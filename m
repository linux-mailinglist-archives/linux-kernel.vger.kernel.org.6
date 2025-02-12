Return-Path: <linux-kernel+bounces-511483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E45BA32B97
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91BD3167B88
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FE8253353;
	Wed, 12 Feb 2025 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TNUfQyu7"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B46024C679
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739377808; cv=none; b=ANSFlxnBMD3dZo9hUAs/DAe67pdp2n7JyZcbFnaGj26ELsmbY85g6yDt1aONZHQnVPlltLl+EuI3OnyD3bwt9/8c0QMkTzgbJy7EOUM7/fkjYSWl5Ox9/XRgKPMSqzqZaoe0fBzLWBxFbAnipEppXMl2DUReKBtkumE0g9xDFZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739377808; c=relaxed/simple;
	bh=bKldBOW8xZeWh65oxIUWKxu4wpR/KiCESxmzhVx6VeU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BiUT1EHI7JIx7yAuUjQjMn8cFsIxlclbOU0j7FKPAO2+Cpr2c6B9TdKXQ7KNNweVlDpvyW+w8cQnDrhvY5aoe7mPYx5BzVlhmQayXhA/fWxuE3zOwVH9jQ2JurJ8PPTjq16X8bn8wgBq5cuirhsK3Fc8BBr6gtOwEjvtnxWCEI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TNUfQyu7; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fa6610fe70so7573684a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739377806; x=1739982606; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=INNJ0GLqmzDttrtzWAMgUkvo0ncHwsXlsbcG3hdIMeU=;
        b=TNUfQyu7coqi8mDit+Yus/yKM8ckOV1t3K2NnANdSJ6iWQ62N76cTYzD6ur8zRzH7x
         G2fCrAkrZ4CfofkBweA0pIkHiH07k+Zx5CTCM6Vd+IF5p9+oKZ9+8kjy7caR4OZmxopG
         bcEUp5FqMy1t4/jsmXjjDYw1CfbK1gmXwBd1Cr9qNq155EN1BZK/q84yZ1oZLihfCbHA
         YHFjSV1stHs5jtQe7DucPZypIISYp6Qa1UwAXw8hShmG6JEa01hmSWq7sX8kh8eXB5RR
         bdvsWwcdqDYVDNwiFXUTRwxHbSL+sUFCLu/Vs9gm92taPmBOmkIrwzCD3Nuny2nIKb2X
         U4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739377806; x=1739982606;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=INNJ0GLqmzDttrtzWAMgUkvo0ncHwsXlsbcG3hdIMeU=;
        b=JF5/I7laetdkL3jeKbCghQGxlflWjdyohEHxrhi6t4uosCT986lLz2hwe/eal3OYZQ
         fVH+By+xG+5gqn9apJzW9oVvwPElh9JZXlmMKw51YP42mJHqg/WQpY+iZi0IlEu1smBW
         nsqPg3sgZB04T2rCp65nALAht6r7igA6kshk9FVGUoSAZGyYuzoNIUVvRJzxE4bGOcs7
         BFIUk/SndjFU6nf/x2UUyAVk2TiGodeqrlefwT4iLmNeTSSlEEaHtbvXziHrGv0upWwW
         DLJtC8TjdL3IpCLuXjLKXFMpOh/O5QvY5KuAIvZn9KvsPpdZXSvm0bm+MzQIrdfhj3wd
         FocQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyljlR2qsXLNZdoCr08dO48wNKyo62+N50STncP1dopxZ9mPlWEXSvvWxXvA3JtyKhmvrXVozvRVnhXgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiuNsmJXS4ZMznVFO23Ze+EmbdW1Iood7y4l2t0FApsv3T4eQZ
	SBKHDN96CZfv5FX6pLA+njhU/c3h5+sDVebC6QLJtcW87eIGWkRuZqnQV6VUwLm4hZGp9EWqKna
	3XA==
X-Google-Smtp-Source: AGHT+IGEb06U+eVij7vX0poCySWtX2XI8K8BPd+Qt/prmv+voKNY99zmB70bJTwUUE97JgWYG6gZ1McIdFQ=
X-Received: from pfiy10.prod.google.com ([2002:a05:6a00:190a:b0:730:83d2:d6a3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:88f:b0:725:96f2:9e63
 with SMTP id d2e1a72fcca58-7322c404660mr5950568b3a.24.1739377806556; Wed, 12
 Feb 2025 08:30:06 -0800 (PST)
Date: Wed, 12 Feb 2025 08:30:05 -0800
In-Reply-To: <CA+i-1C0Sbgkyfan=srXL8dRrqaLoT1g1F5tZesC1rrh6v7L68w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250211210823.242681-1-riel@surriel.com> <20250212102349.GE19118@noisy.programming.kicks-ass.net>
 <CA+i-1C0Sbgkyfan=srXL8dRrqaLoT1g1F5tZesC1rrh6v7L68w@mail.gmail.com>
Message-ID: <Z6zMjTyqTihpl9BI@google.com>
Subject: Re: [PATCH v10 00/12] AMD broadcast TLB invalidation
From: Sean Christopherson <seanjc@google.com>
To: Brendan Jackman <jackmanb@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Rik van Riel <riel@surriel.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	zhengqi.arch@bytedance.com, nadav.amit@gmail.com, thomas.lendacky@amd.com, 
	kernel-team@meta.com, linux-mm@kvack.org, akpm@linux-foundation.org, 
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 12, 2025, Brendan Jackman wrote:
> They apply to 60675d4ca1ef0 ("Merge branch 'linus' into x86/mm, to
> pick up fixes").
> 
> Rik, can I refer you to the BASE TREE INFORMATION section of man
> git-format-patch. I haven't used that feature lately (b4 takes care of
> this) but it looks like --base=auto will add the necessary info, or
> IIRC there's a way to make that behaviour the default.

IMO, --base=auto is too easy to unintentionally misuse, e.g. it will do the wrong
thing if your upstream branch is set to a personal repository.  --base itself is
fantastic though.  I personally do:

  git format-patch --base=HEAD~$nr <bunch of other stuff> -$nr

where $nr is the number of patches in the series.  I.e. advertise the base as
whatever the series of patches is based on, not what the branch is based on.  The
only time it doesn't work is if your local branch has a commit that is not in the
series, and is not publicly visible.  E.g. if the series depends on another in-flight
series that you've applied locally.  But in that case, you should be explaining
what's up in your cover letter no matter what.

