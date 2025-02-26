Return-Path: <linux-kernel+bounces-534112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E68A462FA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39DD17A4054
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144BE217737;
	Wed, 26 Feb 2025 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gWb+oE74"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040D32222D5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580350; cv=none; b=ow7eWw6jvjjZAkqqkS7qsBkR815IWvTvVpkPSiq2YjJAT/Sv2HWfaO0OD3Kxyn0emFjVki/tgkW6Lm08pQbs5JZIL3ULN60BIclZ4vzjdxDGHr5TSD4fM6fKsrJglU8pYJ2ZYoSZnqGSiiiHQYlP0/CXUkSe4xTj5vFRqTZslEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580350; c=relaxed/simple;
	bh=1xje41uCepRrRXg3A3edi3Mg9Y3fBjuttj6Mnw8furo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/f6mIFOubgLO6Y3nyV9Z423dDIpp+7Gx4JfLR49TQmsKjYgYTWBQEr4EiE5iqE1e/AQpGVD6xphSZTs+PA3dsRSSAeb6foJshpNI762TtvbV3KqJC8l1WfJSoEn44asAtALDk0FpxljYvpg5vxvoKhCCk+sZ/ia+AGwAsLiZQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gWb+oE74; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-221ac1f849fso137865ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740580348; x=1741185148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=td9asxPNprcMZQkvIe996BJRz0iK1TqPUGnP0/ABMBE=;
        b=gWb+oE74KGT/ffjSYhI9knAAG02nDNmIqpwPgndBTLi+3Bnze37K72F0LiBn/AvZzu
         eRrdn8M2vCONtNGEndrmi4jyhiHEtPEi/cP+T+A81XkKChrfJ6ksGkOkvQ0Bk/EKm0TQ
         JKpLmTaz97+pp7F/4Xx7Y73LHSPRoXQrn5oWqRPonRrYg9L+V89fZohX+TJwfWnLhRv/
         EXy8v4/niZC+go+YOdjcebK5julupkTw45CM6yKoJJy0gKnt048tfwafbJFwp6slapPT
         V2ubURY+MKmJBRgkDZ9POYeNxMDoYbAoHTa5YtoRuJkzh1aAZL+a7PlWeGW7UII3JWKZ
         znLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740580348; x=1741185148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=td9asxPNprcMZQkvIe996BJRz0iK1TqPUGnP0/ABMBE=;
        b=XJmkD+S/HScF/YaZjSXR9GDpQy+iGkgMY880uYsXp0pB7IGGxFyo+p5S6iObyAmzKX
         E4/t/Itm3obkgF8w8O0MDOnYa2f9eMHECCFGuhwyEBuePEklMxi1INFhA7nehriu73HI
         dhq1Iomz4vh0I7SRqbDl4cd74CEP+a9CrZUd/Jc5JGDuEbKoLkYvcBQa9L+8qrNez6Kt
         05p57iSKZTeCximRkt0PaeYsNt3sR9di1qbm5KK7vOWkkKjVRZOgWeu4hWaSc4KlGOfB
         PgcHyc9jbdztkyV2LUfDRI5zsJdBSQDXcRKs1o1zkTpXmph/1bbnCG+AEcNpG5M3EgUJ
         ZHxA==
X-Forwarded-Encrypted: i=1; AJvYcCVbvamjDvhQqhSE+nK0lX/W/JJ3O1hSKJQ7xUzgGOEKUiWJaqwrEdqxIm/Dmqm0pnUpcTc71DLevA/7Kpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp8Is6ZSKWIvmPH7+WnmimiBAt5StWkwQhK6iPdxnxizAFF15d
	Pp/g8OehniYFj4V9G2u3oG7XFJlDQ4FRV11fqBBeIx872dDoxfjHYR688bsb45b8wkU3pzi5hEg
	eDEIS+umvf18IhsyICmlPvhLOGtN1w/7I4N0d
X-Gm-Gg: ASbGncv9LZTBgn0aD816iEq/1NAcuJ2NzdbmMy0kpo8trvEKz6ZIpJwapzyV7h4NGha
	lAXnYxepO6xG5rKY2Z+p/uPRTEHWwcmKfvp18vi8su4tt0v+O7QcsWg9evGW/FsfcjX95yXBr+3
	PABpmITg==
X-Google-Smtp-Source: AGHT+IEV7oIAxW6mnHKhBlIrbZwecYCm5nSGQwXbP+kYpROVcMIbhN327FZxfj24JStSXf63AwfCMV6rWezOiQiGmYU=
X-Received: by 2002:a17:902:ea0a:b0:216:21cb:2e06 with SMTP id
 d9443c01a7336-22307a97497mr6478505ad.19.1740580348078; Wed, 26 Feb 2025
 06:32:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226114815.758217-1-bgeffon@google.com> <Z78fT2H3BFVv50oI@casper.infradead.org>
In-Reply-To: <Z78fT2H3BFVv50oI@casper.infradead.org>
From: Brian Geffon <bgeffon@google.com>
Date: Wed, 26 Feb 2025 09:31:51 -0500
X-Gm-Features: AWEUYZn6pM-y42p_MFAy4Xy3EXUzYgSyyByB_sRAby2IurtgY3iUwDA_grGzwRU
Message-ID: <CADyq12x8eJ8ASq6WOEkFFbmJYajLnPd+qM8+QP1W76Add=S67A@mail.gmail.com>
Subject: Re: [PATCH] mm: fix finish_fault() handling for large folios
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins <hughd@google.com>, 
	Marek Maslanka <mmaslanka@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 9:04=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Feb 26, 2025 at 06:48:15AM -0500, Brian Geffon wrote:
> > When handling faults for anon shmem finish_fault() will attempt to inst=
all
> > ptes for the entire folio. Unfortunately if it encounters a single
> > non-pte_none entry in that range it will bail, even if the pte that
> > triggered the fault is still pte_none. When this situation happens the
> > fault will be retried endlessly never making forward progress.
> >
> > This patch fixes this behavior and if it detects that a pte in the rang=
e
> > is not pte_none it will fall back to setting just the pte for the
> > address that triggered the fault.
>
> Surely there's a similar problem in do_anonymous_page()?
>
> At any rate, what a horrid function finish_fault() has become.
> Special cases all over the place.  What we should be doing is
> deciding the range of PTEs to insert, bounded by the folio, the VMA
> and any non-none entries.  Maybe I'll get a chance to fix this up.

I agree, I wasn't thrilled that the fix looked like this but I was
trying to keep the change minimal to aid in backporting to stable
kernels where this behavior is broken. With that being said, do you
have a preference on a minimal way we can fix this before
finish_fault() gets a proper cleanup?

