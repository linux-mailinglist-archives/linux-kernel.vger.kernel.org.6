Return-Path: <linux-kernel+bounces-184831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FC58CACA8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 12:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAB801F22CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5832274414;
	Tue, 21 May 2024 10:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z+lHHegZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Bon4G70g";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z+lHHegZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Bon4G70g"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092445674A
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716288698; cv=none; b=KqaTP9/5TQ0LkHmDyBiOnNTQBi8VMK4qiYbydDD7R+jYW/PkwqVNXXBw6R3xGcotCpbuoH8Dh7LMIJ5rU53v51NNnIv8XK8lur79t3PZyCnCfOJPSuN72hCHJhFxquQ9+SSrtBn7iMC+rhkN5MuzHAMsDrPHtrXSNlRDLWsfZTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716288698; c=relaxed/simple;
	bh=4Kx7WXARIW9MSU6q7eJuCa5sRur+0LgvIET+O3hB6nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzBUNjKyqLE1Fv3U/9ghNQPR/Vqw7ZApYMfQguNyBwfW9wTkhPSPnzJ2hmPtWOBVTbmIJ2QL8SstQOreXHW4E3HYIKJ8OgC1wWD/9D8hC0pqfheGaucGADmuoraTvkUuOLPejXZ8XiCWDxngvOiKT97gijommXynCekklWJVVt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z+lHHegZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Bon4G70g; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z+lHHegZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Bon4G70g; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 88D2E3402E;
	Tue, 21 May 2024 10:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716288691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z3Td21Nb/lca1rU44g3R9277/UsQFL4lej+k+yXEDEk=;
	b=Z+lHHegZSQ4W23K+LKRA3yg9ZAiT/NjuRK59CeguCXFWStXaUI/WM2mGXIMIKDCo9oH/w0
	OpijWjAxpFgiVEZcf8SbF60C8XOFBzdAimww3+Ar3fnPZDDIgkk576shbMugQ7kMryNkKq
	Dl4MIIVqqW545/qID36jmCQiQEHmYTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716288691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z3Td21Nb/lca1rU44g3R9277/UsQFL4lej+k+yXEDEk=;
	b=Bon4G70gnMgLKIEJyZMk0mT4znXDbzETwGZ/MxttgI+7z8/RAQ4joaCE2R15Mp7QoHxuGK
	wrrMYMvGapEPXgAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716288691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z3Td21Nb/lca1rU44g3R9277/UsQFL4lej+k+yXEDEk=;
	b=Z+lHHegZSQ4W23K+LKRA3yg9ZAiT/NjuRK59CeguCXFWStXaUI/WM2mGXIMIKDCo9oH/w0
	OpijWjAxpFgiVEZcf8SbF60C8XOFBzdAimww3+Ar3fnPZDDIgkk576shbMugQ7kMryNkKq
	Dl4MIIVqqW545/qID36jmCQiQEHmYTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716288691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z3Td21Nb/lca1rU44g3R9277/UsQFL4lej+k+yXEDEk=;
	b=Bon4G70gnMgLKIEJyZMk0mT4znXDbzETwGZ/MxttgI+7z8/RAQ4joaCE2R15Mp7QoHxuGK
	wrrMYMvGapEPXgAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20B7F13A1E;
	Tue, 21 May 2024 10:51:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id riBOBbN8TGaNEwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 21 May 2024 10:51:31 +0000
Date: Tue, 21 May 2024 12:51:25 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, vishal.moola@oracle.com,
	muchun.song@linux.dev, peterx@redhat.com
Subject: Re: [PATCH] mm/hugetlb: remove {Set,Clear}Hpage macros
Message-ID: <Zkx8rW-HvlzCND04@localhost.localdomain>
References: <20240520224407.110062-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520224407.110062-1-sidhartha.kumar@oracle.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,oracle.com:email,suse.de:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Mon, May 20, 2024 at 03:44:07PM -0700, Sidhartha Kumar wrote:
> All users have been converted to use the folio version of these macros,
> we can safely remove the page based interface.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs

