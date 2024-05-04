Return-Path: <linux-kernel+bounces-168525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B678BB98E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 08:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B6328394C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 06:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CD5E574;
	Sat,  4 May 2024 06:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EWuRQ51a"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82480291E
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 06:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714802538; cv=none; b=lj/ZsgRvveRPusgRAPvKwO1UsFvPFmqoilruCFAJsm+2xO2QTAqxui+S5TIdMsc3QDLbtx3yb0oXSDoJyB4ANPV3OGngffr6fnWEfM9Cj7keTpLh+ZTg7aPmA/0ciKniel4SYrBq3bd2Dk4UMQJOcuFkraCvhdi4KGVinKDgy24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714802538; c=relaxed/simple;
	bh=QNxdE8XEnHl6uXZt8I1uundZI1OzA1eNbsJ07NtLMy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNdexWyLCtNTE9y5+JEFOZbrvTQpqfNpP64LS01vw6lKjSgNcuxsap8l7/D8NnOH3nwyF142ckfa5qWxxMhvQKx9gJ3pMTuT1/hp1jN/bLxc0z1KVLVKsvx1a/iB9YIVfbGWYlteYEy85dWMSumdKDe7pZ/WyZjMaWvKTTIi54U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EWuRQ51a; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f45f1179c3so55044b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 23:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714802536; x=1715407336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qRvyWG41PYoYuhLyhTnYN9G8n9dRpCEoa0AKDj0Jn1g=;
        b=EWuRQ51awUZFbsXgacY4XdeoDVjexcBZ0AiO0ZG4XiKxw8X/znsMnObrCFuclS6uu4
         witwJsrzfupeALVjpbgTDRsWOTDWOgNPdnYy27GlcVoq88EJ9Ra9rDw0zr4wQlNTNd4M
         AO4IeaHxauCls9ujQB2oMx7kI8e+X9EVHtggM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714802536; x=1715407336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRvyWG41PYoYuhLyhTnYN9G8n9dRpCEoa0AKDj0Jn1g=;
        b=fJtZ/1aXH06nsjWDcyilOoN+ssiDydcf04p1fSjd+fhI8nXWTSkLKAgisim2Urd6kJ
         JSmO0k/NkQ//8MZDJrntMbHOSjUJlHvTIf6J1u/ucDa+EVd77a67757s3ryPKp6yxu5X
         ZpoW59B4JOCKYHKv+/XKPsnM+sjK2hsLVhAdFvutRl0mqtDMjaaYP0F+Mm6JMMlFeSF6
         mGYZ3c88PmqjRWKroJB4PQsZo1sZLsvdqPOfNK75nkk2sey00Xa5lA+Qm52mKnP4NALq
         rIU4FroRP3Hhd+pGlbQuRYHkjJ/s80tumGq9ZaAH2vF/OE3HdRrkzkpAB4q8ZIEOpD3q
         ewBA==
X-Forwarded-Encrypted: i=1; AJvYcCW3szjzk2cSkwc6WtxZgnwBoOxRYIsvg1tonN2iMCfBRn0KaMe4vMFjDrf0apOdrH1uPDp66zy3FlgrIFwx9Qvzam+FU770ESpjMavb
X-Gm-Message-State: AOJu0YzAl9sCpn/Ndg4jcvP3FWedeUaimBFjLCyUgOqbmz19mdz8sCQE
	qae76ucD+IOwznsbkjVAUy72vpMJGFtr2Q4j/CZmpEL3I7u+GSibalYauI8T+Q==
X-Google-Smtp-Source: AGHT+IFUO+CEFCoN7TlImHtWHusMlMi0XYn0uzySokxZVJLphayei5VRGyym00K3lQbx42uw2RsCOA==
X-Received: by 2002:a05:6a00:2316:b0:6e6:ac71:8b38 with SMTP id h22-20020a056a00231600b006e6ac718b38mr4920802pfh.22.1714802535870;
        Fri, 03 May 2024 23:02:15 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:a616:7211:d0ce:9ad9])
        by smtp.gmail.com with ESMTPSA id a1-20020aa78e81000000b006f454a607d6sm1118488pfr.148.2024.05.03.23.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 23:02:15 -0700 (PDT)
Date: Sat, 4 May 2024 15:02:11 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 13/14] zram: add dictionary support to zstd backend
Message-ID: <20240504060211.GG14947@google.com>
References: <20240503091823.3616962-1-senozhatsky@chromium.org>
 <20240503091823.3616962-14-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503091823.3616962-14-senozhatsky@chromium.org>

On (24/05/03 18:17), Sergey Senozhatsky wrote:
> This adds support for pre-trained zstd dictionaries [1]
> Dictionary is loaded once (per-config) and then loaded to Cctx
> and Dctx by reference, so we don't allocate extra memory.
> 
> The patch is a little non-trivial, as it seems that noone
> ever attempted to use dictionaries in the linux kernel
> port of zstd.
> 
> It also uses GFP_KERNEL gfp in Cctx customAlloc(). We probably
> would want to do something about it. Either make sure that we
> always (somehow) fully setup all Cctx contexts from non-atomic
> context before we attempt to use them, come up with some sort
> of custom allocator or stop calling zcomp_compress() from atomic
> context.
> 
> [1] https://github.com/facebook/zstd/blob/dev/programs/zstd.1.md#dictionary-builder

JFI
I reworked this patch quite significantly in v2 of the series.
I guess I'll post it soon.

