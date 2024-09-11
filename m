Return-Path: <linux-kernel+bounces-325586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB06975BBC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D076328514A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212407DA9C;
	Wed, 11 Sep 2024 20:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u69Ldnqa"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0482C13B582
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726086616; cv=none; b=aVYb7j4ItvXgUqYUb9cR0Xci7cFDdMfSP84i2x18k/peieIEwxLgcvQoub1GXiBimDqE3A1S0E+MmXo77okxxccGMIp60OXgL78luwPxGCcBp3j6oVmRluwHszqqdhWt6PoiHLGwoyucA4BWJU8sESUqrAELkaDCBwN/f4tRSEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726086616; c=relaxed/simple;
	bh=mD3jHmQWAY6Oppf574BbgavHABRgp9MNGZT+gDX+xM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gObOecwWntEhVIwlQCYNq4liSB5atv70xhylzcdkk9oz5k/bvExhHluJvl57EGegWuL5dty+rE3Zoph8vPkibJ7/fgbENbTGN6du5RmoaEjWPw6M0rLWBID7F/wFI6Kf2LJxRlf9d0afDEnnHwLYdF2xwcVR4Ex4+953lPzw6CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u69Ldnqa; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso2953271fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726086613; x=1726691413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mD3jHmQWAY6Oppf574BbgavHABRgp9MNGZT+gDX+xM8=;
        b=u69LdnqaRUJUeDb3MAKLAFTddgN1dijZr0GZQO2/vbf4ZoHwREu+y+4YucnWWPC+Th
         p7vOpF9m/DpiYj3Wn/OIzfDDPRpyNqUatUJjYHprbkd8vbqqGlPngDT+Ufu6rt6byM/Z
         Gy3Rxtv62nmElN8eN7+hIkf8X3OkYXkMbM4scE4RbTYdHQTj1Y0dNDr9otNntB1lfbQE
         9FyHWiKwHfRdL1pcyEruQIW0ISPUO7mwHbBVK2HxSLq2XAFnDGEg1viJoY1XlSSV5ieo
         /DCUUIxha6Yl8aZ6l5dA3+Z16SE1kUQvmfv1jbC69sDz7i0XDbIBQKicNvpYGDwCGw4w
         YISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726086613; x=1726691413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mD3jHmQWAY6Oppf574BbgavHABRgp9MNGZT+gDX+xM8=;
        b=vZQ70+o1zNuV2l7vX/B1bKE8KigAb3rRXZBHkvbSW1CvUmB/OZJWjniyKufmScwvru
         +DMtZZKQKgxGvj8xM3h1MzH24eBZ0rJWsD/TW8bR5YTqhq/qCdJbKstCI7urT/TqzDZO
         kbZk9qirspTV115cdmc66697hTVPTGc6KvH0Ze12i96s9jAPjwE2YRlST/18ssGe3/yH
         ZLOLh2GNZRjjp6WskFWIWmeGjO2/RioQ7nV2Xaa8aG+2zmIRb8V4w6WI7eQRHzUnFH1K
         I7Yuz2JgjIuJQaYb6dK6ILFxTpbxwaWQfG58yqr0SdWK0iPPd0I/kbkyCbkXIWcXiQX9
         WYnw==
X-Forwarded-Encrypted: i=1; AJvYcCV6pSQRxARxgKUdwjcfQ8JhVONnhMnWkxL8gtnQxXCWX5sa6onunmOZgi5fjbatjA41YCCxye7Fr6HC8sM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn845k0crpYx9G2TrtgWinxe++91Fm2X1wUB0UYy7AKHq7eRJf
	epQj2fm+2qmDZBXmbGYP6dcGTdxrAs5F8qpqA6pB9oFKIvdLxJvDM7GX9o9RmG/I4crTVsLDg8Q
	7kO+8ZZOkrQl5rq/9E4foBfH0r4cWesc9C38=
X-Google-Smtp-Source: AGHT+IERcbJP4ldP3RrpCdk2BA8bRtJ+on/WCKShhXzF0zUXYdidRdEPSkU72ClAH1VJnLWbwQdtsrdQzHzVv8h9Q7k=
X-Received: by 2002:a05:6512:ba5:b0:533:45c9:67fe with SMTP id
 2adb3069b0e04-53678fe69bdmr533917e87.48.1726086612587; Wed, 11 Sep 2024
 13:30:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-12-2d52f4e13476@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-12-2d52f4e13476@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 11 Sep 2024 13:30:00 -0700
Message-ID: <CANDhNCpCudSmPLmh9FKWYONhbma3Ua+qzkPGOtQmOEbhj2DAJw@mail.gmail.com>
Subject: Re: [PATCH 12/21] ntp: Move time_freq/reftime into ntp_data
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
> Continue the conversion from static variables to struct based data.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

thanks
-john

