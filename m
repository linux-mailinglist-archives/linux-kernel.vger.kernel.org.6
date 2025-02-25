Return-Path: <linux-kernel+bounces-531720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03D1A44412
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C1D170973
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEBA26BD9A;
	Tue, 25 Feb 2025 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="e20skNTR"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E6E26B097
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740496463; cv=none; b=KlsoZ8pPnehexsl0fKcBh8XhMXz8j/yRBS5G/v07fnq3B9vGuA0R26DSohHXEu1+BqMU6hD3bUOD9ntPefoAl8hE3hyq+ML5k12ohnyqBh6BfghETegNLzTGojHDC8mHAKMvVTP1WkF0IT3d3C1vQ3pIR+gbuLjBI4Fy2Nc7p5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740496463; c=relaxed/simple;
	bh=O0RctnXYQoC7flW0X7Av1f+4ilo5pjQtLa52BK3C09M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9/jLHT4y6QMhPPiMUMyMpFB9GLBsKiDiQRcbqAmm+6mJpUakpLXvgFv0MOeju00OwjsgQx6wyx7Cto/iiSv9W4sd6p0V5GOovWpRb9Hf9xrQDjxJraiAR11xwAp1i/8TDEX8LVi4macZ2IOBfiRgVgSvmT0IkTKzqUHFuOl7SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=e20skNTR; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-471ebfbad4dso47364071cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1740496460; x=1741101260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dOiv7bSPf7EjE51B+T0p4dYCqbf2wAsHmjw4hcxI774=;
        b=e20skNTRtFgt/S3NLdxwvHZV6AAUOOaY/exd3gLnC8Wbg6c6i//S5MytTntbnpPMrc
         TmrBee1JiqtMnTReQfgZbpWk5+TAMr3c5yqe6Hz9r3VxVOvDBSbfr6e4L4fMAtXTkBnT
         HhLZ3WtnOIxbW6n3c4Tbe6BVq4XkThv32Uhhu+BbioVqnAtN2VY90MOnc4j0CENHU++s
         xxXe+7j4VWCfSF1vrg/9ylL9rSlwxGovGiQzZr8h1bqTBAk1Ntm5iHKZH4SXfOyy776Z
         ao5TGBZ5eMVel+pGI7K8xlj1KlViOPO1XMV05iAfTTiH+RM3PA3IXqDJw5LU4RrHHUwU
         A//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740496460; x=1741101260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOiv7bSPf7EjE51B+T0p4dYCqbf2wAsHmjw4hcxI774=;
        b=A8IlXH0836YZFnFQTpCeghTvsZj//+ZEhDSy3EVwLf51r/XUSADLGafZPrtHA4awWg
         kU5sylAZFTpNaF4GnacCiob/iBeOTOH/hOHtEunAD9Ft3/itA61v1pBXOsq3NRY2lBGC
         3GjRIaNopa633gUKQs9sQqew+l0zsQL0oSQOfhqJdf9PaQ/9M34SKZPbadqQgmHR4RUV
         j0dTR0p6mJgg1WW/tKitjC0quU/wXXMr3BeuyNxamhiG6N4liPr11+7YT9R3RmkqaYXQ
         Hoat5Yo8rMuHt5B7hqWdN/a/vFcwzqHt43mMMimqauHSPXD/wpuH+EDKd2MdnEkwwVKr
         0YyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAUcWI8BK+SWspuBWPgq8MhZEz7hSGLoaW2tauV560kaPCdfns5pCEsr7axOYYRUecF7ewTQGiRy3/vrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVe4QpQYsVNCdDPCcKgBDbmd44r61HwC5WO7hZzBC4rOBO8QkM
	JSQBU77YllyR3iBu14nLkkzSNJcaKi6FRqic9TcjhTTq27G9p+OjW01naNhD5Yc=
X-Gm-Gg: ASbGncvsH7ll/gvk6r+jQsa+tvDcMMAGpJg4KJjUzxGco/QgLnmm1G8IUSqwfcHOSAJ
	VUwpbVoLInt5jinr2OZhl6DMobSxB9hGyyFV2Ch7X83zWx56pi5oS51PffTDozuRq3/Ddc1A5iw
	txpzXWf2srQpWxtdUxsoAtv6uO4VOOiACWnJc/I3ftkRZXC5/iTM0q4g/bswk005FGtpni/rAwx
	P+luMIkIZSsZ/U9z8o8Tn0dJNcS+KCKIeATAERmVafiUz3ng2m6E7tTTxjQjWV0zSy5yRc6jdxD
	m15smi5ztfraOExssRtJgiNu
X-Google-Smtp-Source: AGHT+IGP/2zpNEzKXQ2v3FQ1MydEpiwMwCLWksUbfMhw6AAi5TzZ2aWM4S09bKoL3BSv9/H1tb3tKQ==
X-Received: by 2002:a05:622a:190c:b0:472:1814:3fc1 with SMTP id d75a77b69052e-4722485f414mr220324611cf.31.1740496459787;
        Tue, 25 Feb 2025 07:14:19 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47377d5b9d4sm11038961cf.0.2025.02.25.07.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 07:14:19 -0800 (PST)
Date: Tue, 25 Feb 2025 10:14:18 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: page_alloc: group fallback functions together
Message-ID: <20250225151418.GC1499716@cmpxchg.org>
References: <20250225001023.1494422-1-hannes@cmpxchg.org>
 <20250225001023.1494422-4-hannes@cmpxchg.org>
 <Z73KkRTWfu-9CBIm@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z73KkRTWfu-9CBIm@google.com>

On Tue, Feb 25, 2025 at 01:50:09PM +0000, Brendan Jackman wrote:
> 
> On Mon, Feb 24, 2025 at 07:08:26PM -0500, Johannes Weiner wrote:
> > The way the fallback rules are spread out makes them hard to
> > follow. Move the functions next to each other at least.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Moving code makes blame more tiresome so I wouldn't personally do
> this, but if others find it helpful it's fine by me.

I feel you, having had to get good at git blame, git show, swear, git
blame foo^, repeat myself.

Blame has definitely become quite important to understanding code. But
I'd argue it's slightly less important than having understandable code ;)

> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> 
> ("Reviewed" means "git tells me there are no new lines nor totally
> deleted lines").

Thanks Brendan

