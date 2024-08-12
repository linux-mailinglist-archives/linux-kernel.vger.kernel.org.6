Return-Path: <linux-kernel+bounces-282772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC52694E865
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 091C61C20EF4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174331509BF;
	Mon, 12 Aug 2024 08:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uYJD66Vz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c6pa7Qrr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A15165F03
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723450869; cv=none; b=VUsn4ZwSeQDQPiAYmgl0CzfzYP6sDlVBOJLtzL2VybmT5P4EFRCvEKnUUX5huyL8yAU/YZ8cUOcXynS7nq/3YDvuu+SVPiMXQbE9dh41OiV1zHoS3Dp5Xh5syJAFANkBhb7zQvlOuuULxyc6UcIbPZ2+ml+pwnf2822GzW3SE8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723450869; c=relaxed/simple;
	bh=IWi+CtSeAB1ftIfiVd0CXGNXXJVcEbqpijhTlUmaPVY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wpa6AOeNT1zzUCo5pSpxbT5aNdZRaQ3gmCqSRiRHQZjI30TeGNjRcX8ICq2rodfiXW0IL+M4XNi0y3/GuCMQAesuK4txN2K2f3Y1NjKzVh3QBz0QOVzKyJl0CqEoLr+cMfOQa+SNfgRh9Oexg5MXndKPEnBspIPjHSruDcqTh4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uYJD66Vz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c6pa7Qrr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723450865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m1az0Qs37KyNJKwUUdOphesR2jg4RCCjN31rdplVVHo=;
	b=uYJD66Vz9xfSIaZMUyK6HnlJ7tqa/kFuTmOOimhXTAz715sBwOOvE05YzY1Y5sIwquqS/7
	LUrcu63NKfVR57LOikw5iMIdvgFicaeb3xzGUJ3oCzUqt3WKj1eNEj8hW8p/KtnJaROMYZ
	/FNxOy+0o14j4YdZetFCoKsYsJKdaEs0LeojuiPiBgGEmJpjoHgZEmyrw5+rouhGRB1eGw
	hVUCixCzXt6arEzYoq89mrJikhiu+Q8IZhZP5kFl9NjI8UQNklbNmgGvMVwsJ0v0lfW6Rw
	w+53Ww+p8WEC3gQMmhPTPr1KFQQkg+Nh/2njv/KN/fQqj5AIpgjvQh8F6EnIAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723450865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m1az0Qs37KyNJKwUUdOphesR2jg4RCCjN31rdplVVHo=;
	b=c6pa7QrrWElEK0LRjNQ+y9p5e8twXS92Q202tyaSeDWdBBLrX4COf69kmu0wCRX+D+rUFt
	x68cnlpB/nHRYWDQ==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [GIT pull] x86/urgent for v6.11-rc3
In-Reply-To: <CAHk-=wjasZbABR14SFRgkL8MZxP+X4qBUOUM3c97cL5gXuwrUQ@mail.gmail.com>
References: <172338466501.1168419.15927287413698158262.tglx@xen13.tec.linutronix.de>
 <172338466744.1168419.7654203284534630611.tglx@xen13.tec.linutronix.de>
 <CAHk-=wjasZbABR14SFRgkL8MZxP+X4qBUOUM3c97cL5gXuwrUQ@mail.gmail.com>
Date: Mon, 12 Aug 2024 10:21:05 +0200
Message-ID: <87le12rw26.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Aug 11 2024 at 11:07, Linus Torvalds wrote:
> On Sun, 11 Aug 2024 at 06:58, Thomas Gleixner <tglx@linutronix.de> wrote:
> Our static key code is pretty confusing, but we basically have
>
>  - virt_spin_lock_key is now a "struct static_key_false", which means
> that we consider the virt case the unlikely case.
>
>    I agree whole-heartedly, because it's going to be the slow case
> anyway, so this is good.
>
>  - that means that 'static_branch_likely()' will generate a branch
> (because the key is marked unlikely0
>
> Isn't this wrong? So instead of falling through to the native
> qspinlock case, we will branch to it, and we fall through to the
> virt-spinlock case?
>
> So i think that static_branch_likely() should have been changed to a
> static_branch_unlikely() too, but it's possible that I've just
> confused myself.

You are right. It creates a branch for the !virt_lock case.

> Anyway, somebody should double-check me.
>
> I doubt it actually matters, since I think this all is fundamentally
> just in the slow-path, so the "do a branch or a no-op" is likely
> entirely in the noise even if I followed the code right. But it looked
> off to me.

It is off and yes it won't matter much in the slowpath maze.

Thanks

        tglx

