Return-Path: <linux-kernel+bounces-274896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2AB947DFD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDA561C21F0D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A0116DEC1;
	Mon,  5 Aug 2024 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="duwpYqDB"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D91154C05
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871346; cv=none; b=osT/76myJqkp4lkoTZpQMxoFBXfnkSS/4xlpL/yZYbvFr+Kpuk0g2rUQsU/B9zF4prXWHIcIb+RLvBgz6vTmYEgxxPEemko4mFOZBiOfvY2paTE7mNKUzAKHV2yXTOc0McFM5HtnZDlITcEu8C8y8CA3Ouy9Bka1PQ2Aavo9tf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871346; c=relaxed/simple;
	bh=7MNrmWDmCHETLP7byPXDSZNNxg5Ec+2Z6SzvxnYDw+k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JRQukg4SbN5l8HVp7S2jjP+bLE7Rf4pB3coY+W+TCw2qFZMaO0lsfPrMRo33AXweUo9YXf64vJ03kXDunx4xb48GSY/kLAcEPl2p1k1jW7eKgRaPeCTErLD1hPVYTurcyJRoroq/dhFZy5w7vHhuMRRSnkQQn5E8g++TVo0hMhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=duwpYqDB; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a94aa5080so449049766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 08:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1722871343; x=1723476143; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7MNrmWDmCHETLP7byPXDSZNNxg5Ec+2Z6SzvxnYDw+k=;
        b=duwpYqDBua77XfqYw5QIQe5LVLWY9yG5LkeRuI9lVpVI1aCO9Mg6Mz+tnT7bn3T9Ue
         4TkDgHE+aaneK5vY+FBDA4xAcKa7WnX9BZr6MEV6OOOd7/MmYP8DRWr0n5G/qivR0UYX
         AuCTPY0wVQlOS0nRztNY1K2Y38XlRdO6cu2cAClpJLSzXX+fBAvxUwoAr6PVsq3MGnSN
         18mDY4OrVVVlsES90eRRw1KLeR/gYAuDMmH8jYfKYKBlwmI/NXmN4LuM23a3Zg6fz7WN
         rCQZ5w3gjFMid6UzEFlFYCLktGLe+IEt3hhbUqAUC06CbtBUfzREq+lYOj8SPnhuQ6od
         d/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722871343; x=1723476143;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MNrmWDmCHETLP7byPXDSZNNxg5Ec+2Z6SzvxnYDw+k=;
        b=IVHDDGk2vrcGKa34zy/86s7vflJTKPU47DYnQo76xlDSNBMuI+ENZfCZ01CEfst9qf
         xCrmhMjmGWzezqrQInShQHA2nt/Z0fegXk0UfixffUQCb2gvj9E8U8E1LbZQupO6N6Tc
         u5FO2toLtHdU/hTUWmeoqVtpzMmjk0cj9YB6d2naUADgTsKxHyh8QnWL5o14nhT8gxwX
         m60iXf4BQoW2U0rFLU+lhIXq2tG66VvcYJ6tg3uJd/2QRu0ifUt47pd1tL2NeOb5bxDc
         vIjQx7IR/NeXDrDsCZc2+wWpLwmF7oBSXQNAsSOWCZe6LfFPJ26s7yArTG1MFSvm+508
         75sg==
X-Forwarded-Encrypted: i=1; AJvYcCUZHDcZuL2ugF5z80t57bbymHql0VN3Eb90gjwPPYCTAe41zJkoAlDcmGzX5TVuwSGIZ3fN4b7HtHD8sh0YO0qy4YHd3iCxtSTco1JV
X-Gm-Message-State: AOJu0YyDLIMe1W3urPXU2ig+NjsjS/+3WruBTmkbOSe+Dea1/AG9PnGw
	Hoe+ktT9Mi9nT4P339iOdsFRTg7UZj3BQK8321nCewR8KUbJ1+pPRrUMWQer4Is=
X-Google-Smtp-Source: AGHT+IHf5/EN37gHp4+psKIk0tgklzZv5YnqYEQ0lWfNPTc/nX+llUFm2rD82+x6VTV0MzzOttW3kQ==
X-Received: by 2002:a17:907:2d24:b0:a6f:c9c6:7219 with SMTP id a640c23a62f3a-a7dc517a75emr918517066b.47.1722871342585;
        Mon, 05 Aug 2024 08:22:22 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:2f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7de2e1b093sm343351866b.148.2024.08.05.08.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 08:22:21 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Martin KaFai
 Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  John Fastabend <john.fastabend@gmail.com>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 0/6] selftests/bpf: Various sockmap-related
 fixes
In-Reply-To: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
	(Michal Luczaj's message of "Wed, 31 Jul 2024 12:01:25 +0200")
References: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Mon, 05 Aug 2024 17:22:20 +0200
Message-ID: <877ccvyoyb.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 31, 2024 at 12:01 PM +02, Michal Luczaj wrote:
> Series takes care of few bugs and missing features with the aim to improve
> the test coverage of sockmap/sockhash.
>
> Last patch is a create_pair() rewrite making use of
> __attribute__((cleanup)) to handle socket fd lifetime.
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Sorry for the long turn-around time.

I have opened some kind of Pandora's box with a recent USO change and
been battling a regression even since. Also it was CfP deadline week.

I will run & review this today / tomorrow latest.

