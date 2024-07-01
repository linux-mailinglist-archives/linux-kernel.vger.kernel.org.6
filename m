Return-Path: <linux-kernel+bounces-235535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3452091D64E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 04:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4694B20DD7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 02:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB43C8C7;
	Mon,  1 Jul 2024 02:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILuBuc8E"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FD3B674
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 02:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719802307; cv=none; b=cw8Q+/j+WZJPDp0S9x2rB8ZKJAU86sFytcIZaqLWWrWV/6o9iLC1hxH8GytJaz+G0y3cLNjKqQ/B4h8jzg8qN0oMW43YqHkY7I5tRtxGSHiyenALs9NXBWxV/Die5dHebq6sanmP66Ry7w0MWK5hhhRp8fakIrXy34jonI4/iM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719802307; c=relaxed/simple;
	bh=xQBKwuHTZDkOLyXcoPralgpNTJ2EI3xxl7Tj0G/Albc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuWk+APG0x0TJc5FP/3umvzBG8amVrB2gj67jzwrSAkbgDf5fTCvd9c/tYTUJQs5ATWf5O7vgsAYyKkI3My0mqxBp3AUwhydd2SZnnAmmvtEIoAoCxeBEpSqerBzv16gtkB5n/24NMqzBPvx+6UlXIazaghNhI7DVEj40edwhQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILuBuc8E; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d5d7fa3485so1793646b6e.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 19:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719802304; x=1720407104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V39eAx4kANWlVQNdFUZ9TVyUf31mvbQKiJoxQmRftzQ=;
        b=ILuBuc8Ern8mY+DhaAyiuBRQ1PNWaPDwy9WpUgqEQ5Zixc4ZXLbw5G5oTlJC9MNXoQ
         cGUHrsO8wb5m3z+h93q6hXgnjhzP72sMExlzEdm8oIaKcMCeq3DPUZTlLaA2Ud/pKd0S
         oUx8kVtkvQOQZ9+UKxh5NKqGklb9QQGYZZ+JyB2PrZh82qTMOb0tNWZcQ19nShVRk7y7
         qd20vlgW5osHFux3DUEPI/Jnce8m6ORtyZV4fNFJS3wLYK9wFZKftkw+ZpE1RGvcfnjs
         8HIWmA1m1qYF1aLWuDZyb8i2ZYdd75TaddBp/g2ZSbNmFVeGCgCcXuHz4LNWyH9OQkRS
         NSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719802304; x=1720407104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V39eAx4kANWlVQNdFUZ9TVyUf31mvbQKiJoxQmRftzQ=;
        b=iUx9HAqonJdDYKS1dSbaXt9q3t1oHCYyspRvSfUmK1yFDNGHeVIMvU64dXNvikKXNj
         0WpuTSkG9AFD36Bmua8bw4oCG6PaQUTSNxD9eg6JU2kqlJ3p7F63HjgEsQtOdKEc2n/S
         VnSpNokifxLTfTvJlLUZJ9cdrFd1UYNb50rPDGQZqFLJkVFHfrFyCKDsNoP8La5Sj9Y0
         psBI63F9buVId1lh/r9I5tseaVFtx5Q6F3jaotWDLY7diojz47x0DA8xgLaVesT0vrK3
         ZwqcHphqYueT3HOUhYOQPs2OEUJEBJHVehWAZL2xMxu1dj33HyYrU+BKYeZzw439JaVg
         6FDA==
X-Forwarded-Encrypted: i=1; AJvYcCVv+BxJCPAjYlxwWyGpZTOJufgtScvXGwknBvX0n8Ai2My4ka4ThPBcTQ4bMWZ2GXwdJj62Cg2tcPIzlZTEsSgFvkXbUkp9XAdGc5kw
X-Gm-Message-State: AOJu0Yy9b90UatH1atapYTaUNLtr486PuTgK/Y1DtcTnZiv1yd8M+1Dg
	PAeIMPP7azXPIg2MckkDKqE/V94bnYuNmze4GV4kSQD8use6h8nC29yHiwNpaW/T09+apnq527H
	BMjttj5wCYGwxzH8ilwoLOONQ+ydcb4Eq
X-Google-Smtp-Source: AGHT+IHTVydBI5xXnmjajwu2cozvTf1QqoVrktjE/za9Jnsk9pfxNIviUGX5ls3zf6626o0W/oAUrMMbwMLUyA+W/XI=
X-Received: by 2002:a05:6808:218e:b0:3d5:6446:3407 with SMTP id
 5614622812f47-3d6b4de2f1dmr7542122b6e.47.1719802304593; Sun, 30 Jun 2024
 19:51:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240630222904.627462-1-bvanassche@acm.org> <20240630222904.627462-2-bvanassche@acm.org>
In-Reply-To: <20240630222904.627462-2-bvanassche@acm.org>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Mon, 1 Jul 2024 10:51:32 +0800
Message-ID: <CAJhGHyCsypVP7VgsNKdQ=rn0hqiJOzSS9p_OGio6k-S2idaLtA@mail.gmail.com>
Subject: Re: [PATCH 01/53] workqueue: Introduce the create*_workqueue2() macros
To: Bart Van Assche <bvanassche@acm.org>
Cc: Tejun Heo <tj@kernel.org>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello

On Mon, Jul 1, 2024 at 6:29=E2=80=AFAM Bart Van Assche <bvanassche@acm.org>=
 wrote:

> --- a/include/linux/workqueue.h
> +++ b/include/linux/workqueue.h
> @@ -525,11 +525,20 @@ alloc_workqueue(const char *fmt, unsigned int flags=
, int max_active, ...);
>
>  #define create_workqueue(name)                                         \
>         alloc_workqueue("%s", __WQ_LEGACY | WQ_MEM_RECLAIM, 1, (name))
> +#define create_workqueue2(fmt, args...) \
> +       alloc_workqueue(fmt, __WQ_LEGACY | WQ_MEM_RECLAIM, 1, ##args)
>  #define create_freezable_workqueue(name)                               \
>         alloc_workqueue("%s", __WQ_LEGACY | WQ_FREEZABLE | WQ_UNBOUND | \
>                         WQ_MEM_RECLAIM, 1, (name))

Is there any possible preprocessor hack to avoid the renaming of the functi=
ons?

Thanks
Lai

