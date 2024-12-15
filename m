Return-Path: <linux-kernel+bounces-446299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E808A9F2244
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 06:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5907E1886E47
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 05:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12FD17BBF;
	Sun, 15 Dec 2024 05:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aDOrv1gM"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A785CA6B
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 05:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734240057; cv=none; b=NRaN8NZjXdGXCVioLkDRDQO/S0hc2m5429Cg7ermCkpjMcHbupYxRCv23E7KqZLjmjXdFG3/oQtA1SFilS71l1OWdi20+4ZHa3FqXQP8VsGxd/amVyig3EYbBsHnW1jZm8S240BuIp4GQvVPMoKK91D11KNoaU+N+d7eDGA66MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734240057; c=relaxed/simple;
	bh=Ltjwz/XO7//43l51lHbe02NSZUnZYBRUH2GyAsi4rs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+RNrj8Zdejf6SflK9qP7jm2YcLpY5Bz47AAeh2VeSq3Aes7pZHNroilJCBjKCwrrpjQrm1BU4DM4RS27wHry0RVnP6iXSbnYw1Al42CGNVqCunK0plMR9PqW4nBOogvp6aJ1gmKpNePgnIGeHqxTg3dBTp5D8kl3UcgiEaYV4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aDOrv1gM; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d647d5df91so3164888a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 21:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734240054; x=1734844854; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p0oWhzbRv4ivtENhrLib3Ss1yzhkHaNRWs6vOjisUSI=;
        b=aDOrv1gMQaSyOb5GtCpRcvCvSQ1nD1CgE4dd5fQRNyNYRFui6ZJD5DVIrtPkuIb2Wy
         xpJ2cuWXuND5QSRDXJ/jS/o8Hb0qBQViT5MYN+CKCRadYVN141yjF2O+M/iws034goOT
         niHseuXOHMrdSL5zBVwyU2nMcWEekfVpc7OFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734240054; x=1734844854;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0oWhzbRv4ivtENhrLib3Ss1yzhkHaNRWs6vOjisUSI=;
        b=ss1/26I5oT+ySttkhlE3iP9BeDdgQxoDAWglBtl2G917GlxcWlUqWz3A1XkAYmgILO
         KLdaWCVXWEtTJY1mJlgFy4f3pYdk/rn7iXMfjrosCnYJsO6XLES1jIpxqVp8zQ3e5P6U
         sYvb+zb/ixTTUIbnTJ5NStuEdIcmv6y2Q2XFBOHkBAR3qssG2hckMpGWITGyjuJr1R5E
         TrBE5SfbDykuo9H+FtwKUpOdNDNSYeNLfLuE2DBoWjHCnHsfkU+3/+Ds2OQ0YMELWQlN
         VPF8jwWMp08JIK5ir+eOjg/t0IjzvPqSiMocTKXevWAwrwh4S2KGvhH6XKgXiUBzfbSE
         XSBw==
X-Gm-Message-State: AOJu0YxBpeUIUtNteFmpRHD8bUMFF4AQZomRZsazs2EDEOTmuxzhcura
	g1QPOtDoyr5kKIMESwzt7hEgy7fZ2wHhtaZhlgFpYMcpH+Yn0pyGmGTGRmHXmiCqBLWrwbKJ99r
	L1+o=
X-Gm-Gg: ASbGncuWjZzzzdIrgpsgPQiIXJ9w6pOoWmvLiiDULPO607mWGkQasBewtlDi1HBRVhU
	2I7Ut8PPhzz5d9cV0LfO0xzpWBqhD1BzvfR9NCy1QI4EMu22aifgRQXKItdmkf/tFQy5C9cSZDb
	5EJf0RFVTJQgEAps6ccDwAhI7qr8BodFbjyN7c24HJ1FTB0ulQ1oU1u2V9GIto7jm6Rs/O0Uiy1
	wRQVH3kpb9qLZPWE/P/afSU7VttpEGtNOzZjA4OW+FADqC/sK5AbhACbisczuExZK3EEThPv6Mr
	kN4pDhw4d0nPAOWUIi6vB40TjnggHn8=
X-Google-Smtp-Source: AGHT+IGI0AJtypbhRG2bgy+nnmDR4nrCJX+se2uuJgjvnJBdaXrPwKf+zYcJXRrRZ6vNhP6RJKAGQQ==
X-Received: by 2002:a05:6402:370a:b0:5d4:75b:8ced with SMTP id 4fb4d7f45d1cf-5d63c3c181fmr7679311a12.32.1734240053696;
        Sat, 14 Dec 2024 21:20:53 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652f25afbsm1732266a12.55.2024.12.14.21.20.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 21:20:52 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aabbb507998so8320366b.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 21:20:52 -0800 (PST)
X-Received: by 2002:a17:907:6d1f:b0:aa6:b63a:4521 with SMTP id
 a640c23a62f3a-aab7790798amr880311266b.15.1734240051722; Sat, 14 Dec 2024
 21:20:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214182138.4e7984a2@batman.local.home> <CAHk-=wgyWEbWa9k5=z4LxY1hx0Pxqf5TQQC_BKme_+DrzGufKw@mail.gmail.com>
 <20241214220403.03a8f5d0@gandalf.local.home> <CAHk-=whrxZwrdm2zHrTmEdRoiC_29XR+0nJpq2CkZjm-ZdOTNg@mail.gmail.com>
 <20241214232333.3c49c1e3@gandalf.local.home> <CAHk-=wi63xXZiCUsMC_3JCuBbYNT2wSiF0JE24fKbyS=yGu8hA@mail.gmail.com>
 <20241214235320.0b01d809@gandalf.local.home>
In-Reply-To: <20241214235320.0b01d809@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 14 Dec 2024 21:20:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgoGjv3Mw6B7fpjrG_psaaks7FVrPgFO6wbCSAY-96_hA@mail.gmail.com>
Message-ID: <CAHk-=wgoGjv3Mw6B7fpjrG_psaaks7FVrPgFO6wbCSAY-96_hA@mail.gmail.com>
Subject: Re: [GIT PULL] ftrace: Fixes for v6.13
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Michal Simek <monstr@monstr.eu>
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Dec 2024 at 20:52, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> But main code of trace_check_vprintk() that you appear to be objecting to
> is the hacking into vsnprintf() that was added back in 2021 to handle the
> RCU and other events that point to their strings. I'm not sure how we can
> check that before hand because we don't see the pointers until the event is
> being printed.

I'm objecting to ALL of it.

It's a debug feature that is *broken*. And not in some kind of subtle
way. In a very fundamental way.

                  Linus

