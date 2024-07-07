Return-Path: <linux-kernel+bounces-243532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B030692974C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 11:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34EB21F214B0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 09:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D369712E75;
	Sun,  7 Jul 2024 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0F3YJ6D"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85FE79D2;
	Sun,  7 Jul 2024 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720345116; cv=none; b=cvptAudxNM89jS6dkFBbbn1N/S66koU3/cmJGkByzabyD9uXoaOuyIFb7zsWV/xwCWMNXS/8sIEYjPibXKkxYCE77xDaFr6VzYwU5zlBwqkInAU4HAtJAV6p5q8Hz7Eswa5qTbUbXbpNC6t5rUQcgEriFKQ0i3NynvZMoRHuKp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720345116; c=relaxed/simple;
	bh=G7HpDLA6DyYZ1Q4ShHpQvbNumM3Z3UO1ThxB2wPm7d8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cTKyxlOotTUcxkkZGKTP+xWUybLrCNmyQ+garcwIj3yj++tgmytaqu41E5Wu6+rWLbOyGscFWPaRmvgyYE8TfGjwSQA+FNS2q1aJfB77rAMEmgKFAlEDrhbnY0d+lQyz3jdTuUCkRJMGfJZTvNrnLK8LRDqqp1jkq1kkzsaAts4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0F3YJ6D; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e03c689addcso3128265276.0;
        Sun, 07 Jul 2024 02:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720345113; x=1720949913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7HpDLA6DyYZ1Q4ShHpQvbNumM3Z3UO1ThxB2wPm7d8=;
        b=K0F3YJ6DiO4yaYhrNrVZNX9rEe+wKcNbxHM7cdQzbVtIMJgrfYwfOyy5Cw2KPA3FBk
         BwbN0FFg8aK/Q3YSSPgG3SJQNuVyCpMcmAv9+WDh5m76Gwbi9xeJTNNsByQHp8Mcfu5T
         5WjfxHv/IlTd5nSQWrBqbPnVH4d9sDoNAFGVewFPP8bR+WwVjlH0+f7Vn+SIG4alBe2C
         Wrir0YJc3lLvoy/usQ6nbPklw9+i6DQkV5caVr/gTBulUdHr6iwT6Hg01eSg8xuzn6P1
         QrW2MJVuMRluxTUBqYMokppC8iSbmKVBcdL9YeERPEwXcoxgbbgd4BZm4rRbA1MU4iqo
         iYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720345113; x=1720949913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7HpDLA6DyYZ1Q4ShHpQvbNumM3Z3UO1ThxB2wPm7d8=;
        b=ULIhF/AV4q6sXn0ohNLud3ANquv4BhWPcThq/5/bzcgTUdtTTCLAOTqakF/xvHRKN4
         lwefLr0XbZ+ACmRavJNFCP6/Deg08Ckl7wgi7vWa4ZrEmgzBFztO6DDvfNtOB7UsDN5R
         ZT9636gQMg2efK7Eg/rw1bOijQZ2IAFKUKSMsYXwiMIhi2/q0jm2sSrEMOAK5G2bBGwV
         D0Z2fKES9FemiCZSkLHPnpA9ZX6oJ/m8IE4Ztw86AvkBkUfh/mZPVSr+tAIaz03JaIVD
         vsPdngUABhPWwR8xmX3QvxJmA96kLX8Ppe6CgB8v8gjz/t4rhZSQSDbkWcQ1Hlqh+ubL
         te2w==
X-Forwarded-Encrypted: i=1; AJvYcCUNKVYYS0s0QRVlnIfL4ZoqsDAdZVFCFI6oKvfaSyTtRYpKz2SJXn6VZsK0NCWSyFro8bQ97noi0kvmUSJwExVo5nt46hnQhPYYdiY4ayoOSuryKFhCtVxNUtDAzcBv5BvVjBwIWcJT
X-Gm-Message-State: AOJu0YwX5oS2Hw0s+hBZgK6khJO8WtcTSIcjsAk7Xvbe3S472twmVUr/
	LiA/KOG0pkf7hIQvFZXYZ1ZrU0IKTFWL+ZVziZNwCedf5sepB9SvX71rm0GSrLe+STBk9ZJ2mCE
	vLbp9YWyWg6xDTscMgTVNHiMtx8I=
X-Google-Smtp-Source: AGHT+IG6/KSsiO76+SpCaTPk6O2Fnb+awAIZQTBm7vTHfjoSZbMdCKO96zulmrapkD9/AV5Do8FNNeCXnHacuaCvxMQ=
X-Received: by 2002:a25:b205:0:b0:e03:b0aa:99ad with SMTP id
 3f1490d57ef6-e03c1a6331emr8985117276.52.1720345113646; Sun, 07 Jul 2024
 02:38:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706022523.1104080-1-flintglass@gmail.com>
 <20240706022523.1104080-6-flintglass@gmail.com> <CAKEwX=MmwqevpoGnskXrsYQWKOR8yx4t0moasVO=risu0P7-uA@mail.gmail.com>
In-Reply-To: <CAKEwX=MmwqevpoGnskXrsYQWKOR8yx4t0moasVO=risu0P7-uA@mail.gmail.com>
From: Takero Funaki <flintglass@gmail.com>
Date: Sun, 7 Jul 2024 18:38:23 +0900
Message-ID: <CAPpoddenrRxWkSHTrrWEN9=uYGiQtvLDCifhAPyy2jkcdwfE-A@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] mm: zswap: store incompressible page as-is
To: Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B47=E6=9C=887=E6=97=A5(=E6=97=A5) 8:53 Nhat Pham <nphamcs@gmail.=
com>:
>
> I tried to propose something similar in the past. Please read the
> following discussion:
>
> https://lore.kernel.org/all/CAJD7tka6XRyzYndRNEFZmi0Zj4DD2KnVzt=3DvMGhfF4=
iN2B4VKw@mail.gmail.com/
>
> But, the TLDR is Yosry was (rightly) concerned that with this
> approach, memory reclaiming could end up increasing memory usage
> rather than reducing (since we do not free up the page that fail to
> zswap-out, and we need extra memory for the zswap metadata of that
> page).
>
> So my vote on this patch would be NACK, until we get around this issue
> somehow :)

It seems the discussion on the thread mixed up memory allocation
failure (system runs out of memory reserve) and incompressible pages
(compression algorithm successfully compressed but the result is equal
to or larger than PAGE_SIZE).

zswap has been storing pages into dedicated pages 1:1 when compressed
to near PAGE_SIZE. Using zsmalloc, current zswap stores pages
compressed to between 3633 bytes (=3Dhugeclass+1) to 4095 bytes
(=3DPAGE_SIZE-1) into 1 page. This patch changes the range to 3633 to
4096 by treating PAGE_SIZE as a special case. I could not find a
reason to reject only PAGE_SIZE while accepting PAGE_SIZE-1.

zswap wastes memory for metadata for all accepted pages but reduces IO
amount and latency by compressed buffer memory. For pages between 3633
to 4096 bytes, zswap reduces the latency only. This is still
beneficial because the rare incompressible pages trigger urgent
pageout IO and incur a head-of-line blocking on the subsequent pages.
It also keeps LRU priority for pagein latency.

In the worst case or with a malicious dataset, zswap will waste a
significant amount of memory, but this patch does not affect nor
resolve the scenario. For example, if a user allocates pages
compressed to 3633 bytes, current zswap using zsmalloc cannot gain
memory as the compression ratio, including zsmalloc overhead, becomes
1:1. This also applies to zbud. The compression ratio will be 1:1 as
zbud cannot find buddies smaller than 463 bytes. zswap will be less
efficient but still work in this situation since the max pool percent
and background writeback ensure the pool size does not overwhelm
usable memory.

I suppose the current zswap has accepted the possible waste of memory,
at least since the current zswap_compress() logic was implemented. If
zswap had to ensure the compression ratio is better than 1:1, and only
prefers reducing IO amount (not latency), there would have been a
compression ratio threshold to reject pages not compressible to under
2048 bytes. I think accepting nearly incompressible pages is
beneficial and changing the range to 4096 does not negatively affect
the current behavior.

