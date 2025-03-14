Return-Path: <linux-kernel+bounces-561615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9E8A61410
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1EDC3BEC35
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37EB201027;
	Fri, 14 Mar 2025 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LXqmpxyY"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E031FF7BB
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963777; cv=none; b=mNLS1PJCZQdDaeN340LDmvp7FED0KSG9IMGq5vu9KHzxGzVF6C1Y9Ezx+9A0Svk43V6LdlOqn2fdlkR5wDf11OfOfX/atJP7U1ocBNeWNocTiiDyTfCaQsehp1I0Zu//NQrvzewKQFufm712XMzK79uPBFbjhtLEXR88b5KWseQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963777; c=relaxed/simple;
	bh=RXZQcC4Mu61YAFZ0xJ1ONTrgbN111VHkmmQFG1fCp2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=br0f8y2l13iPGXuKVfWVkWtnEP7NvFi84SYQ5q3gPQr4Dq1PB0Di8U7R6xV+4EwKd0abBrK3PCy3SB9g8db+JHuhBP+4MOM6hcflixTYt2UaghF1od4yI1W1Q9Ithd6EPSiMrrdiNPqgwma1OCMvdrXESOOVgN7Ckubxrw3BiIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LXqmpxyY; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2aeada833so422046766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741963773; x=1742568573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vaYWZrrXVhr81EbJfjzrSCaLmcRbDWo2bd4uQl4U+HE=;
        b=LXqmpxyYDPZ51LTl8jbi9JAaJUINaxm3Rc8kGywz7LPW8WpQVEhxDnchvDGT6HcQbh
         Fjs/WU47hTb93HiGbYh1G0/+LRY4XIBU4EuyIibnYGwanbTlOuItar4yn9yxe83nnMoF
         so5P5WX80YVisr9r7WxrJDWghTn5mM10v6Xlfxb+ww7vQwnfXN5w0rNhHrKloX9WRjgL
         BaOBGwTXJUhfP2S0cD6/UPxpobaQstzK0ed8aLBBo9Nr4IhKEXjwqgjP+zvyEQ8Mtdbx
         wphQk6yPnuqFfs2zB8+uSkiDg6Fi3U3u7kSGvd3wZHhr7XgLfVEqiSeju8B1ZX2FiqSj
         AJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741963773; x=1742568573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaYWZrrXVhr81EbJfjzrSCaLmcRbDWo2bd4uQl4U+HE=;
        b=vfCdWLq44zyHyT+u/aXto1l8iXY3zKx7JRkXPdFe+P73vyPKGIIG2/8ajcquxTFRal
         ji3YxNajW/GppOxDNX34bN067UV8hHF1FBMQrvP6hkttct6jk1wxk/raI8+8TL5zLw1b
         9+8xngYSKHSCH4JB1agCfj7kwn1iQcCgfLKONzXFHb7obA/zNSwgXCY2ahPliCgxZt1L
         plZ29jhNbjz/V+XVXGgAfmzfECEYK+kp8TJ8UoLPQC3n4OgFHG3B+H0VSuwFYRlCwoFs
         zS677cFIGLcXCoWspWoZ66wRVSuMgR/EtIn6myf8jnh1uELgvTJ6uNC64vgPoooAvLq0
         b0+g==
X-Forwarded-Encrypted: i=1; AJvYcCWqKhoMR/tA4c2yYU8uPq3DwGlL5G4RIzGoETHBKbF7L0jNnB2MOyMi0XtD8shR1/zXAjd7EGfHMcELIXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx3WbtMSlr5ROgP9zZIPshGF1nOJkiHmhKqpiA6Ic6vAbmmbyt
	56gynVfptIPM+ssOBvGRYgKov0sLOQatMndXa1Okq4fSUtft8Be0d/IzwmQpvaU=
X-Gm-Gg: ASbGncsJntXy8HRodO2PfYLDqq7ruWxki/Ux3SS14kTbwem/eMDTasPZUkxNi1Q+Hjw
	wBp8HbQ8m5uXCx95JFIeec0zvzzUcROGRNPALRigNYWJMwDpifJypLT8LVWpoPdH9OUxLf0dsy5
	p6noikLFY8elNEAnafU377qXYzBCjgddBMI3nW4aPr1dd1Rdq1k9KKdEBDK0AKHCOQtBbSxeTcc
	yqt7qBLq+f/irCuQyUNHOq5WiKNIQmqUxHD1qIG5u1Z1ClU+qsQDkrbRqpZh/f5k+5gpvHi7AHS
	UupAAZRCcwkBn0NKUEGcBxGJmX5nSnnzThGagXWLUlgVX7WHiFIL2k3qSg==
X-Google-Smtp-Source: AGHT+IFuZcfsNTicbAsGSdC4hoUDrMHk9sk4gAEvb2ZxuSm7mdfAF9+7SV0Qz/gkzMlJVIiYFvty/A==
X-Received: by 2002:a17:906:c147:b0:ac3:d1c:89ce with SMTP id a640c23a62f3a-ac3313056d6mr271960666b.9.1741963772281;
        Fri, 14 Mar 2025 07:49:32 -0700 (PDT)
Received: from localhost (109-81-85-167.rct.o2.cz. [109.81.85.167])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac3149d0bfbsm237138266b.95.2025.03.14.07.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 07:49:32 -0700 (PDT)
Date: Fri, 14 Mar 2025 15:49:30 +0100
From: Michal Hocko <mhocko@suse.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Zhongkun He <hezhongkun.hzk@bytedance.com>, akpm@linux-foundation.org,
	muchun.song@linux.dev, yosry.ahmed@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm: vmscan: skip the file folios in proactive reclaim
 if swappiness is MAX
Message-ID: <Z9RB-gHgtXRc86ro@tiehlicka>
References: <20250314033350.1156370-1-hezhongkun.hzk@bytedance.com>
 <Z9PuXMlHycL6Gco0@tiehlicka>
 <Z9P2nZ6b75FRMhCp@tiehlicka>
 <20250314141833.GA1316033@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314141833.GA1316033@cmpxchg.org>

On Fri 14-03-25 10:18:33, Johannes Weiner wrote:
> On Fri, Mar 14, 2025 at 10:27:57AM +0100, Michal Hocko wrote:
[...]
> > I have just noticed that you have followed up [1] with a concern that
> > using swappiness in the whole min-max range without any heuristics turns
> > out to be harder than just relying on the min and max as extremes.
> > What seems to be still missing (or maybe it is just me not seeing that)
> > is why should we only enforce those extreme ends of the range and still
> > preserve under-defined semantic for all other swappiness values in the
> > pro-active reclaim.
> 
> I'm guess I'm not seeing the "under-defined" part.

What I meant here is that any other value than both ends of swappiness
doesn't have generally predictable behavior unless you know specific
details of the current memory reclaim heuristics in get_scan_count.

> cache_trim_mode is
> there to make sure a streaming file access pattern doesn't cause
> swapping.

Yes, I am aware of the purpose.

> He has a special usecase to override cache_trim_mode when he
> knows a large amount of anon is going cold. There is no way we can
> generally remove it from proactive reclaim.

I believe I do understand the requirement here. The patch offers
counterpart to noswap pro-active reclaim and I do not have objections to
that.

The reason I brought this up is that everything in between 0..200 is
kinda gray area. We've had several queries why swappiness=N doesn't work
as expected and the usual answer was because of heuristics. Most people
just learned to live with that and stopped fine tuning vm_swappiness.
Which is good I guess.

Pro-active reclaim is slightly different in a sense that it gives a much
better control on how much to reclaim and since we have addes swappiness
extension then even the balancing. So why not make that balancing work
for real and always follow the given proportion? To prevent any
unintended regressions this would be the case only with swappiness was
explicitly given to the reclaim request. Does that make any sense?
-- 
Michal Hocko
SUSE Labs

