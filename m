Return-Path: <linux-kernel+bounces-325567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE8B975B66
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456392836D2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782621BB696;
	Wed, 11 Sep 2024 20:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lzTdpMTX"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490AB1B9B45
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085541; cv=none; b=l+XugzhfLVLacEbC3KyROS1VVaBnrxmB9thcbYvzXyV2bkpLrvyhEAZE7V4rJRFU1WyifOTml8UabZkvxtOhcliC87HoFoi1tRQVwRFrpmJNwJF7w00NPZPFdm3Tc55omrmTcnvzqaYmeE3pOVptJigPTiwdU0z6dOGEls4syag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085541; c=relaxed/simple;
	bh=uTVy0H/9nrR2sptTBciRNjASgqccjEA9yYDlS8MCbeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3FQerjqZB5DMMQfPjYBZM5Y5dh/XJR6PIatJCV1tLSBNQef9DfDCFTYgz4co5Sm1z8+zWV9i5+cvOBhHjJBw5nYfITw0aYNjrH3dFMcvAJOZ6VKvJ22KLXQp1mBQAOjNCRTalQVnhjnt8VUn1dUoqV3gadKGFXxm7pF24qwh2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lzTdpMTX; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53658f30749so239346e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726085538; x=1726690338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTVy0H/9nrR2sptTBciRNjASgqccjEA9yYDlS8MCbeM=;
        b=lzTdpMTX/0vx16Yjt76H0MxuZUNuw6J+UCzWDUJvM3cysCe7O1/EB5/SM1H5gysthR
         l9/lNkDNmfYr1A6O+GHSD5m/u8CoJ1akW7U7KfeIvC87lLtBY4jiIm9KDWEsvL6LHJYC
         patFd2XwSzSw+gLnROy2hXWjW71axmBKrnbe41tLdKoUFfDQg4JMbetAApwAN+pk/NQg
         nfPO4mLiP8QduYH8w6XUhBtsR4O+Q/aVoBFx8WPS2brF7Xdz0pA/9ROzNeS4fW+jsYko
         D7CaPJCrWM5fYhL5b6k97PpCYGe0yhUoHymk7p1QFcG86gecbbShOX6Q1SMrHRbW9FgR
         Jf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726085538; x=1726690338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uTVy0H/9nrR2sptTBciRNjASgqccjEA9yYDlS8MCbeM=;
        b=TgKMYakpRU2f9U+XphjcqC2mdd6cyt3upB95L5zQtU6BRxms/7x1u7Xl5BqtbtjOyc
         2mgA0wsjQARKJB3DPFdCqCp+uDMxDxJzT5CzVUMc5L3mTcjpWQJPNakf5ikSrWow7yym
         cxOAaZ9nGSverLQpMUglV37NAlvnX2tPEPo/laN18K29kvRF9VveE5hdkZCYmu9ibXxS
         c2ua5ahDEaJSJnks+U0/LnNao3eIryGu3p8c84pjcmTybO7rgsxqH2vJofzAZKkTvKGe
         DLdYWr493nmBp9ruchmEUvkcckDTeH4x5AzFPhJZ2J1j1I1i6IuQRC8gCzIzVv9678j4
         omFA==
X-Forwarded-Encrypted: i=1; AJvYcCWczURA7ijKbsG8Q5UUZ20GX3uTvVXV0C2BXblOzWI6Sby0lF3KaQfwYAOm4WjfnLUhLwEBQMbthSUoTAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEPaZaRXrL7m/HC7lmKS0zYcCNgjewI3DHKRv5vS5PifDgaCiF
	A3MQ+ZJqIrPEck8xHQcUeLaMPufvwNKHY/jykUS1dws+4vKBQx98fm9gNZeqAUJyl8WuhZFlV5F
	vzk6Behcelwg7P6Yga840COEA8ffQoAVXOVHwQtSiV9Ty3ZZmxFs=
X-Google-Smtp-Source: AGHT+IEdnmRQdJnZf50tlj7/hoA7Gw8t8SJc1icGuYV7aI91C5kPb50//JTyOTMS9OtmqW8cf4sljGOvSoiSNkTugvQ=
X-Received: by 2002:a05:6512:4020:b0:533:40dc:8248 with SMTP id
 2adb3069b0e04-53678fab5c1mr315676e87.11.1726085537318; Wed, 11 Sep 2024
 13:12:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-5-2d52f4e13476@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-5-2d52f4e13476@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 11 Sep 2024 13:12:05 -0700
Message-ID: <CANDhNCpnBMZkp9TUca8OEYKS=ECE516Y9DMy28SrcAstYB0iqg@mail.gmail.com>
Subject: Re: [PATCH 05/21] ntp: Convert functions with only two states to bool
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
> is_error_status() and ntp_synced() return whether a state is set or
> not. Both functions use unsigned int for it even if it would be a perfect
> job for a bool.
>
> Use bool instead of unsigned int. And while at it, move ntp_synced()
> function to the place where it is used.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

thanks
-john

