Return-Path: <linux-kernel+bounces-309103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1B7966638
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 814D8B253D4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2711B86E1;
	Fri, 30 Aug 2024 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxuXWP29"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C1B1B4C49
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033372; cv=none; b=m6D9D9q4NjF/SKyhXLJ+YaU98CY3N1/aZUvBOSCcmRxP2k6c+S+CfmUNi6VXHyeZnSPhT3XcEx8tIweJbtY0neDyQV5Xoi98fGkNvwG3IvKGC0vz486CR6CtyHnz73+/h6eaS3tZ0xv7xEHA5YsRt5H2Bi40nJCLZHpRaMqxKcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033372; c=relaxed/simple;
	bh=lOyTp8vzOGkC8EqX4NxLMP4DhaKdV5Mvt3q8gHsnW4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIU0fAaN3oHSyLOJ3V7yt5xrSzpCqlraWkj75RGUJfc0FkBgru+I9abPNgVGcjwKN1x2AqNGooD7mYrwHiKc/gqIDrjCwQ9CDGEq9qRS21ptiJb/+c0B0B64SsimGKpkc7c162zoTGrbwK6iAkv1xkZ19A8DJudVebu543ShMGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxuXWP29; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20203988f37so19551575ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725033370; x=1725638170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mhd4d0nqZmfe5h3UzwABiskA2QHsJzZaGLNGBZFL244=;
        b=bxuXWP29/pUCVGfIni7Pb2/bKrzRVNsMskLWoXrsYmFoTGbGpT3k42p8F1eNvc2lDf
         D0z6XEfWyzIKYqHOYXX2/4fX6xPcfM6XxCm/pwvdEWjlxPkE3zGwX7j7NK7UxlkSsrnX
         bFpTbwToSfSdEiVbHoZUyG5mr4ubIku0ua9eZWrr1bwb4IdAaPqY46tkk0wea8isZ9jC
         UWj32GhitBgxUOPdViyPYldibkOu9QFam3tvZX5o2Qrx0lde48Co2W37tYhFMWnjwKGI
         et3gLJtPGEx9NB8uTOnn1esRO43DiOaXEw0OiYC9BkFTzk+fbR+RZZkFxBCGjvR4Bmm4
         5riw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725033370; x=1725638170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhd4d0nqZmfe5h3UzwABiskA2QHsJzZaGLNGBZFL244=;
        b=ip4xkeNggudPdTOcexRfqoMsDeenqL+z4RPuOuDhCBkgcguBFrtwAF8yHgXmqJv78d
         mLIAj3JjAOHL8AZ/goIgh8xmXKsupQ/hQQd95z8qCRHQXRfWFCgIXtzXRNZwXGBtrBvR
         KG4/a/Eh1v+/sT4g3cSHi2GtQCx3GJYvJh73BRme55jcVtBAKijayE1mNDiEyb2KsTVm
         qs4NM8Ee1fvISEjSIcj/vm5tTY5DswCqIxoAmluoHjroFIBkG24JbLrruzDeDy5JuhXg
         k3FAGvZ7Y+rF5/2a4WdKD+aH3D/Lz+lLFHMT8bjS7j6ZHfcAEf1iKPrjIR/X6NgEMVC1
         ao0g==
X-Forwarded-Encrypted: i=1; AJvYcCUTaSJubuqlzfAB/HXocEb6TeS39FVih7zn+5AQp/kQ8LhueB1Ru2DyvVqP3S19idF6wFTWJHnPQM2t1lI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTjoHF7e20LhwhTHbKE2BmvIhdLHCKPBm/rScEp09DpDAgbiDU
	MDDa+j5p7zecjQ/ey2RiMPCMmPfZMdROAz8j2Kn2OowMc4MC++TM7cZ+zb5W
X-Google-Smtp-Source: AGHT+IGdasXD2+//sTiPlh5huaaZSW1sY0Ul67pCN4Am3d365YaZvhBNefyFK7m/aiYY4nHq7I4UjQ==
X-Received: by 2002:a17:903:40cf:b0:203:6c70:b8f4 with SMTP id d9443c01a7336-2050c474437mr59070515ad.41.1725033370066;
        Fri, 30 Aug 2024 08:56:10 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152d2b3bsm28432005ad.66.2024.08.30.08.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 08:56:09 -0700 (PDT)
Date: Fri, 30 Aug 2024 08:56:07 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] lib: Extend bitmap find binary operations
Message-ID: <ZtHrl_1DEku-VeQV@yury-ThinkPad>
References: <20240829135926.926603-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829135926.926603-1-mathieu.desnoyers@efficios.com>

On Thu, Aug 29, 2024 at 09:59:20AM -0400, Mathieu Desnoyers wrote:
> Extend bitmap find.h and cpumask.h with additional binary operations
> such as "nor".
> 
> Also extend the testing and benchmark coverage of those bitmap find with
> binary operations.
> 
> This is useful for NUMA-aware rseq concurrency IDs which depend on this
> series.
 
Hi Mathieu,

Thanks for the series! I appreciate your time nailing it down, and
especially the tests provided. A couple nits is that we don't need
an 'extern' specifier,  and would better avoid local statics, even
in tests.

I'll fix that inplace and apply in bitmap-for-next. Can you share
a link for your work that requires the new API? I need to point it
when sending a merge request.

Thanks,
Yury
 
> Mathieu Desnoyers (6):
>   lib: Clarify comment on top of find_next_andnot_bit
>   lib: Implement find_{first,next,nth}_nor_bit, for_each_nor_bit,
>     find_first_andnot_bit
>   lib: test bitmap sets binary operation iterators
>   lib: Fix test_find_first_and_bit and test_find_next_and_bit benchmark
>   lib: benchmark bitmap sets binary operation find
>   cpumask: Implement cpumask_{first,next}_{nor,andnot}
> 
>  include/linux/cpumask.h  |  60 +++++++++++++++++++
>  include/linux/find.h     | 124 +++++++++++++++++++++++++++++++++++++--
>  lib/find_bit.c           |  36 ++++++++++++
>  lib/find_bit_benchmark.c | 103 ++++++++++++++++++++++++++++++--
>  lib/test_bitmap.c        |  81 +++++++++++++++++++++++++
>  5 files changed, 396 insertions(+), 8 deletions(-)
> 
> -- 
> 2.39.2

