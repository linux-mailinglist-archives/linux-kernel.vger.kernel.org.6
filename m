Return-Path: <linux-kernel+bounces-325552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4337975B3A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86827283CA3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E37B1BAEF6;
	Wed, 11 Sep 2024 20:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ufwNgHM9"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FD01BA874
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726084864; cv=none; b=smlYcVIQliI69Ab3dWAh/MIvXhTcpOi+j7yteYZz1Ii+/f2fzbH0kVunvGSkLiohbb8XHTqi86A+RUNYJWBFFu3L2V7LtKgHXy9erHm5yMa6JdBKeqcElYmerjTO5i737Ft3sizGQGYwtAlaN2usHwdoewGv0iMVwdq3ZnI1m/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726084864; c=relaxed/simple;
	bh=k7YGE/HAplf0XjvHfK2+m8qOpcTrVatN5s0xk5zu56w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ROzIpUwyWiFryFIXOaGCHnMog5qUVQl5DwaY7Ai0u8Y/IX3d8Bb2Y1FPxIK9+5Xru3vJLCMLErumJqAWSx7CGcq+gnrxL+04UFZowFHZR7a4twIXkM5OOiPMVIgNYzJKcQfJCz4G/CHcViYzNxD1Lj6fSz7ap+yg4u2NHa46dOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ufwNgHM9; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so38743066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726084862; x=1726689662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7YGE/HAplf0XjvHfK2+m8qOpcTrVatN5s0xk5zu56w=;
        b=ufwNgHM9a67+FTxq3UR8QLaUak1ZKhWQ9NRq5lvWnlLY4p2ltCiS7QZquO/S3UK9F+
         oTQshTCFhpurcX0wMPcaJnkiPESLkh0DEyjyChNSn7DsCC9lWqiPj/ugLsJcocT+3C2P
         ej2SW4ClYCliYPwVQRpcrGgjJMG6vf0pZKpn5XE4xsJTiCROuIqoeBrPPXBsQsDSOb2H
         WFJDjbfiT9zJEFGrTq3ljzqcWcwkUO3m0zlhX43p+N2P5YEI/o7cBjYxE0EJZ9uZdiuK
         3LzlgXWlyUGiBZIGELeyHsho5VxvRi3uu/gIiObJNOROBK9Vj4sMZX4KQshtMEae+lWF
         opSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726084862; x=1726689662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7YGE/HAplf0XjvHfK2+m8qOpcTrVatN5s0xk5zu56w=;
        b=Y68CFjJyvQ7WtcqInPC9m8SaqeBBHptyFmxhHjK9o8Ep+iX3NWjdgHflMuwTELgOSk
         8ETLAkJi9B5YI1ufCQje174SG82Vmx80PB1CoOv6GZBwctZQQJtxnYworhaDq48jbdQF
         uOrBNCS3/Zyq7lALD+qvZECsANHW+7kMmiIwQBZ1+E5EmOx0/OS6T9gkiLVwY46JTY+5
         9cYwetXNG376aCPLoSKY4y/s8L8v5UlLeIWOcao2DLiteVbI3UjwbSDxWIp+iYHjxKHR
         jk+Dh4xT1xFo7pVC4XHXN5rlLBy7IpUUlkX7YwToYmyW/OA+mFJkbtllJwQLr6nkVV4Q
         5uJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUizX8Bd60ksH2MHRDb2lmEVgVD3jZtRLIad/RumO+G28mvnaVnAYrbtEhzy4+yUQ25Z9BXty38ULT1M44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2nVNfM23kL9KGcaQvQR4FpDR07tZP0h84SDUBVqktRQJSXSyp
	e2wSjkwfyhVcK/PunZ8mKB5Vga+NxGosqb/hQcRAX2zYL7ppvI734LRyr1BvfJgfgtl1xbLxZBa
	fmtanMJuxRxkRI2vkMYs7GCAFthzdBHFFOac=
X-Google-Smtp-Source: AGHT+IHdnj3Vd2kpmZXK/IoEHXyuSQsbsfirlzCGNIRsUhRhpvqYGr4h4+fdQxF4LXx9mZr5/7PBgtujMvbJoYbmWlE=
X-Received: by 2002:a17:907:f783:b0:a77:e48d:bae with SMTP id
 a640c23a62f3a-a902949aec3mr59308866b.28.1726084860628; Wed, 11 Sep 2024
 13:01:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-6-2d52f4e13476@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-6-2d52f4e13476@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 11 Sep 2024 13:00:48 -0700
Message-ID: <CANDhNCq3MU=hGyWZWcVvRkAubEq6jYO5a61VwQi_e+ZtvK5uxw@mail.gmail.com>
Subject: Re: [PATCH 06/21] ntp: Read reference time only once
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
> The reference time is required twice in ntp_update_offset(). It will not
> change in the meantime as the calling code holds the timekeeper lock. Rea=
d
> it only once and store it into a local variable.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---

Nice!
Acked-by: John Stultz <jstultz@google.com>

thanks
-john

