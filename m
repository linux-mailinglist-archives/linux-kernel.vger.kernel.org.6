Return-Path: <linux-kernel+bounces-330149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDEE979A4E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 06:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 875DB1C22A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 04:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6B3208D1;
	Mon, 16 Sep 2024 04:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EG4+m3Ou"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A0C28F7
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 04:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726460463; cv=none; b=vCoGkNJmCNeldv3wmr0s5VwphMmIipGxaP9qyVLp1auwRfv46SJ0ZZx1Bs7fy6vNi7inN31FefA8LWKAV1qGYSbUpaM65kIK3XKWsFwVapImhWCvtogxc4+guzNr3jXVGsS/LnBVMFMwqhxHX8EcuuVLxx61Laq24rQ2NWoMvzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726460463; c=relaxed/simple;
	bh=OTJ/oKsnoisoc9GbqLHkeCIc2BFxmDrQOsJxcfR3nk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbRvNNDme8xYmZ0TP/5cf1CESWtVJT7hPGMnxz2z8nVwXVZRfRMw67IOKosnVxYxqfmwhnNcmrL2MSbVLjyiVfMVZww1EErZXMdIBgwIhTDPcjDjlAnIVA9QdS2MbOz59CNs43KzcwAMaoCWn6QtAOIn59e0kLKIUVFyLpd6CkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EG4+m3Ou; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a83562f9be9so419101666b.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 21:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726460459; x=1727065259; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jwnw+7buV/Co6cDy6nKRIoLyua67GCD7ZNv0sYBhUOM=;
        b=EG4+m3OuB97C8n50jxnQ/2K09kcBih9ERGeMIO459vRyvMHHgivgjB1jpf4pzTuYYB
         0GmMbrCTJTRnJZIjYdwFg7NyVJJZK2Dyz6OvfCSgxQPmDW0hwEqpNMHQHAl+sJKArZnw
         OUONTkRMht9HS7J13XqI4c4fw+oJgulRV7ZZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726460459; x=1727065259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwnw+7buV/Co6cDy6nKRIoLyua67GCD7ZNv0sYBhUOM=;
        b=S9jtmte2JL/ddfOxnSqXPcFkDw3iG1xrAfxURT5CYhYqSleUA0jDePZo0RzXkCx00A
         d7JlObD/1gJyEP1KVUNUEGFeUxQxnd5JF5DNmoNJtMjC3tdxn3vl4QZlfCR8uB27ixs4
         tHovmkJldQ3bzeJFxubTHicgd11A/pS9jYWs41XvAFci0qvXy5G5OvbSJWjG/qMntMGy
         HKKVyiMyaOpVrsMlY3ME9VRoNSbK2ykOB65ea7NLzjocwLN0nb523tUTPghXNPnwanfi
         EdQLMl7ZQphBczfXn7RCmT5atR34pi8uRjeIeMNAhovRtgY/A592IJWqfx13bjKXhU54
         sO/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUp1lud8oNgYZ4FR3FFX7yzlOvpkvtTNjTU+G8/eaqYNUedrHm+V/ErvlFmY2ldN7D/E4VIWjh8zikJHeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcsk2FvtAckUOYJ9ImwBNXIZO/QE6Xy8jd39WFXY/qwjj0zMYk
	Tr5RRWnKm54+R8BgvXvWZ/6xa9HOS9uVCHJwjaSyQVh6jYwcfFma+2gJZDEAfPs5kim7ZDx6MQ6
	yGMWsNA==
X-Google-Smtp-Source: AGHT+IHTzIxTuVH0iBc/Wetl3OglVpuBmoTjMFFkn5giODY9ZMdLZnT9mS+lz6s0hMvXU5NsvYHqeQ==
X-Received: by 2002:a17:907:7f20:b0:a8d:2a46:606f with SMTP id a640c23a62f3a-a90294ef246mr1457952766b.38.1726460458729;
        Sun, 15 Sep 2024 21:20:58 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061328e6csm257608666b.203.2024.09.15.21.20.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2024 21:20:58 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c3d20eed0bso4580998a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 21:20:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVc7BWNnWksV4Kudmh4vnI+744/QJ+ZV3BqnkYQZpd7T1OO6b4yiHgFkCuXzXWBNcvYWnNMp9LpsqTd3b4=@vger.kernel.org
X-Received: by 2002:a05:6402:2107:b0:5c4:367e:c874 with SMTP id
 4fb4d7f45d1cf-5c4367ec9dfmr3443219a12.11.1726460457889; Sun, 15 Sep 2024
 21:20:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
 <ZuNjNNmrDPVsVK03@casper.infradead.org> <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
 <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com> <Zud1EhTnoWIRFPa/@dread.disaster.area>
In-Reply-To: <Zud1EhTnoWIRFPa/@dread.disaster.area>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Sep 2024 06:20:40 +0200
X-Gmail-Original-Message-ID: <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
Message-ID: <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Dave Chinner <david@fromorbit.com>
Cc: Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>, 
	Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Dao <dqminh@cloudflare.com>, clm@meta.com, 
	regressions@lists.linux.dev, regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Sept 2024 at 02:00, Dave Chinner <david@fromorbit.com> wrote:
>
> I don't think this is a data corruption/loss problem - it certainly
> hasn't ever appeared that way to me.  The "data loss" appeared to be
> in incomplete postgres dump files after the system was rebooted and
> this is exactly what would happen when you randomly crash the
> system.

Ok, that sounds better, indeed.

Of course, "hang due to internal xarray corruption" isn't _much_
better, but still..

> All the hangs seem to be caused by folio lookup getting stuck
> on a rogue xarray entry in truncate or readahead. If we find an
> invalid entry or a folio from a different mapping or with a
> unexpected index, we skip it and try again.

We *could* perhaps change the "retry the optimistic lookup forever" to
be a "retry and take lock after optimistic failure". At least in the
common paths.

That's what we do with some dcache locking, because the "retry on
race" caused some potential latency issues under ridiculous loads.

And if we retry with the lock, at that point we can actually notice
corruption, because at that point we can say "we have the lock, and we
see a bad folio with the wrong mapping pointer, and now it's not some
possible race condition due to RCU".

That, in turn, might then result in better bug reports. Which would at
least be forward progress rather than "we have this bug".

Let me think about it. Unless somebody else gets to it before I do
(hint hint to anybody who is comfy with that filemap_read() path etc).

                 Linus

