Return-Path: <linux-kernel+bounces-184639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9017B8CA9EC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B3452819B6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 08:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AD954762;
	Tue, 21 May 2024 08:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FM461mjd";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FM461mjd"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932B153E36;
	Tue, 21 May 2024 08:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716280126; cv=none; b=YKnrJTSbcbRwqtganBQ/5RA2rsf2G3hJ9OmpvmRQ/v3EcKJ95iIe/sEa98ZJkS5AtN2NSFIVL96gxX3gSloyvN+QI9vDYhj9WtH3pyznf2Vt92eGwetK8FYIBmnD7oK6NJS/UUAIMgdh31Nb/13ul3oChQqCc5QDXNfVajODImQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716280126; c=relaxed/simple;
	bh=+HBXBxjK0hn+einWaT80KqVILuPZatzwip9pfgsubls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWAUkn4wPmzjHkxgxkZCbsCZ1JwuHxD4krqj9OElYF0yEgoUpZamoGc1cJXYZlouQZONGoj5ZrMVR8GqwVBHvvt84JAX8X3NGikyvTgNuehSM9lvkYIA74kz8JlfIsOozf8lj/fgLTYGmWpeHlK4iuHthevafStyA8GXLYk+hvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FM461mjd; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FM461mjd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9BE792221E;
	Tue, 21 May 2024 08:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716280122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TNe2GfLUdarAV7Pjty0I9P1PpuGnzoPRECguTyu2x/k=;
	b=FM461mjdAusMoraBOxHjfkn7AqecV9yHs26Q+++I4apSt+XhgoCCzfrTfPsgPe7KnzM7Wr
	1FxTsZ8dg2UEAJQ5FMkoeSaBzvanVI/d4XtH0loQuihd83uVuFCWKgFgircvAVF1FeuWQ1
	3llZcB+lzPEzq4P09/BO2MluVbbyMEI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716280122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TNe2GfLUdarAV7Pjty0I9P1PpuGnzoPRECguTyu2x/k=;
	b=FM461mjdAusMoraBOxHjfkn7AqecV9yHs26Q+++I4apSt+XhgoCCzfrTfPsgPe7KnzM7Wr
	1FxTsZ8dg2UEAJQ5FMkoeSaBzvanVI/d4XtH0loQuihd83uVuFCWKgFgircvAVF1FeuWQ1
	3llZcB+lzPEzq4P09/BO2MluVbbyMEI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E0C113A21;
	Tue, 21 May 2024 08:28:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +61vHDpbTGZhdwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 21 May 2024 08:28:42 +0000
Date: Tue, 21 May 2024 10:28:41 +0200
From: Michal Hocko <mhocko@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-cve-announce@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2024-35906: drm/amd/display: Send DTBCLK disable message on
 first commit
Message-ID: <ZkxbObACcnUMZ3LA@tiehlicka>
References: <2024051954-CVE-2024-35906-1c6f@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024051954-CVE-2024-35906-1c6f@gregkh>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cve.org:url,imap1.dmz-prg2.suse.org:helo]

CVE-2024-35881 to revert f341055b10bd ("drm/amd/display: Send DTBCLK
disable message on first commit") by 3a6a32b31a11 ("Revert
"drm/amd/display: Send DTBCLK disable message on first commit"") has
been filed as well.

Is this really intentional? Should both be rejected?

On Sun 19-05-24 10:35:20, Greg KH wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> drm/amd/display: Send DTBCLK disable message on first commit
> 
> [Why]
> Previous patch to allow DTBCLK disable didn't address boot case. Driver
> thinks DTBCLK is disabled by default, so we don't send disable message to
> PMFW. DTBCLK is then enabled at idle desktop on boot, burning power.
> 
> [How]
> Set dtbclk_en to true on boot so that disable message is sent during first
> commit.
> 
> The Linux kernel CVE team has assigned CVE-2024-35906 to this issue.
> 
> 
> Affected and fixed versions
> ===========================
> 
> 	Fixed in 6.8.5 with commit 0dab75b433ed
> 	Fixed in 6.9 with commit f341055b10bd
> 
> Please see https://www.kernel.org for a full list of currently supported
> kernel versions by the kernel community.
> 
> Unaffected versions might change over time as fixes are backported to
> older supported kernel versions.  The official CVE entry at
> 	https://cve.org/CVERecord/?id=CVE-2024-35906
> will be updated if fixes are backported, please check that for the most
> up to date information about this issue.
> 
> 
> Affected files
> ==============
> 
> The file(s) affected by this issue are:
> 	drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
> 
> 
> Mitigation
> ==========
> 
> The Linux kernel CVE team recommends that you update to the latest
> stable kernel version for this, and many other bugfixes.  Individual
> changes are never tested alone, but rather are part of a larger kernel
> release.  Cherry-picking individual commits is not recommended or
> supported by the Linux kernel community at all.  If however, updating to
> the latest release is impossible, the individual changes to resolve this
> issue can be found at these commits:
> 	https://git.kernel.org/stable/c/0dab75b433ed2480d57ae4f8f725186a46223e42
> 	https://git.kernel.org/stable/c/f341055b10bd8be55c3c995dff5f770b236b8ca9

-- 
Michal Hocko
SUSE Labs

