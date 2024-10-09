Return-Path: <linux-kernel+bounces-357791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB93E997618
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59F11B21D02
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7C91E1A17;
	Wed,  9 Oct 2024 19:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e/3o8xwf"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB221B3F30
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 19:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728503928; cv=none; b=t/rwlVHFLKVjUeCKfP5FQpV29SolxiJ21s6bDfu/9P4BNb/KNmvJseJI6Ut1j1T3DhcP0eA9opB9uN+yd4o7XYyW2yHsBMjKDDFiavQwWtsDRUzRcwGTjZL2gxHk2OpJdmq5BJovTF0VEGiHuUPb/rN5kyHYrpysTFxuDb1AHA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728503928; c=relaxed/simple;
	bh=NfHTMlcLeIvdDweTgtwVoYY5GdBkXiWBWcHPSsaJyA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IyY6UhP01DUUO2OweLjDzogVrMkTaU+E6lL636vrj5wdr7YtPVUycqC/FiyceXgzxLeTe2/cC5st8lShkB3RHEmL+Q6dOYrNW1kmlmN4upmTJk0k2fktPNWPCM+t+EfGXsRFaXwE11a/9byiYDlm1BvhbuJ2DZ7XB6juvq8NqA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e/3o8xwf; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c42f406e29so101340a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 12:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728503925; x=1729108725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfHTMlcLeIvdDweTgtwVoYY5GdBkXiWBWcHPSsaJyA0=;
        b=e/3o8xwf7X/zfSnovyyvLNt8yAoaHMXLObgzChX+HVr2cv0RgPpnLerNfN8O3XT1Dz
         nXvlYjBLl0VzNjTJheahwRAnHGYDaxqEdjT1pIaBEhPNdSLbr3tsW8naExMUIS1ajKQ3
         j1xzCIh/zmATjxjHCJBaGeppExHAE2IwGlIhtPpgqUA8S/sKhCnxuXIPy78/YV5VnHfc
         JjXMCEzt/2lzU39+k3wUxm5NJabXEQXixhKuqywjD89nLZGIBqRlIIn1BM3/gJE+IsmI
         UAfQTwHIcnJ2FvQGLDnkk7M5TQgDsgk7iAjU3zrKplpX14A5uEqYISK4nFxChQG1gJKp
         5h4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728503925; x=1729108725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfHTMlcLeIvdDweTgtwVoYY5GdBkXiWBWcHPSsaJyA0=;
        b=vAXqYTal+RO+cpwxti4P/6bmKK6wm3zWr8LyvNGRy3oce8IYEk7rfJVhFlp0tpyqk0
         QjBuQ982j04gAuDpt3zcM7tcIhW40WsmnMRXtOo8zUlxoz/kb64qzCdHk4NnNXKVl8hE
         H9xF5V4ZLSRQIPOzw3Njv8t34NM9HqWtzO8HeyUoqzvsbrOoTvjtS+UW9BKHtp/2kVDD
         Elpjn/DjiwDZ2YdVW9Byz2DE8vq4CkGFq2vlcVMGarT4VE50+2HPicOfdNmxyHyhZGzb
         DrV7Gl2EBgeSbGdw8XVmYEsi1nTwkkF5FvL3oktCHr8auFE0GNqhm9prPqsS4C8r5FYK
         MDVw==
X-Forwarded-Encrypted: i=1; AJvYcCXZdQdJb/2R4xdEkXSU5jwaHWoqZaWd5JeqH9uIM88L6YGY6DflbapcgtI8WGs0w3+ojIic549JzUzFUUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHALrTtj+/qkuI4BtXLxIw7FR6TQb0Ha0ds6ZwFLIXFBAqLnpf
	yBFL9jTZJZOXcyEQRMs5nnhOB47QP9lWG6DeXlnky0uvX5ACrbNc0XwE+QNk6ZfUc1jypbdMhxT
	Q01DfmpaCp2OUA+/z1pKIyAa5Sfg0cRfeu0w=
X-Google-Smtp-Source: AGHT+IHxtYkLIkxNlDjK87qi1yhBQTPxuSD3L45q7+j8+ET8HOF9fuHAjTNBiHXNu0dr5D6OrP/tk5ih65g65aAxdqc=
X-Received: by 2002:a17:907:1c16:b0:a8a:6c5d:63b2 with SMTP id
 a640c23a62f3a-a999e695b1dmr120436566b.18.1728503924422; Wed, 09 Oct 2024
 12:58:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-4-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-4-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 9 Oct 2024 12:58:32 -0700
Message-ID: <CANDhNCojYH=c8Dqgi2nPP4tK7QPqxpQMLCCAyrDJbyhv2761gg@mail.gmail.com>
Subject: Re: [PATCH v2 04/25] timekeeping: Abort clocksource change in case of failure
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
> There is no point to go through a full timekeeping update when acquiring =
a
> module reference or enabling the new clocksource fails.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

