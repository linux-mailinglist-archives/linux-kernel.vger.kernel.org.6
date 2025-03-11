Return-Path: <linux-kernel+bounces-556459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5150CA5CA02
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920A01899A0F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F7A25F7BC;
	Tue, 11 Mar 2025 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="G6GTh78x"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DED825F78A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708741; cv=none; b=EWTIgCaSIaCLWRXvTPcAZrxY1FEvZwNLpqZ0A62pJTJq2NKwjqBs1kzT9Bxh8K3k58LO6z+DU7ZAakT8ftqkzIdOClWHXBN1ka6Pcg05Ji7wxuf5xWH3CddrcXt2R4JFMJo47bGQqhZjEMSaDiIWX1NOPQjGEuSepXJAnPjWbV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708741; c=relaxed/simple;
	bh=Kf0XD+4NQsGqhvJzqE/CH9n9Xpw5uC/LHjG4Urq2ZtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7BWJTaqg1kWH5oA6gh5sQmil8R8udJ9vcw+DGZTYdtlTFGTitUdg2y6NVuThUf8Fcdk0KL2yzRCe79jYncyG3gdt+9j4ftiLda4MdvSHnW/OVgjFzlHbUai2+Xok0t5/QS3XQNQYCLPr6NlocpNarwTNwi3dfANZcebISyuq64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=G6GTh78x; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7be6fdeee35so1079816785a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 08:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741708738; x=1742313538; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x5MIY1YFuGzMEl9B7g1td8wp5xC/AyaxT2y//gV10VU=;
        b=G6GTh78xzH1JT94By3eikJimS1MZQSieTW2dDl22jIML9n8HBsOYDG4HW7wnANuzey
         mEifVq7faiTt+3t96h2LhA/AUIHziymh33VN+WDSmTGUBgcksE337H2Nf+ljqDLZGb/b
         aE85TKdi1FHyc7uK0vrEysHU/5EHxDN+9ou80HKwebKgryRuD4Q5w9862g0lnlMQlUPs
         sRtHdHrSsmVQLZsVBi5N8g56sk8GbkKOb0p/fXZYuFmVWJGuY4CoQOzfZKe2pLeDWGiN
         FJwQSPHnojtfYr6PktFLJaFWrGNyAf4Knlk7zu9iLU62kakH0SkYPJs21XXbO31h5zPN
         vLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741708738; x=1742313538;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5MIY1YFuGzMEl9B7g1td8wp5xC/AyaxT2y//gV10VU=;
        b=gXRMZ96y69LzDFFNeQvZfvDx44UHNm4BenIQ2pm0t6frHmmdEHVlLJm9XFUlJTpKfe
         D6+9xj8QCoewWSLZ+SOq2zZC3BbALmK/YIOAX14v/JumzMij6nfHLO3UVzUt02Gazi0/
         hNSRI5zA3auHbZZxLnqbdNj2hFIoDRbnnmT0dlSYD61LW8Ft/dbZIPvm7R4YhwBb7qaN
         bzfvwf60shKr7uD/FSmxjt0lh2lskzvM6HsRfk9Dk4L04CM1T69sIi2YMOiK/nm2C3mg
         dXj7y6nPEQfYcVfWXFuILJlozHsuczovbEB7YLAY9ePUCo2SlHFtwUEksvfZXz0+1IBV
         6FjA==
X-Forwarded-Encrypted: i=1; AJvYcCWcUfF3EoYl4XjkcdLVaEXVnTmbtN6vroMBq288pd1OeB91m2c8+SGK2yH3yAXp/acITMHhT+gO+jCRUqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPUykkhOddGheAZ9eTFe9rtnDKMYtRktgw+CX5i0eZU2gRWutU
	I7gAIXAAoIAFLzgi8MF1qjwFE274usI3NBt791qVQPNrsEhhIqsR2cawvYa3pps=
X-Gm-Gg: ASbGncue8rNCEGJSbd2v05XmtIMCA7AjFP9452dNFG74Pv8tYDwPcTxeWcM9HcAtGSZ
	OvPI6er96oM2xlezjnDFpwbWmzmSqVKH18+rZNisOneF4D8UZjH8EOBZiEiPL8Npzf1ITk6/MWG
	NkeNT57v1s4drOhCirniyDoadBgkyWMigbFTXE9ZJvGRWgcM0Cq1ORuP6emRkdmXIGFfWMh9Fa7
	lNvvmq6P7/m6kTiPcviE+b9WFWxlk5z7WtRW2w+L/UK48QLtH95f9JHkvbdfkd/tYp3Ot8dvZzp
	KBkCFUTwNzBqixXXeAHFULqFj/8C7jD+NlXFHY4jANvHk04tqTPo4oarw5bzHJScO++SYq32fqk
	xvVV6EpGfH09uo2FzlgALWl/s3NE=
X-Google-Smtp-Source: AGHT+IGY+q9fXEIzLK5PRqLHxDbH9gjNl112Y7A8nGw2k9Rrrn3f350E8jTleyyIVailHzrgpleY6g==
X-Received: by 2002:a05:6214:29ef:b0:6e8:fa72:be4c with SMTP id 6a1803df08f44-6e90060476bmr245065826d6.1.1741708738413;
        Tue, 11 Mar 2025 08:58:58 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f715b809sm73419286d6.79.2025.03.11.08.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 08:58:58 -0700 (PDT)
Date: Tue, 11 Mar 2025 11:58:56 -0400
From: Gregory Price <gourry@gourry.net>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, Yang Shi <shy828301@gmail.com>,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CXL Boot to Bash - Section 3: Memory (block) Hotplug
Message-ID: <Z9BdwFZ-ZRpMSabG@gourry-fedora-PF4VCD3F>
References: <Z7OWmDXEYhT0BB0X@gourry-fedora-PF4VCD3F>
 <CAHbLzkq6Me6nRaL6b09YxJ_nFkxb+n+M3-q_aJwOs2ZO4q8VCg@mail.gmail.com>
 <Z7TLwtQY3vGUw2bO@gourry-fedora-PF4VCD3F>
 <1b4c6442-a2b0-4290-8b89-c7b82a66d358@redhat.com>
 <Z7TswQbpPV590ADr@gourry-fedora-PF4VCD3F>
 <bda4cf52-d81a-4935-b45a-09e9439e33b6@redhat.com>
 <CAHbLzkqDQcrHLPzk8n0SMgkidH2ByCqdwfYXX=uBPQfOArWf8A@mail.gmail.com>
 <Z7d3vVdJ8UWU5oex@gourry-fedora-PF4VCD3F>
 <4ae838ee-b079-408e-8799-e9530ca50417@redhat.com>
 <0C5749C4-B3EE-4393-A8EA-AA56B399E9E3@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0C5749C4-B3EE-4393-A8EA-AA56B399E9E3@nvidia.com>

On Tue, Mar 11, 2025 at 10:53:41AM -0400, Zi Yan wrote:
> On 20 Feb 2025, at 14:26, David Hildenbrand wrote:
> 
> > Yes, the only way to get some 1 GiB pages is by using larger memory blocks (e.g., 2 GiB on x86-64), which comes with a different set of issues (esp. hotplug granularity).
> 
> An alternative I can think of is to mark a hot-plugged memory block dedicated
> to memmap and use it for new memory block’s memmap provision. In this way,
> a 256MB memory block can be used for 256MB*(256MB/4MB)=16GB hot plugged memory.
> Yes, it will waste memory before 256MB+16GB is online, but that might be
> easier to handle than variable sized memory block, I suppose?
> 
> >

The devil is in the details here.  We'd need a way for the driver to
tell hotplug "use this for memmap for some yet-to-be-mapped region" -
rather than having that allocate naturally.  Either this, or a special
ZONE specifically for memmap allocations.

~Gregory

