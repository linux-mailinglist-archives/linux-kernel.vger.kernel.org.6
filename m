Return-Path: <linux-kernel+bounces-191544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1388D10E7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EBC1B21514
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC582748F;
	Tue, 28 May 2024 00:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KTCPaFEP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WrqU41HN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KTCPaFEP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WrqU41HN"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5493038D;
	Tue, 28 May 2024 00:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856389; cv=none; b=EGZ0AUx6JqvzjeOYF4Ml/RqtAceI9yWCuFjvGFdhK/6M3gLcCS62zF8fsJTL5PnlU3Dh70vPVL4Zgumn638rQX5mDgNj9PnrTwGEVYT3Eq9pEbMXVh0XdQapgwTrEyxtEbbqaaGPux00Z/1v8hILmNRsqHyagS0JYNoz/q+gM4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856389; c=relaxed/simple;
	bh=7clH/Iv4ClqYjilRnT04DvbFwWKh1zOKab598Eace5g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S1LLMweZGRNMDpv9KnRTMS9Fx9EpRq39qp75Mbe8b7YOeZpQUW725mJhf1G/wC0tWwHjou5BcBMhNPKZ8cbWiYG6QpzRWZt2iID2dMd37YbOZans0/zx7kZJK/a972I2W/EdQMO5pYjxqSsbfcMQo8kb3lSFD6sfBOoEG8/OZZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KTCPaFEP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WrqU41HN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KTCPaFEP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WrqU41HN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 24C6D223BA;
	Tue, 28 May 2024 00:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716856385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/ZAL6RZoWSx91cpX0WCzS5wAlhagkbg1LxuHIspcF2k=;
	b=KTCPaFEPgWvrWPcj6WfU2O8YvOP400K7+r8e3Zmkngx+9nQt10bIF1ycUWwG7v9va5tWtc
	idoiC99zjjRV7xaG4GX+gDDUb1knHLsIZCtQGiqEYlRcB6tnfkV1yan9VqRGjlMxUh03iK
	QG75MDvweQW3wQ5jPZZZ5qNqH1hSN14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716856385;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/ZAL6RZoWSx91cpX0WCzS5wAlhagkbg1LxuHIspcF2k=;
	b=WrqU41HNdhPPxYeCajyR0L9fo6TYILaUNUfgTK5pzpqXW8GYFsCk10G8hLR1+/63zIJz3U
	W+1GyztlKnZVICBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716856385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/ZAL6RZoWSx91cpX0WCzS5wAlhagkbg1LxuHIspcF2k=;
	b=KTCPaFEPgWvrWPcj6WfU2O8YvOP400K7+r8e3Zmkngx+9nQt10bIF1ycUWwG7v9va5tWtc
	idoiC99zjjRV7xaG4GX+gDDUb1knHLsIZCtQGiqEYlRcB6tnfkV1yan9VqRGjlMxUh03iK
	QG75MDvweQW3wQ5jPZZZ5qNqH1hSN14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716856385;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/ZAL6RZoWSx91cpX0WCzS5wAlhagkbg1LxuHIspcF2k=;
	b=WrqU41HNdhPPxYeCajyR0L9fo6TYILaUNUfgTK5pzpqXW8GYFsCk10G8hLR1+/63zIJz3U
	W+1GyztlKnZVICBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFA1713A6B;
	Tue, 28 May 2024 00:33:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vopSMEAmVWb8IAAAD6G6ig
	(envelope-from <krisman@suse.de>); Tue, 28 May 2024 00:33:04 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-cve-announce@vger.kernel.org,  <cve@kernel.org>,
  <linux-kernel@vger.kernel.org>, keescook@chromium.org
Subject: Re: CVE-2023-52685: pstore: ram_core: fix possible overflow in
 persistent_ram_init_ecc()
In-Reply-To: <2024051752-CVE-2023-52685-64c5@gregkh> (Greg Kroah-Hartman's
	message of "Fri, 17 May 2024 16:26:58 +0200")
References: <2024051752-CVE-2023-52685-64c5@gregkh>
Date: Mon, 27 May 2024 20:32:54 -0400
Message-ID: <87jzjeojwp.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Level: 
X-Spamd-Result: default: False [-4.27 / 50.00];
	BAYES_HAM(-2.97)[99.88%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Score: -4.27
X-Spam-Flag: NO

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> Description
> ===========
>
> In the Linux kernel, the following vulnerability has been resolved:
>
> pstore: ram_core: fix possible overflow in persistent_ram_init_ecc()
>
> In persistent_ram_init_ecc(), on 64-bit arches DIV_ROUND_UP() will return
> 64-bit value since persistent_ram_zone::buffer_size has type size_t which
> is derived from the 64-bit *unsigned long*, while the ecc_blocks variable
> this value gets assigned to has (always 32-bit) *int* type.  Even if that
> value fits into *int* type, an overflow is still possible when calculating
> the size_t typed ecc_total variable further below since there's no cast to
> any 64-bit type before multiplication.  Declaring the ecc_blocks variable
> as *size_t* should fix this mess...
>
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.

Hi Greg,

[Cc'ing Kees, who is listed as the pstore maintainer]

I want to dispute this CVE.  The overflow is in the module
initialization path, and can only happen at boot time or if the module
is loaded with specific parameters or due to specific acpi/device tree
data.  Either way, it would require root privileges to trigger.

-- 
Gabriel Krisman Bertazi

