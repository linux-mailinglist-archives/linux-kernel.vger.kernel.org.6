Return-Path: <linux-kernel+bounces-286037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F799515AA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046981C20C05
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 07:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC85313C3EE;
	Wed, 14 Aug 2024 07:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlAmIpnx"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B097529CFB
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723621164; cv=none; b=QK+SVWNlW/EDFfQgONZlCrE49lju2VopAcg4SadlYYenCRTSqz7Vny+ZJu5UDTdlb7GyDX/60qwkdKBFNTUiPrQAjARQy05kM4eNaR3hNeznr7cdViu0RTZg2zIZkdPhw0TH4uLJlU2vonXflFiTnRS7qA3vOhfZGw4YrHQK5To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723621164; c=relaxed/simple;
	bh=kiBeWPY5NKI6M/CzXOOJRZbv3H7igDsanpxAPq+KnE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCPlapKwd85smOif1fGOFGTdlLHZ3sM4NfJAkJyi8sRrgXLtrMwf/t0t4yg0yyMt6/lQtl8ebgNDvqZfeSgGtU1atrISmiiHBEAqDaDSYYm4p0BHKR6OefSCdcVjfggLMH152LnheCROidZaCqgGvMyT2RW2pLgCKqnBJH8rM7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlAmIpnx; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7d26c2297eso722790766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 00:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723621161; x=1724225961; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoktD14rOf17qbeJX0ltx3XBsLh29mx4h86hsRR022M=;
        b=RlAmIpnxPBP/g5yjWD3YDHyPIx86vSFqTWxQILGokRNNr248lGUkWBucZvX+3fYQPP
         Hd+vgC5NkLLBDRVHKP5J7/U1uhOxzoFISINenAdOOpi7JgJ8MeF/GjNH0wRvsc/0WenN
         6RH4ay86WkPPD+XRcw2RmkyPf/g/wwRLXId7EG+Lv6/z4q4Nc/l0cIuRUGZ8PLRyh3vs
         vAZwmqhTcdLWImU6mQawRnFZrDR8d9DOYVzqHW7HWa2j50od34LtgvQMrg73V/J6NJlQ
         SxbBLH01XGzTjBtxWrKqpVsI91agljCwqvjapwe0aGWfC07QNHbVgKRwpOOHpQxYKImd
         C1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723621161; x=1724225961;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aoktD14rOf17qbeJX0ltx3XBsLh29mx4h86hsRR022M=;
        b=SpQVtwannYProZ0hFbQXkYZJobC5O1MWoBXsoiO/CoF/7oKWjZ0YdQn5kZcd60Pkmw
         ri3+g0G/J78WNCI5r8wHOaWW4mc4qmGWmcgQ8D6gg5/k1O6+5DRNQfV+UAgB8tMlFm5p
         5Mh3bC/E+hmqLyfTN2OURKmmKHvtgvWda6sTnbObQy6pwMaSwAemSCkvcKgulKKuh71Q
         kYexT7Cw+pSZvsUZFhKFScXO3HiP7cv7fgYWu90o3H3TYyTpkvSq/WW80oLbrHqOi9OS
         W7pYgJu40ka8mAtFJ3W5ESh2/Hl2N5IgqD0RCOiiNOPCU/zTQyKLyw11fAWXlvCs7Epm
         TdSA==
X-Forwarded-Encrypted: i=1; AJvYcCXsXlCrQBRDa+emuN0pUn3MQ3hYtzsdZmmHRN0qhDsgLyZp0XXUswrybzTh6IQh7i9e6oJNvBKYSlHlm0bXgwc9YDg41hkta9LsptBU
X-Gm-Message-State: AOJu0YzeR0NP3cpSzi/xpLDdDzdlouRx3PDY8vGfOjsG1re/TQ7+kyVW
	qh3ocTTmzcbnZWJW0yRx+VSrUr+j9dxsxUC8jcv06mNOjB+Y2fB8
X-Google-Smtp-Source: AGHT+IFy1nEq8IwxJ2LZWHGLEJJ2YCNduZdAEcpK4voH+o8MlDtkFESe/p1jfzRFg6s5dXKjgEgEhA==
X-Received: by 2002:a17:907:e61c:b0:a7d:e41e:6bbf with SMTP id a640c23a62f3a-a836700638dmr125255166b.50.1723621160470;
        Wed, 14 Aug 2024 00:39:20 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f411aefesm139076666b.139.2024.08.14.00.39.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Aug 2024 00:39:19 -0700 (PDT)
Date: Wed, 14 Aug 2024 07:39:19 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
	maple-tree@lists.infradead.org
Subject: Re: [PATCH] maple_tree: clean up kernel doc
Message-ID: <20240814073919.2tfhf2gexahcbnre@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240814022509.3806-1-richard.weiyang@gmail.com>
 <ZrwfcFr4vN1Hnw39@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrwfcFr4vN1Hnw39@casper.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Aug 14, 2024 at 04:07:28AM +0100, Matthew Wilcox wrote:
>On Wed, Aug 14, 2024 at 02:25:09AM +0000, Wei Yang wrote:
>> Went through the kernel doc in maple_tree.c, there are several points
>> needs to be cleaned.
>> 
>>   * kernel-doc should start with '/**'
>
>No, wrong.  These are static functions, and the documentation for them
>doesn't need to be kernel-doc.

Ok, I will drop these.

For other changes, looks reasonable to you?

-- 
Wei Yang
Help you, Help me

