Return-Path: <linux-kernel+bounces-339088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5983B986034
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A4F61C24A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947F119ABBF;
	Wed, 25 Sep 2024 12:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VscpGCZe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n5QO7BG/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VscpGCZe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n5QO7BG/"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1A215E5CC
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 12:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727268316; cv=none; b=c1FDgbtXclfOq67AosvJRz8dChdddnTGAeubw8lZkZwyiXjckZSZ0jA8FLD8+4kgvfUk8quGWLsfPm1XWGYsZn6kW/mIx9IE8ipdbSC7IySuBJhgkmCiO5rT1W81/Z0hxudedqsslcWyA4rPfP3vv1sZtS3keAD/80GzXQE0va0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727268316; c=relaxed/simple;
	bh=dQ89KBSvy6i9g2C9FRKnv3i8YMoGHNjZsyEpGFu4aTY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jpBMwSOYslMnVxHBxCO2apY8jbnQkhr5vIR6OWszBUQlfLATVGkOAGebIp4CH/FWZ+ZF6C57G+ItGKSZVXmZJF+TTh/N485y9sCZnlON1EEeslSgdoDbR0udR35ctmWd6aRwJOuJziByjJmsTqkUsRnVsOWHr25QfZjI8WtHdeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VscpGCZe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n5QO7BG/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VscpGCZe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n5QO7BG/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5C80A1F457;
	Wed, 25 Sep 2024 12:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727268312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4i/bZFuhhk2rN3QG7b1/ju2j/zwetIQIp2c8vpy0YaY=;
	b=VscpGCZeT3s8fF8Wg2Njj4zlLLsr79DVH1nRkpyExZQhel4T6t2V8a9FCGMC+jSFaeprpI
	DR7DM8DFdIH8/qX3mrth9ulmLYI4cM6ugWocK1q+uah0MVW3hnzEiBH594NVmQ8yh2htmw
	FphrANDyTTMdHh3dK+7q2zdBkSBv9x4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727268312;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4i/bZFuhhk2rN3QG7b1/ju2j/zwetIQIp2c8vpy0YaY=;
	b=n5QO7BG/6ZxjVd/KQhhFB0zJgJCpjRxNMMdFo50khmf/f7iWWTeKKsZli07eOY9UeBcgm+
	8xD8sID8Z2/5QAAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727268312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4i/bZFuhhk2rN3QG7b1/ju2j/zwetIQIp2c8vpy0YaY=;
	b=VscpGCZeT3s8fF8Wg2Njj4zlLLsr79DVH1nRkpyExZQhel4T6t2V8a9FCGMC+jSFaeprpI
	DR7DM8DFdIH8/qX3mrth9ulmLYI4cM6ugWocK1q+uah0MVW3hnzEiBH594NVmQ8yh2htmw
	FphrANDyTTMdHh3dK+7q2zdBkSBv9x4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727268312;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4i/bZFuhhk2rN3QG7b1/ju2j/zwetIQIp2c8vpy0YaY=;
	b=n5QO7BG/6ZxjVd/KQhhFB0zJgJCpjRxNMMdFo50khmf/f7iWWTeKKsZli07eOY9UeBcgm+
	8xD8sID8Z2/5QAAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F39B113793;
	Wed, 25 Sep 2024 12:45:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pw14OdcF9GYmTwAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Wed, 25 Sep 2024 12:45:11 +0000
Message-ID: <2a2df11ccb81dad5975bdf72a9c085fc8038ed84.camel@suse.de>
Subject: Re: [PATCH] eeprom: fix cacography of switch
From: Jean Delvare <jdelvare@suse.de>
To: "Dr. David Alan Gilbert" <linux@treblig.org>, liujing
	 <liujing@cmss.chinamobile.com>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, W_Armin@gmx.de, 
	hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Date: Wed, 25 Sep 2024 14:45:11 +0200
In-Reply-To: <ZvPrF9FRuY88aq3J@gallifrey>
References: <20240921103644.14667-1-liujing@cmss.chinamobile.com>
	 <ZvPrF9FRuY88aq3J@gallifrey>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[arndb.de,linuxfoundation.org,gmx.de,gmail.com,vger.kernel.org];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinamobile.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 2024-09-25 at 10:51 +0000, Dr. David Alan Gilbert wrote:
> * liujing (liujing@cmss.chinamobile.com) wrote:
> 
> As well as fixing the sign-off that Greg's script noticed, 
> I suggest changing 'cacography' to 'spelling'
> 
> 'Cacography' is a rare word - I had to look it up!

But it's a fun word! Made me laugh ^^


-- 
Jean Delvare
SUSE L3 Support

