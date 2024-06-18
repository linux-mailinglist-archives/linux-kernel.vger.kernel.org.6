Return-Path: <linux-kernel+bounces-219330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E93B690CCEE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949391F26384
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52011A08A6;
	Tue, 18 Jun 2024 12:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcLycoM3"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD51A1A071F;
	Tue, 18 Jun 2024 12:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714438; cv=none; b=VqUt5ZbnAl5ccsjMLYIrRb1CL091O3uRaQfU2F7UXXXqT3/uPTrOW1TOmZ9YiOMaNSXWsfyQdw+7ZvPL7ejPsBfsCSiZskjFZ2QtWZUWa+ur2I6d8ZXJPzbFvtWntzKRfBAdnM4ykVt1EaMiE/J+aEGpxX4dEAt4uESRNmFvot4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714438; c=relaxed/simple;
	bh=5a6B7OS5y/6qcp1oPN+ywcFiRxZ6JJXCwOzY6VEkxZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZiP5AXpQIbToBkqX9VnD1gu4c+lss0AZIvGhLuJHrEwNa6GqhgVK9w7tNchxB++EwzbYOc9fXPMYWwnlVT7wD6lcp3HGMuAez+S2X8+4nz5Wg7amHgf5MceqA+dVVvJxj9b9ywXqskhurt7nZSyRz5pH+l9so5/X9jv8Gn19s9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcLycoM3; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c2c6b27428so4189370a91.3;
        Tue, 18 Jun 2024 05:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718714436; x=1719319236; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5a6B7OS5y/6qcp1oPN+ywcFiRxZ6JJXCwOzY6VEkxZg=;
        b=NcLycoM3Ef8Wq+qSHN2erLNDeH3L84ywxcqX0ujbvW4XPcctS0OnMHvD7HjBOh0sTy
         zDjLlU/SEtoToQ1fs56GUHNKm3OL6nwsppajIVOG9ArbrOWqWpNo41Fpi2dMFf/q4gZQ
         PiAErmr/VhFqBgjfuRdDUtD7/jNcVdwaXd0BjG3SQImU5C/4iiBU9SEv0o0mHOgQxHWS
         ydR0kumarazo6vOtzFjzDen0bp/VdbW2vupHmvNcAeP+dinxK4xr4bU5VskXYIbeltBz
         oIXafWN83Ao+5HE9iR7rDcAob3o3LNhEVP+jS2RG+7jKtJ0c2ilJ77zMg7yp/YDttFcy
         2CIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718714436; x=1719319236;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5a6B7OS5y/6qcp1oPN+ywcFiRxZ6JJXCwOzY6VEkxZg=;
        b=J43uxWacW31BRHRg9onmlbZFPwZFKSEeO31MXOlB4s8cxVllIokrQn1CYJRXA7oAvZ
         3guNVgy8qkBpsZpgA24VvE/lXskkSbG6noHyE9XEp/ipcZMeg7CJxfEzO+P3v6NiTAnm
         8UiWyvfIaB5UwVrARKBq+yqLGL6jAnZudyo9mIwhaxaoayHhGGEA2bdUsZ9oywoX2Wtx
         EdbgeZEop2Bya6w3+7eR12Y22NK7WbI2MMySgufbsdpUg6zh6T37NYzJPy7rAKl7xCAR
         sFckdhFghwjyVtw6m6qGvQpj9d+Za+IhaY+mFjV7qRfaMWD3hirdO+vkQ7148vLS/QvQ
         wLdw==
X-Forwarded-Encrypted: i=1; AJvYcCU1Wz1xAmdK4X/0RZMukuF9eO7PrMNEW9H1R6tY2+/56L4NZ2vn2sRfi6hSy2v3HD9cT9sIxlRVybI4400LktosRcTLaYi9NzXyDg4q6CARW+6U5iuqdXSSrfduzbuX0t9Q4Qp7RMM+4Co=
X-Gm-Message-State: AOJu0YxS863x3Hgh6ySz2EW0MGow9QOt4aSw9LkSXC/mTooqL+rjwSsG
	bzCo5r3MH/ytKBWVqgSMNTbN6oca22ErTtCPVS5eMNB5e8L1+TZJorkkKTdvx3gfEKS92RhbpKF
	H8/lkCj3dANyyqMSFrxXLGtG0thM=
X-Google-Smtp-Source: AGHT+IHzJ+FQXBDprzDLivYXPnBaHoSRGyFKlPdv4yqmqIcli49NimXBrXz6EdcJ6mVtfetMmC1KIax8TCU52XOcrsY=
X-Received: by 2002:a17:90b:253:b0:2c7:6305:9905 with SMTP id
 98e67ed59e1d1-2c76305b4aemr956131a91.10.1718714435549; Tue, 18 Jun 2024
 05:40:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240615125457.167844-1-rauty@altlinux.org> <2c9ba341bc95d4b9010bf5f8794c0d14b1c57dc9.camel@irl.hu>
In-Reply-To: <2c9ba341bc95d4b9010bf5f8794c0d14b1c57dc9.camel@irl.hu>
From: Rauty <rautyrauty@gmail.com>
Date: Tue, 18 Jun 2024 15:39:58 +0300
Message-ID: <CAGpJQTHoBAixmxta2WuZfjHjiK9GXF=hkfPyV7PBD5rt9Z_0WA@mail.gmail.com>
Subject: Re: [PATCH v2] ALSA: hda/realtek: Enable headset mic on IdeaPad
 330-17IKB 81DM
To: Gergo Koteles <soyer@irl.hu>, alsa-devel@alsa-project.org, tiwai@suse.com
Cc: perex@perex.cz, kailang@realtek.com, sbinding@opensource.cirrus.com, 
	luke@ljones.dev, shenghao-ding@ti.com, simont@opensource.cirrus.com, 
	foss@athaariq.my.id, rf@opensource.cirrus.com, wzhd@ustc.edu, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 16 Jun 2024 at 10:38, Takashi Iwai <tiwai@suse.de> wrote:
> Your From address and Signed-off-by address are different.
> Could you try to align them?

Ok.

On Sun, 16 Jun 2024 at 21:08, Gergo Koteles <soyer@irl.hu> wrote:
> There are some similar collisions with Lenovo laptops.
> Please see commit 0ac32a396e4f41e88df76ce2282423188a2d2ed0 for an
> example how to handle one.

Yes, you're right. I'll do the same and send v3.

