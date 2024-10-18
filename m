Return-Path: <linux-kernel+bounces-371970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E269A42C1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8A51C20B80
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5924F20265A;
	Fri, 18 Oct 2024 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z9HavkLn"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8F8202655
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729266202; cv=none; b=Jo7sFgZi+oaNsmPbiOjjAp67VvZFLFerz/duZrtA2O+loBb9ga+1MVKhj66vJNuG6SnBS0oYnlF6d/ejMqMsEM26TML7FPcGYkylHKl3XwDB/s0/m8sgIfaS8/sE0I3XLQSgOCqQokFUyubTKCCGyfkdma3gYdVMF6Nvd1/MrQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729266202; c=relaxed/simple;
	bh=c0Eoe6/nO4lN/XxFgwsBWWXoK2ooRSnbrUJPmSJTiYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ulk7IyD5d6UUU6XvVifiXt4qTPymuGveCGEt65PQQdT6fmrRA8+UMNY/aKeqCoLuzYmVgzJW6XYG5yB9w1AY/XkfEzRs8Hu9pdyFJIThpXjmeq9xzIVUDfyH94SWgzt9agajh3Ry3qSPnOjhbLA6RHG6ZFVWRwgGDm744G3LOhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z9HavkLn; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539e681ba70so21384e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 08:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729266198; x=1729870998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNvrrma6BTw3zL2RctfT/cmV6V0njwbtezNVin6wtIY=;
        b=z9HavkLnqBdnMlcQBgaNWdRs1VuPPPRKuSCUAhWYtz3Jgfawyn7OpnKYZOBvpxauem
         hQOufs05xvtJPDv6pGqe/e+zPrrtgzAJ9XaTaV69DPSIF96fnkIxi3DLfuwQbHPATdEP
         rkzzXDrLefj3cT0WVbrVwFIq3I7kw3kuUDBVpfweeOFS9sdkrtfSeArLaDIUlnuzrl4C
         tW0foaI5kYT+smhUmHw+w3GneEPj5BC5kz8mGHEVEPDWaD8Nh5pzM5+BIYVX/eRFP/yY
         H+SyqSd6Rf6W4eRAZhSI/+DJS5NLQFqU+qYHG0/I2BCKPVxFXkr2LMWUf2/w9dqcLfhi
         Hc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729266198; x=1729870998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNvrrma6BTw3zL2RctfT/cmV6V0njwbtezNVin6wtIY=;
        b=gTH1vsQiF0zn5UJEMtjGWgBIFsTzc9O/ZjG6Okk9fcRdnGX0D65MqySyoSlX7Im3Dg
         LerKspMXJZdM+yNSn+YvKy2Cs4WckIg9Bb9/uQu/h0+wdgQvKzpuWzZdj0PJavPQ5M7O
         3lSbFwHqGSWYu+VmiXaM/pZZT97qKH9lejGvqKCATGNocLVAcAPNW/Y35qrUs60W+C9V
         dUE0ifPsFF+lXpMk4Io98ScweAqeFjgQe1oOwRj6l/9xAdUFTRzp0NnxRj5dC0p6BsCj
         1sPa3qcPB1MBwBcV3cLZx5eA/wQ1dyHnNM5dAzoFw3Pt037cDU5F1r6O8PpBxdGJLgsK
         3CSw==
X-Forwarded-Encrypted: i=1; AJvYcCVr8c2WQihsN0j8WeCxKBdOZuemWH0aDalOj7ysFork3VhCX5bdyj8Hn0TgTkAC7nwctvcbkSMCJpE94Ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkB7rk/EA+ocyXhXKbbXf05MgIo86A3JxReq22ZgsWFx+iPtRc
	FZAsvQoHd0eqTA+e+l/lPHH6y6JanCquN+9FcqBqfOkMSyrdWJkHrt9qqxxCpC4qq4WJYKiDq+8
	/KJf7Wj9w7Uuzt2lFps6/dERiI1dXfsbkVYi7bQw4DDg/wdpoYF0qzCo=
X-Google-Smtp-Source: AGHT+IG3vlKjb4acLUJQrUf0wlFP+haGvVjOhpoNLq0EbhvWYHGGjdYzHwcPP6dx45ZVtSwlmUALpiqDUA+ttbmBIQY=
X-Received: by 2002:a05:6512:130b:b0:539:e436:f1d1 with SMTP id
 2adb3069b0e04-53a157591eemr413396e87.1.1729266197161; Fri, 18 Oct 2024
 08:43:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67124175.050a0220.10f4f4.0012.GAE@google.com> <671260bd.050a0220.1e4b4d.0016.GAE@google.com>
In-Reply-To: <671260bd.050a0220.1e4b4d.0016.GAE@google.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 18 Oct 2024 17:42:39 +0200
Message-ID: <CAG48ez2VAMZ2K8AvWL0UoEvFCaKEzVYbaJ=syezoXj9Y_P5UVw@mail.gmail.com>
Subject: Re: [syzbot] [pm?] WARNING in thermal_thresholds_flush
To: syzbot <syzbot+f24dd060c1911fe54c85@syzkaller.appspotmail.com>
Cc: andreyknvl@gmail.com, daniel.lezcano@linaro.org, elver@google.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, lukasz.luba@arm.com, 
	rafael@kernel.org, rui.zhang@intel.com, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 3:21=E2=80=AFPM syzbot
<syzbot+f24dd060c1911fe54c85@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit b8c8ba73c68bb3c3e9dad22f488b86c540c839f9
> Author: Jann Horn <jannh@google.com>
> Date:   Fri Aug 9 15:36:56 2024 +0000
>
>     slub: Introduce CONFIG_SLUB_RCU_DEBUG
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D14cc4c5f98=
0000
> start commit:   15e7d45e786a Add linux-next specific files for 20241016
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D12cc4c5f98000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc36416f1c5464=
0c0
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Df24dd060c1911fe=
54c85
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1192f887980=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1417e83058000=
0
>
> Reported-by: syzbot+f24dd060c1911fe54c85@syzkaller.appspotmail.com
> Fixes: b8c8ba73c68b ("slub: Introduce CONFIG_SLUB_RCU_DEBUG")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

This looks like a bogus bisection - the blamed commit was already in
v6.12-rc1, while the file that contains this warning
(drivers/thermal/thermal_thresholds.c) doesn't even exist in mainline
yet.

