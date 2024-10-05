Return-Path: <linux-kernel+bounces-351918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFE2991798
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 17:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB47F1F225AA
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 15:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE8F14EC47;
	Sat,  5 Oct 2024 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="co/G/QbG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="co/G/QbG"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712D1149E16
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728140681; cv=none; b=BBCbfdbLhH00OwNS8RnVVeYT0LiO8etwgTAU9vPoURDdslqXcSlc+Jmtj5ZYP7YATYbr+W7Il9acQGdXaRWSvmdQmxEOladzg2sYvbTsZb3vKHrgfBVTVOl2+Bqm/wEODh+v5eD+nwBd2uGNvkuu6Q8pLbnvqxBuGGsDElSYG14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728140681; c=relaxed/simple;
	bh=kYqtYpOlUQ/OJ5KPs59CzPd4KMmzSHSSJjC7ZBScvwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TX889KIRJZ+jV0gp7rZRo1C3ZTKz3FHAfrUgNdXzmie62korRAHuzCKSyrl7uRgMggZg8aByI+PibhHr1/IGmjWlZ0eSKhMGYL1GXaKzD4pqvbBbX4vH03F4vwJMY+xxa4mp03d12hgVxd85DnL1xzwUJ7kaiUMgPcSMOeG7oF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=co/G/QbG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=co/G/QbG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1AB1D1FBA3;
	Sat,  5 Oct 2024 15:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728140672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/3KKG7LZPfw9Sx7QYfWQpHcT7Tnop1iS0tF91rj7sKo=;
	b=co/G/QbGA0caLJktBKxTo6aVIQW6kS2F3Aq9n6Q7SIdZW8IB4s/IZjcj92evlsqTA4tsQc
	vEgjFL1JgpQO3iBSBd2BiozMbQB9vt5GuZoyNj0iN1iTstUA0rGo9JT0mHjfEJzxVwnHvO
	RUCdsa/pVBX0klwFUAhvQee4+1v/pSM=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="co/G/QbG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728140672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/3KKG7LZPfw9Sx7QYfWQpHcT7Tnop1iS0tF91rj7sKo=;
	b=co/G/QbGA0caLJktBKxTo6aVIQW6kS2F3Aq9n6Q7SIdZW8IB4s/IZjcj92evlsqTA4tsQc
	vEgjFL1JgpQO3iBSBd2BiozMbQB9vt5GuZoyNj0iN1iTstUA0rGo9JT0mHjfEJzxVwnHvO
	RUCdsa/pVBX0klwFUAhvQee4+1v/pSM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D803113736;
	Sat,  5 Oct 2024 15:04:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iDu9Mn9VAWcQBgAAD6G6ig
	(envelope-from <jgross@suse.com>); Sat, 05 Oct 2024 15:04:31 +0000
From: Juergen Gross <jgross@suse.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.12-rc2
Date: Sat,  5 Oct 2024 17:04:31 +0200
Message-ID: <20241005150431.12546-1-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1AB1D1FBA3
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_NONE(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.12a-rc2-tag

xen: branch for v6.12-rc2

It contains just a single patch fixing an issue introduced in the
6.12 merge window.

Thanks.

Juergen

 drivers/xen/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Lukas Bulwahn (1):
      xen: Fix config option reference in XEN_PRIVCMD definition

