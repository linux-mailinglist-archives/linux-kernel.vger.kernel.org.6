Return-Path: <linux-kernel+bounces-511163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC9BA32718
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F5A3A7E5D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D1D20E317;
	Wed, 12 Feb 2025 13:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S5nJwnWs"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2294120E03B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 13:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739366943; cv=none; b=lpPnQX8zOJSQ2rYEtSY887n6zItYYsG7iMH07GVEcSSzxo3J3sfWH/UY0bNBYXOvfHkmpCW80TM6vrJqsSYZF+4B/1coUg6cdnzN5nC5PEGlpZqduG6LkuUd0vaIpMqBedbnLSM/qLHg6a4vw2tl/HHKLv/120ClB+Mw6wtgJZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739366943; c=relaxed/simple;
	bh=dcPwOogXC38uVoyd6zrdXBJSymZEmEN1/uCRO1Visbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KbNAjcoIXEAY62D9kph2Dq00Dksf2VebmkBkNDa9bx1A7ahHNS8LzJClHVoMMaddjCgO/5T8IOJtaLvgyHYUQyObcvuQwGIlM7GbGlvh9GB1vxjoh3TyvsBIihCEBkDqVGDFLRrtoume28VQCqPKzHk3E4CjHeq2UgshTfqR5YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S5nJwnWs; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-47180c199ebso267631cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 05:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739366941; x=1739971741; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1oevKEhZpdcUgIPsqB5jXWn7er2+P5SxSWdzJyUQCGc=;
        b=S5nJwnWsK0bSfeweEPKK4yCbogl6hej/8HoY9RlgHRaZHL5gk2YgNwTBz+gyJnjlBe
         v8myqvuXkzVhY8o4Tkd+RLWXPUtAYdhznqziZXUI/BzwQugHiDNuYXAW0gIsGNyq93oD
         WimKb8E1JrLzJRIRli/PdfYtuS56w+1HkW2EQKd3G2ug9kj3WlIQBBqxnkch5yCB3Tun
         rRvKlQGPWoyzMHsCYVrM1GjYtMFEDLBj+GdcbmqGT6Zkw82w591JzVGxitV+6ASZSWay
         lFjpoOImugKFbg/4UIk/5w3OfkeFdMlxMmU/C/oLmrSP8Y8LZtIx1MzjknpYpp3atD6K
         jTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739366941; x=1739971741;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1oevKEhZpdcUgIPsqB5jXWn7er2+P5SxSWdzJyUQCGc=;
        b=Bx/94hh5703fVqbFWD2Qz49JL3PI9FYnD3df1YymEQSbTQnjDvawflahoKOLe8bxzU
         IIweuASsjpCh9La6vV1ffsYE5gJ7D3V/kZbVXKRn0IFpv4vj4OEwDFzlq5+RNGuF+oMv
         cDc9MgjhoNJKOTpKxoCSP3XhNgWlxz1pNRovDepuzc+AiWTd+J25Lhg1Fn3UY+jJVvfv
         rpkpMsfkOAwhG5xqFbZBIJ5Ib/RUNCAVwZRNyHsyTVRo0UN2R1NbgNTDF0m+/EodkaY8
         CwgB40zECn/TjYXLul7RtUtN2dlVhTSr3rMs5VkZlyQ3H5TG8HvS85KEmsQNddYcC9WC
         pxGw==
X-Forwarded-Encrypted: i=1; AJvYcCXtUEQDVqeiTH7ZvNazehDlcSnbzmUOCb8GUlPt37jj94N0J1M1kDZ+bpPWXqqESGojf3bygQBgzPkXAFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/NDVvw5IZOoLhVHMVQc6/GuEe1nX5FhRIVLqXF92DC01XJSPw
	U41mYr10ul6SZSTh/o+YTMUPjQvPrgmAuVnB5JPM8i94V36F6BzzBiLxsZn28SXqorb2AxxIAH4
	6n367hHm4U+ZYH6FLD/4d8G6436OBluvU4kBX
X-Gm-Gg: ASbGncvpEFj+cOqlokjkA4CN6PCH2e0AEF5VKSW2wT8Ywhts9rSWRkbk9i+DlXx7HMI
	WFn0eLnwUagyG8kwyDt6c49Ui79yse3Ar33P+zuXiI8d8teHg1xdG8nqXyQE1o4yBaMD7AVhicZ
	cCEM4/Ann+ug7y6Uc8aI2FvZ/znpY=
X-Google-Smtp-Source: AGHT+IFY7L/Myi794B1SK+3UlK21ZXz5RBVCl3KeIJna5/SZL0sEYBOmA5JkjmD5IfT9EtGDO2KAnqAmYbqEqpdLGX0=
X-Received: by 2002:a05:622a:606:b0:46d:f29d:4173 with SMTP id
 d75a77b69052e-471b0211422mr3517011cf.16.1739366940740; Wed, 12 Feb 2025
 05:29:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211210823.242681-1-riel@surriel.com> <20250211210823.242681-10-riel@surriel.com>
In-Reply-To: <20250211210823.242681-10-riel@surriel.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Wed, 12 Feb 2025 14:28:49 +0100
X-Gm-Features: AWEUYZn7d4B4bRC0FiC6VGjDHlL6JQqFPYLv5MVNharb2RHtWqjjfMY6zCfQF3A
Message-ID: <CA+i-1C3-F-VAy_JccwKx_AcD1mXsVcGHGwUFvi_ruAiqusiXZQ@mail.gmail.com>
Subject: Re: [PATCH v10 09/12] x86/mm: enable broadcast TLB invalidation for
 multi-threaded processes
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de, 
	peterz@infradead.org, dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com, 
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com, 
	linux-mm@kvack.org, akpm@linux-foundation.org, jannh@google.com, 
	mhklinux@outlook.com, andrew.cooper3@citrix.com, 
	Manali Shukla <Manali.Shukla@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Feb 2025 at 22:09, Rik van Riel <riel@surriel.com> wrote:
> +       /* Transition from global->local ASID does not currently happen. */
> +       if (!global_asid && is_global_asid(prev_asid))
> +               return true;

What about a WARN_ON_ONCE? Then the code contains evidence that the
comment is true. IIUC this isn't just a "not implemented feature",
rather there is plenty of other code that would need to be updated to
make it safe.

> +static void use_global_asid(struct mm_struct *mm)
> +{
> +       u16 asid;
> +
> +       guard(raw_spinlock_irqsave)(&global_asid_lock);
> +
> +       /* This process is already using broadcast TLB invalidation. */
> +       if (READ_ONCE(mm->context.global_asid))
> +               return;
> +
> +       /* The last global ASID was consumed while waiting for the lock. */
> +       if (!READ_ONCE(global_asid_available)) {

I think the READ_ONCE is unnecessary while we have the spinlock, it's
fine if this read gets split or whatever?

Ditto for mm->context.global_asid, it's only modified with the lock held.

