Return-Path: <linux-kernel+bounces-228947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DFC9168F7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03763289237
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FEB16C866;
	Tue, 25 Jun 2024 13:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eaCCKF6/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128D015FA8A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719322413; cv=none; b=ZGe19jwXxH81aKeLrpou1whXH9Fa+hTEluto0uBLQJj/+rbMwhqrue3CAmWPPG8WeNbILzA2zMS7K2q/oH9p2rmCnBEhwg/6s1NyFDL+CoEP5fK+TO8VfEa9Vga1Ln62qXRzeWAVu3IdIfq3fLs4Oj5ebVcofeebq/BcD2qYIDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719322413; c=relaxed/simple;
	bh=alSlDhdkiJyvmI6ifHWRuAZIRHQHoXNo6fYGRI5E4GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiNPwnwbUkkJdynM2Z8FYyZeCaEiE9qn2DeHl4ETsy4nw7lN4GIF8y8vsCvg6dLsMFxFwmQ0r7R0mE8rRNA5mIc+l5IYvWUyU4e2sv3g35Gl07NxHXvG7CXL1hyHYYazbLTl2iL13NCvrFM/zZEsRz/tIriSNkBfeG5E24PCRhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eaCCKF6/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719322411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b084P8R3rbMy/BJbC4aMnxh/+d0pYKaHDsv3RMDiIlU=;
	b=eaCCKF6/dS5aVc9kJDB9btDzhYmBxW7D2c9/VwtGjTUj1FPMtoPpr51vgT1ReisFaqgUHL
	E+TOxZncUv6j4wj8hqdlcbt2JJCeZhplp7nULHZHLmH7m8D/ross/oAIPlNP06T3rsTjQl
	z7KjRByQbVImBw4bDEq4sTHXDXt3VF8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-k8AO3SgWMm2m2Rck5Pad4Q-1; Tue, 25 Jun 2024 09:33:29 -0400
X-MC-Unique: k8AO3SgWMm2m2Rck5Pad4Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42196394b72so34008295e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 06:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719322408; x=1719927208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b084P8R3rbMy/BJbC4aMnxh/+d0pYKaHDsv3RMDiIlU=;
        b=Tty3jeA3UpLetHOeYamqxCi9Bo/CzEbSUJNOVi4oZn3/V1/c8jXfG+6UX/MbCJPhUa
         LLeQ3VWvY54c2Gb/4bwyxhmiSsKXOw/arHmPFspxB4jjXEW60EEUUWD3SgZq2ZZDZILk
         8oZawugynqGkrAb1P0j61TPfEzfB0iTQ6FcdxWPCw3lNWRVXZolW0TDkmY7kMusmBDdV
         uleo72+ZUVT8iRIS1DFPvY3f2qcc8dAQ6JHo0d8UfE791bRpOyFNKQfxid+e23AVB0Fp
         9ZB2Ajw46S/ojM1f49/4q86sGtxY4McWe6a+j3d+Ga3HNAmNmOSLxQHyh7zPZmTtBS6f
         d2Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWcN9StstzbmOLXqx08SJleZuNH53S4zb5z8EgfxmYY3F7kSc8fwT1DNsK7cJlVAb12342wXo3As83koJvhAOmZ5tOH+7bMh4GEnuiG
X-Gm-Message-State: AOJu0YzLBtdJX3biiNQ0caB9JOzwc/GmO3KMBLlgF8boZ5Tiz7yH9fNv
	h3idhCFZmqtYkVYy9ww1YAb4qGh1pMifRH0Ub3zJv5r5tw4SmSpASToN+IjmsbB5UojU9PVjMqz
	se9VYbrw/4YwRryLfE1GcA5cJJdnPVmKrxYEJLhruq298wwHKobLkRHpjYhQoaA==
X-Received: by 2002:a05:600c:1c02:b0:424:8dba:4a3b with SMTP id 5b1f17b1804b1-4248dba4ccemr47873215e9.5.1719322408620;
        Tue, 25 Jun 2024 06:33:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFynXqRqFfvBY+TB6vjUjM72qSVhbQKQIMBidJG6T3yjQSVdckLFQEsGIPL+9KksRFnlnNCpA==
X-Received: by 2002:a05:600c:1c02:b0:424:8dba:4a3b with SMTP id 5b1f17b1804b1-4248dba4ccemr47872975e9.5.1719322408175;
        Tue, 25 Jun 2024 06:33:28 -0700 (PDT)
Received: from cassiopeiae ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f9924sm12980580f8f.72.2024.06.25.06.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 06:33:27 -0700 (PDT)
Date: Tue, 25 Jun 2024 15:33:24 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com,
	lina@asahilina.net, pstanner@redhat.com, ajanulgu@redhat.com,
	lyude@redhat.com, robh@kernel.org, daniel.almeida@collabora.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 09/10] rust: pci: add basic PCI device / driver
 abstractions
Message-ID: <ZnrHJKeHLGKqEgH6@cassiopeiae>
References: <20240618234025.15036-1-dakr@redhat.com>
 <20240618234025.15036-10-dakr@redhat.com>
 <877cedi98j.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cedi98j.fsf@metaspace.dk>

On Tue, Jun 25, 2024 at 12:53:48PM +0200, Andreas Hindborg wrote:
> Hi Danilo,
> 
> Thanks for working on this. I just finished rebasing the Rust NVMe
> driver on these patches, and I have just one observation for now.
> 
> Danilo Krummrich <dakr@redhat.com> writes:
> 
> [...]
> 
> > +pub trait Driver {
> > +    /// Data stored on device by driver.
> > +    ///
> > +    /// Corresponds to the data set or retrieved via the kernel's
> > +    /// `pci_{set,get}_drvdata()` functions.
> > +    ///
> > +    /// Require that `Data` implements `ForeignOwnable`. We guarantee to
> > +    /// never move the underlying wrapped data structure.
> > +    ///
> > +    /// TODO: Use associated_type_defaults once stabilized:
> > +    ///
> > +    /// `type Data: ForeignOwnable = ();`
> > +    type Data: ForeignOwnable;
> > +
> > +    /// The type holding information about each device id supported by the driver.
> > +    ///
> > +    /// TODO: Use associated_type_defaults once stabilized:
> > +    ///
> > +    /// type IdInfo: 'static = ();
> > +    type IdInfo: 'static;
> > +
> > +    /// The table of device ids supported by the driver.
> > +    const ID_TABLE: IdTable<'static, DeviceId, Self::IdInfo>;
> > +
> > +    /// PCI driver probe.
> > +    ///
> > +    /// Called when a new platform device is added or discovered.
> > +    /// Implementers should attempt to initialize the device here.
> > +    fn probe(dev: &mut Device, id: Option<&Self::IdInfo>) -> Result<Self::Data>;
> 
> Since you changed the `Device` representation to be basically an `ARef`,
> the `&mut` makes no sense. I think we should either pass by value or
> immutable reference.

Agreed, I think we should just pass it by value.

I also noticed that I need to fix `set_master` and `enable_device_mem` to
require a mutable reference.

> 
> 
> Best regards,
> Andreas
> 
> 
> > +
> > +    /// PCI driver remove.
> > +    ///
> > +    /// Called when a platform device is removed.
> > +    /// Implementers should prepare the device for complete removal here.
> > +    fn remove(data: &Self::Data);
> > +}
> > +
> > +/// The PCI device representation.
> > +///
> > +/// A PCI device is based on an always reference counted `device:Device` instance. Cloning a PCI
> > +/// device, hence, also increments the base device' reference count.
> > +#[derive(Clone)]
> > +pub struct Device(ARef<device::Device>);
> > +
> 


