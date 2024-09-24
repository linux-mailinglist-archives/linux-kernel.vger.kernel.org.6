Return-Path: <linux-kernel+bounces-336448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A50E9983AFE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 03:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680D12838E2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3B29460;
	Tue, 24 Sep 2024 01:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="htzWQVWS"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F217E9
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 01:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727142399; cv=none; b=J18GNH1ZmVbZVtfKEFQbZ1SlXs6Ihz/cSDDGu2J+Ch6zTaDQE1Ipo67uCmzHnrP1KQBCgbNq0C8j21vzU/A1bemNbHsaBrNltarZ3z7kmDxjiR87O8QorPkYkSxLl8RZTiNtRchySMMAgFLJxBUP2Mv8mtR6+/kbSxLoy3DeI7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727142399; c=relaxed/simple;
	bh=uqjOc5RRUJlg3FOry9HLFpX3EPZoLUCv5W+OuLPFmDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4eS2iRSB94MY06Af/MadLuro9YfkL2+4E7On4KBEJaVUCAtDvWqbFZJ9IMxy4IqNhBk2FhFjXS7O+DU6uIsM7wozM9rxc2xS9z2mUM1vj/7uZ3ZghDeXRaQFmTJKSsZcyeazUMHfAy24E1BCNd3zNbiO9UxuQL+0o52gnXdMho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=htzWQVWS; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-718e285544fso3756394b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 18:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727142397; x=1727747197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kjf7bgPkxvbASBQBW80GmywcvOAyN/cF5IYIogDHDPs=;
        b=htzWQVWSfpobRegI9Dg/Y/sJ/jzTnhlHBiToA3u57gO/d/xYQpHzAx0cRLY6xJOGjG
         /xKhRp6TRrIZf7yhFugDh7Md1cisVSxzb38fWGXwP35VrGYn8Cz+rFCC+plY0b7d3Swp
         P3V+Ekvl6IktXnVC0yj6mfUgCSok2FFFGG3rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727142397; x=1727747197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjf7bgPkxvbASBQBW80GmywcvOAyN/cF5IYIogDHDPs=;
        b=HLBPWDjRwdJLFnYfYPKIiC01OWXGBvdMgNyYjz4/McaSw6PZZH0gE5Se7T+sn12PkF
         3pUGAadr5reOWBQIwA6IeUHXZw0sGdBPr/Xt8FbPbxhGRbnYRkwyGYeaEy/CptfEnrWG
         Ai/6NMu5ZDfV3jm7UYPIR/vk+DX06PYY8E+eCB5OeWKvCJHes49VM1EEhk5giQdP1e9B
         hgUR1W10ar2Qrt46E6hXUOpespKhIDZXKgfa1gFn58oEiPnPWI9h1VG+NacodUdWHzdT
         0dc3tSKG4hHLKa3UTRo6IU4VezZe7ZMcaeo80N86kNljgMeZQalb7AxPLuPrap9LsvNI
         L2rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCN2SvbZR+LPHmyBlqzMmgZNWGjhDDy89c8lH+YzXmWFNm8zJSS0zBQi885yuoBbrMTPyku9IKJYw0wqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeHN170uBgCJFRh7/1rE1r4rcc5EEuuJShQKL6f1E7RDZek5HP
	YTYQ/e8EuuawdNuE1GWRIgFw1a5hu0dswCR9KOuhnKaRvA77rqucw0o1KryasQ==
X-Google-Smtp-Source: AGHT+IEChjqT75K/jqfu3No+egUQqd+5DAXt7Cf8ovcAwg3g1ML0TXHbIOCQb+CWDVISEwVc4D+g+g==
X-Received: by 2002:a05:6a21:3482:b0:1d2:eb9d:9972 with SMTP id adf61e73a8af0-1d30a967d51mr18786453637.20.1727142397256;
        Mon, 23 Sep 2024 18:46:37 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:fd63:e1cf:ea96:b4b0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc846e0esm232357b3a.81.2024.09.23.18.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 18:46:36 -0700 (PDT)
Date: Tue, 24 Sep 2024 10:46:32 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] zram: don't free statically defined names
Message-ID: <20240924014632.GI38742@google.com>
References: <20240923164843.1117010-1-andrej.skvortzov@gmail.com>
 <c8a4e62e-6c24-4b06-ac86-64cc4697bc2f@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8a4e62e-6c24-4b06-ac86-64cc4697bc2f@wanadoo.fr>

On (24/09/23 19:40), Christophe JAILLET wrote:
[..]
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -2115,8 +2115,10 @@ static void zram_destroy_comps(struct zram *zram)
> >   		zram->num_active_comps--;
> >   	}
> > -	for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
> > -		kfree(zram->comp_algs[prio]);
> > +	for (prio = ZRAM_PRIMARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
> > +		/* Do not free statically defined compression algorithms */
> > +		if (zram->comp_algs[prio] != default_compressor)
> > +			kfree(zram->comp_algs[prio]);
> 
> Hi,
> 
> maybe kfree_const() to be more future proof and less verbose?

I didn't know about kfree_const().  If we change ->comp_algs release
to kfree_const(), then I'd probably prefer it to be a separate patch
that changes both zram_destroy_comps() and comp_algorithm_set().  The
current patch works for the way it is, given that it fixes a nasty
problem.

