Return-Path: <linux-kernel+bounces-510934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD33A323C7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53F7B1883125
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C77C20896E;
	Wed, 12 Feb 2025 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B6V0oH4N"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127E3208964
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739357055; cv=none; b=tHFPOpmzn3AVsadDZdL2TcWjSkjk3zk3j8o0UAraVV/xLMLHJEPjzABv9Lt8nGArOJ1LtlvxUEYbuqmC6gj4GaJTUEXJTUov4S2Gf0CmC+S9SJswCW0vvL3KQF+upL2gykvsrQOJzsj1BZVpCHgLRsWPBVj/cKGI9Fs/+Z5awJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739357055; c=relaxed/simple;
	bh=znGATIqYnfIj5Omip9XqassNFw23hr0mEndIXqqLOBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EiP6p9U5oAZoHkSlbNqZa3OnTHNWGGrCUrRB4PM5wTt/4JJppHkkjyePdwqMfCMXOhuGcopAev9psX79HOdIGbcHRI+7VJgbg6G9AlX4WJ1GaZACsA8G0KkhsAQ0X1P4q2TdwReeuUBHhSztcrSTrgEAfeLsQ5i9UvO00+JsB9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B6V0oH4N; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-47190a013d4so165831cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739357053; x=1739961853; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=znGATIqYnfIj5Omip9XqassNFw23hr0mEndIXqqLOBk=;
        b=B6V0oH4NXyhd9IjMAE3gbpq8pNyZeNLQr60fPKr7GoFeKODAlJIBfo1kNT1hRUwprq
         mRFzp8NGFaASqrgl3xXxKkJ6kYU54tUZ7h1/g9IP2mhGC6ufnoGwUHVB0rzapawK4P17
         /Hoei5pyIX2hZEi4EMkiDAvowtSV85/EaRSlv8qLKfsB8we3mqsiUinVM8ipHVtYilFY
         I5z/Zudbude5yS4mSa3NBHRHIRdaaeSORWpDgmF7hEc2+iT+xZ7riYyOD+AoqZolk6mr
         wid75Nui+lcjoWFym4nNxWu9r1kZIKRLspsHfFWd0NFfWwgUZzFyEAnysHXm0WvUOsWt
         S0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739357053; x=1739961853;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=znGATIqYnfIj5Omip9XqassNFw23hr0mEndIXqqLOBk=;
        b=DtpxgMV3S1seWy9+Bo/Ac4SZw+nEA/QF1aqXoHIAbTxk2slgEaWMI1ptl8oOysgwiK
         RMn7Xj5P9DTzf256NHi+F3XeI5hvin4ivwAsIjuj11beNmMO943v1OJ9hdbQhxL7DKZx
         fTaFksLEzcc8VCgsOIWRh0c0neJOgMEDdDecA7d8J1UU96TtdHjTl3feKC0sJMVx9VL9
         MRAh4IO2aZTnVR2mhth/8jFkxpkVnkjFy/EkOaSigJjktyyO9wk6zfIG00DKngBCvxZQ
         x9y7koMK+YCS5xuSp+n2cdg9MnmQ+3cEDfa4G4yEkIwIpXalk+jZRNi07YBN0ByrNYVE
         +aXw==
X-Forwarded-Encrypted: i=1; AJvYcCVpwge0GgQWi9d5Ztj6X3rmQZgHHxn6a976sL3RgpheyWRNvZ7agcyngdPGxoZlq2CgEf7Wk2lyM1NJrxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLU/GfAfLun5F42SSqST9/Beg+lNy5ahfRDJA0Xz47ZNQOMKfj
	ZCmI7nSeeP08LfK9/wOJlSf/HEchhU7OnrpIrif7g8cIzEs/kSRiVBcafLPWlOPtGfmwBKlUSsL
	v6IE9kTNT99HTdAtxjxyDov5C3S6va3S3m3xk
X-Gm-Gg: ASbGnctAZBfVdmLx1Q6itD4rafraICSYQ/qPt44Xc6MTZAqq4zPakf7/XSEUa2bR9T4
	F+gPd59rt/QgZ3l42hEJy6Hpr0atXXmOvJkdRQZBudxr2uvaKy284pLiy9jAh1e0BQpQ/lqHtvu
	ZpEyOyMVDbQ2xQBYFH5lwPmCFN+8A=
X-Google-Smtp-Source: AGHT+IEyV+a8/XTwlzGcDuCm+W2LAprsvor8l9fKfMKMWxmtMT4HwfT9w5s6Znn+Li6TACjdRksJpfoU0lunLPdoPjg=
X-Received: by 2002:a05:622a:5908:b0:471:83af:c8d1 with SMTP id
 d75a77b69052e-471b01db5a0mr3303281cf.10.1739357052664; Wed, 12 Feb 2025
 02:44:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211210823.242681-1-riel@surriel.com> <20250212102349.GE19118@noisy.programming.kicks-ass.net>
In-Reply-To: <20250212102349.GE19118@noisy.programming.kicks-ass.net>
From: Brendan Jackman <jackmanb@google.com>
Date: Wed, 12 Feb 2025 11:44:01 +0100
X-Gm-Features: AWEUYZkHDY9-oWjBv2GAM02r8jxQT_sHCXNZi518ZRTzQtvPclq6CRF6k4zSfKw
Message-ID: <CA+i-1C0Sbgkyfan=srXL8dRrqaLoT1g1F5tZesC1rrh6v7L68w@mail.gmail.com>
Subject: Re: [PATCH v10 00/12] AMD broadcast TLB invalidation
To: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	bp@alien8.de, dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com, 
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com, 
	linux-mm@kvack.org, akpm@linux-foundation.org, jannh@google.com, 
	mhklinux@outlook.com, andrew.cooper3@citrix.com
Content-Type: text/plain; charset="UTF-8"

They apply to 60675d4ca1ef0 ("Merge branch 'linus' into x86/mm, to
pick up fixes").

Rik, can I refer you to the BASE TREE INFORMATION section of man
git-format-patch. I haven't used that feature lately (b4 takes care of
this) but it looks like --base=auto will add the necessary info, or
IIRC there's a way to make that behaviour the default.

On Wed, 12 Feb 2025 at 11:23, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Feb 11, 2025 at 04:07:55PM -0500, Rik van Riel wrote:
> > Add support for broadcast TLB invalidation using AMD's INVLPGB instruction.
>
> What tree are these patches against? I can't seem to cleanly apply them
> to anything much :/

