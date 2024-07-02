Return-Path: <linux-kernel+bounces-238141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1701092440F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849921F22000
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E881BE224;
	Tue,  2 Jul 2024 17:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2Ctd8DWr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rH8/pphW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2Ctd8DWr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rH8/pphW"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BF4178381
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719939926; cv=none; b=XzDj3c7d1LoFh+iXB2180uMQkXdIZ7CsWFzkgpWbFKG20PUIVD9ivrm7S0EVVYqzGhqwmYgqL9klThWk83KKGV5QJo1i8GhA6YQ7R4G944gDbe7h8GDRmD2QHbw/7rIzMZJA7CuZtp5XS8Tx8zd1gOBZzu/ovSmScMFnFP4+0ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719939926; c=relaxed/simple;
	bh=qADlBCfCfuOm/AUMWzAwt/KOM+/fwy4TFtr439mG4+w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TuDVG1QCYZ1sPTggsmIxIUOB86RRyytRA618GBU84NsiWMYhXrQ3h+I2ufuK5dU+96ISgxATey9Csvyst43wG8+xaRuA+ET4B+aqZLiF6l0F1KUFTWf7iqaoRW2SRpc5bjUwvNoFMDgNwksNcKGYuqXqGFZ80+CnIsCT9OBeLjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2Ctd8DWr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rH8/pphW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2Ctd8DWr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rH8/pphW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 01D5C21B70;
	Tue,  2 Jul 2024 17:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719939923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RA1eifoXZ+Ze7uLWwcBTp71FsSduRk80zWQLo01NY8U=;
	b=2Ctd8DWrkTuWjzPhsIE30EyPO7vHLI43engB6OYeOY93dhy7qDwA1I7mnvwDORCbUu04KK
	pLDu4KaDxOnOPSDRuG8bBInXhsLpSbRQkOpNHeoOPg2k6hH4XxcyU16dQKqMSbHCCBvznl
	iRJyjKFgXrwSBZQ6eiogHc6TKXR919o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719939923;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RA1eifoXZ+Ze7uLWwcBTp71FsSduRk80zWQLo01NY8U=;
	b=rH8/pphWoyqDZW0wxUnq22T+PRR08NQ3qz4uwr5PLkKDV/Z7fifSF9Es/iEsY4nOoP0Oku
	CT4f2t3oAIkQN0Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719939923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RA1eifoXZ+Ze7uLWwcBTp71FsSduRk80zWQLo01NY8U=;
	b=2Ctd8DWrkTuWjzPhsIE30EyPO7vHLI43engB6OYeOY93dhy7qDwA1I7mnvwDORCbUu04KK
	pLDu4KaDxOnOPSDRuG8bBInXhsLpSbRQkOpNHeoOPg2k6hH4XxcyU16dQKqMSbHCCBvznl
	iRJyjKFgXrwSBZQ6eiogHc6TKXR919o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719939923;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RA1eifoXZ+Ze7uLWwcBTp71FsSduRk80zWQLo01NY8U=;
	b=rH8/pphWoyqDZW0wxUnq22T+PRR08NQ3qz4uwr5PLkKDV/Z7fifSF9Es/iEsY4nOoP0Oku
	CT4f2t3oAIkQN0Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3C811395F;
	Tue,  2 Jul 2024 17:05:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3yBOMFEzhGYORgAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Tue, 02 Jul 2024 17:05:21 +0000
Message-ID: <364518a3a279657815b631e85f3177880b42f4f7.camel@suse.de>
Subject: Re: CVE-2024-39362: i2c: acpi: Unbind mux adapters before delete
From: Jean Delvare <jdelvare@suse.de>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hamish Martin
	 <Hamish.Martin@alliedtelesis.co.nz>, Mika Westerberg
	 <mika.westerberg@linux.intel.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Tue, 02 Jul 2024 19:05:19 +0200
In-Reply-To: <2024062550-CVE-2024-39362-2d27@gregkh>
References: <2024062550-CVE-2024-39362-2d27@gregkh>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[renesas];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

Hi all,

On Tue, 2024-06-25 at 16:22 +0200, Greg Kroah-Hartman wrote:
> In the Linux kernel, the following vulnerability has been resolved:
> 
> i2c: acpi: Unbind mux adapters before delete
> (...)
> 
> The Linux kernel CVE team has assigned CVE-2024-39362 to this issue.

I would like to dispute this CVE. I don't quite understand how this bug
qualifies as a security bug, considering that only root can load and
unload overlay SSDT tables. The bug can't be triggered on purpose by a
remote or local unprivileged user.

The bug causes a warning to be dumped to the kernel log, due to trying
to unbind a companion device which is already unbound, but as far as I
can see, that's all. acpi_unbind_one() is a best-effort function, it
returns 0 no matter what. kernfs_remove_by_ame_ns() will gracefully
return an error code. I can't see any obvious use-after-free happening
so I see no way an attacker could exploit this bug.

So I would cancel this CVE.

For completeness and in case someone objects to the cancellation, I
would also point out that I don't think upstream commit 525e6fabeae2
("i2c / ACPI: add support for ACPI reconfigure notifications") is
sufficient to reproduce the bug. Support for ACPI-defined I2C
multiplexing was only added by commit 98b2b712bc85 ("i2c: i2c-mux-gpio:
Enable this driver in ACPI land") in kernel v5.12 and my understanding
is that this capability has to be used by the SSDT tables in order to
trigger the bug. So at the minimum, the CVE should be amended with this
piece of information.

Thanks,
-- 
Jean Delvare
SUSE L3 Support

