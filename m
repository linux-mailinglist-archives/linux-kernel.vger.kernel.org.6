Return-Path: <linux-kernel+bounces-277548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 899CC94A2C3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9841C22573
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408BA1C9DF3;
	Wed,  7 Aug 2024 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gi8WhD5w"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF0F1C8FD1
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723019267; cv=none; b=NMu2vceZyswfVtvERlE9/t0y1GXYObpRQO2F320Iv/N9Q2TNVkz/WRcdYkA835wVj9EOyIh5iSY5JqEBw8kGlMYFngWPtJI8C1imOjPcFqTgThPsYKCUKGb1Nw9WFXyH1WZCNMkCIWbjfTHb/UW5YuhIAARwC/I3hB5OkWefziM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723019267; c=relaxed/simple;
	bh=VjCKTrVCGp20uaV9/jDf8DJnQm8WVUERSF7FaiYYu+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q1KA6p95h2rj77Ma3S3Hev/oi7O1VE9jxmpxav8gDdZIjMrX0yMQ+aA+XxEpTwkdz1wKEI1I48Lv91Loiq+COc2mc6HytgJU/dGlsrRAKBCoZjB3kzXQpG3AaxdsiuFK6ZPdheCwxdRCrQjud5yFJxZcDCPXQdu3sYaaOL4Nkwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gi8WhD5w; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b7a36f26f3so5653036d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 01:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723019265; x=1723624065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcjlAwWs3hexCvUovNEYGd6p98RErfbaioX/6j6nW3U=;
        b=Gi8WhD5wsTCYEI2qZgUSHj/t0IedxaS2k6iU2cC3vV29WoR1jL3hDGPtYdHSnAzLhr
         fQmAloJ1mRft07Wt6lCOrYR2rfX0VBHOu8rIhJ5uAgB51CF1M7MnPTs8pWZvn8xo48VD
         L3723Rcy7B1k/leeILvwuprKCBBe/5PnsAcXiYLiuTzh1YNPPa6srJf06w5RZ0h+6jMA
         A92P1guUVshPxdEB1TTFiCClvE0Y+5bvjLi28+q+C4GF+hvg9BXeILbalGtsxRYUHA4d
         cFoJTzbPewxlgdo6DULUhW26poToYe44glaXr3YPzFAiQp5ZBVd8HD2iKOrlTTEaXCf9
         m0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723019265; x=1723624065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcjlAwWs3hexCvUovNEYGd6p98RErfbaioX/6j6nW3U=;
        b=pVsbsngvMdyQ4nGzHCvhtRE0JwDG3Mp1vnR7AUb8QX/JiBCgOP7soxbGwmFoYfzi6k
         flnIJ5EhoJxdacXDAkVieex8cVUGeUoxygKZcKO+ZPl0jK/7kCwaATHU80zohFLBOMNe
         JThnOBje60CS86JzOOgeXKGt/EUnxqF3u5kROE1Dx328S4rKLvEd0Q59AMFDwjaLoBoI
         B95+Gd7IHZVJJLJnk6bIbMEd2xO4fgdzvuX2Gt+KIckJ4NncE9TglEM+/vBvrsRgav1q
         AHx41Vh8/LDOQVU3uU4GeZcg+IUJdio45nqkVeBeb3X99d9uSL4LjCG2sEod6QWXXAe/
         VLvA==
X-Forwarded-Encrypted: i=1; AJvYcCXSo6Ck/Gv5imNvfcNr8iZpSDRMH6bUpjLtzDNkHfxjb5Y3DHiuo0pBrozV90kj55RHn2RfESMG9o2j2UVI5pGWkabzIZoyYnlQvL2Q
X-Gm-Message-State: AOJu0Yw63UGVfy+WPM8MuXghkP3Bu3kwR2PVS3zyY/7jNVzauYTtBJ/K
	/6JMzzKqDWoONpkwlwBzQaBMQnZTKQMTBLzPUsPUrc6kdNpCfdm/PjhjrwkzycjiUaOkkmPA4wS
	KvF0FTyN4Znx7ihBWEKWrwmlMT9N3785FsWKg
X-Google-Smtp-Source: AGHT+IEcvMnb4X4O6U4Rpq53D1t/7zNkq31q4hjFOvgZYWlOqyzxxBJWe99x4DZTzrTjPjBVKDTFaDZdCmVqbpyHddY=
X-Received: by 2002:ad4:41c2:0:b0:6b5:e0d3:31b3 with SMTP id
 6a1803df08f44-6bbbbdc7376mr27127586d6.9.1723019264543; Wed, 07 Aug 2024
 01:27:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805124203.2692278-1-elver@google.com>
In-Reply-To: <20240805124203.2692278-1-elver@google.com>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 7 Aug 2024 10:27:03 +0200
Message-ID: <CAG_fn=UBWge=QGeB+XQRtuFkzqWbrA8_FJsrwhihhwkrzt8DoQ@mail.gmail.com>
Subject: Re: [PATCH] kfence: introduce burst mode
To: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, kasan-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 2:43=E2=80=AFPM Marco Elver <elver@google.com> wrote=
:
>
> Introduce burst mode, which can be configured with kfence.burst=3D$count,
> where the burst count denotes the additional successive slab allocations
> to be allocated through KFENCE for each sample interval.
>
> The idea is that this can give developers an additional knob to make
> KFENCE more aggressive when debugging specific issues of systems where
> either rebooting or recompiling the kernel with KASAN is not possible.
>
> Experiment: To assess the effectiveness of the new option, we randomly
> picked a recent out-of-bounds [1] and use-after-free bug [2], each with
> a reproducer provided by syzbot, that initially detected these bugs with
> KASAN. We then tried to reproduce the bugs with KFENCE below.
>
> [1] Fixed by: 7c55b78818cf ("jfs: xattr: fix buffer overflow for invalid =
xattr")
>     https://syzkaller.appspot.com/bug?id=3D9d1b59d4718239da6f6069d3891863=
c25f9f24a2
> [2] Fixed by: f8ad00f3fb2a ("l2tp: fix possible UAF when cleaning up tunn=
els")
>     https://syzkaller.appspot.com/bug?id=3D4f34adc84f4a3b080187c390eeef60=
611fd450e1
>
> The following KFENCE configs were compared. A pool size of 1023 objects
> was used for all configurations.
>
>         Baseline
>                 kfence.sample_interval=3D100
>                 kfence.skip_covered_thresh=3D75
>                 kfence.burst=3D0
>
>         Aggressive
>                 kfence.sample_interval=3D1
>                 kfence.skip_covered_thresh=3D10
>                 kfence.burst=3D0
>
>         AggressiveBurst
>                 kfence.sample_interval=3D1
>                 kfence.skip_covered_thresh=3D10
>                 kfence.burst=3D1000
>
> Each reproducer was run 10 times (after a fresh reboot), with the
> following detection counts for each KFENCE config:
>
>                     | Detection Count out of 10 |
>                     |    OOB [1]  |    UAF [2]  |
>   ------------------+-------------+-------------+
>   Default           |     0/10    |     0/10    |
>   Aggressive        |     0/10    |     0/10    |
>   AggressiveBurst   |     8/10    |     8/10    |
>
> With the Default and even the Aggressive configs the results are
> unsurprising, given KFENCE has not been designed for deterministic bug
> detection of small test cases.
>
> However, when enabling burst mode with relatively large burst count,
> KFENCE can start to detect heap memory-safety bugs even in simpler test
> cases with high probability (in the above cases with ~80% probability).
>
> Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

