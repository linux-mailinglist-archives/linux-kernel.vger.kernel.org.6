Return-Path: <linux-kernel+bounces-336151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F3D97EFCA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 19:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 430C12823FB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CE619F138;
	Mon, 23 Sep 2024 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ouzwuqMi"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDCF1474BC
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 17:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727111784; cv=none; b=H5u0RkygG2j7w8cFXEAX6FfkjyK7EReX8t0GuUP1tm0DXfgBIbiRr3bFqVz34XDdLqB+oj3hH9Im86qKwpdvi+EnHzJ2esVHm9ObWnexYkTN7vM/LZlVQSvAPVEUqWqdkUf+Kx5Mam7hLdtTrAnfXK0FXUZuSFJ0BxnA9P6cAdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727111784; c=relaxed/simple;
	bh=qesHKONBRYDP2KSDZ6mCK+CMR2Q7nSj9EycFk5oxOhA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=sZqC2pkUr5ZdSHCkWMC0NDtBs+i0MB516BRzsxrfRo3kvgl90A/G0cBRqDobbPEUNjjw3PT7pUx6aOEKRStCqTJ5LQuAANesktIcI2LI5Xaokbuf3dGYLjIArfekpr+DAYy7urCArFPG0C0k+EpS8UaPdVXq+6LtAHk7iOp0oeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ouzwuqMi; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727111779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=arIDJxxGKp3XMowF+iWC13inJ73XuWBIODOHW7hK5as=;
	b=ouzwuqMif2L/1uJhpaphQpGt/N7/Wxb6RNRd9MG+LigGY0wEZ/xIxScJ6Gtq79s63VtLzF
	dUfhvWqVCXEvOBi34EbdcvYZ27rQ9J0qTBfQmoYusyNFaqXGfAJt7pw+H6CIsWm7Km/qOU
	yjoSIOyh6Xnds1lIDrx6cWDB7Dk3FhI=
Date: Mon, 23 Sep 2024 17:16:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: andrea.righi@linux.dev
Message-ID: <e93dca67d070beb548c771a8836110cd015b7c48@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] sched_ext: Provide a sysfs enable_seq counter
To: "Phil Auld" <pauld@redhat.com>, "Tejun Heo" <tj@kernel.org>
Cc: "David Vernet" <void@manifault.com>, "Giovanni Gherdovich"
 <giovanni.gherdovich@suse.com>, "Kleber Sacilotto de Souza"
 <kleber.souza@canonical.com>, "Marcelo Henrique Cerri"
 <marcelo.cerri@canonical.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20240923165749.GB313849@pauld.westford.csb>
References: <20240921193921.75594-1-andrea.righi@linux.dev>
 <ZvCKPkwwC9-o2dsQ@mtj.duckdns.org>
 <20240923104548.GA308802@pauld.westford.csb>
 <ZvGJ_xT2LhYJHQbZ@slm.duckdns.org>
 <20240923160007.GA313849@pauld.westford.csb>
 <ZvGYjKAB07VJW7jq@gpd3> <ZvGbkCWR7AbgA6ug@slm.duckdns.org>
 <20240923165749.GB313849@pauld.westford.csb>
X-Migadu-Flow: FLOW_OUT

September 23, 2024 at 6:57 PM, "Phil Auld" <pauld@redhat.com> wrote:
>=20
>=20On Mon, Sep 23, 2024 at 06:47:12AM -1000 Tejun Heo wrote:
>=20
>=20>=20
>=20> Hello,
> >=20
>=20>=20=20
>=20>=20
>=20>  On Mon, Sep 23, 2024 at 06:34:20PM +0200, Andrea Righi wrote:
> >=20
>=20>  ...
> >=20
>=20>  > > Yes, the load sequence number should stay persistent across al=
l schedulers,
> >=20
>=20>  > > but each scheduler should report the sequence number at which =
*it* was
> >=20
>=20>  > > loaded. Note that this doesn't really change anything now. If =
you only care
> >=20
>=20>  > > whether any SCX scheduler has ever been loaded, you'd always l=
ook under
> >=20
>=20>  > > root.
> >=20
>=20>  > >
> >=20
>=20>  >=20
>=20>=20
>=20>  > In my testing root is not there is nothing is loaded.=20
>=20>=20
>=20>=20=20
>=20>=20
>=20>  Ah, right.
> >=20
>=20>=20=20
>=20>=20
>=20>  Right, there's no root if no sched_ext scheduler is loaded. Maybe =
we
> >=20
>=20>  should always keep root present, or have a global counter and one
> >=20
>=20>  per-sched?
> >=20
>=20>=20=20
>=20>=20
>=20>  I'll apply as-is. Let's add per-scheduler load seq separately.
> >=20
>=20
> Thanks! I was thinking that per-scheduler you could just snapshot the
>=20
>=20global counter (either before or after increment) on load. Then you
>=20
>=20could easily tell when each was loaded relative to each other etc.
>=20
>=20Especially while "per-scheduler" is defined by string comparison I'd
>=20
>=20prefer not to rely on that for this use case.=20

Right,=20and it should be a trivial change, I'll work on that as soon as =
I find a stable spot (still on the road for conferences) :)

-Andrea

