Return-Path: <linux-kernel+bounces-517202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A49A37DA4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09041894B99
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CBE1A841E;
	Mon, 17 Feb 2025 08:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3kXDG27F"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B631A3152
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782580; cv=none; b=gT5ELQHfgEZlJ15dG1rjT+kVpndmBTwTsay9OwFnuqB3vrA1k4eVz375OqSEjZcF9LYT6V+BkgxL1kDH6fKwQq5c7dz8ADRVGRB39uONNG129Om0j4o/Rxa6DYP5dOqN0rziXmAAhtZwWhI9Vda7xYusT/t2dsCE+zyCnmsgFl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782580; c=relaxed/simple;
	bh=rSMNGwh035t1vgisSjnlcCCc7am/GET8bwd1o2yn6sQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLJkrIsjqM8RxYs4KCsWHfkd+2v1fla+jHRuP7CrioWwRHNqn5UyvR4No4Ho7mEd98fMDfLxbM3IM/p573szMvkiFg+nb8l6MQOzpnPPaMWoW09gw7Bxjc+NMIwcTwOpevwWsyiQOrdtzbU40ujd9M2jw6g9GW9fGD6A69mS04k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3kXDG27F; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abb86beea8cso233469866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 00:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739782577; x=1740387377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9fzVMy3EuccpMQqhxoX/SOE/CZjtz9LlygVskmK9lA=;
        b=3kXDG27FWhT01M9JuWjMzmHn/xX5xJ1D35SOGgD/Qt2sXLqcz78n06P2+dRPzNKLU4
         KCwi8wdqZwuCB8T5U4hfc8YMt17moYxzPBFwFqX/wra+TCbrNidcB2yFQKjr4UISVbYx
         HTXBbWPOWAMmSvpTl8n4U6n0YhyXB7qv3e4gHj1clb7+OuLPMC07aulYbi2ZMJGZZnS9
         ocR3Cr84l5dp0qBzLXGYt2iKIUhaOyPMTatqJX9WFZuYio2sw+X6TbWmZwY0R5P9me5H
         3BfRDl3KEtnyqGR7SN1rkpnGvyDbZ8QiJp8nH/mYVBGJc3oyo66HnA9FbLlwoCShxVZu
         kfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739782577; x=1740387377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9fzVMy3EuccpMQqhxoX/SOE/CZjtz9LlygVskmK9lA=;
        b=JQcl/1K3ZMWLuLvsVD/4ZGhsNsUM4k8Rz9UkCTspvdDKpNBbLludwqYOv6jvDvmmzp
         xe1lIVcpCoAIMDopu1l9GBZHzT+dkyPK2SozjxwLnMwiIaPm4QrsKI5nsriKdZOe9Eay
         Fg8izl9VelIpJ+wh0hnRFQ9VHBZhDDhDNlXKKS9LdTQRIAiZaFAxACgMbdUvKwBP3HHO
         313OvprZCKYBK+b9LFy/sf3D1kZ1PkAzqbHDwrFMGM027AxVpiyHYcLeAFcks3OCdlwM
         8urJvj956bO4l67gpHEEBOhPqOIpn9yolNJ9wKlMCvFuanrwyYMxGOYuN+RNy+6KIHEE
         4/bA==
X-Forwarded-Encrypted: i=1; AJvYcCUA+fPE1qU/5xsaq1UIPaSQXZ5H2PV/OR1Dek28etqSYHeX7YQ23d+coURNiFPdtQL43uumG82N6xJ9SKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+JqbPnlJe4W5OvZex/wzteS0MnTlencBkMxCPLH3y0AtxxBYx
	5atRaFSnx0dRqMnPVZIG2GK05Om7o2UUA63rWGizhoVpqfzhAmBE+nWGmmR9FdtM5QwYyEw0ghR
	P98sRouZePI6hHtfmqlqsgNAq+NsPVGkH33Sm
X-Gm-Gg: ASbGnctCCwbpmclji5zdFclKY9eKMmD40zCWSCYz7EUzu4EjZmWV2sn1XD4Bo2jtSFA
	x8As4o5c0YobM3cT+qQq4+z/i1VM81tlxTxhCceIZd92suMrVbzwcB3D/OvySPuDUd+xji0R6dQ
	==
X-Google-Smtp-Source: AGHT+IHWt5SAAYDeYXdUcNKwcxZAqv+io1rowGJTMwarJM+W2ClYHlji61lLGs7htKHDg+kp7YH72yhKYU7FCuLtiYE=
X-Received: by 2002:a17:906:da07:b0:ab7:c43f:8382 with SMTP id
 a640c23a62f3a-abb70dd3789mr751029266b.31.1739782577285; Mon, 17 Feb 2025
 00:56:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250216163016.57444-1-enjuk@amazon.com> <20250216190642.31169-1-kuniyu@amazon.com>
In-Reply-To: <20250216190642.31169-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Feb 2025 09:56:06 +0100
X-Gm-Features: AWEUYZkLYy697Q1BcHQ0_hIbyfhdXPfDJNufGWgNEXRfNDqTFi2VIYf4X2t432o
Message-ID: <CANn89i+ap-8BB_XKfcjMnXLR0ae+XV+6s_jacPLUd8rqSgyayA@mail.gmail.com>
Subject: Re: [PATCH net-next v1] neighbour: Replace kvzalloc() with kzalloc()
 when GFP_ATOMIC is specified
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: enjuk@amazon.com, davem@davemloft.net, gnaaman@drivenets.com, 
	horms@kernel.org, joel.granados@kernel.org, kohei.enju@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, lizetao1@huawei.com, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 8:07=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Kohei Enju <enjuk@amazon.com>
> Date: Mon, 17 Feb 2025 01:30:16 +0900
> > Replace kvzalloc()/kvfree() with kzalloc()/kfree() when GFP_ATOMIC is
> > specified, since kvzalloc() doesn't support non-sleeping allocations su=
ch
> > as GFP_ATOMIC.
> >
> > With incompatible gfp flags, kvzalloc() never falls back to the vmalloc
> > path and returns immediately after the kmalloc path fails.
> > Therefore, using kzalloc() is sufficient in this case.
> >
> > Fixes: 41b3caa7c076 ("neighbour: Add hlist_node to struct neighbour")
>
> This commit followed the old hash_buckets allocation, so I'd add
>
>   Fixes: ab101c553bc1 ("neighbour: use kvzalloc()/kvfree()")
>
> too.
>
> Both commits were introduced in v6.13, so there's no difference in terms
> of backporting though.
>
> Also, it would be nice to CC mm maintainers in case they have some
> comments.

Oh well, we need to trigger neigh_hash_grow() from a process context,
or convert net/core/neighbour.c to modern rhashtable.

