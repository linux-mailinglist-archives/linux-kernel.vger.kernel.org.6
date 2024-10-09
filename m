Return-Path: <linux-kernel+bounces-357402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D65099970E3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 140391C20BE3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C91206940;
	Wed,  9 Oct 2024 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FEjdEXiZ"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24371E1044
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489190; cv=none; b=DY5YbDFSf4a4uZHwLK3Mc/IyYHCXovXNhlymWJkKDZdaNLG77qDXvMvXJh3tR/APB34JUAmKn1xuPlL8KoxW8KKe0PomZjYdIxnf9Y+VyxyDWNKR/6QHfte5U6/E48NSjnYsSmCHLV0sqMJND72SbJ//8Pg7KfnBAZtNmE/qdfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489190; c=relaxed/simple;
	bh=qY3+Z+3Bq6ZOCLy/wmsIjJJC3n70MViMpYQ5o+VGqBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t56wYmGFqa4O1lCMGfEE93vtMLf7IFAfeY50WIrJ3MObftqgNfdT6/Ej3XFOaMB+H+trZU1otFz1fe0Gp6+hLR0z5OoA2nEi/+M8Gy18Gc4UgYtYHpCHK8SV/ofA2JFbWaBHIOeZLCM6a6Bov4yJGkCj0wE5sHopF9N73ne+nNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FEjdEXiZ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c928611371so913137a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 08:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728489187; x=1729093987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qY3+Z+3Bq6ZOCLy/wmsIjJJC3n70MViMpYQ5o+VGqBU=;
        b=FEjdEXiZVKFh5ePrG+OLjHRd9heDbh9wOtMVIWoM3fr3aNs3b839XsmlCR7lzfSODO
         b3Z6sq9FNLjTt1GFSGf4MRu4Hm8T7z/CvqyJhtfszd7QSPgFoYdEWMoca9QN4Dg0nu+M
         ozaV2FA2IV2yhDXWsTdjuhIoKNPvIpcJkN3sjBXFaBzvv+eHfBqyK6VUv37yfrOIzopz
         Mu8kzkw0TxQvzNyWZmLI37DRurqvMaavKxG4OkJXHOH7U3mMYsqZLitHDzy+Ia+TS08w
         ZxUtjBe6mRi6yKtajsAUz1vuNCuCxqt8NLUX84sSfuC6X8e0PjEGu28tU8pp/HekL5VV
         NwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728489187; x=1729093987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qY3+Z+3Bq6ZOCLy/wmsIjJJC3n70MViMpYQ5o+VGqBU=;
        b=ahzokhsFZ7vMQr0uHvVygVbu/PB/qrnFZQsIF/TJP3/BjKTIp06k495UXH2QSKeY1s
         4gAm3hDQE27O/LlwvxVjPEeMDAPCRpNhh+S/vyN3q3NB365b9H/0nwYDMAtf50fq2TeE
         DvxML3dY4pdGjjIUe/iVA/az5/8fmorJp/9NRQGwlcpZLLm4VEAggSaXhJJPrk8hUjUd
         EwiV0jDt0sF3DSDroxecmygnQxBqr5VAU1N7E8PLPTCgcB0HcxdPMjJU5Bhxt9S3cSy7
         TJIUKiIZuncaSiEJTYJF+SnmqlIa3C9l6AHBACPe8AJIhh+PO38dOI0Vmd4iNqhuzitE
         U3vg==
X-Forwarded-Encrypted: i=1; AJvYcCWwj+PBWB2SjS99L5W0BuGxy1S9MHSVC4FRjq9UQjht+T8lXJOuOwa7adKGriYmwZwt02roL2qWh6YHIws=@vger.kernel.org
X-Gm-Message-State: AOJu0YytqoygKWLZSLAaffzO4RwbPgEvvfKY3GAzUOYaGSkWpzuVwZCN
	lqrZDQxb3pf36gmE0S8Nn1gkkmCJbaaTZBOEllwaxHDdawlN7qDgob7GSDB/y952e33LKYlsJqq
	AsjF65A1k2OaBBxShu6k/af3ftCwz16AzisHt
X-Google-Smtp-Source: AGHT+IEQV7nAbPoM6W+RrSQoV1u726+qXXT1p852mGQFg9Gw4itkSxdL7eXhWxwSO/6myLTg4/DgHQkXtgpF3yoCFr4=
X-Received: by 2002:a05:6402:4414:b0:5c8:84b2:6ddc with SMTP id
 4fb4d7f45d1cf-5c91d68c9c1mr2454867a12.33.1728489187004; Wed, 09 Oct 2024
 08:53:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009121705.850222-1-dongml2@chinatelecom.cn>
In-Reply-To: <20241009121705.850222-1-dongml2@chinatelecom.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 9 Oct 2024 17:52:55 +0200
Message-ID: <CANn89iLKVh0_wkgZ-a2+Dr9xz6wOs58CE8PpwzZEH8ZHMn=jsA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: tcp: add tracepoint skb_latency for latency monitor
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	dsahern@kernel.org, yan@cloudflare.com, dongml2@chinatelecom.cn, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 2:17=E2=80=AFPM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> In this commit, we introduce a new tracepoint "skb_latency", which is
> used to trace the latency on sending or receiving packet. For now, only
> TCP is supported. Maybe we should call it "tcp_latency"?
>
> There are 6 stages are introduced in this commit to trace the networking
> latency.
>
> The existing SO_TIMESTAMPING and MSG_TSTAMP_* can obtain the timestamping
> of sending and receiving packet, but it's not convenient.
>
> First, most applications didn't use this function when implement, and we
> can't make them implement it right now when networking latency happens.
>
> Second, it's inefficient, as it need to get the timestamping from the
> error queue with syscalls.
>
> Third, the timestamping it offers is not enough to analyse the latency
> on sending or receiving packet.
>
> As for me, the main usage of this tracepoint is to be hooked by my BPF
> program, and do some filter, and capture the latency that I interested
> in.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---

Big NACK from my side.

Adding tcp_mstamp_refresh() all over the place is not what I call 'tracing'=
.

