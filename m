Return-Path: <linux-kernel+bounces-177681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 236418C42F5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5BD1F21B12
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAA0153835;
	Mon, 13 May 2024 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z93enhUc"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7138B15381E
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715609657; cv=none; b=jU72qCwGELn9sLPFY4NncXJ9QUv2RzAlLXalqlIrFXohzVN7qoT/nL6O2N8/ELb44GMsRgkz0C2Pb2RELdsr7EBzOYyo84vLymjRScsJfIWLr2lAk7hEOZfWkp8ZVGCJE7FbV0QFR/kJkYcXKvC8cD0Et7Cz0NBTK1mXQl8O3tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715609657; c=relaxed/simple;
	bh=FB9V+vs5E1VQUhmCPHB+F4habDJck32zqBLt199+I3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7iyLFcQR72R2kRkYgg/m0rvfEXX39Q3DTCtAb7YqyDKSWagvswkbCoTgYNpm96HWNflsYeVCDjxyhD/ivZh7iQFm7Bsfo20AJGes2o7VQJ62CspyhwurJEBUDRAEZe/qLZRiCRoTL9m7GmcMpFZdl3+Oyen0cNd2r8LKxrbmCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z93enhUc; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c9958a9485so923031b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715609654; x=1716214454; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2UOBn2IF+668KdrcZrqcrK14CUBpiCxB9sfNMBwRB7s=;
        b=Z93enhUcs5q6v/kvwubU26jUlpt9p2dwds+1vZR8gA59/gBdWMBuMZD1ISXJcuiHJ5
         N/2vjfRVI/uaaYEke6olAvOUmSVBbVBYSjDxOWKrJMNgHd3bQnB3O84ya2k9QQoBPCG9
         5S7F24TctYrnjnomPyjVCwoAc41E8K9NZMybTtLDNHy6a8qe4NfLs5W5xMzmPcjo7zG6
         nDysdj8izHJkmJ2e+KwFPQ9loPrL58c/NbBWflJjk3nV4BGYiP9zCzkc5I7dCmxBFUVr
         qosV31JLKtd70CQgQm3SNvRl3MnjgO+nOhOSsKh9PY2KrxEZx1CpeTYXueKJzv6Ynkjp
         d2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715609654; x=1716214454;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2UOBn2IF+668KdrcZrqcrK14CUBpiCxB9sfNMBwRB7s=;
        b=EhCpBjUthx2OWpdwyJhYEKX3KM8wxLJOsLyO5KjhGwbEycCemp0diNYhzrcEvPP/Fg
         8HMfIFoTg7bN8T0xy/9JJsWv80PK9TxnxjF7TE5uuXQj1jmOEzPJOXCRhCBvWi5M+z1D
         tN4Wvv+yudQlELSnWclmBX9e19SuDSamwC6OiUD2Kcs/7qAKns+7LrgBsb8Z7Z9hcRYe
         lWza7ziAcw0v/RprTBJqfGdgzA3a4A76jt0PtImzjNJ3otgX159nfUHIiEQ5TPSQQuu8
         U0Bi+Td7Fp9YUSDS9KXmxuOM8LhkV09xCWCMTCcFO5fVeUblGf0gAiYzCFKCrmekVqoq
         Dlvg==
X-Forwarded-Encrypted: i=1; AJvYcCWI40tUloMISXrq84idST3h35UMQZaBnrRjPOUazg73h3xDJB0NFtrRoFZHiE5cnADcKSXaW/js9mPRF/fC7ZR7G5Po1HUu8uA/kC/G
X-Gm-Message-State: AOJu0Yy1HuXUWzHG82YA/5QCxkAD+KMz4GC5p7/zNSRTCwXxkZqvWSDw
	FzLqisJv1/Zz14+5rBG8K/9U9i8zephuwJdvr5ctbMSFvwnMwKaKveRZY/O/NrJSbQFD3uMl6NR
	fwGEHyhN6zkapAib3ehfLLqxyOjuwYCT/kYj22G6qnIBEpb4QLxB7
X-Google-Smtp-Source: AGHT+IGu6SKrlKrLBVpI5R4Fi+Tdpwzzi1hi7Ih528iP/NR27zuc68FroGIgKA8luFoPZtoMcHDGZD3nlymLqxVlv+E=
X-Received: by 2002:a05:6808:358:b0:3c9:66dc:1a7a with SMTP id
 5614622812f47-3c99707247emr10272851b6e.32.1715609654266; Mon, 13 May 2024
 07:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507093530.3043-1-urezki@gmail.com> <20240507093530.3043-26-urezki@gmail.com>
 <ZjpAsYJIfzYSKgdA@redhat.com> <4c9e89b5-c981-4809-8bc2-247563ce04e9@paulmck-laptop>
 <20240510131849.GB24764@redhat.com> <20240510135057.GC24764@redhat.com> <474ae55c-fe9e-4668-8f9b-23f819c76d10@paulmck-laptop>
In-Reply-To: <474ae55c-fe9e-4668-8f9b-23f819c76d10@paulmck-laptop>
From: Marco Elver <elver@google.com>
Date: Mon, 13 May 2024 16:13:35 +0200
Message-ID: <CANpmjNMUJ6UMwWAEHfm-7WZ=jKD56PH67Zp8dB6B=fEysiK=Hw@mail.gmail.com>
Subject: Re: [PATCH 25/48] rcu: Mark writes to rcu_sync ->gp_count field
To: paulmck@kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>, 
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Hillf Danton <hdanton@sina.com>, Joel Fernandes <joel@joelfernandes.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 May 2024 at 16:11, Paul E. McKenney <paulmck@kernel.org> wrote:
[...]
> > > Does this mean that KCSAN/etc treats the files in kernel/rcu/
> > > differently than the "Rest of Kernel"? Or what?
> > >
> > > And how is it enforced?
> >
> > I can only find the strnstr(buf, "rcu") checks in skip_report(),
> > but they only cover the KCSAN_REPORT_VALUE_CHANGE_ONLY case...
>
> Huh, new one on me!  When I run KCSAN, I set CONFIG_KCSAN_STRICT=y,
> which implies CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n, which should
> prevent skip_report() from even being invoked.

The strnstr hack goes back to the first version of KCSAN released in
v5.8 [1]. It was added in response to Paul wanting the "stricter"
treatment for RCU even while KCSAN was still in development, and back
then syzbot was the first test system using KCSAN. Shortly after Paul
added a KCSAN config for rcutorture with a laundry list of options to
make KCSAN "strict" (before we eventually added CONFIG_KCSAN_STRICT
which greatly simplified that).

While the strnstr(.., "rcu") rules are redundant when using the
stricter rules (at least CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n is
set), we're keeping the "rcu" special case around because there are
test robots and fuzzers that use the default KCSAN config (unlike
rcutorture). And because we know that RCU likes the stricter rules,
the "value change only" filter is ignored in all KCSAN configs for
rcu-related functions.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/kcsan/report.c?id=v5.8

Back then syzbot occasionally reported RCU data races, but these days
rcutorture probably finds all of them before syzbot ever gets its
hands on new code.

Thanks,
-- Marco

