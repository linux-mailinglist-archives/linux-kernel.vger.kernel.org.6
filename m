Return-Path: <linux-kernel+bounces-256121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 397AF934960
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3E5D1F2278C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B4B7711F;
	Thu, 18 Jul 2024 07:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdlbP7h4"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22D61B86F1;
	Thu, 18 Jul 2024 07:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721289143; cv=none; b=DTtymNZNHHtUAiPiptIXBTO0N0QT/rtiXNd5PaW9q70ot+vnTZ9I7NmkEpA9Rgre9DZAzabXv3Zoh6ww3oGb7tn1Ep4IZK1RveMsWza5Usql70YoZQbIUbVCG4P3evNHwzJ4V8kwjk0Mth7yOxAx0uVHsHHSIccMQZU9XLTApG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721289143; c=relaxed/simple;
	bh=DiV0p5o4n1qcmrSq9TJa++YItZSe+uOXJNWLTngzDTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lfk12w64nn+iofFdBE/LJbFaE8FoN+Mas29vv4UWS1XH3m2BihkHUtRNFwLoJwV6bYy/f3jd7RD7gyfhNYzLN/XySWTQayyELskhlKynYtgQTy4UWHIAe4hugqPiGVNHFHVOsnWzNN/dCM4aQSNQvSp0ynqPDqaG4DTbFJ4PrKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdlbP7h4; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5c669a0b5d1so244961eaf.3;
        Thu, 18 Jul 2024 00:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721289141; x=1721893941; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HeudbiUTX343qNiEURPI5YAOVpjxRDTmOUF5CU1l3Yg=;
        b=LdlbP7h4ojVhNqvV54h1lhiB01lnQHVM8tLTtEExrNXI6oPZl/tbaLSa08jDrc74cH
         wGi46MwUGmkvN6yx/wa8W0FPyhdng63d+M5W9XhFut89/CuZ2jyFAQ03wSQCPWyUT5tR
         WejUK9NPHbUy0SgP4Ylg6zNJAeOpQulup8xPl4L3iI4TwNg1+w+LoRbrXYtD/ovUGXG+
         x2zRv1knWke3eYv+iiiekOYEJxM9mwRmUdG5DedVd/sXC4/MmJcECM1/coZprVXlJvEA
         nFhIEcRXnSgOJyWwWZ0h+MblyCPraMLDTVWy4G0kVw0e+bRyCNPp5YbL2bYijrAQ0/jB
         6mrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721289141; x=1721893941;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HeudbiUTX343qNiEURPI5YAOVpjxRDTmOUF5CU1l3Yg=;
        b=M8we5Mx63qwNLmWCjZE2oMb4jsWa6TroVZ3hMDqrKEsjgNnSJwLQPInRyi3BJxOHab
         hhBMlCno95aQPXaGooKNV2YAIjOygAHOMYlE+dlDENBk4gWaGxJcz0XqqNSzrFFNhydJ
         6trIvulDyksh+hu8HQmzTjm9Ar2VJWNDL9ec8dBoX2oxwEZFktQJ3SmAehyFGntZYb5L
         ZDN3swI/GKDhtIbp062DCnxqoK3rt9k3+C5VUCHtrguq5HGRQNNa14Vcog1enYNk4Nuh
         tgU2rGSE4Ta0LcmuvWCO5Nn61OE8GncHFnX+e71jY4dWV0C3BhiaPlwEpGLzMBQxmqPW
         SxRg==
X-Forwarded-Encrypted: i=1; AJvYcCWt+0wwHHnaEapZocPQZ+4mYpgSMo0oZIbaEGBKErYcB0oXt76FS33CTgK5vGpXautD5TUi16gs/qDHueYMSywpQmLmO4tlRJyOmM8IZaWev2Y/wrRJYhC0HApJCT9O14XesgXv5XExrQX8OBLhOp+I2r/d8WRPZTgNXlhWHCtTNHtf+Q==
X-Gm-Message-State: AOJu0Yzo7jqSZR3rmY9RU/4HfmGJA9s6Qwk3uxVFw8Ndb9mqUfAllVJ5
	Yehrgb1pfrNgjxoqmzI9xXkXQ6ojMWIPhqKBBaLTAhSKYb1wA7Gv+OuOKqt5qf22365HB6TdwnP
	zmLVqTwG4pgpi5tuEfatDMdtmBxU=
X-Google-Smtp-Source: AGHT+IElzIEx7wtVYpF6wTHWDFLynANwFo8IX6K7B+fK3JlWZ76v8o9Oz+rqmBzF/VNzFntcaCU7zaa6RIubG5h0QfU=
X-Received: by 2002:a05:6820:270f:b0:5cd:2e7:cc6 with SMTP id
 006d021491bc7-5d41cade049mr4827457eaf.8.1721289140922; Thu, 18 Jul 2024
 00:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715110251.261844-1-heiko@sntech.de> <20240715110251.261844-4-heiko@sntech.de>
 <CANAwSgS_ZaEkt5-kKud9OwdN4za+xvW5SoBr34EmOdU2OQJWnw@mail.gmail.com> <8a16eb6a29a39719ba4e4c43bae3b6ec@manjaro.org>
In-Reply-To: <8a16eb6a29a39719ba4e4c43bae3b6ec@manjaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 18 Jul 2024 13:22:03 +0530
Message-ID: <CANAwSgRZR8cM9qDD0Xn5ims4GX+PNMQ1+PEMBDQtZq2GxFd6Rw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: fix the pcie refclock
 oscillator on Rock 5 ITX
To: Dragan Simic <dsimic@manjaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Dragan,

On Thu, 18 Jul 2024 at 13:02, Dragan Simic <dsimic@manjaro.org> wrote:
>
> Hello Anand,
>
> On 2024-07-18 09:26, Anand Moon wrote:
> > On Mon, 15 Jul 2024 at 16:35, Heiko Stuebner <heiko@sntech.de> wrote:
> >>
> >> The Rock 5 ITX uses two PCIe controllers to drive both a M.2 slot and
> >> its
> >> SATA controller with 2 lanes each. The supply for the refclk
> >> oscillator is
> >> the same that supplies the M.2 slot, but the SATA controller port is
> >> supplied by a different rail.
> >>
> >> This leads to the effect that if the PCIe30x4 controller for the M.2
> >> probes first, everything works normally. But if the PCIe30x2
> >> controller
> >> that is connected to the SATA controller probes first, it will hang on
> >> the first DBI read as nothing will have enabled the refclock before.
> >
> > I just checked the rk3588-rock-5-itx.dts in the linux-next.
> > You have not enabled sata0 and sata2, which might be the problem
> > for the SATA controller not getting initialized.
>
> Rock 5 ITX doesn't use RK5588's built-in SATA interfaces, so that's
> fine.
> Please have a look at the board schematic, it uses a separate PCI
> Express
> SATA controller for its four SATA ports.
>
yes, But I am referring to sata node not enabled which enable the PHY_TYPE_SATA.

see rk3588-coolpi-cm5-evb.dts and rk3588-edgeble-neu6a-io.dtsi
rk3588-quartzpro64.dts
which have sata port on board.

&sata0 {
        status = "okay";
};

Thanks
-Anand

