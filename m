Return-Path: <linux-kernel+bounces-393172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E326A9B9CC7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 05:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5460D2820FF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 04:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9320A13AD20;
	Sat,  2 Nov 2024 04:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UZoxe03u"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7F020EB
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 04:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730520949; cv=none; b=Dv4Nsya/yDRYEeJlIg70E5I5RGDqihZeK2H1C1dqanEFqroZ9FEBC+/6pXGv9BylHC3bVMh4kCMB0WNCfYbX+6/g6BkuQ4E+cTCki5WKGxl1ye7ux62KqI7EevecI/2GcMfkrHwawbnVGtE0L518/i+Hs/n4PUZQqDCH0PZgQY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730520949; c=relaxed/simple;
	bh=UKd1zj9ed9x+HauKpGT7Nf+g/U9f6uZcRXFye06UpEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MOr/8C2d0vENLD/SeaS7PJq3FcC56ltMhfyrXO3L35Y6QdRr1fFN2WcY8H0JGXgcYBkZT9ProIPiU1rU7h8why4r++rBqZdmPK4JkmnEBZKxwVmKkciwwmsCpkiX7JWdSGGjq2REhhIyMVOfZzAh1bug18xd5PdCSQ+ZSDtJyVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UZoxe03u; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c9709c9b0cso3724656a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 21:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730520945; x=1731125745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKd1zj9ed9x+HauKpGT7Nf+g/U9f6uZcRXFye06UpEI=;
        b=UZoxe03u/nPlf5QUfqBpJ3P3MI20IuyTH30KjTpDP9KbXGRLCJBUxGsviICNKu2iPY
         NpG/8r9VgNWUrwYqhqlnT74SKphSTza7EjacCPyRp8cpRJTqj1sZ9MGXiHm1xKr2m3Wl
         0KRuqiZLkM6DHER5Yik+oAeA/pTbgTk84/FzSILeQHmpX0WwB4YoM56RWhvpfQJh64nX
         q2xdPIaAzS1vs1MrrU+U6BqPADMRvCqDB0SylXKLBjtkv4JCAdXY2fEoi8j3KnvMjKuG
         A7mOaVUn4yFkKt+OBuvUWNRFkMqaTH8DSxNSOONWTJvcguSH1LAvhp/NNKHcm80mcaZz
         MgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730520945; x=1731125745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKd1zj9ed9x+HauKpGT7Nf+g/U9f6uZcRXFye06UpEI=;
        b=VMYUxsqgrMJyw2pTtte3kD+xXM2Y/3Eur/7E8G6S7F2/zhhUF5wozOqqa+GQijXg7l
         R2iWnvpRM1t4RL2mNjlXzuNUM0XtJFlxrkAB+F/0jFGQJRaXLXteWWTY36/JAE4drMHv
         G/M/2GMgR0soQGY7Mnkjr4X/nNo2IZ5FLJZlbeUjDFY5T5gW4eEI03Sl8AxyL8U7iHiy
         ZKKcteClFw0WBhT5t5IqYPlQciamxxIEMomJGBQMrHkwqpto/iYqne7Kt5Ig4ty1ux1h
         4WHvbApP/9XXmHIR86R3PVh9/eMsflHYPTEtZlXbb7esoRKXmHMQuT4kX6KywSVXfWX5
         uQFg==
X-Gm-Message-State: AOJu0YwXtj91t8PArJBJXZ4EmyKa2fVG9x9iPLrFP86Nlf6apdEmnPxr
	X/NTJ61FEezP9UjFQkoDLwk9LyInpXANM3PYSl3jyZ2TCewXoL1/s7bwOseXUTLQ/oajFxjGhxx
	E/bNcUg3ZABZXDYXmEcFtWtsmQROwLHgDtso=
X-Google-Smtp-Source: AGHT+IG5rGIm2Ag+4OxDuvdMCFtzRc2jiUWfdEYRpFVLsZL+97QedtJk3djwR8k2DYuO9g53BlljXtNO91RGYEVWs1k=
X-Received: by 2002:a17:907:728d:b0:a9a:cc8a:b281 with SMTP id
 a640c23a62f3a-a9e3a573cfbmr1156146266b.3.1730520945460; Fri, 01 Nov 2024
 21:15:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031115448.978498636@linutronix.de> <20241031120328.599430157@linutronix.de>
In-Reply-To: <20241031120328.599430157@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Fri, 1 Nov 2024 21:15:34 -0700
Message-ID: <CANDhNCrL_G+HPfKPNpH5QFhouE_Hn-Nx7EAC7vUjLeL580q-UQ@mail.gmail.com>
Subject: Re: [patch 2/2] timekeeping: Always check for negative motion
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 5:04=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> clocksource_delta() has two variants. One with a check for negative motio=
n,
> which is only selected by x86. This is a historic leftover as this functi=
on
> was previously used in the time getter hot paths.
>
> Since 135225a363ae timekeeping_cycles_to_ns() has unconditional protectio=
n
> against this as a by-product of the protection against 64bit math overflo=
w.
>
> clocksource_delta() is only used in the clocksource watchdog and in
> timekeeping_advance(). The extra conditional there is not hurting anyone.
>
> Remove the config option and unconditionally prevent negative motion of t=
he
> readout.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

