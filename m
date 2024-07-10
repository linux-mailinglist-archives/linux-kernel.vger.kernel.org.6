Return-Path: <linux-kernel+bounces-248062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A06EA92D7E8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506C7281F6C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A6A19596F;
	Wed, 10 Jul 2024 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CbYZH1Gl"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70321848E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720634393; cv=none; b=YM2oZ0zvXx2HXfrbPNNOmdGPj/7BerMjpgOVCiLhpoT97DfAeTkH++vGq3/uiXZdBcwgmAbwp2jwi+LuPaWXQuAajG93/vEIWHiMua09sFxh68+2O+DGfu1tRjgzEKvaBlXvTJVoXKAca36g5J1iuHApKEDrfO1SYf682JYAvCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720634393; c=relaxed/simple;
	bh=GAPNZcvser605hEu4iiSAliRidVEuPdS1XtY2MqVrAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKwCNjzyTUqzXVL9u8duCsrSrEILG6foXRfEJBuI4l9abCRLZMELZ3TtQdjZweAMKTFMUvorFysnCP9q2efRsV3ZUifKvjISWG74UUbpT5373WM1yx8YD4e8JKyyrjsLZCdWlNjFdxSwUj00cqE8sd1HsqWVcYw7QD8G3o+r/0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CbYZH1Gl; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-447df43324fso25211cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720634391; x=1721239191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aF3CnZV7DMRprpGI4b2ruu391JiaLKZraUtA5FT1zY0=;
        b=CbYZH1GlTCNaWQB0ahc8iHfcCt+3P3MDXCRP82n14F5kkJJMReAdDHX4bdfP7QgmVS
         UqeExnPbn2RgSoWqJL8OA/UnJDqC2RtMpcYtwVw1H6gYJrJknye6eMnkAHDuD7ZUWuKl
         jscTZQHRKtPW1NNo035do4C5pxSfLr0nHofQnR42X7l275lTYyvQPvsId4Gdf7CzYYbV
         RPYKn0Au8cg3WU6E0w1cuiBlFL+3WVVdB5A5f8bSfqpu+MnpnspiLEh2A+9cT5FLm0e4
         QdFwUpSYsxOJ4DFaYaQ2/0h+Ly1wr5zIGiN/KRrSkzX+6W/JGtPIqssnH49SS1BkhA2/
         Yh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720634391; x=1721239191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aF3CnZV7DMRprpGI4b2ruu391JiaLKZraUtA5FT1zY0=;
        b=Xl3YQMMOnoO1+ykngmnpFNl6FWFWcWrZqWDPhzbC0xTuMp28U5OhoP1oh8KwMnBMFU
         OSgTMIKtmuIh2K20p5CrnF6AgLYp+lf9P07AaAR3jgzNzymuSj5nnSC1eJ4twsGW28DS
         VXotu4MVUxVwrEbPGnqyKy9P5EVFYxbCRKiPr5lPXM6H/AFE8iFcAoKCrvkSxbPsrS+K
         /qFqbiOhZkRG3wc/t6QHfaOGvv+0O4ziImMAg7XONYlu11PjXfU9s9sbsiGPcPrtWrEM
         wU4Pd+TIsltxruw5lhL+2uonRqROC1xDIB0jDusBrkLjmaCQByyCA/v5yckMMR8/MOlV
         ImWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRfYTQuKCV+obaw1WHuVROJOlhsqmaC7NOwcZdvNQ0tVTkyH5nihsRtybCJIu6wROLbB0oIKKF+CcnupWlqbJHjeWK6C4+4XA2F958
X-Gm-Message-State: AOJu0YxJnL9vuMpAy9CQIeQ+1I5Dfl2+FGA0EIE5K8lnPX3dzNQPYNeQ
	8b9IrOimHM7O6r2CKJh6GtOKpMjgEIKFhgPvrJaxgcRPGZcFpPtUoxh+T6TnqoE/W8QSQfhnZ2D
	IXRgsAu1ymSB7TQF9Lh1Ab9y77JBRtTbFf/+Q
X-Google-Smtp-Source: AGHT+IFUgm6+kfvtUIojSaSP1JNb9q6BBsgws+EhCtSdyUEJErn22fh9KctlnFuqFkqK/lTFoiBrWOKvvJfQy5snASE=
X-Received: by 2002:ac8:6887:0:b0:447:d7ff:961d with SMTP id
 d75a77b69052e-44d11893b0dmr61151cf.9.1720634391141; Wed, 10 Jul 2024 10:59:51
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604020549.1017540-1-yuanchu@google.com> <20240604020549.1017540-2-yuanchu@google.com>
In-Reply-To: <20240604020549.1017540-2-yuanchu@google.com>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 10 Jul 2024 11:59:13 -0600
Message-ID: <CAOUHufb_2kRGV50FyV6Wf4eCdeOUaXvV2-hdznH1bFP4XzYp+g@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] mm: multi-gen LRU: ignore non-leaf pmd_young for force_scan=true
To: Yuanchu Xie <yuanchu@google.com>
Cc: David Hildenbrand <david@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
	Khalid Aziz <khalid.aziz@oracle.com>, Henry Huang <henry.hj@antgroup.com>, 
	Dan Williams <dan.j.williams@intel.com>, Gregory Price <gregory.price@memverge.com>, 
	Huang Ying <ying.huang@intel.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Kalesh Singh <kaleshsingh@google.com>, Wei Xu <weixugc@google.com>, 
	David Rientjes <rientjes@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>, 
	Kairui Song <kasong@tencent.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Vasily Averin <vasily.averin@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Abel Wu <wuyun.abel@bytedance.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 8:06=E2=80=AFPM Yuanchu Xie <yuanchu@google.com> wro=
te:
>
> When non-leaf pmd accessed bits are available, MGLRU page table walks
> can clear the non-leaf pmd accessed bit and ignore the accessed bit on
> the pte if it's on a different node, skipping a generation update as
> well. If another scan occurrs on the same node as said skipped pte.
> the non-leaf pmd accessed bit might remain cleared and the pte accessed
> bits won't be checked. While this is sufficient for reclaim-driven
> aging, where the goal is to select a reasonably cold page, the access
> can be missed when aging proactively for workingset estimation of a of a
> node/memcg.
>
> In more detail, get_pfn_folio returns NULL if the folio's nid !=3D node
> under scanning, so the page table walk skips processing of said pte. Now
> the pmd_young flag on this pmd is cleared, and if none of the pte's are
> accessed before another scan occurrs on the folio's node, the pmd_young
> check fails and the pte accessed bit is skipped.
>
> Since force_scan disables various other optimizations, we check
> force_scan to ignore the non-leaf pmd accessed bit.
>
> Signed-off-by: Yuanchu Xie <yuanchu@google.com>
> ---
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index d55e8d07ffc4..73f3718b33f7 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3548,7 +3548,7 @@ static void walk_pmd_range(pud_t *pud, unsigned lon=
g start, unsigned long end,
>
>                 walk->mm_stats[MM_NONLEAF_TOTAL]++;
>
> -               if (should_clear_pmd_young()) {
> +               if (!walk->force_scan && should_clear_pmd_young()) {
>                         if (!pmd_young(val))
>                                 continue;

What about the other should_clear_pmd_young() in walk_pmd_range_locked()?

With that and the typos fixed, we should probably split this patch
out, since it can get reviewed and merged independently.

