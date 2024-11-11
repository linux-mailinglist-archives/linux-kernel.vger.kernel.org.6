Return-Path: <linux-kernel+bounces-404773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC039C4873
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6A67B23558
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095F71AC423;
	Mon, 11 Nov 2024 21:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zvhzf9Gx"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E601EB36
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 21:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731360099; cv=none; b=muxFbfQj3AZY0N6NMJm6XD1758ldRX7oMB2Ba8Jrp0cpC30IYKbQmPEBaR/e+i6HsA/VXfaCL3zr9QnbXKSTf3xxQKc/hKiJC8F2nJQC1UqWrOoqzJFVR/4siTC2I9ETylLaMEWloTCJQRazb8Hu9iO+QuBBiUdNbKXRf809jR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731360099; c=relaxed/simple;
	bh=VFJvq+LERFNyJY8U+s574EYCcRx3GigbkNEAPfZLdkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lD1CTvAb8noDQFjrB+VzljNF9drZZTHn2GcTOmvDXraTsvLynpoTHyc4TzwNxBhAbaG8WENkMNQH8binImb0eGnhbrGP6CHNTX29hsVhadOyFh6DXYl2rZkrPq+X21cZlwUiGveNtEItKhY5P9/+6wOsgimvQRHTsc5nYz3J4tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zvhzf9Gx; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e19d8c41so4542e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 13:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731360096; x=1731964896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLnHLRpX4FgJDKaQVlTjZrusIwYcyb5vNTLCS3vgVJc=;
        b=zvhzf9Gxq1yL9WyTH2n5lOdnYNdEfx4zrjBEvosyl2uOeGljUNpLpXkiSZ2cxNIjmh
         /vd+GVMm/Q1jvz9RVVPEFiDntCauA3aRRWfaz3xAmHLOwdxWwIK0MvbEUJjDcJC52ywB
         zr+QkZvmJUwtrMdr+hXUe4/xVu+PmyTWMNY3IXRi5SIvumD2T4wPC+HAMs0nuqAL/dfh
         inz8R1EhWv0jFdaToGVRgGIfQIwSBLWHLXdGA5zFRqhJ5Es1CQwzqmHEbcWh4E1463vn
         5Evsy/vqoc6MVEXfptjujMMOyVDXMe9+fjE+LEj346oujT3VwmeItazP96ZmSfz3mi8a
         Cj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731360096; x=1731964896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLnHLRpX4FgJDKaQVlTjZrusIwYcyb5vNTLCS3vgVJc=;
        b=nF+MxYqoqGWbDkRg+9tW2SMr9dcD6gK2onVQjcHgDCa9gOOzKbQPf+XThvFte5hcZv
         bVUdH8exiTUv4c8cqp7f041xZwgLUzWUQ+G2TRVBUHuiclvBe7so06H2A6MzK04a+E63
         LbGDffmnTa+U2xDtmYJiJbWij92JokEBrGM+3nNo8MzmorGNkmmKncLon8KOjzyTOwGq
         5s3cWwEln+3p5mVpKgHWNq8FmbwIlVle+rTxgTRqOgvx6ix2FSIMuhj4BVYPacV/XEE2
         EIQz/oiESmQqxMDgleh+C/btRc8KXEj5dGW43jjvEGAqvjkRd1dqLgF/FGcfwItFoXAz
         3+sg==
X-Gm-Message-State: AOJu0Yznypi7QDMoynhhI6sIEB1Vy7TTOImO9Wgi7Q6AJIkQWaAu2PPQ
	r+f3HpffhEbqaNqWXHgyTIZa+fy7rq4dfTVNPqmnrX/Fb4uhgAe4TQHnKqpgu+lJj6HQqCHFpna
	rikXcQpYg/QPUMhLhLor+cnBD1b4mDQXPbOK7
X-Gm-Gg: ASbGnctg+3Zk4FnYxFKaveb9Fsvh8LOmSZr8NF8lcAJx6StoHCWgvAo2KjDnxFZZfHB
	RKVCB9wvgzpRkLkkU9MN7x/CW8QdTK2eNXXkHc2pDA1j/ipLI1xWngiaqlw==
X-Google-Smtp-Source: AGHT+IFox3Wq6T2Q1LkJY3chOYmzivx2kH9F9FcDQQB+5OTyAW6yTDkFUkoBaDF4bv6wxemMWtOFwRRbrsjFXYyZSpM=
X-Received: by 2002:a05:6512:10d3:b0:536:88d0:420d with SMTP id
 2adb3069b0e04-53d99ee6dd5mr105722e87.6.1731360095424; Mon, 11 Nov 2024
 13:21:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812181225.1360970-1-peterx@redhat.com>
In-Reply-To: <20240812181225.1360970-1-peterx@redhat.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 11 Nov 2024 22:20:59 +0100
Message-ID: <CAG48ez0NNph0Zp2aZ+c1T+U940CvwxcQ+jyEhp3KYZLSWPSrNw@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] mm/mprotect: Fix dax puds
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	"Kirill A . Shutemov" <kirill@shutemov.name>, Nicholas Piggin <npiggin@gmail.com>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, James Houghton <jthoughton@google.com>, 
	Huang Ying <ying.huang@intel.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	Hugh Dickins <hughd@google.com>, Borislav Petkov <bp@alien8.de>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Michael Ellerman <mpe@ellerman.id.au>, 
	Rik van Riel <riel@surriel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Mel Gorman <mgorman@techsingularity.net>, x86@kernel.org, 
	Ingo Molnar <mingo@redhat.com>, linuxppc-dev@lists.ozlabs.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Oscar Salvador <osalvador@suse.de>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 8:12=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
> Dax supports pud pages for a while, but mprotect on puds was missing sinc=
e
> the start.  This series tries to fix that by providing pud handling in
> mprotect().  The goal is to add more types of pud mappings like hugetlb o=
r
> pfnmaps.  This series paves way for it by fixing known pud entries.

Do people actually use hardware where they can use PUD THP mappings
for DAX? I thought that was just some esoteric feature that isn't
actually usable on almost any system.
Was I wrong about that?

I think another example that probably doesn't play entirely nice with
PUD THP mappings is mremap()'s move_page_tables(). If
dax_get_unmapped_area() allows creating a VMA at an unaligned start
address (which I think it does?), move_page_tables() can probably end
up copying from an aligned address mapped with a huge PUD entry to an
unaligned address that needs to be mapped at the PTE level, and I
think that will probably cause it to call into get_old_pmd() while a
huge PUD entry is still present, which will probably get us a
pud_bad() error or such?

