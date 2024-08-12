Return-Path: <linux-kernel+bounces-283640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2351B94F736
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3CD41F21FA5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636DB18E772;
	Mon, 12 Aug 2024 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qyL4738N"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233E818EFC5
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 19:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723489620; cv=none; b=V7YLeiNkcI3kkblM6vHemd9tFNKN92lmeJJGEfCtTc0Axqir6LBSvMT4MZoh/JMVHNh5GcrLFJ+YDjCKCcDfGF5XnhaghkD2n7S4g+98WSwwOztP9hOxmA+Pfp2Iyzrvz2hc0DIoS+HOTi//k3BKWmNXIRMV0uMem2Aiet52ceo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723489620; c=relaxed/simple;
	bh=Iol1CFVoy+gFeVCbnyPayZ3JKGKO3O3as7Xw6sIc61Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTC7Ve/zRuPqo/CH8uYfu4uHBexUCFaQRjAZXotb0qqGj/NIEsu+AZHu2keMvP81HsN51g/B5QhePte3Ccv1d8f42FreWdGhOJAv4yY8bySSGkQcVbg0YJ43DGz64flZjTf3FN/RcNUdy6M0vSnPYJztxd8qBjVaomAe8U3AhDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qyL4738N; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4929992a5e2so1221135137.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723489618; x=1724094418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xB6GgYIvbyBy6I8JWqaCez1V6H7Bqdmk//8NtSPBKqA=;
        b=qyL4738NJ2cdKz8hALheUyxxSytxIdEHAwjTKkxEyaD/vd8/YxmrHUZqlUsU012fNQ
         oNfoEBGFNxYWEMCGiXIG6Wki1zK0kHOoBcZ1rfCBaSBDLxSzuo0DbmFLK3OiPsO+StOH
         ESvkvJj0ZCXcs4j2Y8CWaBUqAvBz5dcHyzWD1jmVdIpm1X7HBTl/PLmVoWj4ZAOFJXlD
         ruuuhSMfNlQnf8Tij8WoXJ39S0zEJ4TKX6PtKHu9+XZZo1dAoOyugAHHoQME/pUz8mqE
         LUPJgZZJVu3XeATaeaVqhsvWeFmu3ZDjojUOOjticPXsoZrNf18l7FXMSToqPu6U36Oa
         N3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723489618; x=1724094418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xB6GgYIvbyBy6I8JWqaCez1V6H7Bqdmk//8NtSPBKqA=;
        b=tnJ/XAnk+xk3zm6bVa31GaudCXpbrr9eEx1zVwMZal4Vd/kEghF9QrY5Upv4slaCAS
         LLrR9DacUUd/dBy8X3pGSEtzPi5jzkbNoKn5NfCQdYLS981jo2ZegPZsrDLPuBrviFHn
         iKidC8etDiNKVvLCDwThfp1pTo4iZb14aMIQZTpKwE10z9SmGglS2Eby+bkDmiiG5h7G
         loAgQtORc+7RUo1vwYnyBoORPmjb74uPSJT3++n8xWf6xHMyMn5hOm1xx/ccEPvGVNXZ
         rBxFF5gn068FXq02ysT+JV8ovFSFh0Mo2AHfMzpFye4XZxQ+bgL9Svyo76VvHWGTDD9V
         Esxw==
X-Forwarded-Encrypted: i=1; AJvYcCWSFlAtxT8Pt5cPhiT3j6ACM6PStShgwHyxWx/NyHwMNwQrhWq5gg+XDSKVYn/H8wi3BxEjOplUyNQyo4CFIX7vvw1kMMFGQKN/Zfv9
X-Gm-Message-State: AOJu0YzZXeYS8j1WCAEeBQBzOAaUeowjgTlBE9yi2E3Q0O8go2zPl/sT
	64dpZkhV4JDHe63g7rZTvgYDY5jR7Au/n6fYLT6iwYWAjNhWhdi5mV9N3uVd14TxSn6DNHaB1b2
	Uw5CLfZCwArKTsBMVVQYODbafmNYxwY8RvBc9
X-Google-Smtp-Source: AGHT+IGBu3SSdfMtnwvh5jc4QS+hZY4FzeoQfYO9cSrQ8tLL9oSnrAbTSuf/hm/n5/hVymVbKWDhCL8v1oazbCATSYk=
X-Received: by 2002:a05:6102:b13:b0:492:aa19:dcf9 with SMTP id
 ada2fe7eead31-49743942f38mr1644540137.6.1723489617727; Mon, 12 Aug 2024
 12:06:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1723461718-5503-1-git-send-email-yangge1116@126.com>
In-Reply-To: <1723461718-5503-1-git-send-email-yangge1116@126.com>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 12 Aug 2024 13:06:19 -0600
Message-ID: <CAOUHufY2=p=UA_S3ZmNGUER=p-ZTU3mfHtwDqBNRbPGY0-AuSg@mail.gmail.com>
Subject: Re: [PATCH V2] mm/swap: take folio refcount after testing the LRU flag
To: yangge1116@126.com
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, 21cnbao@gmail.com, david@redhat.com, 
	baolin.wang@linux.alibaba.com, liuzixing@hygon.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 5:22=E2=80=AFAM <yangge1116@126.com> wrote:
>
> From: yangge <yangge1116@126.com>
>
> Whoever passes a folio to __folio_batch_add_and_move() must hold
> a reference, otherwise something else would already be messed up.
> If the folio is referenced, it will not be freed elsewhere, so we
> can safely clear the folio's lru flag. As discussed with David
> in [1], we should take the reference after testing the LRU flag,
> not before.
>
> Link: https://lore.kernel.org/lkml/d41865b4-d6fa-49ba-890a-921eefad27dd@r=
edhat.com/ [1]
> Signed-off-by: yangge <yangge1116@126.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/swap.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> V2:
>    Add sanity check suggested by David
>
> diff --git a/mm/swap.c b/mm/swap.c
> index 67a2467..c048659 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -226,12 +226,11 @@ static void __folio_batch_add_and_move(struct folio=
_batch __percpu *fbatch,
>  {
>         unsigned long flags;
>
> -       folio_get(folio);
> -
> -       if (on_lru && !folio_test_clear_lru(folio)) {
> -               folio_put(folio);
> +       if (on_lru && !folio_test_clear_lru(folio))
>                 return;
> -       }
> +
> +       VM_WARN_ON_ONCE(!folio_ref_count(folio));
> +       folio_get(folio);

No need to check folio_ref_count() here, because folio_get() already
does it with a better check folio_ref_zero_or_close_to_overflow().

