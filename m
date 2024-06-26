Return-Path: <linux-kernel+bounces-230853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EB79182B7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B112F28929E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929F91836D0;
	Wed, 26 Jun 2024 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyTMMWyD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1543181BBF;
	Wed, 26 Jun 2024 13:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409107; cv=none; b=vD02RM05SBnN0Pw/QEhQFkO8SnOEq1IYtYvwM9eYKRvLQ/+A4U5rqZmH9Ko162JYoq5rT6STE5CVlMLcNddlfoQ8gnTu45s3dMC+nED79uHzxvzmX7kRE2frmT555tdB9YeI761+RLcSynSuH2Fvua9f8SBhpEnaXwBaFVq2Pj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409107; c=relaxed/simple;
	bh=mT+XvH8UWizqo1I9e1vZwDFAL61b089M6KvtdSkZlYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MOmbCtRKJnsbCBYLlpBHa4IkBioqBXjtCueOIPxQyWlabtWIZjvt7inCmd42/FicZtFuqIwSKRnIeSrIJyUON0TGyhYf4f89yXiSIDrzNbS8SolDMFnDtYHAVT/RKqWkvHO9+j6sb4L9FyThjDKjmvMNN2xpd6ww4yqYjH5CFZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyTMMWyD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A385C2BD10;
	Wed, 26 Jun 2024 13:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719409107;
	bh=mT+XvH8UWizqo1I9e1vZwDFAL61b089M6KvtdSkZlYQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hyTMMWyDWl7i3UzJAOekCXQecATrQ1qOiavEK07g6HN1P2ioQLTk8Jj6i3HJtwdfr
	 8A4/oYETPSakxgQYGyOOHr0piXrCzEgS04Agpe6dUdPZ9iO/7tLqAIoPKwwxLYWSaH
	 8EuuLOWd7MP8juGF0zwDzv+zmEoz6Bbk6E3XAuUSToYXTQLUl14ZjTdY+SDtfbjmPG
	 3jjP2/sQy85YPVcdmk4LmgJVcO4KMvclq01JW9YzMlX6xsTYWOY+1YyBDrpmOT+P6a
	 aGI+hzRjpI2ja785xRIX87IgECypRAoDPgLSuVaQTcDlhLqRdD36jQFyyKzuKvIngb
	 h0kmuKG4RPBcg==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ec1ac1aed2so81090791fa.3;
        Wed, 26 Jun 2024 06:38:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWsx9UUB3LVNvj/A7Rkft0hFBCesX+V8yFT84eFyjcBwIMvdWb+3CzVSb5EWMDsZpR0ds8rkojK9iAD16LHVhqG0IEo9q7jcEEQ5N4mAJur7yB0w/VqjgdwpAnsMXtBHEs69g0EdsJBeA==
X-Gm-Message-State: AOJu0Yxcn6IcW+kqSW/lWJE6l32XjnahgUg8QfS7dCLtCBmOqgKLltP1
	oCCgR/Bn0aN9huzXcMYvBd6aSsYeHfM0Y++Za6hRPim67SSRCkzMqTANKquDo1VGa/3cvNj6R0+
	2d5K16v5WwrcEbJLzRKho4kgCTQ==
X-Google-Smtp-Source: AGHT+IEsX6qXOl6xVez/XAXXEykZ0DqynORMkATY30RgaD9BFgyHKzmt9KjRBpXz2UGDbbrSY43FLqrTUosq3vLwFQI=
X-Received: by 2002:a05:6512:ba1:b0:52b:de5b:1b30 with SMTP id
 2adb3069b0e04-52ce185fa38mr8425545e87.44.1719409105710; Wed, 26 Jun 2024
 06:38:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626130332.929534-1-yangchen.openbmc@gmail.com>
In-Reply-To: <20240626130332.929534-1-yangchen.openbmc@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 26 Jun 2024 07:38:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL-b==HMLJGd_e-43yZHjBFYrrLV5J2a=E2LSEck=ii6w@mail.gmail.com>
Message-ID: <CAL_JsqL-b==HMLJGd_e-43yZHjBFYrrLV5J2a=E2LSEck=ii6w@mail.gmail.com>
Subject: Re: [PATCH v1 00/17] Revise Facebook Minerva BMC DTS
To: Yang Chen <yangchen.openbmc@gmail.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, patrick@stwcx.xyz, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Jerry.Lin@quantatw.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 7:05=E2=80=AFAM Yang Chen <yangchen.openbmc@gmail.c=
om> wrote:
>
> Revise the Linux device tree entry related to Facebook platform Minerva
> specific devices connected to the Aspeed AST2600 BMC.
>
> Changelog:
> - v1:

You already sent v1. This is v2.

>   - Modify the properties of spi to match the schema.
>
> Yang Chen (17):
>   ARM: dts: aspeed: minerva: change the address of tmp75
>   ARM: dts: aspeed: minerva: change aliases for uart
>   ARM: dts: aspeed: minerva: add eeprom on i2c bus
>   ARM: dts: aspeed: minerva: change RTC reference
>   ARM: dts: aspeed: minerva: enable mdio3
>   ARM: dts: aspeed: minerva: remove unused bus and device
>   ARM: dts: aspeed: minerva: Define the LEDs node name
>   ARM: dts: aspeed: minerva: Add adc sensors for fan board
>   ARM: dts: aspeed: minerva: add linename of two pins
>   ARM: dts: aspeed: minerva: enable ehci0 for USB
>   ARM: dts: aspeed: minerva: add tmp75 sensor
>   ARM: dts: aspeed: minerva: add power monitor xdp710
>   ARM: dts: aspeed: minerva: revise sgpio line name
>   ARM: dts: aspeed: minerva: Switch the i2c bus number
>   ARM: dts: aspeed: minerva: remove unused power device
>   ARM: dts: aspeed: minerva: add ltc4287 device
>   ARM: dts: aspeed: minerva: Add spi-gpio
>
>  .../aspeed/aspeed-bmc-facebook-minerva.dts    | 516 +++++++++++++-----
>  1 file changed, 373 insertions(+), 143 deletions(-)
>
> --
> 2.34.1
>
>

