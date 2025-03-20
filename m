Return-Path: <linux-kernel+bounces-569806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAC7A6A7E7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7EB21B62A98
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741D71ADC93;
	Thu, 20 Mar 2025 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rpm1HaMJ"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4143C221F12
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478969; cv=none; b=kNpw44igEzg3V7pAL5/R2h2LudkAWK+W2hXVZOP/ELeCwhqfzHU4K13Z4ULPKATRYp0T5KFX7/6Ds4OnKclDWcAru1uQSF1OTLuEjqCAE3YMZwqMhi0KwCpwbh1+YC0vHLG9+qtNBNI2PGnMx7z31EMaQAm8MA0EtGaJQtI9uwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478969; c=relaxed/simple;
	bh=nUaR/nCHRIz6/4FDMPevRY66eapZVm3Y4PiREj0DAJY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KDdcjbDdBex1q3ZHtK4QviIiIXA9uJQgZJUFeCE+VoNt5l+FuOR7xZPqy+orwcbJSdIV7PfB/OxqKv6kZp06n/6QsEsMUt5GCSKYSEedR696nS1UIk8U2/F/nUEBKiYyxRAiUdMw0K8RU2+SB/UEzcKYeyCis/vK+42twhi/egc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rpm1HaMJ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43cf327e9a2so7159305e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 06:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742478966; x=1743083766; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8E8OqeISMoJbUQ42c5DF0qEmt4USZs1130o5kPyecBM=;
        b=Rpm1HaMJ532VJhLDwhS/yeXwfOG2dTezKoFgNcXzMzn7BAxFM4hnRlP1qHcBhOeBlo
         FnouSWKSEYNxT505cR3z/+uBx8MXOWWTcVfwvC2XZUJj9YwSMKhhmO6UT6XFOgCDxh/K
         saGi4HiFb7XAjoZRey8MN6H2x96VkEGihQ+ZZ5i+pI9yudh8yBz44LMC93Cr98c7iWwH
         EZaukCdLuRtRNZtpFQ3hXeW21zt3jkkb3eMQSPGYi++6pHPNuwZjxW49GcCg9AQQp+2d
         kyq/XkXOtvTl9Gy98u8AtbZTC9FRcD4+oHijOlkx3O03MATIUtTwXVBS1TrUQilaI9Ty
         zoSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742478966; x=1743083766;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8E8OqeISMoJbUQ42c5DF0qEmt4USZs1130o5kPyecBM=;
        b=nSVZyD0UTX2heBj+Lp2bzbo2epMRvRnGaxyiQfUQh0B59qwyzk8vrKvwacJQRg97PX
         Y+yKA9JV90+Ax90Q9xYFQgppd//WMyYMMJ/U+dWlzNdZL5FVUP71CJkXHeYhlzC8iHRc
         05eW+7DlWiQfRMmhw/mVDBlOwyZs4opO8ZaKLeYjwMwWjKIb0Ppn+tDGD9WRItTiMXDQ
         PQBSLU2Zo72LSLtptDmeXheUJzR2W3TFCCXhmT118PxuI984ajo8lbwzCCBAsRHR9T6Z
         npkm/YxW1OIUKGN0Gy1xsNj/D3jHkvJN65fEB1jnQx+i3ExZBrwuXUnyu76Cspppys6p
         eTew==
X-Forwarded-Encrypted: i=1; AJvYcCVZcU8zHtB6LRYc0rMUaOUboA8n1+dDMfkQLk6gmO3M7Ix4DEXv8f7WjAo6x4fnef9Tkl3kG7kVnWQXxn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Rot+mvfKe3YSLLy6MEOk3TpbBRho2LGjfcVEmA9g7LHTob32
	Sfyl4gG5pikFaGtRlWVqMoK0lutdUl1vS7kRETyV9M/xoyzQfGKKDq9aY4dEJ8NC61YshK270YY
	s6oxoRfAT92/r1g==
X-Google-Smtp-Source: AGHT+IES/KBxR3IFZF6/p2wguTQuK4j5WKsZzCUEa3/0Gb/QL82tmNsePTpM9KCnh2vZcWlk5iQgZ67NPI6IjZM=
X-Received: from wmbek12.prod.google.com ([2002:a05:600c:3ecc:b0:43c:e9df:2ecd])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4fc2:b0:43c:f64c:44a4 with SMTP id 5b1f17b1804b1-43d4378bfbamr50404505e9.8.1742478966631;
 Thu, 20 Mar 2025 06:56:06 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:56:04 +0000
In-Reply-To: <Z9wDV7Y0-pwe_A-v@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250319203112.131959-1-dakr@kernel.org> <20250319203112.131959-3-dakr@kernel.org>
 <Z9vTctFR7QAOa4tn@google.com> <Z9wDV7Y0-pwe_A-v@pollux>
Message-ID: <Z9wedMSNOntie88F@google.com>
Subject: Re: [PATCH 2/4] rust: device: implement bus_type_raw()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, tmgross@umich.edu, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Mar 20, 2025 at 01:00:23PM +0100, Danilo Krummrich wrote:
> On Thu, Mar 20, 2025 at 08:36:02AM +0000, Alice Ryhl wrote:
> > On Wed, Mar 19, 2025 at 09:30:26PM +0100, Danilo Krummrich wrote:
> > > Implement bus_type_raw(), which returns a raw pointer to the device'
> > > struct bus_type.
> > > 
> > > This is useful for bus devices, to implement the following trait.
> > > 
> > > 	impl TryFrom<&Device> for &pci::Device
> > > 
> > > With this a caller can try to get the bus specific device from a generic
> > > device in a safe way. try_from() will only succeed if the generic
> > > device' bus type pointer matches the pointer of the bus' type.
> > > 
> > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > > ---
> > >  rust/kernel/device.rs | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> > > index 76b341441f3f..e2de0efd4a27 100644
> > > --- a/rust/kernel/device.rs
> > > +++ b/rust/kernel/device.rs
> > > @@ -78,6 +78,13 @@ pub fn parent<'a>(&self) -> Option<&'a Self> {
> > >          }
> > >      }
> > >  
> > > +    /// Returns a raw pointer to the device' bus type.
> > > +    #[expect(unused)]
> > > +    pub(crate) fn bus_type_raw(&self) -> *const bindings::bus_type {
> > > +        // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
> > 
> > Is this field immutable?
> 
> dev->bus is a pointer to a const struct bus_type, yes.

With that added to the SAFETY comment to justify reading the field is
data-race free, you may add:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

