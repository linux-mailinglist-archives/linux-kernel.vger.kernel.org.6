Return-Path: <linux-kernel+bounces-542163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C76A4C66C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34E0189AAA7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F017217F35;
	Mon,  3 Mar 2025 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Z6sQxey0"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAE8215067
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018016; cv=none; b=nfislMr+4yDbtKFnkbVkD0A4XpPuF6aaMWfOkeddyrDk3c+CG/oOfAF5ZWqgVE44pZAHe2EFJb6R7cIA3G+CaX5CoRcCZBUSYTz1NegwdsTzkHj7SuZfCBws8e6ALhvkRyvqbRzy57By/4JU+E52jUTFxQA9e4sH0VoRCDhLWLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018016; c=relaxed/simple;
	bh=AI3cxo2jLjVqpJ60qa4KMv07qXG1TjgMfC4cjuPoLfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iheiDoZkMKPx9mJs5as2tz/XSyIVJYYr/IPd/N9zzLZyWBLdWVA53lIid4yKljI94MDI3ul+tcARnQVsZ9P7YZvIzJhw3BUJmhd3RfNLGl3dOHn3/aQsuC02hNBDWUjIklxQhQWZl6u/lA31erIDNJwgenWg3KUJqq0sbeGCAAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Z6sQxey0; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c08fc20194so805000585a.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741018013; x=1741622813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lzr/oaHzu3jeYpfGgArieRcxtUwl7pyGcBoKbLPEPNQ=;
        b=Z6sQxey0RceQFhHQ70JhD7FbuKlLqwUWjMU1/yO/zjSrF30J3FjbmN6nNM84YpIZvh
         seA5cPP/fAUlf4FXFwpnhylmb3jbqRNVkIfSByF7u+GgBA4aj3wUHX5Hcz+Xdo2gh9wp
         vDND/yHd4iSe7WPOJhFeEtq+kqHq6nHEhEJGgAy76rj+AkYNimcEoF/0OSEFDa0Z4Xat
         CeVHLnXo8OfaiXTa6kkmYodrkfYWdJfPiBG6sxveCgAMABOM0GH2+qstZ1VdziqHDt/V
         YiaKN7pv4/y2d9vo9UWc2x1NMjZcw6pJaWg81sRVm/+XleukTyugJMXkQt6dTRvFSskJ
         DTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741018013; x=1741622813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lzr/oaHzu3jeYpfGgArieRcxtUwl7pyGcBoKbLPEPNQ=;
        b=bBC8Nn1/nwy4zvP38/ENnwgyBSmRxlmIfKmdwd4JVI3GIa4H6tKAI4+gPDdIo2L5ex
         2LmBNdUwWk1qkqVn2jAQhiiL++D+eaxGS5koGFYKf1iTA29MPr62y2/vC8p08PJDYg3m
         E80DY59aptAqhgs7APybH7Ads9xShxKt5fX/NK5+JKz1mej0fXWLKVYbUkp0FEdIYtbA
         1Hr17JBGs7/fo5sVuGsk76wYijWodxfczc5049RFcHLEp0VNTdvEEXlN7v3q4ghuaIel
         t5cembPhPf0HUw9kfp4q4v+anC2ViYpLLHkqV4WRJDQXPSLCm98r8qo6aD7hwaMjVkVw
         3VEA==
X-Forwarded-Encrypted: i=1; AJvYcCWf5jFp5uWdB0RWssQJrUAF5yqoF9ZPDAG7OrEVP1f8lSzdWu3PmwdhIbMVPYgMJ5JWrtF/4mn+W/pKIBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHwE1oh2HslOjiBsvLLqDna9Jh3AwgYp3+m7329viSt45Mto74
	foDyuYpgKpJJNAMbmB6EdsravfofEqnr7HJg3pwGklzpnqBpYf8owbrO78Rtxs8=
X-Gm-Gg: ASbGnctbLkqPvNOaHLREx6QoBkDB60C/pQpj31PhN+Xtvex5aLJR1xYBXyhR1VapXLp
	nMDa0TShQfAU7544l2b1XTDsXW1ctNCU/ohRvE1ZOhBxK3vmVDhrDmd2jEGLL0TaC+Wa7IydtTr
	VLohwrPTcWDiBHhP8Elr2aK805BcVJ7weCebDyMjGzm6wBo7mXqRsfwuSFcnAd3JX73DMW2qokJ
	Q4sfgANei2cueiJB47Sl2lu02OswwvhcAhqiAntiCtSvjFVhMP49IYKqROQJ+A4qinddp3zDzcE
	gBp64sAZ37mu4ZlJ2UFsHobQ2wkIGqCpaXQK3eN3Es88b69NOHayLqUvRuLv+ybOoCQXg7ourhU
	xyS3ry2lVpccLn1hNzCLPFdQh2qU=
X-Google-Smtp-Source: AGHT+IHChyfToyTxgY2RQQ9d6t+oy8oG7M1Wky4HqRu+rPnl3md2BPSbDf0c47gPgHsrhxTz2O+GVA==
X-Received: by 2002:a05:620a:2945:b0:7c0:b93d:69a6 with SMTP id af79cd13be357-7c39c499da4mr1921637285a.9.1741018013083;
        Mon, 03 Mar 2025 08:06:53 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c36fee8abasm615446885a.7.2025.03.03.08.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:06:52 -0800 (PST)
Date: Mon, 3 Mar 2025 11:06:50 -0500
From: Gregory Price <gourry@gourry.net>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
	peterz@infradead.org, keescook@chromium.org,
	gregory.price@memverge.com, Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] selftests: Fix errno checking in
 syscall_user_dispatch test
Message-ID: <Z8XTmnRo5opCojnH@gourry-fedora-PF4VCD3F>
References: <cover.1740386567.git.dvyukov@google.com>
 <d11d91e0c27ef78affcef06e00d1cf4cd8747fcc.1740386567.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d11d91e0c27ef78affcef06e00d1cf4cd8747fcc.1740386567.git.dvyukov@google.com>

On Mon, Feb 24, 2025 at 09:45:26AM +0100, Dmitry Vyukov wrote:
>  	/* len != 0 */
> -	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0xff, 0);
> +	EXPECT_EQ(-1, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0xff, 0));
>  	EXPECT_EQ(EINVAL, errno);

This patch should probably just be pulled ahead of everything else,
since you change the behavior of the syscall, and now you're updating
the test - but it will fail (since this no longer produces EINVAL).

This patch should probably just be entirely separate, maybe even in
stable?

~Gregory

