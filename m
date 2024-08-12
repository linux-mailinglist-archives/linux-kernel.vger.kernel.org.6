Return-Path: <linux-kernel+bounces-283863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2382994F9CF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 00:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 567F31C21CE7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6648019A29A;
	Mon, 12 Aug 2024 22:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B3e9Otvq"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37582194AE6
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 22:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723502892; cv=none; b=T6rfPJXPPPoXw9TvUhhJrOEeGyfYuZQ0SbpjaoE+zzGbbdfeFlnFZ/pbH2vhNgmFXE7ZFCYsnd4S4oEdRIQ2I5THihd2oks7msOtqHWbw17Vt/dzEHnu4bJU75JNarCpzQjNSYtHXEVv+/ft+mkHmu33roc2FofUGRSm3GjIYOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723502892; c=relaxed/simple;
	bh=R/SzWoRe45bI0KnM666t5204D4AGqvGVrG5MhvDeytE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BcTtFn5fCsL6Bj39IbJi37PBYSQaLodCHSMsDb62nPMjOjCLATWlKbDl8Kjk8JipxBgTv6YglUZPSHZuzuNwaoW5EudS5d7233iFCRLwA3B4hKBF4U5n8WsonPu2N8Qotho0IuGQVFVWFB0JdDcpjyQIZqUG+0Z6VKG+IOgmX3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B3e9Otvq; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-823227e7572so3592326241.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 15:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723502889; x=1724107689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqzIydDvM83GWgkkK53ycdV9UVExKvfGUU1et7okzOc=;
        b=B3e9Otvq78SRxi+BgJy/5uOGKIfd/5icUnpirWGhMpNBLtqJNk5vTeIZ7E3PAW9Ncg
         Che633g9KTiM7Isd2nG2thFKrs7UClCm2EsPbBkXialfz3H2IvrQv210qzDdpXREthzP
         a8bJc5ySW2rmGIgbZtbxyggCci9geYXE/lRRHC1NX/nUGbmvd3jGJrkZZMiMW/d8gUaM
         3TjutlxR19AZ1e1DHsT4jnvU+zzJjuzENL0daoWRCGyum7RD91WOMjalxwQb5WuPb8ja
         V6ovOHGYww0SyxW7QGpHoBO8qUMeD348gtM6/DsmI96FPVteC2dWMNb6cZj3thDLD/77
         IRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723502889; x=1724107689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqzIydDvM83GWgkkK53ycdV9UVExKvfGUU1et7okzOc=;
        b=wtTpzgwVTfCf/2/YoO1/FKmA+yq8SMupICyiqZ/tuzXDNcoLMf5wGz+Ao+qnN0SHU8
         GLZ8BTGlnfEYxJIV6622FRoR/PNRrV2frC9UMlC+4rKSGPacIluE+/sb9DdZO1no87hZ
         vQwBbwMz2wytvlQSeqmHZaOfC1IWEO7Z3mcFMMSvuzxYSom8hBUGzkAHT/f7PGyvDJ8a
         bFLWFG5rYsoB/PIywu30gC4Y5eXJ4uAFENWtd+38fDt/n1GjiAne/7KKouYS4hH8NpSr
         uXN9un7tylXaeXUiuv3DcZPYD6JJux3uC2wv+p07rwufaOALRsd4zlNjVd4IGXXkGrYS
         O6/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBPqE3lVw3bgvQh5M4ag9nl1+iO7wMwp2HAhzo0DsDUbU48DBOtQPbMtQJ1ioIkp7TbsoP6Ej8vCV5SYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlteD+BL8v1DxyTH1ifuw7DGKrk5B0LFGH6MA6h0KOK7NhaNSt
	xjTy1ABQ/Q6KSg8G3lWu47OxUArSlPIp2YfA4ToL5FwtGWQ6AnWA5GqIhbN4x+7kxd6sQd4mvt5
	krxHO9mP37yGQDtjxtRyN6m8LWlNMQrIm959b
X-Google-Smtp-Source: AGHT+IH1ieRG4WsuTUYg5Y6Zh8hdQ8R2Ck4XKoO4go5pHVzLgtexTSUHK7iSce0042CDI9++0CPCZrUohxRDky7+UQw=
X-Received: by 2002:a05:6102:32c6:b0:492:9e70:ef2b with SMTP id
 ada2fe7eead31-49746d0d86cmr800646137.1.1723502888923; Mon, 12 Aug 2024
 15:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809160909.1023470-1-peterx@redhat.com> <20240809160909.1023470-11-peterx@redhat.com>
 <CAJHvVciF4riGPQBhyBwNeSWHq8m+7Zag7ewEWgLJk=VsaqKNPQ@mail.gmail.com> <ZrpbP9Ow9EcpQtCF@x1n>
In-Reply-To: <ZrpbP9Ow9EcpQtCF@x1n>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Mon, 12 Aug 2024 15:47:29 -0700
Message-ID: <CAJHvVchObsUVW2QFroA8pexyXUgKR178knLoaEacMTL6iLoHNQ@mail.gmail.com>
Subject: Re: [PATCH 10/19] KVM: Use follow_pfnmap API
To: Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Oscar Salvador <osalvador@suse.de>, Jason Gunthorpe <jgg@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org, 
	Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, 
	Alistair Popple <apopple@nvidia.com>, Borislav Petkov <bp@alien8.de>, David Hildenbrand <david@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 11:58=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote=
:
>
> On Fri, Aug 09, 2024 at 10:23:20AM -0700, Axel Rasmussen wrote:
> > On Fri, Aug 9, 2024 at 9:09=E2=80=AFAM Peter Xu <peterx@redhat.com> wro=
te:
> > >
> > > Use the new pfnmap API to allow huge MMIO mappings for VMs.  The rest=
 work
> > > is done perfectly on the other side (host_pfn_mapping_level()).
> >
> > I don't think it has to be done in this series, but a future
> > optimization to consider is having follow_pfnmap just tell the caller
> > about the mapping level directly. It already found this information as
> > part of its walk. I think there's a possibility to simplify KVM /
> > avoid it having to do its own walk again later.
>
> AFAIU pfnmap isn't special in this case, as we do the "walk pgtable twice=
"
> idea also to a generic page here, so probably not directly relevant to th=
is
> patch alone.
>
> But I agree with you, sounds like something we can consider trying.  I
> would be curious on whether the perf difference would be measurable in th=
is
> specific case, though.  I mean, this first walk will heat up all the
> things, so I'd expect the 2nd walk (which is lockless) later be pretty fa=
st
> normally.

Agreed, the main benefit is probably just code simplification.

>
> Thanks,
>
> --
> Peter Xu
>

