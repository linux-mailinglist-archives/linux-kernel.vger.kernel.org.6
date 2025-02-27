Return-Path: <linux-kernel+bounces-535700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B47A47631
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F6C188ED6D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B333721D3C1;
	Thu, 27 Feb 2025 07:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LuKokJ7D"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC3619D8A2
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740639625; cv=none; b=FzMBKcQ8U55MhMJV/Gk0jGcBYnvhsTbJluisLctBjrGmNLEaaqg4d43zmbj/vjRXtyPSm5Ry6cECH1S0xuk9EDo3ZYLxF1lqCzSbO+/yk1YUytMy1IIBD1nbENGPqWN5AELBAV45HIEszff1CITr+WQou2xHfH0Nm9FiBfp7XZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740639625; c=relaxed/simple;
	bh=Ah0Ok8u2jvwbArCTA7l4DjY9WAjqP5uUmepnny/Z2kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nHHX5oLrP8yG1Rp74vq/Y3326DuBiU15ihh72Y6U1CWgxd8+nIbQsrY4qTBR2Dmng/AFyg+EW1glM/afrmGUMPXftRVqTvW+x7UCR1srtqapNrPMaXryjusYm114QRTeV8PT3NjjxzqUWJwA7RS6tUqNJyS4xUe+KsWg8pcl1Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LuKokJ7D; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fea47bcb51so912562a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 23:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740639622; x=1741244422; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3B7a9PKqDfPLxt+uZdMSLJc6wZgnR8JO787nsEWqq0U=;
        b=LuKokJ7D9zG2/XGscU4kMDnfTJsPXxCjq2JaNkS9yY0qLXIL/1U6KNMeu7uMJP574R
         pkrYS7LM6m0jClsNvt3YIlqBZfMy3qEppQ0Xtc9z+sM8cRRTedhb2FZp3zUAg4y+wkCF
         zARfalQLaGf+FVHUBNqBg06TaEIhRz4X1Hwc0AXfEuF6kHg8QIhAP6zuNKYqpCIaRs0z
         s3PuUnsllVcv+7dAEnN9VP36L7vtRQ2vpTohqpLN3BrzdjGRsFZtaQPqpy9IDRJ3foTX
         M2B7fe+tBkSt2h7USbBzb4hBKIVfWapzl4EDTMykeEjqMhxpdi3vPz9curMgrsfO7g3J
         BxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740639622; x=1741244422;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3B7a9PKqDfPLxt+uZdMSLJc6wZgnR8JO787nsEWqq0U=;
        b=OIvBQqqVX2pqHucGs5PYZNtblC9Suaw45ewJ0W8AdMLOOEqn77gG/dJh38kutgTd2T
         ByzNuGJbWx7yBEbL9yViIOd4mCCRQuLXBZ2mtnFuan31i3OjqA1HO+V/IGzOF3mrXT25
         zJ6BQiSh1Rt9lExADnP2euwzr4zSjck1TM06eG1RpzTO/e+4lMDAjDBJuHfNT6t8TOjv
         HCBRAh2YP0Xi7HbmB9hnIaYBLGJxVYzM8aPJAP4pDIfqxM/YsIyEbrqurrU/vp2VVGH5
         1C9MIo+aA2sglYj0nfH6Py+82r2naeL84QGm89e/EHAVVy1lMFbuTeQrzdLwkZhbK4KD
         ek+A==
X-Forwarded-Encrypted: i=1; AJvYcCVOHDyT0Okhv+QiahN0fr+XnfdBip8JVHacYfFRO/zDcwhp2lcUkCsIUEBBTUl64jiBMyaP01OySx7+4bY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTGy/BrNg+PSXLa6S/vdQoopK2Len+mbMsRksPjpFWSQ3BIC87
	1dt2RWHUgOWKoRauP7nb3iePL2lQMJwwE3ogBEEUmxBkuzdJ7MRHvTjNRD8iaqnZbszCplDYAE4
	l1kcUm4Z2lbE8kRK+QVLBQ7N9Tc+p0pn9LjGx
X-Gm-Gg: ASbGncsEFhyxvR+u7+S+OrgR3QxYYzH8+soMUS/9yCouJxTXtfzcM8N9dl1mHLOC05d
	/EWNP+yMjhbuUSn9k0w0qLjaI+nu0S7zhFXRfU4383HtUyRv761lS0mb7Kh9abrUruBxHIsov/P
	m2c5kzSlLCC1qrMob3kVTrTqXrmB96KZRlKjKpBQ==
X-Google-Smtp-Source: AGHT+IFfzszcK8xz3AbKXR7cq/ASZditUq/IPM5LeqCUO3BVtZeQjerGEcaCp84fg3Mzv4RyJIt8ZyiiSg5FyAUsE5M=
X-Received: by 2002:a17:90b:5148:b0:2fa:17dd:6afa with SMTP id
 98e67ed59e1d1-2fce86cdeddmr44583103a91.17.1740639621455; Wed, 26 Feb 2025
 23:00:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206181711.1902989-1-elver@google.com>
In-Reply-To: <20250206181711.1902989-1-elver@google.com>
From: Marco Elver <elver@google.com>
Date: Thu, 27 Feb 2025 08:00:00 +0100
X-Gm-Features: AQ5f1JrZWnMR4OE-NBvXmFaojOYjcgWnnmEzRSN2Q8FKZWV0JX5T-ip-Qb4DfME
Message-ID: <CANpmjNNxb8f4QNQE+3oprwfhbhZNkiN+JJMRAzMa8mHXFkksow@mail.gmail.com>
Subject: Re: [PATCH RFC 00/24] Compiler-Based Capability- and Locking-Analysis
To: elver@google.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, 
	Bart Van Assche <bvanassche@acm.org>, Bill Wendling <morbo@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Triplett <josh@joshtriplett.org>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, rcu@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Feb 2025 at 19:17, Marco Elver <elver@google.com> wrote:
[...]
> Capability analysis is a C language extension, which enables statically
> checking that user-definable "capabilities" are acquired and released where
> required. An obvious application is lock-safety checking for the kernel's
> various synchronization primitives (each of which represents a "capability"),
> and checking that locking rules are not violated.
[...]
> This series is also available at this Git tree:

   https://web.git.kernel.org/pub/scm/linux/kernel/git/melver/linux.git/log/?h=cap-analysis/dev

I'm planning to send a v2 soon (Clang just gained
-Wthread-safety-pointer which I wanted to have committed before).
Preview at the above tree.

Thanks,
-- Marco

