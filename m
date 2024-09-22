Return-Path: <linux-kernel+bounces-335248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B00AF97E30F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 21:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3F01F211D3
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 19:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C66F4D8C3;
	Sun, 22 Sep 2024 19:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="USieU2LE"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5765D2BB13
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 19:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727034669; cv=none; b=HPWe+Pbmv0OhNOOJEMCNVq1impTeFDjWgDubqUkc8IyOrAJ7PRSsv0Nldq4e3WPoVk5zZKUYZJObhLG/LJWNkkv81pOWNqmCgy00ttDqRT+vjplu7v922kVZX8QIxcJXFeJ+LoROwOHXWwb5CT0F5R0T7Pry3cKUw13s0w6JisA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727034669; c=relaxed/simple;
	bh=dysrqieFCLvjuMXlh4VvFMyQkvPunx3IEGVcSb6VrYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5QxlYj4JbGsFeccnzBvdgj5pJZr0jMuOTY+SGmr1WJtm7s0UHaZ4fxjhqydb+lCiwZU39y4YlXsXYXzjxgluGGCpW4RxAoxXn5o/0sE2LcjTpReLll7MRS5Z/nw0jDYbpnhRz2tajtpgpimB9RJQXfTA/dD866BHhM/DlNVnR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=USieU2LE; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c4226a5af8so4896202a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 12:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727034664; x=1727639464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RJVp1Rf9h97g7u9Ya08bmXWVz0V+212p6C9Iyxo6fCU=;
        b=USieU2LEWqpAwRhWm8pdLChDql5vaBoNtKP+pW9VCzfkHcl1HQM5HxitVv/0zV+EcL
         Y808tpRMg+o2s6o51SPnzfwlHqEa/yHVwKqMX1ZCMq9BpWwkpcDO8WdCMqikp+AYDhND
         44sbI1pebNi43d0TxQyLBBPTTbzyUgd0GP4bE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727034664; x=1727639464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJVp1Rf9h97g7u9Ya08bmXWVz0V+212p6C9Iyxo6fCU=;
        b=ZA6FLT0IyNZgpXyiPSrZ8CryNcISwJ4R0qu2HJG2ui93LXb8HCV6ksFBs6IS7In9+B
         dS//DcC1ZZkNWOgOoHpHKM98uL+5i0fDgYBQkIX1glYMXxrRq860ruqHM7+7eYqIvX6S
         /qjN3pB4ZFMXHO9gWxngE/ZN1MHyCPcNBC1GgnqzrtiES/QIpxBm2Gow05q3asbPh24y
         OdpWnU56T8Xls49/uuAIv5yb9vn5+0kNhL9tmaOXdfyLKxAGBeJVFEuD6lr2g/JEVW2n
         8PIhvrN224J7Lr25NEPTqcf3PacYvigQMr34/qkgeu1b4TDydDbq2CeYuc/eZcTChGp7
         96tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpHCARtwsUgFvWDoEykz1OZIpBHkJdw7OwD8lSPZH83jCF8bKk/HP0FDLgqtF1+Pr5bwc6CV2nPW4jyxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrNcEZ7q5WJi/+CDyKsj3v6rrWQWK8fpAcqF0HoxDBm4m+BV/t
	4uieQ3UKNcAxgphxggyC81gD1v3iQPy/IJe9b1B76rOE78ANqUhExIWkzFGsgUViVJvz+kguRC4
	zKN4=
X-Google-Smtp-Source: AGHT+IHNN9XUVSgivENIG44mAvxi6vTq49izAzbkvAKswH+VifeN8xgMCc+QL15q+z1QGoDEieSRcw==
X-Received: by 2002:a05:6402:2695:b0:5c5:b9bb:c4fb with SMTP id 4fb4d7f45d1cf-5c5b9bbc64fmr4125289a12.14.1727034664369;
        Sun, 22 Sep 2024 12:51:04 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb89e97sm9498372a12.65.2024.09.22.12.51.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 12:51:03 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a86e9db75b9so583897466b.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 12:51:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWVff4glhMrI4BBqoeOBmHTszsGp39yOcWd3yDo+Fc34ccDDn1dVJw6PFydeBnXtKpkWKl2yvuPSLpGEwg=@vger.kernel.org
X-Received: by 2002:a17:907:2cc7:b0:a8d:29b7:ecfd with SMTP id
 a640c23a62f3a-a90d5157361mr1240658466b.54.1727034663286; Sun, 22 Sep 2024
 12:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZurLc9qEjBH9MkvK@gmail.com> <20240919082624.05ca5fd6@canb.auug.org.au>
 <Zuv0kA-um9ZT-Tjd@gmail.com> <CAHk-=wiz_57SsfaX1JkmDJ2sMo9Pfiq27XciQeh7GE3tDBVDFg@mail.gmail.com>
In-Reply-To: <CAHk-=wiz_57SsfaX1JkmDJ2sMo9Pfiq27XciQeh7GE3tDBVDFg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 22 Sep 2024 12:50:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjrLPDVMu2Bj+01XmZF=puP0nKXbLzC40fe_enGDdcBg@mail.gmail.com>
Message-ID: <CAHk-=wjjrLPDVMu2Bj+01XmZF=puP0nKXbLzC40fe_enGDdcBg@mail.gmail.com>
Subject: Re: [GIT PULL] Performance events changes for v6.12
To: Ingo Molnar <mingo@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 21 Sept 2024 at 15:39, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 19 Sept 2024 at 02:53, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Thanks: I've queued up the fix for this ARM warning in perf/urgent and will
> > get it to Linus later today.
>
> So this apparently never happened.
>
> I'm back home now, and so I now do my arm64 builds too, and it is
> indeed failing.

In case people didn't notice - in order to now do my now usual full
builds I just took the fix directly (commit 673a5009cf2f: "perf: Fix
topology_sibling_cpumask check warning on ARM").

                Linus

