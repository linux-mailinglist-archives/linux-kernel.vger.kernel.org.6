Return-Path: <linux-kernel+bounces-209928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2891903D08
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53385284DBE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4DE17CA0B;
	Tue, 11 Jun 2024 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q8NRf+Si"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE94217C9F3
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112100; cv=none; b=WqAtR+cYTypZR5ARINi8e2QAYb2ZSXJMuC0ji8Hu/MsNcLIxsdmowAy5VT3VUhW7xV6FJo0TJSUl4pDCApQ9QlPVL8R7n5Di8fSGY51qju+bFNJaUX7IF8HDCqzsthl0cA7MB79ibwE49wJggDzTaJ9ISQG4MTVCAx3ECwGuMjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112100; c=relaxed/simple;
	bh=N9bbDuUtVI3n6modvV8e2C1xul8okVr+fDJnep69kXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpRjJaLUk4UKmEJLhiq++nTBV/Ms+aWFryD5mCqGY92rZ0teDRLGe+QwOeV44FaZp2irwyc+q1r/BL2eeXnwiWMBXBKhknXwMvBuVe1j7FriENGYy5UFZN4IgeuGQNNjeMgfoElNxhyKgh0jf+1xzxioZu7gNLWFcF4m+/L8AVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q8NRf+Si; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718112098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZIL3WzHfFsP6BI60s8nCj0qGjt3OC3BNLgftYsOna64=;
	b=Q8NRf+SiewXrK2ma5jDeZO2wCHtkHVT6iAbk1V4fxHR6yFQKKIpzcgD4MtwdXTA577gMg+
	fJyJcOxaPWlfa5DPVFYhvxi2/DKMe4VqvQc1BFiK2G6LeyINl3m2O+xTer20te2qJ4gkSW
	p3u1FGKhPsDhH1jktOjHI2Y0zvMiaG8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-V0Nc9FasNlKm3VMYd3kCeA-1; Tue, 11 Jun 2024 09:21:36 -0400
X-MC-Unique: V0Nc9FasNlKm3VMYd3kCeA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-35f1ddd8a47so1407581f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 06:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718112095; x=1718716895;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIL3WzHfFsP6BI60s8nCj0qGjt3OC3BNLgftYsOna64=;
        b=qcgQhQbaDGNywZ7xivM9lbigmAoM3ccEZpwb5Y1kxNnWn3VzSlTVapu6HX/8ikoDsC
         aAkhq6cEJvcHE/nvQDBYf68rX5H0/AjqQ+9/saQvE9yVMnINCggNXPpn3UIH6Kafnm88
         BdJrgesziuX38uOaJOLNnxpQGY/WU7WQ8BBgGi73uxBJ5L9YxZ++7jG8L2eUPtsLyn7d
         gCyRfuCenK5TGfYDA0vv+kJJSDxbUghiA1vDKQUpF9FVKbMOigLVkTuuYNA9G7ThBF34
         VYGO9zEQrvZ97WQE5bxcCW+D9G0fRBWovUi9URl8s52khg4QEoYN0JTBRB3WZaPmaVfz
         p12A==
X-Forwarded-Encrypted: i=1; AJvYcCWqhMkGVm7L7vuL77+pzQeKE8jljM7ADq1y3ezY+U4WFi8n9htP7KqGerKYu5opiUdxHzMAsF/1aywwtPcYkoCdY+5WBcp4vOPNAeMe
X-Gm-Message-State: AOJu0YywWeblj85dM6kvkBNOXXzBOi1laF1TBA6MZuFjHGzBBPLjCl4/
	LCdLUqpkvSAmR5HVqcoPULZVOy6JuMQ88VQErUtoaxtW34SbUbvgC9cb2O28j6uoGQPKwmonAQl
	6Stfksovlg12dUZnnPETlPvekG/9mjl0kOELzMN9ezXiBTW+yrVzB7dnQL5IAag==
X-Received: by 2002:a05:6000:1e92:b0:35f:2fd3:85c1 with SMTP id ffacd0b85a97d-35f2fd386f6mr603166f8f.12.1718112095109;
        Tue, 11 Jun 2024 06:21:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdrgyGSXnWsxnxLNMq9gvn3zIKYLzq6W4Ui2uJAaYYqihXeuvxSaXL/IXX8Ulu/RvLhy739g==
X-Received: by 2002:a05:6000:1e92:b0:35f:2fd3:85c1 with SMTP id ffacd0b85a97d-35f2fd386f6mr603148f8f.12.1718112094727;
        Tue, 11 Jun 2024 06:21:34 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1aa8d4f3sm8441598f8f.99.2024.06.11.06.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 06:21:34 -0700 (PDT)
Date: Tue, 11 Jun 2024 15:21:31 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, mcgrof@kernel.org,
	russell.h.weight@intel.com, ojeda@kernel.org, alex.gaynor@gmail.com,
	wedsonaf@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust: add abstraction for struct device
Message-ID: <ZmhPW9yq7y6jbmIg@pollux>
References: <20240610180318.72152-1-dakr@redhat.com>
 <20240610180318.72152-2-dakr@redhat.com>
 <ZmdID8AlXtoxUfC1@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmdID8AlXtoxUfC1@boqun-archlinux>

On Mon, Jun 10, 2024 at 11:38:07AM -0700, Boqun Feng wrote:
> On Mon, Jun 10, 2024 at 08:02:27PM +0200, Danilo Krummrich wrote:
> [...]
> > +/// A reference-counted device.
> > +///
> > +/// This structure represents the Rust abstraction for a C `struct device`. This implementation
> > +/// abstracts the usage of an already existing C `struct device` within Rust code that we get
> > +/// passed from the C side.
> > +///
> > +/// An instance of this abstraction can be obtained temporarily or permanent.
> > +///
> > +/// A temporary one is bound to the lifetime of the C `struct device` pointer used for creation.
> > +/// A permanent instance is always reference-counted and hence not restricted by any lifetime
> > +/// boundaries.
> > +///
> > +/// For subsystems it is recommended to create a permanent instance to wrap into a subsystem
> > +/// specifc device structure (e.g. `pci::Device`). This is useful for passing it to drivers in
> > +/// `T::probe()`, such that a driver can store the `ARef<Device>` (equivalent to storing a
> > +/// `struct device` pointer in a C driver) for arbitrary purposes, e.g. allocating DMA coherent
> > +/// memory.
> > +///
> > +/// # Invariants
> > +///
> > +/// The pointer stored in `Self` is non-null and valid for the lifetime of the `ARef` instance. In
> > +/// particular, the `ARef` instance owns an increment on the underlying object’s reference count.
> > +#[repr(transparent)]
> > +pub struct Device(Opaque<bindings::device>);
> > +
> [...]
> > +
> > +// SAFETY: `Device` only holds a pointer to a C `struct device`, which is safe to be used from any
> > +// thread.
> > +unsafe impl Send for Device {}
> > +
> > +// SAFETY: `Device` only holds a pointer to a C `struct device`, references to which are safe to be
> > +// used from any thread.
> > +unsafe impl Sync for Device {}
> 
> These comments need some rework, `Device` is not a pointer to `struct
> device` anymore. For the `Sync` one, how about:

Indeed, I forgot to update them.

> 
> // SAFETY: `Device` can be shared among threads because all immutable
> // methods are protected by the synchronization in `struct device`.
> unsafe impl Sync for Device {}

Sounds good.

> 
> and for `Send`, I actually don't think we can easily say the generic
> `Device` is `Send`: you can create a `struct device` where `->release`
> requires to be run on the same thread that creates the `device`, and
> nothing is wrong about it, I think (e.g. making a thread be the sole

Hm, I guess in this case we actually can't argue that it's the owners fault to
pass a pointer of this device somewhere else. Since it's C the owner can't
enforce that someone else is not taking a reference and prevent sharing
ownership...

> owner of some special devices). Unless, in the #Invariants of `Device`,
> and the #safety of `from_ptr`, you mention that `Device` assume its
> `->release` can be called on any thread.

...hence, I agree we should indeed add to the #Invariants and #Safety section
that `->release` must be callable  from any thread.

However, this is just theory, do we actually have cases where `device::release`
is not allowed to be called from any thread? If so, this would be very confusing
for a reference counted type from a design point of view...

- Danilo

> 
> Regards,
> Boqun
> 
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index fbd91a48ff8b..dd1207f1a873 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -28,6 +28,7 @@
> >  
> >  pub mod alloc;
> >  mod build_assert;
> > +pub mod device;
> >  pub mod error;
> >  pub mod init;
> >  pub mod ioctl;
> > -- 
> > 2.45.1
> > 
> 


