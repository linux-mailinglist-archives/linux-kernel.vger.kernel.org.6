Return-Path: <linux-kernel+bounces-571287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE854A6BB65
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15D97176268
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4874A226D07;
	Fri, 21 Mar 2025 13:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTdwCIob"
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406271E87B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742562245; cv=none; b=lS6Bn6q6dTxVuuBm3bCELj0K89O0p3XczcqFhcHf5y9wIOrLx4jXqNF9THyxVFfkDKrTq9KWPlxFm8eqijoMCLYHft6cK0VI+ZN55TqWmtNZKWTFiN+WQ6pUC50PqHHAWIoUvSEPYVY4GUAYa4t6RaeZ36vKNkx2iy65uhG9kRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742562245; c=relaxed/simple;
	bh=0pJdJ1Eyxs+PrwuAINvPMf3NQuW4WJqZKbUbk34P1F4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=p+1wqwjp7zApsK9gZHhTf6FKacyOHtfHoRflUIxll7/cx4+GIdVjW7qWIE2a0zD53+u/v/3mEfhJj4g1MQjebgUCLXTViDkbIkywt30FXLgTaUBmOxjsL2q+DbiVyBLv8t4IH3idk6xpJWyZnTk/Ca1yFn0WpcjEp4IBJ4/Ecf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTdwCIob; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e637669ef11so1307466276.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742562243; x=1743167043; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0pJdJ1Eyxs+PrwuAINvPMf3NQuW4WJqZKbUbk34P1F4=;
        b=HTdwCIobeUu3r0WaHjJ+2pCia2Kxk2k8M9IwU3O26b+AWH5EauztA252GzT+38Wy9C
         mX94LtmtpqzuCKmsyl9tXKKlWJEdH00cD4GUMNeJMvw2HWlI4gFTkWa7BEfUrLF9ywHk
         5gmBWqK0xjSYq2UVph68E7mKRpUR9d5njcXaIVMajV2W2QjDA3V1g1S/ndD1X/GdOVHf
         EYlrc8PLQNpRzG8uuqvtOGyq69QTjlkaX4uRMKOgSybb7tudhbGzPr1LtKbeGqDkerwg
         /Z9H76oyGzNh+QE/ATkdh3ZffLP29wCeZVeI6zMMJJPrEWvWA1gn57TUrVfumsd9ep/G
         MMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742562243; x=1743167043;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0pJdJ1Eyxs+PrwuAINvPMf3NQuW4WJqZKbUbk34P1F4=;
        b=AI6OASLYszmlZBzUQ4AH3GIHceiAWUbK5sePA+e5TS3849sqgg1AifIMJmPvOr0TyS
         SN1G4kS+ET9/Q/CpIXD73zpBMJXPuspWsozy2/GNJpYyLmppWdqdEt6dRjJXDjKbdO9f
         gN+Y1RQ8+Nt7OD+9AI/h40aSK7agk7Ud8mZ5Ok3lVHK/xNnQh7n2qS6BxjNWLbLBOMjW
         xVuwJyVr0olgbu1jYRnPkOtMEk+SpYt2b4hd9crNOUAaL4i1irLD+33ypqqd9koR9/cq
         7xGzdInUMRIEyaq2Y4om1xtUv1p/HbsP2Dt24tdLf4JJ0N0E/PlJ8KW+N+CB0lftXJuC
         YXQw==
X-Gm-Message-State: AOJu0YxBYwrrrGi5y6Yf+3ClZK5wDvxoh1tOwqcgdus50Uf9xWD0hj1I
	+tRWgjm6Q5LYD1f0SeBUlgLOy5Kl5fuwxGW5d41umRdt/XqdytCKdfj9gK1xxOrvIBVYYx76LJ3
	vQxDpuwSFS4Ez/3MGnpiZNi5Q0DfMDgcTs/M=
X-Gm-Gg: ASbGncuGCiux2m4Y1z45OnD3ruz/mn7A3fu0MdGdjYs6cLv4aDlp1hCblADBgAjc4oi
	2Sc29jQuDmIGouYsiBYVZSYdTr6qzgG9nDK9tepFdHvZxzC95MpcLeg3PT9iA2wNR/FrCtOlKhj
	PJzSu+N5pWAmGEkmWKfv3OY++GYh5M+Xl4iOxAZJ0MvuwMTUsU66GEPVtF48ED
X-Google-Smtp-Source: AGHT+IHlAKBYZtfTQEj2okUPDYjXZjOigHyCCWxiTb/sOZWsYvPLRMM4De7i9pMbCxEX5jU8rwnOOKhXGekB24h/kpc=
X-Received: by 2002:a05:6902:11cf:b0:e61:1b54:2d1 with SMTP id
 3f1490d57ef6-e66a4e13fcamr4033767276.27.1742562242904; Fri, 21 Mar 2025
 06:04:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFf+5ziUY_gLJGMHKHHB_w8aq2KP+EZRK0VdoxyUtkBH=-EKPw@mail.gmail.com>
In-Reply-To: <CAFf+5ziUY_gLJGMHKHHB_w8aq2KP+EZRK0VdoxyUtkBH=-EKPw@mail.gmail.com>
From: Amit <amitchoudhary0523@gmail.com>
Date: Fri, 21 Mar 2025 18:33:52 +0530
X-Gm-Features: AQ5f1JqXG47IM-nAatVjt1yp_TZA2ja9fws8vzLVP6QZQskB-fF478wvC3Mw2ZA
Message-ID: <CAFf+5zgwEJ_Rzv9GM0yPSaRTXw+w15NgGK1CWj5zjDW+DZ03kA@mail.gmail.com>
Subject: Some concerns about allowing Rust code in linux kernel.
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I have some concerns regarding Rust code in linux kernel.

Many C programmers who contribute to linux kernel and maintain the
kernel may not want to learn Rust. I have contributed few patches to
linux kernel a long time ago and I also don't want to learn Rust.

So, what are the chances that 10 years down the line, we will still
have Rust contributors/maintainers for linux kernel?

What if Rust kernel developers abandon linux kernel 5 years down the line?

There are tons of C programmers around and they will be around because
OS/Networking software is written in C and will keep getting written
in C.

What is the guarantee that we will have tons of Rust programmers down the line?

Java developers are not going to learn Rust.

Only C/C++ developers may want to learn Rust but then the question is
how many C/C++ developers would want to learn and become an expert in
a new language? And then how many of those will actually contribute to
linux kernel?

I am not suggesting anything. I just had these concerns, so I wrote them here.

Regards,
Amit

