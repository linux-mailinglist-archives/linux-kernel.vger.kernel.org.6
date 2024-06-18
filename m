Return-Path: <linux-kernel+bounces-220285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B3890DF0A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 00:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EDF71F236B2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CB017B428;
	Tue, 18 Jun 2024 22:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="bA1/tGjb"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDFD55E58
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 22:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718749035; cv=none; b=jA/lPpKY02N+Q5Hbh8eUR3UVoXYW6y4ok1ygPhZaHB8W4Xi3Ud3fRoNU5m5cIXeiD9x0ypah4xyGExTRPBX1x5QlXb4vcPFNENsHZFI6gC/hA8f2Nba7xSjtfMm8SA8Y1wEIbbaH/qJ8i7OQXkZyA2s/TfXqMsVpq3hUaonhr3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718749035; c=relaxed/simple;
	bh=JC7janUdTkIxMRlZ2yUyHscdIR3OVRO7ZObAu4A9T78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WyIosLB3T+HleVM+UQP2+cOMVZLzjNZAFUVBR1J+voUQjVQiu5WBLUHh//uApeu7+1t4Uy9oTMnlvOe8qz+7/yvusBf/RHkbG5TYIRJnE8UaiEE2M1mxrJ14iXd27RfBq6xmXjrSKK53iPma6gMUIyL09hqfUibppcl4YtDgFVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=bA1/tGjb; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6fe0e23d8a6so534366a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1718749029; x=1719353829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnC1LBQnjtEKO+X1jyWNJR9MMF6f5OsiOUP4k8JZc+E=;
        b=bA1/tGjbdrpXyN5Ho0qMs9H3JnlL4oCP7NN2xwHycihd1PePvuSkXdE4PcxykYCDg6
         0bLhC727Wj+CjwAnihbxiGN6oUx3W7CG+NH9vajpPXb7Pk6Kg7/XMCNPDEMhsE+Ei12D
         CeAr0oiNC1E1buxz9YF+OznvO4vtLSZykW9ajWLjemjsuuXC/63BdZaEpa/k7yOBY2L0
         SyCYc+4V9sOP4sngFiLQI83yhmHhqmwYZDjX9hIyT1W2RutjcOr8JvjgWFK8xeWXVQgI
         sUjarZfl4NzZsGReB3ohaQT94i/2oHwN61J9+QmZZGhmncErelRbV5WTJYa7NMS2qKck
         ozAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718749029; x=1719353829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LnC1LBQnjtEKO+X1jyWNJR9MMF6f5OsiOUP4k8JZc+E=;
        b=C4GbRN+YxUCxl41nb+TUCFkrLObABI8eRvhbzfM+sK/FFm3qTQYxAjgwJT16taX1Ij
         chdyOm/2cziT/zG88XuQRVi3LVExNJPpvLnNrAP7AFb4eDAaY75XEtbLL6k6f5K9phRm
         QwkzkN9KgLqYlqm258VrXSAVXp6harXUaZMnz4AJcOwtWGi1NzJJvFZl40S0W+IeGfro
         ukh5vue+2J/hhMEMYgFy9O0KOECBjBR1Vuy7F27aeIf+1I+jROUmc+/MP/XelYr0OpK6
         cW+mHl7pYafoYrsEwZPlx3XhFJ2v/uF9G+Qc3yM+okoVH3tFS4PUc/1JynpZ1HksPnJK
         XLQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAcu1WuHge2pmjLrHJIwBs9KIh/2rDLfknVP/iDekH/B4dWLLFuJI98PfMBaK0XhMQuyoQxzVxJNU9K72vn4KvaBlG8Qp/r13xPncJ
X-Gm-Message-State: AOJu0Yx4QuaCXdvnjZqBps3TXn4NFAKMvuDPEU4bIUwNS5IPUcwOiH9c
	kzmYAtUe6ZmPG76+GV3SJobTJw8n6DZKTd23oArwkupER4W5D5laD1uy6o6gCfiLUtNHRTUVw+W
	sZETtAVnBCoyw87aL/58q2GfPdwC0GtWixC2B
X-Google-Smtp-Source: AGHT+IEXKq/xECPLoVdaKRzGmnRVLc8vS2zPQcYKvrbgroA29vHQSq/4IWdtC4KntTt0ibP6NnNAW9EX6e44UbzWnEM=
X-Received: by 2002:a17:902:ce84:b0:1f7:2a95:f2de with SMTP id
 d9443c01a7336-1f9ab0c21bbmr9093575ad.6.1718749029420; Tue, 18 Jun 2024
 15:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240616170553.2832-1-jszhang@kernel.org>
In-Reply-To: <20240616170553.2832-1-jszhang@kernel.org>
From: Cyril Bur <cyrilbur@tenstorrent.com>
Date: Wed, 19 Jun 2024 08:16:58 +1000
Message-ID: <CANtDSir9O+B1mZx-k+j0+bHo03A653itida8f34frFaY2doM0Q@mail.gmail.com>
Subject: [PATCH 0/6] riscv: convert bottom half of exception handling to C
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Samuel Holland <samuel.holland@sifive.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 3:21=E2=80=AFAM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> For readability, maintainability and future scalability, convert the
> bottom half of the exception handling to C.
>
> During the conversion, I found Anton fixed a performance issue
> and my patches will touch the same exception asm code, so I include
> Anton's patch for completeness. I also cooked a similar patch to avoid
> corrupting the RAS in ret_from_fork() per the inspiration.
>
> Mostly the assembly code is converted to C in a relatively
> straightforward manner.
>
> However, there are two modifications I need to mention:
>
> 1. the CSR_CAUSE reg reading and saving is moved to the C code
> because we need the cause to dispatch the exception handling,
> if we keep the cause reading and saving, we either pass it to
> do_traps() via. 2nd param or get it from pt_regs which an extra
> memory load is needed, I don't like any of the two solutions becase
> the exception handling sits in hot code path, every instruction
> matters.
>
> 2.To cope with SIFIVE_CIP_453 errata, it looks like we don't need
> alternative mechanism any more after the asm->c convertion. Just
> replace the excp_vect_table two entries.
>
>
>
> Anton Blanchard (1):
>   riscv: Improve exception and system call latency
>
I've retested this patch with the rest of the series applied. I can confirm
that the performance improvement is still there. Definitely thumbs up on my=
 end.

> Jisheng Zhang (5):
>   riscv: avoid corrupting the RAS
>   riscv: convert bottom half of exception handling to C
>   riscv: errata: remove ALT_INSN_FAULT and ALT_PAGE_FAULT
>   riscv: errata: sifive: remove NOMMU handling
>   riscv: remove asmlinkage from updated functions
>
>  arch/riscv/errata/sifive/errata.c         | 25 +++++++---
>  arch/riscv/errata/sifive/errata_cip_453.S |  4 --
>  arch/riscv/include/asm/asm-prototypes.h   |  7 +--
>  arch/riscv/include/asm/errata_list.h      | 21 ++------
>  arch/riscv/kernel/entry.S                 | 61 ++---------------------
>  arch/riscv/kernel/stacktrace.c            |  4 +-
>  arch/riscv/kernel/traps.c                 | 57 ++++++++++++++++++---
>  7 files changed, 81 insertions(+), 98 deletions(-)
>
> --
> 2.43.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

