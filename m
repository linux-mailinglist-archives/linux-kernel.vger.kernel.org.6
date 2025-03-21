Return-Path: <linux-kernel+bounces-572016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CF4A6C583
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E4A480705
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66537232373;
	Fri, 21 Mar 2025 21:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArM5ztOW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D7A28E7;
	Fri, 21 Mar 2025 21:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742594091; cv=none; b=Asog89bTfYWj9XXsjdqryvR7ecJJwviNGNRBhGjrtl7woUfFuAuQgeb2bHF0nwas09dogCsnmvpUKf+p87DmvV0XtawUPShFEGFnw+dGAc6Zl9U+P69MF+jqByref47QMJaRxnsZ29nlebWfT9Om8uPf2Gih1QZwcNAPawa8Exo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742594091; c=relaxed/simple;
	bh=ST89ptphulKjZHhKBjFlDo2o2KSI8FUPiuo7L/N9YQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBzs0nyJoHFHMGh4ZVEhcV4mXzz6k/jRElo/NYn0t4L6r65QMuBz4eX/jz863bLsdLq3bBYKAqNH+uSmlxUI+xVwm0qe8pJzs6a+UXAZHNe9/rlwO4LiPK/fSsbQw3JJgFAtMAj7XC9VQVML1DwKw3crY1pO1Xm0fEsfK+//7z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArM5ztOW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B452C4CEE3;
	Fri, 21 Mar 2025 21:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742594091;
	bh=ST89ptphulKjZHhKBjFlDo2o2KSI8FUPiuo7L/N9YQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ArM5ztOW6vejfrtGII/jYjuX0RAXxiNjqlXEOAbD5FZJYGyOrb5eqfL/YkahlU9P7
	 r3PSG4nekLZAXEbpzTdwNiGcAuaZeutEuFhZlZ6WLX8xEgul9010c26IEJ39C4HwJM
	 JWDWvGAo/jGJKphL0O+Em8gdlBsaQGQd2RF6WSgvLgQq6xhUXjagaZ8tFU6Fb9ymzx
	 rIsizMoVNTghu3FmS+1iawjyNbTMtK6VqlFPUHjaZH04d9EUpoVfQbcePmZ+O/N8E5
	 9ZOkK+f0tkZausZH3skYBoR+7wzTnS7XQNhgveoHNL1Uat3nOr7hRXNfCY2StsJQJo
	 YEEwTMsfxcbmA==
Date: Fri, 21 Mar 2025 16:54:50 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
Cc: Conor Dooley <conor@kernel.org>,
	Yu Chien Peter Lin <peterlin@andestech.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Kanak Shilledar <kanakshilledar@gmail.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-riscv@lists.infradead.org, Aradhya Bhatia <a-bhatia1@ti.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Min Lin <linmin@eswincomputing.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Albert Ou <aou@eecs.berkeley.edu>, rafal@milecki.pl,
	Heiko Stuebner <heiko@sntech.de>, Anup Patel <anup@brainfault.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Darshan Prajapati <darshan.prajapati@einfochips.com>
Subject: Re: [PATCH v2 04/10] dt-bindings: riscv: Add SiFive HiFive Premier
 P550 board
Message-ID: <174259408740.4183990.13657262859263435933.robh@kernel.org>
References: <20250320105449.2094192-1-pinkesh.vaghela@einfochips.com>
 <20250320105449.2094192-5-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320105449.2094192-5-pinkesh.vaghela@einfochips.com>


On Thu, 20 Mar 2025 16:24:43 +0530, Pinkesh Vaghela wrote:
> From: Pritesh Patel <pritesh.patel@einfochips.com>
> 
> Add DT binding documentation for the ESWIN EIC7700 SoC and
> HiFive Premier P550 Board
> 
> Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@kernel.org>
> ---
>  .../devicetree/bindings/riscv/eswin.yaml      | 29 +++++++++++++++++++
>  MAINTAINERS                                   |  7 +++++
>  2 files changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/eswin.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


