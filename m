Return-Path: <linux-kernel+bounces-188609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E898CE44B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D75CFB2115B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C619F8612C;
	Fri, 24 May 2024 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oUbimOcp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oUbimOcp"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5168784E1C;
	Fri, 24 May 2024 10:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716546843; cv=none; b=sNqQNi1i1xukUCSvIejfiB+QoHriLjipPzHTmcQ7gYP29emlyhEuCR4HGYykuOq7VdegaynW67WW4Jydoq5+2N8M5XyKM+D3lrNoyMFmZeES48GKtMqvt4P6QMvm1kAnNPIxYGmqmHIPqGo9wSKeH1xdjk43uzPbn+r34pymtpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716546843; c=relaxed/simple;
	bh=voropSVgEZlD3t1sgEn3rPlZfsbWolOGFDe2M20xc2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyxf+ToRZyDAqqf5xvYz6lhY9O9VWMvCR7DenCeBuLKYmwB1sZ7RLI8rS9ivykVy97n7bqokbMIFVkakP2E/rPahPsyU0Zm//a5f8pGd6uNuSBgikrZK10xynqjVHaOiZ+vS9lEg4572OGQxI2Z4AN5o4rx6dJKmI1269rtZNVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oUbimOcp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oUbimOcp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5B7EC33950;
	Fri, 24 May 2024 10:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716546839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QxOonoGsk84HZlWNsyUNiAxulYAJKPkRmHkt9PJMTOY=;
	b=oUbimOcp0DpgzvCNXqKg6s4qNTvLFXj1Lf4sVSkIqPgxmY8J4oJROp2VkcYHTHYnEgAenL
	bO5S5OYxGT40/goI0sC2siIPA+r0dn/lpsdnzLwzXREO2CGcjTVLJUKH4/vzAE6cMuTGxO
	7C7ee6l50IwSUXd9mvLI721JhDjgpuA=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716546839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QxOonoGsk84HZlWNsyUNiAxulYAJKPkRmHkt9PJMTOY=;
	b=oUbimOcp0DpgzvCNXqKg6s4qNTvLFXj1Lf4sVSkIqPgxmY8J4oJROp2VkcYHTHYnEgAenL
	bO5S5OYxGT40/goI0sC2siIPA+r0dn/lpsdnzLwzXREO2CGcjTVLJUKH4/vzAE6cMuTGxO
	7C7ee6l50IwSUXd9mvLI721JhDjgpuA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D86E13A82;
	Fri, 24 May 2024 10:33:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mbT6CxdtUGYoGAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 24 May 2024 10:33:59 +0000
Date: Fri, 24 May 2024 12:33:50 +0200
From: Michal Hocko <mhocko@suse.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: zhengzucheng <zhengzucheng@huawei.com>,
	linux-cve-announce@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Jun.Ma2@amd.com, cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2024-26650: platform/x86: p2sb: Allow p2sb_bar() calls
 during PCI device probe
Message-ID: <ZlBtDovyQpIioBFS@tiehlicka>
References: <20240326175007.1388794-18-lee@kernel.org>
 <Zkz2qpUP-HVROO1I@tiehlicka>
 <da7e8c85-52fd-b2f4-83da-751f812de6ae@huawei.com>
 <2024052316-subtotal-fragrance-15e3@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024052316-subtotal-fragrance-15e3@gregkh>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Thu 23-05-24 15:51:38, Greg KH wrote:
> On Thu, May 23, 2024 at 04:50:18PM +0800, zhengzucheng wrote:
> > 
> > 在 2024/5/22 3:31, Michal Hocko 写道:
> > > This patch has been reverted in upstream by 03c6284df179 ("Revert
> > > "drm/amd/amdgpu: Fix potential ioremap() memory leaks in
> > > amdgpu_device_init()"") and based on the changelog the CVE should be
> > > rejected.
> > 
> > hi Michal Hocko
> > 
> > This reverted patch was previously used to resolve CVE-2024-35928 ?
> > 
> > so CVE-2024-35928 should be rejected?
> > 
> > 
> > commit 03c6284df179de3a4a6e0684764b1c71d2a405e2
> > Author: Ma Jun <Jun.Ma2@amd.com>
> > Date:   Tue Mar 19 15:24:03 2024 +0800
> > 
> >     Revert "drm/amd/amdgpu: Fix potential ioremap() memory leaks in
> > amdgpu_device_init()"
> > 
> >     This patch causes the following iounmap erorr and calltrace
> >     iounmap: bad address 00000000d0b3631f
> > 
> >     The original patch was unjustified because amdgpu_device_fini_sw() will
> >     always cleanup the rmmio mapping.
> > 
> >     This reverts commit eb4f139888f636614dab3bcce97ff61cefc4b3a7.
> > 
> >     Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> >     Suggested-by: Christian König <christian.koenig@amd.com>
> >     Reviewed-by: Christian König <christian.koenig@amd.com>
> >     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> 
> Yes, this should be rejected, I'll go do that now, thanks for pointing
> out the revert, we missed that.

yes, I meant this one indeed! Sorry about the confusion.
-- 
Michal Hocko
SUSE Labs

