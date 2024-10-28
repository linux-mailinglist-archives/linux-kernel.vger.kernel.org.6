Return-Path: <linux-kernel+bounces-385181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A0E9B3390
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE5D283545
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EC51DD53E;
	Mon, 28 Oct 2024 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AAMg8Dnp"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8123C1DD864
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125909; cv=none; b=OrpLu/HqMuEp0ODAzezKjr8+q/xMEQVjK7mvIC2p2OJ2s1N7YoWzndYe8ziYpGmN0WspvkbY0VPOMH0aqwzsPVFSGsWoSHlxPG8I1VkC8e4G8h0zi1ZyCmMJfiveZNK1lxwjeINmqROcK+Qki/prSI+dI+y3P6q8KDJ7rq7n5UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125909; c=relaxed/simple;
	bh=LK4EDtnpnDwZB2WqvhVmmMEuMgMTbNxkPsRQXkvj5nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gj/4IpV40oTj3mPHvt3qMJmTVsZylrFO8xZB/9uyu3rELqZJwFZMo947anZ4WIFg/MJILJMSI1r3jx5h8cEuk8ImA/Fso3IkHFzoezEd8eaojhIJ9EZgQ8NT+r4brj+rFIGT7aA4yE6oek9/0hBn6cxv6fghxw88sKontemCRno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AAMg8Dnp; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539d9fffea1so4113355e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730125906; x=1730730706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LK4EDtnpnDwZB2WqvhVmmMEuMgMTbNxkPsRQXkvj5nk=;
        b=AAMg8Dnpbc2OO7wlXCGTLMuRwVooe7gRuklr3btvT59TyadwPMnxoBoH7HRB9oqgKo
         em6iqq/QeBQBWBqjKihDMngwjewcxV7Fw4AMNyiAKIXxypTS5wTpzT1nFWE94bI+uuxt
         N4RKWg70+DFHvGIgWP+UKJS7zmcjfBOF4T01juf7FlNNivjEOaBsC+nfe1on0GiA2jFM
         PQCD6LXsKdcds8QmxuJ/bNeU+FRFqdlyK3xK8mTLzahM7CEq4v6d0S0Kb7ZTRuOOGxp5
         qPt9tGsHxKkyoxc7unA3YRBjERoGWzeDUqTFLWOKKT1TE93sff30/bWUL3ntEyrSgRSS
         lbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730125906; x=1730730706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LK4EDtnpnDwZB2WqvhVmmMEuMgMTbNxkPsRQXkvj5nk=;
        b=H3DUdHd0E41sVhYCFrH6XQJfpcakR4ulblz+X7+hCQA46Hw8ZzofSWi18uuSgLHfh1
         pgikE6F7BaXQd7tAS1BF+P7h7yXnFoynsbo64hfFRAwKQe+SH2Urwp0zxHPqfvHbSzKC
         DPltLI630l3WoRkXmKTbJwu9hp+lIb02dOdUrRSyFx1lRkqakjg/5TAwLKKHrfJhk7kd
         F7Ij0gs+fOS2Cd1N6LNs5ZItit4QCVSuiIW3rmHlomGQnPxIHTSD46m4FVb2Y37AOOlv
         SdsBUnDrZiIvggrTnZpH5UJefMtlj+N99gWY94zHVo95BkNQs8iz8HZHUifKaVsMJ5nx
         /Z7A==
X-Forwarded-Encrypted: i=1; AJvYcCWySZv6yrpeMGsCwra7rx4MVjJhkrSl4xVtUByZdyNVorItfEnfUMxeXz4vDXaU6WH7WdV97NYtIWjyis4=@vger.kernel.org
X-Gm-Message-State: AOJu0YykvGBGjatg+YOwyTPEBSW5s6H7+SvlJcON//9lrXSAFmRbTmOK
	DMeStOCkMQCRG0hL7E03HRAIqwjwmQMJ7tCyY27zAX8lo1d5MW6ibOMsJWzg/qdp1gaWqjjDov/
	Nzt9r6giSEyCNLWk10uadTrdFkHWH4lkV0YfX7w==
X-Google-Smtp-Source: AGHT+IFyUKwlV/wfF3YLecBexq3ekHk95aUb6Zg12n9/6ksn7osAJtYYNlIOOAAduSgwHV67fKeJqngOSyOovEzf/Os=
X-Received: by 2002:a05:6512:1590:b0:534:543e:1895 with SMTP id
 2adb3069b0e04-53b34c5f77bmr3321159e87.39.1730125905664; Mon, 28 Oct 2024
 07:31:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zxr4nF-igbrmgq85@google.com>
In-Reply-To: <Zxr4nF-igbrmgq85@google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 28 Oct 2024 15:31:33 +0100
Message-ID: <CACRpkdbn=em2tTrAhYPhRyggjEK+O4QYMg4PrnHRibBhsAp=OQ@mail.gmail.com>
Subject: Re: [PATCH] Input: omap-keypad - use guard notation when acquiring mutex
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Tony Lindgren <tony@atomide.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 3:47=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Using guard notation makes the code more compact and error handling
> more robust by ensuring that mutexes are released in all code paths
> when control leaves critical section.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

