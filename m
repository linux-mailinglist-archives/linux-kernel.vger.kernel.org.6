Return-Path: <linux-kernel+bounces-260163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA0D93A3FD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA0971F242EA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501BF157468;
	Tue, 23 Jul 2024 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GEi5Rp5h"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4130A1534FB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721749788; cv=none; b=DLDd16iz+AHfOogmA5vJUClGDj9CLs7BSnsON8p/gzr7bJ/Mzu2gcqdawX3kjt+KQbaJHyGUAbcsoP9YHk5wNW152oAux2LN80aQXagK54ZRFRZckIqEInkHDBZA0PDr4nuFBOHAOaWI56eBt1n9NXWoCcnEQiRrvWrRUSN8Qow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721749788; c=relaxed/simple;
	bh=X4Nds+rNamt6o8AZtuKA3sluusWdlVXyP8txbmaaq2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hUNQP5UXP9SrjjyUsvifQ+xC5ZF331Isfg4ehDRcTzKXsBtjgOVQfKR1C0g11oO7y6Q9iQuMY0kU7Gr3ILLhiLG+K2tSvkNIWSA4gk4KOlRKREH1Uip1W4YIJPgZW6Uy4JJYnW/jrE/WEZLEOPw7W7uPhQkaQ/AT7wgPPH8Jh0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GEi5Rp5h; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-38b3543541dso174765ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721749786; x=1722354586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4Nds+rNamt6o8AZtuKA3sluusWdlVXyP8txbmaaq2k=;
        b=GEi5Rp5hlu8rUR4ZQZ+tYk3kln1qTtfAFIsSKIScH3CbhoaM7neJwVFXmRr1QkKobW
         CQce6aq/5dVhTFD3E4zi4qY3JB9mfQdCJZvfK2ChqQ/KRsvs8CpVHryCg4Y4TSKtEs/c
         nup1JLvb1ReG2yE4X7AAKIvExRSxBQ2Sgar6ap2860nbd+oAWvV/svMZpHq0i3EQhZPl
         vnNhBE2BBs02mNTfjUGsfExJeQ2ZMqakDT5esMO/mvTpJq7D+vrIDcoWPSxn3E376LPL
         0Vkl+WwnQVMq5CdsJroIf5QtT8BxkxgapNji47xbyAzce4eI7zuenqoIMc6rdR/Z7JeN
         APaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721749786; x=1722354586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4Nds+rNamt6o8AZtuKA3sluusWdlVXyP8txbmaaq2k=;
        b=fPwC9PzPSrQoZjq0x55Ng6TBXJlQXzWv/mBam5ooQg/W1CMO+ONMpJHHmelc66h0dX
         AulGn1DmnkDE50B00hIvDUT394p3dzx/L6pkcAwyNCZEwQFcXXn1gjmJBOTcCU2nla+U
         OoWcxoDylrMl+WmZ0ykAPWdzTU6D0oVroW9oc5SaJGh11ZbkEHiT+CfDKe3/lXU1JOnc
         vQjxVwtpkAoBQm51rMM0K3gdBqfSqoDm40FLe/nMssJnS97ijZHa34caO1tQby+ZWLDG
         zXoWgRAnDVMEVZ5Y+iBImQeqZQRH9bukurtSoir2k0vW5Pyyby7XCfLjlzfWAbXBeKne
         pTbw==
X-Forwarded-Encrypted: i=1; AJvYcCWDKLHLgE+Wwh9Di4ntbIR5l8C0hdWY6cq3OgCueLa2Jsg3moXJ/NxwGW+QEUv9O1hqTZ4ynBkd89PX8HR6VRvY60LaTbwKwVI/UGQw
X-Gm-Message-State: AOJu0YxtR/+4TIusfkFPImyxgnIgVTn5ZqBLkmuV/Ve/pZDrA1eskF0z
	BSAZVZezBpsbPYZ/Sky5rSp3dzGdiE+eTtBMNwZRJ5gFK04hPxaAYBjqyIlrvepLbn7/lsqE7r9
	XfIUXK/EZ4m2SN34QPWzPVO6L9xmE32qij1e6
X-Google-Smtp-Source: AGHT+IFl0/VkX8PPNjlbtADQKyQ/N/HUEAfW/C+NwrwOVp90LbkPlP9cOIo2QjN4hq5sYZFANiFih58z927cWGi+zQU=
X-Received: by 2002:a05:6e02:18cd:b0:398:fc12:d70f with SMTP id
 e9e14a558f8ab-39931f3b179mr9948205ab.0.1721749786256; Tue, 23 Jul 2024
 08:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720074552.1915993-1-irogers@google.com> <20240720074552.1915993-2-irogers@google.com>
 <8c8da262-a398-41cc-9721-4e72e6b7e5fd@linaro.org> <CAP-5=fWwjJuHpTJDMtxKYGDa9Sjo-kHk099vBTW8N-6_GtMfMw@mail.gmail.com>
 <945e58b5-5012-45a8-933a-c1a192fd006e@linaro.org> <Zp_Ozo_Iyu1sgL9h@tassilo>
In-Reply-To: <Zp_Ozo_Iyu1sgL9h@tassilo>
From: Ian Rogers <irogers@google.com>
Date: Tue, 23 Jul 2024 08:49:34 -0700
Message-ID: <CAP-5=fXNvR-XaYAZrJKaX=nHU2FrmFKCYoX+UyEBv2=TNq4wcw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf script: Fix for `perf script +F metric` with
 leader sampling
To: Andi Kleen <ak@linux.intel.com>
Cc: James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 8:40=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> > Yeah I suppose it's strictly better now without the segfault. Could you=
 pull
> > in the test and update it to add -a? At least then that behavior will b=
e
> > locked down and we can extend it later without -a.
>
> Ian's patch really implements completely new functionality (supporting
> metrics over multiple groups). It isn't a regression fix, but completely
> redesigns the old "single group" feature.

I don't understand this, I don't understand "single group". I couldn't
understand the old logic using period. It is true in this patch and
others we've been trying to remove duplicated count values, such as
"saved_value" in shadow stats. Having a single value has led to things
being more robust, for example, counts getting reset in perf stat's
interval mode. The stat-display is still a mess, the stat-shadow code
is also still a mess with bugs in things like column header printing.
It won't get any better by having something as simple as a count
duplicated in at least 3 places.

> > I also tested Andi's V5 and still got the segfault.
>
> Yes the earlier versions worked, but they broke perf stat report.
> I think the right short term fix is to use V3 or so, but with a
> check that perf stat report isn't used.
>
> Then perhaps the new functionality of multiple groups can be considered
> over it.

I look forward to seeing the changes. I was trying to do a service
here as you were randomly jamming 0 in as an aggregation index and
hoping for some magic to come from it. The code here shows how things
can be wired up and it works, but just not in the way the original
stuff did because I didn't understand how the original stuff was
expecting to work. Feel free to ignore it and not see it merged.

Thanks,
Ian

