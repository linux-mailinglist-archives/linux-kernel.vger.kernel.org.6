Return-Path: <linux-kernel+bounces-358109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E51F997A46
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2066B1F23C03
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 01:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AF727446;
	Thu, 10 Oct 2024 01:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O/Y4wf49";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dxmCeAQ3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31897B66C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 01:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728524857; cv=none; b=W4fCvn81QFkwLBIth7v4vojmeCoRTJDXQd8Lu7P7RD5aehzR37U5edRwZ6nsQCakbuya3vkTaoGj2stG/FRclxUlRO3W6n4FKzX1mg1j98oJCc1JSoj793MirN7e3FduVtgtluA+GltlzpMfDTmXczhIc7Etefq1Ib66W32sByA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728524857; c=relaxed/simple;
	bh=9QDtjOrmA9fDTZn34s8gbDFLlQaVmBqBEhgMAYPX37Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vCX8ZI6f7GidS3EmEb9LfSj/UEtluO250BU8EFmyMey3S4Yedo4gMRBXGRrLUcjssurElt0ue515KHlgcqDgJ1wZqz+ltyzne5vCF0JmqwTeQ0bxyn7Ddomqya6I0JzBXixx9Zou9WuPUgvYIIr7HKyARt56FZO3qg/zhmO0k+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O/Y4wf49; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dxmCeAQ3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728524854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cUzukGKckgTGNflWemKkp+i85aK4/v4n9mZwmQh09+g=;
	b=O/Y4wf49fN/4PL9/0eGDBKSrnbNmJBKXUZm5aqq61thYhHRtmDcjjQHjUUK7liyYRiAEFL
	uei3kOlyZ3/2P1ZueqpWYlODMa3C/mdWR86ae+mYJZC058JrupKnD9wr+0Ak4KJcF1/4FL
	9DOajjXl2xzeEyBg8GjP+XINBTCJuqFyLT+bdyVNHXUi0HHyyeHo8YFu8F6NPYhPNIslMb
	6qDxZ88SvWwrL87p9IL7/EDJcYKKWoDumT8jLAfduGMJa/NrI148HsxwhVC0IY9/LfBf0d
	KkbxExCJa2fVv/btgjvlCVGTRJSvpAijgIDQzN10UDOSVOmbj9Z/qHkOYnlNDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728524854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cUzukGKckgTGNflWemKkp+i85aK4/v4n9mZwmQh09+g=;
	b=dxmCeAQ3VmjphIyzggVa7jSwM+Ts4Ynwadb6hLc4JYaPqfZuCOZMDFsZkjB5wJ7fRrGzxe
	4k4cM8WMKQJRveDw==
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Uros Bizjak
 <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v2] futex: Rewrite get_inode_sequence_number() to make
 code simpler
In-Reply-To: <bb91d63d-c61a-4063-bf14-4cbbb62bec12@igalia.com>
References: <20241004085257.10908-1-ubizjak@gmail.com>
 <bb91d63d-c61a-4063-bf14-4cbbb62bec12@igalia.com>
Date: Thu, 10 Oct 2024 03:47:33 +0200
Message-ID: <87ed4oiv9m.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09 2024 at 16:43, Andr=C3=A9 Almeida wrote:
> Em 04/10/2024 05:52, Uros Bizjak escreveu:
>> Rewrite get_inode_sequence_number() to make code simpler:
>>=20
>> a) Rewrite FOR loop to a DO-WHILE loop with returns moved
>> out of the loop.
>>=20
>> b) Use atomic64_inc_return() instead of atomic64_add_return().
>>=20
>> c) Use !atomic64_try_cmpxchg_relaxed(*ptr, &old, new) instead of
>> atomic64_cmpxchg_relaxed (*ptr, old, new) !=3D old.  x86 CMPXCHG
>> instruction returns success in ZF flag, so this change also saves
>> a compare instruction after CMPXCHG.
>
> Remember, it's easy to see in the diff that you replace the function,=20
> but might be not so clear why you did so. I think it would be better to=20
> understand if you write like:
>
> We are trying to set a value for the i_sequence, that we expect that is=20
> zero, but if we fail to do so, we are happy to use the current non-zero=20
> i_sequence value that we found. Instead of using=20
> atomic64_cmpxchg_relaxed(), use atomic64_try_cmpxchg_relaxed() which=20
> provides a better semantic for this situation.

We are not expecting, trying, happy.. That's non-technical babbling.

See Documentation/process/* for futher explanation.

I agree with you that the change log should be more informative about
the why instead of listing the what, but not for the price of a
non-technical 'we' novel.

Thanks,

        tglx

