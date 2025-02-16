Return-Path: <linux-kernel+bounces-516683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B4BA375C9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 17:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8892118907EE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 16:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00A719A288;
	Sun, 16 Feb 2025 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="qQx77b4h"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7270019ABAB
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 16:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739723360; cv=none; b=N2DXgqxUZjOb9tZHA5YlHzQBL5AqQml3IvPAU9uyyDK/ZDHvWbPXV9ub9K+3NQa/yw6Oeyk42gwMwo2FqzalS1yAWGseM2EZRq/wLcDAeKE9B+4lRmfIDtQpdZuCTkFRig+vUEXQT/LZkCmbKKhL7vx3mjBRwWwLKvWKWEhWlFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739723360; c=relaxed/simple;
	bh=IF0kN5D7MRNLIaRbAmCzUbINkd04aZChF99GX+SDCxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TN9s52tvn4lVcgOinnC1Tqxj+/Uv1ppPh5WsoaDa2WSsHbJVchQzulth5heup4pgSi8rOykyQP4awsf9Rztkr6PAJNeMyDFgplboe/WkzEeLU93dtH1L7sHmk5easyYdI9FLXDs2z0mkAdOZ1BqKyydIzJ/zHGnQoYlLSkU8AeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=qQx77b4h; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f3ac22948so339476f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 08:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1739723356; x=1740328156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UAhfnYpTnYxNND8RVs/qgruEseNc8XFVZ5I6OH3cRtE=;
        b=qQx77b4h+GdCEzGIgfnsaqylochJYi+MWFwS/pTPKcu48h/Sgfl3LzfBr+bAZ1ggFj
         5clT2y+dFh/P8TwnqOGmhDeaYNvi8mKG7W/PZIWWySbW23zJDFOoe3OGPJy03/mQhkBC
         2dfg+I30oNIDNxIGJrj/oq1Zh+e1vSikd0p1AAYHSnM8tpYMn+kqeTArMkucbcOFe7N4
         +tNEcsAC2T4JdsVpmO3HNKeH7X2j/D3CKniz9h/VclP9hlGxab56MyqwZ+fioBoyHW3d
         WZPdbDD0Om1FLou3Bz3uSfknja2OkEyFkD5wMOLKqEyz+ib9z2nKuS3NWNw22yW1pxsA
         g0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739723356; x=1740328156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAhfnYpTnYxNND8RVs/qgruEseNc8XFVZ5I6OH3cRtE=;
        b=hdR+PkwAnylRZOZ+APuaSaRhQxwk0Pz6np3jCRw/4lFCu2iw3Ve0KMdEo9Cpl6Fsy0
         mZNSwbegoUG7UZht+LxMo9D58qOn9ZrrYMWT6uwT/ZbUkOAKD3iRZsltAf2ZbTRG8Ndq
         VHIt77woxlL3i0eABO3KlRj3ijEWS0rtan0CNm0Deuol760RacGQDJCSTMuAMK2FxWG2
         wv+IP/OIoEbZJtlFe0Lg713dC6cRFJ6gJWKpFd2nGeB9gkRgaXa9JBx1dr1yJjRZRG8y
         4JY09mFq9euZEsW+enN58DvaYgFvIiwwM9AMUFxXxFo3G3bxI5ndkluAlLvM2k+F2d/2
         uoUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoOyDJeCAkTWDx8pkFofmAl1edNu0DGTNiGHCkon4ZSXT7cnvNNEGp/UiMq1PV6hMqttTea5FZQ6qDlcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIHvOskrzAoUTiz/N+XWCnxL1GzFNBHvSVfjDEcF58lEktSeTF
	JfVp9zHzlHfJnJZh22jAI2p3dNfgUCYuEo+/Ugj9YK+IO9g84b8sRol1VI5hPSc=
X-Gm-Gg: ASbGncvOvKNT7jQdwchGMd+XPx/LOfBseLYiLOi8tNlMkIp9o8Zvubm3gPfNI95KcBT
	Dd7xAbA0cMR2VvOyUekiLWa3+/mdYS0Y78RaDi+Proteybi+1YaDqQB5/KKUfLU8tcl68fbhY7i
	pn8W7jKG4gYnIXiL55isy4HpctF1FMlLuho1UX7WHLFtbv/APFrBAZ8tv0IFyczaBvR2CHJXPHC
	1bodBMifUnh9537+kC0Jh2mRGBUrxoguvoAKAKg4dupZW0kXcwpTmxiTwuh4XEt263TrRPyLpvK
	Z9QVIY/LRivxlWR5w8cuai5iXCuydDsbzdeGzqZdzqZ3b8iLn7Mn6+2JrgWoPP1mV5kh
X-Google-Smtp-Source: AGHT+IE29rpJaTzcgH1ReQmiY7jkCnDWpHeHyl5p8P9vWxiW/05CDQrF0FVxPYhuuUA0lIwdRthJ3g==
X-Received: by 2002:a5d:6d84:0:b0:38f:3888:339a with SMTP id ffacd0b85a97d-38f388836c5mr6027222f8f.21.1739723355697;
        Sun, 16 Feb 2025 08:29:15 -0800 (PST)
Received: from airbuntu (host109-154-33-115.range109-154.btcentralplus.com. [109.154.33.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4398148f4fcsm12981595e9.7.2025.02.16.08.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 08:29:15 -0800 (PST)
Date: Sun, 16 Feb 2025 16:29:14 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Saravana Kannan <saravanak@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Stultz <jstultz@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kconfig.hz: Change default HZ to 1000
Message-ID: <20250216162914.n74bcclvry7cwvnh@airbuntu>
References: <20250210001915.123424-1-qyousef@layalina.io>
 <CAGETcx9T-Fz-AN0GgOCmT+xZ3JMehmz-cDf5wEm7a1QuBHWUxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGETcx9T-Fz-AN0GgOCmT+xZ3JMehmz-cDf5wEm7a1QuBHWUxA@mail.gmail.com>

On 02/13/25 00:24, Saravana Kannan wrote:

> >  kernel/Kconfig.hz | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/Kconfig.hz b/kernel/Kconfig.hz
> > index 38ef6d06888e..c742c9298af3 100644
> > --- a/kernel/Kconfig.hz
> > +++ b/kernel/Kconfig.hz
> > @@ -5,7 +5,7 @@
> >
> >  choice
> >         prompt "Timer frequency"
> > -       default HZ_250
> > +       default HZ_1000
> 
> This is going to mess up power for tons of IOT and low power devices.

Why are you singling them out? Why is it worse for them compared to other
battery powered devices?

> I think we should leave the default alone and set the config in the
> device specific defconfig. Even on Android, for some use cases, this

I'll hold the mirror and tell you to keep the default for your systems in your
defconfigs. There has been a lot of discussion about sched latency and this is
a common cause especially when combined with schedutil. There's a lot of
accidental behaviors going and they are being addressed. The default should be
representative of what users of all classes are after. And responsiveness has
been a prime problem for a while.

> causes ~7% CPU power increase. This also causes more CPU wakeups

Have you analyzed the cause? Is this caused by something not mentioned in the
commit message? Accidental behaviors are not a reason not to move on to better
default. And managing system response time (particularly with schedutil) is an
ongoing area of improvement.

UiBench gets 13% and 54% less missed frames at the cost of 6.67% higher power.
There's a big performance impact because of the long TICK.

Phoronix (thankfully!) did a comparison too. The power impact wasn't noticeable
with some big gains in some benchmark. The things that got slightly worse were
regained by enabling PREEMPT_LAZY according to the comments.

	https://www.phoronix.com/news/Linux-250Hz-1000Hz-Kernel-2025

> because jiffy based timers that are set for t + 1ms, t + 2ms, t+ 3ms,
> t + 4ms would all get grouped into a t + 4ms HZ wakeup, but with 1000
> HZ timer, it'd cause 4 separate wakeups.

This has been called out in the commit message. You can't rely on accidental
behavior. If this is something that you think matters a lot you can send
a patch to do this coaleasing and decouple it from TICK. The right thing to do
is audit the drivers that are causing high wake rate. You can't prevent
improvements to the system because there are users that rely on wrong behavior.

> 
> I'd like to Nack this.

Please use the value you like in your defconfig if you have concerns. The new
default is a good indications for what people should be using by default. But
no one is forcing anyone to stick to them. The new default is what really the
majority of people want today, and this patch signals this clearly but doesn't
take away any other option from them.

--
Qais Yousef

