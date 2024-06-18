Return-Path: <linux-kernel+bounces-218822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C42E890C693
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7AD71C21D90
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3163019CCF6;
	Tue, 18 Jun 2024 07:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MrlQNZru"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F025213DBB2
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718697403; cv=none; b=p+fLXhSlDbxPZ4Fqgbg5CC5wUihIm3rZKmWjaWG7QxXFZ711UI5xNXxD25WeHVHLnYcuoLq0l02Sss1YdAvVxLLJALCZ8sgmmmDBrHUzmipgLMsgkFJj3Daahqgo0HzCw65lp+18/3pcnyHYtSlIUkhTMAnogQ/YiJpXHBP6lR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718697403; c=relaxed/simple;
	bh=X7oXfGqsaROPIv0d321bPJMWdfKZBHlFilMIFo4qMew=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pc4SD+H21fncY8MnnLy/fZtXecFiC8dUE3uvuuGFlTebDjf26p49nryArF8cFEiwPCq5MHslJJk6aNLLPA3SEz4uWCYdW+oFHGPdCfol/aZRx+v4F+9UWBKPg+6x7VLojAjdo0Miu8HZtnTVn1fGpul9uBQT6/Np+QqidpXNZwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MrlQNZru; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718697400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X7oXfGqsaROPIv0d321bPJMWdfKZBHlFilMIFo4qMew=;
	b=MrlQNZruF7xHb8vmBvrmi8hEoZ+Y4c+olT+NKe7sCRKOXVz78xqlYe12W6Rv6osHEzRG2K
	La7Pq0LZRWw1axqa5n580rB1i7x3PMtOxc99ZdWfCL7hfTvlNbp11a0ZX4zx42D1ws/qgh
	P75AnIpI9JEPOK31uOTiyGtUtcD3MlE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-M9EicROlM-KHaFzg5ICV_w-1; Tue, 18 Jun 2024 03:56:39 -0400
X-MC-Unique: M9EicROlM-KHaFzg5ICV_w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42180a0730dso5173375e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718697398; x=1719302198;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X7oXfGqsaROPIv0d321bPJMWdfKZBHlFilMIFo4qMew=;
        b=u3PVHE3cm1dbGnVsNKShi4GZt7GDGh7sURdUNinn50aFB2X+qxRctkFPYev+eo0Zba
         3GDRDq+V5uthYdQyLmWLOXbHG5Cl/fFxDZG50QBTpcyddC0xq0goFd4WTCE0rJOKaiRC
         DI5n//rSuk/IXAv0U/WLnGsRNzU6w4e6UC6Pb/wNb7Jid1dwJUb4LOfeLlUTkciC3mOS
         DvtZ5sAaLQNsuQxZIapnoYk1PYE00yTMANUBy0eNPFdrRnLvsOJ49tHd73mbpm5RQTc+
         030BWUMqCt7EEktaNAueuSYqY9duZjgvI2XcQzk9aTssIoyuuEd/k0eowgLcBFuGtCQj
         bX4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUX+2FPBRQz8de+uWWUs5hyuxFEpYYirn+wfwHuwIO07KWFFEgqf+bsgGmwUz1DZATMPZhJgtL3iYt0xvMN38DqV1CMKDpwvYJp2h7L
X-Gm-Message-State: AOJu0Yw09329rDCieeVUjawoI1RDTZK8uADAOFVIOdb0woxWhYo/wgnt
	D1+CEAqPMknj/X9rdsu+mqkyym3eBm7ARA+DZ0ws7VFQmoqX/1P1Ewduv8Yy5KegJVRtkZOgEn5
	81Ocq60c+q/0wiUL7Me8ll+gZ4QMPQgd7Re+6EYqKTN3F2eMlywYa5iBmz9zSuA==
X-Received: by 2002:a05:600c:4fc9:b0:422:2f06:92d1 with SMTP id 5b1f17b1804b1-4230484ea73mr83191025e9.2.1718697398460;
        Tue, 18 Jun 2024 00:56:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElQg2MnML4c3e9aZwFA6IJ+FN0+5pNCUzrjPBudpNMYeXrjO8WNPBPXb35SYsoR8Fe93j85g==
X-Received: by 2002:a05:600c:4fc9:b0:422:2f06:92d1 with SMTP id 5b1f17b1804b1-4230484ea73mr83190795e9.2.1718697398070;
        Tue, 18 Jun 2024 00:56:38 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f602e802sm181674215e9.11.2024.06.18.00.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 00:56:37 -0700 (PDT)
Message-ID: <0d9fe3d3c52fa618b6c4e1d3414373b2e5417f32.camel@redhat.com>
Subject: Re: [PATCH v9 10/13] PCI: Give pci_intx() its own devres callback
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede
 <hdegoede@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, Sam
 Ravnborg <sam@ravnborg.org>,  dakr@redhat.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org
Date: Tue, 18 Jun 2024 09:56:36 +0200
In-Reply-To: <20240617164604.GA1217529@bhelgaas>
References: <20240617164604.GA1217529@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-17 at 11:46 -0500, Bjorn Helgaas wrote:
> On Mon, Jun 17, 2024 at 10:21:10AM +0200, Philipp Stanner wrote:
> > On Fri, 2024-06-14 at 11:14 -0500, Bjorn Helgaas wrote:
> > > On Fri, Jun 14, 2024 at 10:09:46AM +0200, Philipp Stanner wrote:
> > ...
>=20
> > > > Apparently INTx is "old IRQ management" and should be done
> > > > through
> > > > pci_alloc_irq_vectors() nowadays.
> > >=20
> > > Do we have pcim_ support for pci_alloc_irq_vectors()?
> >=20
> > Nope.
>=20
> Should we?=C2=A0 Or is IRQ support not amenable to devm?

I don't see why it wouldn't work, AFAIU you just register a callback
that deregisters the interrupts again.

This series here, though, stems from me trying to clean up drivers in
DRM. That's when I discovered that regions / IO-mappings (which I need)
are broken.

Adding further stuff to pci/devres.c is no problem at all and
independent from this series; one just has to add the code and call the
appropriate devm_ functions.

>=20
> Happened to see this new driver:
> https://lore.kernel.org/all/20240617100359.2550541-3-Basavaraj.Natikar@am=
d.com/
> that uses devm and the only PCI-related part of .remove() is cleaning
> up the IRQs.
>=20

OK. They also use pcim_iomap_table() and stuff. I think we should
inform about the deprecation.

I don't have a user for IRQ at hand for my DRM work right now. I'd try
to upstream new infrastructure we need there as I did for vboxvideo.


Gr=C3=BC=C3=9Fe,
P.


