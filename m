Return-Path: <linux-kernel+bounces-211382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BFE9050E7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 829EDB23488
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5939716C685;
	Wed, 12 Jun 2024 10:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="re8qN6q0"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EDF16E888
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 10:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718189554; cv=none; b=hS0gL2hCYFjh1tPCHWp4EuGjGIG8guW7+MSAo1LSDA0M229+Hq/z9FDxsIsqtgKPKtS4l2gAECaqHUqL7j2LpBNO1AtigZRcD8tL4jxOFoWtR/pLwGXjQctECPLRSyW3YdBfzXCg0CtYjJZdWLpz+12UFEEg1c/uf3Aawk9fscY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718189554; c=relaxed/simple;
	bh=hfca2HZsexdSmcR2L0VarVPDzv56VOL6tv9ZzVNhWgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHYiKO1aZIeeLnw/5FV5Sv/5QkBrihRc4zZeIXhk9vvAxzqIPUp0a8uVyzMvp8qeJ0OWOmIn+KnsyPq7dv/uqdu0pm/kS5pPZEAM/tPyU7QcaPhUIeKazIGw21uWchchSGMvLIFVSpIpII1XrHcyN0H6rkZrwIdqeA2vxfj/o1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=re8qN6q0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-421eab59723so24212155e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718189551; x=1718794351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cPi9QkdS95dkNdofAqCFmLTLe43Jm537m7bw1KQ0ItY=;
        b=re8qN6q0jAzkaIlLcbrQD6yb62C0s1p099HEKNJKNUFhfCdsivQdXyLRpFvZo3s1Dq
         jth8zdP5iL2an0vn6WGN4a8rwYdyqrVpm2BrmxzkVKBoQfDve7A6TTNEkeiSPrJXXqp/
         qBhfPCXjH7aN+xIkKr/zGO2V7K6GRY6l9TXg+B6aXccVuLDgEXs6VWupxL0SP8HCOGRC
         nmB5WOf+RFx8htebdViPH5gsR99FMjV+mlJWWZ7w9RlycQPhwczAgVRcWtScdFxk907G
         M7jTbvRuToRzpP8HoJAw82YMC9FoPiuKLpZoLSycT0WVdu/E0Fsgl0DaQFoE+oBAyHIG
         Mlfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718189551; x=1718794351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPi9QkdS95dkNdofAqCFmLTLe43Jm537m7bw1KQ0ItY=;
        b=ALb68QJRfN/xeF9Sh1+W3zfy7vp/EQql+rQbVd4N9z5lQUM/xmtydf953QemGyTajL
         zct6vnGTNccQpyxMQ4AstMfkxp6e8LauCcJHxzSzaDK4aDRQeRNTDO+/985WQ4Mqz3XN
         g2KoGjIsyDolXvoyCAmhr3ySDPoj2lirO5o9MqDB9gLGELti+htLQU/F3KWf14lm3mSj
         Jgx6r9TQoC27MbPUv9ullhirhVj6Wy3Zi2OaGuPr0LfHS3EmzavNu6MXsUWvP+rVaCKc
         fcHjQPsqS9dLYkpGtCNszFxyRoGz154Z0BOGbV1Wvi76Sh29GpF1NRuWT+5DjXbQ/yRr
         kK3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVeMraGKIfSrDTCJoENy1cJxHHuI/80arkrg5opPpjn5VmwrplDmvK9FmsM5k+wvJOZXc5twxDE5B4rXrLGiDtZteMIhrXt+TSvkz7j
X-Gm-Message-State: AOJu0Yze2KJmAaJ3oIcmvARWBf92yb+diE0/K33RIyhn1xK5sXOlVzlL
	PHw84VmNpexD6oaddAYPpwW5VMkAbBsmuZF7+0l//wgpFPeDbvEbkaYzfSH60PY=
X-Google-Smtp-Source: AGHT+IESwYJf6CJnIPpXgk18wMsSx3pKvDvFlcyAWNgt77NIwpqGQS3CGPJBRqxbG2fIpZ5+AFV1zA==
X-Received: by 2002:a05:600c:74a:b0:422:8557:3c5a with SMTP id 5b1f17b1804b1-422864af026mr11662165e9.19.1718189551298;
        Wed, 12 Jun 2024 03:52:31 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870f05edsm22074695e9.24.2024.06.12.03.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 03:52:30 -0700 (PDT)
Date: Wed, 12 Jun 2024 13:52:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>, Tom Gall <tom.gall@linaro.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v5] checkpatch: check for missing Fixes tags
Message-ID: <386af0a6-b15d-4be2-a0e7-0375e822031d@moroto.mountain>
References: <ZmhUgZBKeF_8ixA6@moroto>
 <20240611113855.b63a6015b26a0dad49d9f2a7@linux-foundation.org>
 <b3baa059-b433-42da-96c0-588312b5a4ac@leemhuis.info>
 <6825db9f-be27-4096-9723-6ad65342a59e@moroto.mountain>
 <390652ca-a383-4953-aa39-8c4ac92f2e3d@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <390652ca-a383-4953-aa39-8c4ac92f2e3d@leemhuis.info>

On Wed, Jun 12, 2024 at 11:15:45AM +0200, Thorsten Leemhuis wrote:
> I see your point and agree that it would be nice to have. At the same
> time I've seen people on the lists that don't like to use the Fixes: tag
> when nothing is "fixed".

That's correct.  Checkpatch stuff, clean ups, and patches which silence
*harmless* static checker warnings shouldn't get a Fixes tag.  This
checkpatch warning doesn't affect that.  If you look at the patches
which were flagged it's mostly because of CCing stable or syzbot.

> And it would be an additional burden for
> developers to look the commit-id up. So it could contribute to the
> "checkpatch is asking too much here and not worth the trouble" stance
> I've seen a few times (to which I contributed myself... :-/ ).

Someone's got to do it.  It might as well be the person who writes the
patch.

There are times where you're working across function boundaries or even
subsystem boundaries and in those cases finding the correct Fixes tag is
difficult.  The other case where it's annoying is when the code has
moved between files.  But it's generally a worthwhile exercise.  It
helps to look at what the original author was trying to do when they
introduced the bug.  And when you add a Fixes tag then checkpatch will
CC the original author so the review is better as well.

regards,
dan carpenter

