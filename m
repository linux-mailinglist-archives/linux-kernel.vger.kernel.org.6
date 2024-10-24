Return-Path: <linux-kernel+bounces-380740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1869AF562
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 00:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FD721C209B6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E2D218332;
	Thu, 24 Oct 2024 22:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UqMgaNrN"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F941C4A11
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 22:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729808966; cv=none; b=CJMEDHY95/cDUiPMAnXnG25eZx+JtQEnhcBtsTBQGqUDowmf2VkTUaY632nniHOCYTGJVGbdnnTZxf73VB4dJEPpFAMnlZ8/cOQlnMCQZcbWZoVL7RzPQpfpJEyAUVLJGmuPwkfTCMJ/sbVBBHc3/SMO4+uqtZqDPVcgg5GW2iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729808966; c=relaxed/simple;
	bh=fTf7NiontjVxpkvw+lLYNC81W5vLDGAzeU0TCcUfWnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bd2TNfBwwnXWYJJ1UOJRoytGd2xZEP/jICEA6M3XL2bKsJ6eAupxRga9vW52aJjfn416JucG1Ujyi+trmHJKgip6Iq7R0jpFJ7TcwLO9PxGdbGQRUMwMbIl74eGHFSZEpComT483nzZRC+2V9pO4BTG/zjSaEzrtaPDD6o8Hu2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UqMgaNrN; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9abe139088so197599966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 15:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729808963; x=1730413763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTf7NiontjVxpkvw+lLYNC81W5vLDGAzeU0TCcUfWnI=;
        b=UqMgaNrN0AABY0U0gCYmZE8CaQ7fPplf1/6FYyLE70MyvB879f6AxUq5Pk6WSomwPa
         tGWeJ7T/GJac+8enqAXNrOY5EWJSnscHzF6cQgFtlmNT7eT3Kd8TVhn8hYtK/MURU4ql
         EfrLWFeoxbJK3V4p71XQzS7TzZaeH+cM31rXwmvQgDLhBd6h6JwGjotJ09JgitDMWjTZ
         xmK4rnih5Tv7aLQYU8OPycCtlKm3jVH4ZVeKbqmm6+4B5GOZ9x4GuK4G/bujFt/XXToR
         XP7gMpuo8U57qEa8ZtMhyrBFTYOoMKqOZG2x9lslTym5BCECUxzXcGH9QWR9G/GQQ6dN
         8nLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729808963; x=1730413763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTf7NiontjVxpkvw+lLYNC81W5vLDGAzeU0TCcUfWnI=;
        b=xHq2Yx6OBXfLgblCo4y5f0B7IwC0bRNN+CFI0+HFebO3QiRBLz11jdjXVtcT2Z9v8q
         YdXODnNYZTpMOmUm7fNxXrOJFQwwHG5ZdsZOaGzGp88+ZiXZt3Onlic3kJ6rg5J7W5Kn
         5rsjpVV8bts9eB5umRqwJ+mNN78cdx4WghZV7QQlG7XMpK+WxHn4t5zYNUDCYNoEVs/M
         /AqKWXdBGVeP87iPNfgnH5ZEN6mwV5ZHkLoZwuMSF7wpgN7qGuuhDlZY7jIynt5AscLG
         ZSu//DFwIMUNlIxUPmS0fhatcRr4APj5cwFIf+TJ1yG1q8ZMyUhNLJutGS6KWWYp7S/C
         y5gg==
X-Forwarded-Encrypted: i=1; AJvYcCVniEEs35/YEs5QHam/dCvjZQGS6ps2bEwPmLQ3vZrwhbOy8DtpMNQnwqy9qssNc0tAyOkr0+7tg7AZZ+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdsdy3lhNv4h69oBYJNLjk7Guute+Sy4iNkIFeh+iVCoKXrIOQ
	kLoI36+0SY5z37YN5DI9ZkYKPCTz1lrrVrm5hlHJLxi7PZZpQ6yQNViWnQe4H2RwMshEyk/HCiO
	G1K7qSq6Q0hLNXgL/nd3hTzymrfbH6A+DM8k=
X-Google-Smtp-Source: AGHT+IEc36rAB8BR3DaQjrgb/NHilWXJBRfWv0wyuG153HxlKlI4YHPEaahgwR7NMaaZfstGKIU5LnVV8xSJYW//nlQ=
X-Received: by 2002:a17:906:794d:b0:a99:f4be:7a6c with SMTP id
 a640c23a62f3a-a9ad285ee47mr307782966b.52.1729808962710; Thu, 24 Oct 2024
 15:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-24-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-24-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 24 Oct 2024 15:29:11 -0700
Message-ID: <CANDhNCqregz2eyuw=n+Ci8kAsORMWp8yp3e5JSgxUOVD=6qeEA@mail.gmail.com>
Subject: Re: [PATCH v2 24/25] timekeeping: Remove TK_MIRROR
 timekeeping_update() action
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
> All call sites of using TK_MIRROR flag in timekeeping_update() are
> gone. The TK_MIRROR dependent code path is therefore dead code.
>
> Remove it along with the TK_MIRROR define.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Ah, apologies, this makes the earlier change in 14/25 much more
obviously good. Sorry for not seeing the big picture until I got here.
I withdraw any objection there

For both, now:
Acked-by: John Stultz <jstultz@google.com>

