Return-Path: <linux-kernel+bounces-432247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 189FA9E4835
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 23:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4CD218803F3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 22:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD211F7090;
	Wed,  4 Dec 2024 22:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X8MGmC1I"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E126918DF6D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 22:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733353049; cv=none; b=q67DaaGpWiWK3z5Oc0IFbkWFfi+0+cXxY4VuTaoalPthr5K+Cz7OVLMusVrW/205yFtF4uP/R510gsopQKALPMidh9CEfYg1gdPQsg1pvZGmc2u/1VySKIe3WoTSl485C/C2QlWnmgYlDL1yRK4BcUe71O5k61FdZz68/31i+MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733353049; c=relaxed/simple;
	bh=CNFEi4qHSUwBi8oIN+T3+XGZ7fuSah6RpAe+XdeR3N0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ciuJ/rYXayyHT8wSj13OdGyWvOExJZTHWFvMhaMOess+c2hiGWBJDDdXOpiikHyfF+SrihM4iYB+3slhKypdz+/n9FF8TGhdlhA8PiF0LJs8vtW6kQmY8fV/sv+5Lgr4TIUY5zkMfjcA5HnkTI1hQxhMJOeB32s9qXunaLjfxaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X8MGmC1I; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d1228d66a0so1549a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 14:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733353046; x=1733957846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOI/TxvWlKuUQC84QT4+Y+q453dEXvhGQN/8IPFfFsI=;
        b=X8MGmC1IGdRWgNLkF98EaPDolSBtwERR2SIenxlV4cH3p3YRnkR1fPPTCcuarjYRR5
         HcyL/okKSDtFV44K3EgEHk1K3RJlgO+Xg9IZWNw8u4wQDczX6SliQcGeI81UgAKNSJ1j
         OFWUFoGg7z13ttXE/f2ifBlnmQcGmbjxMfvCSG35a9RXvBkTAWdGk7WyUTwxHmuaGgQn
         F2OjGgJO3QP1cK4BaYnDM0+IPqXaw7QMLT11mh6E63wKGGF3DZkBA0wXm50nkxlrFNMD
         cNeELuD5R82z1nl2qrUiBYOIiHPrcw9suVImNJsBg4KzC1WwfbCnlR/WwuN6FEYSbvYX
         CjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733353046; x=1733957846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOI/TxvWlKuUQC84QT4+Y+q453dEXvhGQN/8IPFfFsI=;
        b=GyF+25lTI8nSyeuwBOaizBDf9NUMTRIfvKB5eIET4QeERm3jMFd7JqFBlEOu46/Mjx
         Nsxa/hMPjISyKeN8JITZB9qPTOZpuN2pKhetzOKXi/trLl328i+jUi5KalypWEKja/qJ
         qzU/XW1cSnY3lpEhxlnmcnzBdDa8283qN2qbyn4ps8/qp9fV8X8mTXDOVrnXNRLJ5Bku
         PzftcIZR3Q1mu23q6n+wqqpUfqCwBu0gkR+hcAUkdsgUyckSKK+SsMuPZMaen5vnt/bE
         HIc8KKfBCWizIXR4VC0Fys4ZHd4ajgS00BATiEcVWfiA8jmFI4MKQlEdTw3F62pZv7+X
         5zJw==
X-Forwarded-Encrypted: i=1; AJvYcCWMlBrMsTJTcNJbqs01hHS5dabP9nSBxNcv0yIxM/pMoQKcqlxfm0gTVmu1NvXP70EMjz8KRfsW7Vmzkg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzRiro1Q2igxe+bv8+etZa3ERVt7rxd4sp1PKR9CEZ1/BXmn6n
	Im5+PzrbHEq+KrQr0Y9gjff+bKB9pkqfMRXH29PHxNSxDl0UBEEFQfXiXJ74sQw0QLaGK6x7QgW
	OiPTzBcQCF1NLdSZvfVi1q2X4jKGVOa4C7PnU
X-Gm-Gg: ASbGncsdM6paR6DeMkVFckqSfifCq4cqsqf0rfVKQn+A/1nLea8/euqASuol+DS7M0V
	BhmFmwhGgtG3/UBNSl3ZikaXgFeueQYdOkYpC/gnmFkhkps1QNFWb2k9h9Gk=
X-Google-Smtp-Source: AGHT+IGGgJDcG5HIIhYazvjzoqnoW5klz8bIwEyP9Stmu7XsrJaY07wSrq7FpQ1urZ8AW6h/UWzmhegUZAugqIkIBXc=
X-Received: by 2002:aa7:d694:0:b0:5d0:d7ca:7bf4 with SMTP id
 4fb4d7f45d1cf-5d1258ce709mr36752a12.0.1733353045819; Wed, 04 Dec 2024
 14:57:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733305182.git.zhengqi.arch@bytedance.com> <20241204144918.b08dbdd99903d3e18a27eb44@linux-foundation.org>
In-Reply-To: <20241204144918.b08dbdd99903d3e18a27eb44@linux-foundation.org>
From: Jann Horn <jannh@google.com>
Date: Wed, 4 Dec 2024 23:56:49 +0100
Message-ID: <CAG48ez19udcgNARKsizFbbnO6ATFGTSX2KEd2D5aC2Wnxy+Jwg@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] synchronously scan and reclaim empty user PTE pages
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>, david@redhat.com, hughd@google.com, 
	willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org, 
	peterx@redhat.com, mgorman@suse.de, catalin.marinas@arm.com, will@kernel.org, 
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, 
	x86@kernel.org, lorenzo.stoakes@oracle.com, zokeefe@google.com, 
	rientjes@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 11:49=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
> On Wed,  4 Dec 2024 19:09:40 +0800 Qi Zheng <zhengqi.arch@bytedance.com> =
wrote:
> > But this is not enough to free the empty PTE page table pages in paths =
other
> > that munmap and exit_mmap path, because IPI cannot be synchronized with
> > rcu_read_lock() in pte_offset_map{_lock}(). So we should let single tab=
le also
> > be freed by RCU like batch table freeing.
> >
> > As a first step, we supported this feature on x86_64 and selectd the ne=
wly
> > introduced CONFIG_ARCH_SUPPORTS_PT_RECLAIM.
> >
> > For other cases such as madvise(MADV_FREE), consider scanning and freei=
ng empty
> > PTE pages asynchronously in the future.
>
> Handling MADV_FREE sounds fairly straightforward?

AFAIU MADV_FREE usually doesn't immediately clear PTEs (except if they
are swap/hwpoison/... PTEs). So the easy thing to do would be to check
whether the page table has become empty within madvise(), but I think
the most likely case would be that PTEs still remain (and will be
asynchronously zapped later when memory pressure causes reclaim, or
something like that).

So I don't see an easy path to doing it for MADV_FREE.

