Return-Path: <linux-kernel+bounces-358300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64891997CDB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CADA1F2367E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B871A0715;
	Thu, 10 Oct 2024 06:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oqKIsuKA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+728j85Q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LmPlEiIk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+ZVo2cfP"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6381A00F8
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728540697; cv=none; b=ezvAnTwKhI8rVTLF/PY9dIN2263m6ta08tJqnlmfzWiB168zC1g0iA1yeUrPWktDClRjJZVh7zmQLYyPq2QKciXC/0l5X3aj/pyQ0T35zLSS5OpithPon4sT61CmYDnL38jSuiwHeJlMoq0x/Ig6rwqGrXYph69kxs2N3irWB1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728540697; c=relaxed/simple;
	bh=3RqqYjYUCBZPDMwK86XZlSn+ae7rDqndobU95Vx5WIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lGqzAxpUZ1Gr7tLIqMpspyCmSUe5BDl+hEvDj2yX28AI/XhUmQIVrCFFhE5TjDxARAd2uLPVvNogP37kHg0+18n1hdYK7wUwrEIGAxWwLGEkwHDEdgAvC6d6LEbpsRHaRoRGo77ahG5JAcbyyB8Pg23ekHd7Uq0nNXAmQc0BboA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oqKIsuKA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+728j85Q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LmPlEiIk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+ZVo2cfP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
	by smtp-out2.suse.de (Postfix) with ESMTP id EBFF01FE18;
	Thu, 10 Oct 2024 06:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728540694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oT2fu9eXrd1TBQvLN0DfKIwD5GlmFEOSKJXIbSwTQok=;
	b=oqKIsuKADR6QeBpYmyZhAW2ml0Et2ciysjjLGDBGOWcjFc5Q+/tNzi2QvhIl1ea32FUZRV
	TeR2vyPqg+jCpbe3FFmXnMG+UmdvRwzvTl5n4lgknSLevq7u18990HoDrrla9yoQnjhRmY
	uihfKEuTRm8QQLFIRoVmje2tYs9eDz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728540694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oT2fu9eXrd1TBQvLN0DfKIwD5GlmFEOSKJXIbSwTQok=;
	b=+728j85QKTCr9tRHwIOnCZ9Rp5jkmui6yeJMGRUieH3xRqAwSaG18Ems4RDA6wmJhsTlON
	GUoZjHXTyGLPP3Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728540693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oT2fu9eXrd1TBQvLN0DfKIwD5GlmFEOSKJXIbSwTQok=;
	b=LmPlEiIk9Gyv7CTjW3O4KBFEaKCR3Jr3yXX1Wv/Iq0EatR5VnhY86K99Qms28zR5yTn5Ki
	beIpp8jKznIVtr8HQFZcDLVz6QByAF8zeXe5tnlIUSoxqBLIOgRWrQKQ73v1RRF0eDOxzI
	Obw5AI0HXDeMlOJZGxqEPYBHX+y1rys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728540693;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oT2fu9eXrd1TBQvLN0DfKIwD5GlmFEOSKJXIbSwTQok=;
	b=+ZVo2cfPwyv0AfQmsF4GUuhVb70CwTyA6IsPtGmnTtzkLkn9XZAxzQRQv/MwGT+bEpKxXI
	rpWVX3xtO9Rhj9Bg==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
	id DB5F54A0567; Thu, 10 Oct 2024 08:11:33 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org,  Charlie Jenkins
 <charlie@rivosinc.com>,  Paul Walmsley <paul.walmsley@sifive.com>,
  aou@eecs.berkeley.edu,  parri.andrea@gmail.com,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: add forwarding header for
 arch/riscv/include/asm/fence.h
In-Reply-To: <mhng-adb76a44-07c8-442c-8bcf-6f29d061c031@palmer-ri-x1c9>
	(Palmer Dabbelt's message of "Wed, 09 Oct 2024 10:18:40 -0700 (PDT)")
References: <mhng-adb76a44-07c8-442c-8bcf-6f29d061c031@palmer-ri-x1c9>
X-Yow: Why am I in this ROOM in DOWNTOWN PHILADELPHIA?
Date: Thu, 10 Oct 2024 08:11:33 +0200
Message-ID: <mvmbjzs32sq.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Level: 
X-Spamd-Result: default: False [-2.70 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_NO_TLS_LAST(0.10)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,rivosinc.com,sifive.com,eecs.berkeley.edu,gmail.com,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Score: -2.70
X-Spam-Flag: NO

On Okt 09 2024, Palmer Dabbelt wrote:

> Happy to pick this up via the RISC-V tree if you want.  Thanks!

Please make sure to pass it on soon, since it blocks building a
full-featured kernel.

Thanks.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

