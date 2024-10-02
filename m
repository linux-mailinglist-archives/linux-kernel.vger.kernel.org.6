Return-Path: <linux-kernel+bounces-347869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE1698DFB8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD40F286433
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03F81D0F7A;
	Wed,  2 Oct 2024 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IvPwEWE5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843B31D0F73
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884001; cv=none; b=dAGhBmvrTcqoTiJbjmKaIBdtZKC7pss5/x9zZxTA9vL06qPLCyrvjsDTJowGBiHvElza4U5oz4S3k81L4yrKrmETDvDSPz0e/YXK/bFc5VmYlXbQXeaUTY1251sC/YUE586SSgmGrSvuQMTjUFJKOYWn+kl1/X9L67EJnBI4Z5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884001; c=relaxed/simple;
	bh=PovutO70/7yS0CdCYqAhhAMP7m7pVc3xx+bTqCgjUFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjbszh14CQBn1dUV3kn/XNAsuLQG3LfR+79nD0zJiHnxuSoci7S6qA4wgr5n6CDKZUiYx2L2+3Wq3R5pnw4GVXfootIkQQnZ03R8gksMcS5J2+6oVvOY40tgfz+6QMQBGwW5pe/eGbEkoEyYavozY38h5CmOk4vCIO/JTYUoK2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IvPwEWE5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727883998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vP9GlQIfYORSZI5Is17sfvk9DUDB6lv1VsEsk5XjhH4=;
	b=IvPwEWE5PFV4XOtg8ObU4JMC1Kg+3iw6beST8FMgY2VwDiszuobTeiKZVcZPvX88Lt79VP
	8Bl4d3yUMicfgd1LUB3ZVSm0L29SGI8XPQMXXar3FHbKB4cfarkRa48Iw26pv1hDSuWXTU
	+1wgkqlbRi+keaUx9HrA7xqXQmhqBo4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-0AifhwxiOVK3JbqMlernbw-1; Wed, 02 Oct 2024 11:46:35 -0400
X-MC-Unique: 0AifhwxiOVK3JbqMlernbw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-458657ce53aso115517891cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 08:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727883995; x=1728488795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vP9GlQIfYORSZI5Is17sfvk9DUDB6lv1VsEsk5XjhH4=;
        b=PA/ji6clYLnmVcy9TMd1aYTVMnxqw5H8cZCGkK+5evO9qKfZZV5WUOfrabUrSkCsqN
         EOk2NDG+oFiiWwiTggYUFkbSrNoXuY/y5Fyi5NiezwqwHGJ6Blf2s+ZkmzCMVmQCjRTJ
         obQhz00scsVwjMHHiaOrnc6/w2DFe3A0zZoBymIcxMhTsXtCymXEflVz13ez/Ta+nyhu
         4TPakHUfyvUN6vPNaayEdPmBNGk8CiwK8H9XC1dMFo0P1finMq7JjaN50gpU/sMFOumO
         eF1L5U5761yTQX+ZL0HnqdhJpuiZWJU/D4YQfeXUWYZBA6rml2ft3CqOgZueNreWxVuN
         sDHA==
X-Forwarded-Encrypted: i=1; AJvYcCX4CJAPzZgXhgsr7YGgbdVZBmHAnLcK+ce2y+g838w8KWuWpSXT5R4R857Uez2Lh2wutRNju1jPKq6v0y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVgK7WwrsgcWuH50QkxJnp3osCOwM1ni+22wKzxa0aBIvAURzK
	jkZ6YjyM3Y83G4u9dvQrHioh6gGIJizW04caTN0ycwgymxGO25AYBJqnowM+enhEGpEsfUNUVHJ
	y4pdOZ7BKIDBdppukj1hznL18Ze6BPxT7s/bUgjjDQy3BBPF3labFPYBEzT2BQA==
X-Received: by 2002:a05:622a:5c7:b0:45d:797b:b780 with SMTP id d75a77b69052e-45d80492e13mr44140831cf.11.1727883994777;
        Wed, 02 Oct 2024 08:46:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdgiO0qZWdEv0SRcqJWln00zHqXFqFkLhb/OqdhhQaGuGxpQZhZaPZDw7D+1YP6n9KNRiDEw==
X-Received: by 2002:a05:622a:5c7:b0:45d:797b:b780 with SMTP id d75a77b69052e-45d80492e13mr44140591cf.11.1727883994377;
        Wed, 02 Oct 2024 08:46:34 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f3394aasm57106251cf.64.2024.10.02.08.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 08:46:33 -0700 (PDT)
Date: Wed, 2 Oct 2024 11:46:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>, linux-kernel@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 3/5] acpi/generic_event_device: Update GHES migration
 to cover hest addr
Message-ID: <Zv1q141LZt59SDSM@x1n>
References: <cover.1727782588.git.mchehab+huawei@kernel.org>
 <d29cdf2bbb67c660142841c2d854db280c18e5e0.1727782588.git.mchehab+huawei@kernel.org>
 <20241002171543.703ab6e1@imammedo.users.ipa.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241002171543.703ab6e1@imammedo.users.ipa.redhat.com>

On Wed, Oct 02, 2024 at 05:15:43PM +0200, Igor Mammedov wrote:
> On Tue,  1 Oct 2024 13:42:48 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > The GHES migration logic at GED should now support HEST table
> > location too.
> > 
> > Increase migration version and change needed to check for both
> > ghes_addr_le and hest_addr_le.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> other than minor issues below, lgtm
> 
> > ---
> >  hw/acpi/generic_event_device.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> > diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> > index d4dbfb45e181..49ca1fb8e84a 100644
> > --- a/hw/acpi/generic_event_device.c
> > +++ b/hw/acpi/generic_event_device.c
> > @@ -369,6 +369,34 @@ static const VMStateDescription vmstate_ghes_state = {
> >      }
> >  };
> >  
> > +static const VMStateDescription vmstate_hest = {
> > +    .name = "acpi-ghes",
> duplicate name for section, we use that already for hw_error address
> I don't know ramification of (CCIng Peter)

Currently the existing vmstate_ghes is embeded inside vmstate_ghes_state,
so maybe.. it's ok, as I remember QEMU only registers top level vmsds (via
vmstate_register_with_alias_id()).

We do have a sanity check in savevm_state_handler_insert() making sure no
duplicated entry will co-exist since commit caa91b3c44cd.

> 
> Perhaps
> s/ghes/hest/

Said that, perhaps it'll still be nice to try avoiding same names indeed if
possible, at least it could make debugging / reading easier sometimes.

> 
> 
> 
> > +    .version_id = 1,
> > +    .minimum_version_id = 1,
> > +    .fields = (const VMStateField[]) {
> > +        VMSTATE_UINT64(hest_addr_le, AcpiGhesState),
> > +        VMSTATE_END_OF_LIST()
> > +    },
> > +};
> > +
> > +static bool hest_needed(void *opaque)
> > +{
> > +    AcpiGedState *s = opaque;
> > +    return s->ghes_state.hest_addr_le;
> > +}
> > +
> > +static const VMStateDescription vmstate_hest_state = {
> > +    .name = "acpi-ged/ghes",
> 
> ditto
> 
> > +    .version_id = 1,
> > +    .minimum_version_id = 1,
> > +    .needed = hest_needed,
> > +    .fields = (const VMStateField[]) {
> > +        VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,
> > +                       vmstate_hest, AcpiGhesState),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> >  static const VMStateDescription vmstate_acpi_ged = {
> >      .name = "acpi-ged",
> >      .version_id = 1,
> > @@ -380,6 +408,7 @@ static const VMStateDescription vmstate_acpi_ged = {
> >      .subsections = (const VMStateDescription * const []) {
> >          &vmstate_memhp_state,
> >          &vmstate_ghes_state,
> > +        &vmstate_hest_state,
> >          NULL
> >      }
> >  };
> 

-- 
Peter Xu


