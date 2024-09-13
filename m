Return-Path: <linux-kernel+bounces-328953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6375F978B6A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 00:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17E1A1F23AD2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 22:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5921714B3;
	Fri, 13 Sep 2024 22:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fT+wurmc"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E102153824
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 22:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726266547; cv=none; b=W6KqcP0GUhIbXAZU0ode1Icp5CSB8Luh1TsglE/fOMitjv1jMXOx3iDrCQtdr8+yPP4Zws4VUhltGLvWmTjQWkhrNVli7tMMdhcrZFqhy4WSIfQp8I0eHl58I8MuWhkRnvc7el7VNM1g7lM0T8h/qz+xQD6zMfR36jlub7nRKx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726266547; c=relaxed/simple;
	bh=IvzabYSh+pHeeHd+hD1FOErHkOCPfysKNWasduDGcwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ThgIaAjqDjoT8mxKO5OPI0J+uBZsHur0zeWGpQ2PsnmCZDGodoLvG9cfYmNwHKN0BhdXCI+Rt9F0Ps1iqkGMIpeMcd5bcVaUcKVKHUXEZ6kAn7m8vduAIv+yqQ0J6j+wwy7ZT0DbTZ8cyVBFEJFFaAj3UhVKNZa2ee7Rub7WC2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fT+wurmc; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c42bcf35fbso59499a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 15:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726266545; x=1726871345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvzabYSh+pHeeHd+hD1FOErHkOCPfysKNWasduDGcwU=;
        b=fT+wurmcxfAuJL3JFVqksvipHULlUHiaSdAwWeQUm5Acr8M2Vqed+mCp2Dvat8vV/C
         iByEJV/EHqOMKn0w9+zxU3AEdxOMrmwNfiSUEb7nLMH1msXRrjcM5b/iQMG6Mb7YRU5N
         j+0tZz098AmE+pDNU2nL9HY9xb7LKoXbIOTi1+Plxd8Vw8siD+Ungm1snDX6hfiXT8jF
         dQuhhVDHkVXQRtwdr14gVJ8rjZHIeVZrs55KWn3XUl5uKgZL8Fch0c5H2LmdieT/ZMSP
         HoU5AR8xMlPN1zaizbmuFxwahnNm5q9Xcgq83kTTxKqpyL47tugtQpc66WErjnKBkwaV
         g28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726266545; x=1726871345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvzabYSh+pHeeHd+hD1FOErHkOCPfysKNWasduDGcwU=;
        b=CVoA6aEIsWSNN9lt8ZH+E7fYLW77zDe6PmAMMwhB59tOambZlndWGGp8RZ9NySqIkB
         qeDAZ2Sq1S6JNXGC9ikO8a77L5ol6rMs6DtZdGogzrEanzkncus9Xiwv2z5LIHGc6SG1
         d68jXc+Eyef7fAI3kuVietq0cet1BlBaFpJXv4e3vwoBdDqlUEaZ8aIDkC3y26ga+V2M
         FatXUsENbqBKzoiyAdVsvMqT5WrmvfjXQ7jvO7ARW0i6AmoRmn0OqRbdZuWznwx2eJOK
         IoR0PjnAZ4W8OUPWzQTQoLXOv04Hbs5/EYtaqAZcbRg83xk/sMY1u9D/Ybli7OImcZwG
         9a2w==
X-Forwarded-Encrypted: i=1; AJvYcCUbumVtlhJV2JPBYz8u05oeh4zNvKdqiuzJhOUDPCM777q3sRcXbtqjYNblzdqDUmj92lPfNVytA7Xoi1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5sM0Vs8n9U6lhBxBOwZRgx9d5mWUMt1XHIJl6R33A6pgxwIjy
	RgQWdh676s5mF7XBfuhC6rry2Wzc7pfma8p6dVPhs1P1txH7HY2eJVN2xJAPLHK8YCiNuATEsv+
	UbLsbQcgSvaWHd+IJiXpU8OQFwcbFufy/iMA=
X-Google-Smtp-Source: AGHT+IGz4HrZgTUzfTrywk01MKDCVDNjEpFYnYsoSdttd9K4GG6wqFFHYTex9HUp/m1OnssmyakcUkoL+HyjINOHmus=
X-Received: by 2002:a17:907:f154:b0:a8a:8dd1:b2d1 with SMTP id
 a640c23a62f3a-a90480c79ddmr413023366b.55.1726266543519; Fri, 13 Sep 2024
 15:29:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911093029.3279154-1-vdonnefort@google.com> <20240911093029.3279154-5-vdonnefort@google.com>
In-Reply-To: <20240911093029.3279154-5-vdonnefort@google.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 13 Sep 2024 15:28:51 -0700
Message-ID: <CANDhNCr_cCeLdqMTwNwgCCeiPifSsew_-hwOC-WY_-PvaNiC9Q@mail.gmail.com>
Subject: Re: [PATCH 04/13] timekeeping: Add the boot clock to system time snapshot
To: Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	kvmarm@lists.linux.dev, will@kernel.org, qperret@google.com, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	"Christopher S. Hall" <christopher.s.hall@intel.com>, Richard Cochran <richardcochran@gmail.com>, 
	Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 2:30=E2=80=AFAM Vincent Donnefort <vdonnefort@googl=
e.com> wrote:
>
> For tracing purpose, the boot clock is interesting as it doesn't stop on
> suspend. Export it as part of the time snapshot. This will later allow
> the hypervisor to add boot clock timestamps to its events.
>
> Cc: John Stultz <jstultz@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Christopher S. Hall <christopher.s.hall@intel.com>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

Acked-by: John Stultz <jstultz@google.com>

