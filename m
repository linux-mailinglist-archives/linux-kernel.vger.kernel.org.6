Return-Path: <linux-kernel+bounces-570008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A710A6AAAB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8DDA883FF4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8B41EC013;
	Thu, 20 Mar 2025 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EJsJNMNY"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E55018BBA8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486820; cv=none; b=ilR8iCucnPwdG2NiVcDV7dDV4WGBMUduOPwOLRSvyIoC0H0PRgMLKhjiKHcDxYlsbB+NJpgYs78YBxSUucfr0IaZg6sgAnAMm9mxIIFwmHdzAj6TXBKFqFcURBtWregRYxImnBpDDxzAsSlI28NGJ2opfl72SP+xCE+OptOY9B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486820; c=relaxed/simple;
	bh=ifrRfiFiGLjy5/kioXPgn4QTU6kdKDttQmJhZjTKTCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VU/3HaOJ4R9VzWCpIumgB8G3Usm55kRT8T48iZ/23+xb0ZHRZIFkhiQ/7dtocOTOAwZeMIwZ+R1E8tZC1xNvE/QAaMwy99qGM+dvK/yNIpVyqHE1+h4UD0E1SBmbPkubZia1jki0eNJ7xCzKkNEo//Jd+NLO/sxmSYmwvKfqc+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EJsJNMNY; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54acc04516cso1192363e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742486811; x=1743091611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgKpMMyMOafptAKyBG1mzXxlPUkssnGf6TM2QWwcXbs=;
        b=EJsJNMNYmPRxxs7VVRlX9XEsc8dCVh7ov8bwn8pQ7rAxhjLQ87KC8Bt6YhPgmwvIk5
         NzNFxL0Nr7NGCUflp31OWaTsAuGEhwrTKvhfCOJBLSkWUsac4sSsF2M7wK/ISG8EeyA3
         C+N1JQkHw6FmsCzcenGBa/VXArhFkdjFl1bpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742486811; x=1743091611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GgKpMMyMOafptAKyBG1mzXxlPUkssnGf6TM2QWwcXbs=;
        b=drClgbLg4FSfz2GZtXCfh7Ju4axkQ3hV5DDpzpjyud9W7CBo0kvy0etcu5eZN4Z+yK
         vbEfoXp3b5QiXW3tW/dIqOSEa5FqceV1jHJnb2AOUDFU8GLtAyCEkaglI8fr6mPv2rbP
         OP2d0y09LG3sG7udiZLbcQYYAKcQ1YEGSsqAjX97c8a30wkUctWuvtuYQaXyRwm7C17w
         pxe6GNtnm3O+0wkMzw/J5QjZ9/VhZ9ZU8Tk6oadAQEuefemBoaHmXo6f+tnd4Ibt43wz
         XSMcmSLFNsQzmOiZMvfFv59EsoQopMniSTKeGUTpZkTE7Fsl4jBwJMdkHIRzABzfVyzf
         8AxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDeliSIRFGXoajvaRdktu4Dah8Fg7DxXDL97MZj3w8YsFUHW++/ZL66w5nAJ0ROIaZD8R5OPq7NaCDseo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzivTtHR0wIL6lF3B3la4ZrMnoZlgnhHVQdq2hG3W4oLOggxHpq
	Rrvp0qL+0JD96zd6eG6ieKt30Ew11DloG1+KBCPa6mL/6OLQ+zayoDFZGutvZkYqCJLwaZwxliD
	K7Q==
X-Gm-Gg: ASbGnctKZCd6OiikFzp9vBKlugx6nBP0sI8nTnmg0oB8I1RbH4+KqvHqRyw2K58F5AJ
	qW94EBa5YhFUlY2jpwW+Zq4GUKbAwIRoKAU03yBCzUdJ3NNUDhJYfjWzYkCAfUTEXguWpBku4MH
	xQMblMq9AF66o0FTMdEwzfsoP+6B1XmjfTRVzHNpCezwafaX4F9uIT0MW44p0/341uI3rZXyMm1
	iGnU3xxdx0LmTDJPBsmppiDq00RFWnsvO9XpiOoPDQjScOQLJT0N1O6X8YjsoPdDCIMofRmoxQO
	Xso28pqdADP4nBLGfXa7uco7zlMaAIINEl5udt+PoHENnWZRyKCdiw1KthlGXYloS9AfpLaUtwP
	nCyYYXcNu
X-Google-Smtp-Source: AGHT+IGLzMfN3WAvxdlYLBbUgMx3e6FrMIMtPg069i1wzQocTgKWqEiFaWEx/f41S6kF98MOVleoJw==
X-Received: by 2002:a05:6512:b8f:b0:549:9044:94b3 with SMTP id 2adb3069b0e04-54acb1cfdbemr2523192e87.29.1742486810720;
        Thu, 20 Mar 2025 09:06:50 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54acf942e24sm251348e87.51.2025.03.20.09.06.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 09:06:50 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54acc04516cso1192191e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:06:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVbiBTXSyACbkfHNNsPH72IaJWmGR5SYe6u/+tHTgXUT6Fqb9bpQ2Gs4O6YFrH++xue3XXbhQmtASLDPWM=@vger.kernel.org
X-Received: by 2002:a05:6512:12cc:b0:549:8ebe:b3c8 with SMTP id
 2adb3069b0e04-54acb193389mr3321744e87.11.1742486808634; Thu, 20 Mar 2025
 09:06:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fV-t6j9SOSUHLO8H8LWEmB1E4KZtKa3fQWiMx7y12gjhQ@mail.gmail.com>
In-Reply-To: <CAP-5=fV-t6j9SOSUHLO8H8LWEmB1E4KZtKa3fQWiMx7y12gjhQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 20 Mar 2025 09:06:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WWUiCi6bZCs_gseFpDDWNkuJMoL6XCftEo6W7q6jRCkg@mail.gmail.com>
X-Gm-Features: AQ5f1JpF9sCuzDNdO5q2qlHtgQI6MPM9Bpy_gqRVuh3gszX3bRjLlOVcnTluNQY
Message-ID: <CAD=FV=WWUiCi6bZCs_gseFpDDWNkuJMoL6XCftEo6W7q6jRCkg@mail.gmail.com>
Subject: Re: Remove the "perf" hard lock up detector (watchdog) from the kernel?
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Stephane Eranian <eranian@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Leo Yan <leo.yan@arm.com>, 
	James Clark <james.clark@linaro.org>, Will Deacon <will@kernel.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Vince Weaver <vincent.weaver@maine.edu>, 
	Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

+Petr who helped a bunch with getting the buddy watchdog integrated.

On Mon, Mar 17, 2025 at 2:26=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Hi,
>
> The kernel tree has two hard lockup detectors. The perf one uses a
> perf counter to generate NMI interrupts and detect a lack of forward
> progress, whereas the buddy approach uses the soft lockup hrtimer to
> check the next CPU is progressing. Doug Anderson
> <dianders@chromium.org> recently questioned:
>
> https://lore.kernel.org/all/CAD=3DFV=3DWfB6inJPuwfhbw4mtFBYpr+3ot2J+SJAZ3=
pT3t4fW7cw@mail.gmail.com/
>   ...but I'd also have to ask: is there a reason you're using the "perf"
>   hard-lockup detector instead of the buddy one? In my mind, the "buddy"
>   watchdog is better in almost all ways (I believe it's lower power,
>   doesn't waste a "perf" controller, and doesn't suffer from frequency
>   issues). It's even crossed my mind whether the "perf" lockup detector
>   should be deprecated. ;-)
>
> In the perf tool there are warnings associated with the NMI watchdog.
> The metric code also has a flag on metrics where events aren't grouped
> when the NMI watchdog is enabled. For example:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json?h=
=3Dperf-tools-next#n1916
>
> The warning and breaking of groups is currently inaccurate for the
> buddy hard lockup detector as /proc/sys/kernel/nmi_watchdog is still
> present to enable or disable the buddy detector. That is the perf tool
> is currently warning and breaking event groups stating the NMI
> watchdog is a problem but the kernel is configured to use the buddy
> watchdog.
>
> I'm unaware of a way to determine if the buddy or "perf" counter based
> approach is in use and to correct perf's behavior. A patch adding such
> an ability (say a new file in /proc/sys/kernel), and perhaps new
> abilities to switch watchdog at runtime, seem less desirable than just
> deleting the "perf" counter based hard lock up detector. The perf tool
> could make the NMI warnings and breaking of event groups conditional
> on the running kernel version then.
>
> Are there objections to just deleting the "perf" hard lock up detector
> (watchdog) from the kernel tree? Are there reasons to keep it around
> but just not default?

In the cover letter of the patches to land the buddy hardlockup
detector [1] I talked about some of the pros and cons of the buddy vs
the perf hardlockup detector. Pasting them here:

Overall, pros (+) and cons (-) of the buddy system compared to an
arch-specific hardlockup detector (which might be implemented using
perf):
+ The buddy system is usable on systems that don't have an
  arch-specific hardlockup detector, like arm32 and arm64 (though it's
  being worked on for arm64 [5]).
+ The buddy system may free up scarce hardware resources.
+ If a CPU totally goes out to lunch (can't process NMIs) the buddy
  system could still detect the problem (though it would be unlikely
  to be able to get a stack trace).
+ The buddy system uses the same timer function to pet the hardlockup
  detector on the running CPU as it uses to detect hardlockups on
  other CPUs. Compared to other hardlockup detectors, this means it
  generates fewer interrupts and thus is likely better able to let
  CPUs stay idle longer.
- If all CPUs are hard locked up at the same time the buddy system
  can't detect it.
- If we don't have SMP we can't use the buddy system.
- The buddy system needs an arch-specific mechanism (possibly NMI
  backtrace) to get info about the locked up CPU.

I'd expect that non-SMP systems are quite rare these days (and do they
really have NMI-enabled perf?). I'd also expect that most systems that
have NMI-enabled perf also can handle a NMI-enabled backtrace (arm64
was in that state for a while, but it was a "simple matter of
software" to fix it). That means that the only real downside of the
buddy detector is that it can't detect when all CPUs are locked up at
the same time. Off-list someone pointed out that could possibly happen
with certain classes of bugs where all CPUs could end up trying to
grab the same spinlock...

That all being said, though:

* Currently, switching between the two hardlockup detectors requires
recompiling the kernel since both can't coexist. From what I'm aware
of the pros/cons I'd think most people would want the "buddy"
detector. That probably at least means it should be the default.

* I have no idea if it's worth keeping the perf hardlockup detector
code around just for the small number of use cases where it could
catch a bug that the buddy one couldn't. My gut says it's not worth
keeping the "perf" hardlockup detector around.

* NOTE that we still need to support more than one type of
"hardlockup" detector because, from what I understand, the
arch-specific powerpc hardlockup detector _is_ superior to the buddy
lockup detector. See "HARDLOCKUP_DETECTOR_ARCH" in the code.

-Doug


[1] https://lore.kernel.org/r/20230519101840.v5.14.I6bf789d21d0c3d75d382e7e=
51a804a7a51315f2c@changeid/

