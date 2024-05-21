Return-Path: <linux-kernel+bounces-185307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C10988CB34B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54CCD282E12
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725EA7F7CE;
	Tue, 21 May 2024 18:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EByw0BMn"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C77023775
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 18:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716314780; cv=none; b=IhrSptMn5UcPGNDotVl4La9X6p0YOu/K2zYmgw1uSqGDH2TmWa0ObMj4O9lQ/0O05qxQLE1un6ztodeb/Iih57xm5+A24bYUse1bB7JddbLUpE9qRyt0FPov2F7WE/gtRncDQEyZ8xqkf5oG7ZoUE/LYKl8L4M8RHG2u0Rx/4hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716314780; c=relaxed/simple;
	bh=VESUA081O2BuGOzfM9+GtLIpJVbkrvttt9G2fR8/590=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JoOA8p0ws1Zx8N++dS1fvFP8lc33700DyT5cQ5H7Ym4YDoO4cXtIdg3yOFGG2cC78FNtgOeRskeaD42l01HQGqpPfnlprU+BoC3Ni/1zaY35lJHhvz5eqbGZc+fCmI01rUtdPUgU0wsatuscs7r016np5jdQbOde+apSJ37+81s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EByw0BMn; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e724bc466fso32294941fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716314776; x=1716919576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=whlt1Bnhny8LtS/uyW4M7JjDCz3FGkigD6pudiqezR8=;
        b=EByw0BMnti4DbVy/XjlPhtW1y5PFzSQmqbUj9oz1k0/7IeeqwNAl1VlixzNZ9pypw/
         SOBkVQrrcRAc153776SPCK0i9U6FBOGFUoZVWHZcQw6WfH+majyey69VlZiLKiazTOC7
         8A6Qs+gFbLeTGXH6GRTVUXDdLQ4/sFJ4rtV3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716314776; x=1716919576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=whlt1Bnhny8LtS/uyW4M7JjDCz3FGkigD6pudiqezR8=;
        b=I7H5y0n9CI5RTf13hDZjhH2Zl4uT5nb78zT7tY5unFMNQp3Sb0BxsakNEmX4jEPc2k
         SRnViT6ezz4UYs/Gdw6CrGSKoYXSevyvXRxU9tFX/RodkQCjyFFhsLg9S8RtEiD6skJG
         41NrUwy28pO0QE4os02vrBC/wjFrT9WGah2G7Sp+rV6xCihNwLpMbuodTcuOMTRO31zx
         9IdpDb6UoR4VhwUG0fG8bGdfNTB1dW4fUA9ojZWjmTnlD1kr1MUV/kv3V8BvJoNKdVZW
         vowrHzs3vjvc79VIfjMeRjEzjW1mpPkpZWrj6Ho/fuzdhaItG8FwOwZ2/XkDQ9iaW7Bg
         Af8A==
X-Forwarded-Encrypted: i=1; AJvYcCWmG+tgXCtHveE6Lt4pA79CVtuuYWGcbKX1sfyKPrn5yf8hjaYrEgGQbSEu8nrWxBcwm98GTKTYcCdpVAIjicR2gvdXqp0Gqr5p72NO
X-Gm-Message-State: AOJu0YzZ1sx7Z2Mk6+DYfsHkVz9J7wXUQN44LUdCj8lZ78zWwkbjdepr
	iEHuTHPBssgKM1XXDHmFjlzSjPiAS4FfHeS4EKd1fLw2KkLyQi7I2v3zWYbDaIljy4UfJwIqn/G
	q6nJABA==
X-Google-Smtp-Source: AGHT+IHgFvZM2Kj8lhUGjYeWTyiZK14gk4MWVonD9DpDMZ2u7yd+90saBdwFfV7MN++InMaicQca/A==
X-Received: by 2002:a2e:751:0:b0:2e6:8b17:ca10 with SMTP id 38308e7fff4ca-2e68b17cd3bmr216526811fa.13.1716314776496;
        Tue, 21 May 2024 11:06:16 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e4d0ce27d9sm37312001fa.40.2024.05.21.11.06.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 11:06:15 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51f71e4970bso6879214e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:06:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUh3xjrF3NPq/H3qxeL+dlPHlwdTxYANPCRvBfpnLnN3YgZ2GJkeRWFOQ4D3+QRtXut7s7lHvqzQ1LAFYAVj+piJxZuJIObpri2Qhvk
X-Received: by 2002:ac2:494d:0:b0:51b:4df3:540e with SMTP id
 2adb3069b0e04-52210277cfamr27576548e87.65.1716314775318; Tue, 21 May 2024
 11:06:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <o89373n4-3oq5-25qr-op7n-55p9657r96o8@vanv.qr> <CAHk-=wjxdtkFMB8BPYpU3JedjAsva3XXuzwxtzKoMwQ2e8zRzw@mail.gmail.com>
 <ZkvO-h7AsWnj4gaZ@slm.duckdns.org> <CALOAHbCYpV1ubO3Z3hjMWCQnSmGd9-KYARY29p9OnZxMhXKs4g@mail.gmail.com>
In-Reply-To: <CALOAHbCYpV1ubO3Z3hjMWCQnSmGd9-KYARY29p9OnZxMhXKs4g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 21 May 2024 11:05:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj9gFa31JiMhwN6aw7gtwpkbAJ76fYvT5wLL_tMfRF77g@mail.gmail.com>
Message-ID: <CAHk-=wj9gFa31JiMhwN6aw7gtwpkbAJ76fYvT5wLL_tMfRF77g@mail.gmail.com>
Subject: Re: [PATCH workqueue/for-6.10-fixes] workqueue: Refactor worker ID
 formatting and make wq_worker_comm() use full ID string
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Jan Engelhardt <jengelh@inai.de>, Craig Small <csmall@enc.com.au>, 
	linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 May 2024 at 19:34, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> We discussed extending it to 24 characters several years ago [0], but
> some userspace tools might break.

Well, the fact that we already expose names longer than 16 bytes in
/proc means that at least *that* side of it could use an extended
comm[] array.

Yes, some other interfaces might want to still use a 16-byte limit as
the length for the buffers they use (tracing?) but I suspect we could
make the comm[] array easily bigger.

But what I suspect we should do *first* is to try to get rid of a lot
of the "current->comm" users. One of the most common uses is purely
for printing, and we could actually just add a new '%p' pointer for
printing the current name. That would allow our vsprintf() code to not
just use tsk->comm, but to use the full_name for threads etc.

So instead of

   printf("%s ..", tsk->comm..);

we could have something like

   printf("%pc ..", tsk);

to print the name of the task.

That would get rid of a lot of the bare ->comm[] uses, and then the
rest should probably use proper wrappers for copying the data (ie
using 'get_task_comm()' etc).

That would not only pick up the better names for printk and oopses, it
would also make future cleanups simpler (for example, I'd love to get
rid of the 'comm' name entirely, and replace it with 'exe_name[24]'
and have the compiler just notice when somebody is trying to access
'comm' directly).

            Linus

