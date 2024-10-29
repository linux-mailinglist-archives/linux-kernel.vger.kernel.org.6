Return-Path: <linux-kernel+bounces-386919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 432409B49B0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02EA2283D6B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C181F206045;
	Tue, 29 Oct 2024 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UyaDviFZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CcpV7VJY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UyaDviFZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CcpV7VJY"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2681617996
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730204950; cv=none; b=Wzpn+lG2gW0xbr/PHkLDYN/MHhIJZITXqUbx/1JCpj9CIPpmx77L8GKycftp/PLciuO//rlMO9lr52vM+gnrG1xlb3li2VYeL0XF7ZpSZBdXzS/RZwWWEWkree+nPe1z/XeLI05EXCkXRuGF4GYyxLlrQi1nqVv19otM7FjXj9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730204950; c=relaxed/simple;
	bh=IJK7+iOSJGGwTfNs/fO+7r1zUQ66G8izAjg5AV2few0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=obAE/U/5B/BqXue1kc7zEzQ+hR4yDA3F4ZQxptDzczsf0BNQqKv2IffXvxWPeYevDvFUovVNTkgA4sqFtKkY3ZozwOjcOetG/WHbYg/u4EGCpty/KiH4taLEAWsASCMDOmV6kUZgvd+G8n5ZubSoI5yXCRsOVsXKAEkoUdk3/wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UyaDviFZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CcpV7VJY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UyaDviFZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CcpV7VJY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from hawking.nue2.suse.org (unknown [IPv6:2a07:de40:a101:3:92b1:1cff:fe69:ddc])
	by smtp-out2.suse.de (Postfix) with ESMTP id 441331FED4;
	Tue, 29 Oct 2024 12:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730204946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j3Vz+dacbqRiljRz+LKhFaDlNU98ZdwgStJ4Tw81PDY=;
	b=UyaDviFZmWlD5ke2+kO5Qc2q1wm2rIpoDGTi5AQEehdzvGdc+y0FbuaXx1IhHKK76T3jqf
	VWVRGNhAFYsbr5Lv00tOpCzo4cznGUC2+m/2u20MyJecozaR5uIvfgx9o4skvlAV2LWPLE
	yA/F2r9PN57U4Z9czXLY9LUN+GD0DYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730204946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j3Vz+dacbqRiljRz+LKhFaDlNU98ZdwgStJ4Tw81PDY=;
	b=CcpV7VJYMq5ImLuDSQD7No38skz4DvHQeUm19+Apq+ggs7JDMSC2ket1zak742Yy7LkUeC
	NqBNYR4xtoLPEDDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UyaDviFZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CcpV7VJY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730204946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j3Vz+dacbqRiljRz+LKhFaDlNU98ZdwgStJ4Tw81PDY=;
	b=UyaDviFZmWlD5ke2+kO5Qc2q1wm2rIpoDGTi5AQEehdzvGdc+y0FbuaXx1IhHKK76T3jqf
	VWVRGNhAFYsbr5Lv00tOpCzo4cznGUC2+m/2u20MyJecozaR5uIvfgx9o4skvlAV2LWPLE
	yA/F2r9PN57U4Z9czXLY9LUN+GD0DYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730204946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j3Vz+dacbqRiljRz+LKhFaDlNU98ZdwgStJ4Tw81PDY=;
	b=CcpV7VJYMq5ImLuDSQD7No38skz4DvHQeUm19+Apq+ggs7JDMSC2ket1zak742Yy7LkUeC
	NqBNYR4xtoLPEDDg==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
	id 2C5634A056E; Tue, 29 Oct 2024 13:29:06 +0100 (CET)
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
References: <mvm5xq44bqh.fsf@suse.de>
	<mhng-adb76a44-07c8-442c-8bcf-6f29d061c031@palmer-ri-x1c9>
X-Yow: LOOK!!!  I'm WALKING in my SLEEP again!!
Date: Tue, 29 Oct 2024 13:29:06 +0100
Message-ID: <mvmy12714a5.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [4.09 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[hawking.nue2.suse.org];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[hawking.nue2.suse.org];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_NO_TLS_LAST(0.10)[];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DIRECT_TO_MX(0.00)[Gnus/5.13 (Gnus v5.13)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,rivosinc.com,sifive.com,eecs.berkeley.edu,gmail.com,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: 4.09
X-Rspamd-Queue-Id: 441331FED4
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Bar: ++++
X-Spam-Level: ****

Ping!  It's already rc5 and this is still not fixed.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

