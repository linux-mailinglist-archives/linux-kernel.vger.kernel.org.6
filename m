Return-Path: <linux-kernel+bounces-203816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D80FD8FE0C8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BEF01F26470
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291FF13C683;
	Thu,  6 Jun 2024 08:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JwQI8D1/"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DCD1C6A5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662043; cv=none; b=Qd3PubVpcM2BW1adQiMRieo5FIo4AEI0CYIxBw7hsZoGY8k4ez5QSZUqY1I/kYbWzGEXsRLOe7vcMkQX1LzIqfsCH4jtj57NQWJxQRFG8JOvr+tq1hHEc/urc2wJPZMGcp5YG5AnifBEa6WU3uZ6jsSUIXEQm8ng8zvCtBSPJoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662043; c=relaxed/simple;
	bh=6kI2cdJDpABdMGmQl+txxxVa/ZELbED2IxOHszzsEmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6OGZd6NZ9cusPEFintEwxk+IiQQHg8r8pTTrq8kfg0wzqIRz5tg4f7sNEFM+3JYV5Ya9r9n9aYH8qMxas21i62celRhe76qvoeFZzJHORyDt13S1BOp0xSshALt7r7gLjPG6SsVxu/qVtBwOefbHb+Nxdi91RAhXg+yPEsnD8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JwQI8D1/; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso12997a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717662040; x=1718266840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kI2cdJDpABdMGmQl+txxxVa/ZELbED2IxOHszzsEmk=;
        b=JwQI8D1/KMlpOJERe4LjbP+zOoLcHnwkXu8KzhFSA7Icx+kBNRoH1ULM+mVb30DwKc
         TlOwzCo61lgbuMmS2bjzXgYSVw0hnO7IeujTaLx5Ik2swMy+L0/AmukFmc+cBq4tPiT1
         Vmg9FU8DovorPMwHwTpIjg4iDRPiTByFTwkebOvhMM+VPWuwjsiTVGP0pzWDIOZtultx
         lBWf5CZEu2ipIe1z9otbbic14RbiRsWMsLKtVB9JM6xiRCdC6Dq9StwS5YIEJxTJ1OIJ
         F5U95JRSvoTz/66oVIaeg3Qm/MWj/6d/sxUUsSW3N4Btf0l66z1V67upkN/p9hNoi8R+
         804Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717662040; x=1718266840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kI2cdJDpABdMGmQl+txxxVa/ZELbED2IxOHszzsEmk=;
        b=oalo3WyZ8bzw1euX2rFLF9QSzbO6O01iZ+hSuAuIMayRRQLPm15OKQ3SaIc895G+6S
         LG3GVnuKZRpReBU0y4ECVLlZaQaBQXC+zexb3J8xLmH3RD55X4Qby13Xddk1zLX1ao4a
         SHHvUHfJ9OALvuRHRH0SV7uTLIj8w/xNG7AFyih7Yo3xuqA/aSxrxnhNrhP5cmYyTH1N
         ae7L9BBilxPFxYMlC8gwdKPAWSo4d5tSDZZ2QJu/koVYbJEOhhGmKPVR77HCAOGG48wJ
         cHB0BGKIgVN8oAZjhAXYqEWEHq2gl3/Jodx3yhOM9dcXcApK/goKLxcP0cQRHUXkRun/
         dwPA==
X-Forwarded-Encrypted: i=1; AJvYcCVQGunp3IIFGHJItFSP7te68/QC7J1RrkP+bRmXQRXTrdAPu/58rnsRI+KeoeU5E0LjX0e3teFd2TOCcVWIw7rF3VFWf2q0S0NcKDYz
X-Gm-Message-State: AOJu0YzgPARZ+uxHKuKFPI33n/shmy9v40Kn2hfaFaeq9V3HHjl8WiWx
	z6BFnevlbm0z93KK7w7e3qdTjlBHfGoyjymF7zgNlZWLWWJM8yqFZfDdf/+1zELE/x5C1jrvPGc
	s8OftxonwG3lBGCLx1l3ql4L7TBre/qSnOMeA
X-Google-Smtp-Source: AGHT+IFE9WmSo5OTxuoBZojQvoBTfkJrcVh029teBW5Jl+55BD7o3it5tXbtjBD7DlrKr7HlCiB/oFVBH9UKsTRUNSs=
X-Received: by 2002:a05:6402:180e:b0:57a:9ea1:f92a with SMTP id
 4fb4d7f45d1cf-57aad34e850mr99420a12.7.1717662039210; Thu, 06 Jun 2024
 01:20:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606-tcp_ao-tracepoints-v3-0-13621988c09f@gmail.com> <20240606-tcp_ao-tracepoints-v3-2-13621988c09f@gmail.com>
In-Reply-To: <20240606-tcp_ao-tracepoints-v3-2-13621988c09f@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Jun 2024 10:20:24 +0200
Message-ID: <CANn89i+D1mXLvTvQe+2ggdm_HZiMQcRP4+Tm0Cgo++oyd=zm3w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/6] net/tcp: Add a helper tcp_ao_hdr_maclen()
To: 0x7f454c46@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, 
	Mohammad Nassiri <mnassiri@ciena.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 2:58=E2=80=AFAM Dmitry Safonov via B4 Relay
<devnull+0x7f454c46.gmail.com@kernel.org> wrote:
>
> From: Dmitry Safonov <0x7f454c46@gmail.com>
>
> It's going to be used more in TCP-AO tracepoints.
>
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

