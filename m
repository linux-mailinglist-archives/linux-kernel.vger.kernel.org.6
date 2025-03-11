Return-Path: <linux-kernel+bounces-556731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 210C1A5CE06
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DD63179C7D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076BF263F3E;
	Tue, 11 Mar 2025 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HdRTFug7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+V1ZquTL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hYIh7t9F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="i4EnicJ3"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8552620E5
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718420; cv=none; b=t6b95rStbSGsGmOIRaMKXq4uKzZ90L+1tdJFP4HtiMg07P0AqbrCoX+XckeW5tjN4EZzlgi5qKbGi2rQ2riDBrGwfssapwO+JzFPKClVRTZ5HS14nPV7fy78AtyuExPNtfMp/rnrMgnGpDWQvyd6OgijX+L0qWwC5QKiGD8Fi34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718420; c=relaxed/simple;
	bh=+TFLJOKq/fXDiZBXmt8JetSqXNQjhGuYqiXzs01lyss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9thkpCVB8Tde521yO9oaVH/1+Fg06gshyyHG5XkJQMUQIhB6ayb7/cxzFzEBo+j/GbsxVs6/GugAGuvlmrcVnPDlVEeX+CdsljpoKvA11fQR4fTeHSZ+i4I3S/jgKgvBeYC2pBCGbtzSFYGYP6mxOZ2m6xz0UmM+IXsQFaQrFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HdRTFug7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+V1ZquTL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hYIh7t9F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=i4EnicJ3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6763D21167;
	Tue, 11 Mar 2025 18:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741718416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ePYwVNIo3LVmt+1lPDZHlVtecaP5ZpafecglfDWrh3w=;
	b=HdRTFug7Re0zh4CZOf9AYDNAfcFCOhnQ5H0YIf+deHnLQjJ8K7MndIyllDfXsNNdfWNB17
	HfncKSDlWJBUsUdMuAW7l7sE+Kv19adi4CMMeFpH9//2wvzrHClqQIc/zd3aSEQSVbfrjv
	8TRjGu4e1wHqKAW3T8JmHujKo/9d9qk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741718416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ePYwVNIo3LVmt+1lPDZHlVtecaP5ZpafecglfDWrh3w=;
	b=+V1ZquTLua2i5OrC4anyFODs62z+ph1M8MDE4S0ZvcNTkIubzdUwZs0M8ZNqoTsviW+Tfc
	zfDjL/quod4JLSDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741718415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ePYwVNIo3LVmt+1lPDZHlVtecaP5ZpafecglfDWrh3w=;
	b=hYIh7t9FC+k0OPeEFABHu4p9NwQNS9zoXqUO+9D4+C/Hxqp7I6v20pXr/WiXR0tvCR1Zcm
	0aH1Cr10HlTQX4Y+ZaAxLqK1xapMuzbhWVZ3zFjaTMf+EWs3X+A+9jPnGaIJCZVFq9s7ut
	sCVtXw+qyo3SxB33ySQKAR0tbIAYuoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741718415;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ePYwVNIo3LVmt+1lPDZHlVtecaP5ZpafecglfDWrh3w=;
	b=i4EnicJ3z2Dj66QF/jn0Q42xfkgdohm/Cj0HgdlD5DLeZu9hDwzwwbWWwow4KX6jBLvSgw
	BCYeu2yeP9gz7eDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 127E8132CB;
	Tue, 11 Mar 2025 18:40:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3bJKA4+D0GePJwAAD6G6ig
	(envelope-from <jroedel@suse.de>); Tue, 11 Mar 2025 18:40:15 +0000
Date: Tue, 11 Mar 2025 19:40:13 +0100
From: Joerg Roedel <jroedel@suse.de>
To: Alexey Gladkov <legion@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>,
	=?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
	Joerg Roedel <joro@8bytes.org>,
	"Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>, Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <Z9CDjecpydOsRhUy@suse.de>
References: <b2e585a7-edd5-4b13-b904-3d0913177aee@suse.com>
 <20250310133833.GHZ87rWfuV6WgQTsoh@fat_crate.local>
 <Z878IRbbzIbUDQvj@example.org>
 <20250310151154.GOZ88BOinZVkbYEx0w@fat_crate.local>
 <104b6d4f-2848-42f4-a134-3373d12d9424@suse.com>
 <Z88Iv0w8_l9i7_8l@example.org>
 <Z9AFyG7798M4VNJQ@suse.de>
 <29fa0d10-0d3d-47a0-8832-b2c7fc04f637@suse.com>
 <20250311110748.GCZ9AZhPYYAz-MXErv@fat_crate.local>
 <Z9B_yS_d8ny9hYUX@example.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9B_yS_d8ny9hYUX@example.org>
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,suse.com:url]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Tue, Mar 11, 2025 at 07:24:09PM +0100, Alexey Gladkov wrote:
> On Tue, Mar 11, 2025 at 12:07:48PM +0100, Borislav Petkov wrote:
> > On Tue, Mar 11, 2025 at 11:22:23AM +0100, Jürgen Groß wrote:
> > > I can live with that, as long as we make it possible to make e.g.
> > > /sys/guest/xen a link to /sys/hypervisor (if xen is the hypervisor
> > > the guest is directly running on). This means that /sys/guest/*/type
> > > should not conflict with /sys/hypervisor/type.
> > 
> > Yeah, so Joerg and I came up with this on IRC:
> > 
> > /sys/hypervisor/{sev,tdx}
> 
> This directory is for guest-side information, right ?
> 
> > 
> > * It should not disturb the current hierarchy there
> > 
> > * No need for a new hierarchy like /sys/guest - we haz enough and besides,
> > /sys/hypervisor sounds like the right place already
> 
> The /sys/hypervisor is for host-side information ?

No, all under /sys/hypervisor is for guest-side information. There is
not directory for host-side information yet. The question is whether a
directory in SYSFS is needed, or whether there are other means to expose
the same information.

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

