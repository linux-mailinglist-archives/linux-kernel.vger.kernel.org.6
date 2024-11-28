Return-Path: <linux-kernel+bounces-424549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8333A9DB5B3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39615160E5D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DEF157493;
	Thu, 28 Nov 2024 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WGJnH+Mi"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE0515854A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732789700; cv=none; b=dEuMZsKeexwwWfVz4L3Vc3UbhfNwwZTw8+HZwg7M2bRnEMcpyurGJh3J7PMyKuc6/MzW1wk85Y5oBSkJYtBlWZX0VVxA8jP+jJkALkaYumgHnelXtS1CNwD5MAtfXkOuk4HzK4VmLQSmsRK//cKR1MofF6SLyvh4ruK2xES2Du8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732789700; c=relaxed/simple;
	bh=xBez7rpBLjMzyjYwf7HZa9dlrkgJrg+yAQKT8Au5N6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsVQ3sM1sOSehpbVv5pn6/KKpXalRssHY8SyTKyuqROxlsLO3NoC5V9K45UJ3PtvcmDAeZHJb4jXNyx5ZjNxoDL7w4M42KzfizLK3xq8g/HR7JtW9kHRsVncAxEvgH3OyR3yZWyJWIUiizypQof8CJD9Rs/7Gs408xDaRTkmg4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WGJnH+Mi; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-8574d696055so151030241.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 02:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732789698; x=1733394498; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CKy9NFeqlqcw1t7BKiitB8spU33tefaJ6SaLKo921pw=;
        b=WGJnH+MiNnbq8GdTtyvTArrp29CWeieCAwYA18o+6AxJcUfuCp9Joto2Ey0eXVB5Xe
         40Gxi+4YKGtbmw1KJ7zp3U9PSuLRHyIYMbSoUC7mOv2M9QYFUrQrwnf9Lm/jWVUTCk1p
         G1W1/HI/ImWEv97USJwNtRVnTlIiWxiL3DN/1+DQNGf2OGva7hzYmlNDBKQCcahkpc4z
         mSlN7D6qOiDfg8pXslIGbpjpGddCV+med1Lv0hFDhb9h8vKZXHFooZyIuGZa7/Mlq9qt
         bsbqq1qTtBbGSag8AzMBwqk4i87GIB2UOu+kWVr+VuSStWpdz5vM3A5Vu1fk7JOxCg96
         nVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732789698; x=1733394498;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CKy9NFeqlqcw1t7BKiitB8spU33tefaJ6SaLKo921pw=;
        b=qcsuTnYvYdtsL+ao+ycFUayfND32B/4+3u3PSSL55PoiyTE+WsLXtIwfZWFiy7DEfN
         fMQ3QLAj94ol5nkb7w0Hby1otuWFeaeCZ/PQNCaFn07p5W7shVkdKS6lekRA/cOe///F
         DZS8deaJ0dhkOTkg0kPTwcl5g58zBNDro1UZdYpDrlROT6Hm6+AHtJ1hFTsMdddiCFZI
         Ok5bvbk5eIUffKsQnnPF/++YmnYThH0rd6abVuKCtLAnQ3ueFIQI7KbVs/XX7jy2hUNK
         Iv8wcJW5BBTXg/FXCctxu/9+ANBCIQ4WGwS0g5S3QiucZUeXmMhj3Mf61qA98FSlgzdB
         oGKg==
X-Forwarded-Encrypted: i=1; AJvYcCWXAOQ6s+S5gmeUUxp1WGMZdMJfguQp8HVM5cNLDuYpDHrooJVx4DPT/obCftvJgu80jWcn6AdgSeeG4NU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZn3RWp5b5AZnVNJKwlM2Rk223SSRWngiIkaTbS+R4VOAUiRsH
	K62nZIqGmqO1dePBMKKODa97O2aRsAR23u4O+HdSboTqvec3PEKAc6R5kAjX02LAxvUkrLWScor
	8Jv4ev65u5BdWzNwzC3WhhoZLxvjxABfpefT4Mg==
X-Gm-Gg: ASbGncv1wTVXnDPMS+TLqg0ZEOJudJQ//E97uFjs4Kar4BthDYGBu1cUXHzZ05q1lo0
	wJGOoFYSC6WHc2wEvuZgYe/vdvb0Obdtqew==
X-Google-Smtp-Source: AGHT+IHNjCHSookykhJ0jiELmB8RMX1pmwKtceJGivKe5r9uvyYhkK2Li/fKdNaKGIC1FiwJ9jTRq09+7ToPFKBO6rs=
X-Received: by 2002:a05:6102:82cc:b0:4af:497f:aaa4 with SMTP id
 ada2fe7eead31-4af497fac19mr5014052137.4.1732789697607; Thu, 28 Nov 2024
 02:28:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYs+2mBz1y2dAzxkj9-oiBJ2Acm1Sf1h2YQ3VmBqj_VX2g@mail.gmail.com>
 <CA+G9fYvh8n=CTCmcCdLViH=o-UXH1Euncn+7YuYkvt5O-k8NMg@mail.gmail.com> <20241125154235.GC2067874@thelio-3990X>
In-Reply-To: <20241125154235.GC2067874@thelio-3990X>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 28 Nov 2024 15:58:06 +0530
Message-ID: <CA+G9fYshK6+AuXSnu7c=j+QJ38kN6O6t7B=DdzqQrMN_rGsJhA@mail.gmail.com>
Subject: Re: pc : qnoc_probe (drivers/interconnect/qcom/icc-rpmh.c:269) :
 Dragonboard 410c - arm64 - boot failed
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>, 
	Georgi Djakov <djakov@kernel.org>, konradybcio@kernel.org, quic_okukatla@quicinc.com, 
	quic_rlaggysh@quicinc.com, quic_jjohnson@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 21:12, Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Mon, Nov 25, 2024 at 08:43:44PM +0530, Naresh Kamboju wrote:
> > [Small correction]
> >
> > On Mon, 25 Nov 2024 at 20:33, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> > > The arm64 Dragonboard 410c has failed with the Linux next, mainline
> > > and the Linux stable. Please find boot log and build links.
> >
> > This boot regression is noticed only on Dragonboard 845c.
> > Linux next-20241125 tag.
> >
> > Good: next-20241122
> > Bad: next-20241125
>
> Can you bisect to see what change introduced this?

The bisection did not provide any good results.

I have been tracking these boot failures on db410c and then the boot
test got passed on next-20241126, next-20241127 and next-20241128.

Boot test history:
-----------------
-  https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241125/testrun/26040307/suite/boot/test/korg-clang-19-lkftconfig-hardening/history/

- Naresh

