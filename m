Return-Path: <linux-kernel+bounces-246932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA1592C908
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF10D1C22D68
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255E7288DF;
	Wed, 10 Jul 2024 03:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gzxK4JI1"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1338C17756
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 03:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720581375; cv=none; b=mHaoo0o3tpIwuzBhVTnoEZxELFVhV0L/mNpmXlxb2v+coPVkeK6fpOsc4RH56NsrMljnDCCDMHYr4f9CifeLNxjuEIHLKF0DUH0qGrfgz+qo0Y8bmRuqp3OeIXJ5AphfAlAlaqzTWuanOTBPpPJyLFhgHY1+AtoWlAqr4693svQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720581375; c=relaxed/simple;
	bh=roUE502xLfXq4pcTuAI0h89lP71wNlAZnzYPEpEqFpg=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=dNVxDzjyjVFHcbH2Mf2zEyzsVkuLqOgkmr/eqHkZ5B0ivDlo63E6W1jgk5+ekTv2ounqN6vRSfG8QnyuV7dA6wRKYxzWc8Ca95iVMuG2AHFDUvionDvpXaOsn2wfQYS8aIHkpMVBcxsbsen5XUSRGXnMpl75tSRgpfUreDTU6oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gzxK4JI1; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: willy@infradead.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720581368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ab57vPDAVW6n2fvyGHo7nNxLm+m7V/+rr2GUI7WVKJg=;
	b=gzxK4JI1hQdkiilYBppppSxd6E3NMcRJKQ17Oo7M30MovjFrxG/DZRb8AnPKrmzVltEPuB
	5N9bCEZScgcOdj1UHAU1R2KzTV91DfI7BUDhmsGMjLcKuAhM55xDtLhWe0yLXR8ZMykuZq
	9ETXsSCuUJzWaKvlJ+o9F5ijarLjnTM=
X-Envelope-To: vbabka@suse.cz
X-Envelope-To: surenb@google.com
X-Envelope-To: cl@linux.co
X-Envelope-To: penberg@kernel.org
X-Envelope-To: rientjes@google.com
X-Envelope-To: iamjoonsoo.kim@lge.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: 42.hyeyoo@gmail.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: lkp@intel.com
X-Envelope-To: nathan@kernel.org
X-Envelope-To: llvm@lists.linux.dev
X-Envelope-To: ndesaulniers@google.com
X-Envelope-To: sxwjean@me.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 10 Jul 2024 03:16:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: xiongwei.song@linux.dev
Message-ID: <43ca4cc6d11f2cff96f2596783442d5ca4b9358e@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] mm/slub: quiet the clang warning with -Wunused-function
 enabled
To: "Matthew Wilcox" <willy@infradead.org>
Cc: vbabka@suse.cz, surenb@google.com, cl@linux.co, penberg@kernel.org,
 rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
 roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, "kernel test robot" <lkp@intel.com>,
 "Nathan Chancellor" <nathan@kernel.org>, llvm@lists.linux.dev, "Nick
 Desaulniers" <ndesaulniers@google.com>, sxwjean@me.com
In-Reply-To: <Zo36BTqhzGkukyT_@casper.infradead.org>
References: <20240710025418.394321-1-sxwjean@me.com>
 <Zo36BTqhzGkukyT_@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

July 10, 2024 at 11:03 AM, "Matthew Wilcox" <willy@infradead.org> wrote:



>=20
>=20On Wed, Jul 10, 2024 at 10:54:18AM +0800, sxwjean@me.com wrote:
>=20
>=20>=20
>=20> From: Xiongwei Song <xiongwei.song@linux.dev>
> >=20
>=20>=20=20
>=20>=20
>=20>  The only user of prepare_slab_obj_exts_hook() is
> >=20
>=20>  alloc_tagging_slab_alloc_hook(), which can build with
> >=20
>=20>  CONFIG_MEM_ALLOC_PROFILING enabled. So, the warning was triggerred
> >=20
>=20>  when disabling CONFIG_MEM_ALLOC_PROFILING. Let's add "__maybe_unus=
ed"
> >=20
>=20>  for prepare_slab_obj_exts_hook().
> >=20
>=20
> Perhaps instead clang can be fixed to match gcc's behaviour?

Maybe, I'm not sure.=20

Thanks,
Xiongwei

>=20
> >=20
>=20> Reported-by: kernel test robot <lkp@intel.com>
> >=20
>=20>  Closes: https://lore.kernel.org/oe-kbuild-all/202407050845.zNONqau=
D-lkp@intel.com/
> >=20
>=20>  Signed-off-by: Xiongwei Song <xiongwei.song@linux.dev>
> >=20
>=20>  ---
> >=20
>=20>  mm/slub.c | 4 ++--
> >=20
>=20>  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
>=20>=20=20
>=20>=20
>=20>  diff --git a/mm/slub.c b/mm/slub.c
> >=20
>=20>  index ce39544acf7c..2e26f20759c0 100644
> >=20
>=20>  --- a/mm/slub.c
> >=20
>=20>  +++ b/mm/slub.c
> >=20
>=20>  @@ -2027,7 +2027,7 @@ static inline bool need_slab_obj_ext(void)
> >=20
>=20>  return false;
> >=20
>=20>  }
> >=20
>=20>=20=20
>=20>=20
>=20>  -static inline struct slabobj_ext *
> >=20
>=20>  +static inline struct slabobj_ext * __maybe_unused
> >=20
>=20>  prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void=
 *p)
> >=20
>=20>  {
> >=20
>=20>  struct slab *slab;
> >=20
>=20>  @@ -2068,7 +2068,7 @@ static inline bool need_slab_obj_ext(void)
> >=20
>=20>  return false;
> >=20
>=20>  }
> >=20
>=20>=20=20
>=20>=20
>=20>  -static inline struct slabobj_ext *
> >=20
>=20>  +static inline struct slabobj_ext * __maybe_unused
> >=20
>=20>  prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void=
 *p)
> >=20
>=20>  {
> >=20
>=20>  return NULL;
> >=20
>=20>  --=20
>=20>=20
>=20>  2.34.1
> >
>

