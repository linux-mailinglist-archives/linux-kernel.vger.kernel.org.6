Return-Path: <linux-kernel+bounces-310392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE707967C24
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 22:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C289281BEA
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 20:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F83B1304B0;
	Sun,  1 Sep 2024 20:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADD3Kqvf"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFC858222
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725223185; cv=none; b=PW1p026mfDuOUyXVEowdsHBMCf5+JARflcGE2y9gl1SshQbd6C3H9UDOMG2RIRVODlSxQ0pAB+BQHh4Tl/tuWUJAe4atL7X4XMdzxDDdvMyU8OmUsBKwQt0zUg0EFgWJkufc+uBuTdK+pJB9YT8kzcNO0mfBJgDiNxCiaqa1XGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725223185; c=relaxed/simple;
	bh=Xl2okuGkZ0a70nJFoBBhxciMppCcQYMVoqQHN9oiXJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=miPWn07UFzYMBBXAb23OjIXzfbPp37XqHJCTM4EI0LUCjd7q2YOlFffsysafmlGXr2dsn1AZWCfGBhSf85X3XimGSydFVo34eFjoMtHxICuflaQi0EMVrpjNBKUXX2b1HEL6ooeRlxDqMMVTYoFn5jqx9a2KjFFPf/dNVjNx0Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADD3Kqvf; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f3f163e379so56501921fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 13:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725223182; x=1725827982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDffpG2ThY4k2VDFqzoKC8KM31EEPwqyGBslWHRe5RE=;
        b=ADD3KqvfZLk/z6vPA+BaDiY+oX7PUWbejVRaY4VoetnTvjaBpmDRaYmMwoEqNvLHmq
         zaUBhqxePdeODk3Gm91gIklMJradM+fli734BVRYzFonywwAKMQnsOGfq3EZEq8kyuJG
         iH2I3fo5vB94I+woBTiUILjugCbgZBxr1o9FJiWnOvYb/+3YOta7lzrHEQ9kFJh5/Mj0
         E3gjKZPGAmPVCfHUaVKjB85Rp0XtCmUAnjtqpVHFkhothWNS+JA1FzjwVWPtP+jiZEo6
         vDtS7xKgpsPhUMdsojuidwDAFH6G5lXq8RLVddlF87OBBMzhiP0UvUrtz9fyNlStvWCj
         ZG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725223182; x=1725827982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDffpG2ThY4k2VDFqzoKC8KM31EEPwqyGBslWHRe5RE=;
        b=w0OgJckYqcwQ4X+Iffzuib4NNnUV4w6sZ2ur1qBSvHP4rG3+HccAvWj3fEULFNfyG3
         JuXOOs1pigy7LPLKZf/iIxSpHETdRN1BaEZMPEZZQ8GAt3upeHL48cMlh1vN9/ohSyyP
         /OMEtemP9TSZcJeyASf8pX5SSHd0fnjkmfl5Yjlt3YaYIk2kpTh1C+r11Xi8msmYogpm
         1aiyuaYBYNTGZikkIYSf+hymiM+ALAgP2O4qMpVdQ9pJcdZgDKcrx03IJif7Iq27PHe1
         6QqBNLRB/opyNLBtKIyUjVmA8AA1ZW9+neMPCnpaQggoU84KA6Hu+RO+vumpa3pV9dZW
         K+Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWozwD1Am8X+jLH8TSD2/FZfAYDMloXrB63Dw3ZYI9iZjXH7UV2euQhXKUh0bPNLkkd1i2lftpaWKj21x4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq4FCUUYQ0z9a2/mTQDoJV5W3KeKfwweEQVOjWMMv2horirkrS
	jw062DncTL0P79bwYaccbO/UQik+bII/EMeg8ndKAeEv95u+PquAHB/RH97A4WmH1uEt26/jzBj
	hBQ7oVIVawKZH+F823L9G7MvJBn8=
X-Google-Smtp-Source: AGHT+IEXsrwqoHt2e/ocmAyYQhcGL4ufKNrpXXSo9TpQGlipO+Q4+m2Y5RZRyOqQEU+ML86TDaIl2ayhuo77wQl61EE=
X-Received: by 2002:a05:651c:b20:b0:2ec:4093:ec7 with SMTP id
 38308e7fff4ca-2f6108937e3mr103433981fa.30.1725223181373; Sun, 01 Sep 2024
 13:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829102543.189453-1-jingxiangzeng.cas@gmail.com> <20240830173813.c53769f62bf72116266f42ca@linux-foundation.org>
In-Reply-To: <20240830173813.c53769f62bf72116266f42ca@linux-foundation.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 2 Sep 2024 04:39:24 +0800
Message-ID: <CAMgjq7AnaNr354zzu-Z-SB6xZtD1+a2zUwFtZ_Qg7pMj0m7y7A@mail.gmail.com>
Subject: Re: [PATCH] mm/vmscan: wake up flushers conditionally to avoid cgroup OOM
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jingxiang Zeng <linuszeng@tencent.com>, Jingxiang Zeng <jingxiangzeng.cas@gmail.com>, 
	linux-mm@kvack.org, Yu Zhao <yuzhao@google.com>, Wei Xu <weixugc@google.com>, 
	"T . J . Mercier" <tjmercier@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 8:38=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 29 Aug 2024 18:25:43 +0800 Jingxiang Zeng <jingxiangzeng.cas@gmai=
l.com> wrote:
>
> > From: Zeng Jingxiang <linuszeng@tencent.com>
> >
> > Commit 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle")
> > removed the opportunity to wake up flushers during the MGLRU page
> > reclamation process can lead to an increased likelihood of triggering
> > OOM when encountering many dirty pages during reclamation on MGLRU.
> >
> > This leads to premature OOM if there are too many dirty pages in cgroup=
:
> > Killed
> >
> > ...
> >
> > The flusher wake up was removed to decrease SSD wearing, but if we are
> > seeing all dirty folios at the tail of an LRU, not waking up the flushe=
r
> > could lead to thrashing easily. So wake it up when a mem cgroups is
> > about to OOM due to dirty caches.
>
> Thanks, I'll queue this for testing and review.  Could people please
> consider whether we should backport this into -stable kernels.
>

Hi Andrew, Thanks for picking this up.

> > MGLRU still suffers OOM issue on latest mm tree, so the test is done
> > with another fix merged [1].
> >
> > Link: https://lore.kernel.org/linux-mm/CAOUHufYi9h0kz5uW3LHHS3ZrVwEq-kK=
p8S6N-MZUmErNAXoXmw@mail.gmail.com/ [1]
>
> This one is already queued for -stable.

I didn't see this in -unstable or -stable though, is there any other
repo or branch I missed? Jingxiang is referring to this fix from Yu:

diff --git a/mm/vmscan.c b/mm/vmscan.c
index cfa839284b92..778bf5b7ef97 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4320,7 +4320,7 @@ static bool sort_folio(struct lruvec *lruvec,
struct folio *folio, struct scan_c
        }

        /* ineligible */
-       if (zone > sc->reclaim_idx || skip_cma(folio, sc)) {
+       if (!folio_test_lru(folio) || zone > sc->reclaim_idx ||
skip_cma(folio, sc)) {
                gen =3D folio_inc_gen(lruvec, folio, false);
                list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone=
]);
                return true;

