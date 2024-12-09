Return-Path: <linux-kernel+bounces-437861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3F49E99A8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A754A1665BD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DC61BEF71;
	Mon,  9 Dec 2024 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kK39EmzR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B87E1B042A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756197; cv=none; b=WLattnsChJzk64BV0DV4H+Bj6oLJlOQOQPbOGrmPiOiopuq9vWaDxSdgJdnu9d1CXyTVqqss8pvt7CPycW2mLVOz/9H7K340kEuiylEqVXaHHoUL5j0dRBaWdBDOSnYh++qTuT71+mBlXeOs2MJRthLc3F0AG6qfaWhXYCUO2NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756197; c=relaxed/simple;
	bh=M821XkMANGnBdOvsES314MxDQe7jNUJxNR/3OnCtFkY=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=NoYDzTZa1c8liHMiXGBpIc7a3f3VXZ8N+wxyVTKcw4RppYprC4u2bLiTHX6NhSKZLWx5ggpmqVxHNHp+7hKvqJkKNStY60slQLZcvbqFr8/2qzvfPPkR7dmxoDCTXH8hnHNYAaW/JEUsmvB7KIwVNhiVCkvGR0HUMcS0nQkQyYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kK39EmzR; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733756195; x=1765292195;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:subject:from:cc:to:date:message-id;
  bh=M821XkMANGnBdOvsES314MxDQe7jNUJxNR/3OnCtFkY=;
  b=kK39EmzRKFAFfCTq+jEqMxlE/aRBcpWwZI70c5oXvx0jeVcmNZJpGAqo
   Q/MCSU4xb+hDgEeCDeQ7Q5NvWt/nxODC20Eybjb+UO2M+jfCXhANApSxQ
   nJCjNhwKmehpScCb6+wc7WojNmG2X54tBfOdpCVfH9Ivy7kS2+FBkEi0R
   IONTkYBKFnAOJsez6qb+C8zxPfAO6otypnwDrn8gfb69u+GhTuUgOtRo2
   FKtTt0SU5D0Ti9NTIzoOa52H+VpasgIkh/aE0cQ8u0AiqECfETR+o1nSR
   oa460LCnYLlq/VF/udXpU9sIJQk9rEyGEGTji7Gv1EVH6n3XPYcZGcCKt
   g==;
X-CSE-ConnectionGUID: ZerGAZDIS4iTAn0FL9wtCA==
X-CSE-MsgGUID: hLVtaiNLQ+Wb+RnoqIOmQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="33400348"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="33400348"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 06:56:35 -0800
X-CSE-ConnectionGUID: Q0zMiV15TV2gVhc8JYz50w==
X-CSE-MsgGUID: /uSc00CUQ5iCx4fLum23xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="99153215"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.68])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 06:56:32 -0800
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ec42fe8b-9be0-41cc-96f4-f1869c6bb7e6@amd.com>
References: <20241209133318.1806472-1-mika.kuoppala@linux.intel.com> <20241209133318.1806472-15-mika.kuoppala@linux.intel.com> <ec42fe8b-9be0-41cc-96f4-f1869c6bb7e6@amd.com>
Subject: Re: [PATCH 14/26] drm/xe/eudebug: implement userptr_vma access
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, Andrzej Hajda <andrzej.hajda@intel.com>, Maciej Patelczyk <maciej.patelczyk@intel.com>, Jonathan Cavitt <jonathan.cavitt@intel.com>, Thomas Hellstrom <thomas.hellstrom@linux.intel.com>, Matthew Brost <matthew.brost@intel.com>
To: Christian =?utf-8?q?K=C3=B6nig?= <christian.koenig@amd.com>, Linux MM <linux-mm@kvack.org>, Mika Kuoppala <mika.kuoppala@linux.intel.com>, intel-xe@lists.freedesktop.org, lkml <linux-kernel@vger.kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Date: Mon, 09 Dec 2024 16:56:28 +0200
Message-ID: <173375618882.78106.6396051881160152426@jlahtine-mobl.ger.corp.intel.com>
User-Agent: alot/0.10

(+ Thomas and Matt B who this was reviewed with as a concept)

Quoting Christian K=C3=B6nig (2024-12-09 16:03:04)
> Am 09.12.24 um 14:33 schrieb Mika Kuoppala:

<SNIP>

> > +int xe_vm_userptr_access(struct xe_userptr_vma *uvma, u64 offset,
> > +                      void *buf, u64 len, bool write)
> > +{
> > +     struct xe_vm *vm =3D xe_vma_vm(&uvma->vma);
> > +     struct xe_userptr *up =3D &uvma->userptr;
> > +     struct xe_res_cursor cur =3D {};
> > +     int cur_len, ret =3D 0;
> > +
> > +     while (true) {
> > +             down_read(&vm->userptr.notifier_lock);
> > +             if (!xe_vma_userptr_check_repin(uvma))
> > +                     break;
> > +
> > +             spin_lock(&vm->userptr.invalidated_lock);
> > +             list_del_init(&uvma->userptr.invalidate_link);
> > +             spin_unlock(&vm->userptr.invalidated_lock);
> > +
> > +             up_read(&vm->userptr.notifier_lock);
> > +             ret =3D xe_vma_userptr_pin_pages(uvma);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     if (!up->sg) {
> > +             ret =3D -EINVAL;
> > +             goto out_unlock_notifier;
> > +     }
> > +
> > +     for (xe_res_first_sg_system(up->sg, offset, len, &cur); cur.remai=
ning;
> > +          xe_res_next(&cur, cur_len)) {
> > +             void *ptr =3D kmap_local_page(sg_page(cur.sgl)) + cur.sta=
rt;
>=20
> The interface basically creates a side channel to access userptrs in the =

> way an userspace application would do without actually going through=20
> userspace.

That's not quite the case here.

The whole point of the debugger ability to access memory is to access
any VMA in the GPU VM emulating as much as possible like the EUs themselves
would do the access.

As mentioned in the other threads, that also involves special cache flushes
to make sure the contents has been flushed in and out of the EU caches in c=
ase
we're modifying instruction code for breakpoints as an example.

What the memory access function should do is to establish a temporary
pinning situation where the memory would be accessible just like it would
be for a short batchbuffer, but without interfering with the command stream=
ers.

If this should be established in a different way from this patch, then
we should adapt of course.

> That is generally not something a device driver should ever do as far as =

> I can see.

Given above explanation, does it make more sense? For debugging
purposes, we try to emulate the EU threads themselves accessing the
memory, not the userspace at all.

Regards, Joonas

