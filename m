Return-Path: <linux-kernel+bounces-310424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F744967C8B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 00:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B75281A31
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 22:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDA14D8AF;
	Sun,  1 Sep 2024 22:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MyPWQScQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D1378C60
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 22:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725230427; cv=none; b=TcWE0j5Ow13WIbWVvCOg5BUjUJR1limP7EF23KGibSn+TE8T+SmRb0GZSHRd+/IOQADgbuoe7baYjc5cQPOfrg3/NW/goTJWJPimPAUTcWqrzKlUrvLTGY2lq9UrSwlGNVJEGM+kRjK7FdZCadeLf2WEeFpE+FcStTW2ApG0Y98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725230427; c=relaxed/simple;
	bh=cBK8ifRIkWx9LTf3ePvAC1yp3D3Rig4E4eLktnCzD6c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XMi51cTJmwxE/NYUZUikPifIcFf7ErA4Enu/jNOryYE5er44fr9oaunLAPJrJrj8oMd6202S/5Wq6YPQz/qZaNY9qMrLAW3eN6DLxPOHA6j7Wtlo69lWNOhXhFQ6hUqWBT6yA6qCxCxtLRKrjab8lm70Tj9xnr3hkXkzUJZrSDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MyPWQScQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2509FC4CEC3;
	Sun,  1 Sep 2024 22:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725230426;
	bh=cBK8ifRIkWx9LTf3ePvAC1yp3D3Rig4E4eLktnCzD6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MyPWQScQ09ooZoZlVyqX5nBhbQcSGuqwJxphQsd85Iaap9QtTufkGGhKwGEoVpVvu
	 fJro5iLbyA6o9itsnAgCjdS2AiOtoi6p+0FuNForCnWmcVWL9j0mrG+DI8UFMR43ud
	 +kilG3PWLJnzoEQQrCJB07gFkg2HMQiUQAvXJl9s=
Date: Sun, 1 Sep 2024 15:40:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kairui Song <ryncsn@gmail.com>
Cc: Jingxiang Zeng <linuszeng@tencent.com>, Jingxiang Zeng
 <jingxiangzeng.cas@gmail.com>, linux-mm@kvack.org, Yu Zhao
 <yuzhao@google.com>, Wei Xu <weixugc@google.com>, "T . J . Mercier"
 <tjmercier@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: wake up flushers conditionally to avoid
 cgroup OOM
Message-Id: <20240901154025.bbe4a99e228b36d50c1c91a6@linux-foundation.org>
In-Reply-To: <CAMgjq7AnaNr354zzu-Z-SB6xZtD1+a2zUwFtZ_Qg7pMj0m7y7A@mail.gmail.com>
References: <20240829102543.189453-1-jingxiangzeng.cas@gmail.com>
	<20240830173813.c53769f62bf72116266f42ca@linux-foundation.org>
	<CAMgjq7AnaNr354zzu-Z-SB6xZtD1+a2zUwFtZ_Qg7pMj0m7y7A@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Sep 2024 04:39:24 +0800 Kairui Song <ryncsn@gmail.com> wrote:

> > > MGLRU still suffers OOM issue on latest mm tree, so the test is done
> > > with another fix merged [1].
> > >
> > > Link: https://lore.kernel.org/linux-mm/CAOUHufYi9h0kz5uW3LHHS3ZrVwEq-kKp8S6N-MZUmErNAXoXmw@mail.gmail.com/ [1]
> >
> > This one is already queued for -stable.
> 
> I didn't see this in -unstable or -stable though, is there any other
> repo or branch I missed? Jingxiang is referring to this fix from Yu:
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index cfa839284b92..778bf5b7ef97 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4320,7 +4320,7 @@ static bool sort_folio(struct lruvec *lruvec,
> struct folio *folio, struct scan_c
>         }
> 
>         /* ineligible */
> -       if (zone > sc->reclaim_idx || skip_cma(folio, sc)) {
> +       if (!folio_test_lru(folio) || zone > sc->reclaim_idx ||
> skip_cma(folio, sc)) {
>                 gen = folio_inc_gen(lruvec, folio, false);
>                 list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
>                 return true;

I was mistaken.  I don't believe we ever received a formal/usable
version of the above and the mm-hotfixes-unstable commits

	Revert "mm: skip CMA pages when they are not available"

and

	revert-mm-skip-cma-pages-when-they-are-not-available-update

change this code significantly.

