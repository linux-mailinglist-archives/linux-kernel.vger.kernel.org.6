Return-Path: <linux-kernel+bounces-512151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78903A334DE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CEF8167396
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9425139566;
	Thu, 13 Feb 2025 01:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="auMrHK0z"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C6580034
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 01:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739410986; cv=none; b=bapZnCeoQdABg82q17OnX9bYKhGmchyIsZAnhQWlU1MqVYYb778ZVOr43ulAG0m2cFXPefYMPi+KO1+B2jkSVfQXt/JuNJwuMYDpClYWbd8ZhnqE6CFFiLoY5kJsiZ8n+/8XKXjJLvrh+OX5mnRnVl0Y76HdXampy/Tgb49M0yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739410986; c=relaxed/simple;
	bh=+ykXtcQ0unMZKuH6OV9U2v3ayx5+m/2c5HxvZe2UP2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ys4xF4M0ULm9oDewHFIMqyAo7FHW6lfxc8JpdRwzIzt2JMxaId5BmP+uka+6t/2GPRfImD9qM8RYeuIRN/mr9Hn4RWpawj5hxJGF+JkaSyrLKVo1n4HA0ome5C3XEoXfS+J6Rqp2lkm8BnwB8+GPY6hmYfZQhLTYyTxEAYO/nHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=auMrHK0z; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220c2a87378so4167735ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739410984; x=1740015784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T5oGSM/mXRFDYtGHRMEZVTjxUhTtt3uAbcMTieIkRRk=;
        b=auMrHK0zjo6ta4ZZrXujpeIKWGqL0TI9jBGeQ/5Doz9OzaMTwrIY5Qsuqw4a2A2X8u
         wb7XbHg+SIkblJJWiOpzqcpE4S64Bl3izoYwk0kvJ2TxX8g2gttZYO2WeCbp4JzfZ5h8
         i79HaTpGin/lQDyRMB/UhfkUjZIDUWyoFtIe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739410984; x=1740015784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5oGSM/mXRFDYtGHRMEZVTjxUhTtt3uAbcMTieIkRRk=;
        b=bY/VgQOLlPEpGvleColpIsn1UhITQZBUnwRITt+yP3rxlD0UGRhJo6GwjKMhRsgQXZ
         zzjAhNol5jbT5WCOEBrp88jnxFyI0ciut5TqTBp0hhiShjY1UqSWlzk6fF3hMVTuOiK5
         puoTU8b7yr2n5SmAjnUr56oYM/fb6yaFko0M3NFHwwVzVY1rsvMKj8NGQ0Dm1Rg03ei3
         cKe9c8oIJXcoS6HlRlKsid9cnGmBhDg8Cd7lk20kHU2QoyvrSF1hqNaaxb7Evl9Zu0xi
         CBz+6/tlVtWaHQLsJC9+6XVsbUEkzfYQlzUmIdc/Pf7o9Be/bGGoT5QKr4XnAOiDXD1u
         gouA==
X-Forwarded-Encrypted: i=1; AJvYcCX7HjSeXjc5dQRlrW9QwwEtyHpZY9DDBqs/9s1ONxysOmX5g3XuXezTXgPkmJIkqOKSEdF0A2kIN3rLLpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgmnEzuNQ1Bqge6NYxCHpWWdHsMRKDG0GSeEhd+47gib4lBnI4
	1DEijgZ15yXnh32MQ33NLPQ8f2DpzkHShwFOdmerhqGCgHU3KfSEepcfaOt0qA==
X-Gm-Gg: ASbGncthoa0HZKqO6rKUXcSaPrJSfRP0wEGrgWk5PkF9Qqd+4NMi/6qXf+AMHKpZyvH
	yYd/3RsqCLXZ3v7GgYvkSQo1eKddK+mLW+k1v/h9ra40YcbmuI5+CTsmMDt9tzbK2EDuSgqMRwi
	snSuTXLhksMjIvVPI4wLLMOI4UHf2kuuC2vTlTfYMif0C4+vt/5gXy9PQyp28PfbV9sRvD91M85
	J4kUS+2gtJshtmKaqcAeiZjjHhW+M5/UIqZ/Rk9AQ8k+CZ+mLF8MlAQY3R0sKU7X6+bCPQ+ootD
	bG8YsEfLFl+wfBttHXM=
X-Google-Smtp-Source: AGHT+IEQkYn7LfEDpm4b84tpMh9IaVyeLMgGUosZu1w3p3j0cQQkmIHAGvjDe9IZBFuwDnNA/Ndrew==
X-Received: by 2002:a05:6a00:4650:b0:730:76a1:392c with SMTP id d2e1a72fcca58-7322c383ac4mr7127290b3a.9.1739410984041;
        Wed, 12 Feb 2025 17:43:04 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:3ed3:97ce:5f5f:1f61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273eac4sm107298b3a.113.2025.02.12.17.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 17:43:03 -0800 (PST)
Date: Thu, 13 Feb 2025 10:42:56 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, Kairui Song <ryncsn@gmail.com>, 
	Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v5 01/18] zram: sleepable entry locking
Message-ID: <ma5b36tdfdclkcd3ncp3bi7cnrcv2z5ju36h5ovugagp626xpd@kofvqoyhcc3p>
References: <20250212063153.179231-1-senozhatsky@chromium.org>
 <20250212063153.179231-2-senozhatsky@chromium.org>
 <20250212160830.730a199935e907c2498b28d4@linux-foundation.org>
 <t6w7bzhdy6vywc4gzowdoe2vliwl7sdju6umrti5rscjyd2uns@pquelrkaywjn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <t6w7bzhdy6vywc4gzowdoe2vliwl7sdju6umrti5rscjyd2uns@pquelrkaywjn>

On (25/02/13 09:52), Sergey Senozhatsky wrote:
> > > -static int zram_slot_trylock(struct zram *zram, u32 index)
> > > +static void zram_slot_lock_init(struct zram *zram, u32 index)
> > >  {
> > > -	return spin_trylock(&zram->table[index].lock);
> > > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > > +	lockdep_init_map(&zram->table[index].lockdep_map, "zram-entry->lock",
> > > +			 &zram->table_lockdep_key, 0);
> > > +#endif
> > > +}
> > > +
> > >  
> > > ...
> > >
> > > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > > +	lockdep_register_key(&zram->table_lockdep_key);
> > > +#endif
> > > +
> > 
> > Please check whether all the ifdefs are needed - some of these things
> > have CONFIG_LOCKDEP=n stubs.

The problem is that while functions have LOCKDEP=n stubs, struct members
don't - we still declare table_lockdep_key and lockdep_map only when
DEBUG_LOCK_ALLOC is enabled.

