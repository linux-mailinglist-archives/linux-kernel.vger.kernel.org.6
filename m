Return-Path: <linux-kernel+bounces-437070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B549E8EBD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFCCB2839C9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA89216390;
	Mon,  9 Dec 2024 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2C0fyFX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF080215F6F;
	Mon,  9 Dec 2024 09:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733736521; cv=none; b=M08g3920M61Qs7XJUoWSesBlR3VZjdvvJX90asuoeWxm/8N+yfogzIGmsOQVgGEW0IR7C9lEihBlH23sJvqnI5yY5UBatxyQKdH3pVBdgyW3BARAooH2jTRj6vcEIpTSP9sSIpyp5l1VGJaCmyADinLapNbomeiVdjoj+xG5dCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733736521; c=relaxed/simple;
	bh=WDjI4g0DfIOL2DK5+4PccwTUMKhSJ21zH9e8E8kHm0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0lUNHlj8OTl+5AgXnmt5K7HhSK9KXivUqyR2AgRjF0J1/mZh2zUNAkK9UfREYWnjnLF1gdsWRbXVIdz1EfLUbIPWJaobqZMjR+eMu6SuG10yif2ikWlIUDvfqqeH8sc2Oep8O/4D7jNY3ooBIVa/nqeiJ7MBlizVpoUCyExgz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2C0fyFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5347C4CED1;
	Mon,  9 Dec 2024 09:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733736520;
	bh=WDjI4g0DfIOL2DK5+4PccwTUMKhSJ21zH9e8E8kHm0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u2C0fyFXkAZT9B9Mdt9WymIJjq0UTLu0esOTlK33rJm7rq7Na7iVBlK56QvB3rL30
	 Zi2PNNzreCGyR2pkLMGu4+0A1oNUWrl4FPQIaUSExQTQoeclU+j4mA1cbmt9sfBRbV
	 4ffcZGL7ZENUA4x6AgMNEIACyXqM3mDkMG8IheOzsQSwJYiY6CJE4zoxf13/GUN68H
	 VPsG7fwN+KcO96ZXpuEaZwneue5BIA9jmYC2fQ0Jr3Gq+HLG7O8JmNhvR0v/4PFsUv
	 IeozQ597DcQKIv+9QiRsK0BDklH0ABKNmDMgbmnt3UuGl1ZaUL2ic16cmr9TenQn1G
	 g9CTTLCQwaRKg==
Date: Mon, 9 Dec 2024 10:28:36 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, arnd@arndb.de, 
	unicorn_wang@outlook.com, conor+dt@kernel.org, guoren@kernel.org, inochiama@outlook.com, 
	krzk+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com, robh@kernel.org, 
	tglx@linutronix.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, 
	fengchun.li@sophgo.com
Subject: Re: [PATCH v2 1/3] dt-bindings: interrupt-controller: Add Sophgo
 SG2042 MSI
Message-ID: <ww2npib4iyivjqp4l4rdilry2iz2svtidue34v4bebkfmuzpnv@o6ujlbilrtw6>
References: <cover.1733726057.git.unicorn_wang@outlook.com>
 <8f857ba0d281010ddfb53d12b3dd66733ee6a810.1733726057.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f857ba0d281010ddfb53d12b3dd66733ee6a810.1733726057.git.unicorn_wang@outlook.com>

On Mon, Dec 09, 2024 at 03:11:29PM +0800, Chen Wang wrote:
> +  msi-controller: true
> +
> +  msi-ranges:
> +    maxItems: 1
> +
> +  sophgo,msi-doorbell-addr:
> +    description:
> +      u64 value of the MSI doorbell address
> +    $ref: /schemas/types.yaml#/definitions/uint64

reg, as asked last time. 'reg' does not mean you need to ioremap it.



> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - msi-controller
> +  - msi-ranges
> +  - sophgo,msi-doorbell-addr
> +
> +additionalProperties: true

Nope, this cannot be true. There is no single device binding like that,
so do not introduce your own conventions.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    msi: msi-controller@30000000 {

Drop unused label.

Best regards,
Krzysztof


