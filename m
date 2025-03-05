Return-Path: <linux-kernel+bounces-546950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC8FA50116
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2660118916C5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E65F1591E3;
	Wed,  5 Mar 2025 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r9+I4QfB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4g5at+CI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r9+I4QfB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4g5at+CI"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355BC5228
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182612; cv=none; b=ddDn5w7pINoiVHZSJLd6w6Py7/KEZiE7q4cCaB5/mjDMxE50q5mykcizCR6s7nsd1xTPl2AXbytgymrDMqzA+epA23Add7Ahlr6wrIrAvzu5MjV/lGHt1TPn/+zmbMdi2x0NLIv5HDzZ11srv1ESaxlsnVddT2Xo5SwN8W067Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182612; c=relaxed/simple;
	bh=bjt9tZ2tdXOXmOh5Sw2/IQfSK8Z1N8A0v424PK7WQJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BR/JeAtHXq3/O2aSZWdy+93bV4l+0EyrX7tMelpj69XSHxbvqCMpstfjNIbl6mC6WThPG2WE+FM7yue1WmqoYOgN0IS7vsKPM4sZFornHLWRlHB0wY3XMqb52rWfr1PquAjyKoSje/juYoeSojSZcAJNoX5sOb6UaRWa0mWUf+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r9+I4QfB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4g5at+CI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r9+I4QfB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4g5at+CI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 45FB6211A0;
	Wed,  5 Mar 2025 13:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741182609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pt57O7QxbgvWtfgO/L+BQo09K7eD75rcFiR0x5kH3Xs=;
	b=r9+I4QfBHqoqitpKz5iJ9FFQJIIbv0X1kh1zqARFO0OPcmUtUR5r9vCOeLlcKLp0I5mTEa
	hY1R/ILkGuioZlIqVEEyT28ZKh6NVjnv1Qq9z/LKR6MKsn1T3ZOlh5jmOxwSUqAbECKTzt
	vWDijno35d/6plaN6V7dZbaHi0HvwUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741182609;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pt57O7QxbgvWtfgO/L+BQo09K7eD75rcFiR0x5kH3Xs=;
	b=4g5at+CIp6BjfjhtCpyQJw+EY6QdT7+pe5/d1mHcczE52f9Jy0glg+zU7GXNF8kWI8xH8I
	sb9+Z6YNwQl+jgCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=r9+I4QfB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4g5at+CI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741182609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pt57O7QxbgvWtfgO/L+BQo09K7eD75rcFiR0x5kH3Xs=;
	b=r9+I4QfBHqoqitpKz5iJ9FFQJIIbv0X1kh1zqARFO0OPcmUtUR5r9vCOeLlcKLp0I5mTEa
	hY1R/ILkGuioZlIqVEEyT28ZKh6NVjnv1Qq9z/LKR6MKsn1T3ZOlh5jmOxwSUqAbECKTzt
	vWDijno35d/6plaN6V7dZbaHi0HvwUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741182609;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pt57O7QxbgvWtfgO/L+BQo09K7eD75rcFiR0x5kH3Xs=;
	b=4g5at+CIp6BjfjhtCpyQJw+EY6QdT7+pe5/d1mHcczE52f9Jy0glg+zU7GXNF8kWI8xH8I
	sb9+Z6YNwQl+jgCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1660D1366F;
	Wed,  5 Mar 2025 13:50:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id isRFBJFWyGfSRAAAD6G6ig
	(envelope-from <jroedel@suse.de>); Wed, 05 Mar 2025 13:50:09 +0000
Date: Wed, 5 Mar 2025 14:50:07 +0100
From: Joerg Roedel <jroedel@suse.de>
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <Z8hWj5yDc-CsIv9L@suse.de>
References: <20250305105234.235553-1-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250305105234.235553-1-joro@8bytes.org>
X-Rspamd-Queue-Id: 45FB6211A0
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,suse.com:url];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Wed, Mar 05, 2025 at 11:52:34AM +0100, Joerg Roedel wrote:
>  arch/x86/coco/sev/core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

And here are the changes to the snpguest tool to make use of the sysfs
as created with this patch:

	https://github.com/virtee/snpguest/pull/88

I plan to update the PR as this patch changes.

Regards,

-- 
Jörg Rödel
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Frankenstraße 146
90461 Nürnberg
Germany
https://www.suse.com/

Geschäftsführer: Ivo Totev, Andrew McDonald, Werner Knoblich
(HRB 36809, AG Nürnberg)

