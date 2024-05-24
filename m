Return-Path: <linux-kernel+bounces-188776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC248CE6BE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3491A1C216ED
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D802412C47E;
	Fri, 24 May 2024 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hoCB6JU9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Au2a7eBm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hoCB6JU9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Au2a7eBm"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B544585933;
	Fri, 24 May 2024 14:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716560037; cv=none; b=nVlSk+T/9nu4AERgFgvDJ+cyGwIq1P8SdBZGmomszVmkBe1vIAIjB/NdVpUGnGnhz4yI65TZfYxjedcsM9GlRZu37VJePLNiKIDNeElzoaU4QKxDTA2NxyelqCJxbwywvNDMC9Cj0PdPkXlJePdG6+Mu8flAD3BoqlW7o2hT2uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716560037; c=relaxed/simple;
	bh=E5+8fyOw15iLM3lIB1Gmk2lZYVOBl+crVzUTt50b210=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPk+WcDOV+YbP+GGYk/MA8hVO/u/gF1KXFeTR62mjdmlCp9Mp4NFhZXs9hsEXisQQqm7wH86l/z5QzIHrZWFs2rpMM7Gw7fvhYwEIOhnUmEhtlJR5DKwvlcWKtjO/SRFPNurdamtHFappbT50FhZzpZGzVfWY1jJOHjB77jqHg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hoCB6JU9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Au2a7eBm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hoCB6JU9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Au2a7eBm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from localhost (unknown [10.100.12.32])
	by smtp-out2.suse.de (Postfix) with ESMTP id ABBFA20A94;
	Fri, 24 May 2024 14:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716560033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ENZk+YNrymrvrrD0I2MRl9n2PBLEnhCmMDbUSSQHsE=;
	b=hoCB6JU9XprYJdvuL8+l1iNbmT1ZYa1Rl5VRmYqZ0oS1KNS1EC1IJ8wJp1vSO/hvRptPz1
	S8EAzBSwXldgUqjrxj2QsbMl+eH0jp4MpyO53psZ0R2dXFuWThK9150jb9vDZrOhzM900H
	y9pH3EfD64HQ1lTur4u3nsgb7GzEZmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716560033;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ENZk+YNrymrvrrD0I2MRl9n2PBLEnhCmMDbUSSQHsE=;
	b=Au2a7eBmvLDVIBcZVVGbc+XGLHrRaIQIPCMaePnoTad5afSIwUqsgcrg/2VSin5J71GR9h
	PDXEX3hEV9NkHWBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716560033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ENZk+YNrymrvrrD0I2MRl9n2PBLEnhCmMDbUSSQHsE=;
	b=hoCB6JU9XprYJdvuL8+l1iNbmT1ZYa1Rl5VRmYqZ0oS1KNS1EC1IJ8wJp1vSO/hvRptPz1
	S8EAzBSwXldgUqjrxj2QsbMl+eH0jp4MpyO53psZ0R2dXFuWThK9150jb9vDZrOhzM900H
	y9pH3EfD64HQ1lTur4u3nsgb7GzEZmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716560033;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ENZk+YNrymrvrrD0I2MRl9n2PBLEnhCmMDbUSSQHsE=;
	b=Au2a7eBmvLDVIBcZVVGbc+XGLHrRaIQIPCMaePnoTad5afSIwUqsgcrg/2VSin5J71GR9h
	PDXEX3hEV9NkHWBg==
Date: Fri, 24 May 2024 16:13:53 +0200
From: Jiri Bohac <jbohac@suse.cz>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org
Subject: Re: CVE-2023-52823: kernel: kexec: copy user-array safely
Message-ID: <ZlCgoTr27AT_eg9A@dwarf.suse.cz>
References: <2024052106-CVE-2023-52823-3d81@gregkh>
 <ZlBlorsBMPK0RdnR@dwarf.suse.cz>
 <2024052420-clang-flatterer-366b@gregkh>
 <ZlCKLBjrF5PWt1hz@dwarf.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlCKLBjrF5PWt1hz@dwarf.suse.cz>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6]

On Fri, May 24, 2024 at 02:38:04PM +0200, Jiri Bohac wrote:
> On Fri, May 24, 2024 at 12:15:47PM +0200, Greg Kroah-Hartman wrote:
> > Nice, but then why was this commit worded this way?  Now we check twice?
> > Double safe?  Should it be reverted?
> 
> double safe's good; turning it into a CVE not so much :(
> CVE-2023-52822, CVE-2023-52824 and CVE-2023-52820, originally from the same patch
> series, seem to be the exact same case.

Same thing: CVE-2023-52758


-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


