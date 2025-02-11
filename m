Return-Path: <linux-kernel+bounces-509943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E38A3165E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63EC4188A619
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 20:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F421FAC49;
	Tue, 11 Feb 2025 20:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0CUKWNxV"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F9426561A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 20:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739304293; cv=none; b=TPIyHM7y+reigN0pqIGHF6Iw8yXgiS0STgmVOg4oh3yQcAUS20r60DQes+hwwki283/xpYwDrz0wvjQ56FcuXoNkFAyaZyh/POQ2ELqOlpjpbSiuJLF8uxxRz2zVe776HFOKAZxl9sIMBRbS3MPFxmgoc1sntNnBuYe+KAO4bjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739304293; c=relaxed/simple;
	bh=yQ5UQtPrJh6CDgDFQ5kOE10MbeESFXkLMTABKS+oBEM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SrrEmJ5p1aEs2aCR8CPAw/0Rb38RFUtAjs5Q5IIo2lH9+/QfHc4moDptch+AOn5JLlH0l2ljnPXQCK4CrvKK9ylN1n900TU3PcOn013sce54eMrwOqoUpbwk7QsryOmxiz2CMRoNwRqj1LyLixSEVCT9Uuza/3H3UMwQkPOFlZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0CUKWNxV; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d050fdf2ffso17564015ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 12:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739304291; x=1739909091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSafBjwhtkCgy84RqH/1n0KPcLrpwZEy3MZrJYm7NDg=;
        b=0CUKWNxVFt84yl6y1X6llOodW49UnhYhsA57+nG/nlt25WIUSbeT1gLfT4+eefnw2b
         8mOjWCZNrueD0DzrMj7l9FhdXrnFUDw2kixUU5iNInLG6XJHwnpiNaC1JDy/ZUL+Ffit
         RXBOubEiLP1uAnJ3SL42OwWKYQasc8fexdPM8eNEPTVnkzN3qXuMPmUjhXB4Nbq1Ocgn
         5+6b9S+mPJvlUtJyeu95OJXXMHQRdB6XlPRLU+ZNtF0yxmpOa42OUELA5xMe9ZdnxUQs
         KoW8O5Afs7waEjRNghwVhagBTBNbYL/kSf32hgjKpVcv6JdDkKCi05nCz8ugbMe9T8vw
         0Dgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739304291; x=1739909091;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSafBjwhtkCgy84RqH/1n0KPcLrpwZEy3MZrJYm7NDg=;
        b=woXHG8BAZlMZlWGDr+aRhPWIoOTS88Hhvt2FhUJtadI9RY3t5YJiCa+cy1AqQVaPO2
         aiDIIbbZ0qmdnEJcsf2z3Ei9apX8AgS7J1Ic7dgsU4hRZ/J+OLYOsFdYRsSwSByVrD8Y
         fBBV6a5++D9KE155CakTvv11HOh6HCSSWhIxaFTVvbU7wnyubvatTQFvIgD0HLTqBCLm
         K0oloihD5eWl8zdSt3FnMl5r6KwYunr/qPS9pD58EJBtbqPeO6XSYD9kJ7t+YLDIjvHx
         MuxDt10uX/DyyTq8ffWwdzKWqE/rFoSg7BawWgS8RM6BerZm209xTg/CGDC0VA4PMT8U
         sTnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb4ZpYcTr7+NbL3UB5Dei/q9OTDwq+IYSUx+v+3XDP1DQ+nJkTxjzZtXbYoDkEBowb4jRQ4vRcUa92xLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc9vcNF+288gpXznBvE4ykca9pP1mkq4r74Mg4Z5aeNmWKouf2
	G0l2HtxEMWBlYVC8FFVIcv33S7TRBz+Qvw5Pq9ETn6q38jMZKxL/G2j4fNPZK1k=
X-Gm-Gg: ASbGnctVR2F/zYuw2IejcYPaYsyzQfDdJrx0p1OD7mSOlHuyJujw+Ggxr9M3zYN0yCq
	z11DjtcvTWzlWDGOhX8d9Kmn5dBUGIEAVtWJejNfhOVDzgcOOroelnDUtt5ZHrtrivVki2AuuIa
	QF6vE8ZUMhWNTn87bOL9lG6SGNYVWQrwSqDLzRTp43yfwVHmmZyZvhZYkSsptBX4AzYb1+ljk7C
	/ahmKi9tOq2u8u/9yJJ5+FIfd5z1aYvBlzghazS2Ih89zNhEoJiJodvRa4AJnCpeEPD4eOxBn/r
	+5Fveg==
X-Google-Smtp-Source: AGHT+IF6ngVv4H+7ay1KS5AYnsWGnxP6t6rI34lhHdXcsNGwsA/2PiydcVTWSg7Ie4NNEWNk4JvMNA==
X-Received: by 2002:a05:6e02:3184:b0:3d0:4eaa:e480 with SMTP id e9e14a558f8ab-3d17be0cd74mr9013225ab.3.1739304290713;
        Tue, 11 Feb 2025 12:04:50 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d155e5caa1sm17430295ab.5.2025.02.11.12.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 12:04:49 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, yukuai1@huaweicloud.com, 
 Muchun Song <muchun.song@linux.dev>
Cc: chengming.zhou@linux.dev, muchun.song@linux.dev, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <20250208090416.38642-1-songmuchun@bytedance.com>
References: <20250208090416.38642-1-songmuchun@bytedance.com>
Subject: Re: [PATCH RESEND v2 1/2] block: introduce init_wait_func()
Message-Id: <173930428956.134224.12826732469038021617.b4-ty@kernel.dk>
Date: Tue, 11 Feb 2025 13:04:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Sat, 08 Feb 2025 17:04:15 +0800, Muchun Song wrote:
> There is already a macro DEFINE_WAIT_FUNC() to declare a wait_queue_entry
> with a specified waking function. But there is not a counterpart for
> initializing one wait_queue_entry with a specified waking function. So
> introducing init_wait_func() for this, which also could be used in iocost
> and rq-qos. Using default_wake_function() in rq_qos_wait() to wake up
> waiters, which could remove ->task field from rq_qos_wait_data.
> 
> [...]

Applied, thanks!

[1/2] block: introduce init_wait_func()
      commit: 36d03cb3277e29beedb87b8efb1e4da02b26e0c0
[2/2] block: refactor rq_qos_wait()
      commit: a052bfa636bb763786b9dc13a301a59afb03787a

Best regards,
-- 
Jens Axboe




