Return-Path: <linux-kernel+bounces-245972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7DE92BC2D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CBBA1C21597
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA8D19149A;
	Tue,  9 Jul 2024 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XAppoia/"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5184619047F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720533256; cv=none; b=uESd1qO1wDv2xD5ZcbJPkOUmB3izDQaEPqTMu+Mefy7l0RvaeBeFy8yEeawZS56hkyuIy5EO5KoHi4qVqQCnGkbZ6cpcX7DlN0EKzekwvK311JRaj2z0S/H+FpQcDyx2Xhwfl24dtL+6aT9SZn8kCQ5zYz9ZAX0Jf1JwoqbB6HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720533256; c=relaxed/simple;
	bh=KBOre6/MDvMpB7h5Xj0oPpmrjYw7FxE8FwVxcWXAqjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LtRthLXh6hEBBv/WCGl5Erh9jP3YpUpUqUQ/7hISj6luARgM++RyyTFInNsgxH029Z4ztFnhYTZwSFTnFr/4j+vJ7vqai2zAGos+dZ7CAQatsaxQ4e3HVSUlwdaKhe+ZhgIVT80OutOZK23LgQCHLQFmIk+F6DdML0IjszycCh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XAppoia/; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7035d5eec5aso2067504a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 06:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720533253; x=1721138053; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iEGMIzj8Deb0RSCNYi9bStxauFP2LxGa08Z7wteG51E=;
        b=XAppoia/CFo7O6AkT5lFBTr1ALeEFE8UQ5k4V/2jwMTsgkXCsKG2Am7mTgPgkM05F+
         cGYcpZOeYnBalYPin4EKa4ndqiz0YNQCEmxOMShb26FjEq46E188mExnH5pf6FAL8E/L
         eTiihG9/v+swpSid0qpvA4WW5+/e3/paGMCgo5c/Hx4EDb0wbCtFE/b6rJ6e/ZzeqLvZ
         oHo8E0q1dPeeIQDjByePUCu5nIg27xSDMKvbXl4fj+CqquBsRodUT3ZAv0pJGTBcGNxP
         A7LU6ahSEB+mdnDPyOJMufJd44HZ/Q5KnAi+Guaog36erzx8X094GVHTwtdX4aNgyr0u
         TnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720533253; x=1721138053;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iEGMIzj8Deb0RSCNYi9bStxauFP2LxGa08Z7wteG51E=;
        b=EUDHQYNbcpivqXgr/krEiPRCgFNCLnMgyV4aU7feAWDPCON0XG/SwfioIoFH7AojhM
         MDcs1NvpiFM5X3u5Btz03jzxHxtklF2KjXFFpL0qZTLhFZEwilqcUsE4dak9/n7DWOtP
         VrEPFpLfJde40lxhxIkJ2pGdY6hEJSVq97CD4MGEwOt+gQkxvREbC0ojLRa2Z4duLBc9
         NZfVIfBU0x9I76n2siRNl2bsaL/EXiZkh+UPD01J1vnQVQYQJXM0JRHoXToTQkrq1rJi
         ffgCMFfdIlam9CdEH2lha3QTxtSXeBUV8TEYHpNtxvuceVedH9vr4+JR0iHbqHVir9jE
         J/6g==
X-Forwarded-Encrypted: i=1; AJvYcCUL/GSrORJ25OvtqiYSl1h/5D/e8Ai+GTZ8tMm0TAA98xNDhbQpLCFouL8L41g9GTcYF2i7BNqvdKTyadiVqqNiJKR812EGw3qSSgFO
X-Gm-Message-State: AOJu0YxZPWjvxY81yVoTvpVg62jLNSM+hUPuOj0YMBhXNYPRMb+X8cpS
	H2Q0E2b1UUJVTXvjwLJFCpQwD0z+VcFR73IoLMnn6c8hbgu1LrNktfsJZLdZUAdFelGBy0djvV1
	ZvXPqO5BMZ2AcIGvgch0a9aaRu0ihOLo9L2Ujqw==
X-Google-Smtp-Source: AGHT+IEBlPAe12D8BWoXO1Z2SMxlnxkHjz990ex0k2qP/zp0P3Mh4WSIRdE0HeqPtKk5VekF8gOhWE2iYeaf40I0cws=
X-Received: by 2002:a05:6830:84b:b0:701:fdc2:5bd9 with SMTP id
 46e09a7af769-70375a11ea2mr3008904a34.13.1720533253365; Tue, 09 Jul 2024
 06:54:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706090511.48818-1-huangbing775@126.com>
In-Reply-To: <20240706090511.48818-1-huangbing775@126.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 9 Jul 2024 15:54:01 +0200
Message-ID: <CAKfTPtB=5Se427by2ntnkW4gD8p6xL39mipVvcRFdH4fLOPjKQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Remove stale buddies comment for last and skip
To: Bing Huang <huangbing775@126.com>
Cc: dietmar.eggemann@arm.com, rostedt@goodmis.org, brauner@kernel.org, 
	bsegall@google.com, juri.lelli@redhat.com, linux-kernel@vger.kernel.org, 
	mgorman@suse.de, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 6 Jul 2024 at 11:10, Bing Huang <huangbing775@126.com> wrote:
>
> From: Bing Huang <huangbing@kylinos.cn>
>
> commit 5e963f2bd465 ("sched/fair: Commit to EEVDF") has removed last and
> skip. Modify the comment accordingly.
>
> Signed-off-by: Bing Huang <huangbing@kylinos.cn>

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 41b58387023d..383582f87def 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5466,8 +5466,6 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
>   * Pick the next process, keeping these things in mind, in this order:
>   * 1) keep things fair between processes/task groups
>   * 2) pick the "next" process, since someone really wants that to run
> - * 3) pick the "last" process, for cache locality
> - * 4) do not run the "skip" process, if something else is available
>   */
>  static struct sched_entity *
>  pick_next_entity(struct cfs_rq *cfs_rq)
> --
> 2.25.1
>

