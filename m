Return-Path: <linux-kernel+bounces-270741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 583239444B0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03DE01F231BC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 06:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83543158879;
	Thu,  1 Aug 2024 06:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FtULnWB8"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419F41BDC3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 06:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722494782; cv=none; b=LDHXEuA5RPSWmfanl0v9T2iIp8lVX4oqxy0WWzbAfccxlmiiHmy6trWEEjo3BnKpF2kF9INXV5jEodChg0IXlcKxjWSFLST/JbkTY3i63Z975U2YxRMOvSbNhKxnoC1isEJL6oEYuPBBoG5k1eqNqW7HzLl1b4JXbrt6Z9AxxWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722494782; c=relaxed/simple;
	bh=Jkx8f277zrEWVXwSQwLfnFzKGG0nvS+9X97LVjs4P+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pWuUUmeCZQl72VvJXz60MBqDkOztiKPfMpl8eJK/qESEjVgBbbIUtP3xX7pcyR1u4O4ZDGj0E3qoB0cyy5Uv33379QvbNUAdJ1mjxOU7CHtAkhcfl5KRIbfbehOTem8At+I34UMOv032GBSV5ZtPPIoVmP9zPK5zotfWsZn3M2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FtULnWB8; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso33679a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 23:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722494780; x=1723099580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jkx8f277zrEWVXwSQwLfnFzKGG0nvS+9X97LVjs4P+M=;
        b=FtULnWB8UXB1uCxt9b/qOEG0sM+OqimX4i9LbVl1wXx3K0Ik8KeCiOQONIwADdDDwf
         TcQ6LuSBF7dpvsijnxCZeeyHPZrWyDtVC9+RnO7/pS+qVBn5YFnsztbZ+Gpc9mgdxO7a
         3cpXYI1TGK+Q1KUy7TKvVIfVy/tDXF6mt9TM2x2qOGG9guZlJWzjkVtxKvlU/u6HQk84
         b18lRAVz3UqgQEwpmapJS+wd0SfT6R22CgKf8oWG0IrsFidLho2pMcJxc0p4ox4pMDUP
         qYda2ltMmpZKUb5Eg7S9SYoqXKiou3mtj2IWVNJNyF9VhihYFBphuBmQlY3F2SNcCdqc
         Vczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722494780; x=1723099580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jkx8f277zrEWVXwSQwLfnFzKGG0nvS+9X97LVjs4P+M=;
        b=k80epbO1hhJsWWVpBVPceXd+vzZEldoHEfwRVPXNNVn4dP5f4y8nJpiZQZ6soeoIdy
         Nf08jyu6FBWBEJIwnpjsRz4SzW8szeNcXCy4cXsWcy0IpPuoQlguGC06yS8kplDlcDpq
         5+XAm0xYy0dL7NRCXGy10Aqwz04k9fR4laTqIgm5WBn8vb2OzfMz0cXVqC7olNIW88Ey
         HOlakj8j0sixQF7Xz1BBWnaFU0yW3sAb795140BbnMKTL+s7w7kR0OS6JN60c94S9hJV
         QkeretZvJLk4SabHzBxMO1QcJ1JSkRi096n4svBOF7Vyl0BAjfJsgkVKch4yFD/3RCwY
         5tFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbS4ZPg/8waNEjx5JOV8UBTVa8sKfj5M9EnzHatSuOAcsX+PPuXMHg8Xx79fYUvgYClKPdKgWeUs11NalfhdcWfL5r6v7E2Tc5W70P
X-Gm-Message-State: AOJu0Yz76hMHdzmvUlM9cpBCyN/FxD0l5+EVfSqaSjG1LCvzC0wIxD6l
	uDM2c9tHCE5C52Wnc6VpPe+BQbr5Nd8DMA40loEcr0Bfz8K9kIWF9orwEKDxcf/28BPZbWdsTNb
	Mmn/wnINweV5UaPLjiFMoaKPp/+26p2Ts1W0Z
X-Google-Smtp-Source: AGHT+IE3cw1MNNwcwf69//fIN28Z82cEPX2hnQMioZqEX77H81l4nLfCXbjwHpaAduox8tkpsQsu1fFAsNW27BCwhx8=
X-Received: by 2002:a05:6402:2550:b0:58b:93:b624 with SMTP id
 4fb4d7f45d1cf-5b740390cbamr42068a12.1.1722494779197; Wed, 31 Jul 2024
 23:46:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801-tcp-ao-static-branch-rcu-v3-1-3ca33048c22d@gmail.com>
In-Reply-To: <20240801-tcp-ao-static-branch-rcu-v3-1-3ca33048c22d@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 1 Aug 2024 08:46:08 +0200
Message-ID: <CANn89iKiDDQu9A8URr6ZtYuBL6uSmtGxYhw7-TOUgGz5cp9OnQ@mail.gmail.com>
Subject: Re: [PATCH net v3] net/tcp: Disable TCP-AO static key after RCU grace period
To: 0x7f454c46@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 2:13=E2=80=AFAM Dmitry Safonov via B4 Relay
<devnull+0x7f454c46.gmail.com@kernel.org> wrote:
>
> From: Dmitry Safonov <0x7f454c46@gmail.com>
>
> The lifetime of TCP-AO static_key is the same as the last
> tcp_ao_info. On the socket destruction tcp_ao_info ceases to be
> with RCU grace period, while tcp-ao static branch is currently deferred
> destructed. The static key definition is
> : DEFINE_STATIC_KEY_DEFERRED_FALSE(tcp_ao_needed, HZ);
>
> which means that if RCU grace period is delayed by more than a second
> and tcp_ao_needed is in the process of disablement, other CPUs may
> yet see tcp_ao_info which atent dead, but soon-to-be.
> And that breaks the assumption of static_key_fast_inc_not_disabled().
>
> See the comment near the definition:
> > * The caller must make sure that the static key can't get disabled whil=
e
> > * in this function. It doesn't patch jump labels, only adds a user to
> > * an already enabled static key.
>
> Originally it was introduced in commit eb8c507296f6 ("jump_label:
> Prevent key->enabled int overflow"), which is needed for the atomic
> contexts, one of which would be the creation of a full socket from a
> request socket. In that atomic context, it's known by the presence
> of the key (md5/ao) that the static branch is already enabled.
> So, the ref counter for that static branch is just incremented
> instead of holding the proper mutex.
> static_key_fast_inc_not_disabled() is just a helper for such usage
> case. But it must not be used if the static branch could get disabled
> in parallel as it's not protected by jump_label_mutex and as a result,
> races with jump_label_update() implementation details.
>
> Happened on netdev test-bot[1], so not a theoretical issue:
>
>
> [1]: https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/696681/5-c=
onnect-deny-ipv6/stderr
>
> Cc: stable@kernel.org
> Fixes: 67fa83f7c86a ("net/tcp: Add static_key for TCP-AO")
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

