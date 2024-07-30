Return-Path: <linux-kernel+bounces-267176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD8E940DEB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92F11F2445F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1679F194C7E;
	Tue, 30 Jul 2024 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T/rN/GrF"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10539194C72
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332323; cv=none; b=kFVCai2WKTa5m25VKk8VO1N5Q2V+wByDWpVjCsC6iZy3VfyidkWHDXVtK7nVj05L5vqbVRE/0cVQ5rQl9xpabaQC2WigyA6j/1XRTwjMe6aBcZvncLVkD+MxuyqMRpF1fv85eEZyVQtwSS/oJEBJ3qVJPYGzWt+2/uFfaTCnTMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332323; c=relaxed/simple;
	bh=AJHPNVS3Ogb1QP4Rz9x87791+WRjYf65t2lTLg1uSpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWwln3O/D046u85T7UX1PFgaLvoym+Dyw+IC7uk2djmXhgxmNzteCKZIyBJqYb6SMB+LRyB6nQYGqImbqlueD6Z9MgiHSa8tUkpXkbVvFPVltrGbN+iiOGL6ay252BpjB5o8hibL9UeD+AZSDqt/VqmHjAQmx4WN6QPJNEC259Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T/rN/GrF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fd66cddd07so27565075ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 02:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722332321; x=1722937121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gNel8wBgzZxeqPt37Zzi9jufIa3B1AS0eleyuj5OMgA=;
        b=T/rN/GrFull9ps0Y+tuDg+yRi9gu/lHlrl2gSmNetDTVW9QF1LCdMnnrWbgNkj7J0N
         BuVHX6nn0XTdkJQJBwIz1YSOqbSeFcxzHq/9ocu8gJY5YZfer+gJq8ZMyANUQU2HAD7R
         GkPBRQA5vqhFFdCgo/ZbS3z/T1qu2pV4ylQ+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722332321; x=1722937121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNel8wBgzZxeqPt37Zzi9jufIa3B1AS0eleyuj5OMgA=;
        b=NuKBAAmzeIuW/TvCMEBTY8EMyiC/qETGlNV8rWfklKMMJaFbo+vjjC0qOSVbyJTB8L
         XfGMUtYbBWOv5S7LeBj3q8Yr/CZBBjooMNsRtOYMUkTOrJ86ZLcjzfkPHBtU7/33txyX
         PvEtvwlTqi6ETT9dKk4EI5MlCFu50bljPWORRErTekPGbaSpqscErDGstY4kcl605/bc
         3LDx6gPzyXmn0GRrzSMO5vaNd2UW/SAZOu3yr9MAxq0mYvFOjXZaHB5kewska/b56sq/
         v1ZsjiwNFq5csiejlAuO6hE39QTG9EDIIG3DFgaYSg/tHSE3BTUKQ2WE+B/8RGELzCJ7
         TSLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWyFdLfMdwfaXFxEsXEdQjHWjO9j0W4qSsrOKT1fiVf2ezevbBVaAdv/I9tOywRGulKO8xybLGDiqTuziOzkINSAaBqQ3ikV9y2Zra
X-Gm-Message-State: AOJu0YwnC0P52dPejg+AM751vZ18OGjd7p/366nHztMGIS4GGhei5/Fl
	174CjRNah/Hv5827bU7ohiDavor8aK1unIEaQqy5XHAGEFqWfK+aTLXhV+csHQ==
X-Google-Smtp-Source: AGHT+IHmvw9M9mYHlmCHrEHJHZFKj6cCVhL/T7ZPTzDotMkupEzWsb2qP9z8ZR2AYu2+3UGC+Sacfw==
X-Received: by 2002:a17:903:2289:b0:1fb:37fa:fedb with SMTP id d9443c01a7336-1ff04805bb5mr87312615ad.10.1722332321341;
        Tue, 30 Jul 2024 02:38:41 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:a51d:b844:f0ff:3c91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee13easm97345305ad.130.2024.07.30.02.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 02:38:41 -0700 (PDT)
Date: Tue, 30 Jul 2024 18:38:35 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: alexs@kernel.org
Cc: Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	minchan@kernel.org, willy@infradead.org, senozhatsky@chromium.org,
	david@redhat.com, 42.hyeyoo@gmail.com,
	Yosry Ahmed <yosryahmed@google.com>, nphamcs@gmail.com
Subject: Re: [PATCH v4 03/22] mm/zsmalloc: convert
 __zs_map_object/__zs_unmap_object to use zpdesc
Message-ID: <20240730093835.GC16599@google.com>
References: <20240729112534.3416707-1-alexs@kernel.org>
 <20240729112534.3416707-4-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729112534.3416707-4-alexs@kernel.org>

On (24/07/29 19:25), alexs@kernel.org wrote:
> +static inline void *zpdesc_kmap_atomic(struct zpdesc *zpdesc)
> +{
> +	return kmap_atomic(zpdesc_page(zpdesc));
> +}
> +
[..]
>  	/* copy object to per-cpu buffer */
> -	addr = kmap_atomic(pages[0]);
> +	addr = zpdesc_kmap_atomic(zpdescs[0]);
>  	memcpy(buf, addr + off, sizes[0]);
>  	kunmap_atomic(addr);
> -	addr = kmap_atomic(pages[1]);
> +	addr = zpdesc_kmap_atomic(zpdescs[1]);
>  	memcpy(buf + sizes[0], addr, sizes[1]);
>  	kunmap_atomic(addr);

Don't know if kmap_atomic() wrapper buys us anything, but okay.

