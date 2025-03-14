Return-Path: <linux-kernel+bounces-561619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 522D6A61422
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FEA23B8A40
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547E9201013;
	Fri, 14 Mar 2025 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="bc2L149r"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C251990BA
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963985; cv=none; b=kg1rFGpzhbLHljdouMeZUBfDmXHAoU781km+Edm6g9BzkDDeTrctz8RJjaJK50/uYds62mPELzUTBuFrs1KXMLfhp6tXiMpvGkAXLWiuTfCLQKtDCE6ABYzM5SdV41Bzx6jP1c4oyuEhtatWP5JU6oktgNP/LSdNUqLJp+uYmLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963985; c=relaxed/simple;
	bh=HT0SaOsbuGXnEM1wt3IqYLOiNA/iKhH3DwxJkgZVpM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQ0CPmDNWejTQTmnBa1BlwczU4HeIuBp/7kT7Svzg9vSIcveY9ROQ3O3Kx8xiekwZL7v6fz1y8SOaQN9Z8cgz+KQv/RdEJ6sjZEAigbhZuykHMzguMV/va7l8rdRnHRNNfEGOgfkJ/IW5cZHQZFAL5JigMdbWQ0J3wU1FL3yYz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=bc2L149r; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e41e17645dso20227956d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741963982; x=1742568782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YEd4Fj1LDDrUKJisnGXeYM3J99GuHY/GkN0INjiYBec=;
        b=bc2L149rPE0UZEZxhzihQLz4KWP58sAEyrQvpz4ZWcOO+ZUfAePKcIfV+Ipro+B5Mf
         JkSkFq1yg38EbExPpVxK2diyjddSAX4zLrbrUdwlGvwghZoxNgJUOrz63Piz0roRFFsr
         IIPWYovFh/CHRt3xZA+9STnh9aruRmXdmBLDFiY6cSpRxXp+s8aU2DnBIbPJBsR/i1jF
         cYooHuU0HitfFa6FWmuD7tUWrZ63YatClghzadOITlQkKNsrdTqrdHbHwXA0jL1A3mwF
         s0zhWckfiUq7qP1TaQTIRbW1uObtXNsMwNP0XEHz96+X88kqUK2WWGJw7r0Q5BCNFh3K
         6VyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741963982; x=1742568782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEd4Fj1LDDrUKJisnGXeYM3J99GuHY/GkN0INjiYBec=;
        b=lt7iVYqxw0PUkSW4RW+eyWWMcXW2155gqLW+j6ZuUZ9ohB+B3IDgPoqFNyUjCT8xd1
         KVUS4opIFT+3ih60RD80UjZeqjn7QPA+hciieMwZFmPaSUdGwUJm5SW4yqCulzrBbeNX
         HBjGzztiEoRYfuQMeTtr+wRjKMHvQkx3l93ivfTvVE/h70hEV8UX5G9TXN/Ks+JL6kB1
         fRaIT+8J7XgYho+gMcVmjVomTg+IBEB7+yBIaPWIUMI1cQyGEO+nBrkFSGmr0i1cO82v
         wWeagowXxBdBiZ6g4tAXjUviKBrgcoJlmNnuOA6nCdLUp7dZPk9bYWy3domjDKNdEehP
         gqqg==
X-Forwarded-Encrypted: i=1; AJvYcCVN01L26YB0vlW+c4+PEgf07KJJno0xKOIhlB2LTrYjWDz0zcEkJXKQnkZkdICo+7vvWP2g1nXwpGIn4KY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnpKSTAqSfS+iqzpyMPY2jW5lFhM8AR5Sx+EWaOFHUf1kVCz2b
	LWn+byWs1UpBkKdKzbZu5AtSaJyas/uuO1eRoqHM3vzrtgaIcHsibyCcJSqjDJo=
X-Gm-Gg: ASbGncteP9SMYuPu8PGGP9wFisicSpYgXmeobsug/UinxApDsPxhcX40RPkvoATxszp
	YndAu4Sr/YN8xNcPlM2guxN8mGmif6SEV8Wzjho4SlY7WBhIsvQz++LArNOFG1FMmWsPHVE09GA
	UQCiQhb28JyNjqCn4xe8LDCQCo9F4LIQb1NY1WcDG0M7p8KfNhuJEBprfH3fy5UEdSRvuteqiUq
	jfrH7LiodQBVqM0XEhygwZpOFcsaMqSAg8+SL8flBX7WwyfAm3QyQGo+FK0fYVC0olHNzjpP4CK
	gRxZWkYXQ7MvA05907FfcAQ6Xb7RaPhHvDrCpn/uMV0CsjdgGOlfu9gdW+z0F9JV4RXNeyo00L3
	lco+sMBUxAEF8FxhiVmrI6YKiDmA=
X-Google-Smtp-Source: AGHT+IH3ggnZtqOByikt617LMehSj1WVoa+dpOZWBqv233tVXHDltWTiKQjWRf/+WeQaFRy9QEo0/w==
X-Received: by 2002:ad4:5967:0:b0:6e6:6535:17dd with SMTP id 6a1803df08f44-6eaea996035mr45083906d6.7.1741963982667;
        Fri, 14 Mar 2025 07:53:02 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade209313sm24790786d6.19.2025.03.14.07.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 07:53:02 -0700 (PDT)
Date: Fri, 14 Mar 2025 10:53:00 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, hyeonggon.yoo@sk.com,
	honggyu.kim@sk.com, kernel-team@meta.com
Subject: Re: [LSF/MM/BPF TOPIC] Weighted interleave auto-tuning
Message-ID: <Z9RCzE7MqNEF9gPO@gourry-fedora-PF4VCD3F>
References: <20250313155705.1943522-1-joshua.hahnjy@gmail.com>
 <87frjfx6u4.fsf@DESKTOP-5N7EMDA>
 <20250314141541.00003fad@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314141541.00003fad@huawei.com>

On Fri, Mar 14, 2025 at 02:15:41PM +0000, Jonathan Cameron wrote:
> > > - Does this need to be in the kernel? A userspace daemon that monitors kernel
> > >   metrics has the ability to make the changes (via the nodeN interfaces).
> 
> If this was done in kernel, what metrics would make sense to drive this?
> Similar to hot page tracking we may run into contention with PMUs or similar and
> their other use cases. 
> 

Rather than directly affect weighted interleave, I think this stemmed
from the idea of a "smart policy" that adjusted allocations based on
bandwidth pressure and VMA permissions (code should be local, stack
should be local, heap could be interleaved - etc).

An example would be if DRAM bandwidth become pressured but CXL wasn't,
then maybe tossing some extra allocations directly to CXL would actually
decrease average latencies.

I'm not sure how we'd actually implement this in userland, and I think
this is ultimately MPOL_PONIES, but it's an interesting exploration.

Some of this context was lost as we worked on weighted interleave
auto-tuning.

~Gregory

