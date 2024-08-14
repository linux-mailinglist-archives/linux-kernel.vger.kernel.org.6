Return-Path: <linux-kernel+bounces-286034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21709515A2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EBA41C276A3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 07:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D95513C684;
	Wed, 14 Aug 2024 07:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hf1QrPtF"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386F929CFB
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723620910; cv=none; b=EmfnIsILEy/XSKrgxmoYr1JKBw77BwLYVM3de9yoZ9bn9dxihDXkKaS9rH/mqOLv5BnESosR1M7xYDl5PHCJBRHAMARiq8sGJvnJHhYTq0E10GxYfjymlVwC7WRRSwIWsngiuPOcg5zrYLcSjpNnm8s/1+2Q27Py0G3iF7dtils=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723620910; c=relaxed/simple;
	bh=dn+L6oAUJ8ys/t5tJ3WejzYSbtBeeeBMxySZGq3wZzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=izoTOHuM8BhyOo26qv/7OjA283+dJo/AOKVoF145TCv7PkKl+ZVo5tGipazuK35OOuT6janlQlLuZom5uFDDDaxBDhreQikGFVpUXDbEKZumyFCcDzAKVfxOgo44nF+5Cbkwva1n57Er5+fwEEST7Fs7KA0mZn3mhDKVLk9sB6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hf1QrPtF; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7a8553db90so748756866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 00:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723620907; x=1724225707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYvlbKLns5cdVvpTzIYsdMbPag5YJ/RZP19+Oopz0OQ=;
        b=Hf1QrPtFntJi4a2ZUMCqHkYbjRfgDaYdnELk/ST0tj2n2bhNMiC2yr5OjMKOaQL5Qz
         wz9NJDyR7OyTXR054sl+dzNVWi57GRMfsiVWJVlt+y/7aIoslcijL5hMPF3vlGFuldHf
         S8IEy120eJK+N+qp5PrDKTkQvZv+dfq+ryIuvA7maRF1PjHGngJgrZWxRpVGQ9XgHZ4Z
         hVtnVRAFazpi/aSMClpfP2Xbg1wtlzu6VHGjHNCRNOnRoTU+9ftVhHUHRjuFR0dEJhkE
         YYR80mv/M1ugp1md05ADOa37hJAv59x53GY5bL3t7Jobj4dtWHasTu9cacx5Iktg2ULX
         5D/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723620907; x=1724225707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYvlbKLns5cdVvpTzIYsdMbPag5YJ/RZP19+Oopz0OQ=;
        b=GWKXLrSl48I20trUNFW0fhKhLZSN6FLSUKgC9jETu2cbUxjgU8jvo4cz7dTZD5FyZO
         goHVrXQqV911gCxkRPDV5ELSTNvkOPr4LJo1Syjtocs8O0P5JJNWve8x82ly8sz1Pwm7
         A5YmeyiKS5TJKW/eiU1PkuorqH9qaXil5b0r665pmIKnTGXEKNCGMA6soJEDIRnIi1Aw
         jQyfzKO3zCo7aUhG7lcrPlBXc+hz9i4fb1/JupHhiwwcoBWoUtehVliFQwqd70WzYsPS
         g+rnIaAPnTEntl/uMebRg60SX27gDt7gYNlCHu1ExfTBpau8glG2CUfW89kao9Q6K84n
         F+kA==
X-Forwarded-Encrypted: i=1; AJvYcCVWs5s+pJotISUCT+3o2Os3S3tHzEFGT3jbtZEfhfRjAwLY/8F9RfnAz8M++Q+sr3AcLFtGhlrsjCeu9DE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx57oM5nEpmzwnHmu23kVGPx5Rnjz6aCMXaIDSZiZLcs+ozfR/Y
	SO/pC32vN+O6mbtTmX+IiyUQEh8J5rMuMEpuhbEjnjRJDMyCjQzQOkJDInrh9IxpibhW+TSGpWO
	4Hjp+aQoJQa5b3rNUplR9RWtvd+9atQUbH698
X-Google-Smtp-Source: AGHT+IE/CG/1vgT1Y1n6PG7T2xGjZvOmrCdMCKO7yg5oBdpqAfSoZGVyiIo9FT8otgRh6yvRXfQeu0fk1v0Z/6Ec7BU=
X-Received: by 2002:a17:907:f155:b0:a77:cb7d:f356 with SMTP id
 a640c23a62f3a-a8367087b2amr110481066b.51.1723620907107; Wed, 14 Aug 2024
 00:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812105315.440718-1-kuro@kuroa.me>
In-Reply-To: <20240812105315.440718-1-kuro@kuroa.me>
From: Lorenzo Colitti <lorenzo@google.com>
Date: Wed, 14 Aug 2024 16:34:51 +0900
Message-ID: <CAKD1Yr3i+858zNvSwbuFLiBHS52xhTw5oh6P-sPgRNcMbWEbhw@mail.gmail.com>
Subject: Re: [PATCH net,v2] tcp: fix forever orphan socket caused by tcp_abort
To: Xueming Feng <kuro@kuroa.me>
Cc: "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 7:53=E2=80=AFPM Xueming Feng <kuro@kuroa.me> wrote:
> The -ENOENT code comes from the associate patch Lorenzo made for
> iproute2-ss; link attached below.

ENOENT does seem reasonable. It's the same thing that would happen if
userspace passed in a nonexistent cookie (we have a test for that).
I'd guess this could happen if userspace was trying to destroy a
socket but it lost the race against the process owning a socket
closing it?

>         bh_unlock_sock(sk);
>         local_bh_enable();
> -       tcp_write_queue_purge(sk);

Is this not necessary in any other cases? What if there is
retransmitted data, shouldn't that be cleared?

Other than that, I have run the Android tests on this patch and they
all passed other than the test that checks that closing FIN_WAIT1
sockets can't be closed. That's expected to fail because it checking
that the kernel does not support what you are trying to support. I
uploaded a CL to fix that: https://r.android.com/3217682 .

Tested-By: Lorenzo Colitti <lorenzo@google.com>

