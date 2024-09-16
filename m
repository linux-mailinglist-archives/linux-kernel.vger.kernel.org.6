Return-Path: <linux-kernel+bounces-331065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2380997A7EE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 21:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5623D1C2621C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 19:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAB813A3F4;
	Mon, 16 Sep 2024 19:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="GDIW3Sjp"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B79B1DFE4
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 19:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726516147; cv=none; b=Fb4MOriosTFPVp18cOAefoeeFf81Dx/J/8pDnzq5W+fqG4AzAQgyOtCQU3nZ7Y+Ig0o/OaVapMRxtn42MT3W+HWdXkIrk+u2OWQCvyBhq1wpBMnOhXW1R50p0Fm3Rmt4UfPJJTwlvIHFTLFVqPxTgH7vOGX0i0ERVibR2hTdU98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726516147; c=relaxed/simple;
	bh=zPjHfQdvpqs4TfgpQHEOptnUrlJ+kxZazWeYFpu76r8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BukfRJ7h0M5FWp17KSsCMCcjnFU6RQpWwexnHI8n2Wx5us26aMiT84GigEP0+PDIDc/GS6eRScpd49NgmHbrkDVlviop+G3lgPY3G41qf8fGGzLBglFh+iMYBGZf9bymC61aKs0fsfzE7c0Uvmn19v/bQDL3RskMtDPNQ8W4Y+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=GDIW3Sjp; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1726516136; x=1726775336;
	bh=8j1OBoEq93yzihCTZoTOGp8S4edGbr7k85rO/0srWEw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GDIW3SjpRZoye586ZrXv/+XV7/DLswdYwq/x/1/OrHNMlHpWpQln9jqUQDhbQAphW
	 TZHWVJTs2KgiKyg41HlEwThjWrxWuUvh9JoT9fEKxZF91OjUJijM+Z3qYGNp1yGr79
	 bD5OpMo3rGzTgF5JaGjZrxqOVBbP51/pEXcTIO9fahq7WZNhvn6orT9g3/M1PC349e
	 El9SxH1/GwHAGFDoo0EJP1wrqYaOy8LavX7qDVqAhXf5Iuc91M4d3BkTUuIX6Z216d
	 w8DYZX2mJkbMJzYZ5TYZAuYhZlnrIRMAU5a1afgnia8TiR3kePD1Vt+ixweO3wJ9gj
	 skPjyF3rpsQAQ==
Date: Mon, 16 Sep 2024 19:48:54 +0000
To: Peter Zijlstra <peterz@infradead.org>
From: Michael Pratt <mcpratt@pm.me>
Cc: Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [RESEND PATCH] sched/syscalls: Allow setting niceness using sched_param struct
Message-ID: <rdEqY1XYnE6kLSvXRjXReSAey0SEwMDUvqQRqLheIM99LpGH8pmv1ngZsNAkW1-DEHQhERga-rxGfTbuhL6FW_aEdo1DvWaOgncii1KmupY=@pm.me>
In-Reply-To: <e6KW_ypfbIVbenvwbBwGgnxX700e-A68oVmCn1pdJ0834U4wtIWXhh5zfHrQF2dvSL_Vc_heC4KZ0XRzNZ-w7QfF70W0epxCzpph55reOls=@pm.me>
References: <20240916050741.24206-1-mcpratt@pm.me> <20240916111323.GX4723@noisy.programming.kicks-ass.net> <e6KW_ypfbIVbenvwbBwGgnxX700e-A68oVmCn1pdJ0834U4wtIWXhh5zfHrQF2dvSL_Vc_heC4KZ0XRzNZ-w7QfF70W0epxCzpph55reOls=@pm.me>
Feedback-ID: 27397442:user:proton
X-Pm-Message-ID: 2ea0a1b247a658765daeb7e72ca0ee54c8445048
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

one more detail I forgot:
it actually would not be compliant for niceness as the input...

On Monday, September 16th, 2024 at 15:23, Michael Pratt <mcpratt@pm.me> wro=
te:

> On Monday, September 16th, 2024 at 07:13, Peter Zijlstra <peterz@infradea=
d.org> wrote:
>
> > Worse, you're proposing a nice ABI that is entirely different from the
> > normal [-20,19] range.
>=20
> ...
> ...
> ...
>=20
> Otherwise, we have a confusing conflation between the meaning of the two =
values,
> where a value of 19 makes sense for niceness, but is obviously invalid fo=
r priority
> for SCHED_NORMAL, and a negative value makes sense for niceness, but is o=
bviously invalid
> for priority in any policy.
>=20

POSIX doesn't allow a negative value for the ABI at all:

  If successful, the sched_get_priority_max() and sched_get_priority_min() =
functions return
  the appropriate maximum or minimum values, respectively.
  If unsuccessful, they return a value of -1 and set errno to indicate the =
error.


--
MCP

