Return-Path: <linux-kernel+bounces-226851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D871B9144B6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DDC0B24704
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6D212AAE2;
	Mon, 24 Jun 2024 08:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1lcaqnV"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142BB34CDD;
	Mon, 24 Jun 2024 08:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719217542; cv=none; b=dJO6HvXn6vVs9XWWuBwVnhsvSLeohXvDGqd5rZsC1JDTrmrB2Srl+7rpth4MGCYKtqpsfWQ+MHYuXxWSAKLbMNgUsTbIzC0paRLbdrb7WoRuYfXtfsrXBMjMBdONykPSSPHQSVsrAR0JO6F+Hn6JDf2gop+KgcpRfxUt4AmbWdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719217542; c=relaxed/simple;
	bh=GyOe0Bk1Qy0x3Zlayl0mhf95b8D33vUNBo/LqZn8X8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cL/xiVbfxkyR/sLgfwFk0rLLA+pdTf6RCdLURWmLwij9bL4a4UXVKmEjFUteTFLsHhiKCo7CQJVjn+h8wZ0jAKBrCxYKn7FMAuX9qhuKSQaGnL5K9rRep/T+V8MO8rMHRGThg5faJLIIGyc8WuH3PoCxbKwUv7PtX6SJUYYv2VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1lcaqnV; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7180308e90bso1560070a12.1;
        Mon, 24 Jun 2024 01:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719217540; x=1719822340; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GyOe0Bk1Qy0x3Zlayl0mhf95b8D33vUNBo/LqZn8X8U=;
        b=W1lcaqnVGyu82uRW6tbZlPEcR/YiZKRo6yUu+zPunVYRqh9SVC/mL3Kw61qv95Cqa5
         KaQHBTEWTQpI/L26jOiCUxaLDsBgCUBe60ETuVeyZCxAAW/WkX7bn5fkYR5KukII8M4a
         VmExvLLy27u3MJAl87rw/mFvgzboF7ptw0g8GI7mJj2S4HoBAOKirGHoTWWdNgbyaZ+Y
         4a+XojSn0udnuG+WRgYVrrot2RinT+NzAIRTUIYVMl1kIzC5ydwME7D+9xdlVgint9CJ
         JiThgdaKyOzQt4Ifg/K/AOe762DALusaMXbMwYXHpGr8G/mqCH+8eWcS5gBYQp4XeCCs
         CADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719217540; x=1719822340;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GyOe0Bk1Qy0x3Zlayl0mhf95b8D33vUNBo/LqZn8X8U=;
        b=dnDgTFeU6kxNBauau2fHixRUIvXjMaASapnvbgW/niG5LWUwtxrUW8trAuCGN4u6Go
         0P+le/BxME4ibx+fw46mCx5g2kkN6OuoqQmvIPaUX2WlKnZExTM+QrA8AA1gELEEpGxH
         a4fxsDwbXnxbzRzMJg9o7YycU0aplpKXKnjIqXOh48VsQTqYXU7+5JRgSNjz6qR4GS2u
         5Y3ihHHLQJESuy2nhN4YksR9J6PW0v60SAM6ToI1swJsjCiE0YleuLpMpnu//yaBN4q+
         ejTXuXpIHW35+U92yrcLHXhr5W/JnBotRWReunIFedJPYSomvpgM7w5sAv8KYd/Rt9og
         +idw==
X-Forwarded-Encrypted: i=1; AJvYcCXGXfcYRGXH3K3KkHGzUyH7BKA9kr4unfVSpqjZ4pUfQ0+SLS6wc1w+RNTAz5fKbNwjyG2CW8gK3XMWcfBxh50NOQjsby69L1/dRG55e0G2KWaXuOxsDByrdkMXIPT+s+r1/+JZBH+0qUM=
X-Gm-Message-State: AOJu0YwbymTG44VFTnQ87RzpbuexqcXBtnUuXnmqh3R0v6VvnoEA/zxc
	kz/osgk+yG0q0oROz8s8BIU+xjf2tgHPG1uKrD83ir3hlVPbLP+yLP7DOirbMQTYZPoUl3VouAk
	G/fVJm+UUmpT7i9r5ekptMFtdHwU=
X-Google-Smtp-Source: AGHT+IH3LtoObSSGd0RS8q2XD+O5g3y4osc0/P7Bukg9/CjaM2KmYXfvOjyoBTJLOJuktChRLOrA3O/E8uVnomjgyns=
X-Received: by 2002:a17:90b:4c89:b0:2c5:249d:67be with SMTP id
 98e67ed59e1d1-2c86126b700mr2556400a91.22.1719217540209; Mon, 24 Jun 2024
 01:25:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240615125457.167844-1-rauty@altlinux.org> <2c9ba341bc95d4b9010bf5f8794c0d14b1c57dc9.camel@irl.hu>
 <CAGpJQTHoBAixmxta2WuZfjHjiK9GXF=hkfPyV7PBD5rt9Z_0WA@mail.gmail.com>
In-Reply-To: <CAGpJQTHoBAixmxta2WuZfjHjiK9GXF=hkfPyV7PBD5rt9Z_0WA@mail.gmail.com>
From: Rauty <rautyrauty@gmail.com>
Date: Mon, 24 Jun 2024 11:25:03 +0300
Message-ID: <CAGpJQTGqxEkfp003QLsp-syUgzDFCmHSmNaoOaem0ZMVf7_=bg@mail.gmail.com>
Subject: Re: [PATCH v2] ALSA: hda/realtek: Enable headset mic on IdeaPad
 330-17IKB 81DM
To: Gergo Koteles <soyer@irl.hu>, alsa-devel@alsa-project.org, tiwai@suse.com
Cc: perex@perex.cz, kailang@realtek.com, sbinding@opensource.cirrus.com, 
	luke@ljones.dev, shenghao-ding@ti.com, simont@opensource.cirrus.com, 
	foss@athaariq.my.id, rf@opensource.cirrus.com, wzhd@ustc.edu, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I haven't changed the patch yet, but it's already in the stable-queue:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-5.10/alsa-hda-realtek-enable-headset-mic-on-ideapad-330-1.patch
Do you still need changes from me?

