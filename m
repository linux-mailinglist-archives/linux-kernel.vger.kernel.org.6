Return-Path: <linux-kernel+bounces-547079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7D8A502BE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FDCF3A3F04
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD99724BC0D;
	Wed,  5 Mar 2025 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="dapvFczM"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E200024A051
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186171; cv=none; b=tO4/vTQ3FVBGgL5vXyeBJtJgnnH9mLrcdo/XWHjFRTWhexEM/oL6qDZfpTwa0N/yCsaPQm5TUsM6b9BhM8sRjGX26tj+hS/WshiyldBastJfZHz4Qzih6jBr756f8MQ2oVOFWJNd+rXrAVuwRAuL/UZGUd62jIW7jj1v7xtX8Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186171; c=relaxed/simple;
	bh=mJEXACtJJKE9hfASIiaItd/yrAoWR6SIqY7FEDakImQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlsTuaCCs/PPkQLK5dihR+wFem+yVlzToi4JeifgS8RgDRdGIQ9f7bLtzeSi+Yw6g+qQ/x4N+j7onAH6+kO7mhZNI3n26C2whNnpRTLaES1U+sqldneN+zVr2ITfbfyZIESldv5qb7Adge13Kr1yj+5UgepGfrk7hj6SOmeEWYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=dapvFczM; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e894b81678so34259466d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 06:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1741186167; x=1741790967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Rjno7BmkI/tfrolSaliBAaOStc/W9LN80z3rGIlnEo=;
        b=dapvFczMlikl8wEMIxqtFgcwwk2VH9d4/nsr+RLNAD6O3klopgE4WHQud0SgFVdqDH
         jqTmVoZErRuNVOGiFIdDzlCNU78Dk3DaM/3uoOEKF5DMgQ93rU9k5i2qa9aW5EeELB5c
         dQVtq0qM/7i2q5CbohW9qPowRNoqUV7ESnl+ZMQOk7Y8APd28VuMBTc0Sr8lMevy81pA
         9OtWRE+GU2Zy0SsgTDxrv1wJRYzmBPcFn0cAFx9WPSUWeJatJpKwtNZLcWmN0r0wlATl
         RdITE6SHovlAiDbvnGrf0cBhBw399Vipi3tCp1i/4/LbLAZhUuAGG1RKCPI+omr9i0wM
         kHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741186167; x=1741790967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Rjno7BmkI/tfrolSaliBAaOStc/W9LN80z3rGIlnEo=;
        b=sXtk7aZvURfgkM1rJ9Wk7g+oIj+IKuIETP/AAaGpRJSq3L/3a/Y2Ss0o8I28S0uuPB
         /dYEcBlBhcrMaiJtoZY0gGMcJIBLUyIFaHXhhSDvRSYjXXZoBKq57l6tGttvJCMFvzh5
         yGWkNzL2tw4VXeEbrK2nwi3gDJy78zYGbzR1pXqlJEAN73wvxH3AFPrjIGx5lbrit4Oz
         JiE0FptVRl4HpgTAoUi8Xfrm4KbdDiZZOqFSWX0krWcF5BGwhHfwrYzkcaeKrTHIeDW/
         3+07fZ2L6rg9HMXZrTOq6bj/VsnLTJinF6nr+YeT8Gv1LAvoB1QJN59wcATifQWz8i++
         gicg==
X-Forwarded-Encrypted: i=1; AJvYcCVXeftfA5mF/mcVCBit0rT87/qtvziIN7rqVwpCl+DmhQRNcFbmW6hj2TSVdO1C36T3R9OwrC7YOXGZUdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzecqarNXaO9SlXON6QEqPuLO00mpAT9PLp3Hg6+mZlF8dwzlnG
	bcaetWWWM8sGAOx6HoVlnxkClla7SwrqnIPDFFACgZ0PZLOPVaHpCSD7RpTFyHM=
X-Gm-Gg: ASbGnctHwjH4QTKAznxPKKKi8B5AzGnJjrHBXnG+RbDl8aUV07C+0OIrI22V1tV+Bln
	C+TRmLEVC1RplIXFiyBOdsGRaSbFoeFiZRspNcuh52qxfKUWS+nGdlIIq9RUdCrPDSp3QqY0U7z
	QKSWLVAExvGvCMe7HN/hM/pv2oXD6a1GOFB8l7ZgOvcs+gzOQ5luK1NmFTXB9MZ3Oe1KvHx+a4z
	GFr/WhP3ZACTTugtP78zEJ0ZJSfXGGy6KZYtZGIWy4SAWqhNCmOGJEexwa2JQPmt4M/hgj4gX9e
	lV4SJac0dSEYm3COdF+RTLA5dI8Gf83v2W6T7XSyywU=
X-Google-Smtp-Source: AGHT+IEh40c1fP8s3ecae2i4XFiJVm9EMriTA5J7Oj9VZq9Az7S5iDaLD4nyxicX2EPTjgnrnyjDzA==
X-Received: by 2002:a05:6214:2504:b0:6d8:8a60:ef2c with SMTP id 6a1803df08f44-6e8e6cc5b2bmr58784106d6.2.1741186167610;
        Wed, 05 Mar 2025 06:49:27 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47505a370acsm17639491cf.69.2025.03.05.06.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 06:49:26 -0800 (PST)
Date: Wed, 5 Mar 2025 09:49:25 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable 3/5] mm: zpool: Remove object mapping APIs
Message-ID: <20250305144925.GC185622@cmpxchg.org>
References: <20250305061134.4105762-1-yosry.ahmed@linux.dev>
 <20250305061134.4105762-4-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305061134.4105762-4-yosry.ahmed@linux.dev>

On Wed, Mar 05, 2025 at 06:11:31AM +0000, Yosry Ahmed wrote:
> zpool_map_handle(), zpool_unmap_handle(), and zpool_can_sleep_mapped()
> are no longer used. Remove them with the underlying driver callbacks.
> 
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

