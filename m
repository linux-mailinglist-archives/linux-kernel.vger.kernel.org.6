Return-Path: <linux-kernel+bounces-250125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5766592F481
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614871C222E3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 03:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756AB168C4;
	Fri, 12 Jul 2024 03:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="shhRitpu"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D75B101DE
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 03:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720756288; cv=none; b=G7NtzC/WNRB4IKxr6F8Xc+rHIoHdEF7eXgw6+NbLd6GAUlZ8tImlH2ExrGkkuJoMgfZXWx+abU6l/2/UMb1q/dBZ2WbkMaZCuXhIY81Qkg2x+JNd9/9D7UYdvtyyimJLGjwtIcwNdHRp2utVLKWOqtbO444EaH3hoWMMSUzLUYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720756288; c=relaxed/simple;
	bh=X5CHzDO2w0iaSpqQBiS4c4McEFhHtmC9DKCnYkfWSQs=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=r2eJoNW1xz57gc2IHyuxmg73UL7YeBMwVumtnoeQNDeHanmCnYKXYoYP/rgcTJEiB6bvLTdw6mYmJU8qxWicxWMAGGEerKcHGCDKrR5eiS8v0GtUgVmPOqxnR428Tj4UNnxNnlV83ZlnvrZbd0klQ3B1SSCtjCbPb8buIVRFVmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=shhRitpu; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: surenb@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720756283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X5CHzDO2w0iaSpqQBiS4c4McEFhHtmC9DKCnYkfWSQs=;
	b=shhRitpuf0ZalVIT4mcGfaEA0ILfBRatFoRHHZjMSySBxZQQ1mIUhlJoB9eZWBJu5NRpt5
	ENscMyjdbTDTtKPiftP0K+AlMBNi/l37IJSnNZN26q/wr+ZdD0Ry8s8+GVPH5bfbWUWwW9
	cHxTycOCTWjsKi1ALp6qTX93+e17y8A=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: vbabka@suse.cz
X-Envelope-To: sxwjean@me.com
X-Envelope-To: willy@infradead.org
X-Envelope-To: nathan@kernel.org
X-Envelope-To: cl@linux.com
X-Envelope-To: penberg@kernel.org
X-Envelope-To: rientjes@google.com
X-Envelope-To: iamjoonsoo.kim@lge.com
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: 42.hyeyoo@gmail.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: lkp@intel.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 12 Jul 2024 03:51:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: xiongwei.song@linux.dev
Message-ID: <f7623c47f2ddb4ece4dc56276e214b754372cf65@linux.dev>
TLS-Required: No
Subject: Re: [PATCH 1/1] mm, slab: move prepare_slab_obj_exts_hook under
 CONFIG_MEM_ALLOC_PROFILING
To: "Suren Baghdasaryan" <surenb@google.com>, akpm@linux-foundation.org
Cc: vbabka@suse.cz, sxwjean@me.com, willy@infradead.org, nathan@kernel.org,
 cl@linux.com, penberg@kernel.org, rientjes@google.com,
 iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Suren Baghdasaryan"
 <surenb@google.com>, "kernel test robot" <lkp@intel.com>
In-Reply-To: <20240711170216.1149695-1-surenb@google.com>
References: <20240711170216.1149695-1-surenb@google.com>
X-Migadu-Flow: FLOW_OUT

July 12, 2024 at 1:02 AM, "Suren Baghdasaryan" <surenb@google.com> wrote:



>=20
>=20The only place prepare_slab_obj_exts_hook() is currently being used i=
s
>=20
>=20from alloc_tagging_slab_alloc_hook() when CONFIG_MEM_ALLOC_PROFILING=
=3Dy.
>=20
>=20Move its definition under CONFIG_MEM_ALLOC_PROFILING to prevent unuse=
d
>=20
>=20function warning for CONFIG_SLAB_OBJ_EXT=3Dn case.
>=20
>=20Reported-by: kernel test robot <lkp@intel.com>
>=20
>=20Closes: https://lore.kernel.org/oe-kbuild-all/202407050845.zNONqauD-l=
kp@intel.com/
>=20
>=20Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>=20
>=20Cc: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Xiongwei Song <xiongwei.song@linux.dev>

Thanks.

>=20
>=20---
>=20
>=20Applied over slab/for-next because of the refactoring [1] in that bra=
nch.
>=20
>=20[1] 302a3ea38aec ("mm, slab: move allocation tagging code in the allo=
c path into a hook")
>=20
>=20 mm/slub.c | 48 +++++++++++++++++++++---------------------------
>=20
>=20 1 file changed, 21 insertions(+), 27 deletions(-)
>=20
>=20diff --git a/mm/slub.c b/mm/slub.c
>=20
>=20index ce39544acf7c..829a1f08e8a2 100644
>=20
>=20--- a/mm/slub.c
>=20
>=20+++ b/mm/slub.c
>=20
>=20@@ -2027,6 +2027,27 @@ static inline bool need_slab_obj_ext(void)
>=20
>=20 return false;
>=20
>=20 }
>=20
>=20=20
>=20
> +#else /* CONFIG_SLAB_OBJ_EXT */
>=20
>=20+
>=20
>=20+static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache =
*s,
>=20
>=20+ gfp_t gfp, bool new_slab)
>=20
>=20+{
>=20
>=20+ return 0;
>=20
>=20+}
>=20
>=20+
>=20
>=20+static inline void free_slab_obj_exts(struct slab *slab)
>=20
>=20+{
>=20
>=20+}
>=20
>=20+
>=20
>=20+static inline bool need_slab_obj_ext(void)
>=20
>=20+{
>=20
>=20+ return false;
>=20
>=20+}
>=20
>=20+
>=20
>=20+#endif /* CONFIG_SLAB_OBJ_EXT */
>=20
>=20+
>=20
>=20+#ifdef CONFIG_MEM_ALLOC_PROFILING
>=20
>=20+
>=20
>=20 static inline struct slabobj_ext *
>=20
>=20 prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *=
p)
>=20
>=20 {
>=20
>=20@@ -2051,33 +2072,6 @@ prepare_slab_obj_exts_hook(struct kmem_cache *=
s, gfp_t flags, void *p)
>=20
>=20 return slab_obj_exts(slab) + obj_to_index(s, slab, p);
>=20
>=20 }
>=20
>=20=20
>=20
> -#else /* CONFIG_SLAB_OBJ_EXT */
>=20
>=20-
>=20
>=20-static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache =
*s,
>=20
>=20- gfp_t gfp, bool new_slab)
>=20
>=20-{
>=20
>=20- return 0;
>=20
>=20-}
>=20
>=20-
>=20
>=20-static inline void free_slab_obj_exts(struct slab *slab)
>=20
>=20-{
>=20
>=20-}
>=20
>=20-
>=20
>=20-static inline bool need_slab_obj_ext(void)
>=20
>=20-{
>=20
>=20- return false;
>=20
>=20-}
>=20
>=20-
>=20
>=20-static inline struct slabobj_ext *
>=20
>=20-prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *=
p)
>=20
>=20-{
>=20
>=20- return NULL;
>=20
>=20-}
>=20
>=20-
>=20
> -#endif /* CONFIG_SLAB_OBJ_EXT */
>=20
>=20-
>=20
>=20-#ifdef CONFIG_MEM_ALLOC_PROFILING
>=20
>=20-
>=20
>=20 static inline void
>=20
>=20 alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gf=
p_t flags)
>=20
>=20 {
>=20
>=20base-commit: fe4e761669ab4d8b388fdb6e9dbe9a110eed8009
>=20
>=20--=20
>=20
> 2.45.2.993.g49e7a77208-goog
>

