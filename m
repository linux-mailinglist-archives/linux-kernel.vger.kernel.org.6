Return-Path: <linux-kernel+bounces-365309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4745799E040
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4AD2817B3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A72D1C9EDF;
	Tue, 15 Oct 2024 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hnQu98/6"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375E21C57A5
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979464; cv=none; b=X9jfDI22PqJx4SFmfkfL6/PlK9HMfHoeDG6lmiJaY9JROHW8cDKNfMQOlPIGwWIrOmSlUxxAohARXu5w3bOv8h0KhlkmbR9Yv20wTMRsO7FCnYmyb1qpm5U0ugP8VAXuUPpQ9yovRM7/nSPHz4XdFHzW0c3OFDRLEETK4fGZJwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979464; c=relaxed/simple;
	bh=jjdIGCXHtqrrmc4Zac1h6TFtk7ByfeGFj5BklO3jkIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSISC6D+oolz6LBOB04Yeycn9OzM+QihIwXkVRDeeFk0Si54L8qZ5Ts9RcuKLSczTW5mi2WvCRQPtyElDL2vKLCsH8RHWzrZVxE8MCEGNfe5MP5FnBarjrjUSTbGbQXeMQ8p4KhtSrCvxlAWtxfj9XBLZN+kJz9HIkK17Ph+olU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hnQu98/6; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so9651264a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728979461; x=1729584261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjdIGCXHtqrrmc4Zac1h6TFtk7ByfeGFj5BklO3jkIU=;
        b=hnQu98/6K8SfIZ+dZFCoVE4e3xhktR+KfmU5DsMYkyCurs6E//JqSiMA2A789KPzpe
         BG7ka08xP3QYQ4vgIhQNXCzJr+93S2xq9YTll6CfXlktnSbaKnQNn2pFS+nWPyk6k3hG
         Em65NimtywSQ34dbgDVQ/hYVA8K7ugXXPtSboyZyt/qEOQJposkJO5qAAq+4ADq0t7aD
         38EXzUyZEW+4D+SlhNZ5RrnaUzx9JZfl2sV2sHwRK469n8kHWM5TNydQi/z47zkysnI9
         jBea0/FDWp/BL0wVA1b+4b7Yl3pE14YOBqUFiCUKOgYJrjZ7EWJPvaexBhq+diT69fKt
         7/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979461; x=1729584261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjdIGCXHtqrrmc4Zac1h6TFtk7ByfeGFj5BklO3jkIU=;
        b=wIbEfNApfZv/NEGgqX7Mr5nJSJm2WdfzXT9W3Z8nyRg+K8upy5J71OKvJrlDqxqCAW
         /+b+n2kOdZ+n+pQPlbKQr0vbyE9LW3kv1s1vbFMVv7qLmRxey/nKHMmevBVDAyYQWcYA
         GbYWBwfmzLMrRcWlXN0kKC7gso6QJfIOzX7470zy3kHduyq50Y/9cLqsUr18e0FULQKW
         Fzo/isqAElo6KUbAdFITCJDaDuq6RRLIKql0X25Pz/dSrQDcUkR+cQhK8gUY89pxVZRT
         Hg8QjhH9fneuRp0schKg8j87WEjtGj9UwX6RoLGVr2KUUAOVzxhzDIrGLLORr5gQQ5CN
         +htQ==
X-Forwarded-Encrypted: i=1; AJvYcCV68KoSLpGcqOSWBq15oUJi6UZsrTUW2tmxMEM41Ty/OqqyYKnA9rGmZIaEUlvrMUFuKBoN3tet9d/vEJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGYoyWDeY+zQ/GZl+pnyKOjV7r5oWGObq/7PB3Pfr952pHO8m6
	e9/gXGW4cD/f24bkJjVizX3Cu9y+nwgZkwo1E+RyTrr1bl+JvUWT39MNXKcaEjBEoSFv6ghaofH
	4WsUUi+74qrNvoMdlWSHez/GjsnpnBaEASZwG
X-Google-Smtp-Source: AGHT+IFVLMYXDjozz3EMts1UX9Vb6aOFr9R871a4tPL9AtIGRY0LFuArOfvBuHL22PThUNhjYOA3RaMjZm6fTzoit6o=
X-Received: by 2002:a05:6402:1ed0:b0:5c9:87a3:628f with SMTP id
 4fb4d7f45d1cf-5c987a3637dmr2709862a12.10.1728979461246; Tue, 15 Oct 2024
 01:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014153808.51894-4-ignat@cloudflare.com> <20241014212956.98604-1-kuniyu@amazon.com>
In-Reply-To: <20241014212956.98604-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:04:10 +0200
Message-ID: <CANn89iL7tdEr6_gpQCsLncNW4d2NonTVR0pTgxY4-O556ZQiJg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/9] Bluetooth: RFCOMM: avoid leaving dangling
 sk pointer in rfcomm_sock_alloc()
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: ignat@cloudflare.com, alex.aring@gmail.com, alibuda@linux.alibaba.com, 
	davem@davemloft.net, dsahern@kernel.org, johan.hedberg@gmail.com, 
	kernel-team@cloudflare.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	miquel.raynal@bootlin.com, mkl@pengutronix.de, netdev@vger.kernel.org, 
	pabeni@redhat.com, socketcan@hartkopp.net, stefan@datenfreihafen.org, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:30=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Ignat Korchagin <ignat@cloudflare.com>
> Date: Mon, 14 Oct 2024 16:38:02 +0100
> > bt_sock_alloc() attaches allocated sk object to the provided sock objec=
t.
> > If rfcomm_dlc_alloc() fails, we release the sk object, but leave the
> > dangling pointer in the sock object, which may cause use-after-free.
> >
> > Fix this by swapping calls to bt_sock_alloc() and rfcomm_dlc_alloc().
> >
> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

