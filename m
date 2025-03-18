Return-Path: <linux-kernel+bounces-566761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F9DA67C2E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49EE54233F2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D58212D69;
	Tue, 18 Mar 2025 18:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hATDPwIL"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2791DE4F8;
	Tue, 18 Mar 2025 18:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742323371; cv=none; b=XZ4v+VkXeyvm0ec+ifrVu1pyT6zk0gKEhoajXU0IPmmWmxwniN03k2bmSy+IzSwDWXGNamSqISNFaKNYWi+1aH/Gb42lA1bYg478P8TmBgvNFsDg+0rarXoCZeSSoENA2Puzzc7CtmL8cfcDX4Ob2pVymXHcFFW/ZxcIU/gZeB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742323371; c=relaxed/simple;
	bh=KT6mPg+Y1JtXH5YBFh2c2ejWXnZICH3D6X2YnV2mw2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WN6KEasiPmY0oWEXMJZl+kQr5uefUn8Y7C5lWJPPZaRj1nV2EVDydwRJ37Hgcoacfu+qgEAsEgOEegYUn3XExUSATm4dOUvEzv13DhRQ7pobajTeE7U7Askxa6cqoZH0sUFqA+iohE6pM3fgJKk4i2a1td7mbzYb2LF+st47lg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hATDPwIL; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-543d8badc30so6905773e87.0;
        Tue, 18 Mar 2025 11:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742323363; x=1742928163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hOZgoX2iJQX4V6wby9ytPUcVpVhdLhvcjz550it+cic=;
        b=hATDPwILp1cnsqV6gnuiYOGcDEC74tv6wZWOCzrIzdwTjdV4shEgIGPrvzdtl2jEd8
         yA8YZQuypPa9pLvlZLLX2PvB/o+lzHYEkocYj+/P07u444VHfPRF5cOOIocb/KG2mtWQ
         eD12JQEaEJ3RGlVjYIzRwzijGgPm9VZGpNbsnAtlRBek0pdlriBvZoN445ZmQyan+VWY
         kJEuW47ifKtNV3MtyAGtM+Lyca0GnfLeZwwlnvi2Ph+f5/fCd5ONT8ZZmuflJtJ1JPxe
         or87iNN2S3QpyWndfmhk6i4PxXNsYThStbUuXuFixFK0MZ4diwP1ARY0tcOeXajwwD2t
         GF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742323363; x=1742928163;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hOZgoX2iJQX4V6wby9ytPUcVpVhdLhvcjz550it+cic=;
        b=CXCyTIxxnX5LKdXhOSTUY+dzzAWUULLNE4KToirGmGZvJtCEES98g+FaeAnRlRXrAz
         62EN23reZe8lEd5dfoIE4g2Q5tzyq/LZRAIsRgum/nbGbfDEUjTEI3oH4ETsR3dJcbxN
         8Q70NgfDa0OskXFcFESoQHBCepScQJHEml9x916YBVx0N5Gdq/gbi4p9riY/bJ8KAP/G
         TVHC+GuQDiWlY1iLN5N99f4jMYmPVHFEJOCTFDl7yN+BJ2x+TsYE4eqAKe4HMojLRKGO
         mcbVsofrE3eEnpoU65SkHQsUayoJvMBzHXXAxEKYowf29lrUsgbhwEDjaZmmI1gZsUIh
         WDvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn+yMnzhg7Uso2HZTIvx0tvY4ApM/g9fsoEXrpXwFWVnce/VqAv2heb8BUqkRohQevCzbsvbEKdetpS9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4yLF31zEkqozVoFQqePzO1RP5GZ/oYZJOcB4oCy0dXIzbK/Zx
	peFncBqJdALH5AUgChM8XO9eg1DnNfau4h7emzrzMNnvg7Iw1AP2
X-Gm-Gg: ASbGnct4OTt25ca0Mh7ccUNYBURWC1XHsDUoIq4CM2gQQQhEkqUB35nB0Au3IOX0Cjj
	lhSdLUcFnTlGMEoZ4WceTqaFGDyiUP+yFzpPYxwc3xU93CM9FnO+wqjuLyT440BOB/usvhF5QHZ
	P1IJfLTm7JO/Yi2hw/laFLxw8oyy5k3zlAARE1jNsZJe9s7riWx30wzFOUewhLasCGBlI6ahhYm
	M+mK4PTokyNMtnt4K+/bEor0IblEa5+wGkshSlv2eoOTwqf+ehUwvVZUjhg2UTL2lr+RjLyFQhN
	8jeJW/5zfjwcC8SGsn2apkGdgAoTrn+k97zGBmtfBOnOPY+sT394Su6Q7Or3w4owHZ7aITeN2Cz
	obgu0Fyl8ZBSaa0o0dlmFjQ==
X-Google-Smtp-Source: AGHT+IFfEyMAaLVB0aN9PjwmSGEU1r94RjANWvSfnn5QdYYbJjD+AEhkRe5qJQAshjNjQqNlY2c+gg==
X-Received: by 2002:a05:6512:3d09:b0:549:7145:5d24 with SMTP id 2adb3069b0e04-54ac9cc6d21mr45966e87.46.1742323363064;
        Tue, 18 Mar 2025 11:42:43 -0700 (PDT)
Received: from [192.168.1.146] (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8893efsm1743184e87.210.2025.03.18.11.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 11:42:41 -0700 (PDT)
Message-ID: <03902487-5cd3-45ed-b3cb-cabfd0ac5cb7@gmail.com>
Date: Tue, 18 Mar 2025 20:42:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 03/11] samples: rust: add Rust dma test sample driver
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
 dakr@kernel.org, robin.murphy@arm.com, aliceryhl@google.com,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
 <20250311174930.2348813-4-abdiel.janulgue@gmail.com>
 <87frjajwq2.fsf@kernel.org>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <87frjajwq2.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 18/03/2025 15:26, Andreas Hindborg wrote:
> Abdiel Janulgue <abdiel.janulgue@gmail.com> writes:
> 
>> Add a simple driver to excercise the basics of the Rust DMA
>> coherent allocator bindings.
>>
>> Suggested-by: Danilo Krummrich <dakr@kernel.org>
>> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
>> ---
>>   samples/rust/Kconfig     | 11 +++++
>>   samples/rust/Makefile    |  1 +
>>   samples/rust/rust_dma.rs | 97 ++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 109 insertions(+)
>>   create mode 100644 samples/rust/rust_dma.rs
>>
>> diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
>> index 3b6eae84b297..e2d14aa6beec 100644
>> --- a/samples/rust/Kconfig
>> +++ b/samples/rust/Kconfig
>> @@ -78,4 +78,15 @@ config SAMPLE_RUST_HOSTPROGS
>>   
>>   	  If unsure, say N.
>>   
>> +config SAMPLE_RUST_DRIVER_DMA
>> +	tristate "DMA Test Driver"
>> +	depends on PCI
>> +	help
>> +	  This option builds the Rust dma test driver sample.
>> +
>> +	  To compile this as a module, choose M here:
>> +	  the module will be called dma.
>> +
>> +	  If unsure, say N.
>> +
>>   endif # SAMPLES_RUST
>> diff --git a/samples/rust/Makefile b/samples/rust/Makefile
>> index 0dbc6d90f1ef..1a9aff6e8d6a 100644
>> --- a/samples/rust/Makefile
>> +++ b/samples/rust/Makefile
>> @@ -7,6 +7,7 @@ obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
>>   obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
>>   obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
>>   obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+= rust_driver_faux.o
>> +obj-$(CONFIG_SAMPLE_RUST_DRIVER_DMA)		+= rust_dma.o
>>   
>>   rust_print-y := rust_print_main.o rust_print_events.o
>>   
>> diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
>> new file mode 100644
>> index 000000000000..1740140faba6
>> --- /dev/null
>> +++ b/samples/rust/rust_dma.rs
>> @@ -0,0 +1,97 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Rust DMA api test (based on QEMU's `pci-testdev`).
>> +//!
>> +//! To make this driver probe, QEMU must be run with `-device pci-testdev`.
>> +
>> +use kernel::{bindings, dma::CoherentAllocation, pci, prelude::*};
>> +
>> +struct DmaSampleDriver {
>> +    pdev: pci::Device,
>> +    ca: CoherentAllocation<MyStruct>,
>> +}
>> +
>> +const TEST_VALUES: [(u32, u32); 5] = [
>> +    (0xa, 0xb),
>> +    (0xc, 0xd),
>> +    (0xe, 0xf),
>> +    (0xab, 0xba),
>> +    (0xcd, 0xef),
>> +];
>> +
>> +struct MyStruct {
>> +    h: u32,
>> +    b: u32,
>> +}
>> +
>> +impl MyStruct {
>> +    fn new(h: u32, b: u32) -> Self {
>> +        Self { h, b }
>> +    }
>> +}
>> +// SAFETY: All bit patterns are acceptable values for `MyStruct`.
>> +unsafe impl kernel::transmute::AsBytes for MyStruct {}
>> +// SAFETY: Instances of `MyStruct` have no uninitialized portions.
>> +unsafe impl kernel::transmute::FromBytes for MyStruct {}
>> +
>> +kernel::pci_device_table!(
>> +    PCI_TABLE,
>> +    MODULE_PCI_TABLE,
>> +    <DmaSampleDriver as pci::Driver>::IdInfo,
>> +    [(
>> +        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, 0x5),
>> +        ()
>> +    )]
>> +);
>> +
>> +impl pci::Driver for DmaSampleDriver {
>> +    type IdInfo = ();
>> +    const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
>> +
>> +    fn probe(pdev: &mut pci::Device, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
>> +        dev_info!(pdev.as_ref(), "Probe DMA test driver.\n");
>> +
>> +        let ca: CoherentAllocation<MyStruct> =
>> +            CoherentAllocation::alloc_coherent(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
>> +
>> +        || -> Result {
>> +            for (i, value) in TEST_VALUES.into_iter().enumerate() {
>> +                kernel::dma_write!(ca[i] = MyStruct::new(value.0, value.1));
>> +            }
>> +
>> +            Ok(())
>> +        }()?;
> 
> Why is this placed in a closure? Left over from deferred error for pin-init?
> 

The macro expands into a block which needs to validate the function 
item_from_index()?

>> +
>> +        let drvdata = KBox::new(
>> +            Self {
>> +                pdev: pdev.clone(),
>> +                ca,
>> +            },
>> +            GFP_KERNEL,
>> +        )?;
>> +
>> +        Ok(drvdata.into())
>> +    }
>> +}
>> +
>> +impl Drop for DmaSampleDriver {
>> +    fn drop(&mut self) {
>> +        dev_info!(self.pdev.as_ref(), "Unload DMA test driver.\n");
>> +
>> +        let _ = || -> Result {
>> +            for (i, value) in TEST_VALUES.into_iter().enumerate() {
>> +                assert_eq!(kernel::dma_read!(self.ca[i].h), value.0);
>> +                assert_eq!(kernel::dma_read!(self.ca[i].b), value.1);
> 
> We should probably change `dma_read!`/`dma_write!` to return `Result`,
> so that we don't have to wrap these calls in a closure for obscure reasons.
> 

Changing `dma_read!`/`dma_write!` to return `Result` is probably not a 
trivial change, would it be okay to have this fixed in a subsequent patch?

Thanks!

/Abdiel


