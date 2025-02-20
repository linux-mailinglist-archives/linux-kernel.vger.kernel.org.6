Return-Path: <linux-kernel+bounces-523852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DFCA3DC08
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02AC23BD447
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4BE1B85CC;
	Thu, 20 Feb 2025 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Gw7b11A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pfLMZvzL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20E233985
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740060303; cv=none; b=oTQOKGOAAU0PvvkIJys2UumwT6pU3cQOv13w2XxOb1XHX+NHwOJ8nBX7kol+MsmqI7ioNgYQcao6cE1nlWa+1YRtkhY+C5rGHzwu1ctKDthU3hsVqgwE41oB3Smf+7HFRtXHSNoy8noAT6Q+JB13iRAIL8BSlQxsaBjrcSHv3cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740060303; c=relaxed/simple;
	bh=XIPdRxF0jRCkVl8AX6evKiKXtPkJXWbZ/BVPmKmEdNE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ReUL4b43Gt7sSBuxj87Tu1SJoz1vg5LamLGeVGFwF8XIQ/uwNqHYEqbFNu6mkYRHzU3552Y36mJu0x4VhNShapspbbXYYWf2IUkBq1IzNVPbuWtJbp2IvsLRO9fwNNWghSyXVAwOgkB3vPLFdDWwYH0lccfbrPE5TaU/DQn6B/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Gw7b11A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pfLMZvzL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740060294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJmBnGypEHoshKrGLRN5jC34a8kVfNK01sMA/Czi5OI=;
	b=3Gw7b11APOMge83I18WLFgvE9Artj5/oY5HZ2engrvTDAQl39ZEvjXprWcql/prERL57D9
	2F3yawaFpk7dRTuHiVsQeDjXCozxs0FjRTUljsAcedN34WYCkcUK4tOreU2cs2JFohHr1h
	/uT/h7APK8FuKJo2+YQ1KsTFPbqDoonPjPmjzVaIisJAc9pJF5XQQD1BC7vLM+3joIG7jr
	OAdGdwj7Mx1x7RfLeHIQIxxzMjA95s/GptOI7KMbJvftSb09zqzEya9sVlf4by8LKDQijZ
	B1bRserO2yeQc93qDq4sPSDrg2WOe8HHV1qCvZq6Hz8LRRTxt/HbtyTIN6LdCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740060294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJmBnGypEHoshKrGLRN5jC34a8kVfNK01sMA/Czi5OI=;
	b=pfLMZvzLiuE6o/kcwx/IgArD4nN3xIyKSYXUNheLoREopF7/Yw2PmGop/D8Gezf8JH2qtt
	O7rMBInUiUMU7GDA==
To: Eric Dumazet <edumazet@google.com>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 Benjamin Segall <bsegall@google.com>, Eric Dumazet
 <eric.dumazet@gmail.com>
Subject: Re: [PATCH V2 1/4] posix-timers: Make next_posix_timer_id an atomic_t
In-Reply-To: <CANn89i+LJFHhA=VF2T5v_kN0=sFLeropuRERnhWdadj5w6kiyw@mail.gmail.com>
References: <20250219125522.2535263-1-edumazet@google.com>
 <20250219125522.2535263-2-edumazet@google.com> <87wmdlhwa8.ffs@tglx>
 <CANn89i+LJFHhA=VF2T5v_kN0=sFLeropuRERnhWdadj5w6kiyw@mail.gmail.com>
Date: Thu, 20 Feb 2025 15:04:53 +0100
Message-ID: <87h64oiuey.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20 2025 at 09:49, Eric Dumazet wrote:
> On Thu, Feb 20, 2025 at 9:09=E2=80=AFAM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> > This allows the following patch to use RCU.
>>
>> Your patch ordering is slightly off by two :)
>>
>> And it fails to explain for what RCU can be used....
>
> This is explained in the following patches.

The changelog of a patch has to be self contained. The 'following patch'
has no meaning when the patch is merged.

> If I add nothing in the changelog, you complain the changelog is not
> explaining anything.
>
> I suggest you write the patches. because I feel a huge resistance,
> which I do not understand.

I'm just asking that I get properly written change logs which adhere to
the documented change log requirements.

How does that qualify as resistance?

Thanks,

        tglx

