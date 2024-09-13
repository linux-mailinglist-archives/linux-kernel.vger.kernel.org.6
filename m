Return-Path: <linux-kernel+bounces-328125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 691DC977F2E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D092889AE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7801DA316;
	Fri, 13 Sep 2024 12:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rA+Mhk4A"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A331DA305
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726228964; cv=none; b=awUWi1R1IS3F4RRoYUHwTpIEUOW9fCRduM7/NlmUyC0511MtqSvELZbwdzTld4BDH9wRdykDuYkgaJziAmJcBSuZkVbYy36NBJ0iWp0ZBZao9SaYkjVI1t9oOHY7zpe/eQU/RYnDTZeGjpVwe/i6ofnnbyW+lufNKPs7MAJdWF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726228964; c=relaxed/simple;
	bh=6PYXJ738FyEPSY1pHIaLaAl1aXVKY84HLyB+bqbrerQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nuVFChJrSHBHmLs+0GXNLF9LX/qFq1I9cJt/nEwFT3k8exwqqBqr0G4OKVHwcR9JloWzhffV65A/8scNVhueZqd9udbXb0V6fIsfleawW9DEn3IUXQuCAKN3QqbzjEJEdYJHe9RBJEHJPvnsmXrnn5y26g82dspPjLo/5I3cIMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rA+Mhk4A; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6db5abe2cafso20266847b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 05:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726228962; x=1726833762; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZC5y+gbKcz2lOvMDPSoSOYxaB5aaC+GKTx2bSEhxRuM=;
        b=rA+Mhk4A2PBdoIDqwvQ4dq/KFPQldiLaL0pwmPkWDii/tQ8tuARiy/OoEgRwdf0ksg
         o90Nd+c9Kupsiz4TswI49pjs0wjFKq4ChvSLkyku/ZPWIkyG/GNolbUl4tOzVk8kJtoG
         UHFulYgyl2rDr0IkJGAZZf0J59xmb7Tv1G1JgxzJMFGaIkQjNJvekSJ6sbVxTH7GvYGp
         t0TKk5SmM6nGV07XAbaKRvazzhEleeSM32rAy5wKRtE2ZVjOJKSbHrFA7j+GHxWGLTaM
         NDjRBlI89/CPtXR7VoT5HSNkHNt1vlIQOMZgX2TNKQMnqmucRWDMJYlfhMrBSYdizHT/
         bI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726228962; x=1726833762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZC5y+gbKcz2lOvMDPSoSOYxaB5aaC+GKTx2bSEhxRuM=;
        b=LBTH6Om/gpc1qAuLOYLa6QRn0Bk7hat0NU5HBCS9cigOIVczFYhHqQoCrxAeJ9AAS/
         Jt+4eoK9brZ4AUudj/k0b7KTtPoKUyZEujaKpizUwXQoM6PzjkMvpQ1UOntvE1Lvq759
         itF0OcTIoN2IK7L2vlZeWBQOqcUEkeX5zw9ycvn248bW18qwJB3+gyce2mzNJ6UUTngN
         F1zojYgIg/axVSmorZNS5a8obzxrmPbO80KIely56qCldBpslim3D/jSDfQ0f7usbMav
         WtHQIUhpF/GkTPA3B6nMMtQ/o+urPOnF5IEcLYJMwr5reLmD/OtkM95SrVdbLWwez+f9
         aStA==
X-Forwarded-Encrypted: i=1; AJvYcCVUpbuKqxcONUnGO4S6emOKRP5Sc7fInwuqSeMaFT3zr3+ckNLsZYLRLRSpvwPBV41Xsz5W60BL5WPbxHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2e+x+fJshKskU+RLpS6L6RxtJgS9LoZGglnUsGT2wLG0U4Ixi
	4J73EdnSCfq+P5i1NC21p1IZe7rQ60WbiFgz1bAZ3qk0kbSGSNMV5nFMkMFVI7kqiXyDw7NRgHu
	1hIS8wFdI+B0J1DhJytBPCa7f3wdIg+0BEJQxHn9TRwcMUsZa
X-Google-Smtp-Source: AGHT+IH/TIqGo3l3sKrn6rpgbmS38MaCtup4PWkQrq9QHy/ehShUvJOygofHes+RONDG5YkXaBXtAw9fG7336kRilnA=
X-Received: by 2002:a05:690c:7084:b0:6b2:7ff8:ca1 with SMTP id
 00721157ae682-6dbb6b40200mr64523607b3.22.1726228961582; Fri, 13 Sep 2024
 05:02:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725459707.git.geert+renesas@glider.be>
In-Reply-To: <cover.1725459707.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 13 Sep 2024 14:02:05 +0200
Message-ID: <CAPDyKFqFwA4AEbTVvUXbjyUG+zQutGm-xN3uCxDta+Z-8cmh4Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] pmdomain: core: Debug summary improvements
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Osipenko <digetx@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	Taniya Das <quic_tdas@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Sept 2024 at 16:30, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
>         Hi Ulf,
>
> This patch series improves the table formatting in the pm_genpd_summary
> file in debugfs.
>
> The first two patches are fixes and cleanups for commits in upstream.
> On systems where performance_state is always zero, the first three
> patches have no visible impact.
>
> Thanks for your comments!
>
> Geert Uytterhoeven (4):
>   pmdomain: core: Harden inter-column space in debug summary
>   pmdomain: core: Fix "managed by" alignment in debug summary
>   pmdomain: core: Move mode_status_str()
>   pmdomain: core: Reduce debug summary table width
>
>  drivers/pmdomain/core.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe

