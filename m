Return-Path: <linux-kernel+bounces-322712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A570F972CA8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D813B1C22B59
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4F5188588;
	Tue, 10 Sep 2024 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g4oq4G69"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BC2187FF2
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958634; cv=none; b=CUALUuYBRWnyz2ruQ43CH4iuE2VEbxpJuTGhSWZsy9OhpxdGpKaEDVejoBVvWJuYZtLPvESKrcFbnN7IZFEiFz5TZk51PkALCTnbGEcJgPswM05nLHkmq53y9sZgs6EZuJNpnGtKaX/z3euGgr1ifyqsr2MDnXqu3Ta0jfmOmYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958634; c=relaxed/simple;
	bh=KWvP5hzroBed5igOh1z2RVnYu3uWa09cY5RjcNsx7AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RuZHCcTyyxopOHHEmgb5fVc5vjolLftUxUTPUU1A8slbFfEDy3A6PQlfv/urXtwDJtz7ZOKa10DAktSRqK8kpd/j4DBY43J06ihcGkMnYTA/3pQkofhPq1F92s9XJFb6VHFzgY5LFcNT2T8lwh+dWaAq1lrNm3YjTwIui+gYt0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g4oq4G69; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8d2b4a5bf1so66842166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 01:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725958631; x=1726563431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWvP5hzroBed5igOh1z2RVnYu3uWa09cY5RjcNsx7AY=;
        b=g4oq4G69gCeLTrinxH/rP1KvN9na/TPrrsgupcrrCc1aPslxjPE73hx4MNuCXa07t6
         FxQSY4liZkYhN76vxlz20BVkzcAQ8DF8d8moE3oVeyCX5yCI01NwoCz8LFgmGg0Bxgtd
         WlYfxlUee6bWQMjfLbejsjcuf0gMGdyAulBcLMT75wHIDXUHnQ6rrjPNV4UpbE9U+N5y
         IecUhZEpweDvZjrPcdqKv9dp4s+fDw2z/0eo8nsGFoi9xQ7WsnYGUFEZjiAVpEkkyysY
         WpqgGl/4W5ruKUs+qJrsDeEqON3vbLhVeEoBpL/eFCZIravITEBkXVdkferpFVIfDY/x
         4MlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725958631; x=1726563431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWvP5hzroBed5igOh1z2RVnYu3uWa09cY5RjcNsx7AY=;
        b=gDvxM+2VBDiNylzdzut0I6U11dn0fI+W3Zxxm+Ozl6RQo3JFzNqAJQRHzKyVcqcwMr
         58k306+24U6eimLy49hbuzqMOADjQ6Er8P2M8OlLNcPtOFkJuQF90gi1GhamVMQD7+IQ
         l6cwh+xl5yF5MRans6hNqkVLnSh1u298d2kcyyt4yYyPupILW3Sv+5CCJcqWl0orijbT
         e7sfFTTWHu7e9Dvf1lO2rjdqZVrlw1FLMBBNPHTaTELPiiN9Lve4h3JEIFwzFRATEpE3
         knMA3c7pOjBS2tfEMYR7YbtC67nyenGVjBeWKlX9xB4rPMN4q9eoEYVyUbOMOLWGA5s0
         4JVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg+FTd6WyErFSxzMyILhz1VXhjvvVW94pHaH0yByy6io1vWB1lyrlwuFkZNjmtKh9iOYferyKHvnLdO6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf/Dk8M92D2Q4mDxvA7fWbWUAp0DT/s/0YZZDg5u4XNR5Oux+H
	t/UfajoeyykrY7IHIw6HzncbQp/9gBsxGd0E3ljfcbDZGkWtWber3z+USuYjrk1yNSPI06nXpnY
	PEdlcFKGeLvFsKWx/MdQV9YMnXK4pnzkc/mrerrAH4+PvsWxiMQ==
X-Google-Smtp-Source: AGHT+IGtExah3ON+mtcvZ6TYqbMlUmlezXeColca8ydpxAzUWBAoJTDmkqfimyO8p/TwLjdAwiTKBSJMiyTwISfNC5w=
X-Received: by 2002:a17:907:97d2:b0:a7a:a46e:dc3f with SMTP id
 a640c23a62f3a-a8ffadf90afmr2909066b.45.1725958631179; Tue, 10 Sep 2024
 01:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909160604.1148178-1-sean.anderson@linux.dev>
 <CANn89i+UHJgx5cp6M=6PidC0rdPdr4hnsDaQ=7srijR3ArM1jw@mail.gmail.com>
 <c17ef59b-330f-404d-ab03-0c45447305b0@linux.dev> <CANn89iJp6exvUkDSS6yG7_gLGknYGCyOE5vdkL-q5ZpPktWzqA@mail.gmail.com>
 <a4c02c5b-af54-456b-b36a-42653991ea34@linux.dev>
In-Reply-To: <a4c02c5b-af54-456b-b36a-42653991ea34@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Sep 2024 10:56:58 +0200
Message-ID: <CANn89iKMhCJietM70bYx+ZEjqTLQjUvQJFno=AQ9uStkhg57Sg@mail.gmail.com>
Subject: Re: [PATCH net] net: dpaa: Pad packets to ETH_ZLEN
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Madalin Bucur <madalin.bucur@nxp.com>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 8:02=E2=80=AFPM Sean Anderson <sean.anderson@linux.d=
ev> wrote:

> OK, I tested both and was able to use
>
> ./pktgen/pktgen_sample01_simple.sh -i net5 -m 7e:de:97:38:53:b9 -d 10.0.0=
.2 -n 3 -s 59
>
> with a call to `pg_set $DEV "frags 2"` added manually.
>
> This results in the following result
>
> OK: 109(c13+d95) usec, 1 (59byte,0frags)
>
> The original patch causes the nonlinear path to be taken (see with the
> "tx S/G [TOTAL]" statistic) while your suggestion uses the linear path.
> Both work, since there's no problem using the nonlinear path with a
> linear skb.

Maybe it works today, but this allocates an extra page for nothing,
this is an extra burden.

Vast majority of skb_padto() users call it early in ndo_start_xmit(),
let's follow this pattern.

