Return-Path: <linux-kernel+bounces-569326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F1EA6A184
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FA877B1E66
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B7D2144A2;
	Thu, 20 Mar 2025 08:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nKJ1iucM"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CD71519BE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459767; cv=none; b=k5jIRew5ZPlDevxf9SH00Yr77/N7nMlioaa7hSGIRJV2zy2ZzN7qLoECOH1rxli1dujxMssSVcDoa50KA12zuIIdCVsOd4ogdSySixnEEwHoxvfL8DRLADo+fXDVUWNSvsjUzfmNm1jxLvP6PdxUkquI5SG2ELjFkfDotCCd5sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459767; c=relaxed/simple;
	bh=KNJnFdpohVmIa9lQL3tDOPD+TWPXmNHbRtdDIF7XKFs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hhBf4eI2EGfevMsq4YJUkdM2hCT8eHwVOAn46gPhUH1h5Z5C2TVy3Eo0giqMktzDkB6wP/gkJIy+hx3BsO8HSyeVX4bEn7tXxe7N31Y2/+A4p14v3zYtcB5va/vqwU4bdIrB5S+FJrkb6WVa4puCmtsFUGzE4s2wepjxmNRRXME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nKJ1iucM; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43cf3168b87so2512145e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742459764; x=1743064564; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F//KPN2uLlDC+J9SdRcv9HHuEvs+T8Y6Iwqb4VpEjaQ=;
        b=nKJ1iucMm4+Ft7xY7dWQjBzS9hYTpOAaS0HrvwhD4WKQglGeji44zIKnRc5a0tC40U
         wIzQ5R42sHRNnC8jJUrfnQ5PTnUYUt6IGwuKT+isj56g+xZuK3bF6oy4e4Y5xHXyJPgy
         oQXDIqJNlz7w5sgdcqSdg0hj02IzXurvJzEKGhwDiskbA2b24KBJ1KAEzmlZkumWcCZd
         KFgsufXXs2LwyrwzqjfduLjOLWrmtil1671KKqXeBx+TsfAQpy3YSybba/7D3GoknfWF
         mflNIdQpmLDbIo5vH5Q5pjVi3/rmjRqOcMExqFVSzJ+wUC7+Dz9VlRUAISePfLsv2Zit
         U9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742459764; x=1743064564;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F//KPN2uLlDC+J9SdRcv9HHuEvs+T8Y6Iwqb4VpEjaQ=;
        b=RWc3IgQE1h2MzdjfY0dBcWs0xtoxCJ/bqeWTSPdNKicczibxCRiLQjVnfjRz2LNwq8
         9+A0hN6wONpll08bmHBR8keZ93NMheocII0f6Osg34FneyeUD44fC/omKKKaI2QehM2/
         /GU+KnUsy0Vz5ZxJCw4a/DzrW1VPcH8osJQ69z/dG/E1W+J3J5MLlGFKl3Vg3LKKgoCy
         ICubiJjvFyavYBA85HRuKInZVfmmqFpdPJvMLV7TgvPjlkyMNGqTSaOtA5G95hT2Olyw
         cil27OKHJOvs/FBlRjqIjp39utaV4oytKHrrcnyY68rS/41qPZ20pkjL6Vdl0liIQw3Z
         Of3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCtkviNyZVUNozPrBisnjfNcfRNySMsACitIujNP7zJ78JCEfnUI0CCNobULrjy13CuDDf0zPorKjkDi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhv6RGvlcHWprMFiozq5ep9WffqlZuSXqTSDdJOCriEWJ85MuA
	pojXIICHhPIm+WISGFnC/cAVn86oapCPo7mlrXZUJgu5aFvxaT/dnu0uoRjVuZdn6B1YhhPJgZx
	Tlm4y/vBZM1pwEQ==
X-Google-Smtp-Source: AGHT+IGae8DQmm0qB5K/T2yS0Ts18/juxqQiCR0uNBRGxkWQTVlUWPIuqtVDcfSLOrlM8VzPf2m3TStxTVObcuM=
X-Received: from wmby10.prod.google.com ([2002:a05:600c:c04a:b0:43d:1f4c:ccf2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f86:b0:43c:f616:f08 with SMTP id 5b1f17b1804b1-43d4378b1bbmr48923425e9.8.1742459764068;
 Thu, 20 Mar 2025 01:36:04 -0700 (PDT)
Date: Thu, 20 Mar 2025 08:36:02 +0000
In-Reply-To: <20250319203112.131959-3-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250319203112.131959-1-dakr@kernel.org> <20250319203112.131959-3-dakr@kernel.org>
Message-ID: <Z9vTctFR7QAOa4tn@google.com>
Subject: Re: [PATCH 2/4] rust: device: implement bus_type_raw()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, tmgross@umich.edu, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Mar 19, 2025 at 09:30:26PM +0100, Danilo Krummrich wrote:
> Implement bus_type_raw(), which returns a raw pointer to the device'
> struct bus_type.
> 
> This is useful for bus devices, to implement the following trait.
> 
> 	impl TryFrom<&Device> for &pci::Device
> 
> With this a caller can try to get the bus specific device from a generic
> device in a safe way. try_from() will only succeed if the generic
> device' bus type pointer matches the pointer of the bus' type.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/device.rs | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 76b341441f3f..e2de0efd4a27 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -78,6 +78,13 @@ pub fn parent<'a>(&self) -> Option<&'a Self> {
>          }
>      }
>  
> +    /// Returns a raw pointer to the device' bus type.
> +    #[expect(unused)]
> +    pub(crate) fn bus_type_raw(&self) -> *const bindings::bus_type {
> +        // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.

Is this field immutable?

> +        unsafe { (*self.as_raw()).bus }
> +    }
> +
>      /// Convert a raw C `struct device` pointer to a `&'a Device`.
>      ///
>      /// # Safety
> -- 
> 2.48.1
> 

