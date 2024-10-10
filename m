Return-Path: <linux-kernel+bounces-358227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E9A997BAB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39CA31C21AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 04:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C2F19AD97;
	Thu, 10 Oct 2024 04:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TvP8438f"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436CF139D07
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728533513; cv=none; b=W9+yXNBAwt0o1rwR4uGEa2pj09bd602aID6Ne3HqsDEDDQMxyrSE/VaamRYIvtL3rxQd5lc2Dl5dOI+mEqDZf1ZrU6vtpgrasp/QMhnMgtJlRPYAphgJGH93fvL1uaeSZcse3xrVryPlI27PUqWn8Msw7B6SdZi8T6O9scCesss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728533513; c=relaxed/simple;
	bh=CgYevYwG0CSfzneOC397ia+aGdKxn/Q4LSvx68lmwCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PEZEhrAaE7j4Nnho+wl308bkiombtFRLHLFXjxyKcy1YCDTtA8rVaf0OyFq+HjIkTGNcbxz7oOJdDqQy4oNE/tYqcriSUr3zMmk0RwgD+BVNtlMeZ0GAOF7T1ZLJhvZXG9dabvyyVaQMbAKSIauCXbUS7ANBFKTt3lT5tWAo9wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TvP8438f; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c935d99dc5so284753a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 21:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728533511; x=1729138311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgYevYwG0CSfzneOC397ia+aGdKxn/Q4LSvx68lmwCM=;
        b=TvP8438fdPwqHGkvjHCVpBqucAeT5oHq5N+xwIYxGJHhwfV6bJqUXUOTnimwdkPriD
         +qQVwpjn5YepCqpxM4GVzkfCg27AO7nzpwbH7Uu9E4Cv8f9CeG+xqQedi/Cg3IW/CQEK
         PTAotdO7212/8R1rv6N/fxhLcmTG+/3kebkCwPKe7k+5WUQNqcTL0dYAvOIOS3XRKo3q
         9WqhQfHdlExa1MejrwNpYFd86qH53TG1C0xjb1kQxWWvj0khRzYo70C0K3mIO7Hm2D38
         z+HbD9ehPDmZowLBr3+9dg7Y6tjA7Is/ohOgVGi6uz9Oxe9RttjIsMj2F948QgLXMQhK
         ZFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728533511; x=1729138311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgYevYwG0CSfzneOC397ia+aGdKxn/Q4LSvx68lmwCM=;
        b=tzwfnIAyXCmxgzCUBK2+Xi67I3HW4ktmRpihpUILKnZO3JPjtO3wCp+gxkdj2ESqww
         XBSdCVmaOQHgzd2bQx+a1w6JURobJivv9C3exUgalTQEzJo1Of2CiLTlC9ZwYdZSGj/E
         WjU+o81pAM/ePWjJ6c0w7ssFGhDw3AYdEFp1DY6dqcKHa2qGghmXV1wvaM6Q3dqop5yR
         CBRFVhaLXi/6O1j9/P0p87QVneOyq/kqXyqnzvRIBG5EGYaxxfLhLGby0ML7lSjGV3Kp
         ovNZO3adXKi3JluBQ3sMce6dK3P9hmrhC1IUAeSRC//wHk1Zw5MBnr5gSJLGj367W+vN
         we7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPELIQ7Lh0q69HmLMNmqCIxwYxJo8teq4ZeZoVZIDNIfbHK5Jpy5oazKm2TQ7MzXuPuORUJaEnmI0oLKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWDZj+829NGe/GpxcBIgCUtkzqyMIs73RsEBvflmuDSNho5v14
	heEBALHVgbPgiZ0KT3nUK3uCuwCUdaxSMlz0tm3zgzpmRfYfEMJQ29BjeSfVEqzs+JVg6BnmwRj
	3mwBEhkDS22vfllvjmf6f0d/fpLv7J+SjqacL
X-Google-Smtp-Source: AGHT+IEggKIp4ZTuRW/SWbztS18yX1MQLhoMfJi16i5VVNUe3ApWhL59KgIghcZllZFMTyqKV54Pq8mwJubV+doV0Bw=
X-Received: by 2002:a05:6402:34cc:b0:5c5:b90a:5b78 with SMTP id
 4fb4d7f45d1cf-5c91d54303dmr4299427a12.5.1728533510356; Wed, 09 Oct 2024
 21:11:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009005525.13651-1-jdamato@fastly.com> <20241009005525.13651-3-jdamato@fastly.com>
In-Reply-To: <20241009005525.13651-3-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 06:11:39 +0200
Message-ID: <CANn89i+nY7TpYY8jREiixSNiZ+63n2PkHq5aaR+G39WWKqbSvg@mail.gmail.com>
Subject: Re: [net-next v5 2/9] netdev-genl: Dump napi_defer_hard_irqs
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com, 
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com, 
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Daniel Jurgens <danielj@nvidia.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 2:55=E2=80=AFAM Joe Damato <jdamato@fastly.com> wrot=
e:
>
> Support dumping defer_hard_irqs for a NAPI ID.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

