Return-Path: <linux-kernel+bounces-383014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5CF9B1631
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 10:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC061282954
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 08:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C6217C22E;
	Sat, 26 Oct 2024 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="w+oIrVvf"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1307C217F3F
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 08:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729929826; cv=none; b=mOdXY/1TXTgs0VEz/ksWyG3lEQwDQb7WaMJ5StCs0FK1NT8KV3ZuOFfeYgldGwFPRsQOjWbEFKFSZjsF2ZmfG32Yp528bsRfvkHrwm0ekiMC6av2h8GU1z5JjgFeTY9z2wzCJpi+0+tv8h/tVynoEoJktQetYQMzMxpwl1cu8mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729929826; c=relaxed/simple;
	bh=8xvFuMBW1keE9gV9hm4gKhkdue9DAfMsI9BXde4g/fg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UGDpAoDTuYSwhKxHs32PiWfHxvJWqRqrdYRwU0oIcg4CaZxjhgyTfxbLxGmiyEXYUktbzjbiWl9iYmQlybm2AaSBCXga65ULu7FdCdonafOEzfoyyV0uzyuD1smnPRstEMLhNDfRda1A910q1IGrj3nH/nLB7t1f6Y4+NUuulls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=w+oIrVvf; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8xvFuMBW1keE9gV9hm4gKhkdue9DAfMsI9BXde4g/fg=;
	t=1729929825; x=1731139425; b=w+oIrVvfgRPIoLxc1LbygBpgbhJR7XADKm3W/PIQakoh3UM
	I3pVALB6UelW9nKt/Urp0r91vLDqcMUMa8X6ZY9G1aSS/dVevwC6CKol5P+uePmno8YLTCBH9owO8
	2gEny/EskNM9MIqGhObYNpdMk0UF1aKsYXVR7sIaGsWLpJ/AuHds6KcXHAcLopNl+0UGduWuIf8EF
	KKyTrU5b4P6yO77gXLk1D8SEKZ1v0NV9eY0IO0yhZ3cxxi5sBgpeMYfGwR5DTzQw1hqmVSHPxt1Sx
	M6ryNSmlk49qAS6w5SA1DyIacl7UenKx0XcN2Jd11jVjgZGB9YMSHYolx8u29pnw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t4blq-00000005Jb4-0fRQ;
	Sat, 26 Oct 2024 10:03:38 +0200
Message-ID: <433fb0eb0132a583dc5f575f0c99c4adb8ef6cab.camel@sipsolutions.net>
Subject: Re: [PATCH][next] um: Malloc just enough space for fitting pid file
From: Johannes Berg <johannes@sipsolutions.net>
To: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, kees@kernel.org, 
	tiwei.btw@antgroup.com, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Sat, 26 Oct 2024 10:03:37 +0200
In-Reply-To: <ZxyhbCw39rBzAvtg@mail.google.com>
References: <ZxxmLngMg3iNjOfK@mail.google.com>
	 <cd892fb5436f1de0fa2ffc9c9ec229873227210f.camel@sipsolutions.net>
	 <ZxyhbCw39rBzAvtg@mail.google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sat, 2024-10-26 at 20:59 +1300, Paulo Miguel Almeida wrote:
>=20
> when I said that "umid is already generated during make_umid_init
> __initcall", from my humble point of view, I was explaining the 'why'
> using UMID_LEN for calculation buffer sizes was redundant. Then again,
> once we know the size of char* umid, we can use strlen(umid) instead.

That's not "why am I changing it" though, that's "why does it work".

The only reasonable explanation I could come up with is that you're
trying to save memory ... but why go to the trouble for a function
that's called exactly once?

johannes

