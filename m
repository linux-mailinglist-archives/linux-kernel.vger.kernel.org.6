Return-Path: <linux-kernel+bounces-259924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F55939FED
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A011F231C1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E211552F5;
	Tue, 23 Jul 2024 11:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IO6Qlm+A"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFA715383E;
	Tue, 23 Jul 2024 11:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721734120; cv=none; b=pmC41royW/CxL5mdNc16kLXzu0PnAv72E2ywJouzWoWl2MD23llqoGdKJ4Dys2YC6f79myaBLQfxxPsZOS9UqjNYi9AmmaeXgH3d/xUYhVeIdz4Yx1u0kBqLlMn2ET832hVboOauRLt3xf1D1U6J5fALhzJsn6/ks+kodIT0a3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721734120; c=relaxed/simple;
	bh=zw4gLjcUkHuXvmEncRda0Xcv2/SJZchQsLo5PoVzXNg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyRu/PUfRC4KxxSAIBsTTBMHi5fzjlkgzlloZJljTNG0RXSaeWKxyiQBI3ccatR427D6z1nAgXD4vy/iLtn9tu7yUPwOy72SLX0oWoSfT8PHvrWnZspkD4INNvGmydzWEgtF6HTDqU3neOJ7+5S0DSVdpGChOpVzJQSo9SvM+ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IO6Qlm+A; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52f04b4abdcso1686604e87.2;
        Tue, 23 Jul 2024 04:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721734116; x=1722338916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=abrqLpr2mYE+mftzGkLINKPIi/aoImy+3XxL7lJcnew=;
        b=IO6Qlm+A4+W38LhyZpxu+5moeVRtMcSA1FU9pcbcgxksY2zxoEqYDZA9li6UXRbW7I
         m4psOajkt747uniSMJ5XuTKFkNsqKQBi0qA5QdromBI3bKYWPqHaGhpGW20Z0sv9gfGU
         mTldm465nLARe/pJ1z3Ha0zBtIJUfbt+vySw1v/oqRSF4B1CVF0mp14dnP/8uHJDJgg0
         zKQTe+U55OyVw9Os+s/wf7wz4EClNA/Ipeq0Nb7+sOb7lVJKBxvlIeOhb7K6kK6boof8
         LBqNoTy20tlfnxzKloQu8hg51A/G7xtbH2HMB5Jv5wrd9Q6DK9rwnfHxcL7FH2MobBRS
         h2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721734116; x=1722338916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abrqLpr2mYE+mftzGkLINKPIi/aoImy+3XxL7lJcnew=;
        b=xRi60SuGAh89tDHu31YomREvUzj0Eq+Glg+vJcNqdM9obNebLYvwW5htAixDviFbEq
         H/7uQ5LPP/kXsgWSUyTc3CdAJaDCaxk2G72OdFsj0IheamXvnU0eueguMpEMfUm4Lf81
         nqNda3UrInnoeJHp9ukqQGoaedKX3JoAZY5tBXILStS39+eqm99mdrB1SgTU6n4vAi93
         nqXmdZI15e4xrgPOtOeMKtVKW4NSHAdQGlhAxdaaVaZI8hCtTzC09q0ExaX+oULdNhSv
         o2k5PGCadpFpbmApNuwkH1Ma0Lr+8YJtB57OOfyaz8fTqxSeRwuPQqZUk0DDLX1lbphA
         CKCw==
X-Forwarded-Encrypted: i=1; AJvYcCUh5dwBvwBd5UDR65PA5jKHacvqFJtTbuPOR5jzptXUuoTjnDfqYHvhEa1H8MRAqRIKHGZdtxOMcqt4/g4Z49028pvUU1+8nvkApv9475eK3b6NupzAQHUDGb58Zlx3lJPhZ+NfUqgR/b6wjNw=
X-Gm-Message-State: AOJu0Yw3dmL/QuIOsGtEP2oKg/pWOU1uwPMIXgnicvV0FObk7gfTyYiZ
	ySXVZt5OxvJmdlniwVGf62IGAM31QXNPeJ5QPue6CqS8UXmQBJ7v
X-Google-Smtp-Source: AGHT+IE6SmKJeYRCd6J8eMwqSuZsAeG1RkElKxi9pM8+aTJA2/sss1iQnaWtymJXnMTtbLebBahEYg==
X-Received: by 2002:a05:6512:3d1a:b0:52e:7684:a385 with SMTP id 2adb3069b0e04-52efb7e8f75mr6226245e87.52.1721734116088;
        Tue, 23 Jul 2024 04:28:36 -0700 (PDT)
Received: from pc636 (host-90-233-197-231.mobileonline.telia.com. [90.233.197.231])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52efa73423csm1235399e87.102.2024.07.23.04.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 04:28:35 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 23 Jul 2024 13:28:32 +0200
To: Danilo Krummrich <dakr@kernel.org>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
	iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, urezki@gmail.com,
	hch@infradead.org, kees@kernel.org, ojeda@kernel.org,
	wedsonaf@gmail.com, mhocko@kernel.org, mpe@ellerman.id.au,
	chandan.babu@oracle.com, christian.koenig@amd.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: vmalloc: implement vrealloc()
Message-ID: <Zp-T4F42tk_aKKc-@pc636>
References: <20240717222427.2211-1-dakr@kernel.org>
 <20240717222427.2211-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717222427.2211-2-dakr@kernel.org>

On Thu, Jul 18, 2024 at 12:24:01AM +0200, Danilo Krummrich wrote:
> Implement vrealloc() analogous to krealloc().
> 
> Currently, krealloc() requires the caller to pass the size of the
> previous memory allocation, which, instead, should be self-contained.
> 
> We attempt to fix this in a subsequent patch which, in order to do so,
> requires vrealloc().
> 
> Besides that, we need realloc() functions for kernel allocators in Rust
> too. With `Vec` or `KVec` respectively, potentially growing (and
> shrinking) data structures are rather common.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  include/linux/vmalloc.h |  4 +++
>  mm/vmalloc.c            | 58 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index e4a631ec430b..9ff0a8e5c323 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -189,6 +189,10 @@ extern void *__vcalloc_noprof(size_t n, size_t size, gfp_t flags) __alloc_size(1
>  extern void *vcalloc_noprof(size_t n, size_t size) __alloc_size(1, 2);
>  #define vcalloc(...)		alloc_hooks(vcalloc_noprof(__VA_ARGS__))
>  
> +extern void * __must_check vrealloc_noprof(const void *p, size_t size,
> +					   gfp_t flags) __realloc_size(2);
> +#define vrealloc(...)		alloc_hooks(vrealloc_noprof(__VA_ARGS__))
> +
>  extern void vfree(const void *addr);
>  extern void vfree_atomic(const void *addr);
>  
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index e34ea860153f..4ec949ac9d9d 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4036,6 +4036,64 @@ void *vzalloc_node_noprof(unsigned long size, int node)
>  }
>  EXPORT_SYMBOL(vzalloc_node_noprof);
>  
> +/**
> + * vrealloc - reallocate virtually contiguous memory; contents remain unchanged
> + * @p: object to reallocate memory for
> + * @size: the size to reallocate
> + * @flags: the flags for the page level allocator
> + *
> + * The contents of the object pointed to are preserved up to the lesser of the
> + * new and old size (__GFP_ZERO flag is effectively ignored).
> + *
> + * If @p is %NULL, vrealloc() behaves exactly like vmalloc(). If @size is 0 and
> + * @p is not a %NULL pointer, the object pointed to is freed.
> + *
> + * Return: pointer to the allocated memory; %NULL if @size is zero or in case of
> + *         failure
> + */
> +void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
> +{
> +	size_t old_size = 0;
> +	void *n;
> +
> +	if (!size) {
> +		vfree(p);
> +		return NULL;
> +	}
> +
> +	if (p) {
> +		struct vm_struct *vm;
> +
> +		vm = find_vm_area(p);
>
Concurrent vfree() will lead to use-after-free. Either add a comment
that a user is responsible for not using vrealloc()/vfree() on the same
pointer concurrently or use find_unlink_vmap_area() which might be more
complex when it comes to design of the vrealloc().

--
Uladzislau Rezki

