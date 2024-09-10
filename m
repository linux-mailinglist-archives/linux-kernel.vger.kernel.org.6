Return-Path: <linux-kernel+bounces-323157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8EE9738A8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FF4AB21E41
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B06B192D6D;
	Tue, 10 Sep 2024 13:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vZRg2DFJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HMIm890K";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L/HvcHR9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="snrQm5Ay"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE18017E8F7
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725974965; cv=none; b=gEtWvzClsY21+nCKOEI97lnNWVLiurQKtn9Ex/1rhoGhBoMA1MphLePJoBo79NsgdW7jGzez1ycNCHWRii+b770q0ab7BT6UsZUtbQUIMiVcFQ/tdSvcA4box9MmgxYCIvZRMTBYbXXZHPFze9AOyCftVMJPPchc3h2pxUGRooI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725974965; c=relaxed/simple;
	bh=eaADkRRFnnsgsggDD/PPsBq6EHJNZKgnQyJByfF6cMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZIa+vTRYxg3iX8e/0WdAqWCfi/08fwmUJRLZuaFZupyrdm8PSA6/rotTSRgPpoBEVSgCQl+YfIoh+eM1ymDg+OKCwCkyk4CbhAvaSNOOOqpYDCcuBjPYOnlxw1qtuoUWzjqOWTPndg4DGcMnTE3LWxpX1shCzGbg+2gzF8XLOUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vZRg2DFJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HMIm890K; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L/HvcHR9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=snrQm5Ay; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CD9AD21227;
	Tue, 10 Sep 2024 13:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725974962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mOYVq6F7Ob2XxqE+z2md4uwqaGeL3XgktjUkUkC12Ak=;
	b=vZRg2DFJSoZNByty4lOn+iwTq1ziQYlWhkUEqSyuRtgbCr1BIBq1gqrRKXEKF5v+hvQTLi
	qWTD6tO0uO6bKo44Z4YUOyxhOzf5BtiFqFOJnV97klBoGd8rS+5cuvljXGLcnsjVpIunxp
	t84zAe+PDuiGEr9/5kWWz+MFiuCH0H8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725974962;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mOYVq6F7Ob2XxqE+z2md4uwqaGeL3XgktjUkUkC12Ak=;
	b=HMIm890Kr2Q8KMzPi42t1z4hDueXmnhdAliJ6Lv8U/yb0r/y57rUv9di1vyA4/y6glxXxu
	ZCxBWch0CJPO0LAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725974961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mOYVq6F7Ob2XxqE+z2md4uwqaGeL3XgktjUkUkC12Ak=;
	b=L/HvcHR9f2AQgXiYJlljMzVDaOG0bHY8DPL81hlaQIVr2TWaBmHKqoIjVgfupQnaoJCszy
	crRlOOHTNlfB7e7HPlwh6S2d1zKf6pV9ctrBtfGGybk5dfweZGi6vBDxYLhboiFKkNmqRe
	kT4jqYnxU5Xj4gaDFeS94RTz9qT+MTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725974961;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mOYVq6F7Ob2XxqE+z2md4uwqaGeL3XgktjUkUkC12Ak=;
	b=snrQm5AyPTq5KGehkd+P5kroleD3JyAL+qdpGlafEVuXbVhQm4inqhIzo7Y/MMLmFRmKpO
	HfSQznM31huX47DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D82113A3A;
	Tue, 10 Sep 2024 13:29:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dkq+JbFJ4GY+HgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 10 Sep 2024 13:29:21 +0000
Message-ID: <a4805d44-9595-429c-86c1-6003b9faa59f@suse.cz>
Date: Tue, 10 Sep 2024 15:29:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] mm/slub, kunit: Add testcase for krealloc redzone and
 zeroing
Content-Language: en-US
To: Feng Tang <feng.tang@intel.com>, Andrew Morton
 <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Andrey Konovalov
 <andreyknvl@gmail.com>, Marco Elver <elver@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>, David Gow <davidgow@google.com>,
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-mm@kvack.org, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org
References: <20240909012958.913438-1-feng.tang@intel.com>
 <20240909012958.913438-6-feng.tang@intel.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240909012958.913438-6-feng.tang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[intel.com,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,linux.dev,gmail.com,linuxfoundation.org];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 9/9/24 03:29, Feng Tang wrote:
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

AFAICS this is insufficient, because the static key may be enabled due to
debugging enabled for different caches than kmalloc, or it might not include
both red zone and object tracking.

But it should be possible to instead create a fake kmalloc cache of size 64
and use __kmalloc_cache_noprof() like test_kmalloc_redzone_access()?

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

The only downside is that krealloc() here might use kmalloc-128 cache that's
not doing red zoning and object tracking....

> +	if (unlikely(is_kfence_address(p)))
> +		goto exit;
> +
> +	for (i = 56; i < 112; i++)
> +		KUNIT_EXPECT_EQ(test, p[i], 0);

... but this test is still valid and necessary

> +	for (i = 112; i < 128; i++)
> +		KUNIT_EXPECT_EQ(test, p[i], SLUB_RED_ACTIVE);

... we might skip this test as the red zoning is not done by __do_krealloc()
anyway in the alloc_new case.

> +
> +exit:
> +	kfree(p);

Ideally we'd also validate the fake kmalloc cache we created and expect zero
slab_errors.

Hopefully this approach works and I'm not missing something...

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


