Return-Path: <linux-kernel+bounces-572099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC6FA6C674
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 00:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF54480B35
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5B522171C;
	Fri, 21 Mar 2025 23:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V+nd9Tjw"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB73143C61
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 23:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742600174; cv=none; b=h0rX8ZApn4beJHlFJqpZ6ImFYVkwUPGQeycd/NTlWESZMTKUk3OnMMw9/bn/EZ33jkmQL9DhkJqW8PqqDQitKRbAX+8GUNQ5vp4VrBtkdpma1wr3h53IbiGW6ffJNJHd7v40zC/kE/1U/2kP1Q8ktzABz6is7qY9WLxnUYnADmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742600174; c=relaxed/simple;
	bh=N1ylXnJIf4zsIafSFGpzcN/CQb6s15L3mdjCPrSKy1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BbfFGvYLBoRORqVqxK+RyZ+JFEugCig9Ihnef/5hDeKZJlDLf6gxDmMHrnipwoEfdP2N+f7fHt5GUKx2x6FOUqxOqtlbIeUdgV1j3uhURzxQHhxGoQnjV5II2zuAfOeID25hMBwlbEGUhsnP+BIbm4zbnUbZi01uZCtzd/2k4zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=V+nd9Tjw; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab78e6edb99so382665666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742600170; x=1743204970; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mM+8KyCZ/6Dstt+0pQzEcl1UGZ8iF+rWSarv6rEzi54=;
        b=V+nd9TjwWctRfQ7rfe/Y8reZiaIhRdXVeEqT0rMaoZI+qfsl2sFxoQvETylwAo5nZc
         ICUk38RG1WGUP/q/6qwk8MrAzvKOT3GWXUDTnVRHT2Pttj5P+S7h5XXPtzQ94cYX0vuC
         dJFdrw5AoF/FTSdKBCCLEDL7qzNOwpxkqdXyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742600170; x=1743204970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mM+8KyCZ/6Dstt+0pQzEcl1UGZ8iF+rWSarv6rEzi54=;
        b=By2dJxxzxOheQV67E7Xmun8oeHaIsh6t/zs36d1B+T10jk6Gttv6aMnvMZd4uTeHX8
         oiMUwdxevtdYAg4IPXU39y8oJPHYsgHDxhjpvP/b3iVaaTH0d1FMNSBfUhYIM+l5LCTX
         TKIyFJD3ZRibT/Y/Xy06o+ZX+s9QA2SaUUMCfbI/B6di4mnCXvjZaG0mTxKI7YmOWAAE
         aQZpF/YyQW5fTnxGAaVv9Rt8LMPrA0NfX2ELo8K2B5dE0Ii3sCPUKo1RRQEzPUOGWAM9
         Q+gCtfwvjUTIq1zbbF1jGuIRhppXyNDLntPFf/OlawwZXJH2pYID+k1XK+qsIFPwUq/c
         rZYA==
X-Gm-Message-State: AOJu0YzwVM8+caS9Qn302Ezq/47xFstQzfkK1hT8r3bwlUwxGn0KcKdE
	GO9+8xPyuWqkz9o5yGLsUXafQQKK8c78EbFbgSY75CpT4HYPoXlIBVuZ3mreXrUCxZu0jqhFoZc
	odbo=
X-Gm-Gg: ASbGnctcKCkmrtlQv1RG6kBcBzuid0vy9A0vLY13GEalTfnBS6lT6yHhxg/c9MYbUPs
	S7ViFGAuTEJuBPyOH3wYevjD6s3Vi/UxBpIBeQEjAqZmbKUK/B4s5d8BxuI9U+fVuVeg09BijVV
	D6A8n7b67uBT27UNGgB0za1Xvtm8Ra0UR6U3RkikmsUrPFgPWqJMkV10ic4Vcy76lBpoP8KXoFb
	azz2g8xpf3WBG1FOjI7WOU3qE90FofGPAvjQNzNFk3dAWQs7Oq9HRrzmu6nqHLsP4jpWi8YjDWX
	CgwoWlhLSylKWphFWBYgD5eOhCYcbck5X55aaH+OeyB39YKOHJhe03uLwVcsUmI5NcPuVdLGzYi
	fUsU1QDUQOKTMx3VwqrI=
X-Google-Smtp-Source: AGHT+IGw0pp8zSm/8GiEJtwHw8edSPjoeJlH8Wv0TCloxdkgUSal8DWSauT3GQhpnJgkKTNtQJ5cdw==
X-Received: by 2002:a17:907:c810:b0:ac3:4489:7910 with SMTP id a640c23a62f3a-ac3f24c8810mr598674566b.49.1742600169988;
        Fri, 21 Mar 2025 16:36:09 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efb65866sm230615466b.102.2025.03.21.16.36.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 16:36:08 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5dce099f4so3437661a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:36:08 -0700 (PDT)
X-Received: by 2002:a05:6402:5190:b0:5de:cbed:c955 with SMTP id
 4fb4d7f45d1cf-5ebcd45f681mr4302182a12.17.1742600168536; Fri, 21 Mar 2025
 16:36:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321224557.3847-1-david.laight.linux@gmail.com>
In-Reply-To: <20250321224557.3847-1-david.laight.linux@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 21 Mar 2025 16:35:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=whs5oVkHMrNP=xkJP4Z4fObn=6Mz3fYp4wWMNQWtyjo9w@mail.gmail.com>
X-Gm-Features: AQ5f1Jo2maw43YvC_sbgFLPkHoO6pFO8ZcY9F9XJGSem0pswyFLYxaqCxok7hsU
Message-ID: <CAHk-=whs5oVkHMrNP=xkJP4Z4fObn=6Mz3fYp4wWMNQWtyjo9w@mail.gmail.com>
Subject: Re: [PATCH next 0/3] iov: Optimise user copies
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	David Howells <dhowells@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Mar 2025 at 15:46, David Laight <david.laight.linux@gmail.com> wrote:
>
> The speculation barrier in access_ok() is expensive.
>
> The first patch removes the initial checks when reading the iovec[].
> The checks are repeated before the actual copy.
>
> The second patch uses 'user address masking' if supported.
>
> The third removes a lot of code for single entry iovec[].

Ack, except I'd really like to see numbers for things that claim to
remove expensive stuff.

But yeah, the patches look sane.

          Linus

