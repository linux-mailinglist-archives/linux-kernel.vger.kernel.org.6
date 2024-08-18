Return-Path: <linux-kernel+bounces-290996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEA3955C0E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 11:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87EDE1C209E3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 09:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BA617C6C;
	Sun, 18 Aug 2024 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EDLgLuHs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1JNCmfcK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EDLgLuHs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1JNCmfcK"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971D617BBE
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 09:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723973251; cv=none; b=l59RjFMhzD93ipOYeIQoqKcm8q1iJS8PHMJTcQl+eJrZ6IR+F5HhemsyAhRWMkf+Z+bX92GsAJ5UbleAgA7i0B7f4mbNmQQ3Dcrs0bQOnzYftVo/Epm5xHp3FKMzM2clMvLeNTIsEFD30w68gF5niecVk4pkEXLTxgZMZ52fSxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723973251; c=relaxed/simple;
	bh=C5qjVSFLbHT633IyFecTCMNdeRzuse34+0Gq5GMtLrQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=pD1WLrUE10mSZl9GXi6P8sbGocPHncD5FNHs5ktqAFcj662dHc9GbuXlV8+PaDiO56++L/RNa0uG+DGFhIDQfvsYNjRY/wMLGQ3PtNt479vYKbF3JNTerxGJ3iF4Cg6k6ITZCF+pCNw58tBnNo+iJxfRfvF67L25ExqyZ+oEjIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EDLgLuHs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1JNCmfcK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EDLgLuHs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1JNCmfcK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C50C620307;
	Sun, 18 Aug 2024 09:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723973247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GZlmuodUzsffUpLSPtOBsk5LrJHVlHkQjDRo5YV6zYo=;
	b=EDLgLuHsdWLDblYrb0ZTK3vFVjfPgI1UKzOnYg0Mtcg6h7MAMldJDIMH44iYJV5cjjAz0b
	c3thFWvM6QG1E1OlqEUlBq+OG/OzTrVnu4mmKM9nbS6mHG0v+blD/xXNRRFLZI2keUTD1Y
	KZb1siTe+wNEFHIYbimPyB7mBWZZUnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723973247;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GZlmuodUzsffUpLSPtOBsk5LrJHVlHkQjDRo5YV6zYo=;
	b=1JNCmfcKSHsaXAUochvRqw54C3WljfKFNiYwm5SC54HLl84jLnnrklQyX50VzryO05CF43
	gktNjQxfYf4XEeCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723973247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GZlmuodUzsffUpLSPtOBsk5LrJHVlHkQjDRo5YV6zYo=;
	b=EDLgLuHsdWLDblYrb0ZTK3vFVjfPgI1UKzOnYg0Mtcg6h7MAMldJDIMH44iYJV5cjjAz0b
	c3thFWvM6QG1E1OlqEUlBq+OG/OzTrVnu4mmKM9nbS6mHG0v+blD/xXNRRFLZI2keUTD1Y
	KZb1siTe+wNEFHIYbimPyB7mBWZZUnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723973247;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GZlmuodUzsffUpLSPtOBsk5LrJHVlHkQjDRo5YV6zYo=;
	b=1JNCmfcKSHsaXAUochvRqw54C3WljfKFNiYwm5SC54HLl84jLnnrklQyX50VzryO05CF43
	gktNjQxfYf4XEeCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9B86136ED;
	Sun, 18 Aug 2024 09:27:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WaLXLH++wWZTWQAAD6G6ig
	(envelope-from <iivanov@suse.de>); Sun, 18 Aug 2024 09:27:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 18 Aug 2024 12:27:27 +0300
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: corey@minyard.net
Cc: minyard@acm.org, openipmi-developer@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi:ssif: Exit early when there is a SMBus error
In-Reply-To: <Zr+Up+94gmPEHwcJ@mail.minyard.net>
References: <20240816065458.117986-1-iivanov@suse.de>
 <Zr+Up+94gmPEHwcJ@mail.minyard.net>
User-Agent: Roundcube Webmail
Message-ID: <84eb700ee647cc40e9e99b086a8648e3@suse.de>
X-Sender: iivanov@suse.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Level: 
X-Spam-Score: -4.29

Hi,

On 2024-08-16 21:04, Corey Minyard wrote:
> On Fri, Aug 16, 2024 at 09:54:58AM +0300, Ivan T. Ivanov wrote:
>> It is pointless to continue module probing when communication
>> with device is failing. This just fill logs with misleading
>> messages like this:
> 
> So the BMC (or whatever is there) responds to a GET_DEVICE_ID command,

Well, not really. In cases where ssif_detect() returns -ENODEV, i2c core
i2c_detect_address() threat it as "We catch it here as this isn't an 
error”.
See i2c_detect_address().

> but then doesn't properly handle any other valid and mandatory 
> commands?
> And this device was added via ACPI or SMBIOS or device tree, almost
> certainly.
> 
> My comments are:
> 
> 1) This fix is wrong, because it may mask important things that need to
> be reported.
> 
> 2) Fix the source of the problem.  You can't expect software to
> compensate for all bad hardware and firmware.  I'd guess the firmware
> tables are pointing to something that's not a BMC.

I am not saying that hardware or firmware do not have its issues in this
case. But just as it is written now ssif_probe() is fragile. It continue
asking device for features ignoring that there is no valid SMBus 
communication.

> 
> 3) It appears the response to the GET_DEVICE_ID command, though a
> response is returned, is not valid.  The right way to handle this would
> be to do more validation in the ssif_detect() function.  It doesn't do
> any validation of the response data, and that's really what needs to be
> done.
> 

do_cmd() in ssif_detect() already do validation. Perhaps,
ssif_probe() should just not return ENODEV in case of error.

Thank you for your comments!

Regards,
Ivan

