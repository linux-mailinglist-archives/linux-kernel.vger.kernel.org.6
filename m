Return-Path: <linux-kernel+bounces-200146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D058FABCA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907CA1F22295
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908ED140E2F;
	Tue,  4 Jun 2024 07:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="IyASznn4"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4176783CB4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 07:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717485646; cv=none; b=vDP3B1KLM71E6OPYvGI8xGjsb8hlJQ+slcnRc7oPGf0exHA6nzXOfI62zs7GqUd6v0mYyBqvSv9ha47bllAIiRqqEYvRKnft7TojGbF88xk8vJL2WmffCOx5CRIGvCAVSA4FHqb1HZk87iSbtu4DKtVe+/jp0DN4q5GSz/0Ag8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717485646; c=relaxed/simple;
	bh=gk96MhHZ+qD4z+JC/CqDk/UP4VIXuPLVFDICmyRSxQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UM5dA7FpBYunX38ocVzw5QxnntS5Ajg0tdFeiIxYWAOdMFY/ku63VvgPAEe1V4DP9FUqIXy9o2YYY7ndtB0aBIuc6lDvQYe3rtV/TZqRkyy/Pvh7EkUFFCRRO60kx+VeAlG2c6MA2tizJndNiWcGDrIscYgNxksHVLEObOb0z94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=IyASznn4; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6269885572so916445966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 00:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1717485643; x=1718090443; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HvkJ2QsK5Vmmx/tl05h2LcGE0mbAgMwnA13TfKa1R1A=;
        b=IyASznn4cRNFaqUdupbE1heCLuT5urEiTz5tvhE/2drAaBklfjF1vuMttgcx0uoSPi
         PmQTl2rYJky1fg00u0ndwZSvdoJR0iT6zEZzELIdXLC/EsII/KqsMtlI8mr40eO/FtNy
         vPkhDrKDAs03AxYSpoWsNaw4b347C4x8tZc9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717485643; x=1718090443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HvkJ2QsK5Vmmx/tl05h2LcGE0mbAgMwnA13TfKa1R1A=;
        b=HlVugYhcoj0rwL3wu61bn6P/IgfhtXVCFuULyuqKd7/A8K2qkTe83i91JNNETv1aXs
         TCHo9DSdAfcp4Y91/s0UNcJfPi5Lr5Nnb0UzOg29DUzFnEDcLB7Hkvyg83rSAcmSw3XF
         3A/NgsnHyvvLt7+Eq9oCjBYZEllMPi2Scnb+juSir+r32bZDd9gctvEFFddl+giNnETH
         kr+GTTBz3YE6NwLEM2T+ntJU6kg+Qho4S54N0AyVFCsYSOWl5Ofis3qyd8p+/ivYlsLv
         9WSzqES/og0G/66CsO2E8HB2FsMoeehoKexwv/OOaYDmHJU+VDm9Fb09fiqVhmKwRvt1
         HPJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfqVfSOo8BlIBfbtCJWbWKz1shr9u8L6sFkJ6ssewVNBHJMD7ifE/zcb1u+7LLk05OF/sf38C6agEkDIemVl7uKxBHgwhMsprFvsnT
X-Gm-Message-State: AOJu0Yz7eX0Cpz5tJtVMw0Zg65fONUUwWvsMkVqVyuKFvu8HrMkkUy24
	egraPGnAXr/hc10Qj5OFQZSz9GK/YyuWqmm4ViSnKcnFgTHIA34vnAD5DfqnMC0Eeb9YsY0rFXm
	LfIb0xbJEXnjHU/Bkn0CK74APuJ+hhbDnmgyIDw==
X-Google-Smtp-Source: AGHT+IHpybo+v5p/7tG/go/8QTBu4G8QfZEZnk6qWoL5XNl83JV3TBTOXUdyGwIOk4Yi+ClINF38k48a4Lpz0k/65Qg=
X-Received: by 2002:a17:906:f299:b0:a59:c698:41ae with SMTP id
 a640c23a62f3a-a69545681d7mr135855966b.34.1717485643547; Tue, 04 Jun 2024
 00:20:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alibaba.com>
 <67771830-977f-4fca-9d0b-0126abf120a5@fastmail.fm> <CAJfpeguts=V9KkBsMJN_WfdkLHPzB6RswGvumVHUMJ87zOAbDQ@mail.gmail.com>
 <Zl4/OAsMiqB4LO0e@dread.disaster.area>
In-Reply-To: <Zl4/OAsMiqB4LO0e@dread.disaster.area>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 4 Jun 2024 09:20:32 +0200
Message-ID: <CAJfpegvYpWuTbKOm1hoySHZocY+ki07EzcXBUX8kZx92T8W6uQ@mail.gmail.com>
Subject: Re: [HELP] FUSE writeback performance bottleneck
To: Dave Chinner <david@fromorbit.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Jingbo Xu <jefflexu@linux.alibaba.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, lege.wang@jaguarmicro.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jun 2024 at 00:10, Dave Chinner <david@fromorbit.com> wrote:

> I thought we had PR_SET_IO_FLUSHER for that. Requires
> CAP_SYS_RESOURCES but no other privileges, then the userspace
> server will then always operate in PF_MEMALLOC_NOIO |
> PF_LOCAL_THROTTLE memory allocation context.

There could be any number of services that are being used while
serving a fuse request.  There's no well defined "fuse server
process", as many people seem to think.  Any approach depending on
somehow marking the fuse server as a special entity will fail.

Thanks,
Miklos

