Return-Path: <linux-kernel+bounces-211790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239FB9056E1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 997FDB247CC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5CC1802B9;
	Wed, 12 Jun 2024 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmGs0Ryw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D28F18622;
	Wed, 12 Jun 2024 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718206253; cv=none; b=tEVBkqgr2UsTek/MKJueE7JR7Zlm04uPKEFdUaS32RAQhyVmJUEXcM6Urac23FOFrHaBqX4Ncu2VlcZTGoyzQrC2XT+aLBCmcw+KzZqE5TDSmom/qHtAyf60wMaU3rAuXbuFfnd3MvbPQEb8YXYYNkZy3MHnZgRoVM11QwsLzdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718206253; c=relaxed/simple;
	bh=CUlq4d9WwLarlHKch8/wOlIU1KBwXlSH4EPb02NZQBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcpDp327y/ahPO/tKG8uyXHT7yV9A6oyZx40cQAWodTxAQFmCsGnz9RQqrtcBT7DuuZhId5GiKiNPMPJcC8qUOrgmlnz2C7US1L7ZJNerLUVD4Ny7oh+W8eMizW/UVE8vitJhNxU6D3vP6OHJsI0vhX1APbIHURwmdiY9nK1fVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmGs0Ryw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8DFC116B1;
	Wed, 12 Jun 2024 15:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718206253;
	bh=CUlq4d9WwLarlHKch8/wOlIU1KBwXlSH4EPb02NZQBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MmGs0RywaTnZC4quAJ0PEgt7pvh09ZXcb5OYLjUgkqKwkHAKGxzOiJkOFbIJw3usv
	 VLv/S9jmg8sttMUF622W6bUGdFmWfPqsX9imxlDrYRK+pxF9XsWyVTFo3HXT3g9vdc
	 E5IZxmw84RAL472ncu6iYJd3265aGxgPsryDXs0cQnZHz8wGU1eBDusA1OJxJb7ee6
	 PxWzWiUvMljtOvzUL/WoKq0B5Pl9pgSavJa8HuqoUomuWkYZWQCvnPON27UmxaDvtA
	 4/8tIIuW0F0IO+A6+JW4cI7qGDdo9R8DR3KGXOQun0O2LJLqXKN213tosCSNQKPr5a
	 t0ldmbBnRGkBg==
Date: Wed, 12 Jun 2024 09:30:51 -0600
From: Rob Herring <robh@kernel.org>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Chao Wei <chao.wei@sophgo.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/6] dt-bindings: interrupt-controller: Add SOPHGO
 SG2002 plic
Message-ID: <20240612153051.GA2633500-robh@kernel.org>
References: <20240612-sg2002-v2-0-19a585af6846@bootlin.com>
 <20240612-sg2002-v2-2-19a585af6846@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612-sg2002-v2-2-19a585af6846@bootlin.com>

On Wed, Jun 12, 2024 at 10:02:32AM +0200, Thomas Bonnefille wrote:
> Add compatible string for SOPHGO SG2002 Platform-Level Interruter
> Controller.
> 
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>

Missing Conor's ack. When sending new versions, it is your 
responsibility to add tags.

> ---
>  .../devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml      | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> index 709b2211276b..7e1451f9786a 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> @@ -67,6 +67,7 @@ properties:
>                - allwinner,sun20i-d1-plic
>                - sophgo,cv1800b-plic
>                - sophgo,cv1812h-plic
> +              - sophgo,sg2002-plic
>                - sophgo,sg2042-plic
>                - thead,th1520-plic
>            - const: thead,c900-plic
> 
> -- 
> 2.45.2
> 

