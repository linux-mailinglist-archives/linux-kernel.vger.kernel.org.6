Return-Path: <linux-kernel+bounces-531728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BEFA44425
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91721893EB8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC8326B0B8;
	Tue, 25 Feb 2025 15:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tlHJ+Ol6"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A223A20AF82
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740496770; cv=none; b=BI/FstSxei7junCserHLlLqET9wSImPS67r/7BnfT5nIGgDrdqUtvmhj36i/xgmZ2pIeHFZsIDfC7BU6MuJVMzSivNy1cwmESBXRItNIRvKML/NFyJhP5hElYrRM+3L64faDIFT2qYm5ctqfGb34sbmCbAv7UUquDbf2pqxhdH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740496770; c=relaxed/simple;
	bh=nZjUnnI4Tn83SqMGtKaeEULz7AjZuUVve25TBnfZYrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHxJpLW7hiKBc+V4StNVwM1Hng9/JL/fqBZf+baEEBQ6cnxkj9qtS+jHuzsOs87T11hl8s4PAxZQdkyDbt+gg/f/q+nJug17XKol42ekoJYt7OQkyTXF3fzdsSwUe42C2CXLpw3nfJn//ZFXNxGRS6rT25Jl9SOXEaAFnUuutw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tlHJ+Ol6; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-472098e6e75so320671cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740496767; x=1741101567; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nZjUnnI4Tn83SqMGtKaeEULz7AjZuUVve25TBnfZYrU=;
        b=tlHJ+Ol6DD36QJ0WJC+x4EgAZi+H8VS2r3+nuzJ4Wf637V9/0U+j4Bxg5wDz4UgmC2
         Aa2jnGuyZPaepepu4Qlz1m/ArKpXGnnaGUJ1+jhS1FYxKCuUJFKcW211/r60zbWe+IMO
         AuxkGMK9HQ9pyRqICsFEwEg+6jb2lJ405EefCGdhSziPoKAHTYPXDHDGjyDGzKauBovW
         UoVkJAzSYaf+jioEn0sU33qHE5QyohCGClh8XAZh25iyyiZ7JW8XCy5n+TQ7wt5MYzZD
         BPW0b8X4N2C/cVxmIvmzC5HqEqK6RrNxTtt26c7pOnx+wAzq2kv4nhXbMaUSzVt2HsSq
         fq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740496767; x=1741101567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZjUnnI4Tn83SqMGtKaeEULz7AjZuUVve25TBnfZYrU=;
        b=OyCRULYbV8tKaAE2fFpnYs3Z+92N8mpPMGvSlpe+mV+HoDidnoD2Yls8g6YA3ZiTMS
         mTt+8ExhM9qimzWu/RWOOPdljVyyS3Cj5ghyxGAdkgqurDoLAh6vua7ytp9cJt2J4paO
         cBVbvjf1frqGZVKYfL/f6+TOVo11VfrP3sp85b2Tv3k+Fi0zILEGV8DKPQGUpkD5w6Li
         m97+prOSfaAeFPD2Xp6YHABHINUaEADFfV1TdlNfqsSX9RKQKdow33EfOJos/JjN6tZB
         eiS9WjwFAIVN9zOEZ1oKBWdb8vriGoDAllUpFJ7JclECvvTms2txGf13D4PDetyIndOe
         q6dQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1OH369wvZxqrqV35Boux08DvwFEBWAxN8Hn0Yr9v2ap6T1LkMtqDI6XKvhbanmfbdIW5j4cQ2UK+9hfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxshXn6r2E1XtW4L+BGTuYq/auCo0gDc6zNllnerRCeSE2posDA
	2Wm+GIKDzWz/r0LloCKRgf7zg5CHxm7awDEBBrso6Gw9KNwCmp2jVqiLV7wXk80ZVFnpIkqlGUJ
	8OX6VQn1rSClNVMsof1SZiyKo1BsuOTv0XRGp
X-Gm-Gg: ASbGnctm0Y0VOiLOqQw0BGHBQcAf1Py9Ueji7mBVlywtvUy3NlCwFqP2tT09ckNFGiM
	5Se9FUXNl5FpH5t4zdAtPgKDlLelMxbPi5qjPbv32loQK7kVO/JqYwTCQ0CRtmDCx/zV72RHb8A
	xqatGpnf4lm+Grh+20t08/nR6now/9kJ+5xD3DPQ==
X-Google-Smtp-Source: AGHT+IHU5WwBLnzqr94ytG6aqHFkY7VP8cLo4bWI0/eKaXEMfxGxmRvBUE5fV5vQNriiNYz8gqAQZ/MyNQoTqpHaZaA=
X-Received: by 2002:a05:622a:290:b0:471:b772:c717 with SMTP id
 d75a77b69052e-47376fdb950mr4251781cf.26.1740496767223; Tue, 25 Feb 2025
 07:19:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225001023.1494422-1-hannes@cmpxchg.org> <20250225001023.1494422-3-hannes@cmpxchg.org>
 <Z73JB40tGaWyVIJK@google.com> <20250225150940.GB1499716@cmpxchg.org>
In-Reply-To: <20250225150940.GB1499716@cmpxchg.org>
From: Brendan Jackman <jackmanb@google.com>
Date: Tue, 25 Feb 2025 16:19:16 +0100
X-Gm-Features: AQ5f1JrJIvBv4zz0sLW321G6YCL1S-YogwoR_uXc6Pl0X_RbSIMsajEMNQGwF7g
Message-ID: <CA+i-1C3jSwVGizsrCrXL+hojo7bdiv=GSxMvGSo5XfTgxSn0rw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: page_alloc: remove remnants of unlocked
 migratetype updates
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 16:09, Johannes Weiner <hannes@cmpxchg.org> wrote:
> > Now that the locking is a bit cleaner, would it make sense to add a
> > [VM_]WARN_ON[_ONCE] for underflow?
>
> Yeah I think that would be a nice additional cleanup. Do you want to
> send a patch? Otherwise, I can.

Yep I'll kick off some tests to check it doesn't fire and send it once
that's done.

