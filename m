Return-Path: <linux-kernel+bounces-549060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3DAA54CB4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8BCA18986FB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D4B1311AC;
	Thu,  6 Mar 2025 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Uqfd4Xtj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="orX3S+bC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Uqfd4Xtj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="orX3S+bC"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5F2146A63
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741269411; cv=none; b=PNWCoIfw5zLbsg6eGuomQLB62XFrbfEPedPye5MmGLgEzD++VVsMmgYDCQ16i0wEKeJ/b5LNAlvOVmRwGYFGNALgVVh9pAo8g2wX72DSex7PdF2wBmgso4z84ySq9rqi85uQk4Wh1CyrITSJK2xHaHeStXCVAuSfXzNZ/ZPqA08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741269411; c=relaxed/simple;
	bh=Q3K1VHupNpSUTilZcUeuX43GI2eT1zNTcd8xfkxjs6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YfwQ8sLkpXmSIB73ZLQU5koJhu7QkeY+b3N8DH9GPVKP0XjpjU9fp5ZIeFJPiFbOlyAfuUknhFTsPRxP65kHDLwFNP7AL6mmu2lqPGualr3pkEsQ9NEwBdeyQtiAHpt8vFtemk6O8ux3JA6Fz475lAyMO5x241xQ5m4x6W58EaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Uqfd4Xtj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=orX3S+bC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Uqfd4Xtj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=orX3S+bC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 353A21F78B;
	Thu,  6 Mar 2025 13:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741269408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Kzl5mnhT2R/4sPjXbXDpEyhE5fuXsCx7EHyoayjeTg=;
	b=Uqfd4XtjfmUDvgJ3SaIqKZFEtpM/tSy/1719dU5HaNc0rnBvd1rxcoVQ/cad8PCinbcJB8
	5B+O/NdcZJhno7ZWZr49WPtT6lIp+5xrNudldZtKidECAky5EBEG1hTCJ0j88lf0zW71cI
	O2MGGKyeeivHpVESXCj/IMn+njbk9gA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741269408;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Kzl5mnhT2R/4sPjXbXDpEyhE5fuXsCx7EHyoayjeTg=;
	b=orX3S+bCvFawaw34RGbnNjSj2GIfQioTB1cArAiGtUCJdvJoDCNwbdUcOHrNupksaT/sZg
	Vwn9hfAJZ4X4V1Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741269408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Kzl5mnhT2R/4sPjXbXDpEyhE5fuXsCx7EHyoayjeTg=;
	b=Uqfd4XtjfmUDvgJ3SaIqKZFEtpM/tSy/1719dU5HaNc0rnBvd1rxcoVQ/cad8PCinbcJB8
	5B+O/NdcZJhno7ZWZr49WPtT6lIp+5xrNudldZtKidECAky5EBEG1hTCJ0j88lf0zW71cI
	O2MGGKyeeivHpVESXCj/IMn+njbk9gA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741269408;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Kzl5mnhT2R/4sPjXbXDpEyhE5fuXsCx7EHyoayjeTg=;
	b=orX3S+bCvFawaw34RGbnNjSj2GIfQioTB1cArAiGtUCJdvJoDCNwbdUcOHrNupksaT/sZg
	Vwn9hfAJZ4X4V1Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D8E113A61;
	Thu,  6 Mar 2025 13:56:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0YEHA6CpyWe8cgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 06 Mar 2025 13:56:48 +0000
Message-ID: <3ee33a2c-5370-4d79-9c73-9dcbe4078b7d@suse.cz>
Date: Thu, 6 Mar 2025 14:56:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] mm/mremap: refactor mremap() system call
 implementation
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn
 <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>
References: <cover.1741256580.git.lorenzo.stoakes@oracle.com>
 <6a62c1a4ea7f362b0685bbe3a2e74a47d24e5c43.1741256580.git.lorenzo.stoakes@oracle.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <6a62c1a4ea7f362b0685bbe3a2e74a47d24e5c43.1741256580.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 3/6/25 11:33, Lorenzo Stoakes wrote:
> Place checks into a separate function so the mremap() system call is less
> egregiously long, remove unnecessary mremap_to() offset_in_page() check
> and just check that earlier so we keep all such basic checks together.
> 
> Separate out the VMA in-place expansion, hugetlb and expand/move logic
> into separate, readable functions.
> 
> De-duplicate code where possible, add comments and ensure that all error
> handling explicitly specifies the error at the point of it occurring
> rather than setting a prefixed error value and implicitly setting (which
> is bug prone).
> 
> This lays the groundwork for subsequent patches further simplifying and
> extending the mremap() implementation.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


