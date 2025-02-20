Return-Path: <linux-kernel+bounces-523923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0CFA3DCE5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63DA16C765
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8401F1531;
	Thu, 20 Feb 2025 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YmJ1XQLT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0/1TACzH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE32028EA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740061929; cv=none; b=Tb6tXNIs/1x/Ey1tPTLeDpZHXOf8pqfa0IG7okvl/gTlD4G1Cg2xhuwmtYRQotxIhMWRJ3UvqkoZPW3ySZSrLDtScopdrsj3bavX5yu85qkh45eZ8JkK3Cikod7t5O0ANpxisyX0kNnqEZz0UH85FaWml1ijkYjyNHXCDtZftIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740061929; c=relaxed/simple;
	bh=CzV9bxd149p9CWYR37KvE/72WikwSMD+HRF/P+rIC1g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tfa93B74z5rtbDFFJCosCYwBGNCbrpJquEQkNyev+T/GroizzL6IjVf/qA5s6Wi89KEH4mbVgGNV0CQEEqAV+AAeoyJrH35528O2O2Nx1W4Ci3wlCCEoEx9W18oThuj3s0EPd6yagW/744rP08+h7Q3UU2g2HR0ePrV4Pw1B+9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YmJ1XQLT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0/1TACzH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740061926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Egw6G4ZiL9DKYfKWl69qMwUYm0iJLmehOs6BqDDJDU=;
	b=YmJ1XQLTsqaym8YoHOcJpFK11R7Z5IKFYJHB8wl4I+VwIoQkavmxAO6IZlYKZ0IPY6sJHe
	Qm034pTEawWB2Ua/u22sF0kxQX7KrokFxjT2+np/SBUqw46P+HuwszktbPNaaAhAeEcvQQ
	PmxqqVwM2CzBhzDKik9zq/hc5qtunR4FuoiYL5yOkeXTi1wY/Qz5pvg+sWg8qTppoEZRpr
	MncL4jym29W24mHlmBYbsFVK7gwn5TPO+PgwhGRLWgA0L1ip2+tNJPg3DgysSIRMZwAlsU
	MnDZMap5XXsa3Wn3Id4sQU+bHqIkKWWD+ohNp2hx+wMziunXudKfbOITR26HWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740061926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Egw6G4ZiL9DKYfKWl69qMwUYm0iJLmehOs6BqDDJDU=;
	b=0/1TACzHVdWsCK/pbUNKLkLkppM0yhrm8leecBpvcyK4jKkj88p1OQiMVLBRhA0Ir3PLd4
	fqlEXVM8aFAaltAA==
To: Eric Dumazet <edumazet@google.com>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 Benjamin Segall <bsegall@google.com>, Eric Dumazet
 <eric.dumazet@gmail.com>
Subject: Re: [PATCH V2 1/4] posix-timers: Make next_posix_timer_id an atomic_t
In-Reply-To: <87h64oiuey.ffs@tglx>
References: <20250219125522.2535263-1-edumazet@google.com>
 <20250219125522.2535263-2-edumazet@google.com> <87wmdlhwa8.ffs@tglx>
 <CANn89i+LJFHhA=VF2T5v_kN0=sFLeropuRERnhWdadj5w6kiyw@mail.gmail.com>
 <87h64oiuey.ffs@tglx>
Date: Thu, 20 Feb 2025 15:32:05 +0100
Message-ID: <8734g8it5m.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20 2025 at 15:04, Thomas Gleixner wrote:
> On Thu, Feb 20 2025 at 09:49, Eric Dumazet wrote:
>> On Thu, Feb 20, 2025 at 9:09=E2=80=AFAM Thomas Gleixner <tglx@linutronix=
.de> wrote:
>>> > This allows the following patch to use RCU.
>>>
>>> Your patch ordering is slightly off by two :)
>>>
>>> And it fails to explain for what RCU can be used....
>>
>> This is explained in the following patches.
>
> The changelog of a patch has to be self contained. The 'following patch'
> has no meaning when the patch is merged.

That said, please just fold this into the patch which actually does this RCU
lookup upfront. The change is trivial enough that it does not really
require to be seperate. If the lockless increment would cause issues,
then the subsequent RCU lookup is the least of the worries :)

Thanks,

	tglx

