Return-Path: <linux-kernel+bounces-336039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A4197EE62
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2EA62828C8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CD5199944;
	Mon, 23 Sep 2024 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LLD8bCkJ"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F298F7D
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727106139; cv=none; b=O0JHg/k+gwEcNOd9GmmpUpOUde3xbh3Efs2MziOO9NS4bMDD1Ah1uEEkgqHMtRHFxQLhEzFYX3yg3mTDYW3fJlDCP8lG2hPpPEyQZ0fv0zsy05WK74d3vDKKBItFRo/AnG9NKQjujn7QBOa2J/5btOo8PR78wzg0W8yJmHQ9TxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727106139; c=relaxed/simple;
	bh=3Q5rxwHj3JGxVIbkrTDsygr7k3PWWTVyU46YCgH2IqI=;
	h=Date:From:To:Cc:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tENVBDN+S9WabNkACxzRbl8uMSWSap2U2Jamze8u6toWofleKQ1ytjslxqyaM+7OHYCx5WtKAdz6/DJ7ETwq/g3K9qBkpQGLniWh5x7osq0So1f99ZJgcMq0Ug3UOQ5lm5sSPtt8eF11z9QgRdg4B8EtwVNaiqSaps798Eff7ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LLD8bCkJ; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-27806115eafso2128034fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 08:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727106137; x=1727710937; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H4psRH9uvTvZ+EcppbtddhdemTURw3wm4/GpZ5POPFI=;
        b=LLD8bCkJOvqGj9e4bMiyRufcefLoRwR2QV4ScCqvboHFKIrlsITBln7+VQ3WcDsQnz
         mzXxb3SJKZqYYpQ3I5Yk72WjoFzu08K0Mr9QAGRyKa2stTASES7yxA188jBLNsse413D
         3oVibPmYUY36iOpKlHny1PHmRq/DoqQy5bb6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727106137; x=1727710937;
        h=content-disposition:mime-version:message-id:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4psRH9uvTvZ+EcppbtddhdemTURw3wm4/GpZ5POPFI=;
        b=aZwsP7CqHq+qfog86KsOrBszftVKEfkOCpKTa/Yn0rUQ4TEjMW6bizmNcD53xogS40
         pREJfskDhumWr3Yq4glboMjUU0di4XNlire6gCyqOASMR3Rr/gi5HUklFbhDIKmgd1hE
         JAflG+p/iXarE8IvvMQciuswIBRgmoffzkEmguMggLytAjnvaIB0E/LyTk4xUhpA2XC5
         1Mx/gJsUoPllOpIcF3S4by2E/1NdkWyy5wh9mTqxR1ww5Z0LIPI8+m949IB2N/RA8RE/
         YUVDHuGVfdwb9bviI0Q9BSaOnX0V0wdA+gdVvylydTgVgDw/UMgP5+5BafgHPttystM3
         76CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAgL+LBRwBZb6kE81cWMcWbVckP7o2S7wrR5Q7+EsZbNXV3FqHhaTpVeDdNumC6JQrqSwd64lWFiceP10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+VzNb4CVzwKshwSCa3d9MrAWK9YaTQPb4B8OZyfFsyDxwjF73
	ALwGe9AGZF4/4015nA5IEgXSASK+3TkpvD4YjFfffP898qPWRMOQQ5jSbWI07g==
X-Google-Smtp-Source: AGHT+IGLrt1SdhW3xWs5HczP5HQsxOV2tK1fkasmItJ6/En3/5xyUcP+o7dkEkQDL7Hn6T6uDllS4w==
X-Received: by 2002:a05:6870:344b:b0:277:e868:334f with SMTP id 586e51a60fabf-2803a7b8503mr9722097fac.34.1727106137629;
        Mon, 23 Sep 2024 08:42:17 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:fd63:e1cf:ea96:b4b0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498fb730sm15502664a12.28.2024.09.23.08.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 08:42:17 -0700 (PDT)
Date: Tue, 24 Sep 2024 00:42:12 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Cc: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Message-ID: <20240923154212.GD38742@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Bcc: 
Subject: Re: [PATCH] zram: don't free statically defined names
Reply-To: 
In-Reply-To: <20240923153449.GC38742@google.com>

Cc-ing Venkat Rao Bagalkote

On (24/09/24 00:34), Sergey Senozhatsky wrote:
> >  	for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
> > -		kfree(zram->comp_algs[prio]);
> > +		/* Do not free statically defined compression algorithms */
> 
> We probably don't really need this comment.
> 
> > +		if (zram->comp_algs[prio] != default_compressor)
> > +			kfree(zram->comp_algs[prio]);
> >  		zram->comp_algs[prio] = NULL;
> >  	}
> 
> OK, so... I wonder how do you get a `default_compressor` on a
> non-ZRAM_PRIMARY_COMP prio.  May I ask what's your reproducer?
> 
> I didn't expect `default_compressor` on ZRAM_SECONDARY_COMP
> and below.  As far as I can tell, we only do this:
> 
> 	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
> 
> in zram_reset_device() and zram_add().  So, how does it end up in
> ZRAM_SECONDARY_COMP...

Ugh, I know what's happening.  You don't have CONFIG_ZRAM_MULTI_COMP
so that ZRAM_PRIMARY_COMP and ZRAM_SECONDARY_COMP are the same thing.
Yeah, that all makes sense now, I haven't thought about it.

Can you please send v2 (with the feedback resolved).

