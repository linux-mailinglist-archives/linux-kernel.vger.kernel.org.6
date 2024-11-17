Return-Path: <linux-kernel+bounces-412146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C96C99D0458
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 15:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80DCE1F21B3B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 14:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2CB1D95BA;
	Sun, 17 Nov 2024 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PItJ7/tJ"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D0A18FDD2;
	Sun, 17 Nov 2024 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731854116; cv=none; b=U7jxcYGnF/tFmCyoFVAbjYqsjBWZHINJSH/cwz+po9+pvXRsCutdW9LFx0+JK0Q2kYXSbfcIE0MHk4feM/Be1d/U7Ks9f+a+w6N13TIQ2ZLWaJ0Z+SLPCbKzUog70uP4wUW6g5i8Hh5kH0/1yXbZOCgcSBmS2PKAmgswJi4UxIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731854116; c=relaxed/simple;
	bh=mj+zr5/Eu2ly1YN5Nz6BSG95JnitRRBoBJEZY9HIT58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=U7HL/12du2zqO7OdITgNCIQb6V6BLKBROxbJoNq9fJo9WwhJhSoj8VGOmseYeYXf/CujdUbrEl8sNmmWfIDdvwlRIUloux7udaHicwyULuQkijOd++Lv9K9U5LC8YClCi5use3aeNjzER/rl4T/wJ+fsRzvFDnL3iAybrYWRCj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PItJ7/tJ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539e59dadebso3942273e87.0;
        Sun, 17 Nov 2024 06:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731854113; x=1732458913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QHmlE3PEHiHFr+j2guDx/AT4TY0CqPzBlvz63DvR7YU=;
        b=PItJ7/tJuQ2pFKG+d2hvB61kt6emamtiG6AuE81FFomaqlEj714l3uPHYTIqm60QIk
         0OaBWLuR0tE7TLkZ1fPp6nNQmt18k9zGFm0VPn7o5WL4w3rAmU71TocCMtQm/phxSxja
         k6nE0KS41d2ZPC2C4bcHdnz2z7EXROAKgsvfgX26j5VIrH/JgpSFrmtMHdnBiV3tR1VC
         cQ9rll+87662DStu7/HNjMscePVDlLtSnpJi+uFLRtdSfJxpo7toEuB5rSNAGJhoGpcr
         bSViv0rdpBLO059hNyilhyRFOcFfRmgwrl4PvlcQYB0+6VdDNoaDMwxJ/xwBVLRjIdeR
         TDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731854113; x=1732458913;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHmlE3PEHiHFr+j2guDx/AT4TY0CqPzBlvz63DvR7YU=;
        b=fwwpYwBWIfYfQ6VnjTcEZXPs8Jc7rO8GFPoLdQjkQ0Uo4bRjT2m9XZlxk8T1FxG8+5
         8ChhQOF/JbkMOiS4cyyqxIFbBz43sRT7brar9p1Cb+Ap49oOy3XuaV8xcyIzlj4J7c5Z
         HwzM+hlgbZFFQpYOvBUaEfROZ4OaAtQpTyQotFxhTs8AdoojUyx67EXHgoN1dEaCb4Ht
         QSwKhry3p5pGsrqJdqfyEivmqPNzdeyGdGkCW2eQbXRVW5RfI7Far2loIJ5A4OFLVFH+
         +Q3GTSG1cR5x2MGHS907nJNSSCdvSkNTdxUUuWyziM0Cwz8t21l3O1M6RE83Upz/h1nr
         ODuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkP7xbMA8Ctiupu0b6ElcfhRfmGSgndUoS6Fy5Xl4MVLC4XKXCzUUYKwgSIAz8ahUNha3+NUaJVb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxizTKndhg+hcm/huk2lPvlBprKWsnaxeSX4NjyHpVpdyQ7PvMz
	oiEcGsdjc0pE9NGuTkacq9TQHXkCqYN8uEQtMd/nmvf172QiTVQX9pqXgA==
X-Google-Smtp-Source: AGHT+IEzNfDOyFoKWVzT5/K6kj/RrHoLls0/uRWmNJAHeMcvOOUQI8EyJqVXO+GE8amhPsPiKvyRww==
X-Received: by 2002:ac2:4e12:0:b0:53a:1e5:572a with SMTP id 2adb3069b0e04-53dab29db04mr4064263e87.16.1731854112713;
        Sun, 17 Nov 2024 06:35:12 -0800 (PST)
Received: from foxbook (bff246.neoplus.adsl.tpnet.pl. [83.28.43.246])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da6548ad9sm1308369e87.263.2024.11.17.06.35.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 17 Nov 2024 06:35:12 -0800 (PST)
Date: Sun, 17 Nov 2024 15:35:07 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: linuxusb.ml@sundtek.de
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: Highly critical bug in XHCI Controller
Message-ID: <20241117153507.4daaa9f0@foxbook>
In-Reply-To: <dd4239c7b0538e1cd2f2a85307c73299117d5f0e.camel@sundtek.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

> Basically the issue comes from hub_port_connect.
> 
> drivers/usb/core/hub.c
> 
> hub_port_init returns -71 -EPROTO and jumps to loop
> https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.c#L5450
> 
> I'd question if usb_ep0_reinit is really required in loop which is
> running following functions:
>     usb_disable_endpoint(udev, 0 + USB_DIR_IN, true);
>     usb_disable_endpoint(udev, 0 + USB_DIR_OUT, true);
>     usb_enable_endpoint(udev, &udev->ep0, true);
> 
> this is something only experience over the past decades can tell?
> 
> usb_enable_endpoint will trigger xhci_endpoint_reset which doesn't do
> much, but crashes the entire system with the upstream kernel when it
> triggers xhci_check_bw_table).
> 
> I removed usb_ep0_reinit here and devices are still workable under
> various conditions (again I shorted and pulled D+/D- to ground for
> testing).

xHCI isn't the only host controller supported by Linux, and
usb_ep0_reinit() predates it. Maybe it's pointless today, maybe
it isn't, but it's not the root cause of your problem anyway.

> The NULL PTR check in xhci_check_bw_table would be a second line
> of defense but as indicated in the first mail it shouldn't even get
> there.

It's an xHCI bug that BW calculation is attempted on an uninitialized
device and crashes. Looks like a NULL check somewhere is exactly what
is needed, or maybe avoid it completely on EP0 (it's probably no-op).

Other similar bug recently:
https://lore.kernel.org/linux-usb/D3CKQQAETH47.1MUO22RTCH2O3@matfyz.cz/T/#u

Yours too should be unique to those Intel Panther Point chipsets.

> As a second issue I found in usb_reset_and_verify device 
> https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.c#L6131
> 
>         ret = hub_port_init(parent_hub, udev, port1, i, &descriptor);
>         if (ret >= 0 || ret == -ENOTCONN || ret == -ENODEV) {
>             break;
>         }
> 
> hub_port_init can also return -71 / -EPROTO, the cases should be very
> rare when usb_reset_and_verify_device is triggered and that happens.

Right, and the intent seems to be to simply retry in this case.

Regards,
Michal

