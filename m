Return-Path: <linux-kernel+bounces-516256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A0FA36EC6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 15:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C5221895986
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 14:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B1213A88A;
	Sat, 15 Feb 2025 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5LU7CJF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17077156C79
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 14:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739629339; cv=none; b=Du5a7B/mW91MPPFLLg60Bj0aGFAwKfarTpAnaZilpH51B+Ns5HH1r44GyjSa5LS90d99qLIZ8Y+UzQZbuwTCzIuWQhLIRSAdv8J23lkDTdpAu21t19z3YPTIjULzgOmvIqZTGZ+JScjMBYYt96FihPnweXd06wRz50Wkgx3tUvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739629339; c=relaxed/simple;
	bh=hqW6ymOflAStCUdXwcL9PQWcJaSBxkT9va/7k3d0riM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tjCydTNZZMiQhtTjLgtBS0Koxz49vZesszT5ARJ5GIZ0MNhmMkAO8gLPVMK3z4+l507SeMbg6PLgi00mQXqESnxGdEOT5ztUrZ6cuRrkKZrtU1vGx81RvKO2XP5ekb6UIRIALY7tmK6YegTdLrCM5idtF6pzZU1vXo2aJUlAFzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5LU7CJF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40255C4CEDF;
	Sat, 15 Feb 2025 14:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739629338;
	bh=hqW6ymOflAStCUdXwcL9PQWcJaSBxkT9va/7k3d0riM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=r5LU7CJFB5NReP5POx76or/k0jq3lZN/wUK2VoEhsj4S2hJ4z/4WojyEoTIzNUOgo
	 ip0tcxCVf4hKRiR0voivRcnHCmEaUfS5l53O3nNqEhtLKm/A0VWCLxNSHaM8xZwK2+
	 JeLsHT7tPbQYSAloBIuPHNfUK8d5addpf0BkkrjnmMqZM7QL/UY4wg7CpORQVVrrcx
	 s3FH+/vWiNauiH0myW7s7ImisAmeNpX7LkUXXnJN4VCyP5NlIw4jt8CkPWc1ks6tE1
	 aNluGGv4W8/8iNIkveq0X9hmrhZ+ZTzxYJ4vFHsnE5WrxquoeCrrLNoe15TmEd71y4
	 GIEhu3DXsqS/g==
X-Mailer: emacs 31.0.50 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, will@kernel.org,
	maz@kernel.org, catalin.marinas@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, steven.price@arm.com,
	suzuki.poulose@arm.com,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 1/1] arm64: realm: Use aliased addresses for device DMA
 to shared buffers
In-Reply-To: <20250212171411.951874-2-suzuki.poulose@arm.com>
References: <20250212171411.951874-1-suzuki.poulose@arm.com>
 <20250212171411.951874-2-suzuki.poulose@arm.com>
Date: Sat, 15 Feb 2025 19:52:11 +0530
Message-ID: <yq5apljj9tkc.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Suzuki K Poulose <suzuki.poulose@arm.com> writes:

> When a device performs DMA to a shared buffer using physical addresses,
> (without Stage1 translation), the device must use the "{I}PA address" wit=
h the
> top bit set in Realm. This is to make sure that a trusted device will be =
able
> to write to shared buffers as well as the protected buffers. Thus, a Real=
m must
> always program the full address including the "protection" bit, like AMD =
SME
> encryption bits.
>
> Add the support for this by providing arm64 version of the phys_to_dma().=
 We
> cannot use the __sme_mask as it assumes the "encryption" always "sets a b=
it",
> which is the opposite for CCA. i.e., "set a bit" for "decrypted" address.=
 So,
> move the common code that can be reused by all - i.e., add __phys_to_dma(=
) and
> __dma_to_phys() - and do the arch specific processing.
>
> Please note that the VMM needs to similarly make sure that the SMMU Stage=
2 in
> the Non-secure world is setup accordingly to map IPA at the unprotected a=
lias.
>
> Cc: Will Deacon <will@kernel.org>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/Kconfig                  |  1 +
>  arch/arm64/include/asm/dma-direct.h | 38 +++++++++++++++++++++++++++++
>  include/linux/dma-direct.h          | 35 +++++++++++++++++---------
>  3 files changed, 62 insertions(+), 12 deletions(-)
>  create mode 100644 arch/arm64/include/asm/dma-direct.h
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index fcdd0ed3eca8..7befe04106de 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -41,6 +41,7 @@ config ARM64
>  	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
>  	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>  	select ARCH_HAS_NONLEAF_PMD_YOUNG if ARM64_HAFT
> +	select ARCH_HAS_PHYS_TO_DMA
>  	select ARCH_HAS_PTE_DEVMAP
>  	select ARCH_HAS_PTE_SPECIAL
>  	select ARCH_HAS_HW_PTE_YOUNG
> diff --git a/arch/arm64/include/asm/dma-direct.h b/arch/arm64/include/asm=
/dma-direct.h
> new file mode 100644
> index 000000000000..37c3270542b8
> --- /dev/null
> +++ b/arch/arm64/include/asm/dma-direct.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef __ASM_DMA_DIRECT_H
> +#define __ASM_DMA_DIRECT_H
> +
> +#include <asm/pgtable-prot.h>
> +
> +static inline unsigned long addr_to_shared(unsigned long addr)
> +{
> +	if (is_realm_world())
> +		addr |=3D prot_ns_shared;
> +	return addr;
> +}
> +
> +static inline unsigned long addr_to_private(unsigned long addr)
> +{
> +	if (is_realm_world())
> +		addr &=3D prot_ns_shared - 1;
> +	return addr;
> +}
> +
> +static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t pad=
dr)
> +{
> +	return __phys_to_dma(dev, paddr);
> +}
> +
> +static inline dma_addr_t phys_to_dma_unencrypted(struct device *dev,
> +						 phys_addr_t paddr)
> +{
> +	return addr_to_shared(__phys_to_dma(dev, paddr));
> +}
> +#define phys_to_dma_unencrypted phys_to_dma_unencrypted
> +
> +static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dma=
_addr)
> +{
> +	return addr_to_private(__dma_to_phys(dev, dma_addr));
> +}
> +
> +#endif	/* __ASM_DMA_DIRECT_H */
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index d7e30d4f7503..3e9bf6ca640e 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -72,18 +72,36 @@ static inline dma_addr_t dma_range_map_max(const stru=
ct bus_dma_region *map)
>  	return ret;
>  }
>=20=20
> +static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t p=
addr)
> +{
> +	if (dev->dma_range_map)
> +		return translate_phys_to_dma(dev, paddr);
> +	return paddr;
> +}
> +
> +static inline phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t d=
ma_addr)
> +{
> +	phys_addr_t paddr;
> +
> +	if (dev->dma_range_map)
> +		paddr =3D translate_dma_to_phys(dev, dma_addr);
> +	else
> +		paddr =3D dma_addr;
> +
> +	return paddr;
> +}
> +
>  #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
>  #include <asm/dma-direct.h>
>  #ifndef phys_to_dma_unencrypted
>  #define phys_to_dma_unencrypted		phys_to_dma
>  #endif
>  #else
> +
>  static inline dma_addr_t phys_to_dma_unencrypted(struct device *dev,
>  		phys_addr_t paddr)
>  {
> -	if (dev->dma_range_map)
> -		return translate_phys_to_dma(dev, paddr);
> -	return paddr;
> +	return __phys_to_dma(dev, paddr);
>  }
>=20=20
>  /*
> @@ -94,19 +112,12 @@ static inline dma_addr_t phys_to_dma_unencrypted(str=
uct device *dev,
>   */
>  static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t pad=
dr)
>  {
> -	return __sme_set(phys_to_dma_unencrypted(dev, paddr));
> +	return __sme_set(__phys_to_dma(dev, paddr));
>  }
>=20=20
>  static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dma=
_addr)
>  {
> -	phys_addr_t paddr;
> -
> -	if (dev->dma_range_map)
> -		paddr =3D translate_dma_to_phys(dev, dma_addr);
> -	else
> -		paddr =3D dma_addr;
> -
> -	return __sme_clr(paddr);
> +	return __sme_clr(__dma_to_phys(dev, dma_addr));
>  }
>  #endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
>=20=20
> --=20
> 2.43.0

How about the below?

The function name addr_to_shared is too generic to be included in the
dma-direct.h header file. Since we don=E2=80=99t expect it to be called
directly, we can either inline it or find a more specific name.

Additionally, for dma_to_phys conversion, we first retrieve the private
address/alias before switching to the physical address. While both
approaches yield the correct result, this change more clearly defines the
conversion rules?

modified   arch/arm64/include/asm/dma-direct.h
@@ -4,14 +4,14 @@
=20
 #include <asm/pgtable-prot.h>
=20
-static inline unsigned long addr_to_shared(unsigned long addr)
+static inline unsigned long shared_dma_addr(unsigned long addr)
 {
 	if (is_realm_world())
 		addr |=3D prot_ns_shared;
 	return addr;
 }
=20
-static inline unsigned long addr_to_private(unsigned long addr)
+static inline unsigned long private_dma_addr(unsigned long addr)
 {
 	if (is_realm_world())
 		addr &=3D prot_ns_shared - 1;
@@ -26,13 +26,14 @@ static inline dma_addr_t phys_to_dma(struct device *dev=
, phys_addr_t paddr)
 static inline dma_addr_t phys_to_dma_unencrypted(struct device *dev,
 						 phys_addr_t paddr)
 {
-	return addr_to_shared(__phys_to_dma(dev, paddr));
+	return shared_dma_addr(__phys_to_dma(dev, paddr));
 }
 #define phys_to_dma_unencrypted phys_to_dma_unencrypted
=20
 static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dma_a=
ddr)
 {
-	return addr_to_private(__dma_to_phys(dev, dma_addr));
+	/* if it is a shared dma addr convert to private before looking for phys_=
addr */
+	return __dma_to_phys(dev, private_dma_addr(dma_addr));
 }
=20
 #endif	/* __ASM_DMA_DIRECT_H */

