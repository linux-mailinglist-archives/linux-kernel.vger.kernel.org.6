Return-Path: <linux-kernel+bounces-516020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C57BEA36C13
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 06:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171B33B227C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 05:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68ACF17A586;
	Sat, 15 Feb 2025 05:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxDi5gQb"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F32B567D
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 05:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739595631; cv=none; b=CAnyLU+8J4FVpVD7v5nw/rnsTYGuyZ3taXJY2uhZKv6BOyWJJHaw+bpwGdY2HQeDEJftcujAsjU1kVZp0RsfhGw2F/fVsvJ2SWXBtcpxiF5Czer4H/hKS1+BX/3/hKj/rAQE7ucJkYZbGHBK0TozM8+4U/yvgFC4hYau860Bqoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739595631; c=relaxed/simple;
	bh=AG+rUztNuue/gbPZmbjg22gL5GbzNaJi5aTxotGayLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gyImhtZWe2kJrukTTZJxt/n4BbguElSbA87heUul4PVLgkOvDAUFszOvmIdRevDnYuLXXWS9u6qfBjUe0IFUHdS0VLTe4QQ2Wp2MEN5EbKKhUlwczVS30iPnf1M+PlsX2XalOQvaUp9k/kwb+SX43fMvcm9psrhABdstCA6UGrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxDi5gQb; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f9b9c0088fso4361751a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 21:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739595630; x=1740200430; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YyTKqMokW7eqhT1f5N4w2aawxCnj9KR60TAyjoqorIk=;
        b=MxDi5gQbuXGnwn2OAMZ8SSjP+pReCOfwhHGG+M5b4HEs17ySASrkq95EHlUkfYzvmQ
         m6qv8EbmCQqm7hRz0ddzEr29Ks4X12hGO76MlqULX0fbZgLzeSREhcO6+JYarZ3EmGd5
         1BoYhw2VWKB7q543+JwmNzk//NX8TiHgWfFkjhd3N6xRlBQE17SB55/PYd3sbYV3/r3S
         joqJB5kha7bJHlQKD3KU8bWxJ+Oe95ss9xKDhlAUbcwZrihap0WN8uvT1kBO1mb2dvMg
         +BZasmiyVCAnQ4G+l5IYxcbQXA1ZKc7ZdZVu3aVtcR9r8qCQpNhhm0oOzem7xfkS+jWN
         PO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739595630; x=1740200430;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YyTKqMokW7eqhT1f5N4w2aawxCnj9KR60TAyjoqorIk=;
        b=VeOT5qalJdjk/uqMzWbFwr5/Xx9TMGg+p7Hr7Xrr5YGQzzu/Fyjjcwexe0GT/98BGI
         5ymnMrK2ksAgFXpY6XM5wyZhf8tTlkc8xLgkoWkgO3YrQXj+GBmJ324+xM5xPaETvWKT
         d2q+m4tOoIKPnSaJlTAW3DgwG9OPqZQyD8tCEvh8m+pBu7naVfrgqPS0Uzr537E6JQaY
         07J5Cz41o6iyaI9TwcuAC/kF4Us5L/Ai3eO9kSYhUIMn912bydlZlQrZ0GmPWOJLdisT
         C1D3OW89gtMzmfcOgSF+OVlUQAuz8hH/uw21ZSrOJpU917qhmQYO5pQDEDFYV/U0KN1m
         NI0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKv9Gz4dl26LBvIFwcbC+nCmzBwQzVYq4TsKiKPQ9Dn/oSi/JWsH5f07MugDfNjfKGxdv2L90hC7relpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ei1nkdeoE1GRowj5plP7HqNmDbo7DyrDsu6zklWtMdtCSmWN
	i+TWbG38D3FpcyuiLHImOxVbDdSIa6G7AF4BIy4xb7mGxhlAZim+w9Pua2kXjxCIz/lOS8DHgu5
	AUjJBENnWTj87tUwQzOOUs9sxPWU=
X-Gm-Gg: ASbGncspdSRWaY7qv+FffgM8BTKev90wFjihez/adovYv4Kookil/i+ULEPjiNgt2DK
	WLhmSzR53mv1rMyAdKB/GYpFDOaVoajzQmgnJXTH3uBQ5vh1KoEyNDQw2PRhb6FUbEgAXzDClE9
	g=
X-Google-Smtp-Source: AGHT+IGYLIuH/5Vd5fliH78JnG+bExE7rDKQXk+JXDjfnyS01OBsE8s1RDs7WxpXnLI6/gRQezP5pV0WWr95KR7yztA=
X-Received: by 2002:a17:90b:17d1:b0:2f1:2e10:8160 with SMTP id
 98e67ed59e1d1-2fc4076f03dmr2875459a91.11.1739595629648; Fri, 14 Feb 2025
 21:00:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214180157.10288-1-aha310510@gmail.com> <20250214152128.61a1054b90d1a53eff9cf16b@linux-foundation.org>
In-Reply-To: <20250214152128.61a1054b90d1a53eff9cf16b@linux-foundation.org>
From: Jeongjun Park <aha310510@gmail.com>
Date: Sat, 15 Feb 2025 14:00:23 +0900
X-Gm-Features: AWEUYZmdoyFh_t5PQgQovfllDozb3s0-ajSRJKaKiIQxMT-PvxrGJF7sLWU852Q
Message-ID: <CAO9qdTHkk-4C59sv=B6ZPkcu4AmSNtuvFsdSWQNmwHoTXTCLmw@mail.gmail.com>
Subject: Re: [PATCH] ipc: fix to protect IPCS lookups using RCU instead of semaphore
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Liam.Howlett@oracle.com, brauner@kernel.org, lorenzo.stoakes@oracle.com, 
	willy@infradead.org, davidlohr.bueso@hp.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Sat, 15 Feb 2025 03:01:57 +0900 Jeongjun Park <aha310510@gmail.com> wrote:
>
> > In shm_destroy_orphaned(), we are not performing updates to the IPCS and are
> > only calling idr_for_each(), which can be protected by the RCU read-critical
> > section.
> >
> > And if idr_for_each() is not protected by the RCU read-critical section,
> > then when radix_tree_node_free() is called to free the struct radix_tree_node
> > through call_rcu(), the node will be freed immediately, and when reading the
> > next node in radix_tree_for_each_slot(), the memory that has already been
> > freed may be read.
>
> A use-after-free?
>
> Is there any report of this occurring, or was this change a result of
> code inspection?  If the former, please share details (Link:,
> Reported-by:, Closes:, etc).

Reported-by: syzbot+a2b84e569d06ca3a949c@syzkaller.appspotmail.com

Sorry I forgot the Reported-by tag. I think the vulnerability is caused by
misusing RCU. In addition, since it is a function that does not perform
an update operation, it is possible to protect it through RCU, so we can
safely get some performance small benefits by using RCU instead of
semaphore.

Regards,

Jeongjun Park

>
> > Therefore, I think it is appropriate to use RCU instead of semaphore to
> > protect it.
>

