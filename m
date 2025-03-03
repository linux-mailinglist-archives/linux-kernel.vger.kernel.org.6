Return-Path: <linux-kernel+bounces-544474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FECA4E15A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E04657A3628
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D66A25332C;
	Tue,  4 Mar 2025 14:39:58 +0000 (UTC)
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFB8205ABA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099197; cv=pass; b=Mer76BI1X+ewBjgSikhBv8bBc26Teg6cTZjHGFsHLkpjAWy6hTZhIEP9X2M/cKo1llsIWXxrSqmOodalYLwFLQqwwNSKRqt40UB0hyZPW/NrEF1gsCqk7tEtePsshN2wAsk1dist3k+SZn02vkZNyjnOMlBLFCb0FQDdnRyORig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099197; c=relaxed/simple;
	bh=8ngrTt5vPnWxJvv5WXsUHu+32lRdZwzHFsBffAE8eJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SG75yshL7ItqBx7oePPCqbymXn3Zcb+G210WzT7+7PO6Sftj2r1ELvpx2lF3tl95yhtdi8IPe4wZ5J/fWDUqcRMvhHarYL5rxJESe4/wOGkgM77gH4SxowIqvlwbe9nPu4TS/2ff69aN3GnuzwGIjvQDbriKD3TrjTFXMVyjdFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=none smtp.client-ip=217.140.110.172; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 5712F40D4DF7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:39:54 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dYs0pLtzFx9H
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:37:21 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id F1AF842741; Tue,  4 Mar 2025 17:37:13 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541765-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 2324241FDC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:09:34 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw2.itu.edu.tr (Postfix) with SMTP id CB0F52DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:09:33 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375E716B74F
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04B721147F;
	Mon,  3 Mar 2025 13:08:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EC72101A0;
	Mon,  3 Mar 2025 13:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007338; cv=none; b=kcTlTqkWvpGg77USDLAlXLhjFb/9Bvy1Ef433MR4iQW57/a/FPZ9YhQ4Cq2XZjemX2KOHRuu8TW4BwoRPRXZvvm5gTcmXDp5PWMuKniMfny0yDzviTt0jgD3oTdw0otMoA8SVmRPs8up6Kkb4VKLBPU9rxn6dNhmTZT1SEjZxnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007338; c=relaxed/simple;
	bh=8ngrTt5vPnWxJvv5WXsUHu+32lRdZwzHFsBffAE8eJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpYHzPPecFb6r9wiUmAJ/T5N+KcYXH5T+J/V7xUZSenlB6p8uRjj9BkG06YCrtS+ql7oKxBg9VFzXFMHhJzCnefJ/n8+Re1xQrKeRX2R9Ahh39BbrByz8W+vfLacQ7CI10fcn8Gfvn2qbqegyHsvSuolPMakFPvavwjLVZAWsR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D60CE113E;
	Mon,  3 Mar 2025 05:09:07 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EB5C3F673;
	Mon,  3 Mar 2025 05:08:51 -0800 (PST)
Message-ID: <fdfb8200-1b07-4dba-9659-ef25a1391f00@arm.com>
Date: Mon, 3 Mar 2025 13:08:49 +0000
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>, aliceryhl@google.com,
 dakr@kernel.org, daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dYs0pLtzFx9H
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741703888.49867@lnSWPiprvofsGyUmA9uSCw
X-ITU-MailScanner-SpamCheck: not spam

On 24/02/2025 11:49 am, Abdiel Janulgue wrote:
> Add a simple dma coherent allocator rust abstraction. Based on
> Andreas Hindborg's dma abstractions from the rnvme driver, which
> was also based on earlier work by Wedson Almeida Filho.
> 
> Nacked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---
>   rust/bindings/bindings_helper.h |   1 +
>   rust/helpers/dma.c              |  13 +
>   rust/helpers/helpers.c          |   1 +
>   rust/kernel/dma.rs              | 421 ++++++++++++++++++++++++++++++++
>   rust/kernel/lib.rs              |   1 +
>   5 files changed, 437 insertions(+)
>   create mode 100644 rust/helpers/dma.c
>   create mode 100644 rust/kernel/dma.rs
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 55354e4dec14..f69b05025e52 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -11,6 +11,7 @@
>   #include <linux/blk_types.h>
>   #include <linux/blkdev.h>
>   #include <linux/cred.h>
> +#include <linux/dma-mapping.h>
>   #include <linux/errname.h>
>   #include <linux/ethtool.h>
>   #include <linux/file.h>
> diff --git a/rust/helpers/dma.c b/rust/helpers/dma.c
> new file mode 100644
> index 000000000000..30da079d366c
> --- /dev/null
> +++ b/rust/helpers/dma.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/dma-mapping.h>
> +
> +int rust_helper_dma_set_mask_and_coherent(struct device *dev, u64 mask)
> +{
> +	return dma_set_mask_and_coherent(dev, mask);
> +}
> +
> +int rust_helper_dma_set_mask(struct device *dev, u64 mask)
> +{
> +	return dma_set_mask(dev, mask);
> +}
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 0640b7e115be..8f3808c8b7fe 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -13,6 +13,7 @@
>   #include "build_bug.c"
>   #include "cred.c"
>   #include "device.c"
> +#include "dma.c"
>   #include "err.c"
>   #include "fs.c"
>   #include "io.c"
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> new file mode 100644
> index 000000000000..b4dd5d411711
> --- /dev/null
> +++ b/rust/kernel/dma.rs
> @@ -0,0 +1,421 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Direct memory access (DMA).
> +//!
> +//! C header: [`include/linux/dma-mapping.h`](srctree/include/linux/dma-mapping.h)
> +
> +use crate::{
> +    bindings, build_assert,
> +    device::Device,
> +    error::code::*,
> +    error::Result,
> +    transmute::{AsBytes, FromBytes},
> +    types::ARef,
> +};
> +
> +/// Inform the kernel about the device's DMA addressing capabilities. This will set the mask for
> +/// both streaming and coherent APIs together.
> +pub fn dma_set_mask_and_coherent(dev: &Device, mask: u64) -> i32 {
> +    // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
> +    unsafe { bindings::dma_set_mask_and_coherent(dev.as_raw(), mask) }
> +}
> +
> +/// Same as `dma_set_mask_and_coherent`, but set the mask only for streaming mappings.
> +pub fn dma_set_mask(dev: &Device, mask: u64) -> i32 {
> +    // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
> +    unsafe { bindings::dma_set_mask(dev.as_raw(), mask) }
> +}

It's a bit funny that dma_set_coherent_mask() is the only one you really 
need at this point (with only the coherent API), yet it's the one that's 
been left out.

FWIW, also +1 to the consensus that the DMA masks are, both logically 
and functionally, properties of the device, so making these Device 
methods seems sensible.

Thanks,
Robin.


