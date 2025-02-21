Return-Path: <linux-kernel+bounces-526299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0266CA3FCE1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 344887B074B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3647024BD0A;
	Fri, 21 Feb 2025 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mH40HEwT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB042475C8;
	Fri, 21 Feb 2025 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157551; cv=none; b=Qirdo97/XOG1WznQPa3KXRlSvk4gpJ1Kidpo/nu4NOKkZMM32iKdpBHNV2BBs+f1KMcSI3Aj4j+pOSAQW7Ab5YTSCRcaeHPCkVRNbhKo/Qi59dSX7v4KkNvT0mQEAm9+ZGugLZgsYWqOA0llsnFOxfAWe+pnFwQlxNRcrWZX1Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157551; c=relaxed/simple;
	bh=jSby6rnqKjliEMlrxy3uDKVy/l12aoQ+Uo0UrPP40Lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rtTG5l2/nQ04klyDNugORVlcpz8DBX6puVqsV1oILR5YahdTLEvNHGrE2jIVlOA2OQWvXN3onxwPRiUaT80JJq/bKzTcWzoA2cBjyCtgXaszmjXueis9EEfGFNaKnUFR7v45eFaK0MrpH87oX7teb7v74pdprPZNrV3bGSpuwbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mH40HEwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6174AC4CEE4;
	Fri, 21 Feb 2025 17:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740157551;
	bh=jSby6rnqKjliEMlrxy3uDKVy/l12aoQ+Uo0UrPP40Lk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mH40HEwTHjeM9NIpgOxjL1qMY7pdYQ+4m/N8gfR36FGqUOJSlxHZRUrUFtUNlCHeY
	 y1q5VTos3TTxyvhmGBd/I6KG/Qw5FsqvLb9aqd/jEaaGUNaiN+v53BLGBziZf41XIY
	 Jn8yFesjGGQLx301ywkDLAeE/CxpnEi6sCYyPTeCUsiT6NRB4UosQH9tEXwtSYwuSV
	 qk14DooIeQCm1U10v+SFBxEExW4vM4xEUhgW7mx2RO2nog27cpEi8diecsKpAGtiz7
	 0pivjoWncSbm9UxIzu2skfabPmQY0v4m4HG/JRpgYGxbUoen0NTwk9c3wMmLtyo4bS
	 oxN0PJHae2Ydg==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e05780509dso3368698a12.2;
        Fri, 21 Feb 2025 09:05:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUKJCR3HNY3fb+8UjHNqgvzFJt2aLwAMBhoOipCMsfkbWSwY2ga67ImEPIGfywnMYs1NW4RPzU/vNye@vger.kernel.org
X-Gm-Message-State: AOJu0YwA87MNFidLYWZOBoaQDJGSwsz+ZBjlWKzAl1sJZqblz1m+8Yz4
	u/ujj593dRB1aHXzPZtLTOqlpDfrYjaIuCZ47UAoFCRTpYyGH0T8Igu/EISrNNBUwwsNAOTlES2
	wWG43XT8VTn54mnb4ZMqa8cmQcg==
X-Google-Smtp-Source: AGHT+IEHxK5Q0XUfTPtZAuMZkAwRWMw8XfiydzGFLhctNfa4yiIzH0cTCubtuN3R8RmjkWGuvnxxNAal/4l8vQ8oXyY=
X-Received: by 2002:a05:6402:3513:b0:5de:39fd:b2ff with SMTP id
 4fb4d7f45d1cf-5e0b6feec0amr3935821a12.0.1740157549868; Fri, 21 Feb 2025
 09:05:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704728353.git.michal.simek@amd.com> <18339ffa3d8c3bf284d9c53ce950beea76516408.1704728353.git.michal.simek@amd.com>
In-Reply-To: <18339ffa3d8c3bf284d9c53ce950beea76516408.1704728353.git.michal.simek@amd.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 21 Feb 2025 11:05:37 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+z-q3fJUdXeSz3mO34=nPYJ+Atc0tvpFswZc3j_rZNdg@mail.gmail.com>
X-Gm-Features: AWEUYZn8Prd84CYTiqgtyxCxmUOA14ATU8QMJIUIGFlCopSWEzeQLWfyxKnLtX4
Message-ID: <CAL_Jsq+z-q3fJUdXeSz3mO34=nPYJ+Atc0tvpFswZc3j_rZNdg@mail.gmail.com>
Subject: Re: [PATCH 01/14] arm64: xilinx: Move address/size-cells to proper locations
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com, 
	git@xilinx.com, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 9:39=E2=80=AFAM Michal Simek <michal.simek@amd.com> =
wrote:
>
> Move cells to board dtsi files from generic zynqmp.dtsi. Changes are
> related to qspi, spi, nand, i2c and ethernet
> address cells
>
>  make -j8 W=3D1 dtbs

I don't think this is an improvement. The warnings are guidance, not 100% r=
ule.

>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts  |  6 ++++++
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts  |  2 ++
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts  |  2 ++
>  .../boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    |  4 ++++
>  .../boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    |  8 ++++++++
>  .../boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    |  2 ++
>  .../boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts    |  2 ++
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts  |  2 ++
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts  |  6 ++++++
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts  |  4 ++++
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts  |  4 ++++
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts  |  6 ++++++
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts  |  6 ++++++
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts |  2 ++
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi             | 14 --------------
>  15 files changed, 56 insertions(+), 14 deletions(-)

