Return-Path: <linux-kernel+bounces-328892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23476978A88
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 23:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5573C1C21FA1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C9A1553A1;
	Fri, 13 Sep 2024 21:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dOXPS2ct"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD871465A5
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 21:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726262667; cv=none; b=M6OL9tGr4klWoVU+F49hkKtKLbKEq6RmNF7XZ6TvEjLWiyKmXo+WqpWRIH6MUsuhtyeD5Ecjir2+wse3MdP1k/MYZ1oEkNdmVtY+V8gm1Cd2tnmDX276SstmY5FAAgEDLX3FeUI3RFbB3svtwVoOoNj4lJEa28XC/vgcaRlCsj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726262667; c=relaxed/simple;
	bh=ZYhLlCfJubXl2lpFJkootrsMtKBVHk6xopFryr344Jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLPp0ZXwelXGODwcgzkGCoerfvP+3re5eYJy9/cNFrkwiWFtwIIJv8Zq/1QatIPKxDGGVXhioBcXiVFZc6RrXCI7ANx/CxryLyyXrBr/BHYqlqdehhO9yuj0CkMwpClZ3E4XS63O4FosUY4ryqOuTQ2Q94zSR2cMEtr0CLm22YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dOXPS2ct; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5365cc68efaso2838770e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 14:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726262662; x=1726867462; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xRuFfVQTrS2LaFQHsAbqiDg4XIXZJlnGtDFvh2VKrJg=;
        b=dOXPS2ctuH/ZJu0xW6+f9l/5uP8WwekX4KBkgSF9NNXokVP6l0rhP5JPeiR39fnwis
         0smUoOPmopxYjX9xHydq9PLm6KpGHuB7HngkdoX9C9Opr5jtwHAk34mA8LbH9VDjKaup
         Fk+WWYnlYtVFc5kvyB6e/Q0OApzCLqrfNjVfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726262662; x=1726867462;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xRuFfVQTrS2LaFQHsAbqiDg4XIXZJlnGtDFvh2VKrJg=;
        b=WHi1mIta9fWNfwMgmW2KCzk/84KCjMxeNTYoUDDX/e7i2QofE4pzw1GCa/zQjnHzjn
         /5cjmpnOi1jR/4qSpoKlY0Bq76aQGOjYOPJZJAVN3wNYkLm/UE31CuO53VCnse+whxbg
         2VoYrtlcp3TbxdOOC79BJrlgfamsnLsrk16FhPZ2cDa3MSVz7JozUxmCht35gCJVXDKg
         vMnk5+nais4xiIhB8bvIAsNlxBNURfzRZwvfjIl5U2ScdrAa0XwCP6Xbwg5LGWoPcr1r
         UbPOXhieNW/qFfpN2UQY5euBy6b2zF1OekgYa0HRkwJf/TXI5q5guNcok5dhhqdOTuF2
         aFOA==
X-Forwarded-Encrypted: i=1; AJvYcCW1l7enN73LAKJSCC8V0Gi3fpacxUHQfN+nYD6YUhgrQAVZYf3ynTvNKiU7KVh08l9w5MfKglkwHQgzJ8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHXRP/UlIBRGGybu/VJBP37tq2OSziKrE0+mwF4pqms8VKw9Dl
	0o9nfRG8C/z2+CIU0kOsmE4LBujjyPG70szXbtKDSbI6OYeXQ8YUUCl1+gvd0yoycQXxssdRCbv
	RL/k=
X-Google-Smtp-Source: AGHT+IHb5LognD//GpPD0o/oZ790m59Ttpup4RmvqkXga3OWJ/zKHtvoG0w0eAf7tIlZwEZLJo4rHQ==
X-Received: by 2002:a05:6512:10cb:b0:52e:be50:9c55 with SMTP id 2adb3069b0e04-53678ff327amr5556812e87.52.1726262662152;
        Fri, 13 Sep 2024 14:24:22 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5368704da94sm33060e87.89.2024.09.13.14.24.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 14:24:20 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f75c205e4aso30663331fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 14:24:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWCiCDsGCykky3TGxe+PrLcSd425GqQHivEpAMjaThx6ZSRqKCrZBULCCYpzzkA4rXFzpygSvWy3SrnVbM=@vger.kernel.org
X-Received: by 2002:a2e:7c0d:0:b0:2f5:11f6:1b24 with SMTP id
 38308e7fff4ca-2f787dd0941mr36494131fa.18.1726262659861; Fri, 13 Sep 2024
 14:24:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
 <ZuNjNNmrDPVsVK03@casper.infradead.org> <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
 <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <d4a1cca4-96b8-4692-81f0-81c512f55ccf@meta.com> <ZuRfjGhAtXizA7Hu@casper.infradead.org>
 <b40b2b1c-3ed5-4943-b8d0-316e04cb1dab@meta.com> <ZuSBPrN2CbWMlr3f@casper.infradead.org>
In-Reply-To: <ZuSBPrN2CbWMlr3f@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 13 Sep 2024 14:24:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=_n1jfSRw2tyS0w85JpHZvG9wNynOB_141C19=RuJvQ@mail.gmail.com>
Message-ID: <CAHk-=wh=_n1jfSRw2tyS0w85JpHZvG9wNynOB_141C19=RuJvQ@mail.gmail.com>
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Matthew Wilcox <willy@infradead.org>
Cc: Chris Mason <clm@meta.com>, Jens Axboe <axboe@kernel.dk>, Christian Theune <ct@flyingcircus.io>, 
	linux-mm@kvack.org, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Dao <dqminh@cloudflare.com>, Dave Chinner <david@fromorbit.com>, regressions@lists.linux.dev, 
	regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Sept 2024 at 11:15, Matthew Wilcox <willy@infradead.org> wrote:
>
> Oh!  I think split is the key.  Let's say we have an order-6 (or
> larger) folio.  And we call split_huge_page() (whatever it's called
> in your kernel version).  That calls xas_split_alloc() followed
> by xas_split().  xas_split_alloc() puts entry in node->slots[0] and
> initialises node->slots[1..XA_CHUNK_SIZE] to a sibling entry.

Hmm. The splitting does seem to be not just indicated by the debug
logs, but it ends up being a fairly complicated case. *The* most
complicated case of adding a new folio by far, I'd say.

And I wonder if it's even necessary?

Because I think the *common* case is through filemap_add_folio(),
isn't it? And that code path really doesn't care what the size of the
folio is.

So instead of splitting, that code path would seem to be perfectly
happy with instead erroring out, and simply re-doing the new folio
allocation using the same size that the old conflicting folio had (at
which point it won't be conflicting any more).

No?

It's possible that I'm entirely missing something, but at least the
filemap_add_folio() case looks like it really would actually be
happier with a "oh, that size conflicts with an existing entry, let's
just allocate a smaller size then"

                Linus

