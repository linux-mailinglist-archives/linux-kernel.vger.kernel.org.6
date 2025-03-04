Return-Path: <linux-kernel+bounces-545137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FB7A4E97B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E9E1899DC6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F49296D75;
	Tue,  4 Mar 2025 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMzXGm/p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2714A261374;
	Tue,  4 Mar 2025 17:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108270; cv=none; b=ao+tWYX/kbSBn8xMxjCXm4ZH4NUgAPfiupFDkJOVWD/6+9EgPWmcrgzbstnsGyZk/psvBM4br9/TmfIyMX+klzgLESoUrnXSqnhl6F1Ryx4jHEX0eC0fpgL1qPDmD4C7C6oBJMiCyaLUH3UqCAHi1YADW06Uoh+sYerviDueWA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108270; c=relaxed/simple;
	bh=xIG690djDhXKXH4IBWWZJH31VsCI0TyOl9Qn3zjmGxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d8xSflnx2WcFoeDUHqfez18Bwp+ZpcJ28TQ3o7wWP64SHNheKIYQlr2TfV7Xt/QyOUvG9YTMYNgUW8kHAk/1AYIGzt11udSreQmkMtAR3r0s0UgOcPVD4fwhcfjqKNqy2yaocsZSbAONe75nE9KAVM7GKm6UyjMydqm0jnA7j6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMzXGm/p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F773C4CEE9;
	Tue,  4 Mar 2025 17:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741108269;
	bh=xIG690djDhXKXH4IBWWZJH31VsCI0TyOl9Qn3zjmGxQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eMzXGm/peXE2BD5aGPmJeqoiZxx0i2Kf49LPMJ67YalBWSMqKue6Mkmjv6m2wGgTl
	 /3OiUnbAhOI/KyqhqLIldNaIMrugCdqsz4llVVTgyy39QV9IC9tlo0I8KYi2y8wQ+s
	 A5xD8caVUFWUPxoV7O1oqb15otQWnP/VQuQVINVWKrPh+//S/0Ksypjna3qFE6oDnT
	 P65ociX14cMYQSeHJImZUj4TmP+YuI1y7e8pFpB5Z9zB4ZGPsJO2H9oJCEftAHz+SR
	 M4fwKG15JdsB+ser2yHaQd1NUZTHHKY6HgcsO6XrKVaAESIyY8DXdJnojjS1ifPr5j
	 QVabhxHZErRFQ==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so1101490066b.3;
        Tue, 04 Mar 2025 09:11:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVfZSAweFBWekD+Y69crLVMVtCdDb6+QyL0ZjfcivCF6FgOgthbzkxk3k7Xe8sDUYN0pm2PlDxXQBvC@vger.kernel.org, AJvYcCWtmAYxwT4dSEJ7Aw89QKBTgum6ZrXq55FIWYUuVkeJHcQTBx7pdXOAfkXqHHi/PAVDXT2uZQ7rCDQkz4jY@vger.kernel.org
X-Gm-Message-State: AOJu0YxXqG9FzFiHLz4FSNCRuXq8xEpbdiO8pmSQ4ES1T2DCw5F7BIq+
	yLOv3EYq9Kl/kZ9Ig6fIaPWAco1mzDebxAXjP119mG/lpeEB0PVaBnJSCjDhcBkwI9zn9Dg9nzq
	sPp7mBRx2r1yapE06ormQo1QSwg==
X-Google-Smtp-Source: AGHT+IFgs8oMB90zZE6lwaT3tbdeTZ2vDb6K7bI3B7uxQqUz1+cPe+fBOtsCycQF9VShe8mD0kCNZUK3gMn27oWuAu8=
X-Received: by 2002:a17:907:1c92:b0:ac1:ea29:4e74 with SMTP id
 a640c23a62f3a-ac20d92560dmr8023966b.28.1741108267600; Tue, 04 Mar 2025
 09:11:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224193308.407606-1-Frank.Li@nxp.com>
In-Reply-To: <20250224193308.407606-1-Frank.Li@nxp.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 4 Mar 2025 11:10:54 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLJciDgc2cPy7QApH4ia=Rx3MnoVMS3pha3u9PVy_EfPg@mail.gmail.com>
X-Gm-Features: AQ5f1JoVIjx_EnjE9gxDA6sYaQfZU0bi3wrsrEMOzYkBv4xckzwxDP8YmX37Q1Q
Message-ID: <CAL_JsqLJciDgc2cPy7QApH4ia=Rx3MnoVMS3pha3u9PVy_EfPg@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm64: dts: im8mq: move dwc3 usb port under ports
To: Frank Li <Frank.Li@nxp.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 1:33=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:
>
> Move port@0 and port@1 under ports to fix below DTB_CHECK warnings.
>
> arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb: usb@38100000: po=
rt@0:reg:0:0: 0 is less than the minimum of 1
>         from schema $id: http://devicetree.org/schemas/usb/snps,dwc3.yaml=
#
> arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb: usb@38100000: Un=
evaluated properties are not allowed ('#address-cells', '#size-cells', 'dr_=
mode', 'phy-names', 'phys', 'port@0', 'port@1', 'snps,parkmode-disable-ss-q=
uirk' were unexpected)
>         from schema $id: http://devicetree.org/schemas/usb/snps,dwc3.yaml=
#
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../dts/freescale/imx8mq-librem5-devkit.dts   | 25 +++++++++++--------
>  .../boot/dts/freescale/imx8mq-librem5.dtsi    | 25 +++++++++++--------
>  2 files changed, 28 insertions(+), 22 deletions(-)

Acked-by: Rob Herring (Arm) <robh@kernel.org>

