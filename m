Return-Path: <linux-kernel+bounces-202782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 010208FD0FB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6EF28254C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 14:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDA92232A;
	Wed,  5 Jun 2024 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uaOC7PXW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zp9/rEez";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uaOC7PXW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zp9/rEez"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4509C1B5AA;
	Wed,  5 Jun 2024 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717598451; cv=none; b=Y+AnlHs6huho+XqFoFSiJZMh2/Zelp65k2wkglUs/+hKAKVFxGsJ4t5FrJ5+l67YZ9x0/dEsls/pXwk95gJOG1315JTmEPZqwmdEjCTgfFAOVLHPMmJoaoDpCPxAuyPZwcu2K0luQ9tpeka3vCK7wPjtI0Jgoi3Uquki6tlz3mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717598451; c=relaxed/simple;
	bh=ObTS/I9Tkk/gUPd/NEOxNka9aQLTx59YfkQoxoNlccc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W2uwJnhUZl5OloJ5sgc/q0W52tnM3drVknEBABQSuSfM71bj/ncRY86ynKvTEW75rMQOTVwf4iL2GHkxZKt1ox3K45NWQU6OudHE/JG08Keo67mNnN4YwbRpR/KRIczWNxe9o+guo2owPphYf5jUYoUqg7veSFO1oNyTlNjbc5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uaOC7PXW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zp9/rEez; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uaOC7PXW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zp9/rEez; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3BB571F824;
	Wed,  5 Jun 2024 14:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717598447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=atowc3f7IrAwqd5a+5vpkBZGm7Q8msOXF4I72q/jap8=;
	b=uaOC7PXW6VshLyJIK7xPSQvhq2+8Cr0rJ/PGqhaMidKj5VLULYoi7AEoNIx722uXiFO+hQ
	9fNH5tWZtfqI66VYGZPvOzGbZem7qnQnW28rL7CN33ZpXzf2lIpWTwbjnaEGrxfYM08uH6
	sy6lk2toyRgl8I3Q63yzKbOCtQamNVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717598447;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=atowc3f7IrAwqd5a+5vpkBZGm7Q8msOXF4I72q/jap8=;
	b=zp9/rEezGtN9P2QC0uoFNVbXklj4oBZHoI6Y5pEPaiI3WQ9yyu0ELMcUI8ItLvJC5APbjv
	pjLUlznuWsu7PVCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uaOC7PXW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="zp9/rEez"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717598447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=atowc3f7IrAwqd5a+5vpkBZGm7Q8msOXF4I72q/jap8=;
	b=uaOC7PXW6VshLyJIK7xPSQvhq2+8Cr0rJ/PGqhaMidKj5VLULYoi7AEoNIx722uXiFO+hQ
	9fNH5tWZtfqI66VYGZPvOzGbZem7qnQnW28rL7CN33ZpXzf2lIpWTwbjnaEGrxfYM08uH6
	sy6lk2toyRgl8I3Q63yzKbOCtQamNVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717598447;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=atowc3f7IrAwqd5a+5vpkBZGm7Q8msOXF4I72q/jap8=;
	b=zp9/rEezGtN9P2QC0uoFNVbXklj4oBZHoI6Y5pEPaiI3WQ9yyu0ELMcUI8ItLvJC5APbjv
	pjLUlznuWsu7PVCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E305113A42;
	Wed,  5 Jun 2024 14:40:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Vej+NO54YGZBNwAAD6G6ig
	(envelope-from <iivanov@suse.de>); Wed, 05 Jun 2024 14:40:46 +0000
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: gregkh@linuxfoundation.org
Cc: cve@kernel.org,
	linux-cve-announce@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: RE: pwm: Fix double shift bug
Date: Wed,  5 Jun 2024 17:43:05 +0300
Message-Id: <20240605144305.78002-1-iivanov@suse.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2024052146-CVE-2023-52756-f694@gregkh>
References: <2024052146-CVE-2023-52756-f694@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3BB571F824
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-2.50)[97.72%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]

Hi,

I could argue that this is not CVE at all. It changes just bit positions.

-	PWMF_REQUESTED = 1 << 0,
-	PWMF_EXPORTED = 1 << 1,
+	PWMF_REQUESTED = 0,
+	PWMF_EXPORTED = 1,

ie. before fix they 1 and 2 and after the fix 0, 1.

All call sites are using set/test_bit() on unsigned long flags.

Yes, double shift do not look right, but I don't see how
this could lead to malfunction, let alone a CVE.

Regards,
Ivan


