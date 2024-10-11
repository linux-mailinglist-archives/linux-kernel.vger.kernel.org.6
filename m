Return-Path: <linux-kernel+bounces-360895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4633C99A119
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 989D71F21672
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D2B20C465;
	Fri, 11 Oct 2024 10:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DtQEfn8U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o87QmKLb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DtQEfn8U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o87QmKLb"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1246B20FA89
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641804; cv=none; b=QouEPKewuQ3X+A8VySZP71UiQfqSL2Mh1omny5qnRJ75HpP9qOUjzFdTi3dwYcjvd62L1vromdd0IR4/3JEopS3P7pXGmrp1OhkTK6yA3AJs2MrBG10Mz2u3D8fRJHJ+NTr1vq7cDCi1V9Ef3taj5Zaftc37P3W3n9FgE2XlLIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641804; c=relaxed/simple;
	bh=TQ6kcWdqLbgNOn8WSqGTRL14Obhfy55lV11i49WhF2s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pYb9uINTZkLd626itlzS3cwTdQGi20s2qkb7nVdzO5nLdh6ZIDAUJYmfN+FmqPShWZiSKJR7fSaioMSX+rGs5sojNz62ZuWSn7cc1Iruf+7OkFAVE5ojtvXbwipPhQkiF2yy1m5BRhGcapo1BluzNKzOp+Nvd2AQV9PNwYJV2mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DtQEfn8U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=o87QmKLb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DtQEfn8U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=o87QmKLb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 38E1F2200C;
	Fri, 11 Oct 2024 10:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728641801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QOskVyjg0ncw+WRCtk4Z8tac+QjK2dxuHGDof2sHPEg=;
	b=DtQEfn8UXHt4o8elirm1xLRoSfmW7kuxwUMuouzVoCTXHCkxMZf29NUDXm/5qo++jKkXyz
	8g8OlkPAoHqRrzfntxOY66Ie8uOPHqp7+Pyfzv5GJU0vmwj7ZANVy4teL4vLa52ZAVj6a/
	auje8Nm2GSiAKrOdFRkE7U4MwH3RZ2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728641801;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QOskVyjg0ncw+WRCtk4Z8tac+QjK2dxuHGDof2sHPEg=;
	b=o87QmKLb1BIzNR/JMdrHa3ktGC/pCqoAEi7ZGgqw6Q9h/Ff7uSYuSDYqrM7/m11oljVrgq
	YaczyjE6e1W+/LAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728641801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QOskVyjg0ncw+WRCtk4Z8tac+QjK2dxuHGDof2sHPEg=;
	b=DtQEfn8UXHt4o8elirm1xLRoSfmW7kuxwUMuouzVoCTXHCkxMZf29NUDXm/5qo++jKkXyz
	8g8OlkPAoHqRrzfntxOY66Ie8uOPHqp7+Pyfzv5GJU0vmwj7ZANVy4teL4vLa52ZAVj6a/
	auje8Nm2GSiAKrOdFRkE7U4MwH3RZ2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728641801;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QOskVyjg0ncw+WRCtk4Z8tac+QjK2dxuHGDof2sHPEg=;
	b=o87QmKLb1BIzNR/JMdrHa3ktGC/pCqoAEi7ZGgqw6Q9h/Ff7uSYuSDYqrM7/m11oljVrgq
	YaczyjE6e1W+/LAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05EDD136E0;
	Fri, 11 Oct 2024 10:16:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rFPgOgj7CGfDPgAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Fri, 11 Oct 2024 10:16:40 +0000
Message-ID: <efc8ab85e02b95ab4db09eb9142f62129a51f08c.camel@suse.de>
Subject: Re: CVE-2024-38630: watchdog: cpu5wdt.c: Fix use-after-free bug
 caused by cpu5wdt_trigger
From: Jean Delvare <jdelvare@suse.de>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 11 Oct 2024 12:16:40 +0200
In-Reply-To: <2024062141-CVE-2024-38630-3640@gregkh>
References: <2024062141-CVE-2024-38630-3640@gregkh>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Hi all,

On Fri, 2024-06-21 at 12:19 +0200, Greg Kroah-Hartman wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> watchdog: cpu5wdt.c: Fix use-after-free bug caused by cpu5wdt_trigger
> 
> When the cpu5wdt module is removing, the origin code uses del_timer() to
> de-activate the timer. If the timer handler is running, del_timer() could
> not stop it and will return directly. If the port region is released by
> release_region() and then the timer handler cpu5wdt_trigger() calls outb()
> to write into the region that is released, the use-after-free bug will
> happen.
> 
> Change del_timer() to timer_shutdown_sync() in order that the timer handler
> could be finished before the port region is released.
> 
> The Linux kernel CVE team has assigned CVE-2024-38630 to this issue.
> 
> 
> Affected and fixed versions
> ===========================
> 
>         Issue introduced in 3.8 with commit e09d9c3e9f85 and fixed in 6.6.33 with commit 9b1c063ffc07
>         Issue introduced in 3.8 with commit e09d9c3e9f85 and fixed in 6.9.4 with commit f19686d61650
>         Issue introduced in 3.8 with commit e09d9c3e9f85 and fixed in 6.10-rc1 with commit 573601521277

For the record, this is incorrect. The Fixes tag is misleading. The
commit being "fixed" was adding a missing del_timer() call, so the
situation was even worst before that, as the race window on module
removal was even larger.

The bug is present since kernel v2.5.61 when the cpu5wdt driver was
added to the kernel tree.

Also note that the bug was fixed using timer_shutdown_sync(), which is
documented as only being needed when the timer can be rearmed by a
workqueue or similar scenario, which is not the case here. So I'm
reasonably certain that using del_timer_sync() would have been
sufficient.

-- 
Jean Delvare
SUSE L3 Support

