Return-Path: <linux-kernel+bounces-345962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E5F98BD74
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C61A21C23553
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F38C1C3F34;
	Tue,  1 Oct 2024 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JXiUbZKK"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8531C3315
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789230; cv=none; b=i2AhQylgA1OYNhIQAad5V8N5Gjxp962QIZ/GJlzCflpQ+sC/LpHcOgkZmOu0yJcMQbLpsaZOse6Q75I1Vn2ITCYaYtFSttUNmNwLc5vb4A7bHMTqS5RI4jJHN2P113LBolX4dnph1bNI9Cubu3qskbD5qKJcqdThJ4DBZ0G2bD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789230; c=relaxed/simple;
	bh=q4WSEnDpuB4eGtxy9YAw4aeZCRyT8eL+xWjfdg1QsNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3n+SfveeQ4tHj9NBTp+Ci59TeaMydifuzNoaC7QiP+jjq5QDW6FeHpw+PosD0QPM/n4F1ZemsXKgG0yCVLIqakrORIB1ACI5gFptRHZL4c/GuBm+uzxOhbtxEbWvU+4WsYPcoAcSvQrbTdU3Io1fj0knS1VIN3YlS783pymCdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JXiUbZKK; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c882864d3aso5346271a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 06:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727789227; x=1728394027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4WSEnDpuB4eGtxy9YAw4aeZCRyT8eL+xWjfdg1QsNw=;
        b=JXiUbZKKPKq+tbRCZp9ZN0Dq2h6lPPXMAQFBQi9CyVpwi7YY9nX+/9PQdQVOog3cGA
         MWyeT58hyUloMAeNDwgHV5ytbN3g8TPsU2ccghodXGvAbuIkF7QQBGu1AepQP1K8Vt3Y
         Dcz/iOwT0pOIQCnnGNWs9fR8SDFRrQ/24cCgkS8ch4Pd/JbdpUzyONyIi1pAtMbB0Xle
         NYmO/8V/EOHrQ9Qg15J3ss2TXE1NxIdm+Cyv8AyBsMhG8V6f9kaxEkF9Wf0CSd3x5JGo
         kupYJz8EWm3MoO8Lvk50QyCUCnmjke+TmbMPmX1xpKLsujPU+i39VGHyGofxkUM/Mnn5
         HRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727789227; x=1728394027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4WSEnDpuB4eGtxy9YAw4aeZCRyT8eL+xWjfdg1QsNw=;
        b=lbKQkhE84T5Wb0n3xHVTNO3xPCMDxP2OKuGXVZlArCwuMG9O237Ue4kfzUrB6I7P8R
         x0ZtLG3mMQ8+pB5yg4LqLFVJgav9Qrr9gfzKM4YpWPy2CExklZk8GVwFkDwnXH0nIHP4
         S0yv+k6ZquMmcXlP6+AwNWwgtEpZQKF+/+LLPp+Pl2tufJHgKxj10ouu0/HsllNpE7pQ
         SZarnaGHfCM/thMxnyQzMwe5hXhzGuEZfeiTR3dolfW+ticw9QrsaVZwPl0HWWhI44vJ
         xDy1QxMkV04PY86HS8RxJzPvs6jxhQeyCZfiV7qz9fi2FZoQ7u3CVNqMSGHdi8j+NHDt
         ucOg==
X-Forwarded-Encrypted: i=1; AJvYcCXGZIfZ3HoA7+w0TqbD+Soc649v0RjyEoQVlk1MCx4fDWUWrUMB44s/zcUyciJEZKdIBVSa8h+L44bd1V8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEEk7nZ2scfBug7wlN+SuRblJmug3ngfljoaT5uQyIJ7wC90bZ
	id8Sa/ipwrTjdOsIV0Foh9ixREuNjC4VEzTmrTLOsJJcezfyato1fhH0Mof17TPpdawCOaw7lYq
	asklQfaI3QRluYJMTAUyJzjq1CczsxYxXALcJ
X-Google-Smtp-Source: AGHT+IGkw0e9HglM1R2Hwa0tlntKnazumrMUcOEW6TH60bfpnaXkt29tvx7Cfut1P3x3OVT2Cu7hcKnSpjImRfnjSTA=
X-Received: by 2002:a05:6402:40d0:b0:5c5:cd34:48d6 with SMTP id
 4fb4d7f45d1cf-5c8824d0111mr12511337a12.1.1727789226905; Tue, 01 Oct 2024
 06:27:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001100119.230711-2-stefan.wiehler@nokia.com>
 <CANn89iJiPHNxpyKyZTsjajnrVjSjhyc518f_e_T4AufOM-SMNw@mail.gmail.com> <4e84c550-3328-498d-ad82-8e61b49dc30c@nokia.com>
In-Reply-To: <4e84c550-3328-498d-ad82-8e61b49dc30c@nokia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 1 Oct 2024 15:26:49 +0200
Message-ID: <CANn89iLC5SgSgCEJfu7npgK22h+U3zOJzAd1kv0drEOmF24a3A@mail.gmail.com>
Subject: Re: [PATCH net v2] ip6mr: Fix lockdep and sparse RCU warnings
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Petr Malat <oss@malat.biz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 2:50=E2=80=AFPM Stefan Wiehler <stefan.wiehler@nokia=
.com> wrote:
>
> > OK, but RT6_TABLE_DFLT always exists, ip6mr_get_table(net, RT6_TABLE_DF=
LT)
> > can never fail.
> >
> > This is ensured at netns creation, from ip6mr_rules_init()
>
> OK, but nevertheless we need to enter a RCU read-side critical section be=
fore
> ip6mr_get_table() is called.

This could be a lockdep annotation error then, at least for
RT6_TABLE_DFLT, oh well.

Note that net/ipv4/ipmr.c would have a similar issue.

Please split your patch in small units, their Fixes: tags are likely
different, and if some code breaks something,
fixing the issue will be easier.

The changelog seemed to only address the first ip6mr_vif_seq_start() part.

