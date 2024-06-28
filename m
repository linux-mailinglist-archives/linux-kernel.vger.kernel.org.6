Return-Path: <linux-kernel+bounces-233268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB7791B510
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 04:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0F51C219FE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 02:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82BD18C31;
	Fri, 28 Jun 2024 02:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hf9KSrPS"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640BD18046
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 02:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719541346; cv=none; b=UgzP1dUUmyBHGLBh4q1INZGfbaoFq+IE3/+fPSczgdkJT2VILutjUQrJTjMvh+r8jBfGJ40emr5KLrTXz09Lu5ilssG03o9tbmH7jo3/w3Wg8vjKSRwUYPwVxGFdsAoBmf3QzFm/4c5VKrZObNh1FHRwSnSIlRgoieXMda+6tCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719541346; c=relaxed/simple;
	bh=zcxnldfNeqNg1S/9+A/HSWxLzrKfZNK+wLswGlM0IOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lze0hYVijbrMsCYW3NU298bIXVLXzTX1jGhd0xFDKnFdvicklCBl0/YLOzLFd+NbODJhGxffm23GvgR1M+Tlv7BDpmuU9WP+oFtLLqvbZ3wjZPBY21G4ok3akZujkbnMbEO8KjYuDFzfdR+CPMBREkJIpVBOh5fCT9geVHQ1QtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hf9KSrPS; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d561e564d0so76811b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 19:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719541343; x=1720146143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hVxz21dbKRa8K35SUlK2JJeWf/rQA8jAFy3VGCptuN0=;
        b=hf9KSrPS2v8aUX23Ackw5Z5nrCS3/CcYM9tvD5uqXcuPti6zbPHwx9r2rNr0gbCOaz
         m13CrpoimVbhv1QN+vQjjx2eK7QJHzH5ljxC5xKjZAx//Uu2Q5P8Q34wpCHJKH5cSwTj
         sym4cfUFsRapcZuHA6fXCp7Fa5TYGFEvMStlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719541343; x=1720146143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVxz21dbKRa8K35SUlK2JJeWf/rQA8jAFy3VGCptuN0=;
        b=prsy/5mDWaOv+5Tqz1tZyMcOvy/EfbJaIPN7LGDhPdfMopNvOdNx0kEp3I2Le/UY+7
         jY+/NR6+FkeNSBk65xGjk15T0q0pL7t3qkFsY400UobfWvtcaV+TDw7q873VeSVD6RKw
         3Iej1DsKjIctsQnlHSHvD13w3kg+gURhGPgMS3QQLNbCASKnKpX66SZ+g1gv3o5ARhxA
         2huSdBcGQehDmiEtDSHkmFS3rnTdSblu2H3RoMfyddnaDBsjF9lv9p9NOSeHQ+jR9CAx
         BZvfF5DNFxjM5eBmtO63EZghuV7MR8rPPE1L/9tEQDfMt3xernT+2/yrz+XwSQCQJRGS
         XeLw==
X-Forwarded-Encrypted: i=1; AJvYcCVURpI86Cb5iG8ewH6u7t8kwHzHdzacS4eTq1Ay62Vaj0nIfjLEIbt8ZkvazobsXrxCMLS/vJLpEJF+Qu5cQT1emtUheQc5oGVyrPOm
X-Gm-Message-State: AOJu0YzrbqqZs+xx3u1t+c2i04ocXr1VD6PdhQsxsJnEVU2g3jXTgHlO
	dFYP/EmTlFP/OthmvBPQGOFNyS8HEleR2Y5fYTnZAdugXNcpzP85PJ06uUS0Fg==
X-Google-Smtp-Source: AGHT+IHcJkuyyKYOPFcF3S9TzhD4NfoyJqqa31mXZ6JF3GxCl8pmGORtv9tjXlHDsEHwneXRdHBTgQ==
X-Received: by 2002:a05:6808:1822:b0:3d5:1eba:10b5 with SMTP id 5614622812f47-3d541c5062dmr19251439b6e.12.1719541343373;
        Thu, 27 Jun 2024 19:22:23 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:c19a:b9a8:4bd1:72c0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803ecf950sm412002b3a.113.2024.06.27.19.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 19:22:22 -0700 (PDT)
Date: Fri, 28 Jun 2024 11:22:18 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>
Cc: Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] zsmalloc: rename class stat mutators
Message-ID: <20240628022218.GE15925@google.com>
References: <20240628015154.3230389-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628015154.3230389-1-senozhatsky@chromium.org>

On (24/06/28 10:42), Sergey Senozhatsky wrote:
> A cosmetic change.
> 
> o Rename class_stat_inc() and class_stat_dec() to class_stat_add()
>   and class_stat_sub() correspondingly. inc/dec are usually associated
>   with +1/-1 modifications, while zsmlloc can modify stats by up
>   to ->objs_per_zspage. Use add/sub (follow atomics naming).
> 
> o Rename zs_stat_get() to class_stat_read()
>   get() is usually associated with ref-counting and is paired with put().
>   zs_stat_get() simply reads class stat so rename to reflect it.
>   (This also follows atomics naming).

I think I will resend this after Chengming patches land.

