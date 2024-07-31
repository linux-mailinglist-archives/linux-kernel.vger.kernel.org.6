Return-Path: <linux-kernel+bounces-268394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8E3942422
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 03:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8AF1F24106
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 01:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA989947A;
	Wed, 31 Jul 2024 01:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOHLLDXE"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8297D8BE0
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 01:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722388930; cv=none; b=LhfI35TjG/5+eUSi2VIvvXy2d7X7ldimHJ1xUU813YE34+hGAERqMB4xPHmOaSgs6ooDw/v4y4kZjMkL6N59MWqow711gQjJCjQYJSBEiyXFG0ahFRmDZXoFJ1s3R8562lb9poiCY8VH6efeMpdwoeal9q10ijUXEIMW/4N93BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722388930; c=relaxed/simple;
	bh=KeBwvg5FtBmleUSkmxHNZ6Gor9oT9LDghK2J/tnx/T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fr7uVzLeu1cJeKEQxDcDNcs7vcYlO+iBaFgzSv+0vj0SSj7APFRRgfHbWBdNGY6hMihwfVyXm26pMh11l63Sa6T/IlcfgpgII2hNTKJjXzJz9QZHPbXdHhbvsHVWGabK5QgQgGt63LxAVKCbzP4kl+l2+10xuph8UkweNY3eF8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOHLLDXE; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-260e6dfc701so3276226fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 18:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722388927; x=1722993727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KZFiQUTKYGbexDFZeNL880njNvHuBbSAu6jjCWHkzJs=;
        b=iOHLLDXEuNl+vuATJS3mNz5jyHvAwrWWQd6f+suzK84EBPH8ePVNAHwOuq9F1+X5xy
         Xz0xHAcFAQQrKfHonoweASnELDTB+546+Gyqz6hBk3/7fFiVCvPB5SKm23PYbqek9jJl
         hvWQBanlSN6Jm9ByzaRjEzl627SCwqE3LjWid1S3o2PZ88E1zKAypJ1Ql6WmGOJS9zgK
         sUi0MU1q7kD/yhbgbQ9g8O14Ht6SbHhyNfJfHsz6qniwJteea4Ys+vgdISEaZ7Qpx4e3
         3RyUxK4dFCn2uBy58lX+GEPn/nwOKmaVWFXaWIOuYsDj3u6T34s4MYJchwsWZ/F5zbHG
         chMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722388927; x=1722993727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZFiQUTKYGbexDFZeNL880njNvHuBbSAu6jjCWHkzJs=;
        b=biG6Jpjfg7pirCouwvR/ibPwe7o9Lij8mIQxNlaRo3sEsex3Atmi2mIfw8Xm6UT1Mq
         RHgNVE7pcMj9h5USWZ/TdZDzqc1qhmILlcSFWoaLMV5vrcKqj3PCMwj6gUtgo1nDulQu
         QSZtgJPJSu9w4CBPjxBdJlAbHmhv+xHiPT7G7V6WXqRPaIWuI9X03Vgoplo7T+ItSn+K
         /5E/CLBYSJeSxIFEmwm5DW2fHQqpGKzR4aV2QtA25lf6n7YE4C0fedmUVFURZKo47I4X
         tcIfGn6DYEjJAqdV/m0DCmmgEdE0l/kYndrNLXOWif/mTFm5mQFWFQcazclfqSFB/X7d
         YMhA==
X-Forwarded-Encrypted: i=1; AJvYcCXfnggyOkrRkUxtOonAxXdJZRnqzCTEEXgKzsdeOdrFFjIDFPAmVFp/IjJkvqDmHtgsIykHBrL5YM0IY/4hHjHF1HxfOMTAE4fiLSwS
X-Gm-Message-State: AOJu0Yx3WRyA58jB+IFiVQrqp4LnmBHsynL8F3qONZ49rBx4+SykopIF
	ifl1wnYbryw9eCvqWTywgWZIUSpl8IUYpvpD3WJ8dDMYHq374K7x
X-Google-Smtp-Source: AGHT+IEYlS0I/3kawtjnY7pCWnnpr611kGVyIICJpmTjHAJOsI/Uou3x0FR0ik/+k7Fpn2g9RageYQ==
X-Received: by 2002:a05:6871:7a0:b0:260:f1a8:a64b with SMTP id 586e51a60fabf-267d4dd3d08mr15447335fac.24.1722388927438;
        Tue, 30 Jul 2024 18:22:07 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8215b3sm8971206b3a.121.2024.07.30.18.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 18:22:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 30 Jul 2024 15:22:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Qais Yousef <qyousef@layalina.io>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.11
Message-ID: <ZqmRveI2HDK0BkDi@slm.duckdns.org>
References: <ZpWjbCQPtuUcvo8r@slm.duckdns.org>
 <20240725011907.3f5ropfai3xoy3l3@airbuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725011907.3f5ropfai3xoy3l3@airbuntu>

Hello,

On Thu, Jul 25, 2024 at 02:19:07AM +0100, Qais Yousef wrote:
> We really shouldn't change how schedutil works. The governor is supposed to
> behave in a certain way, and we need to ensure consistency. I think you should
> look on how you make your scheduler compatible with it. Adding hooks to say
> apply this perf value that I want is a recipe for randomness.

You made the same point in another thread, so let's discuss it there but
it's not changing the relationship between schedutil and sched class.
schedutil collects utility signals from sched classes and then translates
that to cpufreq operations. For SCX scheds, the only way to get such util
signals is asking the BPF scheduler. Nobody else knows. It's loading a
completely new scheduler after all.

> Generally I do have big concerns about sched_ext being loaded causing spurious
> bug report as it changes the behavior of the scheduler and the kernel is not
> trusted when sched_ext scheduler is loaded. Like out-of-tree modules, it should
> cause the kernel to be tainted. Something I asked for few years back when
> Gushchin sent the first proposal
>
> How can we trust bug and regression report when out-of-tree code was loaded
> that intrusively changes the way the kernel behaves? This must be marked as
> a kernel TAINT otherwise we're doomed trying to fix out of tree code.

You raised in the other thread too but I don't think taint fits the bill
here. Taints are useful when the impact is persistent so that we can know
that a later failure may have been caused by an earlier thing which might
not be around anymore. A SCX scheduler is not supposed to leave any
persistent impact on the system. If it's loaded, we can see it's loaded in
oops dumps and other places. If it's not, it shouldn't really be factor.

> And there's another general problem of regression reports due to failure to
> load code due to changes to how the scheduler evolves. We need to continue to
> be able to change our code freely without worrying about breaking out-of-tree
> code. What is the regression rule? We don't want to be limited to be able to
> make in-kernel changes because out-of-tree code will fail now; either to load
> or to run as intended. How is the current code designed to handle failsafe when
> the external scheduler is no longer compatible with existing kernel and *they*
> need to rewrite their code, pretty much the way it goes for out-of-tree modules
> now?

It's the same as other BPF hooks. We don't want to break willy-nilly but we
can definitely break backward compatibility if necessary. This has been
discussed to death and I don't think we can add much by litigating the case
again.

Thanks.

-- 
tejun

