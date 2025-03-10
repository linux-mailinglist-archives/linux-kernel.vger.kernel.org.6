Return-Path: <linux-kernel+bounces-553821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AADA58F3B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF8B2188692A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FAC2248AA;
	Mon, 10 Mar 2025 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1hc1VQ9+"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0450D1361
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741598153; cv=none; b=hDjSfa3keL3j5UG0FPeS64ZLA2GY1YIwPqC/b7jRajSJknxJknUVkDM6aIjUGoGdQLa3DMkiz0Hb7icnF5JSWuJW52SyNpVAJKGi8mvGvFroPXpgVSdF2i8hmfHUZXZRk7OMngYjc23ArgYXRo45LjtTI6wepayPFjMVOvE1QCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741598153; c=relaxed/simple;
	bh=KjSoU6/mBbGahQ04HV4jjvNKb9ObDoSCk+0lV+80R4w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fRwN7MsA+V9dWenR/U+wHPGk6KkBEuht5Z89jDtWGeSMJR44U/PGplnM2cq42l6Oqstv1C0gn8nD3Pq1x9KQc8PwqWWzqQ+eVAxI4AVp7cf66w+awKIzdzb9ZXHzLTHF8uE3GWbRlTL8gZsFLujdVisSECLJOmCkGhNYifh6hL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1hc1VQ9+; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43cf64f1dc5so3626215e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741598150; x=1742202950; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jC9dwmLMGrJONvWdmLchB8OrIEYq2jjVi0+jpdkBizI=;
        b=1hc1VQ9+HImo9HXOoLOaEZ4Z2hS7xQpfWafecn9cL21vx40Ck9OzJp9L5FOQIrNG7+
         Shn3OySkR1iHegJt9I79hQOs5Tdli+sbiV1+kGUHsI4shJMBld0GIzWo94AGW0GpJ6AL
         LRVwpcp3WPjNUSK9lg5jjZ7VI2hOsaKpxVqViVQedrR3fBnIrpkMANaITQdWmgx4E+LX
         MRvJENo1oOjVngr+W8afvO9mIZXAsCPXpaAo2VSAubvaSD4M9FwhaP9HEfOf94zh09Jl
         32ivivoo2QhiK2MaJqDYLp9YPVyQ5UfQVYTatoEFi3ztVBKS7TfmAFcvSK9qT2KYnGEc
         P6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741598150; x=1742202950;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jC9dwmLMGrJONvWdmLchB8OrIEYq2jjVi0+jpdkBizI=;
        b=Xn+aKdFLkSsOiHEoLBf9ur/JUyUbea3b0C2+ba/1T9O13sK/WI5cJpbm61/P5jJPUB
         eFdcFjz/y3HxiEofdimlpi0FEEgdD6ZFyIu9/wiNzG1glCnsrJFooBf6XRL3JU6RkuNF
         Fb+lZCI3PgtZzAT6cb6GCQwLsZZSZB7rarAzLw0Y4NurARx6Z6HlYIvPY2zFhE/Fn/Lc
         n4OnRXWMD9YlnSnDcuWHFtNCLapPvx9JPkqADF8dme/cbfGMPLaNMtRXOhQ10zOuteer
         QF+sNnAzKYLy1GaqA0mzd8H6+dbLpvIwwc8TuN7s+DUvKs9vooBoCoaqTFt2m5PD6Jva
         xyyw==
X-Forwarded-Encrypted: i=1; AJvYcCXOLkWFn40xhmYH3kB0LaHvO9tDDZoCLBFjV6D2nYaRC/tmSqCIa7V64st5++Q7oC1bmjYHetgVC9tMwbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs+fnFVnePxzS2zdajpdP4PQE2XZ/fvB4IHXKGDvob5RAJJsz9
	m/74GqWBCmpiG9n7NFHOTT0jwWxUJn1aPlwZ36hBe+hOwImIAnw/i8fiu/JmkxYiFhqcLBpmloI
	htbj7mU10Rfsdgg==
X-Google-Smtp-Source: AGHT+IFld+YMbPi6vF1aQtVy8e1i98OzUQUBy9QMXqfEE1Pf4Daw9v+O6rr7flwQQrudHMtNoS+bOOx/1S6RKQs=
X-Received: from wmqa4.prod.google.com ([2002:a05:600c:3484:b0:43c:fc61:959c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4fc1:b0:43b:cd0d:9466 with SMTP id 5b1f17b1804b1-43c601d9251mr66339335e9.9.1741598150298;
 Mon, 10 Mar 2025 02:15:50 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:15:47 +0000
In-Reply-To: <20250308-comment-fix-v1-1-4bba709fd36d@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250308-comment-fix-v1-1-4bba709fd36d@posteo.net>
Message-ID: <Z86tw6ugdwfJCTnu@google.com>
Subject: Re: [PATCH] rust: task: fix `SAFETY` comment for Task::wake_up
From: Alice Ryhl <aliceryhl@google.com>
To: Panagiotis Foliadis <pfoliadis@posteo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Christian Brauner <brauner@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sat, Mar 08, 2025 at 04:49:05PM +0000, Panagiotis Foliadis wrote:
> The `SAFETY` comment inside the `wake_up` function references
> erroneously the `signal_pending` function instead of the
> `wake_up_process` which is actually called. Fix the comment
> to reference the correct function.
> 
> Fixes: fe95f58320e6 ("rust: task: adjust safety comments in Task methods")
> Signed-off-by: Panagiotis Foliadis <pfoliadis@posteo.net>

Thanks.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

