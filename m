Return-Path: <linux-kernel+bounces-325695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6AF975D4F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 743191C21390
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEA51A3031;
	Wed, 11 Sep 2024 22:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IILSiPXY"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CC115442D
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726094172; cv=none; b=TxVWzPlNbyE8LmY6101yggSXlKLK3nCT6If1Ap2SSe6uAUidsCvYZ1/vNp0V0YWhrCapprhMJfMnYaH9nWwJMNS2OBCKHFG5IffOmUT+c3WcOTko8bFKDDckZPDXjrAryVraQ+sg3asJ3SOBiU0nPhxeCJBl0COUcikVpxoHSOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726094172; c=relaxed/simple;
	bh=sLlXxbnjPC9CfRE5O8PkdWPJBgrUnwjCDdhr7B/2ybQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XNzTEl20gNl10x2geXo905Zo3SfXaJfZKqVJDiN8qYvjnPooaVYRzzPqlzaeLNNwxfcQ3G7gCIeQ9SzRYMypShMB2jP3coBWPZ9av8BbIro2csfWaxaSqm48ePR9qnI39oz1TSsqe5HRNuhKxjuveTNqCLAeialCUqunWSyIaV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IILSiPXY; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a99fdf2e1aso30343585a.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 15:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726094170; x=1726698970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RT3aNE15p9RAXHCvWqpl3UOL9ARm17zm9RMpFuaq4rI=;
        b=IILSiPXYtVc8sAHY8yMWLL+YUWA71yNFdyYGpusjeaX437RsWGJL5wmFCEhRhgYZc5
         ik/E7UHJ347eAqjjRBj0/ElrT+VT1uuhEbJOQRueudPffaI5OmpBvqHH/tW1it+zpAJ3
         ioDlWQBT5TzrPYhf5qDEU2DI4SoE47Vke6ADU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726094170; x=1726698970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RT3aNE15p9RAXHCvWqpl3UOL9ARm17zm9RMpFuaq4rI=;
        b=m5VojNm+1/SQCVWbbo+b4cDDUmkZ/+QQC4B5S6BOIUtJgIO89BXLh/d/MV0cedwxj+
         vfRJFnVRMy0ueg1YS1uEkW6hN4tQTKrYacM+zMy0CQbZ0INdrIRjZd7PMQJjS4hf3/fY
         ZjiD+4aJbvPuTCkSwC5tRXXyqu58KIvlgXWH0pu+OaXuDKxnDXv6OX1W6z8NlLbVdAT6
         rkSBwYo0TwM2PHlJZNAQkWqlfofVJEIgQpSybJLq/qIlP5UhvP3poBIfdeC7MekJX/O7
         EREwAHNIKKc0j1Q+Ix1KGRkZvn7x+adkRitn7xCt0y9RZMrXM05tWnQ3742Kz9j2xFpO
         BDVA==
X-Forwarded-Encrypted: i=1; AJvYcCX/+vVmpmoIe5r3O3qr6YDu365fo9hfBqlhhu3b6f8jKKbu9aGFrZUywGZ5CrJkBdvZS0ONxpS4VpWFIqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ww1Mq+588AS6bw4v5337i+BpTC8J1EAn3FIhqVFXxq8qQFwe
	AvpWBbXUDKmBS+5sxFElc/QAohGwxo12TW79yQG6TSZ8JK9S4eLnI0l8cTc7VD0W/Glkd9SnExQ
	=
X-Google-Smtp-Source: AGHT+IG29acf7IZEFASb2dW3pvwTO3tfrlB1yrL71WkAiNGCPJnuyYUKc5Cb0JTprIrtdPNJwcF5cQ==
X-Received: by 2002:a05:620a:24c1:b0:7a9:aeb1:388b with SMTP id af79cd13be357-7a9e5f930cdmr128858285a.40.1726094169869;
        Wed, 11 Sep 2024 15:36:09 -0700 (PDT)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com. [209.85.219.53])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7a1fa93sm467648085a.125.2024.09.11.15.36.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 15:36:09 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6c524b4f8b9so2433826d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 15:36:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVHx8FhVMhLkBNRYb9IrAM41SqRNuaW/F8ffRXzo2pxHkbDaZSBbgnExiUia+E6AzIaRzD/jHJa8BjD/EA=@vger.kernel.org
X-Received: by 2002:a05:6214:5344:b0:6c3:7047:71f5 with SMTP id
 6a1803df08f44-6c57359225amr17185946d6.49.1726094169056; Wed, 11 Sep 2024
 15:36:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD=FV=Vw1fG9sUiG4R6LiKnR2fgnt5Wr4QKzRg+v8MC15pWUEg@mail.gmail.com>
 <20240906094700.GA30052@didi-ThinkCentre-M930t-N000>
In-Reply-To: <20240906094700.GA30052@didi-ThinkCentre-M930t-N000>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 11 Sep 2024 15:35:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VGt-M-CGBOWDc1a3g-t2mUyHkCQ1TFcgvrUbmJDyV0Mg@mail.gmail.com>
Message-ID: <CAD=FV=VGt-M-CGBOWDc1a3g-t2mUyHkCQ1TFcgvrUbmJDyV0Mg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] kernel/watchdog: always restore
 watchdog_softlockup(,hardlockup)_user_enabled after proc show
To: dianders@chromium.org, akpm@linux-foundation.org, bristot@redhat.com, 
	bsegall@google.com, dietmar.eggemann@arm.com, john.ogness@linutronix.de, 
	juri.lelli@redhat.com, kjlx@templeofstupid.com, linux-kernel@vger.kernel.org, 
	linux@weissschuh.net, lizhe.67@bytedance.com, mcgrof@kernel.org, 
	mgorman@suse.de, mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org, 
	tglx@linutronix.de, vincent.guittot@linaro.org, vschneid@redhat.com, 
	zyhtheonly@gmail.com, zyhtheonly@yeah.net
Cc: tiozhang@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 6, 2024 at 2:47=E2=80=AFAM Tio Zhang <tiozhang@didiglobal.com> =
wrote:
>
> Otherwise when watchdog_enabled becomes 0,
> watchdog_softlockup(,hardlockup)_user_enabled will changes to 0 after
> proc show.
>
> Steps to reproduce:
>
>   step 1:
>   # cat /proc/sys/kernel/*watchdog
>   1
>   1
>   1
>
>   | name                             | value
>   |----------------------------------|--------------------------
>   | watchdog_enabled                 | 1
>   |----------------------------------|--------------------------
>   | watchdog_hardlockup_user_enabled | 1
>   |----------------------------------|--------------------------
>   | watchdog_softlockup_user_enabled | 1
>   |----------------------------------|--------------------------
>   | watchdog_user_enabled            | 1
>   |----------------------------------|--------------------------
>
>   step 2:
>   # echo 0 > /proc/sys/kernel/watchdog
>
>   | name                             | value
>   |----------------------------------|--------------------------
>   | watchdog_enabled                 | 0
>   |----------------------------------|--------------------------
>   | watchdog_hardlockup_user_enabled | 1
>   |----------------------------------|--------------------------
>   | watchdog_softlockup_user_enabled | 1
>   |----------------------------------|--------------------------
>   | watchdog_user_enabled            | 0
>   |----------------------------------|--------------------------
>
>   step 3:
>   # cat /proc/sys/kernel/*watchdog
>   0
>   0
>   0
>
>   | name                             | value
>   |----------------------------------|--------------------------
>   | watchdog_enabled                 | 0
>   |----------------------------------|--------------------------
>   | watchdog_hardlockup_user_enabled | 0
>   |----------------------------------|--------------------------
>   | watchdog_softlockup_user_enabled | 0
>   |----------------------------------|--------------------------
>   | watchdog_user_enabled            | 0
>   |----------------------------------|--------------------------
>
>   step 4:
>   # echo 1 > /proc/sys/kernel/watchdog
>
>   | name                             | value
>   |----------------------------------|--------------------------
>   | watchdog_enabled                 | 0
>   |----------------------------------|--------------------------
>   | watchdog_hardlockup_user_enabled | 0
>   |----------------------------------|--------------------------
>   | watchdog_softlockup_user_enabled | 0
>   |----------------------------------|--------------------------
>   | watchdog_user_enabled            | 0
>   |----------------------------------|--------------------------
>
>   step 5:
>   # cat /proc/sys/kernel/*watchdog
>   0
>   0
>   0
>
> If we dont do "step 3", do "step 4" right after "step 2", it will be
>
>   | name                             | value
>   |----------------------------------|--------------------------
>   | watchdog_enabled                 | 1
>   |----------------------------------|--------------------------
>   | watchdog_hardlockup_user_enabled | 1
>   |----------------------------------|--------------------------
>   | watchdog_softlockup_user_enabled | 1
>   |----------------------------------|--------------------------
>   | watchdog_user_enabled            | 1
>   |----------------------------------|--------------------------
>
> then everything works correctly.
>
> So this patch fix "step 3"'s value into
>
> | name                             | value
> |----------------------------------|--------------------------
> | watchdog_enabled                 | 0
> |----------------------------------|--------------------------
> | watchdog_hardlockup_user_enabled | 1
> |----------------------------------|--------------------------
> | watchdog_softlockup_user_enabled | 1
> |----------------------------------|--------------------------
> | watchdog_user_enabled            | 0
> |----------------------------------|--------------------------
>
> And still print 0 as before.
>
> Signed-off-by: Tio Zhang <tiozhang@didiglobal.com>
> ---
>  kernel/watchdog.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

The description is pretty verbose but also much clearer. The patch
looks good to me now.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

