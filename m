Return-Path: <linux-kernel+bounces-368875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6269A15F1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1284285167
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7F81D45FC;
	Wed, 16 Oct 2024 22:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Iye5OD2K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9F718732A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 22:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729119351; cv=none; b=stLIhayNJevgv7iP4I3owH/DVfTD+fplrq9jIfhj7y55JmkGB8gATj/sDkLuyGnRSB2PVJDrCaVnktT7SlKzyLopX+rgj8rdOaBtFwT5x0+A2UmcrY8KA2HPfgkThyv8nweQmuSH6DTC6VMl5n1e7EWd9Q1pJo2roRhAxGhA4+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729119351; c=relaxed/simple;
	bh=bT2JLjZZKc7+vXZL6LB9hRUEx0yRWfaUyoEzcklQZP4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bz6rAfUVYgrtrvMktPFRoa8aeEVIVaJvCKJfBjoNqmqXIjyoLrzdPAkMmCvwe/UTl0Y7YPIWynq767608Q8S6BbhnKOx8bmtr4GLmnEsm1ilGiJqlgLLAW6lKNo9wEmtvR360HJGYx9K1hUum9xGidx7+/V++Lnn/scJ8EFXf3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Iye5OD2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1226C4CEC5;
	Wed, 16 Oct 2024 22:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729119351;
	bh=bT2JLjZZKc7+vXZL6LB9hRUEx0yRWfaUyoEzcklQZP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Iye5OD2KhLQdb5t8pJDtrEhGRIJgUe6Ecoc0jeRc9weQzJ10pmoEILIRE5u+QgAl5
	 hln/UELTBxTf2++S5mrY6sZshB+hUHHTpDxojpA2smbi6uKn+AJyGz1GEmwYSIHYp4
	 iokrlb/FzZh1jCLJKI2udjGBCV7U6vNierV2j9KA=
Date: Wed, 16 Oct 2024 15:55:50 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yu Zhao <yuzhao@google.com>
Cc: Wei Xu <weixugc@google.com>, Brian Geffon <bgeffon@google.com>, Jan
 Alexander Steffens <heftig@archlinux.org>, Suleiman Souhlal
 <suleiman@google.com>, Axel Rasmussen <axelrasmussen@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/mglru: reset page lru tier bits when activating
Message-Id: <20241016155550.9ff2ab4625c7f19b6be8b7e1@linux-foundation.org>
In-Reply-To: <CAOUHufb2nJ4-qEWrS_d0X_8FbLKR-+=OC3yNh1ExthKXiYYKHQ@mail.gmail.com>
References: <20241014221231.832959-1-weixugc@google.com>
	<CAOUHufb2nJ4-qEWrS_d0X_8FbLKR-+=OC3yNh1ExthKXiYYKHQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 22:55:23 -0600 Yu Zhao <yuzhao@google.com> wrote:

> > @@ -257,7 +258,9 @@ static inline bool lru_gen_add_folio(struct lruvec *lruvec, struct folio *folio,
> >         gen = lru_gen_from_seq(seq);
> >         flags = (gen + 1UL) << LRU_GEN_PGOFF;
> >         /* see the comment on MIN_NR_GENS about PG_active */
> > -       set_mask_bits(&folio->flags, LRU_GEN_MASK | BIT(PG_active), flags);
> > +       mask = LRU_GEN_MASK | BIT(PG_active);
> > +       mask |= folio_test_active(folio) ? (LRU_REFS_MASK | LRU_REFS_FLAGS) : 0;
> 
> We shouldn't clear PG_workingset here because it can affect PSI
> accounting, if the activation is due to workingset refault.
> 
> Also, nit:
>   mask = LRU_GEN_MASK;
>   if (folio_test_active(folio))
>     mask |= LRU_REFS_MASK | BIT(PG_active) | BIT(PG_referenced);
> 

Thanks, I'll drop this version of this patch.

When resending, please include a full description of the userspace-visible
effects of the original flaw, thanks.

