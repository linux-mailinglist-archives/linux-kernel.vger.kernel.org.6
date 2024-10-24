Return-Path: <linux-kernel+bounces-380407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A55709AEDFE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A9F1C235D7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E51D1FC7E0;
	Thu, 24 Oct 2024 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8IshtLm"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6E71FC7D4;
	Thu, 24 Oct 2024 17:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790807; cv=none; b=fJD6B+JZOquYEY09zo9Z9gE5CO8jaux6FYzsuUA+H2Lc7EIYYftx5rN9rbBeF7TjhtV/6rOdtA922m2N1jdUPSPo8Oa0XmcQnSVAzQdUf2LB1BzTIhKJ8+LdiRy4ufqVab99aZ9vO8O51fA43KZi7xkf0yW6/doHc6PUjNoM/Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790807; c=relaxed/simple;
	bh=y3x/Yzqr5rOkV6VpVIRWrECyDD+bnzjGWzKCC9ld0xY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UaDC3Cb6lP0zxK7COh3b8Xvq2MpKIMGvHYax/GG/A62deFnP8cUri4jPf1pbCVRFLLGnO19ffCEuC1608lHF5elqnULKNaywx58gVzUdwZeq2btqKyYjUhY8PdS/+e55apY39siYEhGPA2t6YOOdQTKWpeBMmAOkuDRBUdjuyBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8IshtLm; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539eb97f26aso1232426e87.2;
        Thu, 24 Oct 2024 10:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729790803; x=1730395603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3x/Yzqr5rOkV6VpVIRWrECyDD+bnzjGWzKCC9ld0xY=;
        b=W8IshtLmydGBLgOBaJPbtlkxVXHO3lg2S9Nv/bm7F1oraRTeSAtPxiHCHIiOe4Ri0R
         T7JR2SCqpfF8NCL3eLzb+0ZrMSbV6ENB+wD3Taaernwrni1qFvc6dWysvUH2nuXWxim8
         TQvobRUFBfG1Sjvr1ldZNRw55kVT6g1wUAvYB1otYPXMMttyMuYmZYpVVbI+NjgTPmva
         nXe91yIJkrtpjvzVU3TuVsgRtbWDCtOsL9FgX85qSO94Cf6gv9GQG7wB6pxKxy00ATN5
         TGegu/fq9b5KY+s/bv1hDzWB8+yfj2YN1T11SJV9dt8Q6md3zvyLQitwBubSYGDLIAm6
         5G0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729790803; x=1730395603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3x/Yzqr5rOkV6VpVIRWrECyDD+bnzjGWzKCC9ld0xY=;
        b=eIgwzTTOlXwjsAZrNe0a+zW23xMo5cT+H+fnWsWipboYBGqa27xKcYo+0YedQDAwn5
         uLdMKS7YLjTE0JAhlclB5JmW+b5RwKzDpkQ/jHj+nCZlF8pQlDqwXlES4Zl5D/Sjsv/X
         KCJTMwza/dTf32sS1MMdaBexrwn6DF6FUjxp8UW5gm4VJkQVlS+bcYGtZpvazhVLdyzh
         wYMfearkEKO7h/aSDWHeY2hY/Cc+6AYzrhFTFXeITCkgfs7V1A8rBLRAQ8auyj5mBE6V
         KFDDG4jT+BAuCTyLfvg8pNKGNhsCBs332Q2yNSu4akAobasOGK01hti4FfUCs88Z6r2j
         E8JA==
X-Forwarded-Encrypted: i=1; AJvYcCXdDLN8kJtZYqqkk661Tobzv8N12f3to1BAdhyairVAxpkPXdrqm+j5cjrO8ViFOt3MOuJ6GM9yKax+ieIS@vger.kernel.org, AJvYcCXxKDzydqxkn2LhtR8hesKgnf/Z3W9Ngl3NcuYGRCAUWAMVID2jBeiKip99T5pC+IiaGd2aj4yAbHa8@vger.kernel.org
X-Gm-Message-State: AOJu0Yya6voClpDhg+cUMJkvRLYiO5oMnuGPVWGsoxvBdqOrESBMVIqn
	AeiBnA9fugVx2vcOOjy/EHLb+NLAV0t2GVZcYm6CgE5vpi5NGvpxib1bAbOmW1RJDNppjt0TXiV
	7s6jDteNxLkC/V5w/iCuj7zIMJBQ=
X-Google-Smtp-Source: AGHT+IGRxl832jNWkv4G/j5EbOky9Qs4+WgynnzzESmftSbrAVOpsaZoETsc+U+/YcqbVeYhcE4fW5L3Lrc4zeMjs1g=
X-Received: by 2002:a05:6512:10d4:b0:539:ebe5:2986 with SMTP id
 2adb3069b0e04-53b1a2fe4f1mr4269898e87.12.1729790803049; Thu, 24 Oct 2024
 10:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023091231.10050-1-bhavin.sharma@siliconsignals.io> <172978739819.623555.106741073057492931.robh@kernel.org>
In-Reply-To: <172978739819.623555.106741073057492931.robh@kernel.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 24 Oct 2024 14:26:31 -0300
Message-ID: <CAOMZO5A7Erks3CHh97AN-XP=Aj2QBUcikAT0ijxkGEchqMfWVA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add support Boundary Device Nitrogen8MP Universal
 SMARC Carrier Board
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>, 
	Hiago De Franco <hiago.franco@toradex.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Michael Walle <mwalle@kernel.org>, Tim Harvey <tharvey@gateworks.com>, 
	Parthiban Nallathambi <parthiban@linumiz.com>, Max Merchel <Max.Merchel@ew.tq-group.com>, 
	Conor Dooley <conor+dt@kernel.org>, shawnguo@kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	Joao Paulo Goncalves <joao.goncalves@toradex.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Gregor Herburger <gregor.herburger@ew.tq-group.com>, imx@lists.linux.dev, 
	Peng Fan <peng.fan@nxp.com>, Mathieu Othacehe <m.othacehe@gmail.com>, linux-kernel@vger.kernel.org, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bhavin,

On Thu, Oct 24, 2024 at 1:33=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:

> New warnings running 'make CHECK_DTBS=3Dy freescale/imx8mp-nitrogen-smarc=
-universal-board.dtb' for 20241023091231.10050-1-bhavin.sharma@siliconsigna=
ls.io:
>
> arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-universal-board.dtb: =
/soc@0/bus@30800000/i2c@30ae0000/gpio@20: failed to match any schema with c=
ompatible: ['microchip,mcp23018']

Please convert Documentation/devicetree/bindings/pinctrl/pinctrl-mcp23s08.t=
xt
to yaml.

Thanks

