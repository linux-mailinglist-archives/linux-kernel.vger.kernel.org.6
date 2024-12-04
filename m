Return-Path: <linux-kernel+bounces-430657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346089E3429
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B677528413C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 07:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98EF18C03B;
	Wed,  4 Dec 2024 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z9CpjuPS"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4AD13D281
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 07:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733297718; cv=none; b=P8Q/j//Y0j3m7b+e+POJr/7D/G/aQ134GmDxBL6CP3vsZsPbxims5ncj9qwKf0C+rlKASh2XjS7Vo5JAialqMCSw5IRcYr0mSzonv1EhYaLJzyiwL8+KTtIXZEt0+MJOtiNs3wuX/yg+3gTKzRNXbVWx3FFacRaLDW4ifwEgCU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733297718; c=relaxed/simple;
	bh=vd3MuS91TAivt2JKNjLBePhtBC64xpmWPU6qbD1fzok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=covhPCYC2Hew8vbh+wXcQODvGI0ruJerbEisOIZZCiqRP5jg/j+eJZtVrOtVi9OcRmAZOkeGdPNLs6gpfdtmrpsbfJA2tPClI+0oL/bCSVsuDS+co4N/sw3IowjYCNgNYOPKcknUns/7gD57fLXbxTAaFWYpOYQKoq+zcdcB9ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z9CpjuPS; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cfddb70965so7972701a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 23:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733297715; x=1733902515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kddNz+EPa1yRSBdVL8TYp+khXdU9NBlX6CaYSf/xfE8=;
        b=Z9CpjuPSK9tOXeHm/JdPduYly1TvSVEuP7vbbHUwctK8vfOP0+djrtk996GFM3HnWY
         8GmVOv3M6chuk1oZfVzHsdlK1GoNl99QeSlntoladf70mzsy4wLIoSmh0xZCShnKT0ZM
         GaRKrVgm+MEchPcQ/a+qJtkpUTwXwwXIMZzr2YNgOKSfFIOyqz67wq0FGdKdZlMuWxwq
         52/DHkkfXVqp09srmwCDEa98KkKUEZ/Rjre3DSEKtvwxJ0tl7GtHGSZpTz/Yc/jammfs
         lV2ULWoMN9iawYQLiUAMW5HuOU275VS80uPsyIcEpZHGN0SPO1DXbQvsqwFLZTu9MzcD
         Uv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733297715; x=1733902515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kddNz+EPa1yRSBdVL8TYp+khXdU9NBlX6CaYSf/xfE8=;
        b=jSYGt3WqlUZHIz0sCQEsRGVhrg6Ls4FNfxxoBvIC/3+376onau9YsR3IUsmgSSCxGH
         k9hOBjHHQbMC9CtFtDqHHejdKXava2euIdIQWYGHrhucY4qTkUFzGIgg/m+ebRD2mOEV
         McUq4evzKBl/WvDD0N7rHRKMnxQJ1BHAQ/e3LpX5GNiAYzBAyuBQwpHtt4G9yGBUhsRI
         poPi23JJqJJjg4hjesew544EBMjh4yoMV+SP0Ql4kB9RDmqPx/Tw8g07VyhIYaIpysx8
         ixGCdvnrSoopOQeSavXCuJLtnHzTLkuYOFQ3XqqP2o1XT6GbV71eWLMIG+/24Bv+koVz
         MKHA==
X-Forwarded-Encrypted: i=1; AJvYcCWQHa1kqWdv6Sso1ktOiTcMGDP2P+tHdudKtd8yooKOWZ93nLuHIoAwqLvmtWxQtkChaFPNQsOdgL1jbs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaenSgiQmCbuWi71dyLReIFrTYwkgwZmjBvFh4Fao1N3/H4Bt5
	33bfoDti20JVGv4k+dvM11ETtEe0+V/ATKl/lCXYRGHZGWsMEt/KnEvdbXGyVHFBimdoMT4oVWe
	kMEm61IFFIDT9QNKk42HCNfwaPvE/k/nyC3r3
X-Gm-Gg: ASbGncuQB9rjV0ccOi2Blum/ZfrZb6+XArc+XzOLCqW8BhKQEulsnCfRjuo8YVlQqXQ
	qSRBwxT7U9diDPQ2md0YbLeZmbYrQ2Wtn
X-Google-Smtp-Source: AGHT+IGDQSz5gUQRd/eo6Ne5990PaNCIXEezEaB4NMUB2/vH7XFA+AbXkM/wlka6PaXNoSgonFmvyWU/GLubjA6GZgI=
X-Received: by 2002:a17:906:23e9:b0:a9e:c881:80bd with SMTP id
 a640c23a62f3a-aa5f7ecd26cmr321185466b.37.1733297714956; Tue, 03 Dec 2024
 23:35:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204034946.10794-1-moyuanhao3676@163.com>
In-Reply-To: <20241204034946.10794-1-moyuanhao3676@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Dec 2024 08:35:04 +0100
Message-ID: <CANn89iJPTw6ANRriR1FHhSQ2aMPDP9PepSbm-+Y6S63aYZ1XLA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: Check space before adding MPTCP options
To: MoYuanhao <moyuanhao3676@163.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 5:07=E2=80=AFAM MoYuanhao <moyuanhao3676@163.com> wr=
ote:
>
> Ensure enough space before adding MPTCP options in tcp_syn_options()
> Added a check to verify sufficient remaining space
> before inserting MPTCP options in SYN packets.
> This prevents issues when space is insufficient.
>
> Signed-off-by: MoYuanhao <moyuanhao3676@163.com>
> ---

If this is happening, then this would be a bug, and a Fixes: tag would
be needed.

If this is not yet happening, but would happen in the future, this
patch would hide a bug.

You forgot to CC MPTCP maintainers and reviewers ?

Matthieu Baerts <matttbe@kernel.org> (maintainer:NETWORKING [MPTCP])
Mat Martineau <martineau@kernel.org> (maintainer:NETWORKING [MPTCP])
Geliang Tang <geliang@kernel.org> (reviewer:NETWORKING [MPTCP])

In my  opinion, we should pass @remaining to mptcp_syn_options()
arguments to avoid side effects.

