Return-Path: <linux-kernel+bounces-395872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1109BC435
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96432B21749
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 04:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E28E18E023;
	Tue,  5 Nov 2024 04:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="HqkqACsO"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF56A433D0
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 04:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730779842; cv=none; b=SSLNrOc2LWiq3fax/xM7XF/9OxNRQGMokhe5GuOfC3AyyoGxhbmwdWn6vs9x1XDW+eY+duirRKg0roVFyeIXU6FYxUkhAsq91X4cI352GhCiNjNhZVx6+MAsIKoFvaFReJ76x44d0LQr8rG7Uk1US+XZsVU2z0lOfaTrOt9mjyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730779842; c=relaxed/simple;
	bh=RJ5dyuCaHnEHxb2ODY/yWTobplceIiFW9Y6NsNace2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pT+4dsqU6+5RZtD4R/byVF4vdestTcNuKhbw2N0k6wjVFZtlmT2k82wm5dXA8q2OOciH8ypNED0jo2eAS9M8GmVx5tjLjgLhz1iMpMChXDZpImiC8fj2eCk62HUGc0GGBxZcrJbQq8tuxOEcVLDNILQNvudHVT+S4cfgEehUVP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=HqkqACsO; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2a97c2681so3595525a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 20:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1730779840; x=1731384640; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=scJvZT2Bp+kcd/IoGZ1ogwNGrXZa1xnJU5qHOxNFIJQ=;
        b=HqkqACsOOPux5BujQmtOUUZ6F3TzX4sJrmWMPZC8qsNn/TCXFp9cuFceIj8OddTvSh
         /34Xd15Qbm3jU/OVLDBSzx5DN0M/2xNXlmq7NGe4aWgrJHIOzpKD/UB5SIwjSjozc3JF
         ZJ1fPPVL1Hd4TRlj51T3l8TtOJcf53lrIEmpVVoOXSffoiBX62jUBXpFezsYZm5cZVrK
         wqGUftcvYRXON3CzU3zWgocTqfAQb7yaTxvp13WoVb6C75LGSmhdHDOzVy3FgNQaa9BI
         /ZnlFdSgskMbVQdSa22YCynVgvHQg5FPQg9RPd6W65h4p3zEybam2iUjmoeOApH/8qA2
         MUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730779840; x=1731384640;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=scJvZT2Bp+kcd/IoGZ1ogwNGrXZa1xnJU5qHOxNFIJQ=;
        b=otbdq7YsEBIivkyk+GaCsMR2NpqCxaB7FsS5DjrDukE7pR5ggm46cssoZye/BrZ9g5
         pGvjNszyvApR69gwyNpcLN+wJCaCx+ZRqIS53Om1UJJshWoP0kLiUeHfSWmnnom3O5/B
         Zj8TK0zeUtrWc4tzk7av2gY7W/qPSPevAsXhyXUgeJXWuzN9s2kpb92LTFNrK4tSsofB
         ZVXlvFBGPVmwiIKfFvr256bDcTce8qDQf/DxKbD/WUG1jlo/e54gOVBzgu5JeYc8zdK0
         p6XXJG8lcZuF6ca+9J/yHvN4eIpkTzQPq41O9MG2l9kBGcMdnqSRF7uH89PHOmjTEYb3
         Vp+w==
X-Forwarded-Encrypted: i=1; AJvYcCXd3eS9Dnld1yZXXOJhJrWsOxG0AgfDh1VBIHC7njKyBgzYHlRc0FxJQRg1H4Fp6+p1wckJ74yg+TKVnGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDWeLH2jdW06lCpmL5meUTh/74Ri1JH4cYV0dTZBJGY+TsltXQ
	6u0m3BwbhieeF2xCHyLVLlOzp2wH1W4D4yE+y8KdCOE+VeWPAGSBGKJolz56Yx351oeFphbldOC
	4Z/bFnIxw04iXhwBprGAQPpKEpcxPqzmfscDQPw==
X-Google-Smtp-Source: AGHT+IGScUy3G6UR8gz6wvjEudlraQqlt5Uia9jokVx/2PFVMQBmpLwbRPnyko1K4A9eB9MF28vFRoIVwNeA/WAajBQ=
X-Received: by 2002:a17:90a:6446:b0:2e2:b46f:d92a with SMTP id
 98e67ed59e1d1-2e92ce50e2emr23868289a91.14.1730779839807; Mon, 04 Nov 2024
 20:10:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104092220.2268805-1-naresh.solanki@9elements.com>
 <20241104092220.2268805-2-naresh.solanki@9elements.com> <ac9698862598f0d09d35872d0e091537f822fbcd.camel@codeconstruct.com.au>
In-Reply-To: <ac9698862598f0d09d35872d0e091537f822fbcd.camel@codeconstruct.com.au>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Tue, 5 Nov 2024 09:40:28 +0530
Message-ID: <CABqG17j8RhFpNV+nJ=nLY8+uO_XXjbN55+Ce8op=6Dj5Z=_WOA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] ARM: dts: aspeed: sbp1: IBM sbp1 BMC board
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jdelvare@suse.com, 
	linux@roeck-us.net, sylv@sylv.io, linux-hwmon@vger.kernel.org, 
	Joel Stanley <joel@jms.id.au>, Patrick Rudolph <patrick.rudolph@9elements.com>, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

On Tue, 5 Nov 2024 at 06:03, Andrew Jeffery <andrew@codeconstruct.com.au> wrote:
>
> On Mon, 2024-11-04 at 14:52 +0530, Naresh Solanki wrote:
> > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> >
> > Add a device tree for IBM sbp1 BMC board which is based on AST2600
> > SOC.
> >
> > sbp1 baseboard has:
> > - support for up to four Sapphire Rapids sockets having 16 DIMMS
> > each.
> >   - 240 core/480 threads at maximum
> > - 32x CPU PCIe slots
> > - 2x M.2 PCH PCIe slots
> > - Dual 200Gbit/s NIC
> > - SPI TPM
> >
> > Added the following:
> > - Indication LEDs
> > - I2C mux & GPIO controller, pin assignments,
> > - Thermister,
> > - Voltage regulator
> > - EEPROM/VPD
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> >
> > ---
> > Changes in V6:
> > - Verified all regulators warning resolved.
>
> How did you verify this? Testing the patches locally, I see:
>
>    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-cpu2@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
>    +       from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
>    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccfa-cpu2@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
>    +       from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
>    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-cpu1@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
>    +       from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
>    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccfa-cpu1@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
>    +       from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
>    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-cpu3@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
>    +       from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
>    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccfa-cpu3@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
>    +       from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
>    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator@5f: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
>    +       from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
>    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator@5f: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
>    +       from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
>    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator@5f: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
>    +       from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
>    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator@5f: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
>    +       from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
>    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-cpu0@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
>    +       from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
>    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccfa-cpu0@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
>    +       from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
>
> From a spot check, the warnings seem legitimate. Did you send the right
> patches?
Just checked again. They are resolved. But I guess the dtbinding patch
for the above warning are merged in hwmon-next branch & not in dt/next

Regards,
Naresh
>
> Andrew

