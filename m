Return-Path: <linux-kernel+bounces-341793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEF2988651
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 15:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC9471C21BD3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 13:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D111518CC05;
	Fri, 27 Sep 2024 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIXZmY+L"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C5B282FA;
	Fri, 27 Sep 2024 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727444022; cv=none; b=CBqMHarfEHJ2eIrv2Lk6GlCStCErQQNwE1700Ca7ydeqhK16cLCF/HGnOXNVsVU188CoFSBw5jRRodRo8v/xfh4ubWnOnzGfhuz8pGHXzoWx7CKTeFVB4r46qyB2dvyLiw+puIB/trIMpUJY7Mhq4YfwEyLGpMEpxl8XVW/SjD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727444022; c=relaxed/simple;
	bh=58dVGBDkYc1bQrbFn0evrCXV59qaZdxh8FX3yDtbClk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FL6V/DlPiv+/F3kU11bns8nklBTN5sHmMBvNJ6dQ9CqybWNfnZH+O1mzMJJ/aC57Ef0DMPUvTIw80aUAmCiK4t8Cpaex3PffZgfuu7LEegmaNso4w7aAGe1yF3eZkoNKs1B4DtvCN2coA/im2dXzL0RMxHxrIilYcSJKpcee05o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIXZmY+L; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso393886366b.1;
        Fri, 27 Sep 2024 06:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727444019; x=1728048819; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=58dVGBDkYc1bQrbFn0evrCXV59qaZdxh8FX3yDtbClk=;
        b=CIXZmY+Lg5f6q92y7Ndc4CGJQJcZDi+8HpjTrLgqlticw+NVDVZfJQko1mijhYXEla
         CwBb7Cbf8AiV2jjWjrHUzFzTJYXLvid8Nq681y3Nq2Ixk7ATV3kxfxJUs8itfj6UwicJ
         YmLB4IK525+zg4aOtcaT646dF+PVF4H4Zjo4e2tVDdogh94YbHiIAAseECfzWpCdl+GH
         2dY0ktM8AjA321g9OMvd56Ve+3PGwyXd2lpcTsKIbbJp3QpuGIxN/RtkGJfM39xiKNbq
         Wd07P0yDgx1xgO8ky73T/b9i9WWPpeGfFikPfgGn2kFqvygEd+U7GMfCjMjZTLma/JfJ
         emNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727444019; x=1728048819;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=58dVGBDkYc1bQrbFn0evrCXV59qaZdxh8FX3yDtbClk=;
        b=jup0E/guL3aZQgEvX9SIdICYbIRKjVUajg4Ni8j0ofJEJ2stOUKcSPVr61sIvgvATy
         fcXdBL8YxHQrjQXeevhn19hQmQCLIx57HpfhKRTt23FXdF5dDKR/jDpdhK6kR0mKE4Rj
         3D9u4ssFQMtHxPAx97oh2ipvI5A8ECV4Fp9t50Hdz7rQcRdl+BVzNy2LmvGJj0BbwRhJ
         oOL/UgL71U5JU/hwWQid+Fy1JlnAhl6JtIlvZ00gCe96M7I6i+3oOJW+H7GRNxE7CoI7
         lRczGA1pRTiQSfC2kZItOihwUmIYKY+coJqtN59nzOUq8pIUq61CaT1qcxHhufypEv46
         Z3+w==
X-Forwarded-Encrypted: i=1; AJvYcCVuRxsV7KAs4WPVMwQ4TIoJdZkzbtcz0ocz1A+MeQF9XXb4jQLWCCZN2PMXUoJWhXrKKwqWda+l1IF7@vger.kernel.org, AJvYcCX4kRlEzEkBqP1FHh2q/zl+a/1rQMy7Y2qR42mKRfDOMZUUCokhyiTdcqCD8UJrWEhMVzklra1ji5iL0tE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSVZFnfWYh1ZpRNBLA6bxUcPou0U2/EGhdPlVIUiHP2VJCV4vS
	UNNXsHoC1pj/77IGFdouAxWiK1dXaHU6EcMwsOXCOkAv21TL00Gz
X-Google-Smtp-Source: AGHT+IHEu9DsqK5Yj66Nid9o12FSNP//HJoLGp5cWV5+adVs65AqKnY9y+QC4K3s5b9z7+Kfst+aRA==
X-Received: by 2002:a17:907:6095:b0:a8d:65f4:c7c6 with SMTP id a640c23a62f3a-a93b165dabdmr734891566b.24.1727444018678;
        Fri, 27 Sep 2024 06:33:38 -0700 (PDT)
Received: from [192.168.216.101] (public-gprs35668.centertel.pl. [91.94.11.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2947a86sm135051866b.124.2024.09.27.06.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 06:33:38 -0700 (PDT)
Message-ID: <a7a132ff61a4533ce463ec088e15e3156c3ce39b.camel@gmail.com>
Subject: Re: [PATCH v3] usb: gadget: u_ether: Use __netif_rx() in
 rx_callback()
From: Hubert =?UTF-8?Q?Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ferry Toth
 <ftoth@exalondelft.nl>, Hardik Gajjar <hgajjar@de.adit-jv.com>, Kees Cook
 <kees@kernel.org>, Justin Stitt <justinstitt@google.com>, Richard Acayan
 <mailingradian@gmail.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Toke
 =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 27 Sep 2024 15:33:35 +0200
In-Reply-To: <1be4dce841c6e5de076864102aca2e131d1aafe1.camel@gmail.com>
References: <155be9e56e650dd7f7baf1c7e193e1a3d85e7141.camel@gmail.com>
	 <20240917143618.jPgAwF3M@linutronix.de>
	 <1be4dce841c6e5de076864102aca2e131d1aafe1.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-26 at 21:39 +0200, Hubert Wi=C5=9Bniewski wrote:
> I'm a bit at loss here. The deadlock seems to be unrelated to netif_rx()
> (which is not being called in the interrupt context after all), yet
> replacing it with __netif_rx() fixes the lockup (though a warning is stil=
l
> generated, which suggests that the patch does not completely fix the
> issue).

Well, never mind. After some investigation, I think the problem is as
follows:

1. musb_g_giveback() releases the musb lock using spin_unlock(). The lock
is now released, but hardirqs are still disabled.

2. Then, usb_gadget_giveback_request() is called, which in turn calls
rx_complete(). This does not happen in the interrupt context, so netif_rx()
disables bottom havles, then enables them using local_bh_enable().

3. This leads to calling __local_bh_enable_ip(), which gives off a warning
(the first backtrace) that hardirqs are disabled. Then, hardirqs are
disabled (again?), and then enabled (as they should have been in the first
place).

4. After usb_gadget_giveback_request() returns, musb_g_giveback() acquires
the musb lock using spin_lock(). This does not disable hardirqs, so they
are still enabled.

5. While the musb lock is acquired, an interrupt occurs. It is handled by
dsps_interrupt(), which acquires the musb lock. A deadlock occurs.

Replacing netif_rx() with __netif_rx() apparently fixes this part, as it
does not lead to any change of hardirq state. There is still one problem
though: rx_complete() is usually called from the interrupt context, except
when the network interface is brought up.

I think one solution would be to make musb_g_giveback() use
spin_unlock_irqrestore() and spin_lock_irqsave(), but I would need to pass
the flags to it somehow. Also, I am not sure how that would influence other
drivers using musb.

--=20
Hubert Wi=C5=9Bniewski <hubert.wisniewski.25632@gmail.com>

