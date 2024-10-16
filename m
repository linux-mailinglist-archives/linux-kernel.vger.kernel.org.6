Return-Path: <linux-kernel+bounces-368111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE02F9A0B4F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E185C1C228E1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ACD206E66;
	Wed, 16 Oct 2024 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDYNJCeg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12B11D8E1D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729084904; cv=none; b=swtytYovXISzKgO2mjzgXVn5CSYoDPyJFLFJJZQBRQohKA1OsOQnAVIyEdxkoIeYrw1opDIZ2PXfqUd9mrQ7xLHoXoOFCAZUfyfWIgkhLsPDdBQowfe7JbvLlciUUV2B4Ffx3aBqpFz9/pD1jiwkWzv/yfQP/oUry90HzyQFQW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729084904; c=relaxed/simple;
	bh=rUj8Gwg342FS1TKcMCdVbJGB3eQfR/cCHLotI1AQICg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ClL1AWvgIJSIbdigWDUIgGzTuix/AX48f3oge9UueoNPX7tfNKQNLA85GoziKaPnNrgopAWTuukAdYsC4dR8NNpOtyGobN8cZtF/e7YnwI/6hFSHhWwj4vuQmxDN5rNWu08LhBLJ44bK+sch5Ets+Il4wfNCdZ6RxZVFipySI4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MDYNJCeg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729084901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZqaY7QF+tALXuS6sAhZnIZBBqHZXvbBY3wvvmoqrxM=;
	b=MDYNJCegRB+tTdVHxZ17VvNoJ4d19UsigoRWD8JgdVkF3nwgt3/CIZb9CBWkyLEUQdP1SA
	iPxi7+QYCQMt1kFRMriUvfjE8R9q8pIwJKQdly5Q6fzXLrrKU2g/Z4U1f/wkVYfi6ARQUJ
	0I+s6xct1DgD4fXR/XlRyEgqkx96a3M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-ci6KiwysPt6LvDmK-0gymQ-1; Wed, 16 Oct 2024 09:21:40 -0400
X-MC-Unique: ci6KiwysPt6LvDmK-0gymQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d49887a2cso509842f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 06:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729084899; x=1729689699;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cZqaY7QF+tALXuS6sAhZnIZBBqHZXvbBY3wvvmoqrxM=;
        b=ABdiNSyv6ELK69QAAgBB30a/kNzZCwvBrSSrJ9jMcpn2xT7loEueJI4vZFrsYQK0mp
         JaKDWQvWcngaqqWtPYjL/qSvx6GZes6ZurQbKc/xtN4c6ieZ//8skX8EfwvgabbgzQst
         U9T7OXfOeMnqmG5qvwrbgCEppoxPt6qfiuklK9UDkoBBo2qBnXHNKF0//yS3tNLYpvPU
         s4M7Wa6ysXR697Xd/5WvAv5+VLpYff2x63YFvRQjpCTDJuYuQqfl4759FBejrK5f76Ru
         KosR93Vg9fsfesF2dszPBgkRF2YFBLxJg6HnuCmCSFBZ8JtWjvRtChp/eDC8ZloCbMMt
         LAxw==
X-Forwarded-Encrypted: i=1; AJvYcCU++IWL+Kr96VnTXgq+KOu559eDGeF1LiV8EPgqxjATvI68Jcni4NyPxt+31Y2qiNyt/XSkXcNvks0jdos=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGOPeSenYc21IhA1JLzzTwg0LsHs67S4M5yZfNVn5L11oj88OW
	FdFXob20oO2jk3Is0+TzzLyk5f4ec4UU97up0JpHsMuwx6VIItrHD8saDzUaF8LZd3RkvZTMTuV
	dQntYweJWQ2E8DMtWdeLzv6btl0lkZdvRu7pJI/W5Nzs/MfCwYLGzFkwSMeXK/9s/VIQkS7On
X-Received: by 2002:a5d:4603:0:b0:37d:39ff:a9cf with SMTP id ffacd0b85a97d-37d86266138mr3021781f8f.5.1729084899300;
        Wed, 16 Oct 2024 06:21:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvgZxmtzCYA4vi7Un7UeUDYjOsv1/PXUBoFfIYhsnpv94gR+MUgt7A/ZOnYZrAG6OOK+0ycQ==
X-Received: by 2002:a5d:4603:0:b0:37d:39ff:a9cf with SMTP id ffacd0b85a97d-37d86266138mr3021762f8f.5.1729084898858;
        Wed, 16 Oct 2024 06:21:38 -0700 (PDT)
Received: from dhcp-64-113.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f6b1e9esm49252895e9.37.2024.10.16.06.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 06:21:38 -0700 (PDT)
Message-ID: <ac50d7cf2a2071f196552fa4dc4109f9a551c7e7.camel@redhat.com>
Subject: Re: [PATCH 1/1] PCI: Convert pdev_sort_resources() to use resource
 name helper
From: Philipp Stanner <pstanner@redhat.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, LKML
	 <linux-kernel@vger.kernel.org>
Date: Wed, 16 Oct 2024 15:21:37 +0200
In-Reply-To: <fc0649b5-d065-2627-f475-d61f0594d0e5@linux.intel.com>
References: <20241016120048.1355-1-ilpo.jarvinen@linux.intel.com>
	 <1cf314b3e91779e3353bbcaf8ad13516a00642e3.camel@redhat.com>
	 <fc0649b5-d065-2627-f475-d61f0594d0e5@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-16 at 16:15 +0300, Ilpo J=C3=A4rvinen wrote:
> On Wed, 16 Oct 2024, Philipp Stanner wrote:
>=20
> > On Wed, 2024-10-16 at 15:00 +0300, Ilpo J=C3=A4rvinen wrote:
> > > Use pci_resource_name() helper in pdev_sort_resources() to print
> > > resources in user-friendly format.
> > >=20
> > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > > ---
> > > =C2=A0drivers/pci/setup-bus.c | 5 +++--
> > > =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > > index 23082bc0ca37..071c5436b4a5 100644
> > > --- a/drivers/pci/setup-bus.c
> > > +++ b/drivers/pci/setup-bus.c
> > > @@ -134,6 +134,7 @@ static void pdev_sort_resources(struct
> > > pci_dev
> > > *dev, struct list_head *head)
> > > =C2=A0	int i;
> > > =C2=A0
> > > =C2=A0	pci_dev_for_each_resource(dev, r, i) {
> > > +		const char *r_name =3D pci_resource_name(dev, i);
> > > =C2=A0		struct pci_dev_resource *dev_res, *tmp;
> > > =C2=A0		resource_size_t r_align;
> > > =C2=A0		struct list_head *n;
> > > @@ -146,8 +147,8 @@ static void pdev_sort_resources(struct
> > > pci_dev
> > > *dev, struct list_head *head)
> > > =C2=A0
> > > =C2=A0		r_align =3D pci_resource_alignment(dev, r);
> > > =C2=A0		if (!r_align) {
> > > -			pci_warn(dev, "BAR %d: %pR has bogus
> > > alignment\n",
> > > -				 i, r);
> > > +			pci_warn(dev, "%s: %pR has bogus
> > > alignment\n",
> > > +				 r_name, r);
> >=20
> > Why do you remove the BAR index number, don't you think this
> > information is also useful?
>=20
> That's because of how pci_resource_name() works. The number will be=20
> included in the returned string and it won't be always same as i.
> So that change is done on purpose.
>=20
> > One could also consider printing r_align, would that be useful?
>=20
> As per the preceeding condition, it's known to be zero so it's not=20
> that useful for any developer looking at these code lines.

Ah, right. Would it then make sense then to do:

pci_warn(dev, "%s: %pR: Alignment must not be zero.\n", ...);

Would tell then exactly what the problem is. Unless the devs know that
a bogus alignment is definitely always 0.

?

>=20
> > Note
> > that there is a similar pci_warn down below in line 1118 that does
> > print it. Would you want to change that pci_warn()-string, too?
>=20
> pci_warn() on line 1118 does NOT print i (as expected when using=20
> pci_resource_name()) and there align is not zero so I don't see how
> this=20
> is relevant.
>=20
> But thanks for taking a look anyway. :-)

Sure thing

>=20


