Return-Path: <linux-kernel+bounces-316435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E688496CF8F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D93C1F25DE5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 06:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB63918BC10;
	Thu,  5 Sep 2024 06:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pRtc64di"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A0E14A4F5
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 06:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725518570; cv=none; b=KOgQ2jIuiwmxk4Pu6Cblor9fBGCn5WO+wRvKd4O1LfmCtYHKMKbFojUh94O8pC+kJuLGuu6DicugKNDdVr2c0RyEIYQGSHhmjuC3UyRqrz5uWpvd4UbOzoMxeZXrRJZ0dew6iy6vnCsmm3raZmH/qvCvQWHm7PFIR97WMY/pBDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725518570; c=relaxed/simple;
	bh=9V4VCmPg6eMZasmKiWPriv+IwgAInkpodNw0GExUhCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qRxN9mmGs9HOqj16uBha6iY0qPTdG5YAV/C6NZq9fvxSFXwW4W9EWXDumDEKwmWW3JNHJlPyRvNiA3I1c1ek5MUnHe6YVOZlrKYjzHWh3s/3dkeopaMV7ZsD4ySEJf19AUDdb0KaQBXuoxKhg6fU+aiKQHKeWZtQbHkz5hw8w0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pRtc64di; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-49bc13c3a47so174566137.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 23:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725518567; x=1726123367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9V4VCmPg6eMZasmKiWPriv+IwgAInkpodNw0GExUhCM=;
        b=pRtc64diVppzAhcbrhOM7N65Eumwn2hiB/eMkTeapMK5VhLXf/CE/Fu30RmK4PRw+T
         3nYOQJyuh05xDzfDLynSsWHHXhcExQNv7+wCBVPlIYBy9fg9O4OLj1z62zVwy0AhJN9u
         9I+X/X1MTiQ2q/qV2VO/XQbUaNQk9YbFs8KB6fvKLNVQx5ASldJpEuxHonCc7PFN8voq
         7WymFrQ9BWh/SxGV78YbwPQDTYHLJYtjS3BUqw5HeWD1IZ5C7M6PZeiyTXsllVUTs6Uv
         AVyRcuOcX5XOfSYbUyyFQRaMFvY9kOWrLYQZ6TMCllCKKeWqo+kVFDXJicEmctrgw/G7
         apfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725518567; x=1726123367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9V4VCmPg6eMZasmKiWPriv+IwgAInkpodNw0GExUhCM=;
        b=C5fBtk3vS+6oOjF6PT0fQaW/L6rVCM93lNcDw9//+0Ka6YkY8Nl7ZyZzmq9q4E+fdr
         3To/U2WG78LamWRpb+whbwYfgaXUjZwXIsL5jwhv6A0CQhEMFWfYwdlVyhO/lJXPJfou
         w7h7Dq5TaYgoBtGrB+Gsm28yYqU53XzTHmsmNvnl4snqBqoeQ7agRTgELje6HtkPxwAx
         qeUup/twASMVIn5YIJqWkZB+iFDyHV93uiDeEcWVBspRCoNTlWLyWl/Hs1AXUzY9kfnn
         lRe9tP1gz3+zIVLWxOwW5agtTf7SOIJsa13B1kC5NzPRPZV7mdS09aMh7WkZ4xDI/eOI
         tVxA==
X-Forwarded-Encrypted: i=1; AJvYcCVratAtoEd3X+tUNuOCxwm2i7eNx4quQt4cCUN8qm6Mta3FkCx9/5n3jZIVVO2FmYUEuTKIg+QFrmP/3Hs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ZDXeOzUtD4jsy6qG8/r2IvxI3qOSbFXBQd7xZ0xJRSJLzwm0
	85PKNzodhMkUdAUOhoiHTp2Y7AP6uQ4gM/5nkF949Lomctcu2N9h4zDt0CZEWacZfV4ClbfD6+d
	uOylOuQKutBBZK+OBviLRLPglFbKbm0Zy6OIP
X-Google-Smtp-Source: AGHT+IEh5tjCAD20+/NXlcvkgFmY9ljkBmWFLbXVoYAhxosbLoYnJ60puOzPhErf+40yYr0ygC1DD+2ouGTExQGvGfs=
X-Received: by 2002:a05:6102:3706:b0:48f:3f9a:7609 with SMTP id
 ada2fe7eead31-49ba89b5318mr11158020137.5.1725518567275; Wed, 04 Sep 2024
 23:42:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904-lru-flag-v1-1-36638d6a524c@kernel.org>
In-Reply-To: <20240904-lru-flag-v1-1-36638d6a524c@kernel.org>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 5 Sep 2024 00:42:08 -0600
Message-ID: <CAOUHufadyZBOifC8-ompzy4idEO9g-zipsSBrkWaoc=sWrk+Uw@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan.c: fix OOM on swap stress test
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, yangge <yangge1116@126.com>, 
	David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, baolin.wang@linux.alibaba.com, 
	Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 12:21=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> I found a regression on mm-unstable during my swap stress test,
> using tmpfs to compile linux. The test OOM very soon after
> the make spawns many cc processes.
>
> It bisects down to this change: 33dfe9204f29b415bbc0abb1a50642d1ba94f5e9
> (mm/gup: clear the LRU flag of a page before adding to LRU batch)
>
> Yu Zhao propose the fix: "I think this is one of the potential side
> effects -- Huge mentioned earlier about isolate_lru_folios():"
>
> I test that with it the swap stress test no longer OOM.
>
> Link: https://lore.kernel.org/r/CAOUHufYi9h0kz5uW3LHHS3ZrVwEq-kKp8S6N-MZU=
mErNAXoXmw@mail.gmail.com/
> Fixes: 33dfe9204f29 ("mm/gup: clear the LRU flag of a page before adding =
to LRU batch")
> Suggested-by: Yu Zhao <yuzhao@google.com>
> Suggested-by: Hugh Dickins <hughd@google.com>
> Tested-by: Chris Li <chrisl@kernel.org>
> Signed-off-by: Chris Li <chrisl@kernel.org>

Closes: https://lore.kernel.org/56651be8-1466-475f-b1c5-4087995cc5ae@leemhu=
is.info/

