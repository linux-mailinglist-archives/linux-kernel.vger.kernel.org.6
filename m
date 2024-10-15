Return-Path: <linux-kernel+bounces-365306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EE699E039
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95D87B213A1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C943C1C75F9;
	Tue, 15 Oct 2024 08:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rgwLWW8o"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B291AB538
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979426; cv=none; b=KRpn9CC67OrwrIZOE1opUVrKdeTXcm+jeegDq9Nv0cIlWkYDfw31nK/1XogUnUuzufsbsLes7xEVkydJjq2hooInvYQR8r8geMaEYCXaROeQcmjnftKY6XUf1uUptFwpn3fmLirX8hnpRfnds0Ig3vvBpY1MPEEcoC4VSyXmwmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979426; c=relaxed/simple;
	bh=NHIMEX9Rn0CtXiXdTCgdeC8hYKUgOcNh17M5gRhUhQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKt8d78NcocT9phJk7CMUHe56z6O8fTp4exaI2D/W2TXQAC1O7XEVUcFFcs0B38P1Wz7oBRp0YAbGF/QyWMTqLXk7w1BEalhzmqTIhONb2h5CzxH1YSkgfeF/q4tBEls44b5jVcj0OAa2H8MBEDxGHBe3T59lFXUD3g3gsXVs74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rgwLWW8o; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so9650161a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728979422; x=1729584222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHIMEX9Rn0CtXiXdTCgdeC8hYKUgOcNh17M5gRhUhQw=;
        b=rgwLWW8obX5/D8ekbqmJw1RM5yc9mvlc/1EyxnFFQ6VgXEKacO/VQ54EHr2jcyYGPg
         jhTO04zx8dgl6R35At0FQL42YsFhXLg3DPMhsXvvPw5L8jyD5qaB66Vo0LOzc8MwX838
         VSZjf5K21HGquS5YFsD1eumsRNGkBlE3Fmi9fyDx3+E8oyXV83YH06d/6YOOCdpAKBoH
         YLxW5uyO+hyRMi1r+XhRkzUL2mpaHy+8CcsxSFYSm+J2s/rzBx/6Wf4LfjfP0pMAKXnm
         xnJXSU9bmo8tcskXajmmEiSh7IJzMCbCq+cW1SFrTRn/6yjPZK+y/MD2kFvCR1Dhqm4e
         aSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979422; x=1729584222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHIMEX9Rn0CtXiXdTCgdeC8hYKUgOcNh17M5gRhUhQw=;
        b=me/Ia5f5wsQFD4ZuF4nXiwteI9slPDZFoOD8Irg1clvNmzD5cFxw6LhGG/0KR3Zkgw
         XUJtREN70uII19QqGXE9N3XXABzd2YVY4uvD4AXJ0Rp5ysBiLeTfqNAEEVaib/Q2ml2j
         ZQL6dfZoAd/vjyE+LodQNQDgaNKJSFjEbZkU5Ygrpdo2hYVg4j/Q1F/Tg0W31CPGFAFa
         I1bgoAwVCpDkBmbDx/7ghpRddj55sYlKDPZuTeGyfXAkAjmJB/fiFF7bemlBT3z5uW30
         0i9iGlYfK7wXkMU0GIQU3ZsPcOJlYuBRA+tNczSwG2mWJ2nQkM141lFN3lsPaMfcSJ4C
         y0oQ==
X-Forwarded-Encrypted: i=1; AJvYcCV35q+iOI9acnPfrCkOEn5cXk5EnusZdwo3FCzFxoj43n+idIn+ObNK+C/BjPE9CiI0aKUqbPxDD+tKZuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzugrmhML48nDz/w72Z8qSJtHg57o7+bHmc4fpLISN5/w53FcxY
	pdJBMYhw+9F1pSK1mjQ6fVNYTvVLlyV9C7OweDfHXG4Y6N6kcQ01zcmFHdS/7K1VPls1if0QJcm
	F6cLTFQagdV/RfIBYj21bFNFjDGWwSIZAc8I/
X-Google-Smtp-Source: AGHT+IGGpQl9m9/E1Fr7ZcAYtpdIcEgx/5d5LfRRQXmGVyQQGHN+I462L/CQw6mm0GwAP8S57x1YRqDAEYORq7y/6H0=
X-Received: by 2002:a05:6402:2688:b0:5c8:88f2:adf6 with SMTP id
 4fb4d7f45d1cf-5c94754c124mr13143943a12.13.1728979421740; Tue, 15 Oct 2024
 01:03:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014153808.51894-3-ignat@cloudflare.com> <20241014212328.97507-1-kuniyu@amazon.com>
In-Reply-To: <20241014212328.97507-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:03:30 +0200
Message-ID: <CANn89iLSebTHBz5k8GTS8+qMEn-tv66xanzypBbQBsxtDs69yQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/9] Bluetooth: L2CAP: do not leave dangling
 sk pointer on error in l2cap_sock_create()
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

On Mon, Oct 14, 2024 at 11:23=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Ignat Korchagin <ignat@cloudflare.com>
> Date: Mon, 14 Oct 2024 16:38:01 +0100
> > bt_sock_alloc() allocates the sk object and attaches it to the provided
> > sock object. On error l2cap_sock_alloc() frees the sk object, but the
> > dangling pointer is still attached to the sock object, which may create
> > use-after-free in other code.
> >
> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>
> Checked all bt_sock_alloc() paths and confirmed only rfcomm and l2cap
> need changes.

Reviewed-by: Eric Dumazet <edumazet@google.com>

