Return-Path: <linux-kernel+bounces-200029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AAB8FA973
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDDEE1C22CE6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 05:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D5A13D28B;
	Tue,  4 Jun 2024 05:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaSQtCy2"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE2612DD91
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 05:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717477502; cv=none; b=jj3+enfYsIKUcFDJlbYxShkI7608L1xLcf5pkqK/NW1kfPYrX/eSfJHVAdhFYsUWb60iVN8clEidqikmitb8Bdh2oBcmQjqqEMk049qj2s/PAkohbxLvBfk+xlXFpj4e7KVegdKEXH+FbpVeSHkbdve5B8ewnlHft8Z1WUVNvQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717477502; c=relaxed/simple;
	bh=FXVSz+mfrwLNkClogeTTaoNd4iOUsHoex8YaalDkbbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KvCaeuiHuIbb5Q1k2tzHNwfcT6b8X/a9aTbBjDIRwL1Nw44FyTVlc7CLgtjdwPxkbY7uuHCLKYAu/QQtBFb2CilFhy14sWunPczvYJQik0z1WKpW/zcgM/KcMQJI8Qcr5kolNzyIvyjVzEC/R7NsM9jB3KANpMaPMRPMFp1rdAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaSQtCy2; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-df78af3bdbcso742479276.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 22:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717477500; x=1718082300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rdTDs4hgwusMN7HjgrC/GqmSUqafBHHaPPQoRHzBBI=;
        b=KaSQtCy2Z80mBzTAPVOzeWwE8ldr1c/g8HYqVu2q+Ooa1o4Cz0GpDILYzxLY78eF9V
         pcyYe28M17QfAs5pZj/XjGeYmYebSp5hS3WSHeE93jq3luN73NXzanXmQjLUjWaEbgsO
         O6wixN/2l/jISR7+tTS+5F9YMsDtf+aK0fouFOPWuxo5uIf8/+M9i9ayeM5elnzpYwkP
         uIDocMtUaREAR28rdr1CvYHU0Lc6UUDNbAs/8WzfJqIrTFdMyMCLlzGx8HhVudotlQbD
         VUHebM4SRbGCGa2UrzUHiShv8Pa/+x5qYX9DbcYPbvhWRtypEU2qScI2sOXIfnOBPv47
         R/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717477500; x=1718082300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rdTDs4hgwusMN7HjgrC/GqmSUqafBHHaPPQoRHzBBI=;
        b=gYT/6rR8N6YwX4YBuH54KZsImKywgc7nVHm9c+QD2RpUoiODWVdgHVb2D5tG52t1o1
         D7IrOu19/tffxeHkxDW60+CIC5mDlJoSQD4W9lH33IiYZURj7EVS+HIFNETlDi/QBfAL
         asPh6IfJ/2xEYMnFlWnM/KB5yEIcT4tQzSIUfMNxjPUWnsbAvtKR9sjGrobb3AePxl8R
         mof9qQ0hY4sD8YjL//K+lI8GKK8sB0lI0bf9A/6VkAfk2NUibqFBF0Ch4ZYzDD/Dn4cm
         w0KPXeeRgaVEQ2k1lCCMu5PIB4IW+QHjD5VoM6wpwRgO9U6gAA+9pvhWzgqCciPoxmhh
         MMhg==
X-Forwarded-Encrypted: i=1; AJvYcCVuSwatmuMMcfoDrRDMeP0svwGNQstDJxZNUwngd+VKfEINtcVe2vB9hB+96evpyjfpMCfx7zVV9Q/vUAfMkIAno3TsY6zp+LRACL6H
X-Gm-Message-State: AOJu0YwXX+Sfb4bXsvem2ej1GH9UzOd37cjq6xtYKmI04bC1KDCHu4tr
	ijMVWHcpQUeQRb/OLOMWlkTRf4oYeyDx1W12715Mj4qI57/0gFOMES5yO8FJJVuGCN/EiTUBCGx
	HMFWMhN+4ZCzizQAvIFfIhF4d0rM=
X-Google-Smtp-Source: AGHT+IFC73Lv9UOogeJX2P9V3Saoj7ztmD07vUjK+txAz9VraaHiwJNLw/ON4EUQCOmYIyTGwjpcVty3afwCyxXhJTs=
X-Received: by 2002:a05:6902:200d:b0:dfa:4ce6:d7a2 with SMTP id
 3f1490d57ef6-dfab9e6580emr1134766276.6.1717477499721; Mon, 03 Jun 2024
 22:04:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531053704.2009827-1-olvaffe@gmail.com> <ZlmQ3_wcL3cgp4Hb@smile.fi.intel.com>
 <CAPaKu7SsD+X7KAO=3vEYU_7YGM_f+7k1fdC9nEK=-NaJw8oYaA@mail.gmail.com>
 <Zlw1_n20oqchAYxH@smile.fi.intel.com> <783e9d9a-e408-c6f0-9a4b-050e1979b919@linux.intel.com>
In-Reply-To: <783e9d9a-e408-c6f0-9a4b-050e1979b919@linux.intel.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Mon, 3 Jun 2024 22:04:49 -0700
Message-ID: <CAPaKu7R8avTfAZq-V5H6t6AKAGG1kGbdNK019-DQ5sOR=UOo-w@mail.gmail.com>
Subject: Re: [PATCH] kernel/resource: optimize find_next_iomem_res
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, christian.koenig@amd.com, 
	alexander.deucher@amd.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Alison Schofield <alison.schofield@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Baoquan He <bhe@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 12:24=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Sun, 2 Jun 2024, Andy Shevchenko wrote:
>
> > On Fri, May 31, 2024 at 02:31:45PM -0700, Chia-I Wu wrote:
> > > On Fri, May 31, 2024 at 1:57=E2=80=AFAM Andy Shevchenko <
> > > andriy.shevchenko@linux.intel.com> wrote:
> > > > On Thu, May 30, 2024 at 10:36:57PM -0700, Chia-I Wu wrote:
> >
> > ...
> >
> > > > P.S> I'm not so sure about this change. It needs a thoroughly testi=
ng, esp.
> > > > in PCI case. Cc'ing to Ilpo.
> >
> > > What's special about PCI?
> >
> > PCI, due to its nature, may rebuild resources either by shrinking or ex=
panding
> > of the entire subtree after the PCI bridge in question. And this may ha=
ppen at
> > run-time due to hotplug support. But I'm not a deep expert in this area=
, Ilpo
> > knows much more than me.
>
> There is code which clearly tries to do expanding resource but that
> usually fails to work as intended because of a parent resource whose size
> is fixed because it's already assigned.
>
> Some other code might block shrinking too under certain conditions.
>
> This area would need to be reworked in PCI core but it's massive and
> scary looking change.
Given the nature of this change (skip checking against children when
the parent does not match), unless a child resource can exceed its
parent resource, I don't think this change affects correctness.

The walk does not hold the resource lock outside of
find_next_iomem_res().  Updating the tree while the walk is in
progress has always been a bit ill-defined.  The patch does not change
that (but it might change the timing a bit).

I can export __walk_iomem_res_desc() and write some unit tests against
it.  Would that be enough to justify this change?

>
> --
>  i.

