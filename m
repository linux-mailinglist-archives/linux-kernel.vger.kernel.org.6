Return-Path: <linux-kernel+bounces-169820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C868BCE09
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BDB3283996
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72062555B;
	Mon,  6 May 2024 12:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="or1DmKL6"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC9E6D1BB
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714998918; cv=none; b=uwzOgVIcBcmUxW9Vu+o3UEn75ddpYlZCNjLtg/uYNGqfmkFEy4ZcScEdJPCrqofFWHCGTyY2eXt0KcEuZctfTZYdOx7WBAhBF8hgom8LlGFCkNQlmH4Y0IJMDYUbZVQBjq87iKa0WNs6uiF02jbxp9+7q+iqAvm65CoJQnWGaNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714998918; c=relaxed/simple;
	bh=8sG8GaqzHZ/COubbDYtb5CUXzzhirAvpp+sqNHF2hRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VAJcc9+muxlp/6UU48jzeXFNTM79BrBpDmuQPbfD6lh31TJWzWL6MVTXuS7NpAxdmiZVtGsBj5fNgoaK0TBQrn9G6T65ckKOXfkCRMeFzkrE9cvH9ScNL0qQ9wg7SwU+nobPJRU5IUA1K0LVSV6WihSEHpawnT8S6YDPYFIpxIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=or1DmKL6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41e79ec20a6so68755e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 05:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714998915; x=1715603715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sG8GaqzHZ/COubbDYtb5CUXzzhirAvpp+sqNHF2hRM=;
        b=or1DmKL6o/3Gx9kFqjyWTIKmwkTyxiiVn8orfLNcWxgIipCJPO/BNfgX5SlTz9Yd/E
         oXmBUNkIGI7qkU28+3LkgRIzpraidwl34B/NKgkZDCiQIecleBBYfyUFnzSfI+v1cwV+
         PQJ+JIvrvenuyiXctt8pjnYRczgast8deEXsvL/q7sc83lzUIwSndqZutbqR35ddHk6L
         BnRSagrnMwIvcOB+mUTqHxWHHZB3Oi0qrohfzyOnoR+XPJumhd5o6wphFVrcmXCV8Rg1
         RKIOWAu9kCozdt6ZFQw64djufitiay3V4RA9bSNsOwnb98sIehPvGzgxF9dZc3M5IR8S
         +ytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714998915; x=1715603715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sG8GaqzHZ/COubbDYtb5CUXzzhirAvpp+sqNHF2hRM=;
        b=rbCzgd/ymXRJKfRE9cmNvdEZVYYEvLs8XjYILAp5RcXdCaJXLFqbSbkmcEMy8gDPM+
         duKLY/odxbsclAXOpNOojh9np2rinoqvEzydH6q4KWUy6/F9g+QVr5z5nNSIX3e4UawZ
         TDGq/IMcy65cESD1OiIM82JcTR9na17hhJYrrYkMWcIxSKlE+RHTARt0fhvvzg4hCeIM
         ygxEfRzrzzbThob9fjHwz7KZk8b/AxzJGfXDdxuPwdOPqRTZ7Bn7jgoQlIbzjfWM81h0
         Vpxvf4odrFhgh66HeRP/eB6u/FfPlIOvVEkqBFoIn+wA0Fb5HGG0WKwlvV1KA+j1t9Ip
         KFTw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ/kaTpN9rw8TdbNqZ5BQclnuqOBiXp36YcQ3hvwxvBnyT8Pm5U662ixQTa2qMCtnkOuKLvk5VHittIrul2Nw+k5cSuYuCDr5bnlAy
X-Gm-Message-State: AOJu0YwA+6xrLqc+vDnolCF/6D5zy/WtvqzxDsvzTYfD2kur5k+scxvP
	bXCqQAYj72Rosc1OlfiE5V2YZtMH17AiZFy/1s/u5fmd6HOtlX/5KAljtq8ITYoDwTnx4XbAGQE
	r9uu6At6CLOr+xFLY/J9WLSTDKCt2dbEvtf1y
X-Google-Smtp-Source: AGHT+IEMMKgFbR+u34icqY5ffdKZJzjIMfq9mD7FSYxMp+5pcTIM3U8+IyeJqA4TUGmmCn1rlruSoSxFhDftbXYhjEI=
X-Received: by 2002:a05:600c:4f51:b0:418:5aaa:7db1 with SMTP id
 5b1f17b1804b1-41e6274d8camr3512355e9.1.1714998914744; Mon, 06 May 2024
 05:35:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506120400.712629-1-horatiu.vultur@microchip.com>
In-Reply-To: <20240506120400.712629-1-horatiu.vultur@microchip.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 6 May 2024 14:35:01 +0200
Message-ID: <CANn89i+SJiOLLy8azt8NqckUkTLqTS3Wu=16vfTrqCFYLKxTPw@mail.gmail.com>
Subject: Re: [PATCH net] net: tcp: Update the type of scaling_ratio
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, soheil@google.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 2:04=E2=80=AFPM Horatiu Vultur
<horatiu.vultur@microchip.com> wrote:
>
> It was noticed the following issue that sometimes the scaling_ratio was
> getting a value of 0, meaning that window space was having a value of 0,
> so then the tcp connection was stopping.
> The reason why the scaling_ratio was getting a value of 0 is because
> when it was calculated, it was truncated from a u64 to a u8. So for
> example if it scaling_ratio was supposed to be 256 it was getting a
> value of 0.
> The fix consists in chaning the type of scaling_ratio from u8 to u16.
>
> Fixes: dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---

This is a wrong patch. We need to fix the root cause instead.

By definition, skb->len / skb->truesize must be < 1

If not, a driver is lying to us and this is quite bad.

Please take a look at the following patch for a real fix.

4ce62d5b2f7aecd4900e7d6115588ad7f9acccca net: usb: ax88179_178a: stop
lying about skb->truesize

