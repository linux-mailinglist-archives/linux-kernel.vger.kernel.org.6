Return-Path: <linux-kernel+bounces-301450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7BF95F112
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DAD91C23A48
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4172E194131;
	Mon, 26 Aug 2024 12:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b2BHI53W"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D35D16BE1E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 12:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674319; cv=none; b=BLcJnxkwze7m9xtysIyv/7aEObJQbL3u78BkVIMig41Gs0p9J2VmMhsMl+ZviiLBHZLMPzZJeeIGLWCONYW/jyEl53VOp4o4gzMgTy3O+5fj3EsBvnGfeP/W3tprTYY+CNCK5CLWzn5aGM5RT9zyOXXGFoiTsbRKrkFXA3rDpag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674319; c=relaxed/simple;
	bh=a/fJ1VhUeNud8O1hmpn/0NNZrKXsQ4daBBCWoqGA1B4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gU9+qEQo+An7yHfjxgF+FC1A4cUy//YizsBZMDpWVQbtOb/LnVF4GjPYJnXtcjZA7cMzJv26ObwzIpLemjwXDu1W8QxfUAMDuDQA4dPLqC+9FEkWu6Ros6pPSkZ9bHsrXKDQ4i0gWhIgnvXUhT8ZjrePl+SmXbTKtDrmNjw8464=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b2BHI53W; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5343e75c642so2859892e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 05:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724674315; x=1725279115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/fJ1VhUeNud8O1hmpn/0NNZrKXsQ4daBBCWoqGA1B4=;
        b=b2BHI53WCBOsWZ1aZeyJLgkqArb9915TGPw+rA++1YKl6oxuZ5MAkZSB77L5EeFZ7f
         uJEJPHwFBfhPEIRjLtOwI2EbYGrL4FPCTdD+YKFqThIg54tepYLYC1elMixUnM/ZYeBC
         kdj4Sfj01W7T74eCOyjYonCQnbHPAF4WgpOENaMKUZg67eGy8/wf49IsLyTOHLc1henV
         5CbQ83zOHJCJHqvHcm9ige+EueeL3Tcnlp+r1l8p6uSOA5povSLLwcfZZ6JngWKFsxs+
         Tz0JnKeLUfQ2Co7g0c4QIBXH7qQFAAblhsdTdagax/ZQ7qoQG9ocr9ouFAFLzGj4IXT+
         5Feg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724674315; x=1725279115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/fJ1VhUeNud8O1hmpn/0NNZrKXsQ4daBBCWoqGA1B4=;
        b=RPg0QxWPlc5wWa/FEBotV7gqjwHUKcLkE/UIhvz3DcdJUmy6fiMfdlb92tEVLNfwuU
         P8+FTzR6yyMnhWHI9JgVBTYuKFXH2QGhX4xDsXLC0tviMSchF26nfWOdxd2RaIrlste4
         0riXt6rVU4pRUXlBBH+Uew5Ligt1cRdUjwEqePZKNnJcW50e7kDT06s84OmRP5HwN3cK
         qM3pNC+4cXdYPK073XCON0pTt4HmIM2UkqaX5GydYuZo97xS4Hu5jD3YsOuG0LenuBDw
         m3aTkgxDymFNFUSFMJqohiVOAUX+0V1TZQzDCYEUdfcfnZpXti3nh8n+HC4Vxzkznbll
         o69w==
X-Forwarded-Encrypted: i=1; AJvYcCUd196AOiI+N7yYHlfeAcYRpUYAnJjsXj/2an4hnRIyZCh+s66ds8PwUTzkdIgar57Ob0HGVXTWqQi+SJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA8Vzwb/f2X9FBAmZuRBU7lXDXeOkaHNU/YJiEunX0R9OyClrh
	A9uM2tGz4oQwVst9L1t2YC830T1JXsPXLO8abeeCc3c30KVrfw8MmegaV8SjDwD+TVI361kPPX4
	BwAjoGGYTDae/mPTrOM/fnE5Es9mbOIG/UEq2
X-Google-Smtp-Source: AGHT+IFeQ08E7GutTBNKbVGUppCfdT90fcFmyhhNHkht0+6YesGTQBnTgu0blP33yoES7E+d4YGyRaK44NLX/lrkb0M=
X-Received: by 2002:a05:6512:ea2:b0:52e:9ebe:7325 with SMTP id
 2adb3069b0e04-5343883b0ffmr6182540e87.31.1724674314497; Mon, 26 Aug 2024
 05:11:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826102327.1461482-1-kuro@kuroa.me>
In-Reply-To: <20240826102327.1461482-1-kuro@kuroa.me>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Aug 2024 14:11:42 +0200
Message-ID: <CANn89iJqQXauMy9mWf7Y5LFNPwtxpfsgpJJtU83OFrzpomYZZQ@mail.gmail.com>
Subject: Re: [PATCH net,v3] tcp: fix forever orphan socket caused by tcp_abort
To: Xueming Feng <kuro@kuroa.me>
Cc: "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Lorenzo Colitti <lorenzo@google.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 12:23=E2=80=AFPM Xueming Feng <kuro@kuroa.me> wrote=
:
>
> We have some problem closing zero-window fin-wait-1 tcp sockets in our
> environment. This patch come from the investigation.
>
> Previously tcp_abort only sends out reset and calls tcp_done when the
> socket is not SOCK_DEAD, aka orphan. For orphan socket, it will only
> purging the write queue, but not close the socket and left it to the
> timer.
>
> While purging the write queue, tp->packets_out and sk->sk_write_queue
> is cleared along the way. However tcp_retransmit_timer have early
> return based on !tp->packets_out and tcp_probe_timer have early
> return based on !sk->sk_write_queue.
>
> This caused ICSK_TIME_RETRANS and ICSK_TIME_PROBE0 not being resched
> and socket not being killed by the timers, converting a zero-windowed
> orphan into a forever orphan.
>
> This patch removes the SOCK_DEAD check in tcp_abort, making it send
> reset to peer and close the socket accordingly. Preventing the
> timer-less orphan from happening.
>
> According to Lorenzo's email in the v1 thread, the check was there to
> prevent force-closing the same socket twice. That situation is handled
> by testing for TCP_CLOSE inside lock, and returning -ENOENT if it is
> already closed.
>
> The -ENOENT code comes from the associate patch Lorenzo made for
> iproute2-ss; link attached below, which also conform to RFC 9293.
>
> At the end of the patch, tcp_write_queue_purge(sk) is removed because it
> was already called in tcp_done_with_error().
>
> p.s. This is the same patch with v2. Resent due to mis-labeled "changes
> requested" on patchwork.kernel.org.
>
> Link: https://patchwork.ozlabs.org/project/netdev/patch/1450773094-7978-3=
-git-send-email-lorenzo@google.com/
> Fixes: c1e64e298b8c ("net: diag: Support destroying TCP sockets.")
> Signed-off-by: Xueming Feng <kuro@kuroa.me>
> Tested-by: Lorenzo Colitti <lorenzo@google.com>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

