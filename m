Return-Path: <linux-kernel+bounces-261537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C52D593B873
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 23:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7D6C1C23AEE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD0813A877;
	Wed, 24 Jul 2024 21:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P7Y7O8l1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0E36F068
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 21:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721855830; cv=none; b=tJB1vIQ1T49vwf+r9Q6nZVuVodaeywWUrOwDL+It8EjjOLwrfMIUbMjilEOpbFz1iTC+ujweEvm8ca/HemIVMjDSSCvGhsikPr+ZEoCB+vmzYCB0yz4yrwkNsUoY81WuWdCt721F90I7HlJqmBoMcT9RUVFKgCio2snmhO9JbWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721855830; c=relaxed/simple;
	bh=CtU01g2cCRY8Yc3D5EGXN7sqJewwORULkSqRWpWQe7E=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WCNgPVQSeBFJ3V2733Xa2UK/3AY6PeTCGLca/qH3ewdQlxgrCd76OjhEQwPBz1Hdt5nYxmDifwONToJD/ilKEnXqmW8sq0CDfLsbG6edQU2qvkoStibgvv+5b+x0+ziOa0XnxdQ71W4d5UXjD9/T9AAAVmUYjXtZCO/o4v3oEU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=P7Y7O8l1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AB2C32781;
	Wed, 24 Jul 2024 21:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721855830;
	bh=CtU01g2cCRY8Yc3D5EGXN7sqJewwORULkSqRWpWQe7E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P7Y7O8l1H1DXEr/5YsFuXJR2ydkIdZjePru7UM2U5trRvNItdsCwyMvqTb9C4eh7Z
	 WSHPkWDzXMrEXygL3+ympmYYKOKRdNT/IyEUGc6bNpX/QliCP0rfM3Q2AdslESJpSK
	 ZRR/48ITmHhhXhdo7Zlj8wmFL+nGAsFpVzfmCabA=
Date: Wed, 24 Jul 2024 14:17:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jann Horn <jannh@google.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko
 <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov
 <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David
 Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin
 <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, Marco
 Elver <elver@google.com>, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/2] kasan: catch invalid free before SLUB
 reinitializes the object
Message-Id: <20240724141709.8350097a90d88f7d6d14c363@linux-foundation.org>
In-Reply-To: <20240724-kasan-tsbrcu-v2-1-45f898064468@google.com>
References: <20240724-kasan-tsbrcu-v2-0-45f898064468@google.com>
	<20240724-kasan-tsbrcu-v2-1-45f898064468@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jul 2024 18:34:12 +0200 Jann Horn <jannh@google.com> wrote:

> Currently, when KASAN is combined with init-on-free behavior, the
> initialization happens before KASAN's "invalid free" checks.
> 
> More importantly, a subsequent commit will want to use the object metadata
> region to store an rcu_head, and we should let KASAN check that the object
> pointer is valid before that. (Otherwise that change will make the existing
> testcase kmem_cache_invalid_free fail.)
> 
> So add a new KASAN hook that allows KASAN to pre-validate a
> kmem_cache_free() operation before SLUB actually starts modifying the
> object or its metadata.

I added this, to fix the CONFIG_KASAN=n build

--- a/include/linux/kasan.h~kasan-catch-invalid-free-before-slub-reinitializes-the-object-fix
+++ a/include/linux/kasan.h
@@ -381,6 +381,12 @@ static inline void *kasan_init_slab_obj(
 {
 	return (void *)object;
 }
+
+static inline bool kasan_slab_pre_free(struct kmem_cache *s, void *object)
+{
+	return false;
+}
+
 static inline bool kasan_slab_free(struct kmem_cache *s, void *object, bool init)
 {
 	return false;
_


