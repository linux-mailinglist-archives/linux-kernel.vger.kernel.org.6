Return-Path: <linux-kernel+bounces-558207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D919FA5E2C7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B7CA7ADFB7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D352225CC93;
	Wed, 12 Mar 2025 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRr4R0RH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363B325D1F5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800234; cv=none; b=FWpdhUZJZI5fZAL5XqwxL5EywTGUdsc010vG5VaK7xiqW278jnhC0yT/+GOFkF1OxtOV51u2QOMNXvOtlIRonzwmKfU4UHKTwrsBJZyzFc61/akhlGdaSlA2jc3L5LDCzchoOgVFCoXhgy/ZVw6wiG++6ifSlNJJ+GNDAQYS6ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800234; c=relaxed/simple;
	bh=wh1Fxnshp8oLvMCLtrPIX0gzdOI/IeVWj1yLkdb7azE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KPGSMmcwPwS8INuJQAUsGFmg/TqloncgXFtwG/3P3j9Y78sH/gjhUdN8SLodpSaqEui5PgZ8utrb7LctmVZkk91PtyD20NqOZ0Q2X/l3rIbdxIma3KK2KXBZJjv2adbWW+3Csz83tF+oGW5uEXaYrKuYN/ildmTSmAclnvje37g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRr4R0RH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D129C4CEDD;
	Wed, 12 Mar 2025 17:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741800232;
	bh=wh1Fxnshp8oLvMCLtrPIX0gzdOI/IeVWj1yLkdb7azE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NRr4R0RHiZhCC3DDkz4iudYArYbHByGgGONNO9lO1z4AeK9haFC9nUSo0tIMk4uZg
	 PtqIG3RrzgNEsNYlPUF+8SuPcE6YvNMaWZfBJL1R+W5nLVBxeddIFFHvMC2X5y6wge
	 SRpwX++BHv/19EwajZMqXWaGN9RZtqDtcMEDGqwvQia2IoBa9CHEnuLeYEjlyHmpUZ
	 rnSvqBIIsZbh3gVtcMl6y/Z1kdqVFLcGfDgJBbmn5Iy006ATxFpCazAeQSE8J+KrZe
	 qAyGhA8xuTnoaX1gGeEda7nUwK8DmldMlGVIK/qNrthZ50QjB0FpyWRUAsrxm+mFeM
	 JfWfkxAxCdaKA==
From: SeongJae Park <sj@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <howlett@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 5/9] mm/madvise: define and use madvise_behavior struct for madvise_do_behavior()
Date: Wed, 12 Mar 2025 10:23:50 -0700
Message-Id: <20250312172350.59632-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2a2eb9de-c8d5-4be0-afec-2efd334dbab9@lucifer.local>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 12 Mar 2025 05:47:02 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> On Tue, Mar 11, 2025 at 01:56:17PM -0700, SeongJae Park wrote:
> > On Tue, 11 Mar 2025 12:17:40 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> >
> > > On Mon, Mar 10, 2025 at 10:23:14AM -0700, SeongJae Park wrote:
[...]
> > > (I wonder if that'd be better as a typedef tbh?)
> >
> > Something like below?
> >
> >     typedef void *madvise_walk_arg;
> >
> > I think that could make the code easier to read.  But I feel the void pointer
> > is also not very bad for the current simple static functions use case, so I'd
> > like keep this as is if you don't mind.
> >
> > Please let me know if I'm missing your point.
> 
> No to be clear I meant the:
> 
> int (*visit)(struct vm_area_struct *vma,
> 				   struct vm_area_struct **prev, unsigned long start,
> 				   unsigned long end, unsigned long arg)
> 
> Function pointer.

Thanks for clarifying!  And I agree this is a good idea.

> 
> But this is not a big deal and let's leave it as-is for now, we can address
> this later potentially! :)

Agreed, either! :)

[...]
> Thanks for being so flexible on the feedback! Appreciated :>)

Thank you for your nice and helpful reviews :)


Thanks,
SJ

