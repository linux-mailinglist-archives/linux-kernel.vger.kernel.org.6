Return-Path: <linux-kernel+bounces-392777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E5B9B9802
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2642D1F21FB1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5231E14F9F9;
	Fri,  1 Nov 2024 19:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="haMSdsVU"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5171448C1
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730487621; cv=none; b=D0SVcSQmwzNbKbhokYfEQNaAFRv4IvResIbmNCyPLlkoVZ1PcujD+7F9twulfn9ihZXOJY4XnlV5LqPKk6kfNTxT6ofKJXkHS1mA1EUL/tBW/FV8MeUKxyI9EnL1oY7YKIPLz7XCZf6tCH3L5A1+vE9ArzGEOqRBO8eScrp6xJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730487621; c=relaxed/simple;
	bh=RjOfzy7gPBWmNxK6//rQdO2Llw/SH2H6GILzFC/1gfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGJAxQWS5G7NVi4lUOc9qSLFJ+ANosacaCAeQT1Cjv1gSHa0Hg/sz5d/3NAW2M8WNK9DhnxXFRNMpngbeyhF5kklZBQfwNSYEZ9tl2dzuhdMZGmsqUxViOXIJqYxZsC2excQPqh21e86bxL5FEm3mCdObCl2v2cDGBpST4VSDsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=haMSdsVU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so20157855e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 12:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1730487617; x=1731092417; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0SBj6xetMK3yUF+ebpIZHeNaC4ZLQNdynS4zqFvz0BE=;
        b=haMSdsVUPGt5NNazEx9rp8veWFGAh0emptfycEVaFPGNplmWFaklDED3kVDlJFIOBD
         pnd5mRm0ueO2azPHxtclAbfyXjpFT4xrXyARCsTP7AKpvJ728lR3Bh1fdeByFXmSBMDO
         aok2K5aq7uLhiFL388dIrQMPRi+JlVbo9ro5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730487617; x=1731092417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0SBj6xetMK3yUF+ebpIZHeNaC4ZLQNdynS4zqFvz0BE=;
        b=ASTZR5LfVDRAU4zq6QHI6bAFx6f8qZ2eeRepSLPTif4hhz5BLglwAfPHoLkPnP4EeT
         kRryrGfKeW5+IXfpN4mhyQY5qJ50z8p0Rw9Way/LrqgU1Aq3YdDLHuCLndJPzgM8b+zL
         N/B4Syz/4x8CfJcy9r1GgNBtCwsQa0d6EDjeZ2+R5TY/vYJsK/8GTeE2Nnme+uuzPPEn
         OMKaqdnrWQhbOs27ZRWA3bn62YlfWt20tzyl0DFyWm3PVF7T4b9+U8ui9u51NnHTSehK
         SO5z0PN7Ok1WHkTC82yWM7K2efOV61UlQXwF4cgfs5AwzOEm9h5pHYo7GbBQZ9261JLf
         pd+w==
X-Forwarded-Encrypted: i=1; AJvYcCVEC25FXtqns17krH3Aas2AEcfP3qU9eKlMB/7Mxt4hILHzXnpna19bgzdcAYKaevHngk5JUAuyrchwf8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNrYAzr0JRZNRTdxGh9jC9p5P4Ss3wdqSm1jMxma9cj0S/P6Dv
	gwP1MTRR505Qgd0TtzZfxhZGjcydJxuK0XjdOlfte6Leyr4MaciY1ujcSl9Xh/G1nDSQXKd6fJX
	ftnU=
X-Google-Smtp-Source: AGHT+IFNq07uJViKqcyQtjFbn4IHQxHYdgZ5AInd2bWHTaIkclqFDis4VJ4DTBKb4T91JHt8n6oCfw==
X-Received: by 2002:a5d:47ab:0:b0:37d:498a:a23b with SMTP id ffacd0b85a97d-381be7831c1mr7711245f8f.21.1730487617597;
        Fri, 01 Nov 2024 12:00:17 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac76ffdcsm1880698a12.28.2024.11.01.12.00.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 12:00:16 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cb6b2b7127so2937651a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 12:00:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfSnXAUtmyZBaJbWWIP+g8sUc6Dq4jZiR/YtNVKVyCXfSAs31aidVYEz4tq1RwjscNb+mS0HoR7T6VpWw=@vger.kernel.org
X-Received: by 2002:a17:906:da8e:b0:a9a:20f9:a402 with SMTP id
 a640c23a62f3a-a9e5089c0aemr795182566b.13.1730487616180; Fri, 01 Nov 2024
 12:00:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101184627.131391-1-lorenzo.stoakes@oracle.com>
In-Reply-To: <20241101184627.131391-1-lorenzo.stoakes@oracle.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 1 Nov 2024 08:59:58 -1000
X-Gmail-Original-Message-ID: <CAHk-=whhiQtzQ4L80rQg7uQzM1cPcNh9nE9U=Bn=iSVaYXPi2g@mail.gmail.com>
Message-ID: <CAHk-=whhiQtzQ4L80rQg7uQzM1cPcNh9nE9U=Bn=iSVaYXPi2g@mail.gmail.com>
Subject: Re: [PATCH] mm: remove unnecessary page_table_lock on stack expansion
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Nov 2024 at 08:46, Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> Each of which acquire the mmap write lock before doing so. Despite this, we
> maintain code that acquires a page table lock in the expand_upwards() and
> expand_downwards() code, stating that we hold a shared mmap lock and thus
> this is necessary.
>
> It is not, we do not have to worry about concurrent VMA expansions so we
> can simply drop this, and update comments accordingly.
>
> We do not even need be concerned with racing page faults, as
> vma_start_write() is invoked in both cases.

Ack, seems ObviouslyCorrect(tm).

           Linus

