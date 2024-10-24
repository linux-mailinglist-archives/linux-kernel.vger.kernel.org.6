Return-Path: <linux-kernel+bounces-379505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C149ADF6A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C571B21973
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC95117334E;
	Thu, 24 Oct 2024 08:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JC30kHNi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2ytTFVcj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0921ABEC7
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729759529; cv=none; b=J/O5JunO5EPcdZ47XfwzoZHQsiyP7W0NxBVMkU25gd2ZGtAqTHNAODqxWFplBDrr6gkN/x3n63/fx1/n/JqukQYmi8y9/JU44Bjn1tw+WyjFyyDQLyC5HUvaAuFH85hamUVSzKA9G/fJINNvgxAKGncJRHsiJa4rL3apLmCF4M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729759529; c=relaxed/simple;
	bh=/cb8dRandN3tRUsDCeEuNU2eZjNgzVCCR9pi980E9JQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eYvYYLcoKgRGjHJcHmjVMzA1viKz8CCK83OZUrXxg8C44wiMNh4XSA6vlNY7gjhOR9qhYP9dznYz4hfS6ZJagvPkUVb2Eut+/pOP/w+jff18oG2Hp+c9dabKiqbuwyuTePvWOvjM2SssZhDMsZ5ma775w5KRzhEDEPUzzQ+q9OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JC30kHNi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2ytTFVcj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729759525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OHLdk91JF4v6KOCW/Nrx+CMImJeR1hvIiopQqYZpsps=;
	b=JC30kHNiuTcISr4wEsAxXqaCoEd1QLSBI8X/duF1s/qTdub+TLVunKAJNZrPUdCdIv76Un
	INgGHlX+sjBBeJ9iXO9PRMck0EI1qnjsMqqTVavKkkgTkqtBjdxc8rXKI5RxBXHEkc8qpF
	/KlBhPdVCfs4boMpzrAHqOTPuJoGne2sEHjLnlaV9dHAXxv90SJ4Y4R3ZFSBC2gGmOFgj2
	pqR3LZxaahhUfEBdgcMRkNsSAcrzEQK8MjlqOYh25jregcT0MjO3MI08AeyHw34yUNO2Lk
	ZuWAoHaS6G1dS9jgB2w7D2YDfJ4WAGS4/r69LBU5wJCBIVmXAf/lBLOKxrLNiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729759525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OHLdk91JF4v6KOCW/Nrx+CMImJeR1hvIiopQqYZpsps=;
	b=2ytTFVcj1rJTzL3ZFVudQ3dbaS2m+PbxVy1olRuVvPletBxm0yI2gY8f3CwaPzsV15Pfjt
	HYQSn1t/ffVgb+Cg==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Oleg
 Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 07/26] posix-timers: Add proper state tracking
In-Reply-To: <ZxZU5ViCYadY6eOE@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083835.670337048@linutronix.de>
 <ZxZU5ViCYadY6eOE@localhost.localdomain>
Date: Thu, 24 Oct 2024 10:45:24 +0200
Message-ID: <87r0856g9n.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21 2024 at 15:19, Frederic Weisbecker wrote:

> Le Tue, Oct 01, 2024 at 10:42:09AM +0200, Thomas Gleixner a =C3=A9crit :
>> From: Thomas Gleixner <tglx@linutronix.de>
>>=20
>> Right now the state tracking is done by two struct members:
>>=20
>>  - it_active:
>>      A boolean which tracks armed/disarmed state
>>=20
>>  - it_signal_seq:
>>      A sequence counter which is used to invalidate settings
>>      and prevent rearming
>>=20
>> Replace it_active with it_status and keep properly track about the states
>> in one place.
>>=20
>> This allows to reuse it_signal_seq to track reprogramming, disarm and
>
> Did you mean it_status here?

No. it_signal_seq is used to validate whether a queued, but not yet
delivered signal, is valid or not. The sequence is stored in the signal
when the signal is queued and compared to the sequence on delivery.

Thanks,

        tglx

