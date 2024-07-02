Return-Path: <linux-kernel+bounces-238012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF7E92421E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E597288888
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807861BBBE1;
	Tue,  2 Jul 2024 15:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zA2ZJQEw"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4621E1BB69D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933392; cv=none; b=QSv/uHSbK12MEbeBvCu7OYsxGMoHDnBGyAuD7qh43CkawA3gFRktmROxkeztX5MOE8uOnMM8oY8a4YE1nRCarm5GZxf5QtcUXKgRucxqobHZlr2OJDkccvqHw9PhNecwwB2gJi/hyHvKMrUl2PBJ2l/C4sQ1tH4RNDf1niexrDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933392; c=relaxed/simple;
	bh=sa19PPKQit/6l2WVAcrh2RkbPmxofPvqwrxfkehB9rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WKgb7JyzOKA0HVA8NC17uemNQAdWtPDjpTPQQBmd0in6q+rMDyFDxJmtx4TxmADtaEFSYcMUJuspkytk2di16kNoxxjZgH1v7JaTtSiBnXD4xWp3wVSrv4K6Oi52/JBMZcxiY/TWNg9zJx8kO1TqGY9puMFf61Jwg897TIwrv98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zA2ZJQEw; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-643efaf0786so37075917b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 08:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719933390; x=1720538190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sa19PPKQit/6l2WVAcrh2RkbPmxofPvqwrxfkehB9rs=;
        b=zA2ZJQEwF9DUbIc7PJrlMLkdZahViNZ3gLVyEFSUe7xMGVYutN0hWBsCfs1pjF29ND
         kUtDUxuezq1cJjCRozlf7ekbD0ClItMvk3m6+64jBAeRIh13LCI2YrGub/FxTGuXq/7Y
         w6hYqtBMH+NdVQ+calNX5w0Ab3xwW2y1HWxpxOgYJwYrHHBoweZ4JIXRIGxxPIM7eM3/
         IkrdZt1dMJFYbnnmoCKtgaZ1NpaxRaU6ESqFqA4no2GT1D1tVNwZgvYmVLVoIAEDNruB
         lQpS7K3yVBmriNdF2KCzre2spwukuu3huYPb9AMssCHpHe5sTiNOw66SYX1JRJlhdCEe
         nREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719933390; x=1720538190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sa19PPKQit/6l2WVAcrh2RkbPmxofPvqwrxfkehB9rs=;
        b=lC9+hmqKOYUVwuuI8+KiQexOxOwMjo6hIG8VevxvcIj9u9bIt0CiA9S0SV2W08nCM4
         wjCBgZAvTIOoEceb2btN83iZ+KoFl2fqdftdgz4lBZB0b49jdtipXtgv53U+VBF4Kfu9
         Hdk26imOivI+Ajftm1Hqf3xapjYdsgDoUmi5MQ1var3SkpKo1LTBpYP0SIdltLUzFIPq
         s/te6wPlQODMqXeCmZ1hBan7dSNa8MLwGj2Yl6l+AvH8d7iX/5I3FdW2gLgK1ZHx8FuO
         /HzwasUEyGw6AoABNsWSKs+yUZkdf5IbFGOli6dLOt0pbftQif9LGB/3od0n5WX3L6Kd
         aO2g==
X-Forwarded-Encrypted: i=1; AJvYcCXxDFnFwx2qb4kCgKexmmZhw/IQz/dwpb171omAfEqMxJ6LwGo/WmlRNRZ7BCPUir3/Mqf0Wp/+Z9Pk/O9rHb3JzYzVj5JYvIFq99z2
X-Gm-Message-State: AOJu0YzYb8vYyRf6yaiQ4b3112O9KA+6zlWfyi0VAll17a13LFYC0Uz3
	uQiVGycAiwCbP1V6lsXLwJhrJ6JjLHMU7h3Qkqk2C57WlUKy/HOJgZ41AFhZwbmp7un36vF4WFJ
	VXJub9mdeetBW/uzsDidedhBtBo+mzS/QMySr
X-Google-Smtp-Source: AGHT+IFx6DSHJnJhc4x7w1fofiZ/DpQdbBv1kkUvEbzs7Z3G4JNMTfpmq8uXFoB3KhpwOcT4URKG2MSZNmrwdubCYIE=
X-Received: by 2002:a0d:e682:0:b0:64a:49a4:3e9 with SMTP id
 00721157ae682-64c71aeb4e8mr69774637b3.19.1719933389857; Tue, 02 Jul 2024
 08:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614225951.3845577-1-surenb@google.com> <18a30d5c-abf3-4ceb-a7fd-2edfd8bee2a8@suse.cz>
 <CAJuCfpFPDAjE5aNYxTngxzAusz_9QkOdnELSRNadi2Sxb4O=oA@mail.gmail.com> <bb4214ca-fada-4aa9-af40-008182ea4006@suse.cz>
In-Reply-To: <bb4214ca-fada-4aa9-af40-008182ea4006@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 2 Jul 2024 15:16:18 +0000
Message-ID: <CAJuCfpGr237=zQb58Zd6E-NmpBfvq-6_LQ58nsiwgx9S1KE0pQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/slab: fix 'variable obj_exts set but not used' warning
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 9:31=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 6/30/24 9:20 PM, Suren Baghdasaryan wrote:
> > On Mon, Jun 17, 2024 at 3:04=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>
> >> On 6/15/24 12:59 AM, Suren Baghdasaryan wrote:
> >> > slab_post_alloc_hook() uses prepare_slab_obj_exts_hook() to obtain
> >> > slabobj_ext object. Currently the only user of slabobj_ext object in
> >> > this path is memory allocation profiling, therefore when it's not en=
abled
> >> > this object is not needed. This also generates a warning when compil=
ing
> >> > with CONFIG_MEM_ALLOC_PROFILING=3Dn. Move the code under this config=
uration
> >> > to fix the warning. If more slabobj_ext users appear in the future, =
the
> >> > code will have to be changed back to call prepare_slab_obj_exts_hook=
().
> >> >
> >> > Fixes: 4b8736964640 ("mm/slab: add allocation accounting into slab a=
llocation and free paths")
> >> > Reported-by: kernel test robot <lkp@intel.com>
> >> > Closes: https://lore.kernel.org/oe-kbuild-all/202406150444.F6neSaiy-=
lkp@intel.com/
> >> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >>
> >> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> >>
> >> But it seems to me we could remove the whole #ifdef if current->alloc_=
tag
> >> (which doesn't exist with !MEM_ALLOC_PROFILING) had an access helper, =
or
> >> there was a alloc_tag_add_current() variant?
> >
> > Hmm. I'll check if current->alloc_tag is the only reason for this
> > ifdef. If so then you are correct and we can simplify this code.
>
> The fix is now in mm-hotfixes-stable but we can cleanup for the future as=
 a
> non-hotfix.

Yes, it's on my TODO list now. Thanks!

>

