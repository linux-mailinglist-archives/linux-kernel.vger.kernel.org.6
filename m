Return-Path: <linux-kernel+bounces-293130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98276957B1B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E73C1F2345E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 01:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497021BDC3;
	Tue, 20 Aug 2024 01:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VBLER97S"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B30168DA
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724118385; cv=none; b=i0jlUzLRKLTcndoOJgsV+KABkr6QT+qc7WwmVBlMVPi8gUyd/BvADNPx67yCKJ6jLR2Lf0hGKfmbtp8uvkGHzxHazbT00Kb/q5NJGxYFng9v3mPyLnKv02raD9ILQ6GXC2ltFIXEKnEG5tQFeOM66oKDMoRCPJ2ECmo+CbmLIQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724118385; c=relaxed/simple;
	bh=NLGXyzyDRCMtFVsCX31SlmRX2OqGRUiNPEeUGshVGe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VjVTfGXV0FjCnqkOQjgw+rpdOeKLMu2v2IfqDMoqzrJw+V5c3LNMzbI1bbg7o5ZP/UlsevUNnNP9yCnPyUOdPXA+XwRmRiWvaycpoQ9oc77dVJ0k9xA/G1+AMatBFV7ZI5GGdYYuxLEjhubmccLiE3Q9T9DmE+VPvRlWUdZ/STY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VBLER97S; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-44fe106616eso27815021cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 18:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724118383; x=1724723183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLGXyzyDRCMtFVsCX31SlmRX2OqGRUiNPEeUGshVGe4=;
        b=VBLER97Sewr+qmrTUsVjbhJdDzMgAQNFmzwxJiV0g2LHP6+gHC47TuWFBEw8QFQ2Sd
         LjDz9bMPs+YEPv6Vo6ZMVjP74DFx+894rtCgqlrxO9TtkvFv5ZBqiaI3R9Ub9GhCLTCC
         3WHiEW4nVdMe9SHxul6dAbfy2yUwp83thwLcz7tafMfy/lWjqdEl06SrLA87J3DJ749/
         K8aEQCi/fV8H+nuzs/K2OXeEBE/tfty3I3OH2CxrENp7WFSffY8IiRkG96Ji/cndFSbq
         j3/VQ0mxP0REnbZMDtaLrfB0XG8x7MLhXj1hInuMrzNyo18GrBjAG8PJe1KkP3beEFN4
         XQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724118383; x=1724723183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLGXyzyDRCMtFVsCX31SlmRX2OqGRUiNPEeUGshVGe4=;
        b=M2PwiGPsr+yEoDBlD9peZYk+qVU0azA/KPuT9pWWHq7JKzWbjFYv2t/FKMHaDZfKTq
         6RYIxdcn8oe7tWibIe1jLDBsEEG3YD8Shw29737oMh6wod6gmQx8Cyv9yhuY/hSCUqEL
         nsI0KmheqZQUrgyWF/MJqHlV+6i7YBbmQzVtD6jnyH9rtZWKxaKQCtnjVC6knSYi0ZB8
         IgzdT5LCYrxcsDbUzkAOxtsEcdH5uIdZaaHFp8IthgU915dNTLG0+TocjjmxDjXn8p1V
         ZjU4pBqnV4nRq8BXi9y/+PyBglTLDDkg37DbaORlLkPiBMOXGXdlvHvmuXE1c52AVR1k
         or0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUrvQ8KuBwUaWZZHfD/aRiaQfUSDsKgsk0CSbdEHmjwcYKqR/fWpBUf8xFwfgZvZ0HOikInhSHvzRub4IU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXOtvAgNkhrp3dvfH0VvXwEsTXU14Vtk02DHVxbPq45yFuhAYY
	4f2EjE5ZKxbl8csevdGi+NTbNBbE9v7LsmwvqJJBWmdaMBtgBQbpN/oxPeCeGW6IFYkpzJIff16
	GI2EPtABTuQuJHQ+hYCWhN8c1TAatqtZXorMD
X-Google-Smtp-Source: AGHT+IGPb3dLfD9raq+gJcco+vCZhESSKSc/TL2rumYK9styepg9BQ19KUfATIjpX/4u48oIpmni43L+UJMs61R8/As=
X-Received: by 2002:a05:622a:5c13:b0:447:ee02:220 with SMTP id
 d75a77b69052e-453742b9ee9mr166792741cf.30.1724118382851; Mon, 19 Aug 2024
 18:46:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806111157.1336532-1-suleiman@google.com>
In-Reply-To: <20240806111157.1336532-1-suleiman@google.com>
From: Suleiman Souhlal <suleiman@google.com>
Date: Tue, 20 Aug 2024 10:46:11 +0900
Message-ID: <CABCjUKA1nm+=eiHZu-0g5qstko9XdnwbJa3YgowV=L1t2Qa5mA@mail.gmail.com>
Subject: Re: [PATCH] sched: Don't try to catch up excess steal time.
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, joelaf@google.com, 
	vineethrp@google.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	ssouhlal@freebsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 8:13=E2=80=AFPM Suleiman Souhlal <suleiman@google.co=
m> wrote:
>
> When steal time exceeds the measured delta when updating clock_task, we
> currently try to catch up the excess in future updates.
> However, this results in inaccurate run times for the future clock_task
> measurements, as they end up getting additional steal time that did not
> actually happen, from the previous excess steal time being paid back.
>
> For example, suppose a task in a VM runs for 10ms and had 15ms of steal
> time reported while it ran. clock_task rightly doesn't advance. Then, a
> different task runs on the same rq for 10ms without any time stolen.
> Because of the current catch up mechanism, clock_sched inaccurately ends
> up advancing by only 5ms instead of 10ms even though there wasn't any
> actual time stolen. The second task is getting charged for less time
> than it ran, even though it didn't deserve it.
> In other words, tasks can end up getting more run time than they should
> actually get.
>
> So, we instead don't make future updates pay back past excess stolen time=
.
>
> Signed-off-by: Suleiman Souhlal <suleiman@google.com>

Gentle ping.

-- Suleiman

