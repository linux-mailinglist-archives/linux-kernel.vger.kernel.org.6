Return-Path: <linux-kernel+bounces-550960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4307A5666C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19079173ADB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1211621771E;
	Fri,  7 Mar 2025 11:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A2Q3wnVw"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35A221766A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346230; cv=none; b=uelN6WZkDOukZZUgOimevR5KxHZ36+31T4lg1Jrxdp1HJ4l23JGyg+FgJ1Bkuk2TQMn0MzhKMERhSrSMDwCZpeqjH09xZsBpL5SipG8G1n33aMf2TXcVFecA6dtHBehqS/BcGFBsfQ/PmT9lXsHyNLPOVXhBRgjY0YqeNxOL2mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346230; c=relaxed/simple;
	bh=phHfA6KQhI9tzLKWRyLl5Cm7ekKU7mLN5aentr1Yft8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lrc+I5iIbDunQvPhkDcEsujYg1bl7dz+NyTkkqmOO2bQs82uwpodOkybxbL28otL1392Qd+Qcl6HhFoOTqQ6DlmO45YqOGrWeT1k6ywe5/hDbtdjweGCp3vRtgKy2+rbe1pz5zRBAEjKB80ZQrPJ00iAqVAFUxvUmesIz6wC36Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A2Q3wnVw; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43ce1eaf9f4so206285e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 03:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741346227; x=1741951027; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7NCud3YDrS8rMqDriMRjnUp9EmgptAXkjuXyMh39DeE=;
        b=A2Q3wnVw0PlGHPudWHBhQsiPeR7vkL0PFoQA/ykpwIla5mRxM01hOpq+HtuzE4jofY
         wXA6hwDbCbLUavV4M6q9OMyfFgPewlfV1Ef88U2x5i6brkp4YhGTM0uNFDRgLODP6E7P
         Z6ScfzfVqBnrrYriZRdq1cwMPSt0V/UDnTgQdixfOST9kgY3qiEnqFf2HeP5w6ngZCCE
         yNt7d2K5WpjEi2JOzyrrRmPjkfe+dADzLZrlg6WMWY1s+lp4V/FT4HPKEspgvLkNCe6J
         BSDx0sMJCvfbNsRPGk3qCGea7i3euED46ebJQDm36ppktS+azXomtijrsG3bGoDKfCeP
         W5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741346227; x=1741951027;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7NCud3YDrS8rMqDriMRjnUp9EmgptAXkjuXyMh39DeE=;
        b=BXBbca+XAQEmd1yYEn+5PrpwdY71JXce6Ezmuf2+LPnaZoyYVbkCyMVDuE4oLnuMZw
         K9A6kgoGtAgEBjEQYC1f7tZiqw0FRurCsGggy9Iid3lP2qWv8s2D0bapdfm0mPPDFXWg
         WwJLVdVsVHGYOvPixVNOVD5cAZbxC4g3MVI9oKtlcC97lXOFDTmmiQZhUoqZz7JoWMbY
         8cTtvzibpUICpcE7R6XuAEH8DJSsKdKK5bKwoeXHJdSxV1fLMsXNIMetZpBycAGlc0Zf
         qIOU7Uj4lyVhO6A3NzF/bMbrEl9gh8qenzxFGWc4F+YBeqxSZ9GM+qx2Pw2DuoilVl3O
         II3A==
X-Forwarded-Encrypted: i=1; AJvYcCU8NWe4RGT1Uc8o18krc5wrVCy0N9B2j63HN4flvi1njKhtECMCBR5sFFjqjmTDFzVLyVUAZcehglZbaWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfANVS9g3ba+YEW2SJ60w38Dh+otorIC1Lp6Z6qdpJzQ8kFpdE
	pb9alBN4PwmxFXmPGCaxRLpP4GfVlug2QNDVEuI+gjdn1b+d6ljPzW/rF7vbgaJhjflctSni7QD
	bCml+VejEGE64LA==
X-Google-Smtp-Source: AGHT+IH5/jQh6E6kSDoYmzpqJhrOtDcnc6+Obu9PZ9gPPi3bYRV7MA4XFxyIILhgKXpg3G8LM6+X3I03hodwVqU=
X-Received: from wmbfl11.prod.google.com ([2002:a05:600c:b8b:b0:43b:c7c8:d3ae])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c9d:b0:43b:ca39:6c7d with SMTP id 5b1f17b1804b1-43cb91c5830mr14428465e9.3.1741346227107;
 Fri, 07 Mar 2025 03:17:07 -0800 (PST)
Date: Fri, 7 Mar 2025 11:17:04 +0000
In-Reply-To: <20250307110821.1703422-3-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250307110821.1703422-1-abdiel.janulgue@gmail.com> <20250307110821.1703422-3-abdiel.janulgue@gmail.com>
Message-ID: <Z8rVsH_Hl34GUjOo@google.com>
Subject: Re: [PATCH v13 2/7] rust: add dma coherent allocator abstraction.
From: Alice Ryhl <aliceryhl@google.com>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com, 
	dakr@kernel.org, robin.murphy@arm.com, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Valentin Obst <kernel@valentinobst.de>, open list <linux-kernel@vger.kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="utf-8"

On Fri, Mar 07, 2025 at 01:06:19PM +0200, Abdiel Janulgue wrote:
> Add a simple dma coherent allocator rust abstraction. Based on
> Andreas Hindborg's dma abstractions from the rnvme driver, which
> was also based on earlier work by Wedson Almeida Filho.
> 
> A CoherentAllocation is wrapped in Devres which basically guarantees
> that a driver can't make a CoherentAllocation out-live driver unbind.
> This is needed, since DMA allocations potentially also result in
> programming of the IOMMU. IOMMU mappings are device resources and
> hence the device / driver lifecycle needs to be enforced.
> 
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>

You might want to add #[inline] annotations to the various methods, but
otherwise LGTM.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> +/// Helper function to set the bit mask for DMA addressing.
> +pub const fn dma_bit_mask(n: usize) -> u64 {
> +    if n > 64 {
> +        return 0;
> +    }
> +    if n == 64 {
> +        !0
> +    } else {
> +        (1 << (n)) - 1
> +    }
> +}

You don't use this method?

Alice

