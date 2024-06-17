Return-Path: <linux-kernel+bounces-216938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F9090A8CE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE9441C2140A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7264190660;
	Mon, 17 Jun 2024 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HP9fnJOG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t3H02Mul";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HP9fnJOG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t3H02Mul"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BC9EEC3
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718614377; cv=none; b=h6rVe8WMA+vDi02IycKZ7QI3Xi7iDgX+B+538EHJl0I2lx/6tcX8IJJ38vfIntdUjMTHq7g5Vep6VktK1ZVKh2wMt1chpc2UnAloui+0yDq+l6NtWaP5XJZYs00CEGWjQy/I86p16qnlZsAtNYy8k7uNhVgnSDskRDjGz7WEJEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718614377; c=relaxed/simple;
	bh=d/qqE6SkyGcWChXWNDZ9+2tk58pqj//A9Rn5YhrAmpA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tcCUQm3+9uy/Qw5olvjLwIoy45BU7lTg3Q/1/gZV99zxlHSXd89405ED1mK0Z3ORHLGYY6odrylEgvjdwxHzEotil8V/oocyvSFVgsml3dsNcj5hIPLpWntkQ/v2ywpBJi/V/NDFoZAHDMF0r0ILLomXaqMyZyuzajgGf/UoJXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HP9fnJOG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t3H02Mul; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HP9fnJOG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t3H02Mul; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E4B237EB1;
	Mon, 17 Jun 2024 08:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718614373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AXKKR8kATSlOVsJ11IozoebgKiVhPULfEOAe1CFHAkQ=;
	b=HP9fnJOGYkdZbaLhsCS0jVTmdMh2vKnRgtInQi/hsOcNIvMxwKgCKEBBSP6UI57yxweY71
	DtDKgfSNtnXx1GwgYkUqdPUCM+8SmwAamXZ2/ihwelcHNHaAx7CfZ17lX5mhDGsxY4Kvpz
	28s4X1TX/4m6wu1JJmCWCTJjCIOrQKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718614373;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AXKKR8kATSlOVsJ11IozoebgKiVhPULfEOAe1CFHAkQ=;
	b=t3H02MulEQVK+OENPV1HW5auiqEAYdv3HcAY3EgO1tTEDUDL4MefdN1d4kj3xgj6gU5zr0
	iXLz6D23xXAg75BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718614373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AXKKR8kATSlOVsJ11IozoebgKiVhPULfEOAe1CFHAkQ=;
	b=HP9fnJOGYkdZbaLhsCS0jVTmdMh2vKnRgtInQi/hsOcNIvMxwKgCKEBBSP6UI57yxweY71
	DtDKgfSNtnXx1GwgYkUqdPUCM+8SmwAamXZ2/ihwelcHNHaAx7CfZ17lX5mhDGsxY4Kvpz
	28s4X1TX/4m6wu1JJmCWCTJjCIOrQKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718614373;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AXKKR8kATSlOVsJ11IozoebgKiVhPULfEOAe1CFHAkQ=;
	b=t3H02MulEQVK+OENPV1HW5auiqEAYdv3HcAY3EgO1tTEDUDL4MefdN1d4kj3xgj6gU5zr0
	iXLz6D23xXAg75BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6970713AAA;
	Mon, 17 Jun 2024 08:52:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mUYAE2T5b2bBaQAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Mon, 17 Jun 2024 08:52:52 +0000
Date: Mon, 17 Jun 2024 10:52:49 +0200
From: Jean Delvare <jdelvare@suse.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Karol Gugala <kgugala@antmicro.com>, Mateusz Holenko
 <mholenko@antmicro.com>, Gabriel Somlo <gsomlo@gmail.com>, Joel Stanley
 <joel@jms.id.au>, arnd@arndb.de, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RESEND] drivers/soc/litex: drop obsolete dependency on
 COMPILE_TEST
Message-ID: <20240617105249.5f797a0c@endymion.delvare>
In-Reply-To: <20240617104509.70c447b3@endymion.delvare>
References: <20240617104509.70c447b3@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[antmicro.com,gmail.com,jms.id.au,arndb.de,linux-foundation.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]

On Mon, 17 Jun 2024 10:45:09 +0200, Jean Delvare wrote:
> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> is possible to test-build any driver which depends on OF on any
> architecture by explicitly selecting OF. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.
> 
> It is actually better to always build such drivers with OF enabled,
> so that the test builds are closer to how each driver will actually be
> built on its intended target. Building them without OF may not test
> much as the compiler will optimize out potentially large parts of the
> code. In the worst case, this could even pop false positive warnings.
> Dropping COMPILE_TEST here improves the quality of our testing and
> avoids wasting time on non-existent issues.
> 
> As a minor optimization, this also lets us drop of_match_ptr() and
> ifdef-guarding, as we now know what they will resolve to, we might as
> well save cpp some work.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Karol Gugala <kgugala@antmicro.com>
> Cc: Mateusz Holenko <mholenko@antmicro.com>
> Cc: Gabriel Somlo <gsomlo@gmail.com>
> Cc: Joel Stanley <joel@jms.id.au>

Sorry, I forgot to update this list with:

Reviewed-by: Gabriel Somlo <gsomlo@gmail.com>

(from https://lkml.org/lkml/2023/12/20/1160 )

-- 
Jean Delvare
SUSE L3 Support

