Return-Path: <linux-kernel+bounces-282754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B855194E82E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D441C2160C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC3315FD08;
	Mon, 12 Aug 2024 08:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eChMw+ey";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZpGdok8L"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDEC1581FB
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723449856; cv=none; b=oXW6KwhiCKIeUN48QehmIjdQZk2quiRguZ7ASNZoecfNIO0LAAiYLB7ga53KVtQCywRapCcRVqBCpp39ml0shokyzhg2K49nJ0/H9bc/gKfP5l59tJZfHaDtogvPbGtItv3nDlVliT6qmia0kdBEGBh9IvI24snVeToBlYpEtuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723449856; c=relaxed/simple;
	bh=MzklR/tgxpG7g26KcREA5Fo12P2CCI9JEfth2PGKC08=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ue+1ciRbW9e8ODgdl0iySbfs9hEFlJR+imjLBRNf55twYMNVnOqvUZUJOvkCPtxnHWPdL/NzLLzJbuQQzL3QRLetPJlAau0Zae/562yJjWIhjm2Qb3l6X4Y+gRLOSvBqj6OvJM3ECsM02Shbx97peizNp/rOOyTWER+vcMsfuGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eChMw+ey; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZpGdok8L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723449852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N5oZjdtkNGfgNPDamv7nu0dx0DvtzIkRIyeIzmYNf88=;
	b=eChMw+ey0F6KRGYmUs7qjuO7Vtxo8eJqjowZKjHRhfAuI6jeRH0IJbaaVKRgoPhWZic3Ns
	q53fkSHincI9BNaOTe/JKCYfTvFxKqgBCPEWpSujwZjBeRYAi8J6xO4+Jn1oG3mzYklNdB
	8W54EhTog8qOFIt62835lgTXy3n0Kxx2ox9vMZGYfFo5hl4EfWdIwM1Vm9RSCfzWvJttDa
	k3xP4tJQyN1a9QfiZYhYz0ypTVX9+fTuxpWDWM3BTNknA8Uh7vjgaBk4CrthiB+pTq+y1B
	u4XCmVnxhMwqLRjWa12r5d9bb0xFpLTPXUQ++8FPLFbImeT/gcB4vZIBXgG3Hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723449852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N5oZjdtkNGfgNPDamv7nu0dx0DvtzIkRIyeIzmYNf88=;
	b=ZpGdok8LygM2AqAZ7WXtdRj7VZO5fgvvkDrFYqTTEx1ekeuIvO03r1URorOhwgWYovorhI
	00P86OyWx+Kzu3Bw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [GIT pull] x86/urgent for v6.11-rc3
In-Reply-To: <CAHk-=wjw=FsFkF9EhF1ZzM9QUG0Az1_hk++9GU3ZffwafDLNgg@mail.gmail.com>
References: <172338466501.1168419.15927287413698158262.tglx@xen13.tec.linutronix.de>
 <172338466744.1168419.7654203284534630611.tglx@xen13.tec.linutronix.de>
 <CAHk-=wjw=FsFkF9EhF1ZzM9QUG0Az1_hk++9GU3ZffwafDLNgg@mail.gmail.com>
Date: Mon, 12 Aug 2024 10:04:11 +0200
Message-ID: <87o75yrwuc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Aug 11 2024 at 10:30, Linus Torvalds wrote:

> On Sun, 11 Aug 2024 at 06:58, Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>>   - Don't make acpi_mp_wake_mailbox not read only after init [..]
>
> I assume there's one negation too many there, and it should just be
> "Don't make acpi_mp_wake_mailbox read-only".

Right. It's way too hot here to think straight...

