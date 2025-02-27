Return-Path: <linux-kernel+bounces-536485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25324A48081
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1859D17BC3D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AE2231A3F;
	Thu, 27 Feb 2025 13:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NmYgBaKV"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F40230D11
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740664717; cv=none; b=B9muQ2ACNYaxskWpPiAaiQZ6uywdKtz4icW9Iowk6MfY2eixLmq8UfmP8C8lQhuJIqs7x8vWp2MQ5877ezDLoLzIHHJj12u2Vj1B/L07C5CRMZSgleu40XClOccRnq8OiL2A+8k6NEX4yz0VqqMMKNItrais4nFoXhScTnPygIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740664717; c=relaxed/simple;
	bh=s+ea1fNlNQuRawa1XJ5CuwO+GP4dU0ORB0f5TA0ec1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FP4QZKHumxS65+jiX96jurHMUOhN1LehV1IUysGtrqmhRRjA25S+bOeUTjH++jh+UR2xceW5kzBvThUAIg133koimkqUzzFf5wik9QoaA/8NF5hdpIi3aWKQ4WosiM8fnqQweaQToySjNcGrG9NdNMzLDZ7e4rtNwtreJ2fyuOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NmYgBaKV; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30930b0b420so8524141fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 05:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740664714; x=1741269514; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s+ea1fNlNQuRawa1XJ5CuwO+GP4dU0ORB0f5TA0ec1E=;
        b=NmYgBaKV2wVssSaw9YoYtL4gUiAFbotzRn4fJ0V2l7/uLxZ0yK4u4i7h5CKJgfp0n+
         j/hTdQf585zJSsQx7ukF0aTylraU8bYfeL78gygkpt7hzgX4hP4xIR4m2klta0GSVt/A
         yKxubxh9CjVsDSBwp7hPXLBAY/QHTQsYMey0Nn7b/2X2MNyoHkDwZ1IBn1JESLdJlWZd
         4BgMeCFsdd1sDvnf3rNaTEGnGRb6dphU/EAgM9zpeh6aAZetnzON8n5A7znc306ANpno
         Ygaic0cBrqcXrEKchnXT1JF4WSKrphg0T8aa4zc0tm72/dQLc1bMazjZ/lUDgXnmmmNg
         UAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740664714; x=1741269514;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+ea1fNlNQuRawa1XJ5CuwO+GP4dU0ORB0f5TA0ec1E=;
        b=BFXSm07onfzgluk0a5jB8VqdJ65HFcvfl75IJHg2usvVGllW3LsOHoi7qxwOvlcQLO
         SrELKzxJgaBSXpVLBNsP+iQUI8S0cbWC0PtmameMBugdWBjYesLDEbQNNhkfwSbgDgvd
         HTdqT+GG7ZvoSYmIrdU/lB4APh7x9cmeEKVqrOwIt3wBKr+4IWuItJBWfEBG3ZE1pQcx
         FS7XqG/HF53z9583Nb8QjIWaXOkWAzilqV07HfXUaR2eNDQGoitPTEMtfyEkjvfEe5dt
         Q5pChSS0kX+LbJn+zrBN+T3WV+rqpX11lzqNnwDO1FTCi8TzpwAZPEJIlug+khcnehKb
         NCAg==
X-Forwarded-Encrypted: i=1; AJvYcCXZzI2UbkdeIWwApRx2a5cCq+LVtyYo4XpGzFPzwAiVDIsfmFMEhjIMiFKkZgNXaKDJCTt5yWvlCw+Rjow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/XPGrfgnOPo3rDU3lKris9+0qwCttCHjeBPMCR8Pou55d9Nnw
	yea/6QWyAsW4kxBdw4RwtFBMP2K4R1zZKlxS8DaXmW0eveGvZenDY79M5DDh3m+k2jd40a5zwdM
	cIaOx43mQvElhNoopVVHyAdszi5tvai+W1Tyd
X-Gm-Gg: ASbGncvUwR9BlBWY9VnXc+IvTMu1M13i4ykshspo8Gpz7kUh2GmEE4PzDK1TFZV5K/r
	mxs8nCB4tYD5cJCkhTESmnx+KrVK70fzm5hNsIpFd7kO8oYDgf5tUyZ8W/Y3mavynavOYvWlyOq
	TUB+bQUwB5q+oZWVNMqKsk5zm5TaFkL0IDM7rp9w==
X-Google-Smtp-Source: AGHT+IHSv963W8ikYWbGwimirmIsk9eaaHi5yCAxZ/JCXtjCetmqk3JkOOLzrju0pplqMU7PT3PhsLvj06z62Zev2Rw=
X-Received: by 2002:a2e:b04c:0:b0:309:214a:6b16 with SMTP id
 38308e7fff4ca-30b7918c1b8mr36557541fa.22.1740664713812; Thu, 27 Feb 2025
 05:58:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739790300.git.dvyukov@google.com> <ffd123bb0c73df5cdd3a5807b360bd390983150b.1739790300.git.dvyukov@google.com>
 <32af68b8-4280-4c15-8e5c-be807c282f94@intel.com> <CACT4Y+YmWrEW9m5zxKoD-Hu0TXKWPVAr0_Xe_X9WGtZWH5W1_g@mail.gmail.com>
 <d352ab70-6c13-453b-a018-dcf19d1a9924@intel.com> <CACT4Y+Ynq=21v0gwZxQ2sQhrJHibYoP6QvcfPoGBFYNXjzodDA@mail.gmail.com>
 <CACT4Y+awOeS8aDkCTJbf4DQXui6pGhVadMkU6ukxnNA6ue88pA@mail.gmail.com> <feefc184-d0eb-4eb9-a495-b7ea6774208c@intel.com>
In-Reply-To: <feefc184-d0eb-4eb9-a495-b7ea6774208c@intel.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 27 Feb 2025 14:58:22 +0100
X-Gm-Features: AQ5f1JoOZs8JgxaO4NAIdzeqa-BO80qhF6E8SkuoX5Z8mJ-2hbpyv5seP_SuABo
Message-ID: <CACT4Y+arkwVHQcbcFDZdLuZeJeued4gwxNYXT7rWsVJDsVjj1g@mail.gmail.com>
Subject: Re: [PATCH 1/4] pkeys: add API to switch to permissive pkey register
To: Dave Hansen <dave.hansen@intel.com>
Cc: mathieu.desnoyers@efficios.com, peterz@infradead.org, boqun.feng@gmail.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com, 
	elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Feb 2025 at 18:21, Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/26/25 02:00, Dmitry Vyukov wrote:
> >> We could typedef it to some fake struct. Such a struct can't be passed
> >> to any function accepting an integer type (real pkeys), and any
> >> arithmetic won't work on it.
> > Dave, how should we proceed? Do you think this is a potential misuse
> > worth preventing proactively? If yes, I can send v7.
>
> I don't think it's worth doing anything too weird. Defining some kind of
> special struct would be pretty weird.

Isn't sparse-specific attributes, or address spaces more weird that a
normal C struct?
If you suggest a concrete type I can re-send the series with the
change. But for now I am going to leave it as it is. A fact that a bug
may be introduced does not mean it will be introduced (there is an
infinite set of possible bugs that can be introduced in future, and
generally there is no reliable way to ensure no bugs will be
introduced, or we would have 0 bugs in the kernel :)).

