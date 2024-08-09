Return-Path: <linux-kernel+bounces-280265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A767694C7DC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 03:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4240C1F23AC7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 01:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C338F49;
	Fri,  9 Aug 2024 01:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lCH1ZerB"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A078801
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 01:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723165405; cv=none; b=awxTb5HF0OH2RIexJWPil2qFuXbEqu9Y7PG1sFgu5DqlHSx/YlElyQqJubZT3j1UpbsaYUUFkkHbEs8OZx72VnFREXmDKtW7jqSzv5Nms1swxCu5Vc5HcqBJsQnhZqt08mOi/astyv0jKrV50SnT7OFMvRHJmogLlXOpIxb9Pac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723165405; c=relaxed/simple;
	bh=vJhVH2X37ELBHuoxXkhWpNap4BFlrkMbHDkfQh6ryrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QRTL0f59UDAkgrRueR72edh1bakworNV7HG4Z/6QaKY7MUA/vk3jSkr7PYZ3Zx1FRHJxJeb1FkgdJ+PFsieU6f9npv7iOwDVZu8H5TFH3TQB5jFH0vyP0U3tKfQaS4n0q57VMFDoXPCwbnzCU27l4meVeeloDGNLkVnaRU/XgK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lCH1ZerB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-427fc9834deso23155e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 18:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723165402; x=1723770202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQvnvDDJliCS6DXZAljXXWbpdOI+Rnw4LC1b+8K9HSQ=;
        b=lCH1ZerBSx3E26+2L/W2I5JYn1aBNpj/+Qk6Gi+OFU1pFZMGkds2mo4eILevby/P66
         aIt01Fk445z6arijwmIOtyzOu+JqD6ppGds5kEozZe22+sEVbn3bJIGIysl1RDUsN+Q3
         7DBzb+RgZu0A7e8j4ztlDTK2X681HSDVQws2rTo1E/GoxzK5pl1d9QVX1RiFqKe5puO5
         d5VN+4Nipey1os2Pv/wplSkRr0RJoenD2WbCnFHbyiIjV1JCDbbRZpYBC8IxLsomD3jv
         GOV2eDw7cTjLMyacsbZ3aGo+p4oJpN/GcHzfb4cidPLGfOxEV81lkttlEKO+wKNEn8qL
         T3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723165402; x=1723770202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQvnvDDJliCS6DXZAljXXWbpdOI+Rnw4LC1b+8K9HSQ=;
        b=ngB62TL2i7breDS4pBebW4ReLOnNH+QyrchIqkQhh8Fna8Tn5cQ1fN1MzMDjMt3GLw
         5g34hcZr+0v3+4at1spULUnLDAOJ3o+xsCtqYD3wFKzfXaSf1MkG0U4crxTgBEshbTNT
         olAAVI7G47suDlu7S0DbALwMiI+0rm330Sgjmcxn6WAV6K6RONARv8lHRJexu4TZU0KU
         mHvgnGK6F3xszzUFv41F2jxNQDM5i5mlo5ldh9PZAT8po8OKmdhio+9BKx0MBvfPUu3g
         YZPi6gR+QGrm77NKowsB1zfLipVNzySWlRzF5UdZrRA6BM3TFMUcYDRCt0gGZVrdW+e1
         CnUg==
X-Forwarded-Encrypted: i=1; AJvYcCWB3lXfSByVY3BVNYVnOPhCReh+wLWRrLJi8CLWVXD21Osxey2oS2KRM76HT7ilN/3RumJipPV+D8ytCYxPGz7rShjeUvK4b4G5Ye1Y
X-Gm-Message-State: AOJu0YwZbqv+xDjMJ//1EI3J1xaJIH2gUbIwDLDvYhMYHQwCpSUmXGaL
	oeSpJlpI1Wnazh5mrzEKzVf1e0ZV3Wk4BwdF1dknA0c0iVS7KtDgir2TMMKSZUO7rABcwivo7yd
	rrdpRVtPPaTAjVGHcTsTUa505k2ENsuQI1EUZ
X-Google-Smtp-Source: AGHT+IHBSqalngtieBRIXl5nEDZR5Pj11uAddRxf8W4HoKGihDUCk65JKJgn8uiV2pn0vs6L/Pvn/vb2mlELKCYPg28=
X-Received: by 2002:a05:600c:1f0a:b0:426:68ce:c97a with SMTP id
 5b1f17b1804b1-429c23553ecmr419855e9.7.1723165400572; Thu, 08 Aug 2024
 18:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807211309.2729719-1-pedro.falcato@gmail.com>
 <20240808161226.b853642c0ecf530b5cef2ecc@linux-foundation.org> <CAKbZUD0_BSv6KOgaRuqjLWGnttzcprcUu5WysSZeX8FXAvui5w@mail.gmail.com>
In-Reply-To: <CAKbZUD0_BSv6KOgaRuqjLWGnttzcprcUu5WysSZeX8FXAvui5w@mail.gmail.com>
From: Jeff Xu <jeffxu@google.com>
Date: Thu, 8 Aug 2024 18:02:42 -0700
Message-ID: <CALmYWFs0v07z5vheDt1h3hD+3--yr6Va0ZuQeaATo+-8MuRJ-g@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm: Optimize mseal checks
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 5:34=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail.c=
om> wrote:
>
> On Fri, Aug 9, 2024 at 12:12=E2=80=AFAM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> >
> > On Wed,  7 Aug 2024 22:13:03 +0100 Pedro Falcato <pedro.falcato@gmail.c=
om> wrote:
> >
> > > This series also depends on (and will eventually very slightly confli=
ct with)
> > > the powerpc series that removes arch_unmap[2].
> >
> > That's awkward.  Please describe the dependency?
>
> One of the transformations done in this patch series (patch 2) assumes
> that arch_unmap either doesn't exist or does nothing.
> PPC is the only architecture with an arch_unmap implementation, and
> through the series I linked they're going to make it work via
> ->close().
>
> What's the easiest way to deal with this? Can the PPC series go
> through the mm tree?
>
This patch can't be merged until arch_unmap() is all removed (ppc change)

Also I'm still doing a test/reviewing for this patch,  perhaps it is
better to wait till my test is done.

Thanks
-Jeff

