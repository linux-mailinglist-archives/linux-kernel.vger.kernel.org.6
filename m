Return-Path: <linux-kernel+bounces-529188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6E7A420E3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 709B3177043
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1F7248866;
	Mon, 24 Feb 2025 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I8XqustC"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720B2243369
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404090; cv=none; b=JwSz/eymOyXE0mgpwWXQyq4YWfWG46x9pYF0QK82nTqLuXquinSladU1g/u0fkOUJdV3e+MUkxI6EN+TMJPI8XEyVtGjdKPAQM1bv1BNv04wPPIDcPErYc7zCkYeKDfg4z8cp0tdtqTNNd1tbs9Pgl1TIZkvFT7rySN4d/jiQiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404090; c=relaxed/simple;
	bh=Rhn6rcgt+b2Y3xo+dMBgT8jo3ndrhfJFJmmDekEusn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qx3ZqiK7Jn0o2v9tQ2O8CJwpdBGVspMIwPXH2axEUGJF2ko5pwyr6Y7WTgPj2Y9yEoB8IndTrKHZA1ilJZnxhlMMiTjB3g+FPMfVEaYJUjhd1TxgDszUWkVdw6mO7T3NSNQvZo2Nf1KYmwekh7qDY6/33GMBKPCuYlEjrGoS3k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I8XqustC; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e04064af07so6478746a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740404087; x=1741008887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0nBUXsQGkf00giLwEkCMdEpFzz3LUSyvHbOWZAiBTk=;
        b=I8XqustCX0CdIoKOy7toicpEtxlb08AyLTU5u+tHPnzczGmHUrxcbN28LKw2uqwGOR
         grDbwXxclM81yn4yw04OS0ZC792TaPrqCjf0ElUCt5vxLoOBi1bSIgWjVR7iVv1LqTpW
         9oPJWZOaKPNU/HssKOYaO53VRtgaUn9Ms/fsnPbHc35gly5rcXao1RncyBNDIWFSZ/lq
         tpYVzf5jt30mySRPTIcPlqv+6f4Q1+K5Jidc5aDloErN/Q/q7QGbQctvONz/+8POH9vQ
         tcn+xi9xGRhAUq6IohIu9heO/2nWNvYuDtAuRNn4U2oTGdC7IxEKh5lXdt7V2YWZ/Dmv
         BUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740404087; x=1741008887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0nBUXsQGkf00giLwEkCMdEpFzz3LUSyvHbOWZAiBTk=;
        b=Xd/FJA6ZQhk6gkoFiTV320mxWE/TEiVwzr9QL1SIEp9ZSX2aTkBIaeyLZi7z7/4Y74
         po9J+2MzCqz9HuqU/ZwDkjSBARGo7ecYKvBcCWBuXJwyDxwwgzyJ/a32Whlrw+ivczCP
         /L3uD1KpdtWEU1OOJIshkdwWjO8+Tlm272XPU8+jgcuSmtRQLAPTdXiaVbaElui7gDvb
         7JTQSHmR7uyrlLbrpT93MxP5cnorWUOc8M6UFuKXP2rBCYDasV6FrSfyjr9pETlv6I6M
         H6o91CLEIQ2Z9k7ra1ECDvY/6KPgpwioQwLQffBpZ7+r9bsigE9g2Y9Je3FTZs7XTeV3
         zLgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU9140XHfEZ585u7ynUR17msVKHLpf/00ry/ai95nr6r+/VHu65jmQdGAEILHf3MhUJInbM/wUMP7M3d0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtWVOxNEnlfAkyqavciw88X5cXKMgPBAJLDJ9pnsY2VBFCkcb0
	2HDGMpeKRuQuso12zuDOKYMg+jtzV2VDi22A+G0vltEwg2lAwvyEmINWBGodNkD5kMl0tTIUaqs
	Aai1YcNqCrWIr9GFlFFQgiecFxPJZj1Whe/70
X-Gm-Gg: ASbGncuFCA6Y+RRlRrTj2CVjRHv8IrISkbqF6Q+L/OPf9x88OdKSn8Il3LbExsgPMcW
	/AscmY2RwYQu2FqqowLmwfuha8gP58EFsJM5vIS1nWhN0YI1p091rWB6GsJQ5lbaxJQ2lBOxFGH
	Py1arVNw==
X-Google-Smtp-Source: AGHT+IHLeIgPiK1T+sBGjXl7ekMle7VFzxQcJeViGUndm3MTzCMhEw8rC+f/H5pUGcU7eWhtEvHiLutAQjKVaI73a7E=
X-Received: by 2002:a05:6402:4313:b0:5de:4b81:d3fd with SMTP id
 4fb4d7f45d1cf-5e0b70fa0efmr12585805a12.13.1740404086583; Mon, 24 Feb 2025
 05:34:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224095736.145530367@linutronix.de> <20250224101343.344168498@linutronix.de>
 <20250224132047.GA34233@noisy.programming.kicks-ass.net>
In-Reply-To: <20250224132047.GA34233@noisy.programming.kicks-ass.net>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Feb 2025 14:34:35 +0100
X-Gm-Features: AWEUYZlVPW1EZJ-9YsNre8ClJxyG7fwanNIhS16_oDsNW6z9SM6kpPItyvJCaz0
Message-ID: <CANn89i+6HRUtHchZ9s94ORw=B+CZ2KSU6--M6Tszsb6F0M2Sdg@mail.gmail.com>
Subject: Re: [patch 06/11] posix-timers: Make signal_struct::next_posix_timer_id
 an atomic_t
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Benjamin Segall <bsegall@google.com>, Andrey Vagin <avagin@openvz.org>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 2:20=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Feb 24, 2025 at 11:15:32AM +0100, Thomas Gleixner wrote:
>
> > +             unsigned int id =3D (atomic_inc_return(&sig->next_posix_t=
imer_id) - 1) & INT_MAX;
>
> How about:
>
>         unsigned int id =3D atomic_fetch_inc(&sig->next_posix_timer_id) &=
 INT_MAX;

NIce, it seems few calls in net trees could use this as well.

