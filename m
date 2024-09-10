Return-Path: <linux-kernel+bounces-322875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF309731B0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 467032885F6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455A2199FCC;
	Tue, 10 Sep 2024 10:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkMysAmN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2C1192B60
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 10:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963002; cv=none; b=FdN7r5ZX3xwHQadFUAoNpSNsbvtX216uo3w3KqgE7GjL465Ff4Y8h7gHC9Wo81Cq9r4lmVU61xdZ+imn5J5Ucsu8/uQ+dYSE+a49kpfYXwJIabn3QfyjxSyben9SWGc+1IZ/+KJ/MM2KkKhV8e+TyBzI3HuKucHkhN0l8P0m9kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963002; c=relaxed/simple;
	bh=qci39d1xKfJDxp/aLwjtEh2USiUe2UEO295o+Qvvu3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTgdERaWLzszHsoUEx63wkmBV9syrr6IGxlbF1ydpMsSFFX1QClUa+mHCgyOKfJqJO6Q0uJxzHkDSV1wFYKQv0JlWnJll9Qy5wq1og9mrqmdRXi87Iy5tT2vfUUYHwG8njTQUSDBAQ/GGBeyFTIzG24ikWtKrtDQ1TxK5iYGMYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkMysAmN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE6AC4CEC3;
	Tue, 10 Sep 2024 10:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725963002;
	bh=qci39d1xKfJDxp/aLwjtEh2USiUe2UEO295o+Qvvu3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jkMysAmNcyCCTeplDafB2PHC8Ir3R5Mi55t7clWLtj5hWoXo/2YOmJKj+8VgDo74r
	 0pwlRQlZVKy9QazVzJgHc9ts+iabrDESOmsnyNIoAbs+55qUgQX4B9yRQaiHcRsqW1
	 NNa5uynyiPhzVrVT+JagutlmHcgU1X78tbR/hTNCP4pOXpeZnXqb2YVJNdlEfLVyBe
	 OKZ943uHnucygqL+smpLURNUQP6on9fse9UlMtYHyXHVRjoF+fSWOOVqmGzvlR5q/S
	 nJAy5nUN5DPKwMNEPspCZilUa8HHnUv0LOKpg6gIjoNxdLwG4lSXNoU0Dc31mv9YOw
	 VMmuD9QGsBGuw==
Date: Tue, 10 Sep 2024 12:09:56 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Feng Tang <feng.tang@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	David Gow <davidgow@google.com>, linux-mm@kvack.org,
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] mm/slub, kunit: Add testcase for krealloc redzone
 and zeroing
Message-ID: <ZuAa9DxCNwvFsZ50@pollux>
References: <20240909012958.913438-1-feng.tang@intel.com>
 <20240909012958.913438-6-feng.tang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909012958.913438-6-feng.tang@intel.com>

On Mon, Sep 09, 2024 at 09:29:58AM +0800, Feng Tang wrote:
> Danilo Krummrich raised issue about krealloc+GFP_ZERO [1], and Vlastimil
> suggested to add some test case which can sanity test the kmalloc-redzone
> and zeroing by utilizing the kmalloc's 'orig_size' debug feature.
> 
> It covers the grow and shrink case of krealloc() re-using current kmalloc
> object, and the case of re-allocating a new bigger object.
> 
> User can add "slub_debug" kernel cmdline parameter to test it.
> 
> [1]. https://lore.kernel.org/lkml/20240812223707.32049-1-dakr@kernel.org/
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Feng Tang <feng.tang@intel.com>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

> ---
>  lib/slub_kunit.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
> index 6e3a1e5a7142..03e0089149ad 100644
> --- a/lib/slub_kunit.c
> +++ b/lib/slub_kunit.c
> @@ -186,6 +186,51 @@ static void test_leak_destroy(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, 1, slab_errors);
>  }
>  
> +static void test_krealloc_redzone_zeroing(struct kunit *test)
> +{
> +	char *p;
> +	int i;
> +
> +	KUNIT_TEST_REQUIRES(test, __slub_debug_enabled());
> +
> +	/* Allocate a 64B kmalloc object */
> +	p = kzalloc(48, GFP_KERNEL);
> +	if (unlikely(is_kfence_address(p))) {
> +		kfree(p);
> +		return;
> +	}
> +	memset(p, 0xff, 48);
> +
> +	kasan_disable_current();
> +	OPTIMIZER_HIDE_VAR(p);
> +
> +	/* Test shrink */
> +	p = krealloc(p, 40, GFP_KERNEL | __GFP_ZERO);
> +	for (i = 40; i < 64; i++)
> +		KUNIT_EXPECT_EQ(test, p[i], SLUB_RED_ACTIVE);
> +
> +	/* Test grow within the same 64B kmalloc object */
> +	p = krealloc(p, 56, GFP_KERNEL | __GFP_ZERO);
> +	for (i = 40; i < 56; i++)
> +		KUNIT_EXPECT_EQ(test, p[i], 0);
> +	for (i = 56; i < 64; i++)
> +		KUNIT_EXPECT_EQ(test, p[i], SLUB_RED_ACTIVE);
> +
> +	/* Test grow with allocating a bigger 128B object */
> +	p = krealloc(p, 112, GFP_KERNEL | __GFP_ZERO);
> +	if (unlikely(is_kfence_address(p)))
> +		goto exit;
> +
> +	for (i = 56; i < 112; i++)
> +		KUNIT_EXPECT_EQ(test, p[i], 0);
> +	for (i = 112; i < 128; i++)
> +		KUNIT_EXPECT_EQ(test, p[i], SLUB_RED_ACTIVE);
> +
> +exit:
> +	kfree(p);
> +	kasan_enable_current();
> +}
> +
>  static int test_init(struct kunit *test)
>  {
>  	slab_errors = 0;
> @@ -196,6 +241,7 @@ static int test_init(struct kunit *test)
>  }
>  
>  static struct kunit_case test_cases[] = {
> +	KUNIT_CASE(test_krealloc_redzone_zeroing),
>  	KUNIT_CASE(test_clobber_zone),
>  
>  #ifndef CONFIG_KASAN
> -- 
> 2.34.1
> 

