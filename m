Return-Path: <linux-kernel+bounces-364426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2B799D47F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67E30B23158
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809E51AC450;
	Mon, 14 Oct 2024 16:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KxIp1gy7"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F43228FC
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728922820; cv=none; b=Ipij74BHRiuHhu0my+mjHfnbKxyPBSJxI9q5auoCoIWGvqMN8BraSyEFdtujJzpJfpEKvwx6aQEakuc4Oh8OV6NtPymrOobIhOsUi2tB1vnWMN4JulKSoD2Gl469YapHgESya/yv7VrRI62ptdc9eJ/Gue3SD1MuyNXMKmTGSCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728922820; c=relaxed/simple;
	bh=gKvXh/I3PdZE3GR9krNhCfohoX6IveIuFUNNLJAJzdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCI6WH0BIS4oIoCAgC2B4vRBuC5I2yKAaaZzpzgj5ssdn6RgBIxcuLbxZqDwmt/iEl7o4HlzY0f7drHUSAQMQm67LXVeivOBEBCFme/q1EElnzvRadi0Rc0WEQ0avpQ0Aa5PU+maS09crm22DhEY0DxL9w77v6Jj2/jd/2BcW8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KxIp1gy7; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539e681ba70so24268e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728922817; x=1729527617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKvXh/I3PdZE3GR9krNhCfohoX6IveIuFUNNLJAJzdE=;
        b=KxIp1gy70J57FSxV/5Ju7yRNFsi9uGMqBpizNikBdqrRhST3EfZwjR9tmN/MWBQbtP
         NqfMo2w366X+cTV8HDKetekPPd7VQlLHWBQh+nEHWhJ6fkYrUyLlSPyj5DgR+ql0cX/j
         hRq2rkmbLw8uFpLO8FaqDyirLFqO11o3sNnTwAadOJhY4JRJvibJwErA1xL+XJyzpeU/
         lbKxh6mowvlToN5u1WFhR1IP0nhLWrNxQlwab0vLXeDaUFW6Ne4/RicJgbQ8dTg59kDB
         4x7fgxZRvC2hoQ9Nxou/o7DMYoGXpREUZSla48S8Tq8NcU3kB4z3ZI5KebvGYc3nbNva
         Ziww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728922817; x=1729527617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKvXh/I3PdZE3GR9krNhCfohoX6IveIuFUNNLJAJzdE=;
        b=qGmF14a4oL2V1F7ZEfbrK93wBmz5q0jqxo1sbSnvir7bF8yIjrLKAKotCG1/6HCytz
         gzq2yKpQ2WJFNmmE17+zHOjIaeFS2xtJduMl+cBXzQF/P5ihp41hYle4wZoiVpfzhFzV
         G1NDTTg4YePs05CbL1aEItjuIgnDvHNc4WneOdW6hHxdeZgYQ/uQ5ICg3RP4a3Ut4FF8
         ARooGHo2vzGAVkhuiYnA1H9h3TJkk9vhLf+OWF7QUZd0KVrilSThamV81bhJmb5dJTsO
         NyvN7GFhfy/x2wY2ZYFwXOt5jA4MSXEqIdXhAEBMEvR17Qcwswuk56AzDseRcrDpuG03
         H9Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWe0mivK24y+JM8Rmp9ty0ALUV21Z0uFpvgvi2kaDLNG32Ib4snGy+Ha1bxNOCG6P17xX/0t2EutIm+6KA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPqTEoWZOI6PC3+Wb5YsA3vfREGxFULtLB5j7CdvWoaJPoYZll
	h4Q3DHIczIKggLsQ4+e3gSG8Zq+y/nNzXuRTj3q4e3KLXSlF7in72U8rgF3QLeltA7PkQYyPW0M
	07MNxbh0WgoDkQxn3Oh+F+/zHVxQakUtJjkws
X-Google-Smtp-Source: AGHT+IHzzT5Xql/B/YM8yku8j1FfwE05VlFhBxx9961bqHFWjZxX7Ej6fRWAUlINENXZDwDsDBwPpWmPq5lKA+HjF7E=
X-Received: by 2002:a05:6512:2821:b0:535:3d14:1313 with SMTP id
 2adb3069b0e04-539e5e762e7mr553189e87.0.1728922817154; Mon, 14 Oct 2024
 09:20:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014085816.1401364-1-guanyulin@google.com>
 <20241014085816.1401364-6-guanyulin@google.com> <afc9fa53-b7f2-45d0-bd30-8681b71beef5@linux.intel.com>
In-Reply-To: <afc9fa53-b7f2-45d0-bd30-8681b71beef5@linux.intel.com>
From: Guan-Yu Lin <guanyulin@google.com>
Date: Tue, 15 Oct 2024 00:19:00 +0800
Message-ID: <CAOuDEK0QomQfXqzmP6g8QRdbE5dXob2cuhM3viErUoDHURaB-Q@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] usb: host: enable sideband transfer during system sleep
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, 
	mathias.nyman@intel.com, stern@rowland.harvard.edu, yajun.deng@linux.dev, 
	sumit.garg@linaro.org, kekrby@gmail.com, oneukum@suse.com, 
	dianders@chromium.org, perex@perex.cz, tiwai@suse.com, niko.mauno@vaisala.com, 
	andreyknvl@gmail.com, christophe.jaillet@wanadoo.fr, tj@kernel.org, 
	stanley_chang@realtek.com, quic_jjohnson@quicinc.com, ricardo@marliere.net, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org, badhri@google.com, albertccwang@google.com, 
	quic_wcheng@quicinc.com, pumahsu@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 9:06=E2=80=AFPM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> On 14.10.2024 11.50, Guan-Yu Lin wrote:
> > Sharing a USB controller with another entity via xhci-sideband driver
> > creates power management complexities. To prevent the USB controller
> > from being inadvertently deactivated while in use by the other entity, =
a
> > usage-count based mechanism is implemented. This allows the system to
> > manage power effectively, ensuring the controller remains available
> > whenever needed.
>
> I don't think all this is needed to prevent USB controller from being
> deactivated while sideband is in use. The modified audio class driver
> that uses sideband is still bound to a usb interface device, and all
> normal pm reference counting should work.
>
> To me it looks like this code is tricking pm framework into believing
> the usb device and host controller have successfully suspended during
> system suspend when they in reality are fully up and running.
>
> I'm not sure I fully understand the case this series is solving.
>
> Thanks
> Mathias
>

Your understanding is correct; this series aims to keep necessary
devices running while the system is suspended. The goal is to keep USB
transfer available via sideband when the main system is asleep. Since
we're offloading some USB transfers to another audio DSP, the Linux
driver is not involved in queueing transfer TRBs, handling event TRBs,
etc., in some specific "offloaded" USB endpoints. The sideband might
be bound to a USB interface device to prevent the device from going
into runtime suspend, but it seems this doesn't prevent devices from
suspending when the system goes into system-wide suspend. So the main
purpose of this series is to prevent some related devices being
suspended during system suspend.

Regards,
Guan-Yu

