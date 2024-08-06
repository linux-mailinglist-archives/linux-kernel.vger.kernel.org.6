Return-Path: <linux-kernel+bounces-275890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD0F948B97
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8EFAB222BF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CC21BD03B;
	Tue,  6 Aug 2024 08:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EuBriMw9"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F9C13A884
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934153; cv=none; b=nKLIq6bMd7zGO1gGlxEMIwLvuBGMy2YLlDToCpIPCMG8/GMzYraLLRYctpXxEA1EothF8YhC09xD7QWh6gB2Go9Ht/3IWEn4Y3VWAmpkFC2oufHoS3uGtEpk6kN0V+BQK83K5nJLmimdM4M9wuRXefoJ8OI5NEMYnzP5cixBQpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934153; c=relaxed/simple;
	bh=5zAkVBagDFzslKPpZR9Yd/kAJfxA8zwkULqrhpfrHd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBSr+zwsgl1vtonxBgP9TopT0Rn0/cYnYFxfgaOh89FrsMBthLO1WWKK4LxgGw8EDW4gNWTWD81QQMkT4e8HhQQp6fD7PTh+tjX2v/aTb4bW9At33JT3+GnDor1+XwhVkVkM04WOzXrbNNYvV9ox/EZo6t9n3l6tktsXNIGJW+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EuBriMw9; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52efd855adbso659587e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 01:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722934149; x=1723538949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qRhPxvIWWUID4A00j/jeUZaqh6VLf4YFR4EWgLZ+bUs=;
        b=EuBriMw9CmEhCM2DmzdHRmFbatWwpbHMTKTZvQ5RpRy/BeCHR2t6cOD1jCxsJ+D5Q7
         OXoC/mKHtJqPLAI0jpQWZ/OGgBhncZxzn0r5JR4Dcw9miAgqkMdF6yfGUHMOjcrqa3ip
         qob5fEMdEyIxzdn/gAPp5ctl8r9lTHnak3cH6KyaU6YHXNlOAJceRRoKtDWT1qDZyxb6
         cCm3894/Hjr3Y3bLFrjdhYElCKhColgj5I1VjdxXIXjXPRk4O2UgbswXRH3rD9K+YL04
         d4sX5GTdlCIi+gxhyHeMFbldyMkzTmOB0L+mnD839m2tBDdNDzKcnjVb0MCenwj1Xbcb
         l4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722934149; x=1723538949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRhPxvIWWUID4A00j/jeUZaqh6VLf4YFR4EWgLZ+bUs=;
        b=IuylulF5j6e8uw/k2XzWKdwjsTj/ttiINLhmCNimfWSJ8NYIaYYUYb9MCbfQVeFxrG
         IbhpEEBQACGoJxHyXeeLZer1kRhx8+8C8Pm+g7VXyUJ2A/VJwtLrrEsW+ldUYdTO0Iyj
         Ox3+NtEis8iD4xAcUZBvcUiJ+dtZMUjzgtSe4oDKbU77b4uuEHxn1kH6uZiYN51w8/4l
         H2t1NLxWqMzYnd4EmlFhel4GTgXO7UgkIxiAKHE8mVasnvu574qjAZ06e8SlEMUwhkbw
         0QQgMY215FM4Xsvv/JS6po31SavyHWqS+HkxfyFMI+UwSRZGmuYo8bB5XZNmS8sqmP/6
         MKnw==
X-Gm-Message-State: AOJu0YyjmtyC9z3N9oe7hFwADNzbqUzeDycsZ/p0Jj0C4U+dctTuwQSz
	MN6IrhgGF2tvp24SlKhZzUcniXusYYaXMEDKw9GCVLPirm0Lw0blfg1f99TGMhoqklARHbkvSte
	B
X-Google-Smtp-Source: AGHT+IEQRBAQ2GpIg69SuXLJ4vnce5P+L4csGP2lK/uGJ18+Xiu3JWYMfrcYpRpFtSrEbyn9+Csbjw==
X-Received: by 2002:a05:6512:3502:b0:52e:7656:a0f4 with SMTP id 2adb3069b0e04-530bb3a35a9mr9836507e87.41.1722934149009;
        Tue, 06 Aug 2024 01:49:09 -0700 (PDT)
Received: from u94a (39-10-26-251.adsl.fetnet.net. [39.10.26.251])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d6988421sm2098270173.32.2024.08.06.01.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 01:49:08 -0700 (PDT)
Date: Tue, 6 Aug 2024 16:48:56 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, cve@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: CVE-2024-42082: xdp: Remove WARN() from __xdp_reg_mem_model()
Message-ID: <25rzouzv3bf4opsbgcbwjn3ycip5s75awl5muu5fzcibwjnv4b@4khlyuarrnl5>
References: <2024072956-CVE-2024-42082-8411@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024072956-CVE-2024-42082-8411@gregkh>

On Mon, Jul 29, 2024 at 05:53:11PM GMT, Greg Kroah-Hartman wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> xdp: Remove WARN() from __xdp_reg_mem_model()
> 
> syzkaller reports a warning in __xdp_reg_mem_model().
> 
> The warning occurs only if __mem_id_init_hash_table() returns an error. It
> returns the error in two cases:
> 
>   1. memory allocation fails;
>   2. rhashtable_init() fails when some fields of rhashtable_params
>      struct are not initialized properly.
> 
> The second case cannot happen since there is a static const rhashtable_params
> struct with valid fields. So, warning is only triggered when there is a
> problem with memory allocation.
> 
> Thus, there is no sense in using WARN() to handle this error and it can be
> safely removed.
[...]

The mention fix (below) simply removed a WARN_ON(1) call, so I believe
there's no security implication here.


--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -295,10 +295,8 @@ static struct xdp_mem_allocator *__xdp_reg_mem_model(struct xdp_mem_info *mem,
 		mutex_lock(&mem_id_lock);
 		ret = __mem_id_init_hash_table();
 		mutex_unlock(&mem_id_lock);
-		if (ret < 0) {
-			WARN_ON(1);
+		if (ret < 0)
 			return ERR_PTR(ret);
-		}
 	}
 
 	xdp_alloc = kzalloc(sizeof(*xdp_alloc), gfp);

