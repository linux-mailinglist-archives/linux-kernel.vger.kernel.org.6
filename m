Return-Path: <linux-kernel+bounces-293732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFF29583BF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10542841EC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539B018C93A;
	Tue, 20 Aug 2024 10:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAehXA3Z"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CC518E37C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 10:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724148697; cv=none; b=iO9L9mSF1BWhPr9yxxcWSwwljGuxyX658Fe+Zj4jIaAfmLwC9wUEiD8F4zWkhZYHQy8RPYy5/8eE3ArRr/d95nJ2eZbK7CAOsC0P7uWm7nSNBXZvUZvsPUJQUUUBdhfIec7IS9iYOlG1572KnqbEIUgWxR0djn97SXytdjqRhXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724148697; c=relaxed/simple;
	bh=GNPnTz6aIlIqhLaUGuoRqCHOJTQu2Xm+pVUoi3YQalQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BfHIr636eXVTodjjt6VMN/nAEXVZDqJctfrubpJmAQoseagMSSMJgFH7LZleIczDdWtcZaNGFnei66bgipHnsRPjQaWJBe2K24thbKoRq//mxRLfpg6Rw8xGFP0qP/xQis3dRtS17sohoWuPjKnZf95HNyG7XY7WHypo1C1D04k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAehXA3Z; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-8430670f247so1310579241.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 03:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724148695; x=1724753495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nF9S5axPX+d6KdUCX914qYZ7PwT7JT7vV7x4YJM1rI4=;
        b=BAehXA3ZCtotmhD6zao1GYMoe17pvDPZmyvD3XzHwploLAdDnGi5s8MVOlvBJP62DR
         SwwwxOwwS63ZJqQaXP4jD89zviOqdStzPDAoLa9g9kx+AhbXnzOVXDwxxLgICKM7V4AK
         rl56hs+ySdBGG0/y1Zwkmr7+ZgiIP+5KFykWoqMN/4BGrmuDABeGzRh2YdSM4OWF0a2w
         gbpU63YH/Yapo+0aiK0oeIE2V+IY8YwRyI31Bwa4mc9fKf8RwOdBhwPaAeHTmFU2e9dy
         L0kPYQDFsgFO9txP9kWGI0IxMHcqc5boHV1JuF1HNoqmY9d+7Oj7PDQeyBaACxYW4CGK
         kwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724148695; x=1724753495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nF9S5axPX+d6KdUCX914qYZ7PwT7JT7vV7x4YJM1rI4=;
        b=mDN2mLPMIBWRMUWjfmW/kJAin7Lv6odBxMa4bLP8wpHP8MT6ilFOjRvuyqmDIdj70M
         Ra3av2EHqKN4c3gNEVHy4s8wPrB99/7Q94eDjY+B5PdG4KDYEka8pnxR3dPslGilVNIe
         eaDfqkAvvisR/LvV3IFsJbr8IB/BcUFpcCOo5rvbzvHvRLQ2197D9wBbGwJ+GykeKU/U
         mW0WyChgDi+jSxa1SHKgdJI4XE3TG9Cu1L0IS78MnQBvI7G5yWzXoB4LHzVsEdYehed+
         pvUC6tRCCt43DtUY5b0nOc7y7nG0pprLnP75TZvUKBrhc3CE6auvxGEO7xhhBXMXvB1E
         RfIg==
X-Forwarded-Encrypted: i=1; AJvYcCX0iPv0YfLVXo8m89dAV9s2exCAGO1sZZEo4nC9X0m1FXXw0DTL4RVYn0ZUo188czenMdsxJWfcpAViAFphCpSvPBkjZzo0801+tMwO
X-Gm-Message-State: AOJu0YziCIzM+Wss7MR9Qlk8R5fzM7/FhxOxDf4wkSasdK+14Nv8dA+C
	MQbRVkfGlC7/tbUPYgoFGrf9huCFTQK12Oscz5iHvPK5BeCVLSph0tU0AC2zOvniNrvjk1Xhd6Y
	okExYyq8P0wCbyJDcmqxtEOCUxVk=
X-Google-Smtp-Source: AGHT+IHY2GJH4azXVKTaIBxjD7Gk06+2FNujSUPDMZwMWR/OS9MVKJ3Uwim/wDGOBGMuopIK1ZK+17m7iyb3suxHgQ8=
X-Received: by 2002:a05:6102:6cd:b0:497:6a77:8097 with SMTP id
 ada2fe7eead31-497799848e8mr17854017137.23.1724148694706; Tue, 20 Aug 2024
 03:11:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f29f64e29c08427b95e3df30a5770056@honor.com>
In-Reply-To: <f29f64e29c08427b95e3df30a5770056@honor.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 20 Aug 2024 22:11:23 +1200
Message-ID: <CAGsJ_4xTW5y4O6BoVuXKk=awhoiZV0zitPYYbfsX1pmqZgY9WQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: add lazyfree folio to lru tail
To: gaoxu <gaoxu2@honor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Shaohua Li <shli@fb.com>, yipengxiang <yipengxiang@honor.com>, fengbaopeng <fengbaopeng@honor.com>, 
	Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 7:48=E2=80=AFPM gaoxu <gaoxu2@honor.com> wrote:
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

Hi Gao,

Just curious, in which scenario are we frequently calling
MADV_FREE but not MADV_DONTNEED?

> Signed-off-by: gao xu <gaoxu2@hihonor.com>
> ---
> V1 -> V2: Based on the latest mm-unstable, recreate the patch.
>
>  mm/swap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/swap.c b/mm/swap.c
> index 6b838986d..e0dbfc983 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -641,7 +641,7 @@ static void lru_lazyfree(struct lruvec *lruvec, struc=
t folio *folio)
>          * anonymous folios
>          */
>         folio_clear_swapbacked(folio);
> -       lruvec_add_folio(lruvec, folio);
> +       lruvec_add_folio_tail(lruvec, folio);
>
>         __count_vm_events(PGLAZYFREE, nr_pages);
>         __count_memcg_events(lruvec_memcg(lruvec), PGLAZYFREE, nr_pages);
> --
> 2.17.1

