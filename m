Return-Path: <linux-kernel+bounces-230845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCBC9182BC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3308BB29856
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FCA1836FD;
	Wed, 26 Jun 2024 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hH+fkMh4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dHlhl5n7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hH+fkMh4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dHlhl5n7"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946908825
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719408958; cv=none; b=gwcW/zeiAC4wv7YhwDZyVVhGHRRCktkOTZOkVI0Ar1gHC6XfmvbzmX4wf/8VB/rh3otcNVukCO1ERr109ovcGn7ZfbHdqX/jlvVFOwv0y6JcWkt6iCKDvooaxjK+upR/wpdvQ8S2XjE12y9UuqUH3pkcIQ69o1YlSQ4iNz3uvd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719408958; c=relaxed/simple;
	bh=rkWoFkyj6Lmx8cfwPcH1xeK/TlfFKjSba1Xhv0OjwyA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bI+5htlor/z3f5nlc38/xSQQJds36uNHBBQK2/nsREIr38SX4BvGdY28Yfpdziv2/zOjC30zHnn/JHZ+AQChMSrW7Q2JeTTDjuFEGABcBa28GOEs2SI9wb/kfDMFmBQ9axTGlG2dyOK/oiPNz1dI4muoW7ApF/8nzvPKmoAOqJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hH+fkMh4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dHlhl5n7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hH+fkMh4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dHlhl5n7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
	by smtp-out2.suse.de (Postfix) with ESMTP id B95B21FB57;
	Wed, 26 Jun 2024 13:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719408954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mfrpoZhgiakpLLc3RPoEygxxgDJs9BsRwzh2jo1OcAM=;
	b=hH+fkMh4zjWLvQFqnHzhw2DJ84Ru97zHt38bUK2J5PeiDbX4dl6z4PgdKc/DuIwMY/63+W
	LfaHZbyfUbgxhad880f2Xem9C255DA/VkGRvAOpjSx+uQd5RToZZ4Tin7EW+veC6+qUnoz
	kU+h2rDen1C6tRpKuzro2t4YogKxSbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719408954;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mfrpoZhgiakpLLc3RPoEygxxgDJs9BsRwzh2jo1OcAM=;
	b=dHlhl5n7lGk1VnXkSQin/xnWpsqKyAilrbdOOJlP5dfhRSn0D6uqMNf5H4Q50stPpk1r3F
	vqCpKNMu6VzzR3BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719408954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mfrpoZhgiakpLLc3RPoEygxxgDJs9BsRwzh2jo1OcAM=;
	b=hH+fkMh4zjWLvQFqnHzhw2DJ84Ru97zHt38bUK2J5PeiDbX4dl6z4PgdKc/DuIwMY/63+W
	LfaHZbyfUbgxhad880f2Xem9C255DA/VkGRvAOpjSx+uQd5RToZZ4Tin7EW+veC6+qUnoz
	kU+h2rDen1C6tRpKuzro2t4YogKxSbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719408954;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mfrpoZhgiakpLLc3RPoEygxxgDJs9BsRwzh2jo1OcAM=;
	b=dHlhl5n7lGk1VnXkSQin/xnWpsqKyAilrbdOOJlP5dfhRSn0D6uqMNf5H4Q50stPpk1r3F
	vqCpKNMu6VzzR3BQ==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
	id 8204B4A050D; Wed, 26 Jun 2024 15:35:54 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,  Paul Walmsley
 <paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>,  Albert
 Ou <aou@eecs.berkeley.edu>,  linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] riscv: uaccess: use input constraints for ptr of
 __put_user
In-Reply-To: <ZnwObmA70Bfx9yCn@xhacker> (Jisheng Zhang's message of "Wed, 26
	Jun 2024 20:49:50 +0800")
References: <20240625040500.1788-1-jszhang@kernel.org>
	<20240625040500.1788-3-jszhang@kernel.org>
	<acd2e53f-b5c1-49c5-86e2-bc09eb917163@app.fastmail.com>
	<ZnwKXWzRz9B5FbLM@xhacker> <ZnwObmA70Bfx9yCn@xhacker>
X-Yow: I like the IMPUDENT NOSE on that car..  Are you a TEEN-AGER?  
Date: Wed, 26 Jun 2024 15:35:54 +0200
Message-ID: <mvma5j7omh1.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -4.20
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.20 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.989];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_NO_TLS_LAST(0.10)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]

On Jun 26 2024, Jisheng Zhang wrote:

> no output constraints either. It just uses "r" input constraints to tell
> gcc to read the store address into one proper GP reg.

Again, this is backwards.  Being an input operand means the asm is using
this operand as an input to the instructions.  The compiler needs to
arrange to put the value in the allocated operand location according to
the constraint.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

