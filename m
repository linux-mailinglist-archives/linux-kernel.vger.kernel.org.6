Return-Path: <linux-kernel+bounces-380696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 854069AF4A8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 23:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79CD1C21EF2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763B22178F0;
	Thu, 24 Oct 2024 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PyzD6QB2"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDC22170B9
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 21:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804915; cv=none; b=gt2o/e+9lPgt3D5JSIe5Gx01sWjJixYkphYhsjdWU6xnaDpVa+fU4v1hiIPx86On/6Ei1KORQwJ5/l/M0XzdZPei0K2fqi35RzZAhHiwhxnkeLEBdrMdJazcSq79ujpvYuQBhdQ5DjPLeuXgmm5cLgEB/12wP+NK2HgeeKZGZew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804915; c=relaxed/simple;
	bh=/WQoSvHqnv2AaCKBN87rg4+23CxO/Hlfj72utA8xuSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bw1lXIc9E2SefU+YzMHqOc8Hv0OqE1eTIyLk4t+82xHxoZICqSm7lP84jpk4ZZg0B6ivZNW+YXXVmsvvtr7JlBdGhX3k7iUOQwnGqjqOw8w5oiHh5aXMpDWg4LwPSfFfMmQH4hKgg6sPR7HZL+0C27PI28IrHsiJwYZelVZ+TcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PyzD6QB2; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9abe139088so190710966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729804912; x=1730409712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WQoSvHqnv2AaCKBN87rg4+23CxO/Hlfj72utA8xuSo=;
        b=PyzD6QB2XjAmFyGPn0fkTwJj5qVthe3+yHJ4A+7UjUQ1MNJnDlEhT3Z3WyLaOUywmF
         WDXuPVMayZ8YMqWH4fazLR4dAu3cTmBpo1VFNp7y9sD9IljAE8oxHln1JtZfp6SuMnRK
         Svc+aWRiyZKSLbPoNV+Hsg8PrV+pk3Y9rZsPhCpD72RFKAy6tjNlZXSmTVIV7tdR752q
         bSQ0PksnWERMapeTO9sD8TLbLT8T9pFo0W6bf46gS9Hwb+2DAhPHJ6DG8Ok3rk+6zxiX
         FF9boSJVJ1dihQbaQJyUFhuxJm+93GXlnS3nzKqU8hFlFkWA1673dR8Yga5Uf3opGAKg
         QYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729804912; x=1730409712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WQoSvHqnv2AaCKBN87rg4+23CxO/Hlfj72utA8xuSo=;
        b=tp1Kg6NShRn4l+VUqY41ELPPBnVSxHrnX4khSiBpZ5J18Kt6tVciSZH9tQOFd3ixsX
         nF/j9qke9hTqnltjMM9VZqfU9qeqPukVCK/FiIsf4c+acwngscpIpRtp4QnzlbKPRCMx
         GZ+ZWVUGBXynAyMPA3K5AUO5dWZB9FfVM37cKiGcRzCBhcYRDZdfnqMcXRs3QVmsvEFN
         PCsVRXDnzEJyVuq8yT15pjXgOUn8beCML6S9q03L0tREh+xpO1RfT7RH6T4JoGhNqu3i
         zGGmgeaeRoIVohoe2U4OXF4ql4UKg0XOO82SL0wkxiHFYbGp1Qa7J6zHf2CbFmc0Y2hs
         NAHw==
X-Forwarded-Encrypted: i=1; AJvYcCWJQ/h9e0/vrYCbyHXf0XFEi6lzTZhy4D4YPNt6t+kQhJ1/61sixqBKGWXxvRG3IIMpUIM6xwNqUtb+ZEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+jBqTMhiKocOsCTT2IN2ieAKSa5twF4+5rlKTb7VOtDp/CYHP
	wtzDYlPs9tLfuk4ULrFvx5wWSUggaf9MqNzKdxSqywZm57E1amzSxCKYdlTdy88N9Kca+/FQpP+
	D8vHjimpwR/MZ8ecnX5T3dfrhhlervA29xXQxuhi0B2/FC4wl2Fw=
X-Google-Smtp-Source: AGHT+IHtgEhxn5BA5sOxWnweacFsVWNQnKA/wvWAjKL8OCa05dpvvIHMQnAIiP14sjO06mtJlY6sA8ggvhC//ltBKcI=
X-Received: by 2002:a17:907:7f14:b0:a9a:cee1:3cf3 with SMTP id
 a640c23a62f3a-a9ad285ee91mr326044566b.53.1729804911718; Thu, 24 Oct 2024
 14:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-10-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-10-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 24 Oct 2024 14:21:40 -0700
Message-ID: <CANDhNCox-M6J9f-hak2CEBqG8PRM=ht34cfTRQ7O5VnCU=Jryw@mail.gmail.com>
Subject: Re: [PATCH v2 10/25] timekeeping: Define a struct type for tk_core to
 make it reusable
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
> From: Anna-Maria Behnsen <anna-maria@linutronix.de>
>
> The struct tk_core uses is not reusable. As long as there is only a singl=
e
> timekeeper, this is not a problem. But when the timekeeper infrastructure
> will be reused for per ptp clock timekeepers, an explicit struct type is
> required.
>
> Define struct tk_data as explicit struct type for tk_core.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

