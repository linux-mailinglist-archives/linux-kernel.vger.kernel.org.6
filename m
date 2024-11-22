Return-Path: <linux-kernel+bounces-418355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1279D60BB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79298B25B6F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 14:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08AA148FF3;
	Fri, 22 Nov 2024 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DAYea4vJ"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01C4762D0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286793; cv=none; b=LZS37LE0FHWeerLhMVYJVJew4AsfDQWeAyoK2CU7DEh7iF2HQwpv04U0slX4dsT5BYHMluP260thy6iiz89tVjkaU7laJ0bUybW8zIJmOK8KcnbUdI40eqQsHqVl37yEHmJDaupddI9jdj7FBSMXDlVa8EvwQ4JP9b/JRQKViu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286793; c=relaxed/simple;
	bh=YuCDyXzpAPEp7yzMQsq89fFqbxrywM3WLDg46780FWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5C2wYPGCfym8osakzPdXaVliGSrVSnYcrsHT3gFocS5F1x/RXyseAWldiCiD7g/Pj38r4CaBFEJSa+x7Oq1BU3rSipZEm7i3Hj97LjtoFEuB9dqPUaMo6QLsY4hWorrdkOmVwmONSlQKFpUm88/r9XgADUmSVIdy0dbZnjtXRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DAYea4vJ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53da22c5863so2679120e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 06:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732286789; x=1732891589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YuCDyXzpAPEp7yzMQsq89fFqbxrywM3WLDg46780FWU=;
        b=DAYea4vJaqkKrZqK3Q0YE2LV/P2qx8pLec7qBLcV/WkUN8sSKyKt9K8eokpTXhiQId
         XYXlKIsFArZESQGX97zkGLQXbuutL3+vw+28nH1n9h7He2tYe6OEtjPM92kR6tsX5r/6
         BjQjmbnCTofZO0vYlKPElN5Aj21cyakOe7VEMfXTItXPUAaF40OMKdRXPJnaeDjbe4pR
         H4c58/jKm4Sa53MujbVHiSgPxjLkv7r97KQ+l8iUHCFjvzjGs5sgAJ3wzZsIfzUxNieR
         83fr4w3UVpbWcA4ffHeyf7dp4VMjeP/RW/K8sFpKim9gDLyK3RT2wSUQFDgarPWApKWd
         dPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732286789; x=1732891589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YuCDyXzpAPEp7yzMQsq89fFqbxrywM3WLDg46780FWU=;
        b=CrTya1gG3MY9S2lca8xBdo/25/dPmg1+kqzZW+wffaDeFyli6d7joGvXWVBmoD0fys
         AdIt88hIsyc+fp2UALrg63UFUuj3wwmZYWvbNkYcEviWdRblhZ2puq9bLJk8pTmRkCwr
         uBwkipc1PwBUWgL5oAUQNCj4NSetm6JKN84dZRxjKE7QpZMvkMIlTNig06JEd7lvhWUA
         ZOVQItJhXWAVacvVnEZDGI/7j63WBJvt0UNijF9XFVTKnVj1q5czckbGEWHEarKuxrhD
         UWQPMLqbOxWreM6+bqRyDrN/4byTCCMwJFUn2ILLtMqwR7ISKmBhkHtG+QLqO586o/1K
         z4WA==
X-Forwarded-Encrypted: i=1; AJvYcCVaytgSdnnZpTl4FDpjNYDX0FAtqIZsE43O7GWa+EpvGrk6lPdLBRW/SGortCcaPY4ggMnRZNejulqTq0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZJMAg6X0YwVBSrsJtK2GE0gK9gKjCHWj6s5NIxmfnCBiIuUDH
	CvkcaxQXPG0lETpsDllB3WK7VXzNWmiLYgBJhCcRrLxJAqsFeyRguXG4jF1cDaXzJbAzBjx3zdo
	xy53j6GCTJmfXc0JskKfpNJtN75MEXHUBwEBu
X-Gm-Gg: ASbGncuT73xs1KnTxC8aVIn3dWDc/pQ2jS99v6NVB9e4O1j9VA8jQ2YMcGfYjFtIndW
	EODdWIrdjxNs92aJQdzkaw41sb6k9ew==
X-Google-Smtp-Source: AGHT+IEO0g02B7hMsc6G7E1jh2onw8QqpwRT1leD0anvYgIAvIwpEwDCFZIzyZF/av/qeAHbuQ0CCwLwxb2LPehfcBo=
X-Received: by 2002:ac2:4d8b:0:b0:53d:d3bc:cc11 with SMTP id
 2adb3069b0e04-53dd3bccc70mr1525350e87.48.1732286788623; Fri, 22 Nov 2024
 06:46:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-netpoll_rcu_herbet_fix-v2-1-93a41fdbb19a@debian.org>
In-Reply-To: <20241122-netpoll_rcu_herbet_fix-v2-1-93a41fdbb19a@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 22 Nov 2024 15:46:17 +0100
Message-ID: <CANn89i+iQJ70z2P-ZVYq9vbas16wDnBPQdp8fZT6X8qONeovGw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] netpoll: Use rtnl_dereference() for npinfo
 pointer access
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Michal Kubiak <michal.kubiak@intel.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Herbert Xu <herbert@gondor.apana.org.au>, Jacob Keller <jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 2:18=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> In the __netpoll_setup() function, when accessing the device's npinfo
> pointer, replace rcu_access_pointer() with rtnl_dereference(). This
> change is more appropriate, as suggested by Herbert Xu[1].
>
> The function is called with the RTNL mutex held, and the pointer is
> being dereferenced later, so, dereference earlier and just reuse the
> pointer for the if/else.
>
> The replacement ensures correct pointer access while maintaining
> the existing locking and RCU semantics of the netpoll subsystem.
>
> Link: https://lore.kernel.org/lkml/Zz1cKZYt1e7elibV@gondor.apana.org.au/ =
[1]
> Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Okay, but net-next is currently closed.

