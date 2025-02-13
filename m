Return-Path: <linux-kernel+bounces-512214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B21BA335A8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 03:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC5C3A2853
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFBD2036FB;
	Thu, 13 Feb 2025 02:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u1drbhpy"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60A54A08
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 02:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739415455; cv=none; b=fGYx2cnHf3CKgmcoAzgvAE+zR7CbYPOp7al8i31EEF7tTw6r55ml6NR7BqsKIDfEVKYTyShvYDE1GAunMhkAyZ0eC9s0IX+e/RfTrwNAYAO5J1stIykmIyilCM1qBQn4nTxwU0RgbmW47n2oaUIdIUnIddOa4qjbhzGoakXANZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739415455; c=relaxed/simple;
	bh=CpcRkamTjzxXr7oWqpFy5FD2Fuz+fACZLhbK+eoL7wA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=W5k0Xx4G9vrMtzT+Ur2rh9pwNj0S67U66XXGW2ehuSYXoJ6ByYwlPIJc8HVApW8SlGpX/LIeXV2UkRD8llqM3fV74OvCbHeGSIkMOUFkvySxBVLgn9jCHzXMGFJ95/+90EC0piXT2kki5AXcnsdbrg357matIoKaVmAIdLNMMog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u1drbhpy; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739415450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NmWV5qLBGFJ380Q636JbOBAatzAC28wVNjP4Bc1s1jY=;
	b=u1drbhpyXca+ZGXrN2eKhW797pCKeYFtckSmOgpaly4XqfrUi0RKF0Zi8FCQpWkVWcqLRG
	wOdHIVDU29LKTCRpasCW+6ns0+bLvOaOi7ssmTz9Aax8GpIqgTGkswExqdQMYk8dCeCo42
	HxSa1vj8ZjeGQdz/cjFa6wCr/yF6J0o=
Date: Thu, 13 Feb 2025 02:57:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yosry Ahmed" <yosry.ahmed@linux.dev>
Message-ID: <25268fbedb82a06ba0c13e2c490b164846ef508b@linux.dev>
TLS-Required: No
Subject: Re: [PATCHv4 14/17] zsmalloc: make zspage lock preemptible
To: "Sergey Senozhatsky" <senozhatsky@chromium.org>
Cc: "Sergey Senozhatsky" <senozhatsky@chromium.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Minchan Kim" <minchan@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kairui Song"
 <ryncsn@gmail.com>
In-Reply-To: <rbco2k74plqedtqvn6ebu6wwssy5urw5mjvsk6n576d3urbjnx@tq43anmdvq35>
References: <lxottj72e7jcqw634qwudpsyqckfrvpmlhra43en4zlrlz4cip@erufv6w4n5j6>
 <Z6JMIKlO9U5P-5gE@google.com>
 <6vtpamir4bvn3snlj36tfmnmpcbd6ks6m3sdn7ewmoles7jhau@nbezqbnoukzv>
 <Z6O2oPP7lyRGXer_@google.com>
 <6uhsj4bckhursiblkxe54azfgyqal6tq2de3lpkxw6omkised6@uylodcjruuei>
 <Z6ThGFt6wyNpx9xi@google.com>
 <wnffho5jguo24wfy3qv5tvovoargezbu4kcvpk43ludrhyfo6i@6ogtvk5ivfjc>
 <Z6Z2l9uovxAiED6q@google.com>
 <droaoze6w4atf7guiv6t4imhcmkpteyvoaigdnw5p3vdg75ebx@m56xi2y527i4>
 <Z6y_3xS_8pmZ2bCz@google.com>
 <rbco2k74plqedtqvn6ebu6wwssy5urw5mjvsk6n576d3urbjnx@tq43anmdvq35>
X-Migadu-Flow: FLOW_OUT

February 12, 2025 at 6:18 PM, "Sergey Senozhatsky" <senozhatsky@chromium.=
org> wrote:



>=20
>=20On (25/02/12 15:35), Yosry Ahmed wrote:
>=20
>=20>=20
>=20> Difference at 95.0% confidence
> >=20
>=20>  -1.03219e+08 +/- 55308.7
> >=20
>=20>  -27.9705% +/- 0.0149878%
> >=20
>=20>  (Student's t, pooled s =3D 58864.4)
> >=20
>=20>=20=20
>=20>=20
>=20>  Thanks for sharing these results, but I wonder if this will captur=
e
> >=20
>=20>  regressions from locking changes (e.g. a lock being preemtible)? I=
IUC
> >=20
>=20>  this is counting the instructions executed in these paths, and tha=
t
> >=20
>=20>  won't change if the task gets preempted. Lock contention may be ca=
ptured
> >=20
>=20>  as extra instructions, but I am not sure we'll directly see its ef=
fect
> >=20
>=20>  in terms of serialization and delays.
> >=20
>=20
> Yeah..
>=20
>=20>=20
>=20> I think we also need some high level testing (e.g. concurrent
> >=20
>=20>  swapins/swapouts) to find that out. I think that's what Kairui's t=
esting
> >=20
>=20>  covers.
> >=20
>=20
> I do a fair amount of high-level testing: heavy parallel (make -j36 and
>=20
>=20parallel dd) workloads (multiple zram devices configuration - zram0 e=
xt4,
>=20
>=20zram1 writeback device, zram2 swap) w/ and w/o lockdep. In addition I=
 also
>=20
>=20run these workloads under heavy memory pressure (a 4GB VM), when oom-=
killer
>=20
>=20starts to run around with a pair of scissors. But it's mostly regress=
ion
>=20
>=20testing.
>

If we can get some numbers from these parallel workloads that would be be=
tter than the perf stats imo.

