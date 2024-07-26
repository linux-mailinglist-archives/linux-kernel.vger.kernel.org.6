Return-Path: <linux-kernel+bounces-263593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D9793D811
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF4F1F240D5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373FB17C9E2;
	Fri, 26 Jul 2024 18:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIgwmSnu"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257673987B;
	Fri, 26 Jul 2024 18:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722017616; cv=none; b=jeUhU38xfTttKJjojpUUs1uCOA0uVs5mhC2XuMv4lQ6Jjh5Gd05+FG4pUK57QvapUxv8lypwkZra+K2YT58B4f5BYgItTrQjypBWi4QfEbhim1WAGrKq6lRsxJ2v6QewQIDSfYWQdNaRLBCKVcfj0j2azdntU1OQYJRDGnQTfx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722017616; c=relaxed/simple;
	bh=8yl+brwVcmXERPrivxbwrAeUpUiEtoSaIUh7zOM8yeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OfveIrhQ5723qlennahzdz5MKk2pwB26voYWseKk3r+kZf96YO0H4iiS7XQAXnDxEO0GF98FfvYn09xxWBG7Z+/mro6Vq90dix77TKiuQdxjeb0ixZ91+DcSRbkpikKeD1OaHZDLPESss1fu7iwGX/Cb9JeJk3m6vG2EVYnBkpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIgwmSnu; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6b7a3b75133so7001106d6.2;
        Fri, 26 Jul 2024 11:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722017614; x=1722622414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yl+brwVcmXERPrivxbwrAeUpUiEtoSaIUh7zOM8yeA=;
        b=MIgwmSnuhsNc7BfUdikpe0YD5Do/+TeYB+1P65nRKW9gNGHtzjgKrfs6evTDnZSUf+
         21ivUQn1cnsgQhWRTF1ETQAFuvqy9vsjjIjkKoeQGD3w+B6bpP5nhAo5FMX30JvsA4g2
         dkrGY1iPExpbvvxLUVEbuAyU5OltFwd3He4rlkix98M7Ebs1If4gB43dP5I4oT1kLPOz
         5fRwkPXZ2iW2NechdhCnLbXqRiqw5rzwOm9vQzOaRuhdGPJAeFkbLESahJFRzp6zKaf+
         NuoQ/ty1lkyOm6fRVvRTKcFubLF5DBm3yxr9ORpHcZPbRHkMDt17j9cUM3dLmX+7CzEb
         GIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722017614; x=1722622414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yl+brwVcmXERPrivxbwrAeUpUiEtoSaIUh7zOM8yeA=;
        b=SRQHMHL+Mkb5ttB0QTRC4UswMfxoWFxVJtll2Lirg76rYyIM/s3E2NRcTlRNkNuVAk
         mudJQ7V5pJ48zYGa4aOrMUnVaharUhQmFYK2DzIssfilAIyKJrnltZsMf2/Kg2PUM6bu
         2mLqNePefi3DjmKXOuf7PWIXrkbnIgmke1kQG3aNOYVqtx5SuK6E09hjRP6owfEFUAjT
         lxl4r5b60xahAAkafBxJtCHFiSrQsmGuj0zna3cVJiw7YsqaRrczvLtPMqWPR0nTF0Kt
         jkCpASrqQBYGJBj3saTAIrXb26I4jUxvXfHUkK7OXqsFAOycJogx9iNryqy/mf1yzDi7
         7SpA==
X-Forwarded-Encrypted: i=1; AJvYcCWqT3/E6EzWukdhEc6LxQqZufxEbHRnqCi4RC5uAMGge4BTRfQIi59uDvtQCK7/cBkudzukgYBZB/GyC5+C1mOj9ZxJmhYrteQQjBOsxHDB4yqZ1up5gex/kK0iNta7Kob2fUQ6RiTx
X-Gm-Message-State: AOJu0YwWobD+doSFVQo4LtZOHY2qWQmBHQyhu8obfcRYz1xbi6dC3YY5
	OeCBLhVfdq+Soo6NVsMmg1teEnVdVRNiGaFE7HObO75WDuYv9BEY+WDzSnFG/ickZpTxvotAqON
	beFQvbABe6ZvZUG+LGhDwU4CCee6mKtuFWXg=
X-Google-Smtp-Source: AGHT+IH9k1ccca51XmPFByCp0c4IKFLOi0edvS+N8+/KUOVzMdJ0gAgPleHDU17zFghi+hDIwlh9UKl9KNkpnOFZhuQ=
X-Received: by 2002:a05:6214:4105:b0:6b5:4573:4ac5 with SMTP id
 6a1803df08f44-6bb55a82e7cmr6503326d6.45.1722017613881; Fri, 26 Jul 2024
 11:13:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706022523.1104080-1-flintglass@gmail.com>
 <CAKEwX=NL1gOe9k5+JB8Q-UAoZ4ie8SBGg7XTjaqM7j4-hiHv=A@mail.gmail.com>
 <CAPpoddefXD1RAjyW2+X_ankGYNpQgY0Y0+xd1yOFgCc_egaX8A@mail.gmail.com>
 <CAKEwX=MFdjryQRDm9b-Oxquhw954HUipCCpABSLwH9mrV4D3WA@mail.gmail.com> <CAPpoddfNfrGjhHzQ4KURv2y_z-iyY8cTzG+7d2ooQFU5NcU80w@mail.gmail.com>
In-Reply-To: <CAPpoddfNfrGjhHzQ4KURv2y_z-iyY8cTzG+7d2ooQFU5NcU80w@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 26 Jul 2024 11:13:21 -0700
Message-ID: <CAKEwX=PhhAiZ_P6YmdsJrtrftuHwzjbR7Hn6n-3aaYD4mVdPYQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm: zswap: global shrinker fix and proactive shrink
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 1:20=E2=80=AFAM Takero Funaki <flintglass@gmail.com=
> wrote:
>
> 2024=E5=B9=B47=E6=9C=8813=E6=97=A5(=E5=9C=9F) 8:02 Nhat Pham <nphamcs@gma=
il.com>:
>
> It was tested on an Azure VM with SSD-backed storage. The total IOPS
> was capped at 4K IOPS by the VM host. The max throughput of the global
> shrinker was around 16 MB/s. Proactive shrinking cannot prevent
> pool_limit_hit since memory allocation can be on the order of GB/s.
> (The benchmark script allocates 2 GB sequentially, which was
> compressed to 1.3 GB, while the zswap pool was limited to 200 MB.)

Hmmm I noticed that in a lot of other swap read/write paths (in
__read_swap_cache_async(), or in shrink_lruvec()), we are doing block
device plugging (blk_{start|finish}_plug()). The global shrinker path,
however, is currently not doing this - it's triggered in a workqueue,
separate from all these reclaim paths.

I wonder if there are any values to doing the same for zswap global
shrinker. We do acquire a mutex (which can sleep) for every page,
which can unplug, but IIUC we only sleep when the mutex is currently
held by another task, and the mutex is per-CPU. The compression
algorithm is usually non-sleeping as well (for e.g, zstd). So maybe
there could be improvement in throughput here?

(Btw - friendly reminder that everyone should use zsmalloc as the default :=
))

Anyway, I haven't really played with this, and I don't have the right
setup that mimics your use case. If you do decide to give this a shot,
let me know :)

