Return-Path: <linux-kernel+bounces-409227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD839C8934
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0497A284A64
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36A71F9424;
	Thu, 14 Nov 2024 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQc5LURl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF9518C02F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731584811; cv=none; b=C1yz4HeJD/aH+fupJJmKw0IZ/sjyhHTwy+zlfu3sdDN5QlHLizzpb6IRg+UkZDpg/b/B2NRS6nZ/w78IusmYSwQbIoa6RDD44vyFrRn+57xuvHh8eC22TexUENxUFWQ49Bg7/fMH+U8R7g0kZz7hkn8iPB/oR5WtHn3YXBHYae0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731584811; c=relaxed/simple;
	bh=7ZyLogsyw0JvegtvsA9lmpsM17jAsYAfH2uhNPnrrmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XFDbTDkdm1REf5Q8TvWZdbekxz56+ruMa0NkAF+VJ1bej1fK7CtiK7z1qSCNffDOs26l4mEkObsaVBmB/K8ZfeX7ufqICcAAt8Y4pfuxSfDNKe4vqjYh8d7m09M/3+uqz2m8J7xY7aHMkqv/VgEw3NcIbKrEa5VDy1AYCE2mO5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQc5LURl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6161C4CED8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731584810;
	bh=7ZyLogsyw0JvegtvsA9lmpsM17jAsYAfH2uhNPnrrmc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uQc5LURltDkoVym5Jv1SkNSYPAWBvNd8Q8QD7nZBIUV9H11WfMiNLSf2aTxQsNins
	 ixt3CvkM9etBvsB71n/Pvlm6zPmL6luZHCYhgAn0Yr5pHtAqUdF5AezdpW6KwLpT3x
	 KbGm80H5IO62Th7WzLzsuvMsd2ag976DiugxNQe/OrRt1d0nEMhYMUKz1NYBJ3H58R
	 ugxoKTzv7F7WY7oxStUTSMQLNz+g37YWoDOEh6TWM1QoZhMq7mlaPv7RH8Mo2EA3n3
	 WXBGaV1VpijH8uk8yXHE6olSOdfj3jGgArlI3VBepsDN7ATWPtmaECVW+a0fcXnbFX
	 v81Rf5DNjh+qQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9acafdb745so101355766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 03:46:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUQNsukzJQO1o08jjbh4bd9asD50COuRlIfjU50RMqIEU2tX/+awv8+oP8iKwtpEziBiDx63orEERseMpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVEnASV9uUPDCkx+OD1CG5ER52HVUqyCjGxj7OjFwLGUaEVtT8
	u+kPq6jpq6KCf6ngzgeDf5554HCd0y+PXr68jls8B4Hxa24pzQpUsH4Q2D9UXh9YVJF0GZfJ57J
	fmRSz3w6/YlY72bIlcdJSFG+eRcY=
X-Google-Smtp-Source: AGHT+IFoq16vJdJosJE7KEK4GHjO6MRlcOMXZwElMAdWC4/i1W3KJbln9rZ+5E1RZJ1W9uq6wZO5N7zhEo+u9zqkDSQ=
X-Received: by 2002:a17:907:26c6:b0:a99:ffa9:a27 with SMTP id
 a640c23a62f3a-aa2078160e8mr253884766b.26.1731584809308; Thu, 14 Nov 2024
 03:46:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108091545.4182229-1-chenhuacai@loongson.cn>
 <20241108091545.4182229-2-chenhuacai@loongson.cn> <20241114102136.X-knc36J@linutronix.de>
In-Reply-To: <20241114102136.X-knc36J@linutronix.de>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 14 Nov 2024 19:46:39 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6vTBwi+t8cPKSo44KZKYj8ubwv2vV4FHrNH+nG=_ZXnw@mail.gmail.com>
Message-ID: <CAAhV-H6vTBwi+t8cPKSo44KZKYj8ubwv2vV4FHrNH+nG=_ZXnw@mail.gmail.com>
Subject: Re: [PATCH 1/3] LoongArch: Reduce min_delta for the arch clockevent device
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-rt-devel@lists.linux.dev, Guo Ren <guoren@kernel.org>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Sebastian,

On Thu, Nov 14, 2024 at 6:21=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-11-08 17:15:43 [+0800], Huacai Chen wrote:
> > Now the min_delta is 0x600 (1536) for LoongArch's constant clockevent
> > device. For a 100MHz hardware timer this means ~15us. This is a little
> > big, especially for PREEMPT_RT enabled kernels. So reduce it to 1000
> > (we don't want too small values to affect performance).
>
> So this reduces it to 10us. Is anything lower than that bad performance
> wise?
Maybe I misunderstood the meaning of min_delta, but if I'm correct,
small min_delta may cause more timers to be triggered, because timers
are aligned by the granularity (min_delta). So I think min_delta
affects performance.

And I choose 10us just because I saw latency improvements when I
reduce 15us to 10us, but no more effect when I reduce it to even
lower.

Huacai



>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> Sebastian

