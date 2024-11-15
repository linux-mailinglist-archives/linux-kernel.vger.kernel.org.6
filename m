Return-Path: <linux-kernel+bounces-410274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0694A9CD730
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 07:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E561F225A9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 06:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A24185B5B;
	Fri, 15 Nov 2024 06:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7X5ZCLA"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C08817BEC5
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 06:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731652734; cv=none; b=om1Bh+PdvTYDY4xRzo+/nt+M17MkPq+4Yye4UQv/bvOW4kD+WIrMAYDlN7WF9LiNySzt2IxImkopO2OyW8j0YRa4qaPQfosqoKE0Sbt13zzWiQAWJfTxTzdzMeXok0j0rIl6QnQcp6kLc+0AyM7+1UObN/rJqLo5D184A/tXw6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731652734; c=relaxed/simple;
	bh=ZeWryhIAPEAd274GWiRj2SxvjKD/sJo0720ArcqeGBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDNbJXJucmBH58EjGLNYF8pDE8raNLEFCmwXu6+KCnky9miCfHFJlC82oaz7qL9W+rGk4f9JBkz7T5K9723Xd17oP0kxNfq1agdQLHuh6o08EIMesX1A0ArLlhbTHsNYpaFjgUHz971QtR6qFdqEQynfwVqCx4T7OvtcSf1Eat4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7X5ZCLA; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7f71f2b1370so1008381a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 22:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731652732; x=1732257532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56X8BgBkivT5wkK96qVoAkc6Emo/mlq4sGR9REwolaw=;
        b=R7X5ZCLA+ArYEYJGNbmlOSzm401w3lXlMTd1fCUVzeT+mR1sdIwJhzlPylFC5QwPyr
         mnXkJhP/CFRiKb9BJvPiWOm9PnfGvmcISh98LwBdztwjZ3s96BkpinfK04ZuBypWQjZ4
         MMPRNI85fCBm56vSQgqEErOkOMcr18nOdi6DQFCpX2kX5X9ytjFoKHddKg5XlIPcBnwc
         Q5f606Sb2WeaxK/RMZNVqj3/PdcKslPCUqirRqlge0o+LzOPwjEO5dwx7eSXWUAWHWGE
         BFwEU3ap7VvePnz3jPcPwazYFmSmDm8AmhhM7NumrNeHpgXV5biIhzAmMsLiziSz+c7r
         avXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731652732; x=1732257532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56X8BgBkivT5wkK96qVoAkc6Emo/mlq4sGR9REwolaw=;
        b=QlnoneTR9v/Amtyb7ORcvTggyF4l8uJYyUlltFQyDgckErYX0KetrQKVV1Mi0WyU10
         VcPCWcD1/05Fi5ijPnz54qBtoxPc/9o4MlWZLqn+8mv/LMzRQ3BiJEAPU4v1r9c+0ftG
         WB/+vrNqO42wsp3mR0wN7VpR7yvO/7oxP9u0fcMlByzLz2i4PyVlqx6K5hGxORTpXr1x
         O0fJ7bJMthY6nNXtQxCWbVnhA+nkSSd6MLcsbKZr2ERN6X6vI4Tv5eS1CmRSOcsyxpn7
         wnn0tetuS68ItnYdYh1efqEvQUbiVkhOV84dFjfguyWSQAUdebCDY72G60UQfXzx5Y8n
         +M4A==
X-Forwarded-Encrypted: i=1; AJvYcCURhiBSUSY86zN7I3PnmYFQkdVOEIbxTLNv6Fy60471kxwfNiPjXx1URMUhl0oVs+tgXGW9dxkbEzoUb9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWnyhvFqqTKfZavTzWelbYV6OHhU4QXmtxJR9vt3FJfkoYdO9W
	hVHNFHumYTRN+4/ASttoyTMhYq4jObSFgVq4g/epW/QPCxRQp1nJf7j0OcH0GBOSzqC2AWrNq6r
	JdABE0yc7hNlkluMTXxlMRNTAqzs=
X-Google-Smtp-Source: AGHT+IEHmbCGkxfuYxBbp5w9bJbGzBcjKIH78G3/w4OoaBqCYkg78xiX+9n4CvsR3ySueptW/YWVUMRwTGv0fi/kg50=
X-Received: by 2002:a05:6a21:205:b0:1db:ff57:562b with SMTP id
 adf61e73a8af0-1dc90be4502mr1557905637.31.1731652732323; Thu, 14 Nov 2024
 22:38:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115054936.113567-1-wangyang.guo@intel.com>
In-Reply-To: <20241115054936.113567-1-wangyang.guo@intel.com>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Fri, 15 Nov 2024 14:38:40 +0800
Message-ID: <CAJhGHyBbhJHqAyfQ6x9BSkLdkMr0P5Fqx8T_2XoW-+X1AQobhg@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Reduce expensive locks for unbound workqueue
To: Wangyang Guo <wangyang.guo@intel.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, 
	Tim Chen <tim.c.chen@linux.intel.com>, tianyou.li@intel.com, pan.deng@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 2:00=E2=80=AFPM Wangyang Guo <wangyang.guo@intel.co=
m> wrote:
>
> For unbound workqueue, pwqs usually map to just a few pools. Most of
> the time, pwqs will be linked sequentially to wq->pwqs list by cpu
> index.  Usually, consecutive CPUs have the same workqueue attribute
> (e.g. belong to the same NUMA node). This makes pwqs with the same
> pool cluster together in the pwq list.
>
> Only do lock/unlock if the pool has changed in flush_workqueue_prep_pwqs(=
).
> This reduces the number of expensive lock operations.
>
> The performance data shows this change boosts FIO by 65x in some cases
> when multiple concurrent threads write to xfs mount points with fsync.
>
> FIO Benchmark Details
> - FIO version: v3.35
> - FIO Options: ioengine=3Dlibaio,iodepth=3D64,norandommap=3D1,rw=3Dwrite,
>   size=3D128M,bs=3D4k,fsync=3D1
> - FIO Job Configs: 64 jobs in total writing to 4 mount points (ramdisks
>   formatted as xfs file system).
> - Kernel Codebase: v6.12-rc5
> - Test Platform: Xeon 8380 (2 sockets)
>
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Wangyang Guo <wangyang.guo@intel.com>
> ---
>  kernel/workqueue.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

This is a problem caused by 636b927eba5b("workqueue: Make unbound
workqueues to use per-cpu pool_workqueues").

Before the said commit, there is much less likely that two or more PWQs
in the same WQs share the same pool. After the commit, it becomes a common =
case.

I planned to make the PWQs shared for different CPUs if possible.
But the patch[1] has a problem which is easy to fix.
I will update it if it is needed.

Thanks
Lai

[1] https://lore.kernel.org/lkml/20231227145143.2399-3-jiangshanlai@gmail.c=
om/

