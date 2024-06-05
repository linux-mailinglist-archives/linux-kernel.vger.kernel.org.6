Return-Path: <linux-kernel+bounces-202791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CE38FD11F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EEB8288987
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 14:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1D825601;
	Wed,  5 Jun 2024 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e6yTzOYM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hBMB+v/s";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e6yTzOYM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hBMB+v/s"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7118819D8AB;
	Wed,  5 Jun 2024 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717598959; cv=none; b=Viz0eS0sdXqQouCVeAekZjZeyQX0RNKSWaLd3k5OonsFz/Ix+GlV5z9lFiTabDzgSgcFAFObUFY7cGzHWShhcBQ4oXvLOk1aNBJOyskHLEvAPQkC4HuIXkr82YKYwpOM6kvS+IfE/nE3g8H6L2i1/yy+bZW2GPJdZw4MAvW7D1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717598959; c=relaxed/simple;
	bh=JI51xCKNXfnxhURIX3KOj0rmwuTxLiCCiq0F7SuZDxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CNwMferZ7yLEuMkVAKVBoiV5QvQPnGsFu76ES2ta0WA5OhsMu1qEXbRonDz8nlF/WJ9cSRVfIetYNhRgPKdQljUBy2dItrDYghk45ft5CVcXPn4wIRmAaGL89WbHTLi+0YNHe5eSsWDl5Z+sUVGzBGTuY94+gTDcQuQ3Bfc02Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e6yTzOYM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hBMB+v/s; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e6yTzOYM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hBMB+v/s; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A907F1F824;
	Wed,  5 Jun 2024 14:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717598956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dVugGptPtD6OX0Z91XnGX144xvMk6jvqh7BpCH/CGOY=;
	b=e6yTzOYMATV04amdTKq5lOqJCSPzNblm7dCqMOpUvqzZP1e5RceXSmkL8duaZ5uhvfbkEj
	AeZxxdNbTsH3ZiSYuKqkAHf0pXkIZi2Gh9QmVxjmQ76zxeTpxXD6va5BcTD36z0KOM7W6R
	P000yrbEgHG4Ofo2jsXG5m0ESIXBjcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717598956;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dVugGptPtD6OX0Z91XnGX144xvMk6jvqh7BpCH/CGOY=;
	b=hBMB+v/srXEq2KFa9faLmmk1x9bcRZgbZyARhWo5kmvSLdbpnBClVihE6YR0pJj06ruI0a
	NQz8Iyvi9NarbAAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717598956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dVugGptPtD6OX0Z91XnGX144xvMk6jvqh7BpCH/CGOY=;
	b=e6yTzOYMATV04amdTKq5lOqJCSPzNblm7dCqMOpUvqzZP1e5RceXSmkL8duaZ5uhvfbkEj
	AeZxxdNbTsH3ZiSYuKqkAHf0pXkIZi2Gh9QmVxjmQ76zxeTpxXD6va5BcTD36z0KOM7W6R
	P000yrbEgHG4Ofo2jsXG5m0ESIXBjcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717598956;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dVugGptPtD6OX0Z91XnGX144xvMk6jvqh7BpCH/CGOY=;
	b=hBMB+v/srXEq2KFa9faLmmk1x9bcRZgbZyARhWo5kmvSLdbpnBClVihE6YR0pJj06ruI0a
	NQz8Iyvi9NarbAAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B2C713A42;
	Wed,  5 Jun 2024 14:49:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B1agE+x6YGYOOgAAD6G6ig
	(envelope-from <iivanov@suse.de>); Wed, 05 Jun 2024 14:49:16 +0000
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: gregkh@linuxfoundation.org
Cc: cve@kernel.org,
	linux-cve-announce@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: RE: iio: adc: stm32-adc: harden against NULL pointer deref in stm32_adc_probe()
Date: Wed,  5 Jun 2024 17:51:23 +0300
Message-Id: <20240605145123.78220-1-iivanov@suse.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2024052159-CVE-2023-52802-81ce@gregkh>
References: <2024052159-CVE-2023-52802-81ce@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: 0.10
X-Spam-Level: 
X-Spamd-Result: default: False [0.10 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	BAYES_HAM(-0.10)[65.70%];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]

Hi,

I could we drop this CVE? 

of_match_device() can not return NULL in this case.

Even commit message agree on this:

" ... In practice there is no known reasonable way to trigger this, but
in case one is added in future, harden the code by adding the check ..."

Regards,
Ivan


