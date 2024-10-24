Return-Path: <linux-kernel+bounces-380697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 439D19AF4AA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 23:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEFB91F22687
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3882216A38;
	Thu, 24 Oct 2024 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GDHxTVMI"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD6C1ACDED
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 21:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729805166; cv=none; b=kZaJpJP+p61FbfTk0s/OhUxhpWYY++JdjNBK+hGjV65AJp4eN0hITb4uC/EvWxs/oHSAseJjA8fU55uNEggvzrUBr53L6mTX4XfHiKBrf0cT9+wJ98xOaCWrad9PFrUQPYGBdcqh+DrHdAScoj0I5vN4lJyxkvrPStnqUud5x8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729805166; c=relaxed/simple;
	bh=02Ju0hbej8lBOecyQ1HKOEDqHVq1YxKinn01v4+GzqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqyB2fHwqrq+61/EBjvbLS6QlYUZfAYvT8I6Xc6Akof6P5WYQunHYLzolgi/rPlaPdyJz1BBdEALZurKQSW9rtrpS6CiLrR+2rEnJrbzKJx4o6FY2oqsTjzm/B+A3dOpaMtWUhbyaU3+BJJNKWzDy7eUk7jnJ5OC3ImtTSoMerM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GDHxTVMI; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a99f629a7aaso227443266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729805162; x=1730409962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02Ju0hbej8lBOecyQ1HKOEDqHVq1YxKinn01v4+GzqI=;
        b=GDHxTVMIBptKhI9yKZw/Bfg5Fx02MY/iXZhW9/q0AqW9wbRccilzXpVQZy024hjehz
         rNv+lPcx+zng8CPfs2XGDb6e/2S3eVls5t5tAIuxCloUov50llIUkK3bZcw9KbyaLOiQ
         s4gbEr6hguxewW8gw066/GoUwa3oqu7dLA0sGtxcjWvPHw9vhs6/eTIvQEfYg1XNnBdN
         eiUCxtycdC44ALyXLOCtqQzvHLr3uNr1ZXQq16/GkZTx/7WbVyuJdg1rxvlW5ics/GOe
         YFPihwy2P038osboZU2SfGIpb5R6wnBOE+WzREQ/j71RNIxIvQQM9rqG6Ro+oYQkO2oS
         +a0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729805162; x=1730409962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02Ju0hbej8lBOecyQ1HKOEDqHVq1YxKinn01v4+GzqI=;
        b=Rxt2vVyOUgIJ9zgpNzPbRbkZGYuJmAQw0EV223eLXharNflXs4j2sZTqXnnjdrpUzm
         zEF/F9XXHrM5TY0ywandCW8/7r+Iz+YhwPZBnjLGlurLfmkKavpEhFdLzpY3wmhpy36j
         aVlhW0HR/h8ztZe8SiG1hzBhu4Trq20meCwz4cmAeR5wxMbU3BJVFV3UiWL/Lw7VIaNk
         U3CGRAu6MSsTfKYDujk8MlDpHmYJf5SYrDeILSYsfcGvS7wsbuVLSPik49PGGuhIWXn2
         5E9RFPmf+fVx2etbKYY2hr1myX84Dh6/1FEwriA7tlalJqLyj0NbukDHTIi9jM4bsO6K
         pbbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWykrFa18Jqi33Num+CUbWlOXQiXtWT9uExsRkYl0+htLQyfGo4K7rOMiINeQF071uCXdBVBVYup+2UHtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0sEyeBT0nhfTwBfWLEm3QwqjFKanzKLSxQ+cC1COK/xmkc4j/
	6ZOEDStRBCUu251E+4mHLDTizQ8OoC7guxmTUz2jwcwZwXDjsZjvrKQn9gVQAfEldzwvUsqDJeV
	GCr3p8DiqW4Pawt9UpLjSa5CPzL6b9vIWfsQ=
X-Google-Smtp-Source: AGHT+IFfCFQXeBsv2p/5d9ojwB91t4WR9gtYZwaOCbNsG7CQYeiFO3Qj0tYKAzRN4mE25bpGrrgWdECqRRJ29FadD/E=
X-Received: by 2002:a17:906:6a0f:b0:a9a:60b0:a8e7 with SMTP id
 a640c23a62f3a-a9ad199c2b9mr374829166b.2.1729805162304; Thu, 24 Oct 2024
 14:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-11-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-11-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 24 Oct 2024 14:25:50 -0700
Message-ID: <CANDhNCo7rxFs8p_yq+vwt-zzOJS2ac=fbHaTF6ikhvOPLYzZLw@mail.gmail.com>
Subject: Re: [PATCH v2 11/25] timekeeping: Introduce tkd_basic_setup() to make
 lock and seqcount init reusable
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
> Initialization of lock and seqcount needs to be done for every instance o=
f
> timekeeper struct. To be able to easily reuse it, create a separate
> function for it.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

