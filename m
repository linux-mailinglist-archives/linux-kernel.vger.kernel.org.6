Return-Path: <linux-kernel+bounces-353095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0F999287B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 11:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78FF2281093
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03FF199FA6;
	Mon,  7 Oct 2024 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nX7MjX+P"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D9617F4F7
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 09:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728294320; cv=none; b=uzh95gf9Zj0aiK812EbPcmUYiv3K+F8w1FDV3uGksbPV1rkHOZcRdR2NNYULiHNHKqRFmqm5RkW9ZIvvVkjhT4tDX2pvSimW/pGWEUn+DAJ+HURJvk6RySztMzwuwR6ED/lci8vnV2uExHuMtQkOqW5QtekqhimnXeNDJvgcl+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728294320; c=relaxed/simple;
	bh=MnG2N7VvARVq+0aNV9losgWOxe1ttCIfTjxliaYMTs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XleSqbebRlAXUlkMEEBGijZRnEcunACRgG60WWCZYvLCZZPopyeTYdjPBCWbouNMa5FMdlT/lOWQg68IYOnXGBvOT9gqrUzqiwmz54Ss8C3LVCN5OxAzuj9kuVrghFkdmdixHSy3oaV/aNqske7EkO/Bs0Prk0X0cStXDff6U2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nX7MjX+P; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6db20e22c85so32873927b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 02:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728294318; x=1728899118; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QlDenJKMzn1mWNc28sIH9DX690Fdx6nnZTrxb+PVbi0=;
        b=nX7MjX+PXaL9MtIUMKbGP3rdC1N+kiludfeVpjKW+AGqwn4KcDyDFyJC9LukJIpmQ/
         aTAehl3h3y7sL5j1B7PBpgosG4Z6aWH7ZG4q0Ta72jtxowrcJOQ/3/5ib+tzLGVCOebu
         feIxeB9p9yCcQS3hTVSHN2w1dJoSC8mLSrVzpqtcRSDsG4lyVvRLhhun5Kio4vjN+jSo
         nbeiTe6gXvD383x8nnQFGrabLby/eCuhh452naQr8Y0PJARtNFlsx/QrVcZrlPzyBfmX
         5x85zOSrFC+Er6NRbPEm5mlj2H9BefnvQh36LKwR9SodvDUQEvWRTIzCnRPGlkuz96nI
         bTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728294318; x=1728899118;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QlDenJKMzn1mWNc28sIH9DX690Fdx6nnZTrxb+PVbi0=;
        b=AxaKPuxeW/A2SuroBCnvyAEi7MFQBygUtrKSFdsH54CbGlYPPsbDY76K6EfM9CNioq
         J4LpTsgPusZUkJ09z8giOZETT45OI3y0di0AUoNWvKrFcdC00VOvxg1JK6ill5qdS5j1
         KbyTxnDFPAeVrCOxZ5KOlWJE4NU832YyYimKv0LLxv5zne4UyLfPFTzoFWvJY3hQrRni
         uJW1vO+4fQXff15gcW//40/d1H+x0HjXxktqEUbLbE0Mbi5X8wXbFmD+Kl+j4M1flt5C
         ncLZkNJPgaeejsU+r1kqjDPmunV2Ftpv3GT4TG4znLK0sm1SZdt+vdrHsVTd8KXtm6Eb
         jNaw==
X-Gm-Message-State: AOJu0Yy8vDAWyrw6o1r2fk0nf+o9Kl5eoHKoO7w9MymG4cbuZeYEbTcU
	G77xj2nUJM5ZgV4USZ3AJFq9zKu5KhuiVsvX/IwbWpysMN35qhYtYzFa18ha8HBuHgYyP+xEET5
	D7eNHFf6rV7mrHNdhqeTUqb/85c01JIlr
X-Google-Smtp-Source: AGHT+IExcomR+N4IAFWP1PJn5kk5uXuKQspNxUZ1d5mN/2UOH/iiIZfkPiLx2XTHLkJmWIJi1t6xRt+M5RCfS4mlaKw=
X-Received: by 2002:a05:690c:ec5:b0:6e2:c5d:4eda with SMTP id
 00721157ae682-6e2c6fdd2e7mr85640457b3.1.1728294317813; Mon, 07 Oct 2024
 02:45:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006213530.335087-1-luca.boccassi@gmail.com> <20241007055133.GA1333@redhat.com>
In-Reply-To: <20241007055133.GA1333@redhat.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Mon, 7 Oct 2024 10:45:05 +0100
Message-ID: <CAMw=ZnRbGbtA+HtGNv0GCfZveHGbwENK9A9MNvqzGg=5aRmR9A@mail.gmail.com>
Subject: Re: [PATCH v6] pidfd: add ioctl to retrieve pid info
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, christian@brauner.io
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Oct 2024 at 06:51, Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 10/06, luca.boccassi@gmail.com wrote:
> >
> > +#ifdef CONFIG_CGROUPS
> > +     if (request_mask & PIDFD_INFO_CGROUPID) {
> > +             rcu_read_lock();
> > +             struct cgroup *cgrp = task_cgroup(task, pids_cgrp_id);
> > +             if (!cgrp)
> > +                     return -ENODEV;
>
> return without rcu_read_unlock().
>
> And iirc this is against the coding style, "struct cgroup *cgrp" should
> be declared at the start of block.
>
> Oleg.

Whops, thanks, fixed in v7

