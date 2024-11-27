Return-Path: <linux-kernel+bounces-423786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CD49DAC9D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 18:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95CC164E81
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C784F201022;
	Wed, 27 Nov 2024 17:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="axXq/cVK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UWqsf0AI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67B082D66
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732729172; cv=none; b=MLRdWgIamqZyke5K9IOKEI2YpJyp6MXPwgvnTbfZVXiyeExgpCVvr4cyII4RVTTdpXPyPk9KwBztrbMg5+OPVmhMvWN+UQuCpojwTqvxidPFU3QlQ9VZP+GpRIinvjLjCk8dT2+kTjePK6UxnPTKegGDJt7IQ4l3SiwZIBTLfGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732729172; c=relaxed/simple;
	bh=KmVFEiRQGKgi20NjezL4WoYvKug/3PLy0NkrfaLyy80=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gkilYNSkTnKbjoBtu8ALHq+m5eMUq80k6CB1z8J/VQ5jn/ey/jpmCtJ+JNDgn/F4FGOGISYTkc+s/0RKD6CtIihWnlsSUd0Qi8SldL/2LhTMbi5GGJsScx9NT1GFdnzocdpBt2sYSVX1Lj1yS2qLHcxgOlUDgparVX8IUBDe86Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=axXq/cVK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UWqsf0AI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732729169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t4+XZoYO8B3ohyj6oZBl2EuZwVjrzncKeUk/15YAQ1w=;
	b=axXq/cVKB6lHbxFNNfx1zlry5pMh54IVrlO5M6eZnTxh9vvoa/ZXGzbNdb9acxrSBgp7+5
	geYOvBzwg8VvguknC0O+2xNMne/dP5Jm7cnWyG9JDchaXV4Fu/IRuB4HSMy0e/PuFxldhF
	xsYcJNFjkgcmhVFBQqok35Hha6mME3i4PsED/I6g8cTWKvG4PovnpkQhd0vqkQL8oPTQdF
	Cq5LAqAGCEozuZyRvDBbhtKdioWA/SFe919hdRwv3E1om7LJoYJ/Y73D2BVgC7LMQzGtYL
	JoeO/Iex1DFCehNTELxVCbMzE75kxPUphhUmsyOzfokHO4eVGmDdG21zXw6BdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732729169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t4+XZoYO8B3ohyj6oZBl2EuZwVjrzncKeUk/15YAQ1w=;
	b=UWqsf0AICBds2KQ7GW6o3/dmngkEDDD/EgjfeJNNJtHlfwx5ai6EHsYdArZE0BlWkwI8db
	z/Z9MKfiq4gbFHAQ==
To: Richard Cochran <richardcochran@gmail.com>
Cc: "Dalmas, Marcelo (GE Vernova)" <marcelo.dalmas@ge.com>,
 "jstultz@google.com" <jstultz@google.com>, "sboyd@kernel.org"
 <sboyd@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ntp: fix bug in adjtimex reading time offset
In-Reply-To: <87ttbsy3zd.ffs@tglx>
References: <SJ0P101MB03687BF7D5A10FD3C49C51E5F42E2@SJ0P101MB0368.NAMP101.PROD.OUTLOOK.COM>
 <87zflkydgp.ffs@tglx> <Z0dDOje96uI_t9sd@hoboy.vegasvil.org>
 <87ttbsy3zd.ffs@tglx>
Date: Wed, 27 Nov 2024 18:39:28 +0100
Message-ID: <87r06wy3sf.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 27 2024 at 18:35, Thomas Gleixner wrote:
> On Wed, Nov 27 2024 at 08:05, Richard Cochran wrote:
>> On Wed, Nov 27, 2024 at 03:10:30PM +0100, Thomas Gleixner wrote:
>>     The patch was generated by the following coccinelle script:
>>
>>     ...
>>
>> So I guess combining random other manual fixes into a patch that
>> claims to be generated is a bad idea?
>
> Indeed. I just figured out why the cast is there. txc::time_offset is of
> type 'long long', so the division triggers a build fail on 32-bit.
>
> It want's to be:
>
>    txc->time_offset = div_s64(txc->time_offset, NSEC_PER_USEC);

Or simpler by using a (s32) cast instead, which is sufficient as
time_offset must be in the range of [INT_MIN ... INT_MAX] because
NTP_SCALE_SHIFT is 32.



