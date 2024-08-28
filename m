Return-Path: <linux-kernel+bounces-304865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D72009625F8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805DA1F26383
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529F817278D;
	Wed, 28 Aug 2024 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RwwPGxMA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OXqnlx5L";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HDKWTJ7Y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0L9heknE"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C913FEC;
	Wed, 28 Aug 2024 11:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724844223; cv=none; b=FqVi053+jC/qqyoMuqinkXm0BxyYdlwVM31+L0Kdso69KXgZxscuzQMcINFfKx5X6a8aBhj2EBaSn4nPIlm0QFjsLNmW0wmAkAe1kV2TcwXH0jtL283t8PioR3RFheAgDqBDAdhIfCp/k2TeIMaV9DzRWuXwOhnbyGWQuclelWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724844223; c=relaxed/simple;
	bh=/nD3GELsv87/jPZ4l6cKmc5fENYaICBxFVhol7UbrYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=llBIer+/yGfO6sTfZrz0RAt3Ut8ATPRqw0ib9eBOSdPfmXGpT3PG5Hp0wZ0wH/A0UgF2eM7fEv4+Ev8HSiUbKcswedq+f824tEt403iSxn+Alr93zYgJmnTd4TfbY/4Kv/j50OXLV6SRhPMpX+yReohElyC3aZezIxLSKTJ0SII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RwwPGxMA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OXqnlx5L; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HDKWTJ7Y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0L9heknE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	by smtp-out2.suse.de (Postfix) with ESMTP id BD5011FC06;
	Wed, 28 Aug 2024 11:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724844218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VU/9WnGSOzBeM537Y5PLqEr5y1QDTfXTBgK86EBJIUw=;
	b=RwwPGxMAH39mMgivxKTaMvNBWNQe3H9cHVI98eZnOHjT+gaJiWefN8yfX+7VB0WdyzkK0p
	mn61T7RT7mrLK5/xZqSrAYkj73NdErJD0vCUkMSSigbcOvo5qQYrJqkg1qsMqxTvjcdVS4
	nuIzjHSS5LALbWM1aWaAXKWul/IBp+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724844218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VU/9WnGSOzBeM537Y5PLqEr5y1QDTfXTBgK86EBJIUw=;
	b=OXqnlx5LDk8CkiliHLD4SodJgRrGZWQC9dPZ4s2soZoOHjdktHFHs+UasERume0KR2UrMo
	0tTIjUv//vzQdGBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724844217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VU/9WnGSOzBeM537Y5PLqEr5y1QDTfXTBgK86EBJIUw=;
	b=HDKWTJ7YQbhe3z2ts88sIa6bK8AHJUtyzbi1b+hmDJ8Uw1yrKwF6DZo0z0IRNCYkwBuG4i
	PpZGoUQNGS/Bs1NeNiVFiGwEW/jmRaew8WKuMq/Z7t6Hr0sNHloepmidhGGQGAiEijjFb0
	6vEeduBka2zmN9YXayDNTumFi/nq85M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724844217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VU/9WnGSOzBeM537Y5PLqEr5y1QDTfXTBgK86EBJIUw=;
	b=0L9heknEgjULYlmzLiD6Mc/ql0of11CmvvIzLGCDK6ukncrac7LeF/CoVEGC1lXBdp2t0h
	5wHFa1aWPZZnwGAA==
From: Michal Suchanek <msuchanek@suse.de>
To: linux-integrity@vger.kernel.org
Cc: Michal Suchanek <msuchanek@suse.de>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/2] MAINTAINERS: Add selftest files to TPM section
Date: Wed, 28 Aug 2024 13:23:19 +0200
Message-ID: <52c629ebbfc8f5218a90fa539f816c8555cb552a.1724842902.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_CC(0.00)[suse.de,gmx.de,kernel.org,ziepe.ca,vger.kernel.org];
	RCVD_COUNT_ZERO(0.00)[0];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Score: -2.80
X-Spam-Flag: NO

tools/testing/selftests/tpm2/ is TPM-specific test

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 878dcd23b331..c2ee92c7c16c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23184,6 +23184,7 @@ Q:	https://patchwork.kernel.org/project/linux-integrity/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
 F:	Documentation/devicetree/bindings/tpm/
 F:	drivers/char/tpm/
+F:	tools/testing/selftests/tpm2/
 
 TPS546D24 DRIVER
 M:	Duke Du <dukedu83@gmail.com>
-- 
2.46.0


