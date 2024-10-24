Return-Path: <linux-kernel+bounces-380691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 805649AF49A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 23:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2AB41C21E29
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916B41C4A11;
	Thu, 24 Oct 2024 21:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bJR3ffAb"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A03189B84
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 21:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804773; cv=none; b=ivsoJPnou4ahlBMjY8IQtB1MfXL9xjlhg4U8g7vELeT94P8fQZxR0aJktM9MhmEdIDiLskjBoDrsKBCnlWMTfkYZik6t50T/5AlvMhUUG1FBcnL+/uIryYsG/MBD8LSJj2HiuWGqbfy8v+jMyiqhZqVz9mS7AM3kfVXH/a8FIfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804773; c=relaxed/simple;
	bh=CjllKaQMNRi5QRmw0m0AUimxSvg5wkpIl8wzT3v+Weg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxCaUezJALdFV++T0zHUSQkI4P2QrXt0TF5u+VNz6XgK4etpUNSbLakQcyeMAdPI4/xRX6Yi32DDo9pOxtQKv8AZbP43L7Qm+38YA36YWV7XBVe1kVZSEAxPQAA97/QGR6g28CSsa6SelqTN+Ag+JQMskfp7KrALEdUX4ezLakE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bJR3ffAb; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so21549871fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729804769; x=1730409569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcctwDFY4vX2U6NHXOTm25XQBD22CesfqwSVX75dhZw=;
        b=bJR3ffAbUcSkEdGdK9EQJFGcxxbRSnzE6e2AOIlSP+xr3BKYCvA5ZabS1ga8HYhmuc
         /8Z3l4n/ebw7gQGPT/rsfUM0wBY4jG9VcpD4gq+FKgJIRVM7ZZrGo01Bpge8P9XXlJt8
         ZlxLWZzH1AesHBuhoqVGcabIi6wY7/2lugA2RXzj0c+Xr5z2bvtSOcnQs9ebbL8AdyOG
         kIfFiyxaCYKn+Glbdf9k5FpynXMfoFlUNj+F91a0bLB72Te/GxxCuuunNz6/HQ/iHYUD
         uwBE9I8W+c2BKdxNcapKHqf1k+9MsmI09CBsc+sBZN9S9KYAA/1QQmB5ZWj9tEuSiLhN
         +GAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729804769; x=1730409569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcctwDFY4vX2U6NHXOTm25XQBD22CesfqwSVX75dhZw=;
        b=Kh7RmZjXNCsbbg+eUEOorNudmugVZMyvtpCZ7oK+aEwJJuPv1u7qmS0bFH7eEMrGZG
         +BKkDZSUrebeO/YrFpqETnk8GD5t2k9x/g8+zX5XZCJsHwLFuDDg+h9OVuOJY2rZ4V9n
         o3EvoQfMt2XjNfjRc15MyBTIBlnxz5Qiderr4YUhyZ9CzTUcdiLyTwWjHjvDHVHtiSdJ
         mnLUYdZ6CfZY+3siMImygqp1IRHe4oEoRHQfoSEwi26THItooirR6AR1anaHnMenMbTL
         5cjn3bYWh0imxa03k8xpw7EjmjDIulLxhU6cN950HLaLmQg+133u1sPMLrOaIuMC0IY3
         +NHA==
X-Forwarded-Encrypted: i=1; AJvYcCUVI1TTHl5zOvF7/lLWS5MuTNZ+jDOHoKuMHfv/P0Ki463xkTKRDuLahMCc2kH+sZl2S+ipuiHw0cK8GB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUPJliPXH2HCk5H+kt+sLgciVw/IcB4r8fqwuX7o3Q8jvBWmXV
	PR0aOVxmnfKZj/VidoRbnKuBXwX567HzasX6Ec5BOrjl0bqgXSDjq7DZIYV801Ci35YHhkZPjFf
	AYuqF0NXjWmeWFeU0JNhIUKHtOzsJ+mojdR0=
X-Google-Smtp-Source: AGHT+IFq3aZ3+eZVePX4hpWlTPzqI4kBipts++dHji4FFgk/U4psBOyg8eSfChqEk0gsmuD/UY/FzUR+svu8SJZT0a8=
X-Received: by 2002:a2e:4619:0:b0:2fc:9869:2e0b with SMTP id
 38308e7fff4ca-2fc9d33a195mr51481041fa.20.1729804768890; Thu, 24 Oct 2024
 14:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-8-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-8-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 24 Oct 2024 14:19:17 -0700
Message-ID: <CANDhNCrU+WufRrOreDNG4jAJMhxXphqyWLm_hGr_ihN2TDKdRQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/25] timekeeping: Encapsulate locking/unlocking of timekeeper_lock
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
> timekeeper_lock protects updates of timekeeper (tk_core). It is also used
> by vdso_update_begin/end() and not only internally by the timekeeper code=
.
>
> As long as there is only a single timekeeper, this works fine.  But when
> the timekeeper infrastructure will be reused for per ptp clock timekeeper=
s,
> timekeeper_lock needs to be part of tk_core..
>
> Therefore encapuslate locking/unlocking of timekeeper_lock and make the
> lock static.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

