Return-Path: <linux-kernel+bounces-262215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D0893C291
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 771961C20EB0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B044619AD7D;
	Thu, 25 Jul 2024 12:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SZIKNQx2"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5514E19AD7B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 12:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721912369; cv=none; b=ZYJWOOBi4y5xzu3LACmHVaVlZFlW4DkQO5Fr6E7YxVS48wkgioNWEPLC81Kt9WfGsz0Wl0PtlefVAt47DHluK1lR8RCG+kEZ3h7h4H4KclFg3QK3RDraY6YSxKJOX3Wbs5YF4KTgk+R55okyrRmz2qxLg2KSyIfkMF7gBs0iwZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721912369; c=relaxed/simple;
	bh=V4wDAafWRN/O1TlwPgM1dOQ9DwPe/pkpHLy40eB7y+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfUxTPtAWJ4eCnxdWLe8XrmYKNhA05XloTlkVVnts/Os+Yls21ueuBaFW4rGJBWmJT3rptDaTUmG9Vi/BlPJlfA1z9GTuPfDe48onpzDc7BsEXcY+aSfMwVgm3Smw9aX4jA2SzJXR2b7qaTJf6FJbNv8y+BxKt7erxXCL2viPvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=SZIKNQx2; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7a9e675a78so3645166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 05:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1721912365; x=1722517165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Mol47svduiCaHsnKdTkKvXi18me6mAtfjU4DPCmBkQ=;
        b=SZIKNQx20uvH1A+Dxv0OgqR+uB9N2MwVVXpSShz4h8tcaSdWjnVMdOlLvhYkfPeBXM
         +KoEfreHhyfhVmgM2XwJJw9XdiYvGh8ySEp50Zhx5cI4e26hUzuwWulGvvWUAoGAEhfN
         f4E0oOSuJjBPCGi7Fx7Difxgj4tmIJ2wAkmVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721912365; x=1722517165;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Mol47svduiCaHsnKdTkKvXi18me6mAtfjU4DPCmBkQ=;
        b=rtIz7vXFlTLyXGDRBAERjIA6en4eIJj9uJDMnujeeLz4fqSNwNer7if+g4haSh7dXM
         AMFPKTLGuy04L2Yr9at3QVbbsycHoXm0M4DBOCW6UuRnjFPverAf8XDrKahOvEJIhv8D
         OXu1IwMv23LTWlg5LJhAPDBWA6d/NJjYwfhiS5K0dd8xU+4zts0ai+CBOWQeENqOD90P
         T9bhVE+/TU79nZbEdWJZSbaCZudnnFlK/KGnHUuZjFDGKtQQEmH19KnirvGkeEg7VquF
         gvSGz+0wgqKrbACXfETpAJGroUKs7ZIR+Coj5INz4jCXZXiiBvnLvFAEV8jPoPQJP0rt
         cH8A==
X-Forwarded-Encrypted: i=1; AJvYcCWNtzL65hyoNT7YTe9dBm49PE7D3bzwcQFIWVmHVRRsWokSwEm0QVq2UhDXipq4Ax/DjNrGJKDLxXXJb1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt83jBWLCThis4J/FlPKh0lnvjfb+UriihGGeIighwV3ggxl7I
	ECMKdNzodwvVVwrNCQ/osE52e7tQyI5rGU363KZwrdxOEf8ed3VVTV3VINRC644=
X-Google-Smtp-Source: AGHT+IELpXnY1wuR/Lf/uOugSgjmN6lRRkW0fqsPCl4qz+7WB0nTWdrMJS8EXcNnsNPBLbmmezjuqQ==
X-Received: by 2002:a17:906:dc8f:b0:a7a:aa35:409c with SMTP id a640c23a62f3a-a7ac5bab2cdmr96193966b.9.1721912365485;
        Thu, 25 Jul 2024 05:59:25 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab2302dsm71116566b.39.2024.07.25.05.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 05:59:24 -0700 (PDT)
Date: Thu, 25 Jul 2024 14:59:22 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Marco Pagani <marpagan@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/test: use kunit action wrapper macro in the gem
 shmem test suite
Message-ID: <ZqJMKvwr6nxPjb9v@phenom.ffwll.local>
Mail-Followup-To: Marco Pagani <marpagan@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
References: <20240723191036.131286-1-marpagan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723191036.131286-1-marpagan@redhat.com>
X-Operating-System: Linux phenom 6.9.7-amd64 

On Tue, Jul 23, 2024 at 09:10:35PM +0200, Marco Pagani wrote:
> Replace deferred action function wrappers with equivalent ones defined
> using the macro introduced by commit 56778b49c9a2 ("kunit: Add a macro to
> wrap a deferred action function")
> 
> Signed-off-by: Marco Pagani <marpagan@redhat.com>

Merged to drm-misc-next, thanks for your patch.
-Sima

> ---
>  drivers/gpu/drm/tests/drm_gem_shmem_test.c | 27 ++++++----------------
>  1 file changed, 7 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tests/drm_gem_shmem_test.c b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
> index c3758faa1b83..f7f7d8b0f61f 100644
> --- a/drivers/gpu/drm/tests/drm_gem_shmem_test.c
> +++ b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
> @@ -23,29 +23,16 @@
>  #define TEST_BYTE		0xae
>  
>  /*
> - * Wrappers to avoid an explicit type casting when passing action
> - * functions to kunit_add_action().
> + * Wrappers to avoid cast warnings when passing action functions
> + * directly to kunit_add_action().
>   */
> -static void kfree_wrapper(void *ptr)
> -{
> -	const void *obj = ptr;
> -
> -	kfree(obj);
> -}
> -
> -static void sg_free_table_wrapper(void *ptr)
> -{
> -	struct sg_table *sgt = ptr;
> +KUNIT_DEFINE_ACTION_WRAPPER(kfree_wrapper, kfree, const void *);
>  
> -	sg_free_table(sgt);
> -}
> -
> -static void drm_gem_shmem_free_wrapper(void *ptr)
> -{
> -	struct drm_gem_shmem_object *shmem = ptr;
> +KUNIT_DEFINE_ACTION_WRAPPER(sg_free_table_wrapper, sg_free_table,
> +			    struct sg_table *);
>  
> -	drm_gem_shmem_free(shmem);
> -}
> +KUNIT_DEFINE_ACTION_WRAPPER(drm_gem_shmem_free_wrapper, drm_gem_shmem_free,
> +			    struct drm_gem_shmem_object *);
>  
>  /*
>   * Test creating a shmem GEM object backed by shmem buffer. The test
> -- 
> 2.45.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

