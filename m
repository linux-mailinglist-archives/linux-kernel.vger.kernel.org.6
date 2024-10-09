Return-Path: <linux-kernel+bounces-356649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C9C996494
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E50EC1C23A98
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6721318A6B1;
	Wed,  9 Oct 2024 09:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="G7TA20Kg"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C1B188929
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 09:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728465188; cv=none; b=GDIpRLYvaqJRlQlb8KkFjOLN0mrePoOAk1BWU7AIMvCImGhGB0JX7X5xNunWW205jfNnlx/KY6980sVOGQ0S+8rTuAvyMvZK3i/P+RjlMevEQOUvGXHQYuBssgcM5ShOwshS3Qz2c69zxZhe4DsU1eNdWBBhS0SCydqwFIHxFw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728465188; c=relaxed/simple;
	bh=ZtXnvvqwwvSgYyRuGL2zc0fQLfyQ5ojitTUrV2UI/p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNWZkNzf+EpdL4E8l1LAuBtIY2KlwY8eziExDADs9cfYZO5uHFemQnCUwvZblDaWLqx9QOvQ6aYQLt8s2VdqGXrQV0l9nctb4Jk1zUeehv8VL3/Cv2Yb/Bzt6xM5KXb8yoz7mGLwlgEUTkV5CRU9WsSOTNk66tH+VB3+639FCj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=G7TA20Kg; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 13D4C40E0194;
	Wed,  9 Oct 2024 09:13:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gCIZPBN66lGb; Wed,  9 Oct 2024 09:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1728465178; bh=vFRAC3+utwi/1G+fGmawDfHtZtcHA038WfspHtbjt9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G7TA20KgmTXKNUaOS2qPQOKqC88vrp2pEbHd3P1N14rbuh5SuJ2hubVzJszUvswcM
	 J4c9/RyXuuNYUxM1kmcfRfHGXUW3mH9cduTx3o/xG7bAGL/RzUs+oSAxM+fC+R4YSw
	 yrcJxEgtJc1oA9tbhAAMYq1a+VpDdN+tvU9GgXWJzg8baizJeZ9zKwero0L7OFGzCu
	 fWDueEh+Viqp1dZey7twmA/Oxs/7D9k1fZPSh3t5Vimtol2k2LLgWQQv4aHvQjGHbg
	 ++3+Pq5suTpoCsUN3ENmrS93aPTXZ1MV/AUz4lbFVhOJRiZGwPw34vX0vcjuIDs8Cj
	 GM5rsBcVNfzEknj816wie5ZzGOnUiHAsAvmWAlXP37WTU8p0ekR1DQ43+AF48Ccash
	 vUf18g7Ypl8akgCAJgr/nYm5aOPOk1a2zuQQ1RjNmGm0hiribirjBp/E2ZRhG9qqaE
	 TcJ1PLwgEcCo3n/nilsz+tZrTBmC9gs6ZqPO2TdbgK4+xjHiTI5tmxTijX7v1FNrlK
	 RTxizbrCc4PbN6VA3zTLySYwuliG0N5Px4UUM9BJkMNCeRM7egR3LAK7ytRq/yu/6z
	 WyVsoAkP0U+fhWw397cqlEv4mx2F+d3DjUUPX0ug8Vu4ur+Jw8QBxi6dWMbMJ7xjjv
	 pRJPkxP3xs6vrvBYVCrcsJuc=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 055A740E0191;
	Wed,  9 Oct 2024 09:12:52 +0000 (UTC)
Date: Wed, 9 Oct 2024 11:12:47 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	the arch/x86 maintainers <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: AMD zen microcode updates breaks boot
Message-ID: <20241009091247.GCZwZJDwFETmN5pEGe@fat_crate.local>
References: <91194406-3fdf-4e38-9838-d334af538f74@kernel.dk>
 <20240928061038.GAZved3hMSU3XahWrJ@fat_crate.local>
 <5fe1e264-c285-4988-b1e3-46771d07172b@kernel.dk>
 <20240930044313.GAZvosYZF5mHi2OZbC@fat_crate.local>
 <d7aff674-ad92-4a36-9ebf-8d3c42774723@kernel.dk>
 <CC418B80-5ED9-4F64-917F-BA6F94130F83@alien8.de>
 <ad9638b4-0a4a-4cd0-9fcb-2690693da157@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad9638b4-0a4a-4cd0-9fcb-2690693da157@kernel.dk>

On Mon, Sep 30, 2024 at 10:25:21AM -0600, Jens Axboe wrote:
> Hmm, seems like a pretty standard cpu and updated microcode fw, no? But
> if it's just me, we can just defer until it gets fixed, at least for
> some more rcs. I just pruned the microcode for now to work around it, as
> it's pretty annoying to forget about doing the reverts and then booting
> a broken kernel. The box takes minutes to post+boot.

With the microcode blob removed so that no loading happens, what microcode
does this box have?

Still 0x0aa00215?

I.e., what does:

$ grep microcode /proc/cpuinfo | sort | uniq -c

say?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

