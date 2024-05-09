Return-Path: <linux-kernel+bounces-174387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3268C0DF1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759E81F23B67
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9864114AD2F;
	Thu,  9 May 2024 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X61WZRV0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="moWPaWSz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0fc2yEPa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MKKTvpef"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4E714AD26
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715248930; cv=none; b=Qky6OXvO0IDlpYwn9C4mh8eUNYmy6ZB3Ij2pGPyDMaP3uwQKTwpGu+tCnqA2cVooqgN1Hhb7tqsGBobAQvEp8QeoTdg1shrPDZaljzpj8iadmdKng64aIv5y7YMQagzfixTW01u+y4cbrDXl/ENXlX4/ueKCu48cKHZDgciM4+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715248930; c=relaxed/simple;
	bh=1HlP+po1f6y0qaDWyUI+KjOG0FllaVd+6vIRHmNouc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LPwZRwhWXlHzWDZseHq3hL9svvK0+ouSLnWxOGgOeNVlHjZPAlI3Ec871CpSJZ+c85N6POSKigq+UCcNit+bV9zUAJwNrpyWsPEjUtO9SbCHzCg0DQge6A7Va51o46kWYAcQsg0yBz0U/U8P3HapXVvM7QJGmDRJM60C15fbJQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X61WZRV0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=moWPaWSz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0fc2yEPa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MKKTvpef; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0B48F3822A;
	Thu,  9 May 2024 10:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715248927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=q4ITZ+sf/JwnbGDnpuG6vOZrXVPF0TDChnwNG2SVvhU=;
	b=X61WZRV0CKSDBsLkJCU1jgxEIEFUZd6o3iouhCS+xgeQON/SlFZauvl64PZV7H5qKnWVXR
	6EX7eLnRl6RoTJpH3oJ6/xYMvR9rev6dok9BUqcIaQN3tLPux/EKeJeWyu36gPfAJbm/IV
	iCdv5eqhJTarsgAzNwaZF4uZufNKdLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715248927;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=q4ITZ+sf/JwnbGDnpuG6vOZrXVPF0TDChnwNG2SVvhU=;
	b=moWPaWSzl/Vn4H/v5T6Iwv1EK6RSCvvSjdu/WUcfhK+WBUlVX0j0ged05gB5ovEsSyjvpe
	yBnbwHYFrEslU3CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0fc2yEPa;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MKKTvpef
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715248926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=q4ITZ+sf/JwnbGDnpuG6vOZrXVPF0TDChnwNG2SVvhU=;
	b=0fc2yEPaajFsfFMJZeDnTNAi+U7z911meFzu73a8rD//CpGmvMf4/o0mLPefMvMm6znEkp
	ymrmY4hfbYz26DTExcwqUWLnBptp7bdQEHikCPUHJJYjlbHT42LxPZ/t+jxygMbrQ6VNF5
	FT5Fe965C/0DlquICRPmlXV6ceCEXMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715248926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=q4ITZ+sf/JwnbGDnpuG6vOZrXVPF0TDChnwNG2SVvhU=;
	b=MKKTvpefJlIk4r+NpcWeF7RgFkCoP6fz+VQtdk9KlUv9W1mhMRqZ2XELwN5sd6e0jSssjs
	1uumZlChYXBsEWAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0978D13941;
	Thu,  9 May 2024 10:02:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 642wOBufPGZbOAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 09 May 2024 10:02:03 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Peter Xu <peterx@redhat.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Liu Shixin <liushixin2@huawei.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 0/2] Minor fixups for hugetlb fault path
Date: Thu,  9 May 2024 12:01:46 +0200
Message-ID: <20240509100148.22384-1-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.57
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0B48F3822A
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.57 / 50.00];
	BAYES_HAM(-2.56)[98.02%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]

Hi,

this series contains a couple of fixups for hugetlb_fault and hugetlb_wp
respectively, where a VM_FAULT_SET_HINDEX call was missing.

I did not bother with a Fixes tag because the missing piece here is that
we will not report to userspace the right extension of the faulty area
by adjusting struct kernel_siginfo.si_addr_lsb, but I do not consider that
to be a big issue because I assume that userspace already knows the size
of the mapping anyway.

Oscar Salvador (2):
  mm/hugetlb: Add missing VM_FAULT_SET_HINDEX in hugetlb_fault
  mm/hugetlb: Add missing VM_FAULT_SET_HINDEX in hugetlb_wp

 mm/hugetlb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.44.0


