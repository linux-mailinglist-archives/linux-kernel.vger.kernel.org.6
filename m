Return-Path: <linux-kernel+bounces-288398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 303F29539AF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8F431F22DC5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7516E4F883;
	Thu, 15 Aug 2024 18:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bzcODfqM"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497B057CAC
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 18:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723745465; cv=none; b=lisUV7jCnFEYHD0wTCnxi/KRePToSUhcXAgKtsoZerPpIgcDqj3A6e2EO/tkeZbNcTXDVrGibG3oDntsyaApAHsuPozOEWHKD8ofRQc2YipnvNSYkrkUQ2dhCknxMPtF69i6P7+owv28OjfFb8iKNmE98HgWkLmCeDz2JmLvov8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723745465; c=relaxed/simple;
	bh=jDcVMXrCiWJ0CENkxN8HulRXLK9STQN634KXwORwsSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/Y7Db8dDE5MM4/CWNjAYYxepx4Q6REvevoRL/FDwUyVrjpg8ghZHKRnCSmH/iCF3NDnbsFyEmMzBJFx6ERLFRW12nk8jF8yV5bJQxG5UE/9mnnPnbpd7WUxGVk9viR223BhFjF+FRBR0Uy/knVTD5a0A7I54gAArtvF024MTx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bzcODfqM; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4f6e36ea1ebso401654e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 11:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723745463; x=1724350263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ebf7Wi4TLq/FXpQ1/84J5moUBXUUd5tKcCYOOme7CHM=;
        b=bzcODfqMoWAZslG9oU+4Z22yPUFzi4yHSGPSPbB7WDw4nJcZgBWVw+ZbHyLu854e/E
         f2hfwIZPpd/pnZWrF2h6nmFOq+UVr5iZeJGGplOPjHTYiYUV3pJ+NXaG423SxC1zaPV2
         QsdX1R+XO3Ag5NlHUU0fRY5mm6f4kapxh3B6K0l9XmV7v+BV7DWJkY42eIHvLGU6+qft
         JOXgrmOHNaogUWMJljO1z1yee8tvm4cQuATnRAYcR80eL1b8vt2ucXe+HXNH3OO75CB1
         RNdgyCqzrP6LwG85Isy0Aibxg0RJX0SKVXQyiR3ppfBFoDSKkvJj+y8Gau0XJdcGRg1y
         a8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723745463; x=1724350263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ebf7Wi4TLq/FXpQ1/84J5moUBXUUd5tKcCYOOme7CHM=;
        b=C867VRzKIWCv33qVl8dRLriGBd8bvZ7YoiFzAiSlWrpbXBGSdn0dVUe4OHUuneQjNq
         mIwNEGZfkqDJF1IuUs8ZkL+WJ0jW1JUREJ2NKO/4JRjpmqyWwgvPj8Ju8pzvX1Ff9wLk
         F/ZBh0l7ph5U+x1Qlw/vVIEi/QCez2fDc0VhItsQ8eWFR7+qMMSLBC2RqXYpDDlNgOZN
         /JmBFt3VtSjl1YGkov/ya5RflY5woVaUP47v4hRzrhYZhhm2ZvHCVoB03C8+DdQRo8kO
         cjFMwCfwqQI/Vgh2SkBzZ0rI74Czh+5q2KgoVAYrAY6ojDK5e6/5ep5w/IAX6vhgZzOW
         PUnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU8zQ6E0/geL6z8spIHfeGZPNtB3PdSyacnRE6VQ/y4DXRJsWyel7triABoMU7NJjf88LtKvFKdb5kiW5v2+0SlcePVz7IsfGgV8Fa
X-Gm-Message-State: AOJu0YxovxMltJ+3Ag7Tew46UhHKLYgZLg3lgIcWzK1zpGOkXz5/zNl7
	dzKtcbDYwlvsf94uUy2e3Wr4DdbO1Bj1+0wZcedvmi8gGaVjqbRK06vAjZejCQ4C9DJOdAljoIg
	73s4ROsJESbwdU3gFlPRR7YTWvr2HPusPpbb6
X-Google-Smtp-Source: AGHT+IHpN9FAXt4QTpC30hZU1ytH96AYrsgYeD/ZGBIq5DTLPRCONedLwVMZExKVBty/ko5WXeqLqsYVoWsfNVYe6rU=
X-Received: by 2002:a05:6122:a19:b0:4f2:e9eb:951e with SMTP id
 71dfb90a1353d-4fc6c9ed8b3mr711408e0c.10.1723745462903; Thu, 15 Aug 2024
 11:11:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <37bbf461e81342a7b5798923b783e349@honor.com>
In-Reply-To: <37bbf461e81342a7b5798923b783e349@honor.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 15 Aug 2024 12:10:26 -0600
Message-ID: <CAOUHufZzmUU6YxOfQ7-v6AMj29uoMOLKMz0RWk9MRA4DkDSXAQ@mail.gmail.com>
Subject: Re: [PATCH] mm: add lazyfree folio to lru tail
To: gaoxu <gaoxu2@honor.com>, Kalesh Singh <kaleshsingh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Shaohua Li <shli@fb.com>, yipengxiang <yipengxiang@honor.com>, fengbaopeng <fengbaopeng@honor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 6:33=E2=80=AFAM gaoxu <gaoxu2@honor.com> wrote:
>
> Replace lruvec_add_folio with lruvec_add_folio_tail in the lru_lazyfree_f=
n:
> 1. The lazy-free folio is added to the LRU_INACTIVE_FILE list. If it's
>    moved to the LRU tail, it allows for faster release lazy-free folio an=
d
>    reduces the impact on file refault.
> 2. When mglru is enabled, the lazy-free folio is reclaimabled and should =
be
>    added using lru_gen_add_folio(lruvec, folio, true) instead of
>    lru_gen_add_folio(lruvec, folio, false) for adding to gen.
>
> With the change in place, workingset_refault_file is reduced by 33% in th=
e
> continuous startup testing of the applications in the Android system.
>
> Signed-off-by: gao xu <gaoxu2@hihonor.com>
> ---
>  mm/swap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/swap.c b/mm/swap.c
> index 67786cb77..ed49643ec 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -635,7 +635,7 @@ static void lru_lazyfree_fn(struct lruvec *lruvec, st=
ruct folio *folio)

Please work against the latest mm-unstable.

>                  * anonymous folios
>                  */
>                 folio_clear_swapbacked(folio);
> -               lruvec_add_folio(lruvec, folio);
> +               lruvec_add_folio_tail(lruvec, folio);
>
>                 __count_vm_events(PGLAZYFREE, nr_pages);
>                 __count_memcg_events(lruvec_memcg(lruvec), PGLAZYFREE,

Kalesh has been working on something similar for lru_deactivate(), and
he can help test and review this patch.

