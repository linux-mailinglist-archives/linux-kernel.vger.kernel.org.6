Return-Path: <linux-kernel+bounces-194940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181878D44A5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 07:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D92F1C217F1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 05:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824E714389B;
	Thu, 30 May 2024 05:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eI4FrrA6"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8258E634
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 05:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717045290; cv=none; b=GIrw71qJrD6QyDhcFu9ZWc/psMm9jLg5nF0dWSc24g1rq22+aquxuJRXOKijfSz/11aJ3B42rOSuU5beD1oeJ76Ynu1987Wj9Ua/kmpjX10E1AxjKy0aAVnTYZkShPfYWA7Y/LUN9f+Sjdln04w06ZdiiT6A71wWUv2WKkFdGYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717045290; c=relaxed/simple;
	bh=vRYRVj2yHwGKHI9c0vlZTFqbZmmt5CpYXco37xWR11U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPb94w4pwhuE4OffrhwGUm48QwkpPfzd5J36jYo3rzY6t5oX0WOG8DAbSpaVdIy3QpPIMfNw6tGMRNfptbjITiAQac3vmhzJVZtCzdaDKuQnGGGn9+gWUG/VoSvjpDhB0WRprotXAEmoqfERAswWHIjDTpUZZJ3PrDh+R+iYI/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eI4FrrA6; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f4a52b9413so4175585ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 22:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717045289; x=1717650089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dRdNEjxzIM5Rgcd8TIZIbz07ixws27VOZGX4oVc8Qwk=;
        b=eI4FrrA6ZBnZ4qSJNpM4PajYoOJIMH6VpW3dx5U948jnBCXmJ2jma96LZhpEPh72Cr
         RoqspLk6ooN0IHw+OMSKoS+u1sVWOUU8p9T+qJU42ju3CbP4wp2kFwL9KNLMeZIwsg0K
         lt6TrkpehXPGsGofTMzeK3LBq8JHsR+HKmFCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717045289; x=1717650089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRdNEjxzIM5Rgcd8TIZIbz07ixws27VOZGX4oVc8Qwk=;
        b=rssGiDKqyNbLncf20nWpnmoVCIYCyS2am1TBW/wBHT/Gq+Fesf/2j5qS6x81qQQ9J2
         IgMDJmJAv6S8nNKC+eHrquetUhWSvOIMxr/jCEmIrSVPf0pythfI71iGwTB91MRef/S3
         N2aUnlkdtldF7oLoMbeaoXfjGuF9UxhX1Ts0IB6LJJnRZrwYbSDmqs2T+pLxO1govk/e
         YWvAsgBIhRrJ014jUVowWeQb/ZyFSrhGXQgjm8vDgfhukRTcvvnJ+/EXiloWJcKon35q
         sHnSGSI3O6ZnnMEXPds4JrUtsQtKcNjR2kmqKDcIF7D29RbxAmzsGWRpUh3WY7MIH23S
         vnsg==
X-Gm-Message-State: AOJu0YwHfQ4oFxwCORivmRtjBbQsWbGre3aNh5hKq4UeWbR6jC8vuK39
	eqBZ8VKvKULlPDDg/gxkdGxesPiCmlHxKh/HqqgJ7uaob7PcQgyYJu/01p6iyg==
X-Google-Smtp-Source: AGHT+IGBR7/UV6FYMP+J1U4nmRVzd9ysxLjhJ4Lsndbi40JaRdq5hR2YnRps4qFoDo8mocVy6VgchA==
X-Received: by 2002:a17:902:ecc6:b0:1f6:226f:cc42 with SMTP id d9443c01a7336-1f6226fd024mr1831595ad.43.1717045288628;
        Wed, 29 May 2024 22:01:28 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:52e7:354b:db96:c366])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c97063asm108726795ad.150.2024.05.29.22.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 22:01:27 -0700 (PDT)
Date: Thu, 30 May 2024 14:01:23 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>, Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH v2 3/6] mm/zsmalloc: use a proper page type
Message-ID: <20240530050123.GA8400@google.com>
References: <20240529111904.2069608-1-david@redhat.com>
 <20240529111904.2069608-4-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529111904.2069608-4-david@redhat.com>

On (24/05/29 13:19), David Hildenbrand wrote:
> We won't be able to support 256 KiB base pages, which is acceptable.
[..]
> +config HAVE_ZSMALLOC
> +	def_bool y
> +	depends on MMU
> +	depends on PAGE_SIZE_LESS_THAN_256KB # we want <= 64 KiB

Can't really say that I'm happy with this, but if mm-folks are
fine then okay.

FWIW
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

