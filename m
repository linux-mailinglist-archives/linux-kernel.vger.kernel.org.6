Return-Path: <linux-kernel+bounces-323411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDFC973CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C259EB253E9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A3A1A0710;
	Tue, 10 Sep 2024 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2oscGzwR"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD0419F470
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725984414; cv=none; b=DGau9FnLT2YIDgYiIZpbvr9yngdd5Pb4NEDAY9iHY2O4biDqdIEA3jB64+LrP+vGKeXrxP+30jLhcMPFFO6G4fPFIg8Jors+K7vhmjWpkc2v5/PZRkjnrmbrsozFE3VZUFZDDQYVf+AQfLHCS7uiIjYKNhAWBDqz453EF3V+2j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725984414; c=relaxed/simple;
	bh=9Rp+ZaWePBqTv+7CDLYdQhLyxwC0Y6Goq+cudkph1u8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VYk069Rz67DiXCElnEKMqJzeLOPcyzq2geffUGB4UX13GzYsR/et1TE+haU/qox+ne2ok7yFVBiqzkpaRvCt3Jc+4RMMHa+JCKCiQVG6KYsWU1yVhQIuxnpcpqW9HsvMOdkz4J7VZPQ1ccmv7Bmq0DJgO+b01ftFOmVZCqsbYqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2oscGzwR; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c2460e885dso23450a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725984412; x=1726589212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Rp+ZaWePBqTv+7CDLYdQhLyxwC0Y6Goq+cudkph1u8=;
        b=2oscGzwR4onXmHbtOk7T7sHnwdGHNxaTaPXyKSYKb+/w/iPXbn2//jfK1OoPvhAAWQ
         kbT3m3utsrQfKXjVDv+BE3OXjkp3RVkS1bZlvWP4HLztW/Z7S9YCJfW298ag4QEb0gWA
         jRCcNY0lx9HiRUIktMboyEGdBsyfkLskNjNMs0RQyThW5rzNk9L6oXV5P+BIBB+UbQYo
         cgxsfV4Kr/kvrLzqoCGkYUmxHwYKHjvMOLJjQybOyf0T5LV7MO75rYZIz2PgyjJntZGt
         TtqphhEmEj2bwoSGVgtkKxWn9+8xUA2oz7QqkWjRoSNGMx/ZMNtQZYQ2pPcya4t1ptVm
         eraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725984412; x=1726589212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Rp+ZaWePBqTv+7CDLYdQhLyxwC0Y6Goq+cudkph1u8=;
        b=Pcdm+TcbjJPu71QE46Pm2g6mcg83rbxZHIvPWdL4VhRCfcKYol5GWQSKZdFC7L944A
         T3gzSfs2eSjB4JoUCGPr9Sq3ebhWgLosyCJIfbbAlGT6ti423FylC2DOKyWAJjf50YFX
         doB7P6azWPiQx4IIixSKBsgHMv1zupgyEeKuMxekwf/HSRiqTld77rzPkEoqFEtaE2Dg
         T8DzCYeyh2nPOkMdSPKw9vO47N7Wb1SqTLapvlOiWbIQZFuIVJE2CAw2UZr8wS94jgUw
         ba0tTkXUwhUByLnv5YvqllVRSwCorL1fEVPfi6wPQzi0QNVv8u6tPyrh5cP0o480tAyj
         cWyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUroSrRoMvtcH4e2Lvyu3d5yQgTFWdh/1An2Fppu64BSf7Gxua5+/XRbos8rj2EkekGN/bnYNEkJy69RIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4307cW2QS6q16TFdsxb/pvTrQBB5YLLb0z1l6EQpWUEQEu+Cu
	A6+Y3wXEItRyYudwwey+ThJxNEc6Hpt4QyXsyrOjZoenGSx811r7Tuqd7Y5hRs8Y5x2nuWkR0iz
	D7ZdknPlHH9CeEP6cgvy7g5KaNRYqe4hBfUoz
X-Google-Smtp-Source: AGHT+IHx0FXXNOSwDc/a2GkEEO0nN6J5e6WRL/WX5poMnRTVWbyacane/wtmnLr+FEV9BbUT65Gm5/vLnAoiz2/SvOA=
X-Received: by 2002:a05:6402:1ec4:b0:59f:9f59:9b07 with SMTP id
 4fb4d7f45d1cf-5c4029ef54amr299933a12.4.1725984410772; Tue, 10 Sep 2024
 09:06:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906051205.530219-1-andrii@kernel.org>
In-Reply-To: <20240906051205.530219-1-andrii@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 10 Sep 2024 18:06:12 +0200
Message-ID: <CAG48ez1+Y+ifc3HfG=E5j+g=RwtzH2TiE4mAC2TZxS52idkRZg@mail.gmail.com>
Subject: Re: [PATCH 0/2] uprobes,mm: speculative lockless VMA-to-uprobe lookup
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, mjguzik@gmail.com, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 7:12=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org> =
wrote:
> Implement speculative (lockless) resolution of VMA to inode to uprobe,
> bypassing the need to take mmap_lock for reads, if possible. Patch #1 by =
Suren
> adds mm_struct helpers that help detect whether mm_struct were changed, w=
hich
> is used by uprobe logic to validate that speculative results can be trust=
ed
> after all the lookup logic results in a valid uprobe instance.

Random thought: It would be nice if you could skip the MM stuff
entirely and instead go through the GUP-fast path, but I guess going
from a uprobe-created anon page to the corresponding uprobe is hard...
but maybe if you used the anon_vma pointer as a lookup key to find the
uprobe, it could work? Though then you'd need hooks in the anon_vma
code... maybe not such a great idea.

