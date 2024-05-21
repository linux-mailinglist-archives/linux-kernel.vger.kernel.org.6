Return-Path: <linux-kernel+bounces-184921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB8A8CADCD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB2C1F21073
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 12:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D30757FD;
	Tue, 21 May 2024 12:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FIDBnUJ3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Spr7JNRi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251C455C29
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 12:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292856; cv=none; b=s7kVkCRDEykzZiiQJikkU42zZQbkDiNIVSj6N+1WjNr1bUHdFn3ycenxSUKnWSjthwMTmMPv5CKaHiY0KQ5LeoCeHAauQUJ9gkvAALqZkTFricLNWUwqYfCvTyBKntREo04XVadNLB0pqoOWmTbNGMVoKUCATRkaoRcH3gJ92vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292856; c=relaxed/simple;
	bh=2+hxZ4gWqxErB7umts2EDcT/gPEgYlbtK771GFDB2lY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=p+qOAJv4NCs83J4ggb+shlM2K5e+VhW2S+X39nM+1O03BYnRE8qXB0avu/5nTFJ7juGs2vSeMkD40qCRDlsOQdbjhf1iaTw+r+n2tNFi0kODVok1Hcnez8tCbISZOeDEG0TBstIGvjKDBnUeTDH5GE6Qd5UDa10wjzdjh7Z5f4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FIDBnUJ3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Spr7JNRi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716292852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=vvJ0f2sUP/26j4faAiu+S+86UTdCTwt5gHLn8LGtfCc=;
	b=FIDBnUJ3tNa2A87zGFoilcQ4NW/ggJY5l+gygYNhzfpPj0KyyuYxcXa3VTu04ASRNisSJ8
	guaI8L20xI8Y+TRBhm/6NJCPsWIZm2iJTp76YYRkPr/xcf+EXXzlZ7VcJIVUUj1EXvfZwj
	j1PXDAYtX1qKNXnBGyayXWHkYDQQZxmWXdzz2hBCpMfUzfV9+ehA+5GChi4mPXREyzk+w7
	mRTyx8OnTRn7JEvrI6vDGnrlyl7gC0kVpo+XEWbK+a9YwLhcGjsuwBN5b6nFgXx4ZGqiG4
	65PApQBXsuKuBS47mElardI3u3kJKnGyGZaEa+OhA/EvtEyl9p57JZPvoI8AHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716292852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=vvJ0f2sUP/26j4faAiu+S+86UTdCTwt5gHLn8LGtfCc=;
	b=Spr7JNRi3mmNDcs/K+u7ptTiyPb7qefZdIkH59E9tIl8jW9Bgp2+3hGyy6nd3Ajd5By1Ie
	ATxdF3CVO32NqwAA==
To: Dongli Zhang <dongli.zhang@oracle.com>, x86@kernel.org
Cc: mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 joe.jin@oracle.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/1] x86/vector: Fix vector leak during CPU offline
In-Reply-To: <954040a2-435d-48d9-b5de-9ce46ffba238@oracle.com>
Date: Tue, 21 May 2024 14:00:52 +0200
Message-ID: <875xv7idcb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, May 15 2024 at 12:51, Dongli Zhang wrote:
> On 5/13/24 3:46 PM, Thomas Gleixner wrote:
>> So yes, moving the invocation of irq_force_complete_move() before the
>> irq_needs_fixup() call makes sense, but it wants this to actually work
>> correctly:
>> @@ -1097,10 +1098,11 @@ void irq_force_complete_move(struct irq_
>>  		goto unlock;
>>  
>>  	/*
>> -	 * If prev_vector is empty, no action required.
>> +	 * If prev_vector is empty or the descriptor was previously
>> +	 * not on the outgoing CPU no action required.
>>  	 */
>>  	vector = apicd->prev_vector;
>> -	if (!vector)
>> +	if (!vector || apicd->prev_cpu != smp_processor_id())
>>  		goto unlock;
>>  
>
> The above may not work. migrate_one_irq() relies on irq_force_complete_move() to
> always reclaim the apicd->prev_vector. Otherwise, the call of
> irq_do_set_affinity() later may return -EBUSY.

You're right. But that still can be handled in irq_force_complete_move()
with a single unconditional invocation in migrate_one_irq():

	cpu = smp_processor_id();
	if (!vector || (apicd->cur_cpu != cpu && apicd->prev_cpu != cpu))
		goto unlock;

because there are only two cases when a cleanup is required:

   1) The outgoing CPU is the current target

   2) The outgoing CPU was the previous target

No?

Thanks,

        tglx

