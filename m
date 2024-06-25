Return-Path: <linux-kernel+bounces-228706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EA29165A4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D53A0B229C5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F73614AD24;
	Tue, 25 Jun 2024 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="ILQLJ/3l"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A90714A4E9
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719313176; cv=none; b=R5tFfsvcipJB3u/qJVKDmy1SgUM8bi1mYdyrEVQQB+iOzsZHz84iqQRTkoksq2Gm6DLw6+L15F+cfydzWigKytMCZxk5zmA7424ogCyOMydB++P814ghyv6f1SqDC70GT9Wt7xN36fqm+um2Dx3ltUdHFf7R/1oEIQNgWZI7zCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719313176; c=relaxed/simple;
	bh=fVPF6QJF7rG/F5OUgasWuukloGcuPijewbPTH7NCyZs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q2XcEWt3F3XACNzCrk7UH1gEJQDoQ/5nKqrvDoVVxlnCVCkQ/0gUuumb6RLku1KroyPKMnxaEW0iTo1kYyGZmAmvLNG3QIirj3P2FRCbicnUJx5pwh0nLmuhBBDwOrzz1cCw6y6iLj/aJOe5BxfbLoPto6EO2lJ/1XRE2jEXHvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=ILQLJ/3l; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ec52fbb50bso32585871fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 03:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1719313172; x=1719917972; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7HK8CBgC+NsQrNpK+KFLlGL2gTcxTEEhi40E3k/R3Wk=;
        b=ILQLJ/3lR1YkL/m7S7M7lLKD8EF+7VQkMHMXKO1OBpqJ5nw2M44saogXfx0XENEa8u
         Rt7W9cQ0PoEWnDwgwE7UYQRQnD2elF1Z6spLrBsaUFUoHbBM78wYmX9N1cvtpKpmdz5O
         sTkSq/a2sOXOjtIeN0P7WymgLpqhje3vnmq+eb76aLeM3KBvZ4PlFvnAsZWLhmhZO9SS
         mftTeJRFxmPo6A+MPjJ5uBf7aXr+wrrnEB7+8gpTPYQuHdf9UGl+WTnqazfBmE1dL/n+
         f+MsHN8BVw6zaZ1wlITCtCdjHPAsK4e5nA19UZECaCSTMHZY/w5HbG81Ue48Uf16j/Ys
         bM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719313172; x=1719917972;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7HK8CBgC+NsQrNpK+KFLlGL2gTcxTEEhi40E3k/R3Wk=;
        b=TN9eYJIDkhM/p0i4APh27nyH5fLpQEvUVUN+jTXZOWEVdlS0U98Yo/l323rnjcqb0o
         s6UamGlWc1yDArAp47Y+cKIcWkStfu7k2JSgl/C0Q6DJidJWKAv6ShOsS+RprVHm0aGc
         cNi8wfat8zG5hFsgARFBbDf39qAFxeInIxpSqWOiA6ugql7/muVtnPeFMRhgMYqZea9o
         mAqu5efAdJi45uE4FU+rL6bnL3/mRvZ6pKRkxcsxq/w/mD4UkoAhRWgLKmZ5u1yA9qUH
         lg+U6jXn4smLlwJEgqLHe/kYB7+haUf92j1woTbQGG0xxbTTY4AW1rAcOxGWh2ynPDs/
         7F1g==
X-Forwarded-Encrypted: i=1; AJvYcCWbmM2T/RUpL731tJpi7RqqqJEOkseVro/TgBSgU/dpZJ5X1aM6y1u5ryYRxfI+DCfsM0IeQ/4VQ0kJceipcokao9MGhwfw1zt5tA7m
X-Gm-Message-State: AOJu0Yx8MqljJehap2yvLc0ZjKy2ZHjHnOsY6Uj6pdR3mdNNHVvCs5Fp
	5A9Z1f4iMsLf8/vL+U8YGr8yhb7epaT4iitg7SdcDINHm2P6cbRq8+BkbEVFzzc=
X-Google-Smtp-Source: AGHT+IE53M3V8Uidqoa3yk8+4qXuwt/bTpN6kGnKnf/lTZX0PwppewDi+ZCmXMrjqzvhU+9ZupI4Sw==
X-Received: by 2002:a2e:9684:0:b0:2ec:403e:631a with SMTP id 38308e7fff4ca-2ec5b36b135mr44323041fa.8.1719313171978;
        Tue, 25 Jun 2024 03:59:31 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3040ee6bsm5730751a12.28.2024.06.25.03.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 03:59:30 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Danilo Krummrich <dakr@redhat.com>
Cc: gregkh@linuxfoundation.org,  rafael@kernel.org,  bhelgaas@google.com,
  ojeda@kernel.org,  alex.gaynor@gmail.com,  wedsonaf@gmail.com,
  boqun.feng@gmail.com,  gary@garyguo.net,  bjorn3_gh@protonmail.com,
  benno.lossin@proton.me,  a.hindborg@samsung.com,  aliceryhl@google.com,
  airlied@gmail.com,  fujita.tomonori@gmail.com,  lina@asahilina.net,
  pstanner@redhat.com,  ajanulgu@redhat.com,  lyude@redhat.com,
  robh@kernel.org,  daniel.almeida@collabora.com,
  rust-for-linux@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 09/10] rust: pci: add basic PCI device / driver
 abstractions
In-Reply-To: <20240618234025.15036-10-dakr@redhat.com> (Danilo Krummrich's
	message of "Wed, 19 Jun 2024 01:39:55 +0200")
References: <20240618234025.15036-1-dakr@redhat.com>
	<20240618234025.15036-10-dakr@redhat.com>
Date: Tue, 25 Jun 2024 12:53:48 +0200
Message-ID: <877cedi98j.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Danilo,

Thanks for working on this. I just finished rebasing the Rust NVMe
driver on these patches, and I have just one observation for now.

Danilo Krummrich <dakr@redhat.com> writes:

[...]

> +pub trait Driver {
> +    /// Data stored on device by driver.
> +    ///
> +    /// Corresponds to the data set or retrieved via the kernel's
> +    /// `pci_{set,get}_drvdata()` functions.
> +    ///
> +    /// Require that `Data` implements `ForeignOwnable`. We guarantee to
> +    /// never move the underlying wrapped data structure.
> +    ///
> +    /// TODO: Use associated_type_defaults once stabilized:
> +    ///
> +    /// `type Data: ForeignOwnable = ();`
> +    type Data: ForeignOwnable;
> +
> +    /// The type holding information about each device id supported by the driver.
> +    ///
> +    /// TODO: Use associated_type_defaults once stabilized:
> +    ///
> +    /// type IdInfo: 'static = ();
> +    type IdInfo: 'static;
> +
> +    /// The table of device ids supported by the driver.
> +    const ID_TABLE: IdTable<'static, DeviceId, Self::IdInfo>;
> +
> +    /// PCI driver probe.
> +    ///
> +    /// Called when a new platform device is added or discovered.
> +    /// Implementers should attempt to initialize the device here.
> +    fn probe(dev: &mut Device, id: Option<&Self::IdInfo>) -> Result<Self::Data>;

Since you changed the `Device` representation to be basically an `ARef`,
the `&mut` makes no sense. I think we should either pass by value or
immutable reference.


Best regards,
Andreas


> +
> +    /// PCI driver remove.
> +    ///
> +    /// Called when a platform device is removed.
> +    /// Implementers should prepare the device for complete removal here.
> +    fn remove(data: &Self::Data);
> +}
> +
> +/// The PCI device representation.
> +///
> +/// A PCI device is based on an always reference counted `device:Device` instance. Cloning a PCI
> +/// device, hence, also increments the base device' reference count.
> +#[derive(Clone)]
> +pub struct Device(ARef<device::Device>);
> +

