Return-Path: <linux-kernel+bounces-241661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51C3927DB6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 21:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9232C285AD0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D704D112;
	Thu,  4 Jul 2024 19:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KW5MXy6o"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7076CDA1
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 19:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720120780; cv=none; b=Ctb7XXU9srBFPL0Y+bAZecBOmYCIxajTYJK4VTQ3ZpOBMzc2CJTN2QZGpjYLDkwOC2W+IZIjuKlSQ4U8b5MyvnLNO6YTCRJ28gjmNGYxYFyA5kkOcbv3yO6CnDqGIMnDn67qy1Ln0PH8Jb50b5g3EvsTworOULTHofvr3Y6yf7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720120780; c=relaxed/simple;
	bh=RvsSi8CcWuxf7mDNmjpLZS5c1lR7wLo8IR2uo53gc+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bt3dW7qtDPavah0oJCzI+dBqHfRDFi1PGKyrHP/ruyzQbsg6/UUuXqE+f86UKssCc+KqLKs+rFaXS0RCZRjmBNXd6dYbciF2gEdv48Ttv6CNLL9U9OXm4DyAsDgf7qkwYPkanDiAz33+VsEwmHDmbfDwSQXK0W8u82XwSM4JNmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KW5MXy6o; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52e9f788e7bso949390e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 12:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720120776; x=1720725576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dMTxsKYHdaYJleEB9Ia1vgf9WyawD3quuYCxDUxBExA=;
        b=KW5MXy6oUxe2YdheS7mutUiYiXHPUw4HhUQYGTjO1/hiBQmYt9B+2EcnBCmO1LMbMP
         bYgSGpdXh03JczoTt5a3BaPa4GKu+j5sCrpi977stMECj6tBxqYaPSSv9OwTgSTOR1EW
         9p4zmA4/dKBI5Jt84SqK4AiEcKIi9M0edufDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720120776; x=1720725576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dMTxsKYHdaYJleEB9Ia1vgf9WyawD3quuYCxDUxBExA=;
        b=cPZNWf7+keBCZbOYM3ViYOTDs7EhxYPSJ0VytpeZfYTSoo0BKT4+1uZe1p+zNF0DQt
         EuNqTNxSQMd0SYYYBvVtHGCeM/CA756JFX5EdNvot5NqIYe5MlFyAGWNNowtcJzpAnC/
         e8TX0UAqKxeMYhfuE7XZyL+YkFW2ZYI6G3RHYELJTaZ/WPIUIbV8scL2grwouLAw6LCp
         YVSGAyLtdl2SdH0cAxlNLg68VscBzKywIyFvhKevYTFVZXCS39Z1YHdpsPBlDUeCMWb0
         FjMIGjr8XIkWOMXZFyYuYLlQcI3Rub0cgUylTyXksHOeHdz8oF9UEJZkUYwpYikAW0iA
         UBBA==
X-Forwarded-Encrypted: i=1; AJvYcCVsEbNlOVE0wWJRFzWqQikPzuZD37TuQWm3KgD8I2pq0mgMU8OD2XnjHBMdm5tTv23E0uLOCK0MFtmya9pyaFFdNMQCPOXxbqttbO5K
X-Gm-Message-State: AOJu0Ywb89gXui9aRAEzVYHg5Q7hlDQbpjemma/hsfiMtyWepU6w2J8J
	nAXCCQFunFeApETBZVcpT+hGM5n2T3jWh9yDjsfYlne/BwXqE5ZnyIG4Vaz85nVnLQ3wGUDOxzB
	fQK+6mw==
X-Google-Smtp-Source: AGHT+IH+dVcN2XxBz50IJhjj/dwxpKufDSr/sg3M0Iuf5HEvEivLVSGCfpbpTn9IcRSFpbqZVA9WMA==
X-Received: by 2002:a05:6512:20b:b0:52e:9b9e:2c14 with SMTP id 2adb3069b0e04-52ea06e23a4mr1713988e87.60.1720120776169;
        Thu, 04 Jul 2024 12:19:36 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e9f8747d2sm319198e87.208.2024.07.04.12.19.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 12:19:35 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52ea2f58448so640201e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 12:19:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVhR86S0OB3ILCDCWwQcZJys6ROcDkbRK28VAUeYXny24HSVzZt1LTEfIzQhr5NxrQwgrtSa1bRZ4GNgOwS1KfiAb62+DSW+jbwQMuq
X-Received: by 2002:ac2:5323:0:b0:52e:9905:eb98 with SMTP id
 2adb3069b0e04-52ea0637a8bmr1492910e87.35.1720120774571; Thu, 04 Jul 2024
 12:19:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZobXdDCYBi8OM-Fo@zx2c4.com> <CAHk-=wiGk+1eNy4Vk6QsEgM=Ru3jE40qrDwgq_CSKgqwLgMdRg@mail.gmail.com>
 <Zobf3fZOuvOJOGPN@zx2c4.com> <CAHk-=whf2Pb8fSmUsLRSn6CnYvQoyUkLikKpFDWN_xnTJqix=A@mail.gmail.com>
 <CAHmME9pm+ZE2_qf1DNxukB6ufPrjTAsnwin05-VX_gS03Yq-ag@mail.gmail.com>
 <CAHk-=whTjdO6szgRKp51ZeDLDmA1+YYSbg+vEUt9OsxTMDUtjQ@mail.gmail.com>
 <CAHk-=wgqD9h0Eb-n94ZEuK9SugnkczXvX497X=OdACVEhsw5xQ@mail.gmail.com>
 <Zobt_M91PEnVobML@zx2c4.com> <CAHk-=wh47WSNQYuSWqdu_8XeRzfpWbozzTDL6KtkGbSmLrWU4g@mail.gmail.com>
 <CAHmME9pgFXhSdWpTwt_x51pFu2Qm878dhcQjG9WhPXV_XFXm9w@mail.gmail.com>
In-Reply-To: <CAHmME9pgFXhSdWpTwt_x51pFu2Qm878dhcQjG9WhPXV_XFXm9w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jul 2024 12:19:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjCmw1L42W-o=pW7_i=nJK5r0_HFQTWD_agKWGt4hE7JQ@mail.gmail.com>
Message-ID: <CAHk-=wjCmw1L42W-o=pW7_i=nJK5r0_HFQTWD_agKWGt4hE7JQ@mail.gmail.com>
Subject: Re: deconflicting new syscall numbers for 6.11
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: jolsa@kernel.org, mhiramat@kernel.org, cgzones@googlemail.com, 
	brauner@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jul 2024 at 11:57, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> I really do not want to expose random.c internals, and then deal with
> the consequences of breaking user code that relied on that. The fake
> entropy count API was already a nightmare to move away from. And I
> think there's tremendous value in letting users use the kernel's
> *exact algorithm*, whatever it happens to be, without syscall
> overhead. Plus, this means further proliferation of bad userspace
> RNGs. So I think the deal is a bad one.

Bah. I guess I'll have to walk through the patch series once again.

I'm still not thrilled about it. But I'll give it another go.

                 Linus

