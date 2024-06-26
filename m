Return-Path: <linux-kernel+bounces-230806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E129918215
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4AC2810C4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4F0181CE3;
	Wed, 26 Jun 2024 13:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B+pAT+RV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JsPBC40J";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B+pAT+RV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JsPBC40J"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AD3181BB8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407573; cv=none; b=Grv2hqzlAINJUjGjK6edLl31gNzPQqtUKa2aOTaEMRG9DPQUkvhYpnOnhrptKpcTi0WZ0Wrmdi2G8ZJpcn8fcdOCMCX4rjAqh2xpyo9BX6JiPRLYds35QeX8oDtGBaNAZvd84PuXVu+CCtBc6c2QQSBJ6In/BgZL/u40v2AtVF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407573; c=relaxed/simple;
	bh=kHDZgcJ0udVs+eyU3t/o9puU7N3q6vsn1coCtrZHWuM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZQpNtgZ08tNCiL1Zz2TxMDps7Lw+/LcS5YOXVu10ql/NakVX4zMFl1DJYilItTxW5j2OQNy4NDj6MdoGpSBg8JQcK7UovJ2IDofU+M+5hsgpi/HEj8w3ZAcsOo3n9UNSPNMSltNQHmoXUmGg1YnIuCTqFwjeSbNMWSVnQ0hydvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B+pAT+RV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JsPBC40J; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B+pAT+RV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JsPBC40J; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
	by smtp-out1.suse.de (Postfix) with ESMTP id 25B7421A99;
	Wed, 26 Jun 2024 13:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719407570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCa82HaPuM92DEe4lqLQ19XPhcnsH9XJaUHSDB5WOrg=;
	b=B+pAT+RVwsuhyDCyJlII7uNA+7KhhqBIQeT3pkN9/guAk3tUG2+qyus0DKMdOvgFa+rNiJ
	FfBkZ3KQPCd7+qupc1NNhOKHdzB+90ign7VtPpZ8zkssGVdV8gubo3xo8XeRKC9oKtbGyl
	cB9j0NtJsrnrcfgJDbnu90WqXrFLN/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719407570;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCa82HaPuM92DEe4lqLQ19XPhcnsH9XJaUHSDB5WOrg=;
	b=JsPBC40J3px8snBbnKMa/1cpnkIANAq3EgZsMvFhgexwioIfRjOlrzwZ5X7lRbhk8tm1fF
	Osm8UCYX7RkVj/Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719407570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCa82HaPuM92DEe4lqLQ19XPhcnsH9XJaUHSDB5WOrg=;
	b=B+pAT+RVwsuhyDCyJlII7uNA+7KhhqBIQeT3pkN9/guAk3tUG2+qyus0DKMdOvgFa+rNiJ
	FfBkZ3KQPCd7+qupc1NNhOKHdzB+90ign7VtPpZ8zkssGVdV8gubo3xo8XeRKC9oKtbGyl
	cB9j0NtJsrnrcfgJDbnu90WqXrFLN/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719407570;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCa82HaPuM92DEe4lqLQ19XPhcnsH9XJaUHSDB5WOrg=;
	b=JsPBC40J3px8snBbnKMa/1cpnkIANAq3EgZsMvFhgexwioIfRjOlrzwZ5X7lRbhk8tm1fF
	Osm8UCYX7RkVj/Bg==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
	id 14A504A050D; Wed, 26 Jun 2024 15:12:50 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,  Palmer Dabbelt
 <palmer@dabbelt.com>,  Albert Ou <aou@eecs.berkeley.edu>,
  linux-riscv@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] riscv: uaccess: use input constraints for ptr of
 __put_user
In-Reply-To: <20240625040500.1788-3-jszhang@kernel.org> (Jisheng Zhang's
	message of "Tue, 25 Jun 2024 12:04:58 +0800")
References: <20240625040500.1788-1-jszhang@kernel.org>
	<20240625040500.1788-3-jszhang@kernel.org>
X-Yow: MMM-MM!!  So THIS is BIO-NEBULATION!
Date: Wed, 26 Jun 2024 15:12:50 +0200
Message-ID: <mvmikxvonjh.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.18 / 50.00];
	BAYES_HAM(-2.98)[99.92%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.986];
	RCVD_NO_TLS_LAST(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.18
X-Spam-Level: 

On Jun 25 2024, Jisheng Zhang wrote:

> I believe the output constraints "=m" is not necessary, because
> the instruction itself is "write", we don't need the compiler
> to "write" for us.

No, this is backwards.  Being an output operand means that the *asm* is
writing to it, and the compiler can read the value from there afterwards
(and the previous value is dead before the asm).

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

