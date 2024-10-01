Return-Path: <linux-kernel+bounces-346046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B18098BEB1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2B9CB26037
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432951C8FDA;
	Tue,  1 Oct 2024 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="adxnIP51"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF821C8FA9
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791054; cv=none; b=a4jKHySPtM/LxexUzwpqU67jlF+if7m28tExptCugjyphIzYqGMlJGXAHbhUP3w1U87qLHcSWtSotOWuagkP6YsfFnGBlGL8zmAfLi3PA0vZ+S3WFldc5HynfqsgYBcT59oGLlH21B3OveLiGclqsg7yrsJGWBIg02MrhY4uv8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791054; c=relaxed/simple;
	bh=kbeMyH20yu/HB+84V17P6+iZmFN0TGAPl8/hBHDRb+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/Py50v9LydtEKfnqeuzfT4BkagyqafZDUcoMy73nwCmZiGIZBgFZImEVC03G7LAKWqxUYG/cVjBU3G+Guj5fFuD9HSuWVB1qwMQEis4RADvgbCirS+D8V+MWCZFA53uf8bN1uSL1U7kSn9Ho3mTBp470bjTMEOIF8cfR1JVQm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=adxnIP51; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-207115e3056so48700405ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 06:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727791052; x=1728395852; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tm1ppOKwkqYM3Q0iCzaY7eJ6v95Qi/bldW5pozjAkbM=;
        b=adxnIP51dohPs9muyVn86aQt4776GpQwDV39aGeAvbczyVTGwDlhYkNgjZDiARNtwL
         iuDgPebsQYHBulJrMb+UTrX1haQijeruNjBFigExpGbq4zCxIy/TKV4yrrpISxtUUDnW
         YTeMqXvhV7iGysR4KBCoDFE9GenRatw1G/pGRSN77w7VXKCd8JmfpAeGZjhAq6AD+E0H
         osp677vzAyMgMqdT4amk7C6xRqxW1vWn6iHkPnuC5433svnE/cp1Jw/FiFhn7PQo8Qkp
         mIXwt/3LZ2TBXURnEPWv3a4n27QtWD984d80Rma/ZGCwM3BfhFf8GxceJF8F36aZ/svW
         hVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727791052; x=1728395852;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tm1ppOKwkqYM3Q0iCzaY7eJ6v95Qi/bldW5pozjAkbM=;
        b=S3P1fL+wvjH86UbWgjZShgKU2a0ZJkAIPoqDGHlYxdliEvu19reuqYwvmqu9bivN0o
         5kjcvO7eypVmhBrVyO4kVAJdtF3CNqyq/VR0jnWPJapb4SSNrBBbzilgDKu2GYyL2qA4
         HzDFMUYNC5vwuq9OcpMvvrlrTJvhxDoZq6qswJAw0zCqGfMLygmLOLj+8ZU3w9dAANKh
         AR+syuObkSPlnATvsoE8cntFoXOl6IqjE5CpXROodypNkzmo9C7iyQ3h0NHtMARkJl+9
         aGz4Ta7aoD5lCQG9KfSSsDu+bLSi6bSE99vauHFdfvZxOhDC5e6/SnyZKIp1vK09JdIB
         7KLw==
X-Forwarded-Encrypted: i=1; AJvYcCUGTLAOsBSjA7/nJQGlfSiihF+aiEC1te5kv/gEsa0e+oVhyd7ney+KZV+bwo5woYFHVwNeiUAFQWH7srg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS7kiRAVwwTE2JRhz192F+KjwgRV69/5anyhjipA3iyww19h/T
	RwRrOOy7HRS7FyV2YcvUyBi/vME+oVB06V97GTElCkGK3kVd7KkC1YpcJrTfd3tTiw2cSt8TfyB
	pYAI8m5VQ1IWhA882h69pmebOX+AmfB7iR+g8moAEsM1qAZsXhA==
X-Google-Smtp-Source: AGHT+IHCkJ5HYmmE2HvkfNwcrY88DufodS0g2Sb8MmU8/4Za1zW3TU64PRjY6SbRP/Y1DR991Yr7a4S1/3BQxKRqPj8=
X-Received: by 2002:a17:903:1ce:b0:20b:6c3c:d48c with SMTP id
 d9443c01a7336-20b6c3cd8e6mr101872895ad.42.1727791052220; Tue, 01 Oct 2024
 06:57:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925143154.2322926-1-ranxiaokai627@163.com> <20240925143154.2322926-5-ranxiaokai627@163.com>
In-Reply-To: <20240925143154.2322926-5-ranxiaokai627@163.com>
From: Marco Elver <elver@google.com>
Date: Tue, 1 Oct 2024 15:56:55 +0200
Message-ID: <CANpmjNNQUQU-jG6jzwVP-4_VBO0w8PVgA137pS72unhFc1k6hg@mail.gmail.com>
Subject: Re: [PATCH 4/4] kcsan, debugfs: avoid updating white/blacklist with
 the same value
To: ran xiaokai <ranxiaokai627@163.com>
Cc: tglx@linutronix.de, dvyukov@google.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Ran Xiaokai <ran.xiaokai@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Sept 2024 at 16:32, ran xiaokai <ranxiaokai627@163.com> wrote:
>
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>
> When userspace passes a same white/blacklist value as it for now,
> the update is actually not necessary.
>
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> ---
>  kernel/kcsan/debugfs.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
> index d5e624c37125..6b05115d5b73 100644
> --- a/kernel/kcsan/debugfs.c
> +++ b/kernel/kcsan/debugfs.c
> @@ -142,6 +142,9 @@ static ssize_t set_report_filterlist_whitelist(bool whitelist)
>         old_list = rcu_dereference_protected(rp_flist,
>                                            lockdep_is_held(&rp_flist_mutex));
>
> +       if (old_list->whitelist == whitelist)
> +               goto out;

Why is this in this patch? It seems like it could just be in the previous one.

