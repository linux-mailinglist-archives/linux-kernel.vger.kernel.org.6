Return-Path: <linux-kernel+bounces-173044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 070288BFAB5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 201AFB2300B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D66354679;
	Wed,  8 May 2024 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y9HdpBoE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mNQtBvwz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y9HdpBoE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mNQtBvwz"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8887C085
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 10:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715163210; cv=none; b=mIDjXIubDcC2NHab9TcY53zberlJsp1+yD9ZEMBHW/qBQfPNL1/roMhkHsS52SvQxIBnFACpoZZdy22q4LIZ2tiv6gFZd/HPo8jGBFaUsRfmb2bns26Vc55W5MFmjXRsl4eDMkC+hVHFMvAd+3IcKrTGqvdW6zw+dgCAm9Fbv+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715163210; c=relaxed/simple;
	bh=D+SeDU4f4kZ0YOm9XhwOgh4eP157dyE6CUIju7BjqXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUogXwnWRHgjnVRKFbKBdL2T56698MJbtfzVS2+mNUCyVqDL1BtSzbKpRjjXJuRCn7Kb55fcWsXmULDrl36zGx2jhbfZuq0IpjmcGiW0eo8pMroB7vkQQmAuI1y3VCk7TYBIAtN6dOyK1LT8uj0oPpq6uB4JlWJjWtNoCFPOP/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Y9HdpBoE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mNQtBvwz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Y9HdpBoE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mNQtBvwz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CA5F75C7CD;
	Wed,  8 May 2024 10:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715163206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KOPhKh5bbV4erWB3bpEEwxQJqvrW36xZvgOrjVCnVEM=;
	b=Y9HdpBoEBZND1blx1ILjE2bVefkOXqJVEqCjUbrYd2G6Equ+iXXFtrg9T/FW8ZB+KR59fu
	xGE1VWprGupuDCGElMZuY2G+MY/mvJ86bkMDXeVCKrHvrrQgB1Mni7THO/CT8O2Ut6jgEG
	5ANTQujXffsr2wWOCJ5QSPyl4Jt0ZF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715163206;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KOPhKh5bbV4erWB3bpEEwxQJqvrW36xZvgOrjVCnVEM=;
	b=mNQtBvwzds9UQ4mngCMyBuYS8l9H7cVUa+uyI4PZCop1Syv45kBzuqKOOGTBmzOyJyFMKB
	0bR/n2My7IP+WrAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715163206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KOPhKh5bbV4erWB3bpEEwxQJqvrW36xZvgOrjVCnVEM=;
	b=Y9HdpBoEBZND1blx1ILjE2bVefkOXqJVEqCjUbrYd2G6Equ+iXXFtrg9T/FW8ZB+KR59fu
	xGE1VWprGupuDCGElMZuY2G+MY/mvJ86bkMDXeVCKrHvrrQgB1Mni7THO/CT8O2Ut6jgEG
	5ANTQujXffsr2wWOCJ5QSPyl4Jt0ZF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715163206;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KOPhKh5bbV4erWB3bpEEwxQJqvrW36xZvgOrjVCnVEM=;
	b=mNQtBvwzds9UQ4mngCMyBuYS8l9H7cVUa+uyI4PZCop1Syv45kBzuqKOOGTBmzOyJyFMKB
	0bR/n2My7IP+WrAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B15F1386E;
	Wed,  8 May 2024 10:13:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X7RYE0ZQO2b1LQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 08 May 2024 10:13:26 +0000
Date: Wed, 8 May 2024 12:13:24 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Frank van der Linden <fvdl@google.com>
Cc: linux-mm@kvack.org, muchun.song@linux.dev, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH] mm/hugetlb: align cma on allocation order, not demotion
 order
Message-ID: <ZjtQRKtzwXN6VUx_@localhost.localdomain>
References: <20240430161437.2100295-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430161437.2100295-1-fvdl@google.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Tue, Apr 30, 2024 at 04:14:37PM +0000, Frank van der Linden wrote:
> Align the CMA area for hugetlb gigantic pages to their size, not the
> size that they can be demoted to. Otherwise there might be misaligned
> sections at the start and end of the CMA area that will never be used
> for hugetlb page allocations.
> 
> Signed-off-by: Frank van der Linden <fvdl@google.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Fixes: a01f43901cfb ("hugetlb: be sure to free demoted CMA pages to CMA")

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

