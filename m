Return-Path: <linux-kernel+bounces-380707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E67479AF4C9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 23:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B5CC1C20CDF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7293021730C;
	Thu, 24 Oct 2024 21:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mGGolRnA"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA221AF0B3
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 21:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729806342; cv=none; b=itea5NY7qhhSZb8iauOQl2KXJozfNGuSb653uGbKcU2GIC3lsUPsimIY1Bd8E/uTWi6QTKS+j70me/4YGdVK09ewoReVaLn3RmYpxeAxrv9EX372bLApvt1cTqX8SCDD3E0+RL0Rxbne779Z5vBZDslyxlU28JSHHepNwlgau3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729806342; c=relaxed/simple;
	bh=mWcIkPTEtqLNYNHa5k0Vz0hDoDrEgX6WzPu75Bhb3pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jf/lTwVJFznnKosAg6QG6bPlEMccbIsCAeSIgU5wAFMiV03dMEx/YjiAY3cjbF9vzPwr3HPdEuY1Q5WpV+0ncK2tSKa+kWrMV+uY9endE8kYmXO+prnJmq1Y0qutULy9MmD3qF74LiCqNQtA+inhIGei5txOoVofAKuI2Xz/ZLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mGGolRnA; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a99cc265e0aso192309166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729806339; x=1730411139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWcIkPTEtqLNYNHa5k0Vz0hDoDrEgX6WzPu75Bhb3pg=;
        b=mGGolRnA63+rFTIX15RX9ZYME6dFwOhjGbNT4H6glXxpnAsXrdasI/LJfbYSybZU1G
         9R6hb0+ooKNZnY/7dG0vfAozfMBW12+w6YrxLsdODq4QrZhsaOaVz15jZCwvxKIoeMuV
         b6yEiSZlyeQSImrtMWCWmMnTNz7wJBw8agnN4xd0/Q8/fCC6G/0F9UjrMAmjeKbArm8M
         bnIDVNxddATPF+Upv/NmVGTtr0XTGSoQQMXyn7jNJJQ/SnK7EgkR6IIwWRDrAcWk7FD7
         g566ymrBlOYEHDtKFjpGHpMrCrZJnMBKBLw9GnuqkuomPdqQk6YQ1R4kyqo3Y5MXWbmG
         TZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729806339; x=1730411139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWcIkPTEtqLNYNHa5k0Vz0hDoDrEgX6WzPu75Bhb3pg=;
        b=BMK8Mdserkj7xQPPmq6wEwCtoFO1TrNR2a+uEXPw3ONb4QGtBuOM21ds0Jrq33/FFV
         aDEuAFixFAS/rwDH2Ic9SgWkl+cCKTj9d5jbSJkPWRlZ4Jy2JpJhdQsvMoPHJA6+y7aM
         DnOtP/byqgN+ZwJdkLBPZnXfoXzbepCA7ky2JvQUQscbAQGxaV1FTMvUu4kE0bb3cy5A
         f6GpVYTr5ObIiXauq0FdFryz2LyxgvTizsQ/9CLCir9sAJPViwDbqR/yNUoaRb3fWqEV
         W7AFRM7vMyaxcQwfhrO4inzl1PJBQBZuQsq/be6lCZUC0SUZUI1fO8Uc4VxkgDKygTgl
         qYNA==
X-Forwarded-Encrypted: i=1; AJvYcCX88sQTMYbC6O55yVOyP9f8/iFS7Y4fhX7mxx0G47ya5ivE11UpVm5bc3BcXE8PPoizVsZMIFLzVFBBE3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyncWQIKYsJRDrepI5CY/G1vhVO0EruhtJsRXIju+M3ym6gcTI
	1pmdPf4tcGe40MYIUrUensOwpjEwnGcXCfnTSv1fgDrIH9d4h0CyAqBbZVl14vagzd4z06n3RFh
	tRvLpso5/4NaenIxfLDld53SaihqxdrQc8wk=
X-Google-Smtp-Source: AGHT+IE2SfueeFIlJqOmVFENL2deNH3VRLZbBUwEYCcOw7KsX515rPsk811ZrTgM7vbMcSCdF4fxa5q+VxZ3xD2a8Sc=
X-Received: by 2002:a17:907:7253:b0:a99:529d:81ae with SMTP id
 a640c23a62f3a-a9ad286c797mr305690166b.55.1729806338871; Thu, 24 Oct 2024
 14:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-15-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-15-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 24 Oct 2024 14:45:27 -0700
Message-ID: <CANDhNCr9mVe_ARu1gaTxpSMA-ybqBWvXG5Ros1b0P9uMheU17g@mail.gmail.com>
Subject: Re: [PATCH v2 15/25] timekeeping: Provide timekeeping_restore_shadow()
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 1:29=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Functions which operate on the real timekeeper, e.g. do_settimeofday(),
> have error conditions. If they are hit a full timekeeping update is still
> required because the already committed operations modified the timekeeper=
.
>
> When switching these functions to operate on the shadow timekeeper then t=
he
> full update can be avoided in the error case, but the modified shadow
> timekeeper has to be restored.
>
> Provide a helper function for that.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

