Return-Path: <linux-kernel+bounces-426747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 406979DF739
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 22:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D28281071
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 21:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B391D9334;
	Sun,  1 Dec 2024 21:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="L39OeohB"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABD918AEA
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 21:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733089792; cv=none; b=VclWvTGBQawwDImI0tvkjvpbeNsqCmviE/xPl112Je2MkNfeALJLQGj4Q4wd9YN4Ck+nFUIVAAdy1iMxByvmqPCJ4wr/NraZ/ICiK2SQm1+JiFEHRs1gtQJjdvSe2bK/yPYjQfgmEt+luBuMHxRgVU8b3AsT4w9oudlZtWeqvCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733089792; c=relaxed/simple;
	bh=xXJPQ6YbYgc+LsntidKKs/X461vEK6auxVARRMkPIzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GSSObRdxILo2vBwMnL1UmPfxXsJtqspS823k8WhuIYNPaOEiTVA/I7sxL+zdxwopluxwr+9G/NeKYiu5Ydpeen60mXDkcpX5BtnPGhWKyeylwsCW9hmgETSoGL/h3ZLBEnGxrzLY3rVUOAwS8Eg0fDTbQF8HfVvsFy3tcWci8oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=L39OeohB; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7242f559a9fso3489045b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 13:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733089790; x=1733694590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ckF5QGnSsa0BB01QMlPw18K2Y6z5eE1xBtBTmSkmOrU=;
        b=L39OeohBrATyQzBYGf4B7mSuB61Oo0AczOununI4eMr8/Gj9jeHZBzWs1oNGBjKx+D
         ua80OZzaYqPz6BU8mNGMuySjhC4CSBohfAdtGmF8UWCn6Fx5dcvmc+bBCT70E+WGLCiH
         s3YOJs2DPvrTgCpbJwonNarS8FcZs+FUgL8/7/tGI6PcdGBz2n8N91qpcJvT8Ef6dyKb
         X3Eb0AOls8Ht5mMSgJxNqf0s0sEmO/WqMknhI866IgFD9pXnVemKaTsqqQ+a2MBUAKcF
         wl6fiGw5DQJ95TvmeZFRRqjoNEncPdB4E3ODCFY8dDbwn0ueD0nmc0QhKOhkUJ5pN4LT
         z7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733089790; x=1733694590;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckF5QGnSsa0BB01QMlPw18K2Y6z5eE1xBtBTmSkmOrU=;
        b=WAArARs6ra3MDDLfvW9TnCsHMBqq0XjmKm0QwEf6P7xaAbjMWV3i+WQWF2Qr+vjNqY
         WwJH44EktMbjILPrmT6wQ2Q/6zg5Udt3+CHn2G+ZzOIm0OypQgURTcti+xDp0AYNriAt
         hkaCodPkI4KGrGXsNinZX1OjvpZohR/rAVxsPIgNzmGmbCArLmtDIxJgmzCgHJbnIM84
         I9YlXdi0bqzrn1zYiULqpEbLJXDFP4ok+DP3Gx17TRg+HHWmCG2sZTnXgI381EvYEBms
         +XMyZQfLegt7iqFuABCk08M+Z+geHveg3xp7dw5b/1DgohgYirAsYjwjZavTqzNExSRB
         o3vQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHq8fXSlXthkXSFlAbOD4fTjZ3JWrovH9n0C8GUFGvifdefUKoUNZcVGnoiK/eCB0oLCeKYeQxDN66Eo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnQtuJEvGC2MJUo8+PtLOdfe5GyZtxkFvU7zh9g4aGkh1zbCtw
	IHdc2Zf7r3FBM23S4hkssfwAgZoSCmUI4gJ0tnEvzHO47QpQmA24yjyu4zvotLY=
X-Gm-Gg: ASbGnctGCPqgSUrWlBe1oWE2/6AIPSAeS0y7R8KSRF6+JC/KddgLRqR+W2WyPwWtotg
	kfHDbN2cXIQ3cE6YuNTALRU03aa6lUu5wup1J+2zPqL3r+rpDj1F2WlB9nVWyRcU//ZdMUee5kB
	7hfrGh1m1gPT7znjX9S15tRrA3xhS97tHGTA7rrNPrljT+TLDUeE51Aj4hteEfIU3zVo6ak6qDP
	+RmUe9noO5nZwm+iXvldSUhVmQjX/pmyD2Ai1ew4ureP2U=
X-Google-Smtp-Source: AGHT+IEJ8i/d4RS5aNUgb0ZzcIBRhjMpR8RaWqdw3iTHbi813IFT7He4V5pwrlQ+TjGvCu78jA5zjQ==
X-Received: by 2002:a05:6a00:2381:b0:71e:5d1d:1aa2 with SMTP id d2e1a72fcca58-7253000347emr24970119b3a.7.1733089790310;
        Sun, 01 Dec 2024 13:49:50 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417725e9sm7069306b3a.80.2024.12.01.13.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2024 13:49:49 -0800 (PST)
Message-ID: <be3a3bd5-0991-480e-8190-010faa5b4727@kernel.dk>
Date: Sun, 1 Dec 2024 14:49:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] exec: Make sure task->comm is always NUL-terminated
To: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Pavel Begunkov <asml.silence@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Chen Yu <yu.c.chen@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20241130044909.work.541-kees@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241130044909.work.541-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/29/24 9:49 PM, Kees Cook wrote:
> Using strscpy() meant that the final character in task->comm may be
> non-NUL for a moment before the "string too long" truncation happens.
> 
> Instead of adding a new use of the ambiguous strncpy(), we'd want to
> use memtostr_pad() which enforces being able to check at compile time
> that sizes are sensible, but this requires being able to see string
> buffer lengths. Instead of trying to inline __set_task_comm() (which
> needs to call trace and perf functions), just open-code it. But to
> make sure we're always safe, add compile-time checking like we already
> do for get_task_comm().

In terms of the io_uring changes, both of those looks fine to me. Feel
free to bundle it with something else. If you're still changing things,
then I do prefer = { }; rather than no space...

-- 
Jens Axboe

