Return-Path: <linux-kernel+bounces-557936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A49A5DF89
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108CB189835E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B963124BD14;
	Wed, 12 Mar 2025 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vzdk7Fxe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tK3ELAQo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VRfa15/M";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ue3lXUSB"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F24323F384
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741791427; cv=none; b=RO/5Pbn4NQKNiKatQpE4iq53R+eTKt8KQQpPxLMDU4jAgjO00RFUTsAUTCdj9DlVqIdOsSIsF2E1fxumJRxqbUuESXBB/rIujAaZrEBb/S6MtAWHFQthqyKjPU22RwamXzPFIJV+4UW4jlGxFEOTQv4GdwI20iF3oA9VdEm6+L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741791427; c=relaxed/simple;
	bh=qHK1pvTnjQuUNj0yF9vF6zbZ8YwKYOmQRS2ETLXbCHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acLG77IyLDkzkDFHpSyDeBjLcnHmtiCkqkNmuNQL6MAIlVbEhwgjHInEMGZDQC6tr+9ykiVeL7Y+wtBinIaSpS/7STW3LigFDzESaag5TSQ4nZkEu7sTobrMDicsK9WAdJeAycNFumpaNeG7ArXHX3ioRhdgjJw+JbCO0CS3iVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vzdk7Fxe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tK3ELAQo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VRfa15/M; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ue3lXUSB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF3B51F443;
	Wed, 12 Mar 2025 14:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741791423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xeHbIyEiYm4gCpoHtdXexIbUDHvJnmMPkDkWRGfF9IY=;
	b=Vzdk7FxeGEiUjuIIR/NYhVPp3HoRIwO5u0Y89T7o7NIbxslhY3NkSgELgeeuNWe0pGlsSw
	KrQ5rdT2gjWt5vd+V+10dL8aMEdl839NVgHSZU2wNLJ8+/bQd6iJQlcRozJwyEUInUSD9z
	Lyp1UMVGDhmKIL1TpYIQfDJEVnonBRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741791423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xeHbIyEiYm4gCpoHtdXexIbUDHvJnmMPkDkWRGfF9IY=;
	b=tK3ELAQoQxembhrdw0bHTFKcOow7c3Xyc39/pYlJaFXZwqe22KVxW37JEAx80GOMS1BkX2
	smZSWWO6NNGbxVCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741791422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xeHbIyEiYm4gCpoHtdXexIbUDHvJnmMPkDkWRGfF9IY=;
	b=VRfa15/Ma9garSWHFVnwbMMhj/Tt4U7YSGQ9QojXjJd6LLcUQ26hZMSe3io5uYhvD0yvyx
	2ITURYXH58crc0YjZQgL6mvRN8caajhny6hLTF+X9VvqESGASNichzl/J4u0x2sWiaIniN
	Jw4BKKKIhoS7LrBmJbkg9T3AvAPv2Cs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741791422;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xeHbIyEiYm4gCpoHtdXexIbUDHvJnmMPkDkWRGfF9IY=;
	b=Ue3lXUSBc4bCkeEG4ZK0rAxs2uK07jNJ6pxWTl72LQx3WPTkDWkxgpxYoS8xUboMbdV98x
	8Mu60E2GqmuhhBBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A021132CB;
	Wed, 12 Mar 2025 14:57:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u0mpGL6g0WcCAgAAD6G6ig
	(envelope-from <jroedel@suse.de>); Wed, 12 Mar 2025 14:57:02 +0000
Date: Wed, 12 Mar 2025 15:56:57 +0100
From: Joerg Roedel <jroedel@suse.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com,
	Nikunj A Dadhania <nikunj@amd.com>, Larry.Dewey@amd.com,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Juergen Gross <jgross@suse.com>, kirill.shutemov@linux.intel.com,
	alexey.gladkov@intel.com
Subject: Re: [PATCH 2/2] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <Z9GguXasI5AaLMKv@suse.de>
References: <20250312144107.108451-1-joro@8bytes.org>
 <20250312144107.108451-3-joro@8bytes.org>
 <8d58b03e-9017-c800-4379-f2a667fb8a9b@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d58b03e-9017-c800-4379-f2a667fb8a9b@amd.com>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

Hi Tom,

On Wed, Mar 12, 2025 at 09:46:45AM -0500, Tom Lendacky wrote:
> On 3/12/25 09:41, Joerg Roedel wrote:
> > +static ssize_t sev_status_show(struct kobject *kobj,
> > +			       struct kobj_attribute *attr, char *buf)
> > +{
> > +	return sysfs_emit(buf, "%llx\n", sev_status);
> 
> Should it be prefixed with '0x'? That would make use of functions like
> atoi() and strtol() easier.

Yes, it probably should. Currently I see just a '7' in the file, which
gives no clue about the used base. I will change that in the next
version.

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

