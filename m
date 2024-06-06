Return-Path: <linux-kernel+bounces-203787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 945E98FE07E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25DDD2830C0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B2A13AD3A;
	Thu,  6 Jun 2024 08:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sD4HM3/C";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ANU3BTgb"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A037346A;
	Thu,  6 Jun 2024 08:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717661043; cv=none; b=Zfa6adfwI4M77+oiGrw2HIEqrkip+HgOw7iDGvI36kNecmJREiiaKOTqrqNOqXuTgFwmlgfGygj//H4kgfylat6JrndtCa3Rl+JDBvOEHXaPZQXRfLch0Hh9hhifVVwaF4jahdWaXG0pbdqL91MFodVwtHKGDYYo+5ncKBH5gt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717661043; c=relaxed/simple;
	bh=NP3gYYn+IyvRoQFk/MsYWjRdkIg4206ZK2DrojwRXSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjfWSo33ITjvDRkSYhw7hdlUbTAG/W6Z4v6Vnata5kxS2kkDrptghemIh5pYP3GIBRyWkCJCsoOMlPSM6lS75WXOW1xuC7h+RBPOU9umd6qnBwspR7pk8vP07lKLVbqtPe9qhN8QHu5kTHSxNlxjtH2zO5dO2Lq4a4/Mo/H58Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sD4HM3/C; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ANU3BTgb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0796C21995;
	Thu,  6 Jun 2024 08:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717661040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tTHGfApC6UGvkBSFwR0S2rb0j81XAR+UlZvJw4X7AsU=;
	b=sD4HM3/Cq588EjNZ4RGLcDtZmEEmq44pUjBqdNYvunYx7DCyQuPrBYLPt02CCZsz1ZpgDv
	zhvi154DsvYczUDZXt2G02kdPu+EveWO7TWZdH7Fy/g1fEJ+pcr6a70bgyyPDqpP2IiZnI
	6BqHYqEBbqJ5V5RN8zfxgVWSyPzRmO0=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ANU3BTgb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717661039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tTHGfApC6UGvkBSFwR0S2rb0j81XAR+UlZvJw4X7AsU=;
	b=ANU3BTgbUr0lMCz4EaaYnY1lvrXJOtgPyej5DkEThmhO4NJP1dJ4BYFa4X2vsann91yNbx
	x1ShnAUk4y3GHTzy91SwRpM6vR85cRp9a/FB3w+PueLML6ZUZxvXC9RneiVlSrVQBR0kb5
	s8fA/s7Nuf3dfax3wI01RRS5RGx954I=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DEACE13A1E;
	Thu,  6 Jun 2024 08:03:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6FALM25tYWaaWwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 06 Jun 2024 08:03:58 +0000
Date: Thu, 6 Jun 2024 10:03:54 +0200
From: Michal Hocko <mhocko@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>
Cc: linux-cve-announce@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2024-35840: mptcp: use OPTION_MPTCP_MPJ_SYNACK in
 subflow_finish_connect()
Message-ID: <ZmFtaijTs6mOpB5B@tiehlicka>
References: <2024051756-CVE-2024-35840-99fa@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024051756-CVE-2024-35840-99fa@gregkh>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0796C21995
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim]

Hi,
what is the actual security threat here? As far as I can see, the
problem that the commit requested here addresses seems to be rather
functional, rather than responding to an unexpected packet options with
a reset, we actually establish a connection with some garbage parameters
(likely unpredictable). Which is unfortunate but I do not see any
security implications.

On Fri 17-05-24 16:27:13, Greg KH wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> mptcp: use OPTION_MPTCP_MPJ_SYNACK in subflow_finish_connect()
> 
> subflow_finish_connect() uses four fields (backup, join_id, thmac, none)
> that may contain garbage unless OPTION_MPTCP_MPJ_SYNACK has been set
> in mptcp_parse_option()
> 
> The Linux kernel CVE team has assigned CVE-2024-35840 to this issue.
> 
> 
> Affected and fixed versions
> ===========================
> 
> 	Issue introduced in 5.7 with commit f296234c98a8 and fixed in 5.15.148 with commit 413b91350732
> 	Issue introduced in 5.7 with commit f296234c98a8 and fixed in 6.1.75 with commit 51e4cb032d49
> 	Issue introduced in 5.7 with commit f296234c98a8 and fixed in 6.6.14 with commit ad3e8f5c3d5c
> 	Issue introduced in 5.7 with commit f296234c98a8 and fixed in 6.7.2 with commit 76e8de7273a2
> 	Issue introduced in 5.7 with commit f296234c98a8 and fixed in 6.8 with commit be1d9d9d38da
> 
> Please see https://www.kernel.org for a full list of currently supported
> kernel versions by the kernel community.
> 
> Unaffected versions might change over time as fixes are backported to
> older supported kernel versions.  The official CVE entry at
> 	https://cve.org/CVERecord/?id=CVE-2024-35840
> will be updated if fixes are backported, please check that for the most
> up to date information about this issue.
> 
> 
> Affected files
> ==============
> 
> The file(s) affected by this issue are:
> 	net/mptcp/subflow.c
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
> 	https://git.kernel.org/stable/c/413b913507326972135d2977975dbff8b7f2c453
> 	https://git.kernel.org/stable/c/51e4cb032d49ce094605f27e45eabebc0408893c
> 	https://git.kernel.org/stable/c/ad3e8f5c3d5c53841046ef7a947c04ad45a20721
> 	https://git.kernel.org/stable/c/76e8de7273a22a00d27e9b8b7d4d043d6433416a
> 	https://git.kernel.org/stable/c/be1d9d9d38da922bd4beeec5b6dd821ff5a1dfeb

-- 
Michal Hocko
SUSE Labs

