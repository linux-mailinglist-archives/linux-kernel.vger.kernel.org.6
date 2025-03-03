Return-Path: <linux-kernel+bounces-540897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9069EA4B633
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A491C169F29
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8B116FF44;
	Mon,  3 Mar 2025 02:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GTpOSCuZ"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2814713C8E8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 02:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740969756; cv=none; b=PzREj7l1qofF86iO1IS8tExaMCJJpmP488hM1CSA6P3ZxiqJtoVrhFdN5OrpwSrcqEw1b7frwSYNwIlBRnBly4UYVSMA9XyDCh5gGNUpAVcdjDkDIO5BEBgpmjVwBB+60XyKlCXcbCU9H1jbUazdA0L+h+KburrasEahb2LKJog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740969756; c=relaxed/simple;
	bh=r6Z4B7+/X7jtyEHpY0gy9jXJoCrvWdOYHCQHgq4RQTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgeU/rwA9fGDAqAhCet89sy5SeSMC865L3xlTzTbk8vq8T9W6huWdD4M0PlHB4Had3otOsEP/mS6v4sXoSv10gdEHzd/zc7oiNoTsliQuhsLWlAy/hxUmhRL+weYASpD+MaEtu17LvFsnupeQoeb+jPZSr2YFMG8b6SoxeGNuOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GTpOSCuZ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2232b12cd36so51412245ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 18:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740969754; x=1741574554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Eq1Jm9nTipKyg498okiimxlJb53FXR4hBqUwQ5lbqc=;
        b=GTpOSCuZvxKQxn6oedcdWjBfVD9Dm7rPwjRPfrMggYRv+RcDzMGSM45b6i1VQ9MoKP
         /v/UQtWTeGfkUbuSZIWb3k0tQfLQFYYIsTA1T5akuvq1UtWOOg9PmEtbvf4JiU8A251u
         rO6YanH0rYFATScz30HTxwQIjryMv7o/3Vfkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740969754; x=1741574554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Eq1Jm9nTipKyg498okiimxlJb53FXR4hBqUwQ5lbqc=;
        b=l5FsB3cyc+QZxpu/4HyYcOA7pm7oZf3DcPc1FzPHAdZaE2MtsYSfA4Js4gas2IJYxq
         YyOIaQflI94IDLTISkCj2g4f0BN1qkfzK7IlCrqaF190KZTPfJDyFuY61lcshts/u1JV
         lEDs1vjfpN/fpjVoWaTw8PbZwFQk6oZWpH3vVl+6IhOad/xCM3w9BSD6xDSLuco8T4gu
         DYVl+aI0OecGiLE4rthBBOWOM4uUM0YkzOEtYr04CEie+LLcHZsWU5U0U5vT8aegAHJi
         5EtZek6WCu7sIx/Ek85LyY3WrXoPr5MGOyLcuBsldklJYEuYpqrh6my9lik8opki0xik
         i54g==
X-Forwarded-Encrypted: i=1; AJvYcCVGDlKUnnwxgNjsEH/da7+TVooyYw0xcT0WzDZYlcltAekzZ0oQPDpRywwbCVy6o6bzByd9doxOIKahFE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrzlKL7177Tlo+QYalNGLAvBChozyp39GjyrIpgWpsQ1dS5AJW
	o6T22J6gBVV1LwqDr5hFxaTV2+OEd9jHCkB1//ZpbR5/W7XjIm9+60ht87Bl6A==
X-Gm-Gg: ASbGnctrG/KvyEti9fW7vQ7pgE45fTMt88PUiFVYQXW6DXn5+N9lg3AQjV5o1P64/w5
	4d0h7B0KYHbU8IftC06iEgBfglIMOdd+1FQlssWiWESuCWa0cNBP7vcOIzb8PTLBcSf0Wnj72je
	m01mYfuYEmB5tkvDrZTscJnnDqTlUF49lZILZRrxycmTmR9Dixkrchj7CeSu/Cst2L5vKmIEq4R
	oJPb1vJZntNLH1uorhMgMlbnjk1RCqEiXi4UcClZvzY8mJi63RtTu3r7cxFjbxzRTso2Bhe0Hac
	osV5dyYs1Px8GMsA3YJfp3fSW5Qdhgau3D8ClSg2dAeLJMyj
X-Google-Smtp-Source: AGHT+IHFCx5QItcKe2emKdnH2UqMC291YHcrn2qE7hpTfsgRWGbkJ+HqoI5r36ycsN1pfGu0e3g0KQ==
X-Received: by 2002:a17:903:1988:b0:223:47b4:aaf8 with SMTP id d9443c01a7336-2236921ed16mr153813725ad.52.1740969754329;
        Sun, 02 Mar 2025 18:42:34 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:1513:4f61:a4d3:b418])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7365478bc85sm871929b3a.160.2025.03.02.18.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 18:42:33 -0800 (PST)
Date: Mon, 3 Mar 2025 11:42:28 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, yosry.ahmed@linux.dev, 
	hdanton@sina.com, ryncsn@gmail.com, bigeasy@linutronix.de, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v9 14/19] zsmalloc: introduce new object mapping API
Message-ID: <jupqosjamzyft2vqknquppeozs57xkgfy5pnr6v2qrh4duf5ik@6mwtww5yl6tu>
References: <20250227043618.88380-15-senozhatsky@chromium.org>
 <Z8K10w-6fIpDhYc6@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8K10w-6fIpDhYc6@gondor.apana.org.au>

On (25/03/01 15:22), Herbert Xu wrote:
> Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> >
> > New API splits functions by access mode:
> > - zs_obj_read_begin(handle, local_copy)
> >  Returns a pointer to handle memory.  For objects that span two
> >  physical pages a local_copy buffer is used to store object's
> >  data before the address is returned to the caller.  Otherwise
> >  the object's page is kmap_local mapped directly.
> 
> I presume this buffer is always given to the compression algorithm
> to decompress? In that case there should be no need to linearise
> them at all.
> 
> Just return a two-entry SG list, and give it to the Crypto API
> to deal with.  Both software and hardware algorithms can handle
> non-linear input.  Yes software decompression is currently
> linearising all input with a copy, but that is no different
> to the copy that you're making in zsmalloc.
> 
> So please change this API to create an SG list instead of copying.
> That way we can then optimise the software decompression to read
> non-linear input directly and skip the copying altogether.

A heads up:

Discussed with Herbert privately, we will look into SG-list API
later (future dev cycles).

