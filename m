Return-Path: <linux-kernel+bounces-555771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C27A5BC8C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09E3B3ACD94
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD8922DFA3;
	Tue, 11 Mar 2025 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xgprfeeH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lOYl09yA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xgprfeeH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lOYl09yA"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD95F22B590
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741686225; cv=none; b=UWqSmmCGJBNS3Yl5HR4u7QRBNhuIcH7trx4ni/eqdGfoAHYwKnF9ujtJAQL6tBF5rUwZp7A83V/DjhknJrGksRGZ3Yal5hcwhvbSq/bcd+vw6xfcC8cFXobz1KryaByJxZxwllj3GK3J0mqBcXOBvf+yybgjWQ4DWfTL3Plbsww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741686225; c=relaxed/simple;
	bh=xI/UtIlPq7MBhSKXy9iDfP/b3IfewPockHRToJ5rXqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4SPnNBrv3jztgBLvz0KJZgPa7foSTJ7nb5oi19Ns+ajeI6Zz19R5sLkcIV0jtcNh1ptV0xklsyrrCMDu+bFxpoGqB0OwtwGu4UjGvRbKHhHZw9OpGHAx7a2aeWG2OeGpYkiIqy6b5KUShGCiyZHwol6Yzoh78YxWfpFzkhcMQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xgprfeeH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lOYl09yA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xgprfeeH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lOYl09yA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B4E5921188;
	Tue, 11 Mar 2025 09:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741686221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Y20H1nGbdauYfEleBbODxTuDqnTmwSYfri+I2J3OVs=;
	b=xgprfeeHpPgBHFd8gjfIxghw/s8NvDFIHqa1Mo7dypKrxmXhFP0NXAWxiZya3WGxJBaNMO
	g++qZDffDFjrUBarW+2WURvjy9hniyHis6g8db2HGRWGFFrG5XG6jH7eXA7LN1yLKATyRo
	q645+qhqo7SZHu9pcmejyGuG4ad/a1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741686221;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Y20H1nGbdauYfEleBbODxTuDqnTmwSYfri+I2J3OVs=;
	b=lOYl09yABVsCLjtiHZRUJbA3fjJwwmUNDoae6p5jYLWHPKMEki3Cd8yT1r3iURVGl3xXtk
	lQyZEZ0jYxkCk4DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741686221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Y20H1nGbdauYfEleBbODxTuDqnTmwSYfri+I2J3OVs=;
	b=xgprfeeHpPgBHFd8gjfIxghw/s8NvDFIHqa1Mo7dypKrxmXhFP0NXAWxiZya3WGxJBaNMO
	g++qZDffDFjrUBarW+2WURvjy9hniyHis6g8db2HGRWGFFrG5XG6jH7eXA7LN1yLKATyRo
	q645+qhqo7SZHu9pcmejyGuG4ad/a1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741686221;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Y20H1nGbdauYfEleBbODxTuDqnTmwSYfri+I2J3OVs=;
	b=lOYl09yABVsCLjtiHZRUJbA3fjJwwmUNDoae6p5jYLWHPKMEki3Cd8yT1r3iURVGl3xXtk
	lQyZEZ0jYxkCk4DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E42C134A0;
	Tue, 11 Mar 2025 09:43:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9E3GFc0F0GcedwAAD6G6ig
	(envelope-from <jroedel@suse.de>); Tue, 11 Mar 2025 09:43:41 +0000
Date: Tue, 11 Mar 2025 10:43:36 +0100
From: Joerg Roedel <jroedel@suse.de>
To: Alexey Gladkov <legion@kernel.org>
Cc: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
	Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>,
	"Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>, Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <Z9AFyG7798M4VNJQ@suse.de>
References: <Z86-3n1-MArVLM9Z@8bytes.org>
 <Z87L0bRi8tcAIsDw@example.org>
 <e9d58d64-ab0f-49e8-ac87-c02bda6bc837@suse.com>
 <Z87ce37GjCqpOLCW@8bytes.org>
 <b2e585a7-edd5-4b13-b904-3d0913177aee@suse.com>
 <20250310133833.GHZ87rWfuV6WgQTsoh@fat_crate.local>
 <Z878IRbbzIbUDQvj@example.org>
 <20250310151154.GOZ88BOinZVkbYEx0w@fat_crate.local>
 <104b6d4f-2848-42f4-a134-3373d12d9424@suse.com>
 <Z88Iv0w8_l9i7_8l@example.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z88Iv0w8_l9i7_8l@example.org>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,suse.com:url]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Mar 10, 2025 at 04:43:59PM +0100, Alexey Gladkov wrote:
> If in the /sys/hypervisor we have information for guest (for running under
> a hypervisor), where do you propose to put the information for the
> host-side (for running as a hypervisor) ?

Okay, so let's not mix things up too much here. The only (upstream) case
where Linux _is_ the hypervisor is when running KVM guests. What
information needs to be provided for this case in SYSFS that is not
already provided elsewhere, e.g. by the KVM modules or, in case of SEV,
by /dev/sev? What does Intel expose for TDX?

Back to the guest-side, I agree with introducing a new directory in
SYSFS with sub-directories for each detected hypervisor. To maximise
confusion, it can be called '/sys/hypervisors/', or just /sys/guest/ (as
Boris suggested).

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

