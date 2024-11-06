Return-Path: <linux-kernel+bounces-399032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9931E9BF9DB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 00:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA4A21C21BB5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A0020D4EB;
	Wed,  6 Nov 2024 23:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f1DqbP0z"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23063201110
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 23:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730935238; cv=none; b=saIpJfNKMQX0OeGihdDT96BtUp2/w5UZNkFhriPhRwKsbG/4fY648kRhrBW12zosxMdrUmvO0+KUp6HRh5XZmky+swsv05Rjp65P5O5+RTP1/SA93Dm1LOwBrRrNaEv/J11lsSfkjEGwBEC+26u8Uqh7/iQSXfRCm1xph8eFhUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730935238; c=relaxed/simple;
	bh=eg7wjuU2P9IYNITEoASoMTMpkKEH9K6SXLMonKJGYwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JWWH93RyLOKF9ko5ULRFVavtr+yD5WwAmQTBN9BZNQXb5//gVqT7CTULcXsCO4aov9ZMNVzFmsACkgGNK8G9OsTOFMV6qix2ncQdD60sFK5tlrAGuw+ODxnzvdYRq4VjmZ01GlniAiNH1rC3v8ovXiivjqnn0ssJ+jmxRqTpydk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f1DqbP0z; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e63c8678so289962e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 15:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730935235; x=1731540035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eg7wjuU2P9IYNITEoASoMTMpkKEH9K6SXLMonKJGYwk=;
        b=f1DqbP0zNzosWj5dSSddrlSnarUH+GrqM07+QdnlLK6Dl9l09k9f+OWZQTR2ct4xZN
         l80PiC7DGktW6omZW/l4G3SWJe7jR5Vmc99B2DwDWUlJZimmR238up4D5U0/zxXGFCmH
         R5EGVwrFQmdtMlTI1jh5iXb+Gy3EqERvnOXyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730935235; x=1731540035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eg7wjuU2P9IYNITEoASoMTMpkKEH9K6SXLMonKJGYwk=;
        b=J9MTs0EkYYZGqgig8I3LGJGESRo4nb8ldcuDRXzaYBERUQ/hfqNMOYBRPpBWqqCMZt
         gckwwzIOzg+r0DEPE/dRYxOuaItxXBkyaVmVVX/8mpLraQzGPRGN4JwkHEnKidrlS9+r
         hHaUphTo213Ml3f80h4a9Z4CA+7P5p+1LqOLBi528k3YYWvMJJ4VIJdHPxZUQviJF5CA
         NsOuyN2Az2o4bh+gB7DPxhtOcHpGR/ARI+SSvPNny3uQLMGCEQrFapIjK7WYCV5FTwMT
         TmpvMKyHn7olidYdP9cWyzDRjGR0/Wggl2n0CXV14SGGev4jJgqj+B0fN8OAnqEm0V2A
         hQ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWjhVUzSZ9tKqtVkx94Zdn8ecVI0teQImc6uXSVXSbrYiYSVM61JKc3r11TdaRhklRZ1qqseGcHDGRm+d4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBOV3Z+inVs0O1st2tork/JrcpupbaOWyPu0NsFK7Hft9t7V5f
	4PNKyxUgdc6WiUg4X8yqW/V45JtLbVW9jCKybotBXp+3/v5Nz1mcJTdk3tkJZxD2pbeonAyYYWZ
	BjA==
X-Google-Smtp-Source: AGHT+IH3uAiQtkL3UkBaZd5xpGy9QlApGIVvNND3beDK1kK8eyJHTpnPOCZ/S7swdqCsrTl1iflj3Q==
X-Received: by 2002:a05:6512:2815:b0:536:a695:9429 with SMTP id 2adb3069b0e04-53d65dca9a5mr12149428e87.10.1730935234633;
        Wed, 06 Nov 2024 15:20:34 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826a731esm19248e87.144.2024.11.06.15.20.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 15:20:33 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso243706e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 15:20:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWfK+qbqQQ1OFpIsXkzXyMfOtl+lixMshqata836vV5YkFhHxPzE868T8bPK/OdB7ThpX8K0z9acyi7PhY=@vger.kernel.org
X-Received: by 2002:a05:6512:33ce:b0:536:7a24:8e82 with SMTP id
 2adb3069b0e04-53d65de4988mr11375945e87.13.1730935233454; Wed, 06 Nov 2024
 15:20:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZyqSm4B4NuzuHEbp@slm.duckdns.org> <ZyqS0GP9h2hG2lvC@slm.duckdns.org>
 <CAD=FV=U7z-Lf_1T2cYyae3b6W5Joyp+oiRSp-iXe_3jz9Aqoaw@mail.gmail.com>
 <Zyvo7lFcnAddB9RT@slm.duckdns.org> <CAD=FV=UTh=JGUDZxO74+ZRQbF+yzcWnBo-f=oie0msmBn2_00g@mail.gmail.com>
 <Zyv2x6kb3gO8cTO7@slm.duckdns.org>
In-Reply-To: <Zyv2x6kb3gO8cTO7@slm.duckdns.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 6 Nov 2024 15:20:17 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XuvhaQPoLN7q5JnraBGggN90aXPoSEFG-H80i368u5Xg@mail.gmail.com>
Message-ID: <CAD=FV=XuvhaQPoLN7q5JnraBGggN90aXPoSEFG-H80i368u5Xg@mail.gmail.com>
Subject: Re: [PATCH sched_ext/for-6.13 2/2] sched_ext: Enable the ops breather
 and eject BPF scheduler on softlockup
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	sched-ext@meta.com, Andrea Righi <arighi@nvidia.com>, Changwoo Min <multics69@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 6, 2024 at 3:07=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, Nov 06, 2024 at 03:02:35PM -0800, Doug Anderson wrote:
> ...
> > Honestly, it would feel better to me if the soft lockup timer didn't
> > tell schedext to kill things but instead we just make some special
> > exception for "schedext" tasks and exclude them from the softlockup
> > detector because they're already being watched by their own watchdog.
> > Would that be possible? Then tweaking the "softlockup" timeouts
> > doesn't implicitly change how long schedext things can run.
>
> Some systems can get into full blown live-lock condition where CPUs are
> barely making forward progress through the scheduler and all normal (!RT =
&&
> !DEADLINE) tasks are on sched_ext, so the only reasonable way to exclude
> sched_ext would be disabling softlockup detection while sched_ext is
> enabled which doesn't feel like a sound trade-off.

Hmmm, I see.

It still feels wrong to me that the softlockup detector duration is
affecting how long schedext tasks are running. It feels like a
fundamentally separate knob to be adjusting. You might want to stop
misbehaving schedext tasks really quickly but otherwise leave the
softlockup detector to be longer. Tying the two just seems weird.

If we're trying to avoid duplicating code / avoid spinning up extra
timers then it feels like separating out some common code makes sense
and then that common code could be used by both the softlockup
detector and the schedext watchdog. This would allow both to be
configured separately. Yes, you could configure the schedext watchdog
to be effectively "useless" by setting it to be too big, but that's
true of lots of other watchdog-like things that are in the system. You
have to set the timeouts sensibly. Certainly you could make the
default something sensible, at least.

In any case, I'm not actually a maintainer here even if I've touched a
lot of this code recently. As I said, if someone more senior wants to
step in and say "Doug, you're wrong and everything looks great" then I
won't be offended.

-Doug

