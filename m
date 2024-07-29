Return-Path: <linux-kernel+bounces-266337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C4D93FE56
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379FE283E1A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A281818732A;
	Mon, 29 Jul 2024 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Jhyd14iu"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AC385947
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 19:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722281788; cv=none; b=rwh/3bY5VzhB4MAHmnRGPic2dJYoJwyRywrDa8ZsMfkBtoMhL4aXr/vhl9lN7zqBvphEb3cVu2o2tYaOFSQ7Tl/+W+QZXfyxHIP4o1nxwVdPHDb89RJfNHtGyvo0vETRUA5TBuOgJQ2UZ0YmtJgNq1OyZ036QFkW312m1faspSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722281788; c=relaxed/simple;
	bh=kStYPtpT360r7+lPNaq4678G1cMKho//gPyH3YttFxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRLp7/IAFq/zjuX7JX5JxAT1eYiJsTFDz+YrAU3pKhWfdO8v9AI9gWoh3N2EPE3DEriTIi02CWMc7Vle5GAd4YskvK0qMbJste5hMinPXKWQK96COaYv13aHuV0b/Vr5RFsJfrpU27GKGYpNcsobkQpi6B9tZsmqg772LQUJ2Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Jhyd14iu; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52f024f468bso5718617e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722281785; x=1722886585; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YRLMvV4In2riP1OtNBuScOq98+Tr4p6Bv5zWorH35kE=;
        b=Jhyd14iuWu+SuaUMlcyd6YHVvYmSnTOQeBM4KabpC1Raeg4kVeTMauFYj/W/ZSZ88/
         bqIuHmvVxu2HrBM+MHz9IBqIDqM0VPHdFYDlLWG0KROAo1As5Uem7/P1vbqyll9fM3Qg
         7mo/uxPUvATtsEuTPIBmFbbd9L4nUH8ajdlM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722281785; x=1722886585;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YRLMvV4In2riP1OtNBuScOq98+Tr4p6Bv5zWorH35kE=;
        b=LXPSlH84X0bq/vc8ZIGwQBE047X0XM93ojSn2bbMSaLLZNO4EgN8NRmYe5jon6RB6x
         PmX22/EvAJwx4I2xkGUjhrSHnYPDw5bgD32chK1q0/CiVUYlvhHJLA/R4KSaOmPuh15y
         Ibw+IdzgQv2DZWMD6Rk/peiQ8KY7nuCHARgh6Gry+If9Xb81Hc35BmndRXpDQNoa2zp6
         6IETkfrBkXv5RPTMfBaNnJu4UcSnTtC43kTyCCmCYXBV1SE+8h6QWpPTjF9rcvlEKO9B
         CY4K6wCjuEjRqTgrbmA63HoSLHKtfzUeStMT8aKboTO8C+NwCtzG5+GUEoah5XukF7Xh
         2o7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6wlD/Dp2j6E3I93sKHiaKud4DyrwXF34Nv8U3D3OI6w8ztUDg6XlSjOkKRKrmNKHQZtlYnrWtHTBfWJxWpM+ArEEF/Btk1eBayoIH
X-Gm-Message-State: AOJu0YzcypX00SBB9qeky9yA3wpeU3k+y5dGyWrNU/qoc5xW9KXLkXU3
	nEaiLACX4BimT3z8L76E0AopiJknSciJL/4mqEnm7TZI3bZhUBtwS5QFuk4LuYIzrr8WywNRtpf
	qGW7M9g==
X-Google-Smtp-Source: AGHT+IGXncZjFf6pSnTPunuQ2QGZvtdlu6/WvVYGO9JlekRlElp0ktMutJOdpzJUWrt8ABQqGwUTvg==
X-Received: by 2002:a05:6512:128b:b0:52d:582e:4117 with SMTP id 2adb3069b0e04-5309b2ce92dmr6000619e87.54.1722281784720;
        Mon, 29 Jul 2024 12:36:24 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5bc3f27sm1608547e87.48.2024.07.29.12.36.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 12:36:23 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52f04c29588so6910092e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:36:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUpK0UXmckryThhNragEnyaxF138EDRYzFI249hXHe3YqgsaGJpYJDYfVmRtH+FXd0ZiMNEn0g2b/UNp5Xwl0uZ57PyQJtfw3PNsTAw
X-Received: by 2002:a2e:a78a:0:b0:2ef:1b93:d2b6 with SMTP id
 38308e7fff4ca-2f12ebcaeb4mr62729131fa.8.1722281783067; Mon, 29 Jul 2024
 12:36:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5e42ce13-3203-4431-b984-57d702837015@I-love.SAKURA.ne.jp>
 <CAHk-=wgs52BxT4Zjmjz8aNvHWKxf5_ThBY4bYL1Y6CTaNL2dTw@mail.gmail.com> <87a5i2ttv0.ffs@tglx>
In-Reply-To: <87a5i2ttv0.ffs@tglx>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Jul 2024 12:36:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=whRa0rQrdJc8SQMkC=CzzonzZk5QnZq7BgqD3+vKP+qWA@mail.gmail.com>
Message-ID: <CAHk-=whRa0rQrdJc8SQMkC=CzzonzZk5QnZq7BgqD3+vKP+qWA@mail.gmail.com>
Subject: Re: [PATCH] profiling: remove prof_cpu_mask
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Anna-Maria Gleixner <anna-maria@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Mel Gorman <mgorman@techsingularity.net>, 
	Michal Hocko <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 27 Jul 2024 at 14:20, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Only people who indulge in nostalgia will notice :)

So let's see. Any bets on whether anybody actually notices?

I took Tetsuo's fix for the syzbot issue, and then I did a "remove all
the flip buffer code" in commit 2accfdb7eff6 ("profiling: attempt to
remove per-cpu profile flip buffer").

If somebody ends up having a real use-case for this old horrid code,
we may just have to remove it.

But it might also be the case that somebody actually does want the
boot-time profiling, and then the runtime overhead is annoying just
because they are on a multi-socket machine and the profiling just
keeps going - even after better profilers are available.

So it might be that nobody wants to actually re-instate the flip
buffer thing, but instead just turn the thing off entirely.

Technically you can do that by writing to /proc/profile with a
"profiling multiplier" that effectively turns it off, but very few
architectures actually support that (see "setup_profiling_timer()").

End result: maybe we should add a way to just say "I'm done profiling
now" if somebody reports that it causes performance issues after boot.

But I hope (and think it's very possible) that nobody will ever notice
any other way than from following this LKML discussion.

              Linus

