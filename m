Return-Path: <linux-kernel+bounces-349814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EC798FBD2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 03:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D201C2204A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 01:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07278C1A;
	Fri,  4 Oct 2024 01:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjK2J1DB"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7596A1862
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 01:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728004258; cv=none; b=LAzvlAE6MNgWmlzK9OsVHyZ/CiGYlx2+gWFGaNBbDXti/trgIrEMHVf98erPssxMld58ykq83r7ir/Wxkte+8T0T2/Og1obe7BKFQleNfG134aqv10J6xSq+0i9StF6w2eDYPfQle5I6AusEAhGEkDgIy9FWLgtMpouyClLc5Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728004258; c=relaxed/simple;
	bh=DKYl+Zd7B7oC7ZrmvuSPytrwkdZZCy16uJdSWNpQYIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myOPQiPyMiKlr4ayrlCv7AmpsLhp1+oLqKhdSC6uARoCuHyiGxeEw60/evjjZm9vHUYzM7kjiSVojPhjBG0nLySyWxhxgcMTK/zlEs1Pj7wRdgrdUuboLrTrzXFujjmDTrwntiIZk7CD3tD4W38V1VfTzE7pXDZTh4SMd5gq01A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjK2J1DB; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4a3b67e719aso634004137.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 18:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728004255; x=1728609055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCX1gRvr7xgcko7ucEWBIV2dt5z8qvy1u1J14nEVaLo=;
        b=kjK2J1DBGxrIMJfBqYHHPPLxOwbNyKAnAR28FL8R+Sv67U0US9AmCJ+V9KUSVAeYdE
         UTYUr9GS5JT9G8m83uVY8Qij96qCVT+ehS9FkhtK3FfWh+F5UnJG2YxkbGXRDlNhHD6q
         Xt2jOuPW9+hpPyAoyONwMa6AV0YHGGi2IM7U4UtZFat/Fd9b2kmMirlFgePxZeU6PlRK
         gFhDNVkSizHcNxc+dk8wTf34aJIYjlif5LQD+eW6Pw3DojhOQ0thmrwnROpEgqSPb3h9
         +OxTKujrwbckZo1Vf2FNbiqEdCN1FNMx3I6DaLjuiVJ5sARcI/b5N7EO/OI5k14+D0OV
         zvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728004255; x=1728609055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCX1gRvr7xgcko7ucEWBIV2dt5z8qvy1u1J14nEVaLo=;
        b=korcglK++lVWm6E2h6hgZsA3c9U0PDdZIjKaD0iuyEsC+Mijd7ebeA2Nj6H1qEwbFZ
         D8QcOSOxhBJyxibt61rFMqqKyYK//dgTUrfxV5bnCqivZ/N1IN09CgDXnTPJWJj+z3pE
         PGEMHhms6PKmjXH+8ZJhzBIw95nlQ2317p4HBVg91o+dgTEZPXs2aUndVeRl8tNGBp5C
         kAnMirnB8sqpGZxfWSwv8ZS0KykJOzxjkHr7e4yIIoiWVeFhPbljQ8j/DhO5w0I29B5r
         ddtH5p9uwMXT6pI3Jv0mo/Jxcus+8fymxL7OTZbclq1657ImclL7OJvUkA0aoP0sKvlN
         OdFw==
X-Forwarded-Encrypted: i=1; AJvYcCUT2T5dR6UVJhAq6bJ/3JlXfmwsyUSnMaGs/S5hU8g1qE21L6xKF55+KSKnlqYebZIu6pDvztqTwQfG208=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvc2f/ptjLfbkWJZiIyfsF3EVjSGSFt1iVDalx5yj8Int/Ib1e
	VW783SVXGVnQzY+Vu5LoFrVas5mmyfdMcWZ7swiosGpdZFZQbpUkXc/WU//CPRltxiy5j//NNEH
	57afijwfz5n/cf/zHQngalCRYgz4=
X-Google-Smtp-Source: AGHT+IFaWK8cjLqmy+brgL9rw0VETzbwyhgClzP1Who58XmUlLZIQHSDuRNkAHxpDBTlvdg1vsTA7xcx4JAg5HnW1GY=
X-Received: by 2002:a05:6102:38cb:b0:4a3:e05e:f6a3 with SMTP id
 ada2fe7eead31-4a405762235mr1317707137.3.1728004255235; Thu, 03 Oct 2024
 18:10:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930055112.344206-1-ying.huang@intel.com> <cf4a3ae4-deae-4224-88e3-308a55492085@redhat.com>
 <8734lgpuoi.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAHbLzkp_SyRBR+JsxMwM_qKpF=8+TU=36hDY6TuKMHdnLnyxAg@mail.gmail.com>
 <66ff297119b92_964f2294c6@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <66ff297119b92_964f2294c6@dwillia2-xfh.jf.intel.com.notmuch>
From: Yang Shi <shy828301@gmail.com>
Date: Thu, 3 Oct 2024 18:10:42 -0700
Message-ID: <CAHbLzkoR1pT1NEL7qAYi+JXOsB7O0FnHyHFOJ+4eZf9vf5K6Wg@mail.gmail.com>
Subject: Re: [PATCH] tdx, memory hotplug: Check whole hot-adding memory range
 for TDX
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>, 
	linux-coco@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 4:32=E2=80=AFPM Dan Williams <dan.j.williams@intel.c=
om> wrote:
>
> Yang Shi wrote:
> > On Mon, Sep 30, 2024 at 4:54=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> > >
> > > Hi, David,
> > >
> > > Thanks a lot for comments!
> > >
> > > David Hildenbrand <david@redhat.com> writes:
> > >
> > > > On 30.09.24 07:51, Huang Ying wrote:
> > > >> On systems with TDX (Trust Domain eXtensions) enabled, memory rang=
es
> > > >> hot-added must be checked for compatibility by TDX.  This is curre=
ntly
> > > >> implemented through memory hotplug notifiers for each memory_block=
.
> > > >> If a memory range which isn't TDX compatible is hot-added, for
> > > >> example, some CXL memory, the command line as follows,
> > > >>    $ echo 1 > /sys/devices/system/node/nodeX/memoryY/online
> > > >> will report something like,
> > > >>    bash: echo: write error: Operation not permitted
> > > >> If pr_debug() is enabled, the error message like below will be sho=
wn
> > > >> in the kernel log,
> > > >>    online_pages [mem 0xXXXXXXXXXX-0xXXXXXXXXXX] failed
> > > >> Both are too general to root cause the problem.  This will confuse
> > > >> users.  One solution is to print some error messages in the TDX me=
mory
> > > >> hotplug notifier.  However, memory hotplug notifiers are called fo=
r
> > > >> each memory block, so this may lead to a large volume of messages =
in
> > > >> the kernel log if a large number of memory blocks are onlined with=
 a
> > > >> script or automatically.  For example, the typical size of memory
> > > >> block is 128MB on x86_64, when online 64GB CXL memory, 512 message=
s
> > > >> will be logged.
> > > >
> > > > ratelimiting would likely help here a lot, but I agree that it is
> > > > suboptimal.
> > > >
> > > >> Therefore, in this patch, the whole hot-adding memory range is
> > > >> checked
> > > >> for TDX compatibility through a newly added architecture specific
> > > >> function (arch_check_hotplug_memory_range()).  If rejected, the me=
mory
> > > >> hot-adding will be aborted with a proper kernel log message.  Whic=
h
> > > >> looks like something as below,
> > > >>    virt/tdx: Reject hot-adding memory range: 0xXXXXXXXX-0xXXXXXXXX
> > > >> for TDX compatibility.
> > > >> > The target use case is to support CXL memory on TDX enabled syst=
ems.
> > > >> If the CXL memory isn't compatible with TDX, the whole CXL memory
> > > >> range hot-adding will be rejected.  While the CXL memory can still=
 be
> > > >> used via devdax interface.
> > > >
> > > > I'm curious, why can that memory be used through devdax but not
> > > > through the buddy? I'm probably missing something important :)
> > >
> > > Because only TDX compatible memory can be used for TDX guest.  The bu=
ddy
> > > is used to allocate memory for TDX guest.  While devdax will not be u=
sed
> > > for that.
> >
> > Sorry for chiming in late. I think CXL also faces the similar problem
> > on the platform with MTE (memory tagging extension on ARM64). AFAIK,
> > we can't have MTE on CXL, so CXL has to stay as dax device if MTE is
> > enabled.
> >
> > We should need a similar mechanism to prevent users from hot-adding
> > CXL memory if MTE is on. But not like TDX I don't think we have a
> > simple way to tell whether the pfn belongs to CXL or not. Please
> > correct me if I'm wrong. I'm wondering whether we can find a more
> > common way to tell memory hotplug to not hot-add some region. For
> > example, a special flag in struct resource. off the top of my head.
> >
> > No solid idea yet, I'm definitely seeking some advice.
>
> Could the ARM version of arch_check_hotplug_memory_range() check if MTE
> is enabled in the CPU and then ask the CXL subsystem if the address range=
 is
> backed by a topology that supports MTE?

Kernel can tell whether MTE is really enabled. For the CXL part, IIUC
that relies on the CXL subsystem is able to tell whether that range
can support MTE or not, right? Or CXL subsystem tells us whether the
range is CXL memory range or not, then we can just refuse MTE for all
CXL regions for now. Does CXL support this now?

>
> However, why would it be ok to access CXL memory without MTE via devdax,
> but not as online page allocator memory?

CXL memory can be onlined as system ram as long as MTE is not enabled.
It just can be used as devdax device if MTE is enabled.

>
> If the goal is to simply deny any and all non-MTE supported CXL region
> from attaching then that could probably be handled as a modification to
> the "cxl_acpi" driver to deny region creation unless it supports
> everything the CPU expects from "memory".

I'm not quite familiar with the details in CXL driver. What did you
mean "deny region creation"? As long as the CXL memory still can be
used as devdax device, it should be fine.

