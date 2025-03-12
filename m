Return-Path: <linux-kernel+bounces-557955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC15A5DFC6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72D718996D1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038E2156F5E;
	Wed, 12 Mar 2025 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AplTCqYk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SnHIz0QK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WI4LBhDJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D7XUBvxW"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16C0142659
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792087; cv=none; b=L70qjfsydLpDlgDhAVDKoe1JD/y0O+p8exrcR7Iuyra1uii3W+mh3vtBImoP45NF3ZuhC15rrBY8bEZfBPQ/+JPDq3LqAnC+g44hni+w/LiR6Rsw2+iXxXdX5pH0+afWqtdpAU+kocAjhEQ42fGanuQIvhhxVOVWwR1c8m3Iq60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792087; c=relaxed/simple;
	bh=wc8JbAP3PIt3Azoy9npzTYy9TnFtAoQqRXYhKLUUSbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYha6ieSGabNL9qv6HU96pI9MxQhbqpHAEg5zzJrA/H+qx9+SEvj6C1DkMJEJ+Y9vvU6Z0dhHYnoKkvVClKNle3r3q8vhSdioiCBbowDROfHt1ISrZresVTi4D3nyUZESTARUheqpjUOUhM0eGxmiKIEbkkG7bVwPpgZ7QYd5uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AplTCqYk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SnHIz0QK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WI4LBhDJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=D7XUBvxW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E9FE71F394;
	Wed, 12 Mar 2025 15:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741792082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C7b3OyWlr6XkYpJCgvuDRuD07UMukpDEgYsj61ygyFw=;
	b=AplTCqYkvL3DrhCJ0K4JRDsu0dBB/mwLwd+eMB+w2IkkBL9DhBEFkW+6oTSXKt/OvehcrM
	pQzQ0OOhTynPDc+72IjuvZIPx3JoyIGy9a+lI6+56lNIlrLLD6u76h4H9VNPQPdudQ4ZwR
	lPD1eIiqbZl/Sq24IYYaFG9XnhGz5A4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741792082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C7b3OyWlr6XkYpJCgvuDRuD07UMukpDEgYsj61ygyFw=;
	b=SnHIz0QK2y397iZAS9xI9+Ct8BseEn+I66mvSPWGqpcG1/2YBRpfNfFyamro0UJ2ER2HC3
	6+lXrZ7iUbA8kWDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741792077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C7b3OyWlr6XkYpJCgvuDRuD07UMukpDEgYsj61ygyFw=;
	b=WI4LBhDJk4kQMJS8DHrFvUv6cj9RAkycOIM/OO0M2dPIYTWoKavBeBMVw4vhz8AfjtBist
	scbGx/6uYutASd4JnBpbnr/BsVgWo0GapT/xUWnVajJ5Y1CsIjhLu+9iIWa1UMeKj7ricU
	Lk+nWWabB6RbEd/AvyBJZ9XE7+TPJnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741792077;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C7b3OyWlr6XkYpJCgvuDRuD07UMukpDEgYsj61ygyFw=;
	b=D7XUBvxWYkgkPdEGGiL7U26j0zBMZLSYRYnl1UAo0Dfmce6JrkqsLBA3JijRHsbfhoYPh2
	tFAlQzCxr/Y9K2CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EDFB13A91;
	Wed, 12 Mar 2025 15:07:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id is+XJU2j0WfvBQAAD6G6ig
	(envelope-from <jroedel@suse.de>); Wed, 12 Mar 2025 15:07:57 +0000
Date: Wed, 12 Mar 2025 16:07:56 +0100
From: Joerg Roedel <jroedel@suse.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Larry.Dewey@amd.com,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Juergen Gross <jgross@suse.com>, kirill.shutemov@linux.intel.com,
	alexey.gladkov@intel.com
Subject: Re: [PATCH 2/2] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <Z9GjTBHBqXenCWYx@suse.de>
References: <20250312144107.108451-1-joro@8bytes.org>
 <20250312144107.108451-3-joro@8bytes.org>
 <ef3f3117-6cd5-4b94-8ddb-e6d224efac60@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef3f3117-6cd5-4b94-8ddb-e6d224efac60@intel.com>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[suse.de:server fail];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:url,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

Hi Dave,

On Wed, Mar 12, 2025 at 07:57:31AM -0700, Dave Hansen wrote:
> Do we really want to just plumb the raw MSR out to userspace? Users
> would still need to parse the thing, so it's not _really_ human readable.

I agree that this is not really human readable. On the other side SYSFS
is more an interface targeted for tools than optimized for human
readability (see the one-datum-per-file rule).

The actual use-case (and the reason for these patches) of the sev_status
file is to provide a better and more secure interface than /dev/msr to a
tool named snpguest.

A human readable form of this can be added as well, if needed. There is
already a line in dmesg with the decoded features.

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

