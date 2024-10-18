Return-Path: <linux-kernel+bounces-371983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD119A42EF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 227F11F2167B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75DC20262E;
	Fri, 18 Oct 2024 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Zz2biUej";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Zz2biUej"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB7A13A271
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729266717; cv=none; b=bTxCammrWbB83iIgTPQ3hv+MOaIRyDwud2/fAvbVQa+4gxn+THVjY2yVeGCHcMnHF0H/MS/0qckHFNcSXg0j8NYCzb2TAxr9JrR3AqbY+W9wiX4bjkdA/ZyBNiFYqbRwOSh3Z+4f2RuduskgDLpzNwQ2YFuVIQqba2Pps2N0iwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729266717; c=relaxed/simple;
	bh=Jp5CQI9d5mqixi33YEsVVJY2019RgRZn5Jkk0haNjho=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RJqYU7BHEzTuIorJ8s7ngN4S5yS6WwhsFocLaHc0lUJ1IMP0+tqaQtfByT3wc2qiNQd4LBFRoiXcTBuKUObghhenZmwi/73Hgi++fODfikgZPow0QvPW3dMnx9VIqR18ZoMkE8u6zOdtGVYbWJFNPkckVv9wrOh0JIZL+DyKp6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Zz2biUej; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Zz2biUej; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 23BA521C55;
	Fri, 18 Oct 2024 15:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729266713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vIjillnQHM8XOu7x5qPkBLQOsxNDMPknEspRSvlrgro=;
	b=Zz2biUejJpIRilqXGOydFeqNY4Yk0/CRu7zQ/TlfMdMw1KcYldisAWIF76HCCq8/MuRdh8
	wz+ra8wVFpMVMs4VzQOs4/hYsjG1sleVRnCHrCFzSTEvJz5f7R5K0MILDHFWnkX5hJF8Z/
	1+rrhbomYd6KkuObOi7dt60czh4ZxIQ=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Zz2biUej
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729266713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vIjillnQHM8XOu7x5qPkBLQOsxNDMPknEspRSvlrgro=;
	b=Zz2biUejJpIRilqXGOydFeqNY4Yk0/CRu7zQ/TlfMdMw1KcYldisAWIF76HCCq8/MuRdh8
	wz+ra8wVFpMVMs4VzQOs4/hYsjG1sleVRnCHrCFzSTEvJz5f7R5K0MILDHFWnkX5hJF8Z/
	1+rrhbomYd6KkuObOi7dt60czh4ZxIQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB65613680;
	Fri, 18 Oct 2024 15:51:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a9stLxiEEmcvTwAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Fri, 18 Oct 2024 15:51:52 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: bp@alien8.de
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 0/3] Minor cleanups in AMD microcode loader
Date: Fri, 18 Oct 2024 18:51:48 +0300
Message-Id: <20241018155151.702350-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 23BA521C55
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Here are 3 minor patches that somewhat simplify and streamline the code in the
AMD's microcode container parsing portion of the loader. No functional changes
intended.


Nikolay Borisov (3):
  x86/microcode/AMD: Return bool from find_blobs_in_containers()
  x86/microcode/AMD: Make __verify_patch_size() return bool
  x86/microcode/AMD: Remove bogus comment from parse_container()

 arch/x86/kernel/cpu/microcode/amd.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

--
2.34.1


