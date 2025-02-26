Return-Path: <linux-kernel+bounces-535139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D492CA46F74
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE62F3A6415
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6E126036E;
	Wed, 26 Feb 2025 23:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ga78yzGi"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B72260366
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 23:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740612560; cv=none; b=HmRgUCja9ZTKMbpdvGpX8lIZjpDRHCUrAsH1pVPVDElFLipbewoiWsaE4YJgUQIY7TIALN9pU72/JUIZ6+9KDEdBY5Dxen2IVSeX3rsdgZIj2Je6Cqu3vPGEN+0oOlpEAgCbMl9wOZ7VGiKD2Mtr/Dfjh5rtiE3ECqEmSrXBr9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740612560; c=relaxed/simple;
	bh=J/dQk4SZYN5ePkzsS3cMgdnGZmrR3Q/tY6oGbPoub5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snJhh3Dd9xgv0Jnh9j/bnRUezIFeLGmG0z8l9PXu+klJrPFUj7e0D8n4xNpMhYGn4IQLWmQe0N6I5thh/WOQ07DgxbaheoDGeo4hAQmH0mhgQ27fN1BrJPb1sApxZnQHUJMxkXMZhp1RriGo/oQvtN0n7j0Ne+wsygi5SBsKa8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ga78yzGi; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e893a8d2c3so2067806d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740612557; x=1741217357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/dQk4SZYN5ePkzsS3cMgdnGZmrR3Q/tY6oGbPoub5w=;
        b=ga78yzGi1LQpBam2GPUts4AZ75jmXutUVeadXnWpM0KPx9wBSQt0dKXE0Bnc7o2f7G
         mG098bBp3wARkQiwpXnV9/Zjtxm+CJ/9uCQrtmMGhur5ZHtrj74MfWzhpkKEGMopoTSa
         VLMy4dqcO6RfI3DEugHM++UOLZh++ICIgyMZpKHd7sRsdhkqe6sVlsyxQnRM7gkDQNTd
         DY44TnPwzkWKFZJWDb6+Y0sJJpmNgR6+06OLY2268/AyrLQZI2LYMVwWqCuyhgbeNatw
         XKLaNRjz1kl2RWpWyBbQNc7O1R2IeLA85EVdrthOaQMOf1WrkK92fG9N2qKxczMaz0s8
         DrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740612557; x=1741217357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J/dQk4SZYN5ePkzsS3cMgdnGZmrR3Q/tY6oGbPoub5w=;
        b=rdf7GFHUnssuLQtiybe+vk3nQPntmA0v9W0CPvw3lQKiyzZJkbo2aPtbia6h11/O0s
         m3D8d/Aw7VeEh9jwdUHqy7cwgrUzPKIsXkP4oLWa4RyrJ7LgmQS5hFKXRB65uaUdEO2L
         hwk9LjDhzF3bQStZzeFyxD8YGe8xHDscGWTLZhOP3ElBDSWDa+SIlVfsnNyAnHLxTpW2
         GNtWsQw1U265j8RKcCm2oopAYf1TnbnOGzfu/piHcgcytEhxNQDK/70dhhtb8bxHAqHX
         NoP65cwHegsPCM4riX1pGpWDcUVH19MTjwUgOE0sPcUldaOSc3wQC7pcOekRzum77Pe+
         CtIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDkbKR9mSBCFbNXpYn7DgG9KIF04DIgKPsUOWVr9g4izKOUwK/3evIs6GbeqHKC4aTG67AfEmnMvGGrYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYTA80b5AzZ0Amf7ORv7iIC9ucTnVPL0JaEq+IKONe+tje8B4/
	2b01Ily343FEpeDtzhu0nYPmE+vKWWlk7BAagcG/ijaq6s9ESG33nst/0y5BKm4bio07pIJeRc1
	CzyXLq8BzdbkdGhHeJNC+HaSoEoc=
X-Gm-Gg: ASbGncskE8uC9FwF+ULe1eNoktPSqE9IlsBNhR+SKWgWCDOX0hhEAuVLXwbB9NLb23H
	zH4UQIBrIFIbD2xtC8aBbnV+QkH+nsn7wXqn57Edx539q6WaGNE7saQseNmjVOPZWp/WqVwNrll
	v1gBNgc5xvGwtgPIHVFKecj6w=
X-Google-Smtp-Source: AGHT+IEK2N3gE/8VfY/AR0Y6ytUjwbGPgl9rer6rSlGeqvaTDUu0JLII+3SkCTDMI092dXsoJ6jINsLMcK/3wYhwkCk=
X-Received: by 2002:a05:6214:c88:b0:6e1:5076:c400 with SMTP id
 6a1803df08f44-6e886902ec2mr59807596d6.39.1740612557602; Wed, 26 Feb 2025
 15:29:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225213200.729056-1-nphamcs@gmail.com> <Z76Go1VGw272joly@google.com>
In-Reply-To: <Z76Go1VGw272joly@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 26 Feb 2025 15:29:06 -0800
X-Gm-Features: AQ5f1Jo8WiMfrrcbDj1XSStbJugMrvbOacaXonziWyPRA4RnosYcazj9rzgd2kU
Message-ID: <CAKEwX=O+27wN5p_j5REfnEsfVi4zsgvyowdhGUKQseo9g1GtLg@mail.gmail.com>
Subject: Re: [PATCH] zswap: do not crash the kernel on decompression failure
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, chengming.zhou@linux.dev, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 7:12=E2=80=AFPM Yosry Ahmed <yosry.ahmed@linux.dev>=
 wrote:
>
> On Tue, Feb 25, 2025 at 01:32:00PM -0800, Nhat Pham wrote:
> > Currently, we crash the kernel when a decompression failure occurs in
> > zswap (either because of memory corruption, or a bug in the compression
> > algorithm). This is overkill. We should only SIGBUS the unfortunate
> > process asking for the zswap entry on zswap load, and skip the corrupte=
d
> > entry in zswap writeback.
>
> Some relevant observations/questions, but not really actionable for this
> patch, perhaps some future work, or more likely some incoherent
> illogical thoughts :
>
> (1) It seems like not making the folio uptodate will cause shmem faults
> to mark the swap entry as hwpoisoned, but I don't see similar handling
> for do_swap_page(). So it seems like even if we SIGBUS the process,
> other processes mapping the same page could follow in the same
> footsteps.

poisoned, I think? It's the weird SWP_PTE_MARKER thing.

[...]

>
>
> (3) If we run into a decompression failure, should we free the
> underlying memory from zsmalloc? I don't know. On one hand if we free it
> zsmalloc may start using it for more compressed objects. OTOH, I don't
> think proper hwpoison handling will kick in until the page is freed.
> Maybe we should tell zsmalloc to drop this page entirely and mark
> objects within it as invalid? Probably not worth the hassle but
> something to think about.

This might be a fun follow up :) I guess my question is - is there a
chance that we might recover in the future?

For example, can memory (hardware) failure somehow recover, or the
decompression algorithm somehow fix itself? I suppose not?

If that is the case, one thing we can do is just free the zsmalloc
slot, then mark the zswap entry as corrupted somehow. We can even
invalidate the zswap entry altogether, and install a (shared)
ZSWAP_CORRUPT_ENTRY. Future readers can check for this and exit if
they encounter a corrupted entry?

It's not common enough (lol hopefully) for me to optimize right away,
but I can get on with it if there are actual data of this happening
IRL/in product :)ion

