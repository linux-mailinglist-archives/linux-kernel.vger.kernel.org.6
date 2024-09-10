Return-Path: <linux-kernel+bounces-323373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054C1973C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E5F289630
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7EE18DF72;
	Tue, 10 Sep 2024 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MOHCt7Ga";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YgbYiRzJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF34191476
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725982798; cv=none; b=JrS4f2n2I7SoTmqPxH92nen6dpw7r5CS4jt6Yq7r8klPj/bSPSNV01UWX4a4eDUxgYDnXbKsfioDqxt+70vwTGZd6D+/lfFz9lwhDKt8y4l4ntHE6t35KSussQRTi3beCryYdvFZpNkIPcIxHoNOqIevXSkFiC3dT83ZSAcBq+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725982798; c=relaxed/simple;
	bh=iHcD49en55wZjTtXeS2HYkhlV/FVJzfHYOxnWe7H8+M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FxDCnnXZQQFrkLNrS5Y1cuxZloYNogIqTW6IKhito8TeILOmZmrGwOgqpVAOWoL/QTyv68OZh+nPAeg5i3NN+eR09PMTXJCgDdx0FN8ZTccVDD6CUtWn+mffg5XIS2w5INZbXdMO498BmV2Ba6wYH19NwMnWCpO4+FdpbaNRjAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MOHCt7Ga; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YgbYiRzJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725982794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SOWzLEEHzSAE8huPEbUv1hAH0Dgc2OS2vbPRANDbkZA=;
	b=MOHCt7Ga2iCuuAJocAeobmpgZpKqL0aMAPSnX6Sfx7K4G7naKLEywjJsSjEuwU4Wiqul+E
	Bd5q2FYq36xkTE4eXEzGtK2S1XAqUjdI2khKrM5I5QFH/y8USqSL8wbkI1psBjZ7C6QMC9
	O/sOZdz3dIKf5pXSHZZTuHrGa4OjwgT9nNFLPsp+T5AIVydDuk+w9IIqoJdg4ykCHZGONo
	TlI/BoWOmuFxqdKkCs3VwwoA1x0MRTTJdEF79G7dJK6kKkU/pyzw81MNFMfGTTztg9tEaN
	mpxa2fWfFQzkZyPYKwVhzqUr5qfe+e7JZ2GA0xj4GKaqZMctf1683mBHIGkeaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725982794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SOWzLEEHzSAE8huPEbUv1hAH0Dgc2OS2vbPRANDbkZA=;
	b=YgbYiRzJCIKm+6Dinp3OD02Vq17tbSejooLuaOPT8UbGc3E0TL6QZKtIwcNlEU+UhuCoF0
	QEv+pWPRxer9jyCA==
To: Jeff Layton <jlayton@kernel.org>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] timekeeping: don't use seqcount loop in
 ktime_mono_to_any on 64-bit arch
In-Reply-To: <ee39e467d23070c00aa39f12895fe346406f527f.camel@kernel.org>
References: <20240910-mgtime-v1-1-35fb64bd0af5@kernel.org>
 <878qvzbtz1.ffs@tglx>
 <ee39e467d23070c00aa39f12895fe346406f527f.camel@kernel.org>
Date: Tue, 10 Sep 2024 17:39:54 +0200
Message-ID: <87ttena56d.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 10 2024 at 08:32, Jeff Layton wrote:
> On Tue, 2024-09-10 at 13:58 +0200, Thomas Gleixner wrote:
>> > +#if BITS_PER_LONG == 64
>> > +ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs)
>> > +{
>> > +	ktime_t *offset = offsets[offs];
>> > +
>> > +	return ktime_add(tmono, READ_ONCE(*offset));
>> 
>> Where is the corresponing WRITE_ONCE()?
>> 
> I'll just make it do a simple fetch without READ_ONCE.

Which will make KCSAN complain ...

So yes, READ_ONCE() is the correct thing todo, but then we want to have
the counterpart at the write sides.

Thanks,

        tglx

