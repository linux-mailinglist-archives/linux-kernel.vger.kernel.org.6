Return-Path: <linux-kernel+bounces-380881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC5F9AF73F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 04:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71E21F22B3D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 02:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C0512D1F1;
	Fri, 25 Oct 2024 02:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgmQvLxh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4084436A;
	Fri, 25 Oct 2024 02:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729822092; cv=none; b=Mgt+e8oeFu7KR0raNctLOru4713d35tAmN3x1NWVQZ88NseUr9GaEeswLuQqGhFDL7BT+fRn/jojogpP0uCAmUrfw2dbRLVgtTuw46sT/PxSJLAVg0DP5s1j1lMNDMhR6vhEgFfmx1zxvHaY+BGptkxC8HVz5++52KhDbIDIVAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729822092; c=relaxed/simple;
	bh=ky8/6r1K5IhNcd01jKs2ZL2ZKqMQimjDmX22tKU+6Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0q4hqXDd7BF5QD8lKpEA/OTAwcTbPvErbKksvS2+4dcL25bL2QdKSQu4CexHHPxUqeHUMSJQYNI/Uz8+Yr+cUkPngSx6jUYRMFDLi95JU9vahBCj7s4iyQBq3UjofHPH9vq0rtl27cwHV1cKlPzTgBXRAOcAEegyA7HINMmIGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgmQvLxh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84F2C4CEC7;
	Fri, 25 Oct 2024 02:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729822092;
	bh=ky8/6r1K5IhNcd01jKs2ZL2ZKqMQimjDmX22tKU+6Rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NgmQvLxhNsX0gcFaIr6Ua2kd3wAIeyXuU+3J96Igd9fQ9n8rtWaZ3+dRzeL34TQ4s
	 VOZgs82YspXIsdmv3OsXw7Wlv/EOTaGr8j02BdQ41rxW4YqH0oja6plnaP4R45e61W
	 afBBJlISqKn7QKSCyqnqeao6Zh2VUtkEFcJXpc6SEWwtpTZ/9Xt6eVK1FXBWxkY7u6
	 utd2L0lEp0+x8SwVuHQnNLItH+Rvtk3GMgeJbInvPjZrVd3SayWmflZAHwWZ1W2kqT
	 VeB4TEtwzaSf20P4NO9IeG7ogTBGX1kadsptcMWpDLEBitFNlK6fS+MKoQZr2eTJjZ
	 rjmMsChf6YApw==
Date: Thu, 24 Oct 2024 19:08:10 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] RISC-V: add vector crypto extension validation
 checks
Message-ID: <20241025020810.GA1781@sol.localdomain>
References: <20241024-fanning-enrage-bcc39f8ed47d@spud>
 <20241024-bunny-unexposed-196d8da36e7a@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024-bunny-unexposed-196d8da36e7a@spud>

Thanks for working on this!

On Thu, Oct 24, 2024 at 01:34:29PM +0100, Conor Dooley wrote:
> @@ -308,12 +354,10 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>  	__RISCV_ISA_EXT_DATA(d, RISCV_ISA_EXT_d),
>  	__RISCV_ISA_EXT_DATA(q, RISCV_ISA_EXT_q),
>  	__RISCV_ISA_EXT_SUPERSET(c, RISCV_ISA_EXT_c, riscv_c_exts),
> -	__RISCV_ISA_EXT_SUPERSET(v, RISCV_ISA_EXT_v, riscv_v_exts),
> +	__RISCV_ISA_EXT_SUPERSET_VALIDATE(v, RISCV_ISA_EXT_v, riscv_v_exts, riscv_ext_vector_float_validate),

This patch adds validation for not just the vector crypto extensions but also v,
zve32f, zve32x, zve64d, zve64f, and zve64x.  I think that should be split into a
separate patch or at least called out explicitly in the commit message.

> +	__RISCV_ISA_EXT_BUNDLE_VALIDATE(zk, riscv_zk_bundled_exts, riscv_ext_vector_crypto_validate),
> +	__RISCV_ISA_EXT_BUNDLE_VALIDATE(zkn, riscv_zkn_bundled_exts, riscv_ext_vector_crypto_validate),
>  	__RISCV_ISA_EXT_DATA(zknd, RISCV_ISA_EXT_ZKND),
>  	__RISCV_ISA_EXT_DATA(zkne, RISCV_ISA_EXT_ZKNE),
>  	__RISCV_ISA_EXT_DATA(zknh, RISCV_ISA_EXT_ZKNH),
>  	__RISCV_ISA_EXT_DATA(zkr, RISCV_ISA_EXT_ZKR),
> -	__RISCV_ISA_EXT_BUNDLE(zks, riscv_zks_bundled_exts),
> +	__RISCV_ISA_EXT_BUNDLE_VALIDATE(zks, riscv_zks_bundled_exts, riscv_ext_vector_crypto_validate),

zk* are the scalar crypto extensions, which don't require vector.

- Eric

