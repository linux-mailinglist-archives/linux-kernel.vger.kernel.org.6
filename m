Return-Path: <linux-kernel+bounces-207601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 893E2901987
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419641C20E16
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 03:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C166FA8;
	Mon, 10 Jun 2024 03:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QLkV97PA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="thvJdHo5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="apNFq9F9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zHrQdBGC"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1903C30
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 03:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717989816; cv=none; b=eXns60Sq/NsgmL848zNyoCHXtQ0P5XQJywlBU029txhZguqwPeN0EEcsCtWhipkw72VZcVX7GBngIrlHHKa2z//tTHTsc6hO/oxIoLqlDQBU+YBiMW3jH27rh05YKYrJoGEtma8EROsXy07JRxhM5niMqTGAZop2L3EViL/Z228=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717989816; c=relaxed/simple;
	bh=leghjFkLfE8nb6GiCvJJxN+wDfpIOYb/kZ2GRb6XcKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrAGztQQe0ctB2BoF/0BwTAKrWgLtjAPWOGkT+XRXRiczzjsz2BFoU3Fs7357DLtz2jG36BGgNNEhSFFNu11icN+9Vs7aoy44qGa1VWoOV+UT7T/aMX52ixys/pn4cqcbnMD05DlVceoLL5hwyqSQSBKqp1A9AyTWDy2+LjgsJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QLkV97PA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=thvJdHo5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=apNFq9F9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zHrQdBGC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D1AA121A2B;
	Mon, 10 Jun 2024 03:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717989812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AqD74k7u9HQG0xtmAgthSPNxIjkcLobv3QHHDm49wY4=;
	b=QLkV97PADal9uWkBMvqGGipEu4TIz5O64viefpW4CMn/J97Wp/DkKizdfYRA6R0aXjTSZe
	x7Y3084fsj+inw1vM3xKkSX6e1w53+CcURgkbcugIBkPHwtzaknL51bh4xcevmbMlC4IpW
	iP5DhEvnhyvnGtpqotuBUAUH2hFpoMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717989812;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AqD74k7u9HQG0xtmAgthSPNxIjkcLobv3QHHDm49wY4=;
	b=thvJdHo5bNJp8IfUvfb8tJ5Re8751aTu7AMZU0bl3+i7IEV+FE3t5FxHD0ZsB1aSdZQ8So
	Gs/lSN0bLCyuhPAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=apNFq9F9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zHrQdBGC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717989811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AqD74k7u9HQG0xtmAgthSPNxIjkcLobv3QHHDm49wY4=;
	b=apNFq9F9XxwjCCiFspfNjiPR5JF1iO1tFQySz985BxE/5r23KRneHFfwtM4HWRhLjq9WHz
	JeJbAntgAnPXcH5YExLL8fXJqJJv0HZoEF0gxh5HKDoOYtIpW2zeVIl1QZF3p+KJtjkWjm
	JT7Cpyg+QY/uB9X/oULKJzj+eVjc2Kc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717989811;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AqD74k7u9HQG0xtmAgthSPNxIjkcLobv3QHHDm49wY4=;
	b=zHrQdBGCdM0Lxs7xhYGgHlxuL4B33pQK/YSDQbzlxgfkQ6vUYC61NreE/bbXnHe8P4nZ4g
	eLarRIY7bVL6EpCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8169813A85;
	Mon, 10 Jun 2024 03:23:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pCCXHLNxZma/CQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 10 Jun 2024 03:23:31 +0000
Date: Mon, 10 Jun 2024 05:23:26 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v1 1/2] mm/highmem: reimplement totalhigh_pages() by
 walking zones
Message-ID: <ZmZxrtGb4rDepBYv@localhost.localdomain>
References: <20240607083711.62833-1-david@redhat.com>
 <20240607083711.62833-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607083711.62833-2-david@redhat.com>
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D1AA121A2B
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,linux-foundation.org,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_FIVE(0.00)[5]

On Fri, Jun 07, 2024 at 10:37:10AM +0200, David Hildenbrand wrote:
> Can we get rid of the highmem ifdef in adjust_managed_page_count()?
> Likely yes: we don't have that many totalhigh_pages() users, and they
> all don't seem to be very performance critical.
> 
> So let's implement totalhigh_pages() like nr_free_highpages(),
> collecting information from all zones. This is now similar to what we do
> in si_meminfo_node() to collect the per-node highmem page count.
> 
> In the common case (single node, 3-4 zones), we really shouldn't care.
> We could optimize a bit further (only walk ZONE_HIGHMEM and ZONE_MOVABLE
> if required), but there doesn't seem a real need for that.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE Labs

