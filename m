Return-Path: <linux-kernel+bounces-529566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97951A427E7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE653ABE53
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DC7263C85;
	Mon, 24 Feb 2025 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fb8De9+F"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE0125485D;
	Mon, 24 Feb 2025 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740414453; cv=none; b=nzTmL9VN8Y9Iy3zmfnXc+W5YdwDc401se2NDm9taBV8R2YN/3IYRzWsTWfbuudJBeL2qb0Yo8i1TH2YyumCszSReugnvuFP1UzNZXT3My96+1IbOHhG7FEyIRxxXC5UI/NRFYnObylgun1HLz0d1sxEXNzfCvumvLuJkiZ4LpJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740414453; c=relaxed/simple;
	bh=SfKoA6FHlpKzTjlmTl90dDY9C7098JrDWp22f8Gat5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HaBsKuhaT9mWb5/QJiAiMPJRg4tjaRIkpGUE8jPto0TbJjw03EGv4Yg1mncWMbVIH9QAkUtfF2TwrfMMZw+eBjclJSAP5MwiGBI+MtDBospWtmqWejSbXbNeQ8xtmO/rfFs2pDoQueOZyXkYdWPkGZxkOF+zKXhcXfI5oTi33Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fb8De9+F; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5452e6f2999so4945018e87.3;
        Mon, 24 Feb 2025 08:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740414449; x=1741019249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bg4rB5EJpBPXIh7sJAoqg5lA1zVEFXJjjwBya4kLsHc=;
        b=Fb8De9+F06PSXKgJXBgmwaKpJaKh6mf2vIbbQ75/20x7OiPBK0yW5sPmM/TeIkCT9W
         hyhOLbLiYMuRTj+I7Irn7Hn0MCIp9sMF7/PWBSjYH0frPMex/851jb4WgxWGHQTMoTZ1
         mHNVDrnZtpe11aFTjDInoFMzcqbdoQGmuDsZ+tcxsDnJxXzKm/CCdOIsutx1yf+h999P
         ugo4RgxHnwnN8D5WRjHS8TAMdcFNr2jmgjN/dlDtM4s4KAIiHRuFcj95YWoM8oAyvsFd
         v2apUVqkdM0LzrRx9FyF0dS/8ntpNIFRC9+Psgr74IwZTL7csxOe9RlO1n2NNGWvyfUZ
         T3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740414449; x=1741019249;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bg4rB5EJpBPXIh7sJAoqg5lA1zVEFXJjjwBya4kLsHc=;
        b=sLEUFRbpUugFUU6aCLaji74joKX5qRPO3gJyuy1B5ultXtw78xpmGgbV3hNQDMezLu
         xOKp3jhCozqsz9BPO5u7isYIZccX/JZUUIO+9QuUrniyB7lg9X+NhQdIAjVHuhfruF1z
         XIkVwh2ChsnL9rJG6PNE0Qusl04YUtrGvbcDijjqbEWeo/58bdaOLsAELC8CRkLkOAxk
         2+6nPell9hhd6dfP4u4G47CTHGQeG3MHTaEa8L+XnIlbPD+Kvwpkr/dOnRrvRELPOQ1i
         GS5Tvoysrx+PevRmhqLLM9wVhkDR5jnAjBXCAK5hsaAaHjizUJuKjm1USu/aDAwuF4vU
         KraQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOeKRqF0ddS0Zynqe0IAwWi6iotZRoy0eIjIutVDC8rs7mesiF+ycJ5HfF7bQvb21nmicMFqhCyeS8/3A=@vger.kernel.org, AJvYcCXYcmwnEmx0MWPB8PV3sf5l0/dhwUl4KkODxNAcvCpsdXpCouc9Kh9Lsaz+GO98wIMafstfsALhrhzaf17Or0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/vH7oj3lhvXPF3f9MUiAI/CQJaKao0Uvh3ipVUzsEPYT6UY48
	HXQVFeBqcCPXmWfL0AKA7zvTMzgrT365vO3IBNkTUo8bD//MkjDv
X-Gm-Gg: ASbGncvhf/iKzOaNdTUbdCu1x8IAFb3HYkKsS1y2lyzdq35xhaRnZoL4h5XT+UKfd9A
	rwy2jERZ6QuN7aH4RGFdhQP+AFjVFfyznJQmUxR9uB6CEZE1R5mTAPBUXwNF2eOOA/5v0l24Zhh
	3srmQ+G9rR5KNXQW5XNEu6MZMrMhhly/h1WMAf5iBG/lxBbOgB8RkRaezf8QMyrAe1oPSyfrads
	jb8Cu4TrXcGmf1cQP1m2Zrvv0wii17tmTZ9ZQtXlkZXfFbx46Xr8Fe7Jw+L5TC8uDFif3JAIwUS
	IohByi7X3x5TYZqPVO2B4wVU6FxjoN/CjJwINmmNyZ3c+nIdkrnd8TcbtWIQGzCXH08UXDm2
X-Google-Smtp-Source: AGHT+IGdsV6VuMH1mr2wYZzWOKRPyftVbhVqgaj2HeDq7VSym8AAoN7aN/aGmmBPQAbcNEOLEsALrQ==
X-Received: by 2002:a05:6512:b8c:b0:545:22fe:616f with SMTP id 2adb3069b0e04-54838ef7278mr6089217e87.24.1740414448976;
        Mon, 24 Feb 2025 08:27:28 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f08332bsm3478218e87.48.2025.02.24.08.27.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 08:27:27 -0800 (PST)
Message-ID: <6f154af8-6379-4b1f-9e30-2b99f7f736dd@gmail.com>
Date: Mon, 24 Feb 2025 18:27:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: aliceryhl@google.com, dakr@kernel.org, robin.murphy@arm.com,
 daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 airlied@redhat.com, iommu@lists.linux.dev
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <k3GMnfXzzvUVOgSnuMlEq3eVRyq1qjcf_tDtILRbOwj08EIQpwQ4bGtGhwWufr8lUn-VlHnNjP8FxIA48Jv-Ug==@protonmail.internalid>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
 <87seo3z9qr.fsf@kernel.org>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <87seo3z9qr.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 24/02/2025 16:40, Andreas Hindborg wrote:
> "Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:
> 
> [...]
> 
>> +/// Inform the kernel about the device's DMA addressing capabilities. This will set the mask for
>> +/// both streaming and coherent APIs together.
>> +pub fn dma_set_mask_and_coherent(dev: &Device, mask: u64) -> i32 {
>> +    // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
>> +    unsafe { bindings::dma_set_mask_and_coherent(dev.as_raw(), mask) }
>> +}
>> +
>> +/// Same as `dma_set_mask_and_coherent`, but set the mask only for streaming mappings.
>> +pub fn dma_set_mask(dev: &Device, mask: u64) -> i32 {
>> +    // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
>> +    unsafe { bindings::dma_set_mask(dev.as_raw(), mask) }
>> +}
> 
> Sorry if it was asked before, I am late to the party. But would it make
> sense to put these to functions on `Device` and make them take `&self`.

Thanks for checking this. The API is about the dma addressing 
capabalities of the device, my thoughts would be to group them with the 
rest of the dma API? But either way, I don't have a strong preference. 
I'll let others comment.

Daniel, Danilo?

Regards,
Abdiel

> 
>> +
>> +/// Possible attributes associated with a DMA mapping.
>> +///
>> +/// They can be combined with the operators `|`, `&`, and `!`.
>> +///
>> +/// Values can be used from the [`attrs`] module.
>> +#[derive(Clone, Copy, PartialEq)]
>> +#[repr(transparent)]
>> +pub struct Attrs(u32);
>> +
>> +impl Attrs {
>> +    /// Get the raw representation of this attribute.
>> +    pub(crate) fn as_raw(self) -> crate::ffi::c_ulong {
>> +        self.0 as _
>> +    }
>> +
>> +    /// Check whether `flags` is contained in `self`.
>> +    pub fn contains(self, flags: Attrs) -> bool {
>> +        (self & flags) == flags
>> +    }
>> +}
>> +
>> +impl core::ops::BitOr for Attrs {
>> +    type Output = Self;
>> +    fn bitor(self, rhs: Self) -> Self::Output {
>> +        Self(self.0 | rhs.0)
>> +    }
>> +}
>> +
>> +impl core::ops::BitAnd for Attrs {
>> +    type Output = Self;
>> +    fn bitand(self, rhs: Self) -> Self::Output {
>> +        Self(self.0 & rhs.0)
>> +    }
>> +}
>> +
>> +impl core::ops::Not for Attrs {
>> +    type Output = Self;
>> +    fn not(self) -> Self::Output {
>> +        Self(!self.0)
>> +    }
>> +}
>> +
>> +/// DMA mapping attrributes.
> 
> Typo in attributes.
> 
> 
> Best regards,
> Andreas Hindborg
> 
> 


