Return-Path: <linux-kernel+bounces-182485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0795E8C8BB9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3B81C20401
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FEB1411D1;
	Fri, 17 May 2024 17:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QrW8C06o";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gjRCT2/7"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8679F13FD87;
	Fri, 17 May 2024 17:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967740; cv=none; b=aqH7fu4pUeeeoibLfqzX+iZXt4Gdtj3A9afliPUg8U/qy4lWi4hW0BndxxhHz41M2Kv0gYnm2XAHqlawzcSPlJG9k5V8Cvs3SQp3xWwD37n+AEG+yA26oODs/OZX7oMwm+9hbh0RN1lkw7zf9d5G3QLXA+q5C2AVkKrvanL0Fec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967740; c=relaxed/simple;
	bh=LdlqTwe/mO4GC3DW1gY14MWjg0vJJEYkMXUv2/W5k30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMaFyLRn5n+H2gODAeNQU+yIZtn9sO0dXxSnpmjgPuobqjhbo6Z8EkByvRvUOGKW05L7hKbDp8X/XrLlE6ZXp9++bcsrWmAaQTz3fsLUNVx7GMraPi9R2+4vmVQOfHjD9DZfKO+WOKYNamJoqee/ttSiUPhi8jGhDGC/QEnmlkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QrW8C06o; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gjRCT2/7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 578135D64A;
	Fri, 17 May 2024 17:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715967736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uI2N/LU7fmAr1C+mGRMoNgvCi87LviYVMcbAgfVaCtw=;
	b=QrW8C06oht8OpaOw/EY/VRJ8pAz/OvSySyEaZY+WhP09eVF8A/4yFtZgXVFH1hyTW53HeX
	O6C9/99mfhll/5qxtAEwAuDF69EXawXfX0a6qnyvzo1Sd0s8h/J+f1tPkmXQdJZ3bp54Vx
	cJ1ciH1goigbQEOybPbmfeW+OrMMYzo=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="gjRCT2/7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715967735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uI2N/LU7fmAr1C+mGRMoNgvCi87LviYVMcbAgfVaCtw=;
	b=gjRCT2/7GRS5jHmCniIfr3VsDyhJGuiT4bFGGOLkNmbiDXKTmQaGbqdDrMDILaCKVXqLkA
	VjapRHSkWYI0M3onX3tTuyECTlrCFqJ5mBaGe3/nGSCjJdLLGOowxRKVbOZh+rfgmc//EL
	Zru+zG7/bxoY4d4VqY0tLVet4wNwJ0Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D33013991;
	Fri, 17 May 2024 17:42:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VtapEveWR2YqUQAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Fri, 17 May 2024 17:42:15 +0000
Date: Fri, 17 May 2024 19:42:14 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-cve-announce@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2024-27406: lib/Kconfig.debug: TEST_IOV_ITER depends on MMU
Message-ID: <ot4g5zxesgwpzbgvb7yjazsgdxojktdph42qbw6pik3tvyswhj@kdo44nmnwwcq>
References: <2024051739-CVE-2024-27406-cfc3@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q2prxzht2io4igc6"
Content-Disposition: inline
In-Reply-To: <2024051739-CVE-2024-27406-cfc3@gregkh>
X-Spam-Level: 
X-Spamd-Result: default: False [-8.08 / 50.00];
	BAYES_HAM(-2.97)[99.85%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,linuxfoundation.org:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 578135D64A
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -8.08


--q2prxzht2io4igc6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 01:40:41PM GMT, Greg Kroah-Hartman <gregkh@linuxfou=
ndation.org> wrote:
> BUG: failure at mm/nommu.c:318/vmap()!
> Kernel panic - not syncing: BUG!
>=20
> The test calls vmap() directly, but vmap() is not supported on nommu
> systems, causing the crash.  TEST_IOV_ITER therefore needs to depend on
> MMU.

This is fixing mising assumption of a testing module.
The BUG is deserved AFAIU. The CVE should be reverted IMO.


Thanks,
Michal

--q2prxzht2io4igc6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZkeW9AAKCRAGvrMr/1gc
jiCgAPsE6bEHzqHkZz/5Qsi4IIuq1AGOE5pAFUGGsTjj5yH+UwEA53XWDAdBJnDM
eyKSRH0pVQkqEUBSMz7vz3BWuoMRnQo=
=6mTW
-----END PGP SIGNATURE-----

--q2prxzht2io4igc6--

