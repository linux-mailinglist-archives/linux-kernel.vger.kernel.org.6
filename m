Return-Path: <linux-kernel+bounces-243548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F64C929784
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 12:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365351F2142D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 10:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835111BF40;
	Sun,  7 Jul 2024 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPQfspLb"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D2C1B812;
	Sun,  7 Jul 2024 10:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720349656; cv=none; b=jdyptYbeu3+1BcQRwbjBu+i7y7jOIJ9gkSPr8fv+ddOsHGkS2KK9yx5a3HmrOkms0zXD/l95kfYgnpT7Hpgh/Y0Ygzl8TcCCamkxJcWbEbg60t07io0rA0Fwyc09Zu1UzzhPP3Ks6C9oFQgZgg41Gk2OHeUWyfm68O3Ys+YtsSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720349656; c=relaxed/simple;
	bh=t39Km3pxRc/KCKTq3cwzWNjy1awjvRN13gz+tqlYI40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LFpBjGVRnoKnphd9JjakpcGlSCoEavtDD6nsczk3lJZMFCkjASvhKivmDii0UdFoRKNaERTa1aavmzZ4hGGdFTR1864wonbW+FIFD6xcc7dWhKsy81cpC7RACiov4iW2FweGj0RX7GjJEhn/5jmdpln0A6f/wmd86eZY38klgXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPQfspLb; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e03c6892e31so2649106276.1;
        Sun, 07 Jul 2024 03:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720349654; x=1720954454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4zNRufwwT/TrxbOR4gV2QOmKOXRZvDSyFYKnOgFyDg=;
        b=aPQfspLboxuz63kWlDC5iwtav6hY2YIG7xxUbHvvzPTNAqi7bOMUOMSz5x1Heds2yi
         GoinbEZ/izo4za24tWd9nZ2FLbcDWK4WcQPMFPhYuQWMGZWFYh1fEgzs6LsVI9Nwy5R2
         uY0Zl3it/Y2pRMUzEq3L9N6othftLcYnAeD6biuevdYrUqIdvS1VWKOVbY++xaW0GDq6
         qGInmtLA6a+mG/YHpjNrjMIlDJch2QB4BpDN1JNeqfxqOEuSUYAzokVdiDg+4mprAdXN
         uJ1wPzHJTstcNhHmTDXsQ6TsR1xWXYEXfkevjI18+MTAF7dfRBEPMEY/Y1xbrbroVjgU
         u84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720349654; x=1720954454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4zNRufwwT/TrxbOR4gV2QOmKOXRZvDSyFYKnOgFyDg=;
        b=fPrQIDtSNkWiDlBK8cTT6T5FK4urBS1xpOrJ21gt0lwnCfbjzBdg+mj6jXBzRBVU+U
         K9BP3YRCDXPA9FZJ9Yau2Z48ZAnlyANMyGmXN+iPK/A1FYvNRRTLMyfaqD44i1Yfu+it
         RxsJ6RfSJa7MAkwQK7U6KcFY9Ex+8EgVbpN5wAdUnjFQAIzJrfZ5X8WQxDC97VHOfyzf
         6dhnbfi2mgO5cvffBkXxVHiNtg64J1pPNUPqc/ufGWa1NaSZ/X4UaMStLb31PuitreH1
         lUbsquDDb4B/7dl0GdcLd2jbIvmgvxpXcbaCGQjHt5i5fKw4Y0oHppvRApY03LM9GlQP
         euKw==
X-Forwarded-Encrypted: i=1; AJvYcCUw6QUUxYGwwKsnIbNFsRAIbM/7khNippCc7dFWc6PR0kECJUonDPiS1th8fSLAVWWY47rlTbX7JLGmQ3iTaxO+8XSRhRcFnDa3fIGJqpxZ5HxtCJzB6O2vdwss0BbbKbUVy3QaAgD9
X-Gm-Message-State: AOJu0Yw0q+iL24LTe5CxJWb1Zq9TntHCuP6pxlSKKi6gYIW/eiXgIiqu
	xb82Y/3dS6Dxqi/TN91oLnoT6I3C34o8tsVA0CMndNCUMvPPCURTly//8+LsmRAdU/baslYtUoV
	3u1UVCQIFbVT553Kg5X7E2PcZGSA=
X-Google-Smtp-Source: AGHT+IFl4/Ie9WZbwZiu5JONXDeG5XPuy7cJdl2JxSSiF6oHoSof8Iana9C/jWqQT4Er5PNtdag6U1Cnv71LNo2ZN9o=
X-Received: by 2002:a25:ef52:0:b0:e03:6346:ecf6 with SMTP id
 3f1490d57ef6-e03c1b6a7c7mr8816539276.61.1720349654398; Sun, 07 Jul 2024
 03:54:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706022523.1104080-1-flintglass@gmail.com> <20240706103254.ffd02d7036fa3fe43dbed806@linux-foundation.org>
In-Reply-To: <20240706103254.ffd02d7036fa3fe43dbed806@linux-foundation.org>
From: Takero Funaki <flintglass@gmail.com>
Date: Sun, 7 Jul 2024 19:54:04 +0900
Message-ID: <CAPpoddfn26cKCWC4KERT7Rd=HzJwSEjGPQtpgEaEYONeHSKOzg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm: zswap: global shrinker fix and proactive shrink
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Jonathan Corbet <corbet@lwn.net>, Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B47=E6=9C=887=E6=97=A5(=E6=97=A5) 2:32 Andrew Morton <akpm@linux=
-foundation.org>:
> Seems that patches 1 & 2 might be worthy of backporting into earlier
> kernels?  Could you please provide a description of the
> userspace-visible effects of the bugs so the desirability of such an
> action can be better understood?

Patch 1 and Patch 2 partially resolve the zswap global shrinker that
leads to performance degradation on small systems.  However, the fix
uncovers another issue addressed in patches 3 to 6.  Backporting only
the two patches can be a tradeoff with possible performance
degradation in some cases. I am not sure the possible issue can be
acceptable.

The visible issue is described in the cover letter:

> Visible issue to resolve
> -------------------------------
> The visible issue with the current global shrinker is that pageout/in
> operations from active processes are slow when zswap is near its max
> pool size. This is particularly significant on small memory systems
> where total swap usage exceeds what zswap can store. This results in old
> pages occupying most of the zswap pool space, with recent pages using
> the swap disk directly.
>
> Root cause of the issue
> -------------------------------
> This issue is caused by zswap maintaining the pool size near 100%. Since
> the shrinker fails to shrink the pool to accept_threshold_percent, zswap
> rejects incoming pages more frequently than it should. The rejected
> pages are directly written to disk while zswap protects old pages from
> eviction, leading to slow pageout/in performance for recent pages.

Patches 1 and 2 partially resolve the issue by fixing iteration logic.
With the two patches applied, zswap shrinker starts evicting pages
once the pool limit is hit, as described in the current zswap
documentation. However, this fix might not give performance
improvement since it lacks proactive shrinking required to prepare
spaces before pool limit is hit, implemented in patch 3.

Unfortunately, the fix uncovers another issue described in the bottom
half of the cover letter. Because the shrinker performs writeback
simultaneously with pageout for rejected pages, the shrinker delays
actual memory reclaim unnecessarily. The first issue masked the second
by virtually disabling the global shrinker writeback. I think the
second issue only occurs under severe memory pressure, but may degrade
pageout performance as shown in the benchmark at the bottom of the
cover letter.

