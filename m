Return-Path: <linux-kernel+bounces-300490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1AF95E459
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 18:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAF111F214B5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 16:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A1E15538C;
	Sun, 25 Aug 2024 16:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZG/DyatI"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140181CD31
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724603083; cv=none; b=sWeA9gFhpjMiMpq4S9g2eDRAb7TD8tpbLYTE5XeOjk9OXQVVV15EfGVqbooqGbORsopCDLumZdsaqMiiLtIk5HNhupRGpahYBi1w4rJa7RtTFUVTfFzWbKjyl1N/N1ItvffJnOoPA7QIIG0nxNuuaHBI90780HHvS7Dbxca7ueI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724603083; c=relaxed/simple;
	bh=KJ+Z50j8sUoBHy3hhy960h2rh2ePf4Ly0jSUPqKdGDM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=OMEdP4Xo8zRZ5eRHTmoIR9II4omZiq8i8OV7rAB741IhjEDJv9AxaoxK0vMbbbhJTpy8SHgkIuoExwZQ2ZFESxMgO9JfgsYEI0D811+jir8oc9IT+sZgCSg/kDN/lvNrMf+Qjq8arPqL4RYgMBIB+8W38QX6kf7QGmfBL+u5xhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZG/DyatI; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f3cb747fafso38064121fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 09:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724603080; x=1725207880; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6XomT4xNhYnUhlhJpfg6DQnFwYDy19uzJG9jCJSIOE=;
        b=ZG/DyatIs0Cu/sia4ttT6BxgT22HDLV5k3QtJTZWUfUHIh79hTrn4vpdKiD1cBCWeR
         s1V24OJ5TfJF+L5rYMoQspb6udvjqd8/houerMkJaZwUrBReOFJja0N3BDmxZGgYaIXS
         J8rwhVNlPFqTCHxT6+zYQuWY8eGq1CckKHkvTNOmfWqG4IDfdeD/kp1oUIcY8aRNc4oX
         k7Yf18oh/H3n57T+tCHx0AERM6QYv5gWIpku7H73gP8wc6aDobqRwM2aVugCmicp7cwC
         13VoImLc3I13d+Yy2ner2dA6bKpBHW6BR/hE8zjoAzYIU9f8kyJuJCbQe+Bd6clLKi3q
         EBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724603080; x=1725207880;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6XomT4xNhYnUhlhJpfg6DQnFwYDy19uzJG9jCJSIOE=;
        b=kc+bMzFzu2BCWZeXLAK6DJE57SRtJms5mzQHRsjA+bWGgz5PZaznlek+zDYcXxLIsj
         +R46l+UBtvnawLJXbcPH3Eaz3JDMy8b6+wiV7I1PjoIC4iajuyAlZFMIh/GqWTFcRYeE
         eTmKiB18Mft5fSVG+ngAxJbWM4d1jZ7Y98af8hz/vqk+YqNnuHe/XYvWYdpUiz+BIOWx
         MaqsQM/ZZGt+F5rouMZfubevMtMmo4B8u+hwdsmLLjXdGHUr3SPGdXdNRWp3/kCwpaRt
         UTeaWVaEDX/yBXmLE5QkjIVruFYxrX9XxWeV8w+LqwhU6OGkXfgWRSHzzXVXAxIoHtqL
         RE9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNK8aIYSaxLBepA6Z6knexnLE7NHB49jSbSR/baQDb8FftKx0w77z3IFl0jLw5+Gp2whrJ8n1q7CE3jUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrlPzMLprRaVF3cJ2Jcyr15sXjuYcIPzqK7vYTuBESAZ3hdXsy
	JLVA1SuRBmyMspuFrQNFhUWxuQ4XEBejOhst5Jlu1x0+N6lJ6vXb
X-Google-Smtp-Source: AGHT+IHTCz6agKZpn/0TM6H5VB1xS4o1qPHzlO6+ruqCMC63cLFJxFAOns8FPsvm6zqLp2Zk54MvFg==
X-Received: by 2002:a05:651c:211a:b0:2ef:2006:bfb1 with SMTP id 38308e7fff4ca-2f4f9dced35mr48808711fa.15.1724603079772;
        Sun, 25 Aug 2024 09:24:39 -0700 (PDT)
Received: from smtpclient.apple (89-73-96-21.dynamic.chello.pl. [89.73.96.21])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f4048acb0bsm10663581fa.125.2024.08.25.09.24.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Aug 2024 09:24:39 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [regression] oops on heavy compilations ("kernel BUG at
 mm/zswap.c:1005!" and "Oops: invalid opcode: 0000")
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <oophwj3aj2fnfi57ebzjuc536iltilmcpoucyms6nfk2alwvtr@pdj4cn4rvpdn>
Date: Sun, 25 Aug 2024 18:24:28 +0200
Cc: Nhat Pham <nphamcs@gmail.com>,
 Matthew Wilcox <willy@infradead.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Yosry Ahmed <yosryahmed@google.com>,
 Linux-MM <linux-mm@kvack.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3D1B8F1F-2C41-4CCD-A5D7-41CF412F99DE@gmail.com>
References: <BD22A15A-9216-4FA0-82DF-C7BBF8EE642E@gmail.com>
 <6f65e3a6-5f1a-4fda-b406-17598f4a72d5@leemhuis.info>
 <ZsiLElTykamcYZ6J@casper.infradead.org>
 <02D2DA66-4A91-4033-8B98-ED25FC2E0CD6@gmail.com>
 <CAKEwX=N-10A=C_Cp_m8yxfeTigvmZp1v7TrphcrHuRkHJ8837g@mail.gmail.com>
 <A512FD59-63DF-48D3-BCB3-83DF8505E7E0@gmail.com>
 <oophwj3aj2fnfi57ebzjuc536iltilmcpoucyms6nfk2alwvtr@pdj4cn4rvpdn>
To: Pedro Falcato <pedro.falcato@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51)



> Wiadomo=C5=9B=C4=87 napisana przez Pedro Falcato =
<pedro.falcato@gmail.com> w dniu 25.08.2024, o godz. 17:05:
>=20
> Also, could you try a memtest86 on your machine, to shake out =
potential hardware problems?


I found less time consuming way to trigger issue: 12c24t cross compile =
of llvm with =E2=80=9Eonly 16G=E2=80=9D of ram - as this triggers many =
heavy swappings (top swap usage gets 8-9G out of 16G swap part)

With such setup - on 6.9.12 - i=E2=80=99m getting not available system =
(due cpu soft lockup) just in 1..3h
(usually first or second compile iteration; i wrote simple scrip =
compiling in loop + counting interations)

Then i switched back to 6.8.2 and=E2=80=A6. decided interrupt successful =
test after 14 iterations (it was 19h of non-stop compiling with heavy =
swapping)
(sure - i can still keep test going - but builder is also needed for my =
normal development)

So summarising:
-on 6.9+ just 1..3h seems enough to provoke issue
-on 6.8.2 so far never in past + currently can=E2=80=99t provoke issue =
(last day in 19h test window nor 5 full distro builds nor last 2 weeks =
of development)

By above i personally don=E2=80=99t believe issue is in hw (ram)


  =20=

