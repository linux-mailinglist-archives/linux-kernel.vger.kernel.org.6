Return-Path: <linux-kernel+bounces-380681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F909AF477
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 23:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF80280636
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3429B2185B2;
	Thu, 24 Oct 2024 21:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pgCQwu2k"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871C12178E4
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 21:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804286; cv=none; b=fToVtv0PmEvf8vk+J/n/nTavwCZgBaaEkSl/o1TxRAlXyKbpfUyIjKzxMx9hR+J6p71dehslZNO/cur4Bz1VhHhMqrrrYeM0eIw9yMgSs5oelnYSKXRNmnK/E9MLqzYI50P+EG67aQlkiK8MIWJb7B0NhzslEiYNYiWp1Xasu8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804286; c=relaxed/simple;
	bh=yMbiVa6MxBi8SIH7Jh+s9NpwcvOveX//Z97Dk2oQt94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLyCCdDqt/+85JpkZlzEZ9EN7tl6g+XXxax7AmNg8tPSotICUjQ+9TkuExMoc/a71K6Qp/JYlduJtkTJwCtvSfOX0u4YMOTpnNiangaKoCpOOBXNW7aWMiwg/ibMtUxGNEJ1iOiMGHZ9NYeSKOUjDtbAuvCSVRGrmlx3CPB5csY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pgCQwu2k; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a0c7abaa6so159342966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729804283; x=1730409083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMbiVa6MxBi8SIH7Jh+s9NpwcvOveX//Z97Dk2oQt94=;
        b=pgCQwu2kDGw4WFELaWum4uv+I3HzCnJXRAsnEhWvQpDMMWmCLrglv3ieNEpWKQLUTr
         miH6qiFYrQed/npUZ5VG+y5iO7lrvAQ+m2LiA0PFbt+yGGdPo2KB9LlE47KBJ6lJWaA2
         ZHXp0Xazs0kko0E1peauc9LbKWvttnpS2CvmquwMsO1jvT9XbId3j9ZAkwPs1M7AvSsI
         rrW0fQfKISpnCX87nE5ZqhU17j62JyY36Yg9jlGJHDnW3EcQRyn0I+y1lV9CQfPRK4OW
         Mx8k+EwU0bZr1wcpuWUJxM77NtXOWBo+jteosqVXV/Xwrp0A1znfzwIR7T2ZcES/yXKF
         B1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729804283; x=1730409083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMbiVa6MxBi8SIH7Jh+s9NpwcvOveX//Z97Dk2oQt94=;
        b=TtzQwZStQNdyuRHuNmO42L7No97S1Se0mTm5aSIv0i9UxTpPQhbs5BmcMq/2pzu0wp
         dO9L3i536kzksvOs5iZyml03r5Z0XlzmgSWReiQOPF6J7KFryKm9oGVxa9r4wCzQYUo2
         2b/znAzKcq0ky1emzOTOAEd0+YCTL4RNKN8SsrzKAO81fRYAZtxHuhnOzc6kyPsydD5h
         OeaWdTYmZq6V+PEZPtJeg/Bs5oFwyO4DziPWTnx4J+5iF5DnsnsSocfxxkECTNDCLq0+
         wd/wDMcJgK85IjgLJvA8JxeSgBFsG1INaOmgiI23x9rxDICNB3PwV9sxq/k8dUHI4AZ3
         EWmg==
X-Forwarded-Encrypted: i=1; AJvYcCVnx9yvn6FCWd+H/8uf0jqSaB8zG5K4Iti/9iWZ25RhojGjIocdDjl3xQ0R4QVx13efK1GyAg98JH9GuhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbxhgJ5cOoyC7v1fCDkPWc/IYVTlJoViXYkhm1A6z8dcF+yTns
	+cPWB73ksPCR8BKjuTsjqvE59eOfebEeLLz2RzR4YNfwY0DELmg0XX019kn98H9OSqNGLOi8Zdj
	BfCt4LOUpKAwzEquRTOEJX9Q55tPuv/JVLus=
X-Google-Smtp-Source: AGHT+IF36IipaF0Apyziua1nDu2qSOpHLIz9jwkRDHpQ2hX3c3T/iEQCcyCPryciyreYm9HN3Sj5EFy2jfOVqmuqi+8=
X-Received: by 2002:a17:907:9805:b0:a9a:673f:4dcc with SMTP id
 a640c23a62f3a-a9abf889e9cmr717378666b.22.1729804282544; Thu, 24 Oct 2024
 14:11:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-7-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-7-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 24 Oct 2024 14:11:11 -0700
Message-ID: <CANDhNCrpOGnNXg0Q5QtWi3EzoyB=nO4BNqSk=oL5P-Qqy+301w@mail.gmail.com>
Subject: Re: [PATCH v2 07/25] timekeeping: Move shadow_timekeeper into tk_core
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
> tk_core requires shadow_timekeeper to allow timekeeping_advance() updatin=
g
> without holding the timekeeper sequence count write locked. This allows t=
he
> readers to make progress up to the actual update where the shadow
> timekeeper is copied over to the real timekeeper.
>
> As long as there is only a single timekeeper, having them separate is
> fine. But when the timekeeper infrastructure will be reused for per ptp
> clock timekeepers, shadow_timekeeper needs to be part of tk_core.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

