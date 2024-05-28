Return-Path: <linux-kernel+bounces-191963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE72B8D16A9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E37282CA3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1303C13C3F4;
	Tue, 28 May 2024 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lfRrZi6O";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lfRrZi6O"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B358017579;
	Tue, 28 May 2024 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716886317; cv=none; b=lyW/ICIPqNZER8S1s5PzhsQD1m7zrCpPM0wKy928cCTv/T9ceyId8kP1xivoy3cgLtsjGPwSSyOQSQ9SODCXZxrFY1qW/3P/tdRVDZ4onSDP5DW82l4IMOLMdn3lfJYFn8/ogFCNwXufFo9c5xEPD9CTDSuymU1CNmHcb3uqCIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716886317; c=relaxed/simple;
	bh=S7ikE0htQsSrGnTr7qsQAYsEBAbPNGxm7ZCXgikJmZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6bcXSI9zfeglAMvaqD7wHLbb6vs4JL5gPzNIgGiiC/BmfUcq+A2D8zpDconi+wzzpJ/JAcKqrNgA5uxTeVo4e/6IgKc8F6sCtJRIGDCaf5hF/moK6p5UaomvwQNAuH4ZEbweGtiRyINB9qvyuZXjvhQSQ9C5/Uj5wiZrtXRg64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lfRrZi6O; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lfRrZi6O; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B4003201D9;
	Tue, 28 May 2024 08:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716886313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kt4MNglgqeU2blxMJ/lY93Og0sDSLSr/kWZ7uEkYdcw=;
	b=lfRrZi6Oug66VGr7HDyKUS1qP5Gqyd5jXS2AiLAHPdoeu6rKElfM3IUJvEGHneXqrZQ29T
	nHt78mShzF00z4uqoUfj1Vo4vEvmcriXiaqx7jH8oL6p8Qxj/VADu+mmmplpnLEa3FWipz
	U20IC2bwuvugQfe0o9QDUrDUG+AVYEs=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716886313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kt4MNglgqeU2blxMJ/lY93Og0sDSLSr/kWZ7uEkYdcw=;
	b=lfRrZi6Oug66VGr7HDyKUS1qP5Gqyd5jXS2AiLAHPdoeu6rKElfM3IUJvEGHneXqrZQ29T
	nHt78mShzF00z4uqoUfj1Vo4vEvmcriXiaqx7jH8oL6p8Qxj/VADu+mmmplpnLEa3FWipz
	U20IC2bwuvugQfe0o9QDUrDUG+AVYEs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F72413A6B;
	Tue, 28 May 2024 08:51:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dSsBICmbVWZUeQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 28 May 2024 08:51:53 +0000
Date: Tue, 28 May 2024 10:51:52 +0200
From: Michal Hocko <mhocko@suse.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2024-35802: x86/sev: Fix position dependent variable
 references in startup code
Message-ID: <ZlWbKDZh18KHTsgX@tiehlicka>
References: <2024051738-CVE-2024-35802-959d@gregkh>
 <b3a6ea47-8628-4edc-aee5-e5051955124a@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3a6ea47-8628-4edc-aee5-e5051955124a@suse.com>
X-Spam-Flag: NO
X-Spam-Score: -3.79
X-Spam-Level: 
X-Spamd-Result: default: False [-3.79 / 50.00];
	BAYES_HAM(-2.99)[99.97%];
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
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Thu 23-05-24 14:14:57, Nikolay Borisov wrote:
[...]
> I'd like to dispute this CVE since it doesn't constitute a security related
> bug. Sure, it might crash a SEV guest during boot but it doesn't constitute
> a security issue per-se.

Let me add analysis by Joerg here:
: This is not a security issue. The patch works around clangs compiler behavior
: where it inserts absolute references to kernel addresses. This breaks kernel
: boot because at the time this code runs the kernel still runs direct-mapped and
: needs to rely on RIP-relative addressing only.
: 
: Any breakage there would be detected at early boot of the kernel by a fatal
: crash, which can not be exploited. Also, our kernels are not compiled with
: clang, so from that perspective this is also not an issue for us either.

So this is a functional fix for clang builds.
-- 
Michal Hocko
SUSE Labs

