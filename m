Return-Path: <linux-kernel+bounces-192644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47D18D2018
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF022854B0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7535E17165D;
	Tue, 28 May 2024 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jZ092uL/"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4923616F8E0
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909314; cv=none; b=sN0bsTE2O0fMjIFrTQwLGdNR8R8DyeGdsv5SJFl+lMgdXzlD4vb/k67N/rDGKp90M4D6imbVhEtglSFOumiJ3zmnZUgTupQMI2xbFTQ9rxKy5PqYW415OoI7aruiUFDREZWpNDZtacTVl/YYQc2rr90sZS2oFtaHvZBoyNpGoJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909314; c=relaxed/simple;
	bh=tqLiPN5amlvHA7fWTBc4Bily8zs9asXJlXwi5CKHC2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nOtFNx1n3W6N47SffQZqJb9DJ7SDVDsDWHTj55+IKkgERMtgI240mLkchki8iHmaZxcCWrxyBzqZl5CDsj9czUftSFapD9Tlz6i5RSyWoDr5L41uCQtawiMqNkM50WXR/XAYb8aDUaQIbcV13r49agv8XacH7ZwtP+37K7swnKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jZ092uL/; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-df4d9b16348so980953276.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 08:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716909312; x=1717514112; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DZlgz6rpKv8RDjntoQGkTFXF4S8SzOpaXSeRL3rg2Vs=;
        b=jZ092uL/ktNAxltzv+uss3nbb86PxxbCer1Qztc69hNlVsnvdrNkyd8VXeok1U03xS
         ICGUEwxnVSMgzgM8pYI3bkvravmkWJNd++XhBxtLCRBsV4iW78yd/v+zDM+3PeSMlv4J
         h9s+MO5/x2g2er9R3wY4F5OLX+xlDJCR3OegzgbYorNPuTkCDODBCC7wAQe66QZ4zLOv
         ojQEIPzFXKdk7MVnn01EzGKAyMQq8Nk+3awa8Te63YKQMdJzLmYJQ2Gs9fQ/KM21ciyp
         dTlDCTLsh17NzEbdhy9PWgnfAyNIMrOCtZIrM35uITDc7VRoKfRykRigVY1xVzjRlOAh
         tE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716909312; x=1717514112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DZlgz6rpKv8RDjntoQGkTFXF4S8SzOpaXSeRL3rg2Vs=;
        b=lx7D3CyLncGFkIqnJOwSzVe4qScs3eLfK6eO1Xf1BZ0C0r4/rzwZxfHGskQ+XBqDuG
         qj3qlPL8EO8IM9QVTBr9M06MQ+avvV6g1cRWUAm0JhXOJUn4ebLeO4RsthbUyyWIlXAE
         QM/URhr/nVpAb9tiwU7yMbuoYAAzpVKGXRDJrMPadah/MOpCUahF7SSe2ThobWyV4B36
         Moww8funDy3Oc3IPiCumzjW7iBCUM+zW1N7nlSK33kynNX66ygBktk0uNVlaXNkG7gYh
         a2C0L8Zrfau8ixJOoTzaLpTsuzOjVjU7Okzt0CJXsTG3d+wwvpjMZkvPRcUPpRLWswJc
         E6zg==
X-Forwarded-Encrypted: i=1; AJvYcCVwZuWnh3r9ZHR9RtUXcjUle9l9AO7jGP5DjaNAL6u7XMaxIvDxpX5M0YiC1ulEPLfOQVixAUcRHF6+FolpolEGUg3X7p0taF4T96lN
X-Gm-Message-State: AOJu0Yzg/lGf3Inu66qotfOae/xzjn0Rfu45gTXTLMtiH//uz63F+9/R
	Tj+p1E1tvUaDUTmxtAsFswdrRctRyu7L4qPjsu9o/xKv4OHYP0g2zWE4HAN14Elr5uNC86/bDIi
	L4drKVibZbdY1QXIjkyJh0D7xAFfnaTXcghfW1MDOumEfZTrKYB5dFJU6
X-Google-Smtp-Source: AGHT+IEKk+jMfb4UjQ2vLhkVRwJcPbBfG+1IZvWjYuTzuxuXisQPVm0zrHIomjE5POF4/tmNCe9LlwLUsAzYUZawgkQ=
X-Received: by 2002:a05:6902:507:b0:df4:d692:93b7 with SMTP id
 3f1490d57ef6-df772266789mr12143479276.44.1716909312385; Tue, 28 May 2024
 08:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMSo37UyC-JRfZjd83Vx2+W-K-WqxAN9sHJ88Jev67Fnwci_pg@mail.gmail.com>
 <20240528091831.13674-1-jtornosm@redhat.com>
In-Reply-To: <20240528091831.13674-1-jtornosm@redhat.com>
From: Yongqin Liu <yongqin.liu@linaro.org>
Date: Tue, 28 May 2024 23:15:00 +0800
Message-ID: <CAMSo37U3Pree8XbHNBOzNXhFAiPss+8FQms1bLy06xeMeWfTcg@mail.gmail.com>
Subject: Re: [PATCH] net: usb: ax88179_178a: fix link status when link is set
 to down/up
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, inventor500@vivaldi.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org, 
	Sumit Semwal <sumit.semwal@linaro.org>, John Stultz <jstultz@google.com>, 
	Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 May 2024 at 17:18, Jose Ignacio Tornos Martinez
<jtornosm@redhat.com> wrote:
>
> Hello Yongqin,
>
> > When I tried the down and up operations manually from the command line,
> > it worked.
> > But it only worked after I ran the down and up operations after the boot.
> > It fails to work by default after the boot for both the fresh deployment,
> > and for the later reboot
> Ok, so it works as well for you after the initialization.
>
> > One thing I noticed is that the following message was printed twice
> >     "ax88179_178a 2-3:1.0 eth0: ax88179 - Link status is: 1"
> > after I ran the up operation,
> >
> > Is that expected?
> >
> > For details, please check the log here:
> > https://gist.github.com/liuyq/be8f5305d538067a344001f1d35f677b
> That is another thing that I am analyzing, to clean those spurious.
> But they are appearing in my case too, and I am not modifying anything at
> boot time.
>
> > The scripts are simple, here are the two scripts for Android build:
> >    https://android.googlesource.com/device/linaro/dragonboard/+/refs/heads/main/shared/utils/ethaddr/ethaddr.rc
> >    https://android.googlesource.com/device/linaro/dragonboard/+/refs/heads/main/shared/utils/ethaddr/set_ethaddr.sh
> >
> > Is the one to run the down/change mac/up operations script.
> >
> > Not sure why the up in the script does not work, but works when run manually.
> Ok, I am not working with Android but it doesn't seem spscial, the only
> doubt is when the script is executed, if the driver initialization is
> complete, ...
 is there any message that I could check to make sure if the
initialization is finished?
or like with adding some printk lines for some kernel functions to hack

> Anyway, I will try to reproduce here and analyze it.

Thanks very much! And please feel free to let me know if there is
anything I could help with on the Android build.

-- 
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android

