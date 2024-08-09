Return-Path: <linux-kernel+bounces-281374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A2F94D62C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A696C1F227BB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B374414EC62;
	Fri,  9 Aug 2024 18:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MR1X+5yB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7242940D;
	Fri,  9 Aug 2024 18:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723227339; cv=none; b=RiBhtrEZz57+CKbplK0ZOkGsh7d9RmuKKImRUseTn/X5UL1iqdK30dXRBkT/eRVBxwk9UYGce1RnRJe48eK1SNnowEBubGf1/bHgfwxw9fJ3dG0DNuVxubIf96iueKnxyUOC0vubbZLgVXwlVnRM3hmGEKVtXcf1HfaFWW+LKfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723227339; c=relaxed/simple;
	bh=DkIXjXMgQ2h07LfBy7/0VFM/IS/1mPxjxgWjjpNWjN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFE3xKsusQqHI4aMaBzRUKu4pEWWMvHU3hOpk8ObpC87H3Kibaqrn9xkDGKp451eAHjkf8zNMH89mDtPV5FTG8hMejkfcv6py299K/wtVn4GySfLkIeLe3TPVnwKe5+URtOXWfN3DybdRhBO20QMYfkMklnZ0YbFE/6gKz/au4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MR1X+5yB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF74C32782;
	Fri,  9 Aug 2024 18:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723227338;
	bh=DkIXjXMgQ2h07LfBy7/0VFM/IS/1mPxjxgWjjpNWjN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MR1X+5yBrVzw/2nz4GlMf1V6E4gE7fxoO2XGRiXRrOAuUhV6qeBbyKQaWkc+Kgajg
	 BXN+XH1/lJhEwmFp3XzqEqRyCR1Amd06zB89gm0eRqQkRyNb15RmFvGEWDeZMTsvEV
	 C9koFvqzCCWgRmG/RkCXDLU2K+M3QHgTwA7RVydwVRJgZ0IyNrEMrFYO0Sxc7L12WK
	 r/Vg6shac1/0N7FkLv1g5Y3B+eO613m7bG3h+Ehn8HDDVoROmp3RVGz1dMN5k4X/fH
	 o1wU3EfU58F5VIQ1aDA4dekfX0qj+Vbkz1Nf+oRY17CMt+poRUh8oVEz37gK/VGaVP
	 VqpBVMFQEasQg==
Date: Fri, 9 Aug 2024 12:15:36 -0600
From: Rob Herring <robh@kernel.org>
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Xiao Wang <xiao.w.wang@intel.com>, Andy Chiu <andy.chiu@sifive.com>,
	Eric Biggers <ebiggers@google.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Anup Patel <apatel@ventanamicro.com>,
	Zong Li <zong.li@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Erick Archer <erick.archer@gmx.com>,
	Joel Granados <j.granados@samsung.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH 2/2] dt-bindings: riscv: Add Zicclsm ISA extension
 description.
Message-ID: <20240809181536.GA976083-robh@kernel.org>
References: <20240809162240.1842373-1-jesse@rivosinc.com>
 <20240809162240.1842373-3-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809162240.1842373-3-jesse@rivosinc.com>

On Fri, Aug 09, 2024 at 12:22:40PM -0400, Jesse Taube wrote:
> Add description for Zicclsm ISA extension.
> 
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> V1 -> V2:
>  - New patch
> V2 -> V3:
>  - No changes
> V3 -> V4:
>  - No changes
> V4 -> V5:
>  - No changes
> V5 -> V6:
>  - No changes
> V6 -> V7:
>  - No changes
> V7 -> V8:
>  - Rebase onto 2d1f51d8a4b0 (palmer/for-next)

Please also put the version in the subject. '-vN' is the git-send-email 
option to do it for you.

Rob


