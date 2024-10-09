Return-Path: <linux-kernel+bounces-357579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A099A9972E3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25871C216E5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0A31E0DAF;
	Wed,  9 Oct 2024 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NGXJ1c1D"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E511E04B3
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728494346; cv=none; b=A8AgTDtOhr/sDIvwZsXO2y3tt3OOVkEQeRRLphojJb3tzdMAkW9l+ILeKW1mx0q39jJQbLCWbIPIdE2XM8z9oNzP7WDH3B9lVdaUGdZJnpk8NqUjdD7Wi+APtNY3622SwHtvzQrfWaZvqfIMql/yXup+ry4uZZgtKFvI3wDy6A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728494346; c=relaxed/simple;
	bh=SLHIL7hjWfhj5fPlbzrw/10O4q1bydyIeItZrQezCG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GS/dvEPIgxEHNRsEcBintBhGXFUR4u+9pSeE43a4Ks1+lvn5HYkpXhuVDh/MDhEUzG2zZK5eUfxgqWVp3tGBvWLq0fCvJJ8dCa3JInDNyWnDlW639BulbEOiJMsP7RZOYvJ/Lmua5vA30Umt+yNoxFcuKhmSaZhLeToznP5QBnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NGXJ1c1D; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a99415adecaso207102866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 10:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728494343; x=1729099143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLHIL7hjWfhj5fPlbzrw/10O4q1bydyIeItZrQezCG0=;
        b=NGXJ1c1DJ4F4dqkfPKHLuV942HYJpLmn45GDPzJShIZgH+ovUwikhzfYDlQml9ahjB
         6WJFRWwt2FuYAULAsbMj3DvNbDPnErxGUmRTDxYNeXvrDtDHDIoO9Gb27/2GDibmxX1w
         IZpknwtBkNs7VlpDk2rwLdA3IdLPWdrT1S0j/AT93opw4WJ0ZfokN+g8e+KqYv67fDQ6
         Hv5MhNa3XLrC1qSxva8OXGFst/LWTaKrnP24J/webnRyr2IEoFEJrfTTFViaQOuw7Mpg
         l+nit1VZEVQPBG7vzuO/W5TSJRF3/lcl4lgoDQ5VxTtfFwAgbU8fkkaKeNeLJjyNs33a
         Y64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728494343; x=1729099143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLHIL7hjWfhj5fPlbzrw/10O4q1bydyIeItZrQezCG0=;
        b=EuBwRqUzu1pWuW04rwuGOFsm7qyA588+YsVg5IqQggU9xdnT1lRVyusMQv5IejTGe6
         pUx8o53ZKDKaNplaBj5FtB+jAfK39DGZlLhDESXxVI7tMT3N0zKOqVQId5eKmCQ/t+24
         BlFZHq26VLe2KFB2vbVygfwJH7o5HqOq/+2FvoqmJE/M67UxJfO8rZtJb+gVa17Ho/bD
         Nm4IbjQYz0EvLbfLmAqE0A53+4FY+GcVZwzOj43NzyRlrBGdsUOOp7BF1HYslPCj1rGU
         57U2noTzth08NAEiJwTlPEgXak89MRbGSt8AJ5AfNBoHG3dKfg/e6HKReTD2VTbpGr9s
         zdLg==
X-Forwarded-Encrypted: i=1; AJvYcCUJSw8R3S+u6VB9NY4iH94udGWxafv7wbKMZ6E6a5OExSesgbmb9K6Qq0b/eOG/3nNDhJCh4SYdUkC8NlA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh7MnBNXT6M/OrWI+YAmausDKGQxTenbTNef8weSBUG5t+jj+k
	Ttcg2QfUuSaVPsR/TzFdMfAS+dXGdgjquwCjXHVuQPrK1wsq/UCaTa6VFd6LIidXhyLYEEVuN3X
	82k/kY/KYRfg3x0/XSlT2HI+uOobTwIi6ERtr4rwDT8KDTZ80tug=
X-Google-Smtp-Source: AGHT+IEE6ixpFHueAQsBsLpEhlL8EhwtQ6xXfYZh0WKjnweVwc5q1Tj1plcGvIrhXHKPY+fugNyLoLw7p/l4Wj9CR1A=
X-Received: by 2002:a17:907:e86:b0:a99:6109:893c with SMTP id
 a640c23a62f3a-a99a1119635mr37613166b.27.1728494342862; Wed, 09 Oct 2024
 10:19:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-1-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-1-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 9 Oct 2024 10:18:50 -0700
Message-ID: <CANDhNCqdUgazFwkqa+Kyzw3+pXfcfEd+R_t6C0BfmuubQyjvoA@mail.gmail.com>
Subject: Re: [PATCH v2 01/25] timekeeping: Read NTP tick length only once
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
> No point in reading it a second time when the comparison fails.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

