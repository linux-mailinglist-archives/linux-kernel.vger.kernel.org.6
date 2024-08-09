Return-Path: <linux-kernel+bounces-280247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EBB94C7A3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 02:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0041C21F2C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 00:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFCE2F2A;
	Fri,  9 Aug 2024 00:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IK8wrlvT"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0151FB4
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 00:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723163694; cv=none; b=OIztXiEn+eeQgmDnXMMGA3PBXpGLrJ++mCkpjU7fWH5DrbsuNH3gQ6t/8t72wUgBPNtYfSwvdXYrRfiXjVcSc4n3VA4b/HksMsz//GxbCXvDlVqEWF/eSK+AY54AZcVeSXcyGDGbuQS7ofWxvFjPKTDTsBH5uCNvoCiGD0u3XsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723163694; c=relaxed/simple;
	bh=luzDOqqJeG0jQf8m7TdGHfyb+dY6lJfgpnAxl/BB114=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5gtx1NBN5vVuAWdEUPbgZ0coakZhC4yh+EgwWyQLuFGh2wVi3qqfdU5DJOE6Vv1EGKaR9o/U1QMnRMkg2YwuaPPPFYmCvtvRcdmOhjppvuuOQrKkShuVPl5Pt5h+8ISdx4iMG+UgXJ4u3x1ZR3Keub7oujJuGEnD5v5Xz0s/Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IK8wrlvT; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52f0277daa5so2116302e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 17:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723163691; x=1723768491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2ogeVtQlhT9WeNRGJxT4wbvVR02faBqDKyUFif3ow8=;
        b=IK8wrlvT6sSTEd4XZ2EmkayGF/eC9qwACQpmmWkjo9GVOs1QBFkT1mYSMysYnP4tiR
         MCLzuVXvphb1N0K6as0sA2lQMel61Z2RZ+mU0F7vhJRDrItrml5q1Hvf/bHb1jn0mydP
         JLzdI9DI9iVprRrLK7cbv6OKJEBv2qK9JrDqybECXsN4VfuSZYr64Ye9Dgnjwma+8z6K
         QIUGPwlMvGDWGRNGaN+PqFfH3jpR2qDH2I/Y0SU8SGKhyQ3YSFo/btGqDnLzXcepvk4s
         wu890faH79vR2f+VCGxwHhLOhAyGp5fzYEUN3gL919BffLDZ7/a08FcBWS/gWyshIVA8
         2E1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723163691; x=1723768491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2ogeVtQlhT9WeNRGJxT4wbvVR02faBqDKyUFif3ow8=;
        b=doG8J5Vyo5BBn5O4ylbT+TqOkrT5di2slVlKEd/3NsZumEiPHimokQ6ofwY+mRXZEF
         bn9nJB+N2ixsNVZed712brDQpQX05I99Sgs8AFKyADid3s2n73Rh2b+yDDULnOH2mkeu
         D1h60CNYg26kA8DAKQuypbRTT5Bq93+5d289yMhUndAz6T9hzW9uuYFca/6y2ahghQGV
         HRXYrYwFurcyU8U++CascHrVVV7A8Ybv3MohJmDwvUCUxhQ8E3dW2CCa/jPQBULFo/Jy
         iJFzjy94VswHcdkUprecpGPLHc2OKonsFHi2q6JeK4/wOYn7EbEyiAPHgRQQcpw8a0Uj
         0l8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGudVqnLuv/gH4U9wmHp2Nfl+AaF04qevBcXZj1qsdXS10KUYissWQ+GwMUuqpgSdVD38t7OE2Ro5+Pokscpcv/X8EgWambOSvylql
X-Gm-Message-State: AOJu0YxL8WOz+ZBsaq1u3y24gC91SHI/ZG1LWEWkpmNdtjTuLcDHOq2m
	rAr+7jleEWM/vXzGEU6aog5eIcfHip7JqXxnH9bxuoSDvCv0AjvzC/LRZCagpLqASJWL6xTvNNM
	HYbhLJoHvv0IZU4ntUlbslmlvMMw=
X-Google-Smtp-Source: AGHT+IG+OWgt/JTOtOb6ay7w4NdI2CbhkenmUHF2ZQ06qsxXIecrYLwxxxllL5pII5mW13MB0mj/Op2MbKpPOcTDGF8=
X-Received: by 2002:a05:6512:3b21:b0:530:b871:eb9a with SMTP id
 2adb3069b0e04-530e58764damr2528461e87.47.1723163690149; Thu, 08 Aug 2024
 17:34:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807211309.2729719-1-pedro.falcato@gmail.com> <20240808161226.b853642c0ecf530b5cef2ecc@linux-foundation.org>
In-Reply-To: <20240808161226.b853642c0ecf530b5cef2ecc@linux-foundation.org>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Fri, 9 Aug 2024 01:34:37 +0100
Message-ID: <CAKbZUD0_BSv6KOgaRuqjLWGnttzcprcUu5WysSZeX8FXAvui5w@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm: Optimize mseal checks
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, jeffxu@google.com, 
	Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 12:12=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed,  7 Aug 2024 22:13:03 +0100 Pedro Falcato <pedro.falcato@gmail.com=
> wrote:
>
> > This series also depends on (and will eventually very slightly conflict=
 with)
> > the powerpc series that removes arch_unmap[2].
>
> That's awkward.  Please describe the dependency?

One of the transformations done in this patch series (patch 2) assumes
that arch_unmap either doesn't exist or does nothing.
PPC is the only architecture with an arch_unmap implementation, and
through the series I linked they're going to make it work via
->close().

What's the easiest way to deal with this? Can the PPC series go
through the mm tree?

I could also possibly work around this on my end, and either limit the
terribleness to the ppc arch_unmap code or limit the effectiveness of
the patch set a bit. But both of these options feel like somewhat
fighting the inevitable.

What do you think?

Thanks,
Pedro

