Return-Path: <linux-kernel+bounces-380734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F459AF54F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 00:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13F0F281C80
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655AC218327;
	Thu, 24 Oct 2024 22:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uUsP3yc8"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72E32170C5
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729808499; cv=none; b=pIK7WwQH6t8kQXLHDXL4cZVEc2DkZdt1Nx2TkEyAb911EhaBgrgwlamVRCtTaWC+pZiyOEl4Zw5GTGWbdCzTBMkYhqFpsS18z/LT7nhytfMiwjsfJeKMWohtu0SNMEyHTxwtXdqwNv3X5Am0h2zGWxhlIHuD5G5uUSsGCkpOMrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729808499; c=relaxed/simple;
	bh=dnO0TIIcH5GDew8qakzI1PNVFmS71onJm0GFkc+cdyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7PVnFJTEtrwKHRR3auZjr6qwqYy/wueUwvVc17Iz8gjChLf74R5nsWzzGUqnwRVxWkYOogW7rwINoz6w2PYmP005yoANc6qPavPTZ8Ci5HG5ujKp7GWaKCTtGg+ASpn7dX/+IIjybJkj3GHRR4uiAep5qiUVbgRwhzHeyVEq2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uUsP3yc8; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a2cdc6f0cso187840866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 15:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729808496; x=1730413296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnO0TIIcH5GDew8qakzI1PNVFmS71onJm0GFkc+cdyg=;
        b=uUsP3yc8pC/hIoJKDQtyWrxJyvUq/M7BWrG29EQrJ/d9Y+kNo2V42lhMLkQWnF6Hy5
         A9cAqPVXUpb4SqB7WOczRiRUhmFqd5WgcBXfcv4piEdfVf/FCyY2epYYS6w8fBxB6duL
         M9a93UKq4rCyLuIXuDMiFIjUZ46MAOyS41QPZjzfIxDwI6pcq+nYsVTI77PyU3CB10G6
         6K3eLKpd8BLHG8zl7gplX6xdjhURMEPVPnEVPWwRA5e9sBDsYf/0e6lOFcEVErg2BmgO
         TCxzG7ywVNWh6OgL0RiHAp1u4b3bZvTlG9Scy2EqO6ptrcRmy6u5IdtivXRwdKl2U2d+
         3dIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729808496; x=1730413296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnO0TIIcH5GDew8qakzI1PNVFmS71onJm0GFkc+cdyg=;
        b=bvHfUj7Kw/NXNOJMPd35WqDisXhCKSj60K6SiVoNpscuk8kovgG56eAs4h+bhIhpPU
         sI7HwYPvKIU7H+RlyvUKIdJhVfOV7c8vZnO+EXGsGQ1oPPpWjzwlKbY3lRUX7eerQIRz
         qY7Q3QS3Hdsf6RbpuF5GWojNb7zFz90DVtHnAuCmfNpNANU8j3VDIBRhI0HoXHZ0LDaW
         FKOsrVgr+nYpqK90uVC1b8uEviw9KEZ2zGqvLlh1seqO9eFxWKAzjAneWXmqp/rBSNUB
         p7v4KjbpQgd0QH4i+eXSH1JibSvoHJ72OdtK60Lyh8ZB4rmaXds0fWlwh4ZhyZEL+vny
         P6dA==
X-Forwarded-Encrypted: i=1; AJvYcCUrRHveEXkozPiN2/0oJocDP+YLkT14XdKILgwaszT4hM3OEv1r48sZmAi4emMSNe2XKf3tt7S8QYz88gI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4YFDzUkdUOeCyAxVZ/PaFFFLqulmAeAVNoOsfooliqQs+N6od
	Ru+h+dMXWksc1u1vRtUGFWwPnxteru6o8GDH9mozVYBAuNeZLQtmA48xo08cwD7ozZipPcDlreT
	IB7ovsXTyhVREpnS/iIOMw9QEX3QyTQ6U3bo=
X-Google-Smtp-Source: AGHT+IEVx1SCnQwRam99zjMuEWq5hoSmUfvm+tas+sXitO3DUfGuDaHvw+Q4wp1XzJF5NesDmT4mqROsaB15jwvX3Mk=
X-Received: by 2002:a17:907:961c:b0:a99:6036:90a with SMTP id
 a640c23a62f3a-a9abf8675bdmr739302266b.14.1729808495819; Thu, 24 Oct 2024
 15:21:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-22-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-22-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 24 Oct 2024 15:21:24 -0700
Message-ID: <CANDhNCrniG3ehXxzFn4ULOdr6=tmzhR9Ti=gSdf5mQpftcG_tQ@mail.gmail.com>
Subject: Re: [PATCH v2 22/25] timekeeping: Rework timekeeping_suspend() to use shadow_timekeeper
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
> Updates of the timekeeper can be done by operating on the shadow timekeep=
er
> and afterwards copying the result into the real timekeeper. This has the
> advantage, that the sequence count write protected region is kept as smal=
l
> as possible.
>
> While the sequence count held time is not relevant for the resume path as
> there is no concurrency, there is no reason to have this function
> different than all the other update sites.
>
> Convert timekeeping_inject_offset() to use this scheme and cleanup the
> variable declarations while at it.
>
> As halt_fast_timekeeper() does not need protection sequence counter, it i=
s
> no problem to move it with this change outside of the sequence counter
> protected area. But it still needs to be executed while holding the lock.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

tk_shadow naming nit, but otherwise:
Acked-by: John Stultz <jstultz@google.com>

