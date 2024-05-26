Return-Path: <linux-kernel+bounces-189787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 163CC8CF4F0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 18:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA6E11F21198
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 16:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E36E1B94D;
	Sun, 26 May 2024 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RP8A/YVM"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7C62260A
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716742423; cv=none; b=jot9Xa5Z0tURwGB7b/F4/JdufsAG0WdZBVVMpORhAg+SX6MfV2ksPhXvnllRN72Da3vRbiybQVvt/k2ThH4s1WwwZnPRPW4cqr3uYPYWzTwHh76Pge4UjGiPJb9w6d4AhECM1FkX2pjMwWs8w/fdTawPh123feVzN5AUZZ7e3Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716742423; c=relaxed/simple;
	bh=/BKmWWBDfRlEDj7KIrCUITVqOvPtb4QcBiN5AA/liTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q6co9MlNvKa3j/qOg6ukssjQMXI1VbhcCbdFgjsu6bH6XYTTY3RyfOd5sLxoxfqsKxEdD99HH1YEPKL8Ci/yx70gErFO6R36VohpM2aAmqENZGpvjXGtLpzdjHM4TKsPTYxXt12B2dbjetGNBwNXJrz3W+UJ91Ejjoc1eKC4cqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RP8A/YVM; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6269ad9a6fso282794566b.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 09:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716742419; x=1717347219; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2KPz8fd987dNAatsylOyQp1D2cGtvz2jm5uP1CPuYGQ=;
        b=RP8A/YVMxPxYCMdO3sc5oQNejfyAG3TAmozX8fQOCZkdzKLPWzjQYMahI+UztVc5xk
         73yViex6GDlCsLjEWgIs0gwkD5X8JKh/DaO2VQ0Rv9Jysn/MJFKEErbLJBvtjuFbtO6A
         oLYyV1Cnhvt9EF7zsNq0ehfZyLblPJxE/6DEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716742419; x=1717347219;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2KPz8fd987dNAatsylOyQp1D2cGtvz2jm5uP1CPuYGQ=;
        b=PMcgLQn6J5WSLqyuFdA7z8EoG1XExprJKekuROALsObhNlmbOcbq1JQ2dKc30XbkIK
         vK1ML7B4lJv1eiTCzvkU1MLaaLwILPBh+PaG65ndsdQNdSnp+wZ5J5+QPZ7TcNh17zg5
         UvCVsnfo15lGvKVitA+u2hkaeMN9P+AaP6fnZtfTFC2sIYk3DVT9ANT/o7hoEzObzqZD
         Sh6Ge/mCgkKZHA/LvRB6ANWAVh6AXoblg5T6d/mI/tSund1oUfM06vUJSjQWAHSiX/Y2
         JfYNel3Zkjoiu1i6l8VP1W/6Ur009dTL7piDUbCOtKTfE9Z0s6PmnCyAK5TQRermqq0a
         E+mg==
X-Forwarded-Encrypted: i=1; AJvYcCVLU0rBwTeuQsh6x1tBTZuPHO1Utwq95Nypb5N7D6yDAhgCWLOjgIPAsNsasxG6nNOy3UsWBWbwdOjQaul/y1cfNilUV5AtTMHp9WMh
X-Gm-Message-State: AOJu0YypNNLoDMH+om6oTHmcigr7fCUAbZ/7Kr75u06NzJhagpC97rIJ
	ARBu1MbfYM7V0wUKLjcYt/0c+3YCazeLgE7lbjCeVu5yumFZeJ0VzBU9Z/IY03RGS/X/7r29lnG
	eA2CZuQ==
X-Google-Smtp-Source: AGHT+IEsvNFy5I+ktj/ElUxlT80bmpQV26/OAfaek7xdf848vARxey/OzFODsg+F7vpXCWKM4YVKYQ==
X-Received: by 2002:a17:907:6d0f:b0:a62:c0aa:8c1a with SMTP id a640c23a62f3a-a62c0aa99ecmr294094566b.2.1716742419291;
        Sun, 26 May 2024 09:53:39 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c81771fsm400556966b.27.2024.05.26.09.53.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 May 2024 09:53:37 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6266fff501so285497966b.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 09:53:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWmhjOtd052HSJdURjXHfmBMfJ5Vzv4NoUSCAMM9Udv6iIjwj/vry29Q9Mbb2ZU6cG1ojEA7xEl0fJ3jelBXMSKCFdeu0lKyywUVHDy
X-Received: by 2002:a17:907:928c:b0:a59:fca5:ccaa with SMTP id
 a640c23a62f3a-a62641a3160mr583334366b.13.1716742417393; Sun, 26 May 2024
 09:53:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521192614.3937942-1-acme@kernel.org> <CAHk-=wiWvtFyedDNpoV7a8Fq_FpbB+F5KmWK2xPY3QoYseOf_A@mail.gmail.com>
 <ZlFE-wbwStOqt8Ra@x1> <ZlFGpxWGQskCTjeK@x1> <CAP-5=fXDdcjMmn8iBenjPmZZQdB=AX+gc4TYDsHXuwH9TYq4Ng@mail.gmail.com>
 <CAHk-=wheZptGieaObmQEsz6bocUjhQXNpWXFDmCK-TOKbOvO+Q@mail.gmail.com>
 <CAM9d7chXVsoNP6uYMCqy2MZOiWkt4GrFn+giYLHQjaJRsap1Cw@mail.gmail.com>
 <CAHk-=wjY7CG5WRZQ3E1gdEO9YtUQstMe7a=ciShY0wz0hKXyuQ@mail.gmail.com>
 <CAP-5=fUvT+O0iyXxst3WKqnWdpimqD8+aX8GJU7_7zYieniYxQ@mail.gmail.com>
 <CAHk-=wjMvgsBu5n9ifs5d8Qfu8x23=XmXgp6gXYNEN2y-g5UMA@mail.gmail.com>
 <CAP-5=fWk-eDfuRH-tL5TWU8dXumOnCTKby5VKonOfjGad4TG=Q@mail.gmail.com>
 <CAHk-=wjZ2JoyBNFnR-TUc7P8sBL2ZvR0W1fCjcK2R2w7137wfQ@mail.gmail.com> <CAP-5=fXwv0Ec4_wEG2m1X73cpFvEWs2b5GdNnMw7OY7fP6V1tw@mail.gmail.com>
In-Reply-To: <CAP-5=fXwv0Ec4_wEG2m1X73cpFvEWs2b5GdNnMw7OY7fP6V1tw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 26 May 2024 09:53:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0OtULpNxk3_vKgmQnMqfOkJ2+_Gx+79hC=bBP=AT1RQ@mail.gmail.com>
Message-ID: <CAHk-=wg0OtULpNxk3_vKgmQnMqfOkJ2+_Gx+79hC=bBP=AT1RQ@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.10
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Clark Williams <williams@redhat.com>, 
	Kate Carcia <kcarcia@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, Anne Macedo <retpolanne@posteo.net>, 
	Bhaskar Chowdhury <unixbhaskar@gmail.com>, Ethan Adams <j.ethan.adams@gmail.com>, 
	James Clark <james.clark@arm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Tycho Andersen <tycho@tycho.pizza>, 
	Yang Jihong <yangjihong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 May 2024 at 09:50, Ian Rogers <irogers@google.com> wrote:
>
> If you think what you are asking perf with no pmu for a cycles event, is it unreasonable it gives you every cycles event for event PMU?

But that's not what it gave me. At all. All it gave me was NO
PROFILING AT ALL and a useless error message.

You're trying to change the goal-posts here and keep bringing up
irrelevant things that didn't actually happen.

I have a revert in the pull request from Arnaldo, and the revert is happening.

                Linus

