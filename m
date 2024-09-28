Return-Path: <linux-kernel+bounces-342363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0526988E00
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 08:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE73A1C20E07
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 06:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B4019D88B;
	Sat, 28 Sep 2024 06:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RykQEm7x"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C54381C7;
	Sat, 28 Sep 2024 06:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727504825; cv=none; b=jjFclTe66JzsJe5Dtvz984jx1KsKY88aQMhsnkihIY/9Rk9X5DosX+VzP5Owzpfgq4b6utTm4wbECsOwK2Q2Cx4oaXqkPvWnJEn1ua/3H4WujtH0L8EG6aFNILPm9FNYDqoldkGYXV77KAjXbNC3qvFvy31rFsmDSOWN02zVaQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727504825; c=relaxed/simple;
	bh=tPc7mhKokWGM2Kapg8cvJg9yAiZSEoe7437Ns8CXF68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IcoBUrl7yFRxH0XJOnXieNAnvjrjY+NW8kvDHCa/StZIFUuB8GDt4DIp4Eo2hvSrgyKSZmbgKJibfNxKAOnyFkpNUwN4bAX66YWqYAa2Vyyh+kWZRetzhyVjtNf/UKaVVXTrj9HeF98cLsCcFZMmEgN7HvQTZP23NTlfgAAYs88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RykQEm7x; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7d50a42ce97so1298429a12.0;
        Fri, 27 Sep 2024 23:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727504823; x=1728109623; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oT+Xix7EUZojgVt8PEv25I8lZLGn+Rt8jomt28eBKxo=;
        b=RykQEm7x0upQPnBmCl8AM5AxXcwh2ONBxCWm9H26UPN8BREaawX1CzjOWcqL7RWjEd
         6EAXX+tBavID9NpVtNPLRTzxqEqaCMVW05zggd32lvcda9q4vEzY5cw/Jp4Vhda9AFBV
         EvYawRkoY0nDBih34XlFslcK0DEOChG99ZsR7JJstyP+97a/A4FLIiVQWgR04E8XHo2m
         ojigYaBgNd8+3gvu2GJ3692QBfEfP1UMV7lrTOCrBIZ/YjiN4XPK7r/SEJ4kfSNkmN7n
         SG1m7GFY0NWWfoDu3FBHQzoXhIy7RXlkczzjSCXZrQB9+++dDnBT+MsvPo95L4lNo449
         aGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727504823; x=1728109623;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oT+Xix7EUZojgVt8PEv25I8lZLGn+Rt8jomt28eBKxo=;
        b=HJLjZXAqVe87lZP1iViEWvlyzuGHDWKXj84ysT3F96vPTsue9D07AbUHXj7ku3MGHa
         Rd50IuclJgURjo8nwC6WS9Usa5XLx2UEXSbIELraE70qsleuFAWnxWQH1pRW6OiVSpnl
         KDHpQNAEhV8FG9OOqt+3M1BIciP82db3l3al/9+fHF4ObkxukY+8KujjGV2qVQthvX1T
         Xk+zydoUTji8I92C5vJ+L3FCNASjjk510yLOMNRpLG37mPSO0HWHKTv2G/6YiaxCe1K5
         1wwfMyAFcCnsDIhW2iyXMkkTQpF88QP2s9cypfQU4SZGV5Ife5qQQlGNnSnuDQmgQpKr
         gAaw==
X-Forwarded-Encrypted: i=1; AJvYcCX/PxQ+gxvVu9R2nNFtid3w056RTaf4dzB13KoZx8krL6POVxPz1tD4MTeqJrMT9ztGa5A8QJ/YpzvW@vger.kernel.org, AJvYcCXXtUeh9S09cGfTqqHbp39yWQEeIoOICj4oJOVDRq8Psl6krL7rVfK8htCHw+T+B7yYtewm/IPnOOW1Okme@vger.kernel.org
X-Gm-Message-State: AOJu0YzWEVVhRgylgZGGy6JoC0Ho+lzuZ4amDsUPfCivYDs/ILhg4aIz
	Iud/KlVhQL6KuToRm29J3McmGBpuCPIAftSh1JZtwAR9aadTn656rU0bGCh8kGDpmlrvefebRdu
	wyPQbVP6SYM6WqRDcwEdB1ciML+0=
X-Google-Smtp-Source: AGHT+IEDhLZNbykD45F4jKtK/hB6A1oiqmApfybjKEaAP/yF36hspj+oOy9wPm7opnb1bFde8Oak9aefQMvq09yocyw=
X-Received: by 2002:a05:6a20:d489:b0:1cf:2b8c:b5e0 with SMTP id
 adf61e73a8af0-1d4fa78baffmr9539894637.37.1727504823180; Fri, 27 Sep 2024
 23:27:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZvQ27pvrnEYA8BB9@Emma> <3e296eed-5dbc-4098-ac3c-3c3125a352d8@gmx.net>
 <6723d91c-ac15-436e-878c-2d6fc1aac5e2@broadcom.com>
In-Reply-To: <6723d91c-ac15-436e-878c-2d6fc1aac5e2@broadcom.com>
From: Karan Sanghavi <karansanghvi98@gmail.com>
Date: Sat, 28 Sep 2024 11:56:51 +0530
Message-ID: <CAEDjzLKZSb8JJXjpbC5tFa4hc7+wdz+v6esimmZuOuYt8tWJ6Q@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: broadcom: Add missing required fields
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Stefan Wahren <wahrenst@gmx.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, 
	Anup <anupnewsmail@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Sept 2024 at 02:08, Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> On 9/25/24 09:39, Stefan Wahren wrote:
> > Hi Karan,
> >
> > Am 25.09.24 um 18:14 schrieb Karan Sanghavi:
> >> Added below mentioned required fields
> >>    1. interrupt-controller
> >>    2. #interrupt-cells
> >> in the bcm2711.dtsi file for the
> >> interrupt-controller@40000000 block as defined in the
> >> bindings/interrupt-controller/brcm,bcm2836-l1-intc.yaml.
> >> This issue was noticed while compiling the dtb file
> >> for broadcom/bcm2711-rpi-4-b.dts file.
> >> After including the above fields in the dtsi file
> >> interrupt-conntroller error was resolved.
> > looks like you made the same mistake like me [1]. This change breaks
> > boot of Raspberry Pi 4 [2].
> >
> > There are a lot of DT schema warnings to fix, but this doesn't belong to
> > the trivial ones.
>
> Including the #interrupt-cells would not have a functional impact
> however, and we ought to be able to do that.
>
> The 'interrupt-controller' property presence means that the controller
> will be picked up by of_irq_init() and that is was causes problems for
> people testing this. Stefan, do you know if the VPU firmware
> removes/inserts that property to tell Linux which interrupt controller
> (bcm2836-l1-intc or ARM GIC) to use or does it make use of the "status"
> property which would be the canonical way about doing that?
>
> Thanks!
> --
> Florian

Hello Florian,

So should I send a patch with only #interrupt-cells to solve one problem?

Thank you.

