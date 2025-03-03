Return-Path: <linux-kernel+bounces-542892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE014A4CF21
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE8A3ABAFB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218AB235C11;
	Mon,  3 Mar 2025 23:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="1ufbAQGk"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278E61537C8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 23:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741043824; cv=none; b=Yvz86q68cKfVNMBO17lgM8bs/tn5wzSTJ4N14yQJHRM9usq/GNW15oc/2oEyenAACXP093zh0wa1sFqZ9R45f1Zu5MBMI2dnpc5p/Gc07aNbMqZTjape8FVLW1X+Gye7UudPy5FREGjHZuqdvl/tieODPbouTGvv58DhspR4f5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741043824; c=relaxed/simple;
	bh=2q+N9CzMMF0zkpMkCS1n3uD0CWA4tPnWzjx8oR+WGX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=if+8CrLRJ+Jadtm3jUNgy4N5Kowh46Ybrn7tkyJn4PIYTz1YqeeJDQvLeXUaTcpYTPyoXH77ijpyfljO1gQB6cH5LLXkYjLiqShRYBtxpMlti647ZvdHNcURC0FMjFfJi6uz5kBTmcusL+VO0eruY0yI1mY5aQDw1mxTMfsd7Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=1ufbAQGk; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c3b44dabe0so182873985a.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 15:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1741043820; x=1741648620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pf+NCzNy6DAShh+optSqQO8OiQ38cROEYTHCXgfvMNE=;
        b=1ufbAQGkixCO325bCy1UF+WBXqahrJ8+GQo3STVIVQR1P0JjDv7STmmTDCXhW+AphQ
         8D8Oy+z3Nf7nbbSHmWaUaAqa+AFin95HquTV1gEaMs+hC4lZg9NksGmmGZjTdTQbGJa1
         OaUWA5vcIrW8Ux3m3HS07jgMeNKSSlh/B2s6mYoD+QELXIfZjAk3wm6PwYjjqheFiuX9
         tfoQdQDt3D91Otj0YPwtHvtEEi4bX2fp67gsEf6Jr5Q8en9s4OS0OT1nazW0iYhL03R7
         2kzknQ8NZ358Vbtame0guMGfWzOTD3nXtJaW3UWq7Ya+Ey4ua2YLOzdUIgLUHha7OdIy
         1PwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741043820; x=1741648620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pf+NCzNy6DAShh+optSqQO8OiQ38cROEYTHCXgfvMNE=;
        b=RC+ZPTbSYO6ULaYICaBOGWamDBrPuYjjfv45alMWOMOvSATYQWb2EsO3gmcmd3x408
         WGdppNaZxOQZ9FhDhoau5MStZigx9wi9opHq+VuCo0Df0wdLUXFeZZX6VQ3kSwNzrUrG
         CnzWsl/Xdj1IvVFJV6Rde/sx/C5TWJ7SclMXZrgloMKVa5pifoY1SK+O20ZUvu+rtlIN
         TJHXhvkHSF4fgQ+9pxRsXSlIBId+vgD3TZtgWUShn+uwh4+GZ3AqGcu3q0WgcJlp7lZ+
         5IaF8mkjE5kl1e8WaN7Cd3V8oG70GW4rFsKMctMIOgmePC+sEbeKmx+XuZgDTlrarIrP
         i+tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWydq5qs3Kr6oUSnSU0iznAW9tq8PZujGG5p/Bpfsa/Fj+cLQOXdrlKqFNBG5WgWRvCcNVO13OOZ2Q23qI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS/q3goTmXMP1KsEGI9X9s1gJ4MiGvLDr/qLyLDTiUUpM06NPL
	XLlyIJvNnVq39cqCfE6ViqRz0COAFpu15jCMGrmH1i4qz/OJ+gJlx/YzLyw/7JU=
X-Gm-Gg: ASbGncsNptWHXZvjFORG9YC3JiTVPUynxYyKhJKxTksg8eWEKcDyDR1vlAs8c+xyaN1
	folo9xEjFHCZ7aI0JQyMUDravTojHO/o7HXHIFETCU/QaXvUGzXJuWwxocfO9DRh52/n52sXt9b
	l4863lw/dv5YMcI+X7r6KSjjVNCXAD0WuX+yFcJrd+9NY6XM3gCrG3RIzjLt8V2xxNmmkk07MkR
	5r9GAzryzxWgmVkE8XfXte3mJeZIgHquJxmL6J6i/NUcX1BRdfcviMPyiGiJekInw5yN08wK3PA
	YL3AqF7Nbrxbt4VBgTUjnw7N5A036ju3AFo6U3lS77Y=
X-Google-Smtp-Source: AGHT+IExpJ0h7r3eDD/EVY81m4Uh57UyCKXDVuTBCkhngbwfxheWBk/7z6l0khLjsRPXclNd3ykysQ==
X-Received: by 2002:a05:620a:608a:b0:7c3:cb28:2f2f with SMTP id af79cd13be357-7c3cb283227mr243543285a.5.1741043819839;
        Mon, 03 Mar 2025 15:16:59 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c395c5376bsm611693685a.37.2025.03.03.15.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 15:16:58 -0800 (PST)
Date: Mon, 3 Mar 2025 18:16:54 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
	chengming.zhou@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] page_io: zswap: do not crash the kernel on
 decompression failure
Message-ID: <20250303231654.GE120597@cmpxchg.org>
References: <20250303200627.2102890-1-nphamcs@gmail.com>
 <Z8YdV4Vqju2w7hqI@google.com>
 <20250303215524.GD120597@cmpxchg.org>
 <Z8YuhvMZkE7CoYRN@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8YuhvMZkE7CoYRN@google.com>

On Mon, Mar 03, 2025 at 10:34:46PM +0000, Yosry Ahmed wrote:
> On Mon, Mar 03, 2025 at 04:55:24PM -0500, Johannes Weiner wrote:
> > pr_alert_ratelimited("Decompression error from zswap (%d:%lu %s %u->%d)\n",
> > 		     swptype, swpoffset, name, clen, dlen);
> 
> Yeah this looks much more concise. It's a bit harder to parser the dmesg
> as you have to cross check the code, but hopefully this is something
> that people rarely have to do.
> 
> I don't feel strongly about adding a helper in this case, unless we want
> to add local variables (like Johannes did above), in which case a helper
> would be a good way to hide them.

pr_alert_ratelimited("Decompression error from zswap (%d:%lu %s %u->%d)\n",
		swp_type(entry->swpentry), swp_offset(entry->swpentry),
		entry->pool->tfm_name, entry->length, acomp_ctx->req->dlen);

Seriously, this does not warrant another function.

It's also valuable to keep warnings inside the problem context instead
of socking them away somewhere. It makes it clear that decompression
failure is a serious situation. We also expect this to trigger almost
never and it won't be tested routinely, so the best chance to fight
bitrot is to keep all those derefs close by. Imagine if this triggers
and the data is misleading or it crashes the system because some rules
around entry, acomp_ctx, the pool or whatever changed. Or if the work
involved in decompression changed and this is incomplete/unhelpful.

