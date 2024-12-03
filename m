Return-Path: <linux-kernel+bounces-430045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2759E2D80
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85C62B396B5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9EC2036E9;
	Tue,  3 Dec 2024 19:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVMsu4Xo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B411C20125D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733253633; cv=none; b=eCkQppS+YX/odkbzoZU7IiLceNcCQBfbDIOvP/SffqvRKax3EQlCct+16V1EFtSdAtG0dQxJiL2tvRgOl+OFykFJr2qdNzM99oaEW3IycmkDh2+fWO28P/qtPWXjOLMqkhbkSX5ILZ+iKKweko99xUEY1XxLm6z+UUIkZMoPkxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733253633; c=relaxed/simple;
	bh=xmLrAoZYfH1C9qAMCpwXhGPaCxW23fC01rFSUrJArXk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZGqBgbwoMRuPTnoI8hiA6nr19a2PAFe6b68tw8P/wPGDDigP0DSjr1Zl2TRhJ2ebel2tqBbWa7izAEUau8AjZ8KkTsbSPMvJuMxqDA1jK6PwkYHDNIyxRyGxmAo//nH8D65CbynXTiJBEaq2EtfunJsDF57bFCZ4YDyyuylU0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BVMsu4Xo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733253630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MTrbWwo6c0uY9C6iZcF4Of2Z27zcDH0xT1dmnkzM2/Q=;
	b=BVMsu4XoLl709cvXbljXP7+xGiXnFN73twyvxPcUfFzbHbMYcHsleUMRjA3Jf9zRo8uEVs
	o8jeSvHiHxFSjsrJswodvLA0c7rytfr3bRS92CAmSmKi9JQoeMJoH3N5BsCWIzi7ovBbag
	ZbDDFigG5b2VmjTuIs0Ok0ZvJKB1+7c=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-YXfa0CLZMXWh18NMqexlZw-1; Tue, 03 Dec 2024 14:20:26 -0500
X-MC-Unique: YXfa0CLZMXWh18NMqexlZw-1
X-Mimecast-MFC-AGG-ID: YXfa0CLZMXWh18NMqexlZw
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-841a803534fso71084939f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 11:20:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733253626; x=1733858426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MTrbWwo6c0uY9C6iZcF4Of2Z27zcDH0xT1dmnkzM2/Q=;
        b=q2jJx8YtVXU2zPg56JDhVy3ggZPA/CDJWk5Ti8Sj9nqKnAPW8euqt+Id8dnNIY/vej
         qZ0n7t6SkDtyuZiT+UYsN9MRtOcCxw58CeG80KzVythj3u6418vtmoLrhO+QxcP2tR5J
         7dqtdrMOzQ6/hBJPcKLtddfo5WrjPVp2RvRknjuqo25PCjAE8UQEYYwQtuTcAhPWja0z
         OWRp/xwGnRDHFtizHfVlq/pEFSSfLX1jqTC3vMy4cOu7ARDCNz+nBtBprmjEHzakkF7D
         a5F9IiRTcHbEOypcfn7RYdKSPelTx2PJM7csaGqIG7i/otYh11aFg2Fef0euAnUnX45D
         IOqA==
X-Forwarded-Encrypted: i=1; AJvYcCVJVBsBO0eV6vX7LyUoLdtXkJYsq7YOqZeJQ/kXvzeMoP4gHXBdjJnHzZnLfKTxH5JwAubhpUMJ9oBY2c0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvw0YW/U69OyANNzPMdAaWksxMEACfutVVyQGe4m1O2L6mZfoI
	Z4e+qIGWl4AqU7ICSRrktz4sY1pXZsJfmYuFsU6hS1poNYGyccHN9OJd4Kpq7W6yjihRkiXnn3z
	lwU5HewEZ3b23uBu4HFhnzJpe+6lFfaIf73OwCBgY1eEDUDQkZJfcO1B0FWLgTw==
X-Gm-Gg: ASbGncuhdBIoutf3yBtjs1Ho4McoSZhZ+JJ41lvrNmeg6UWpJHzi9X0XMYDy5QT0Ng1
	fff2CVT7Kme+dMuCfxetQH4H9twj5bn7Ue7UfYMRKVLrM5rWrf4dBm3xV/7Y44tUso3kRECFdf0
	B3kcaOcmsXDfHWbHtjwDrDIRPg5z2HAUHIMB9m2hXaCzc3fMeKayirsQysSuZ1xUNcl+xpazqXp
	hWSwEOYW4fdVX9/nuXjpjMsqb8zy7VYQt8L0MJYJ2sgCj4t0Cnukw==
X-Received: by 2002:a05:6602:1588:b0:83a:abd1:6af2 with SMTP id ca18e2360f4ac-8445b7d3fe9mr107439339f.3.1733253625911;
        Tue, 03 Dec 2024 11:20:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdS55JUe4FzmsGSIchjfa8Tf5gGWZeiOfX6lsv54NBFvIWQxWGmKOKqYeAHPiZ9GJxJvIQug==
X-Received: by 2002:a05:6602:1588:b0:83a:abd1:6af2 with SMTP id ca18e2360f4ac-8445b7d3fe9mr107438439f.3.1733253625625;
        Tue, 03 Dec 2024 11:20:25 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e230e5f21esm2722452173.80.2024.12.03.11.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 11:20:25 -0800 (PST)
Date: Tue, 3 Dec 2024 12:20:23 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Mitchell Augustin <mitchell.augustin@canonical.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Subject: Re: drivers/pci: (and/or KVM): Slow PCI initialization during VM
 boot with passthrough of large BAR Nvidia GPUs on DGX H100
Message-ID: <20241203122023.21171712.alex.williamson@redhat.com>
In-Reply-To: <CAHTA-uaGZkQ6rEMcRq6JiZn8v9nZPn80NyucuSTEXuPfy+0ccw@mail.gmail.com>
References: <CAHTA-uYp07FgM6T1OZQKqAdSA5JrZo0ReNEyZgQZub4mDRrV5w@mail.gmail.com>
	<20241126103427.42d21193.alex.williamson@redhat.com>
	<CAHTA-ubXiDePmfgTdPbg144tHmRZR8=2cNshcL5tMkoMXdyn_Q@mail.gmail.com>
	<20241126154145.638dba46.alex.williamson@redhat.com>
	<CAHTA-uZp-bk5HeE7uhsR1frtj9dU+HrXxFZTAVeAwFhPen87wA@mail.gmail.com>
	<20241126170214.5717003f.alex.williamson@redhat.com>
	<CAHTA-uY3pyDLH9-hy1RjOqrRR+OU=Ko6hJ4xWmMTyoLwHhgTOQ@mail.gmail.com>
	<20241127102243.57cddb78.alex.williamson@redhat.com>
	<CAHTA-uaGZkQ6rEMcRq6JiZn8v9nZPn80NyucuSTEXuPfy+0ccw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Dec 2024 13:36:25 -0600
Mitchell Augustin <mitchell.augustin@canonical.com> wrote:

> Thanks!
>=20
> This approach makes sense to me - the only concern I have is that I
> see this restriction in a comment in __pci_read_base():
>=20
> `/* No printks while decoding is disabled! */`
>=20
> At the end of __pci_read_base(), we do have several pci_info() and
> pci_err() calls - so I think we would need to also print that info one
> level up after the new decode enable if we do decide to move decode
> disable/enable one level up. Let me know if you agree, or if there is
> a more straightforward alternative that I am missing.

Nope, I agree.  The console might be the device we've disabled for
sizing or might be downstream of that device.  The logging would need
to be deferred until the device is enabled.  Thanks,

Alex

> On Wed, Nov 27, 2024 at 11:22=E2=80=AFAM Alex Williamson
> <alex.williamson@redhat.com> wrote:
> >
> > On Tue, 26 Nov 2024 19:12:35 -0600
> > Mitchell Augustin <mitchell.augustin@canonical.com> wrote:
> > =20
> > > Thanks for the breakdown!
> > > =20
> > > > That alone calls __pci_read_base() three separate times, each time
> > > > disabling and re-enabling decode on the bridge. [...] So we're
> > > > really being bitten that we toggle decode-enable/memory enable
> > > > around reading each BAR size =20
> > >
> > > That makes sense to me. Is this something that could theoretically be
> > > done in a less redundant way, or is there some functional limitation
> > > that would prevent that or make it inadvisable? (I'm still new to pci
> > > subsystem debugging, so apologies if that's a bit vague.) =20
> >
> > The only requirement is that decode should be disabled while sizing
> > BARs, the fact that we repeat it around each BAR is, I think, just the
> > way the code is structured.  It doesn't take into account that toggling
> > the command register bit is not a trivial operation in a virtualized
> > environment.  IMO we should push the command register manipulation up a
> > layer so that we only toggle it once per device rather than once per
> > BAR.  Thanks,
> >
> > Alex
> > =20
>=20
>=20


