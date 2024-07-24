Return-Path: <linux-kernel+bounces-261585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6153D93B96D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 01:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BACCD2845C7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 23:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D5913C90A;
	Wed, 24 Jul 2024 23:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qsKR/u7B"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0208F4A39
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 23:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721863115; cv=none; b=qM/BW4KdHLNb5vS6nz6y/6eQHsaQaUL0hnfXl5q/GVsHtrLL8+/MDuawM5soeWrXmrzVqPWsNDj0/rweqLDQa+1NNed36KYfGfSzWWsLk3ydl7NPJsoZ6Ow/1EBljZjIs1ogcxWGVasemH3CotfR8Be2wBZjgv3uz4ZLEpoyFx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721863115; c=relaxed/simple;
	bh=YzwsQtWG7e7lIV4f+rJC/NED6lYg6yqlnek4/q0DfWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i29tPuMKHfMizye5h+dzt4Nk3YOK3zMyfNKDCrjAxNZs+qOZHJhQqvB/eZryGnXoUifchVjh1nCruedM4nMWzkERHckBZpOPrJnxqmFUP2TIq6669Ch6d4REkAggW7Eb2+TX1djRaAaN3z63yGlnArX7sx4keBQsU0SK+uFeVzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qsKR/u7B; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52f04c29588so346502e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 16:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721863112; x=1722467912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBy09clzXrnMnEqnYTigIgIPxOJXnj7DMJjTwwAfQDI=;
        b=qsKR/u7B/xwFAUWFRvCrtORtG6bJBuN4hA1X4xntsODyy0OkRY83tiowgsTMjaxW1Y
         Wib6h7K6umPThIbufyGZfLqwGLAe7X5V0MoCppB5kbN37fwhbYvXCEQQV+nIZ2Yavt0/
         vQBhJXOlg1WGffFWUtwEYhHn5/IXdDkw3HRwFSuHfGdLYqmeDW3FL81Dv51I4Ep2LPKy
         98xrfebdHcmTpNpND6PfK3fzVla+BS1IINRnFRv/xf7U+HPMPt2KD1XCp7XhssmHdT+j
         tiKn+pBjVhVbyuGXA+Sp2UOFIJmsl4jjxhUdGfXtCbwMaOqP9XnNn/NCutcV4D0vfo0M
         wy+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721863112; x=1722467912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBy09clzXrnMnEqnYTigIgIPxOJXnj7DMJjTwwAfQDI=;
        b=pSlagnfGOktHi3Rc22MPV+rJU8XFDyvQjM9rwxwC9WFlCWOCmLcdWGJEPARUSYv23e
         DMZmYcPamcRmGYFNUx0tPQ6lZsVnRzjgaZfbULuEd+Iu4ByROES5341PMD2YacAiRAiU
         UcAB+Eabe01TnRCc2GVF4coLh9VkmuN0d4opIjtCR2DqcGBGWh1912vUuXEI82bTaSEl
         Cfpsx9mN+39cBvHW9/eCvKP6+qMzoZJo5xxkcJwJ3h98m337+2GArFBFLktq7VVTHiF0
         P0+ukm9WqEp5aLnJ2Jij0yTRi9iegi9uLkn8WoyBU5FYVkCcBRyEvkghWdsUSbOpO7zj
         WrkA==
X-Forwarded-Encrypted: i=1; AJvYcCUTHfrTrib8P6G1Fo5krDuo3I2H1FipED8XRk6MNNy6C/SG1wwVgr4atN/1g5EIUV8C6JfQ5pcQsTh9/zRatxld7KhffXEYRrjx+zXZ
X-Gm-Message-State: AOJu0YwfGgD5xGMjxZvOwFj6jsBcoslzCmzSIvzv5l+YerbLm/p2hxUo
	Yf8Ucbg1wmhhHgnWl4YJwZanyXvbxIupOGHz2qZGf5/4xjz+ufBrcb90rLCQMQYfKPYeTQJWDDp
	+KYzQwhYPgcf12wQ39qLadiq3c/JVeDI8gCfA
X-Google-Smtp-Source: AGHT+IHOVvXE8GCCKwfqIw3pf9FYZqj0uIOOwWCkIpAiAgGZ3JbXKYEqqHyFvApNH35L0C6WCWjkREO0ZQHFcipJE1U=
X-Received: by 2002:a05:6512:3191:b0:52e:a008:8f55 with SMTP id
 2adb3069b0e04-52fd6080137mr87591e87.41.1721863111566; Wed, 24 Jul 2024
 16:18:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724203322.2765486-1-pasha.tatashin@soleen.com> <20240724203322.2765486-2-pasha.tatashin@soleen.com>
In-Reply-To: <20240724203322.2765486-2-pasha.tatashin@soleen.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 24 Jul 2024 16:17:55 -0700
Message-ID: <CAJD7tkY+atjCn=3o4tCKt-PsRveMbv5mzM+QppqM6jBGHUnwqg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] memcg: increase the valid index range for memcg stats
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, jpoimboe@kernel.org, kent.overstreet@linux.dev, 
	peterz@infradead.org, nphamcs@gmail.com, cerasuolodomenico@gmail.com, 
	surenb@google.com, lizhijian@fujitsu.com, willy@infradead.org, 
	shakeel.butt@linux.dev, vbabka@suse.cz, ziy@nvidia.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 1:33=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> From: Shakeel Butt <shakeel.butt@linux.dev>
>
> At the moment the valid index for the indirection tables for memcg stats
> and events is < S8_MAX. These indirection tables are used in performance
> critical codepaths. With the latest addition to the vm_events, the
> NR_VM_EVENT_ITEMS has gone over S8_MAX. One way to resolve is to
> increase the entry size of the indirection table from int8_t to int16_t
> but this will increase the potential number of cachelines needed to
> access the indirection table.
>
> This patch took a different approach and make the valid index < U8_MAX.
> In this way the size of the indirection tables will remain same and we
> only need to invalid index check from less than 0 to equal to U8_MAX.
> In this approach we have also removed a subtraction from the performance
> critical codepaths.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Co-developed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  mm/memcontrol.c | 50 +++++++++++++++++++++++++++----------------------
>  1 file changed, 28 insertions(+), 22 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 960371788687..2fdeece7f1f8 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -320,24 +320,27 @@ static const unsigned int memcg_stat_items[] =3D {
>  #define NR_MEMCG_NODE_STAT_ITEMS ARRAY_SIZE(memcg_node_stat_items)
>  #define MEMCG_VMSTAT_SIZE (NR_MEMCG_NODE_STAT_ITEMS + \
>                            ARRAY_SIZE(memcg_stat_items))
> -static int8_t mem_cgroup_stats_index[MEMCG_NR_STAT] __read_mostly;
> +#define IS_INVALID(index) ((index) =3D=3D U8_MAX)

The use of this macro extends well into this file, should we use a
more specific name (e.g. IS_VALID_STATS_IDX())?

