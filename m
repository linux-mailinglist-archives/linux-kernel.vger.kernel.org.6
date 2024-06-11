Return-Path: <linux-kernel+bounces-209174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 819FA902E3D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93AD01C22011
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8295CBA42;
	Tue, 11 Jun 2024 02:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwM0umZL"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477CB8488
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718072066; cv=none; b=uXQTZZC+LZVvpDtz9GLJkU/l2mjWlwG3EG3f1er5jpQw2DPubbKyNLXqEIt7pEOF2+OFH0zrPbhXJnsqq+yKThVq8cOYPY3H223cOQL7a9d+T4239DiEoZtZSWkTpv6vXkSvyClH1AXG879cha5Zqsicpen5BZ5CixzqYKlKBHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718072066; c=relaxed/simple;
	bh=arDgzSOCqXO87eiMavP6lTb9B2d5Tik6rmDcTXq8DSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvdfbqFkp2RA6qFLPYbDg2Xw58RjVArdL6Hqtv0zvWvRuJu6/KP+9irFpt1K47/yWMFyukEX4y90n8H/4/JHj2zMBX+NpWn0ZfohFjE8uCxs1s3Lae3MOviZ9NFt4XLm1u1/q0uMWSaD9omxydxOZi1NIHJrJp5jo6Krb+2S/ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwM0umZL; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6ef64b092cso337809966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 19:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718072063; x=1718676863; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8pZMe5tLOhtQMTyhHDkVRgRGfxx7jB/8jVnL+SLk/k=;
        b=FwM0umZL6m57tYBvGieadFidYzO2VAKWesNVbvHn5ziickQhJjVlKeZTmJBJbjSGHH
         kdWkxolpWBWKQY+h6FZ9uy8lEZ+WMKDQksSbKpVaPMOKx/31RtabQZ0dBuPB+11OKYmt
         6tvi3+ug9UjVPITPVpUhEAfaJBVAXKiDFeycvsLOrZbijmaL5MLm2eFDn0FpC7nVhDGB
         pI08DX1o6gYKtRevtRKrGPX6KwmgWEecpNmedxnWuZhXFBGsEMNu5fQPfifjtMb88/5y
         c26acFG1R0grHI0z/YcXnfxsZbv7Cq/OwvcWKx2LEWLzRBVVwqGXXHvabgK6cXBUvoMj
         DXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718072063; x=1718676863;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b8pZMe5tLOhtQMTyhHDkVRgRGfxx7jB/8jVnL+SLk/k=;
        b=N8ovhLdguWbR5J8eAUwc9os3gvCeyxsc7qi+dqDqx9l3Qh8IZMQQ7LoXZX7sHZoAGs
         T2aE6DhQU/TRzCvs+VpsIxoRaMCsL+//8ZTo5K1hMQAGUYcSjxnm7qD4iOVvWh1fynp2
         hosSvMFfuQnhb0cWw9LNkqt1+QPoNk5Zn5gBrHNHPcaxVbM7OQZ6aIUNln3FfH3VQg21
         BmutvU58vgw+tNmS4pC7V/nRhoy87vrtHn6+y1ltNPSrG3b8Z7C5/l+uV9fk6ZTb1EeX
         i+NYxjyyFUXm9XiMvnLZQqMTLKNgDcFDvoky/duQXZs7YILHJuycKJV87ptzm6Et0HSx
         9ikQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmrlu+SOMVZfGWnVET5Lm51MHYzgEL6SS0tRT6Sh49A8fhu/NpTrUr3NxZLnMhRP8vwW/oqb07RNu2f3BaUMTtVCSydzZndnTe4nbO
X-Gm-Message-State: AOJu0YxVni36+eeUjS42iElIF+D0FRj78aDMbpssvqGEfOVWB0Wnf0Jw
	qtUZzOiTo4tKhwr63/wigxXJMZMDEVnRgpuSVWpaMJOVnLofjddt
X-Google-Smtp-Source: AGHT+IHLndnHLEdIidZRlflhfxTVqBNZR5kp1EjeHswiQ2VdgxapfNGOo2BZUBezZU02I3BpIC4g9w==
X-Received: by 2002:a17:906:398:b0:a66:414c:2abf with SMTP id a640c23a62f3a-a6cd60a189emr763912466b.26.1718072063176;
        Mon, 10 Jun 2024 19:14:23 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f1d862513sm219900766b.166.2024.06.10.19.14.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2024 19:14:22 -0700 (PDT)
Date: Tue, 11 Jun 2024 02:14:21 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Leesoo Ahn <lsahn@ooseel.net>
Cc: rppt@kernel.org, Leesoo Ahn <lsahn@wewakecorp.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/sparse: use MEMBLOCK_ALLOC_ACCESSIBLE enum instead
 of 0
Message-ID: <20240611021421.seknuy7flwztan33@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240610151528.943680-1-lsahn@wewakecorp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610151528.943680-1-lsahn@wewakecorp.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Jun 11, 2024 at 12:15:28AM +0900, Leesoo Ahn wrote:
>Setting 'limit' variable to 0 might seem like it means "no limit". But
>in the memblock API, 0 actually means the 'MEMBLOCK_ALLOC_ACCESSIBLE'
>enum, which limits the physical address range end based on
>'memblock.current_limit'. This could be confusing.
>
>Use the enum instead of 0 to make it clear.
>
>Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

>---
>v1 -> v2: do not rename 'limit' to 'limit_or_flag'
>---
> mm/sparse.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/mm/sparse.c b/mm/sparse.c
>index de40b2c73406..cf93abc542ca 100644
>--- a/mm/sparse.c
>+++ b/mm/sparse.c
>@@ -351,7 +351,7 @@ sparse_early_usemaps_alloc_pgdat_section(struct pglist_data *pgdat,
> again:
> 	usage = memblock_alloc_try_nid(size, SMP_CACHE_BYTES, goal, limit, nid);
> 	if (!usage && limit) {
>-		limit = 0;
>+		limit = MEMBLOCK_ALLOC_ACCESSIBLE;
> 		goto again;
> 	}
> 	return usage;
>-- 
>2.34.1
>

-- 
Wei Yang
Help you, Help me

