Return-Path: <linux-kernel+bounces-232754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402D091ADFE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6B1285591
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE22D19F46C;
	Thu, 27 Jun 2024 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpKj3Jx0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF2219AA60;
	Thu, 27 Jun 2024 17:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508992; cv=none; b=ANnRq01ZlOFEtwqC0+xABgeHosPtI7sG4sbqgXP4di+Y/F05VZi/cM8usmd+xC3TdjehD68D1pw63p4loL89uOqI+Sej2GtOr6i9jzsup05Oys/bR871VN7s4WjCDG7SPprO32m9qnfuQ/4ckviVYvALO+/jOSN5fgstvHM388k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508992; c=relaxed/simple;
	bh=SzSQXLn35CAVEqK1pP+0y8OHPEJi33g8wq6whDfJ2U0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sM70V/4b4qkezskYDUo0d5OWIRdgDpSn4KXikJKxBxpclajbFVAis618nYiwS80Lty91HKOTyJpjXG2GU5iiSxRno4qPNencXzpwH8hHSGoRR2pch+r1JeR39EwMWCiQg+3UVrW3TPvMxa8aH5fJJnPGqSq6poz5jO0iq+4HJqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpKj3Jx0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B79C4AF0D;
	Thu, 27 Jun 2024 17:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719508991;
	bh=SzSQXLn35CAVEqK1pP+0y8OHPEJi33g8wq6whDfJ2U0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TpKj3Jx0kLyQULOjrQ1G1YFRj3Q5zw0TxQeZFCbz1LUqI0cZH7X2ToIdDC7LRIyMT
	 YhMygxp+gNO5dEQkhOV16YQYCLNCiE8iAhdjPkvdtcQHjtIr0Ze9MfCAu1/oevYfRy
	 rqeMQOmonwGgp8kFx7+jJLLdHIT3aXohVLGmwLLlm0qWBH1qBMRtZuzir/aLRLSQWG
	 9pJjU0EPgubLlXW5/GWWdLU9FKwoDJDK2LGmirgx751gdNTpYpn14S5t9JGOpNOSUv
	 NupAoq+lv2HnN0k4dOmcaHqRF9wFdpvbSQkWGeW9A3qtb9SWSnbbqeBtreXl07XD6W
	 GbDASz5SfQSLQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52ce01403f6so5603548e87.0;
        Thu, 27 Jun 2024 10:23:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqf+QSpLVi9emHQnZ7v+heZ2klb79b9GvkC+7vG+4IBRxO3VihKKGRNqHUHILnBISr0IESqK8yDWfn3Jr8TXN95b9bieGsEbu1FW2K6USC0qu9bGJg2qx7lezyvVpm2Bn7F899skxx9A==
X-Gm-Message-State: AOJu0YzRP8tQqoSo6YKP81Yio6tgE8C8wjzvEPnHkL1+krTaLSVVRNMV
	COoYATMabWefukZpQC/8/vK/7EU9gJrEUzpYOby3flePvTtenbiSVc9l2hwcVeVb47G41N6bGh6
	pkZtvYWGENPCfx/yq+0Vw+Pi0Qw==
X-Google-Smtp-Source: AGHT+IHR1yCKB1utUU8LXu7iJHrZ0fIDsz546zcbjPZVWVy3CCLzPj5Ke4IQeyOr2Ol4d53PW2YtCuULHb69RX5R2yU=
X-Received: by 2002:a05:6512:324a:b0:52c:9e25:978d with SMTP id
 2adb3069b0e04-52ce185e46amr7595359e87.45.1719508990016; Thu, 27 Jun 2024
 10:23:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626202533.2182846-1-Frank.Li@nxp.com> <20240626202533.2182846-8-Frank.Li@nxp.com>
 <CAL_JsqJDOgGWqggWXE-_jv6oQW9nekxU-4Fui+2JFZ6DWUqLtg@mail.gmail.com>
In-Reply-To: <CAL_JsqJDOgGWqggWXE-_jv6oQW9nekxU-4Fui+2JFZ6DWUqLtg@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 27 Jun 2024 11:22:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ1X8rRfVrw0gGeiiQaK+9RekNFSHgXR3zhcNRNw5y9mQ@mail.gmail.com>
Message-ID: <CAL_JsqJ1X8rRfVrw0gGeiiQaK+9RekNFSHgXR3zhcNRNw5y9mQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] arm64: dts: layerscaple: add #dma-cells for qdma
To: Frank Li <Frank.Li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	"moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 11:17=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Wed, Jun 26, 2024 at 2:26=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote=
:
> >
> > Add #dma-cells for qdma to fix below warning.
> >         dma-controller@8380000: '#dma-cells' is a required property
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 1 +
> >  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 +
> >  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 1 +
> >  3 files changed, 3 insertions(+)
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Except for the typo in the subject...

Frank, while I appreciate the great number of reductions in DT
warnings on FSL platforms you and others have been working on, your
work is sloppy with issues you should find yourself.

Rob

