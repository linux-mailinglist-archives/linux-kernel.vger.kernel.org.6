Return-Path: <linux-kernel+bounces-325577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D72975BA7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8457B1F23A7F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79311BB698;
	Wed, 11 Sep 2024 20:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d3kkqGK5"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CB31B655A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726086033; cv=none; b=HvOMrQDjJKDBCvuJT0DB75KNBzYaLk25hOOjWju6YaVBkM2HqUh6YF/r7DH7YPKU+rNb9k+x4++HiB3CegkiqO2UOOQg0KJPJ7p+8JLryC2vXnwz/jI+ZYIPbn5/Di47uwzqJM3vljOcqwk8sQPUqdBeCAgG2JPSIRhYOm454tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726086033; c=relaxed/simple;
	bh=17TxleIW6R7gWSpmadpXboypIqEFClM/tdQvl+4QBOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWYSoUuyCiHM6roD/CuZVHxR/6ImU5Lw3M0xqwNSO31O3hjCHmcDIge6mPp0J59sjahGhwvnczAepm9yixBXA5Dop9Egld1k+m3joaDcp1MhQShl7XIhz+qFu5xAzuU14/UMfeWG3yDv3TzZ7fwaMiwRkifvWST/tcF3QEIvrG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d3kkqGK5; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8ce5db8668so38921266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726086029; x=1726690829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17TxleIW6R7gWSpmadpXboypIqEFClM/tdQvl+4QBOY=;
        b=d3kkqGK53JRhkkKfHz9j6RCdrS7ORF7dUyfp9isQN9qXvJ+3Z4N1n8S5aPhx+vrAOM
         2aSB+GSOlN3qPCEvSEn0Zrh543jgeTevMjVJzTnOUanNa9nelOz3tLaSXxVDadTK/gMN
         ELp4K77C2Fy5Gq545NRQbRO+r/OcjcTaWOs5vc1uJlGi18NfhW4Df732MeFjw0BVr8m4
         SkfqwfgWePcWE6w8yZto0Hpk6LzmQtq6OQBuoTPREC+mhY2FWOju7o0+FjTdwBZd7feT
         +6tcMSGkbxPnpvCY96acjRXu0t2WX1D8C5uum9QzZZa85O4R7ovcinpchLWVbaD3Zr28
         bR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726086029; x=1726690829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17TxleIW6R7gWSpmadpXboypIqEFClM/tdQvl+4QBOY=;
        b=JadJOymIYzjLmAXZRO+SCEV0Fmf9hbk418NSlF1C3l0F93xtyol47zPiW9E87b6H6A
         OJjEqV5UfqjmXomnfUNwyqkKt0+SVK/RRLLsVGVvJYKBF9yA/wArMyRYweu8zMLnVGXv
         hvY0wNBKgP2AA3/sGLKVRotwTKFCjlQIP0s5dOXlHpOg7b5msfdles4vP+a/3/RUKOVK
         JQSeBh/cUWpTgrhl8RzJWa8+UblNN5sw9fQkP8+SZZLlItztdGTLr4yGuMGSmdWmqQ7V
         n0zJvcARTSzsIK0E7CUJwe2ZCoIfjdA9+/L+PdLfs6KtLAHwg6qMQp9o4wxvAQNuVrQ5
         t1Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXNTjeb+Bp4ta6qs3dVoVpm1xgeOGwMTdgKRQ0bq4jcC0xz8kkGqsgfM7mxHoltHK4ZUgBV+wiVWqBntHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFodLaDABVlflc4u5ml6CDJhwDf7sL/sWM9uua2JZ5woEZRCCW
	lNmGeE/D0egGLeD4iPPwPs/GHvry7koQ+iB3rzMnFVtEyj4wyEpjhV02bR+FNqyfPC77bOVwSj9
	NIW7+boBiDcwx67qWZrI+GSQ4YyiuUvbHM58=
X-Google-Smtp-Source: AGHT+IEqI9RSt59HcZKfkrb3+N2g48eKklIT7OWBhDN7FyBJ5Emwmg/ESMqX7DRWe+MxgciwXRmIHO/h8cjPggNSiKk=
X-Received: by 2002:a17:907:1b13:b0:a8a:78bb:1e2 with SMTP id
 a640c23a62f3a-a90293b15e6mr74991466b.6.1726086028469; Wed, 11 Sep 2024
 13:20:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-7-2d52f4e13476@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-7-2d52f4e13476@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 11 Sep 2024 13:20:16 -0700
Message-ID: <CANDhNCqHaGYnMKqmVuaUwG_rXjHw--+es=OHNE2M3Gd94kjJ9g@mail.gmail.com>
Subject: Re: [PATCH 07/21] ntp: Introduce struct ntp_data
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 6:18=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> All NTP data is held in static variables. That prevents the NTP code from
> being reuasble for non-system time timekeepers, e.g. per PTP clock
> timekeeping.
>
> Introduce struct ntp_data and move tick_usec into it for a start.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

thanks
-john

