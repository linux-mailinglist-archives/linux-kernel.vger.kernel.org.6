Return-Path: <linux-kernel+bounces-260207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6248293A480
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5331F2385B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE601581E3;
	Tue, 23 Jul 2024 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLoIxZVa"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110A6157467
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 16:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721753097; cv=none; b=NEowqG6nd4iZ70tt9lAn9jpWo0KCWvLzBQidhJPkMLyY4Br4mpBMQ5jY17MWjLB5FIT5q/GXJgKFSY54C4syyVEKLP2wbtK7/yucdiTAZvtdx2F71JkmH1UVXC4I2N7jEUxCz2umfi5zzQAHoPxNCOUHOB3sPMIIBF1WS6Bk1Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721753097; c=relaxed/simple;
	bh=NNvLWdFKg/+T/LGq8qPmN78u+zlvgEZMxDTpbvsSDek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ox0DFGR2WBWAXd5x+Uja2GWx0L9kpMvSSyfZQabqmu3RPplOd4XvBjJ0QUGRgEP1K1M0UTrA5F7W48OkJcm0lSaF4FNVkk5gexG6dVtd0JVdg+Pyi/OTRFd1exPZMuayhkB05DxOc3YCf8Zf+IYZvVUu9sxIkrd++ZzSaLE056k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLoIxZVa; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dff17fd97b3so5362954276.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 09:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721753095; x=1722357895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuWmgIHPZDsK15BuOy78U3m2lb9tQNShwei52QgqB8o=;
        b=kLoIxZVa+IczvfZumAul3TDNZOKW5PUAF9cmkS90iwpsu8iiivc33g9xWz0qjwgogS
         UjtZHC9hd9PZB0l/2kwhw/mxUdQoVzyS4vMKu2LDYQU9nt88TxVww0H4bPc/tSM459SK
         C5BHpvRRJrPZtlbWe5YliOD6DG3/3/hr6kABDI1YfbtOP22AjVhMWL5y6IkVPeyQlC1A
         IsKz0P65dABRUTqWhZLCrxAUjowkCqVt0LmG0tO8CjZWAVwSWx6riBb+Yoe/gJT+aRh6
         Hj3vlnB5tGovMPGyTGsOFaSPH8XHYHJVfhy2n5rJNcJt+wogO9eUHNBv7zPFvDiIMXLz
         x0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721753095; x=1722357895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuWmgIHPZDsK15BuOy78U3m2lb9tQNShwei52QgqB8o=;
        b=rfFEnLEgj3ao06I2lG0np2YXXBjn+gLy2kS34FOkaVDWtJY6sisfFrnT0yBbXUOoX9
         sI6rI5hFmsf0CpjJouMCfgxqYiR7e5x1TfIFPYxthJAGPX7J/IuGf5RRMtp7Etetr0tk
         5keOEa5SMHyR59SXkwWJ5ZDgitgpWZMIX6AOPHOjDu5yHCOXLCzUFCPVWaYMh9tBNcbv
         JQ0Ec17QwxhihmK+GMxwJBYNL0slayZ9C8Tt6IydNZ52hBxxwpe1JIeV2lsLNuRJerdf
         F5A9S0RWLTLKTISqmlwo4YDYa0RzCnwMgcT+87XgKS76/RkjJNq2z9pwoosjK6pOdPxz
         OKaw==
X-Forwarded-Encrypted: i=1; AJvYcCUbn7gQT9zu7vN14QdsbGLG44jDq8OO+4a16QfH++5FNqjDlpi0yb88OiJMlajyORMkGVmy+lvOhtfXOW053LJQ+wkF2aKplR+7KOha
X-Gm-Message-State: AOJu0YwZ+tYeActX1wxtKQhOmfZefWpAJyfoa2M6Up1AGF9BnNLn0Wou
	RTd2aeCLlKhGYVXkxrAqW5bb7GNtFP18pDy/0azNwFx6L65Rat5a+aCs2MWwTZiEsEvP7uqy4ws
	FuKmixuElQOrHqoEb95dFZ1b8Wt0=
X-Google-Smtp-Source: AGHT+IE+LG/KOyQucZr3AjVxnzA0WaThXyO3Mfyu1xXcvXnr5BgGcOfOxWqa2fjDt1cVGCebVOrUD3TyxUNcpUHahXw=
X-Received: by 2002:a05:6902:1b88:b0:e08:918d:7f9b with SMTP id
 3f1490d57ef6-e08918d8221mr8389731276.50.1721753094994; Tue, 23 Jul 2024
 09:44:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720044127.508042-1-flintglass@gmail.com> <20240720044127.508042-3-flintglass@gmail.com>
 <CAKEwX=NCm9t9Y6z8bWQ788_wnhQsGN0frroTabNpHStxGnJOqw@mail.gmail.com>
In-Reply-To: <CAKEwX=NCm9t9Y6z8bWQ788_wnhQsGN0frroTabNpHStxGnJOqw@mail.gmail.com>
From: Takero Funaki <flintglass@gmail.com>
Date: Wed, 24 Jul 2024 01:44:44 +0900
Message-ID: <CAPpodddd2SAVj3JmDHOz+xdaAc4nPT49_yHqnPCtcFSWqJk1=A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm: zswap: fix global shrinker error handling logic
To: Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B47=E6=9C=8823=E6=97=A5(=E7=81=AB) 6:51 Nhat Pham <nphamcs@gmail=
.com>:
>
> On Fri, Jul 19, 2024 at 9:41=E2=80=AFPM Takero Funaki <flintglass@gmail.c=
om> wrote:
> >
> > This patch fixes zswap global shrinker that did not shrink zpool as
> > expected.
> >
> > The issue it addresses is that `shrink_worker()` did not distinguish
> > between unexpected errors and expected error codes that should be
> > skipped, such as when there is no stored page in a memcg. This led to
> > the shrinking process being aborted on the expected error codes.
>
> The code itself seems reasonable to me, but may I ask you to document
> (as a comment) all the expected v.s unexpected cases? i.e when do we
> increment (or not increment) the failure counter?
>

In addition to changes in the commit log suggested by Yosry,
adding some comments specifying what memcg is (not) candidates for
writeback, and what should be a failure.

-       /* global reclaim will select cgroup in a round-robin fashion.
+       /*
+        * Global reclaim will select cgroup in a round-robin fashion from =
all
+        * online memcgs, but memcgs that have no pages in zswap and
+        * writeback-disabled memcgs (memory.zswap.writeback=3D0) are not
+        * candidates for shrinking.
+        *
+        * Shrinking will be aborted if we encounter the following
+        * MAX_RECLAIM_RETRIES times:
+        * - No writeback-candidate memcgs found in a memcg tree walk.
+        * - Shrinking a writeback-candidate memcg failed.
         *
         * We save iteration cursor memcg into zswap_next_shrink,
         * which can be modified by the offline memcg cleaner

and, the reasons to (not) increment the progress:

@@ -1387,10 +1407,20 @@ static void shrink_worker(struct work_struct *w)
                /* drop the extra reference */
                mem_cgroup_put(memcg);

-               if (ret =3D=3D -EINVAL)
-                       break;
+               /*
+                * There are no writeback-candidate pages in the memcg.
+                * This is not an issue as long as we can find another memc=
g
+                * with pages in zswap. Skip this without incrementing prog=
ress
+                * and failures.
+                */
+               if (ret =3D=3D -ENOENT)
+                       continue;
+
                if (ret && ++failures =3D=3D MAX_RECLAIM_RETRIES)
                        break;
+
+               /* completed writeback or incremented failures */
+               ++progress;
 resched:


> My understanding is, we only increment the failure counter if we fail
> to reclaim from a selected memcg that is non-empty and
> writeback-enabled, or if we go a full tree walk without making any
> progress. Is this correct?
>

Yes, that's the expected behavior.
Please let me know if there is more appropriate wording.

Thanks.

