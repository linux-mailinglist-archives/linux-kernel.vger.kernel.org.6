Return-Path: <linux-kernel+bounces-564161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EC3A64F00
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C8FA188DB71
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8C22397B0;
	Mon, 17 Mar 2025 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BmwLtKkk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KkzKcQI8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NB+lTWxq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VkmEzqaV"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C544E22FF39
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742214961; cv=none; b=mp9iHmFh6VoWV02F8KY3y5oVAqR/WL4/m3W9qJAiCFXE0nlsemZ7IMtP7VZy2z30ZTvbWoU35emS2uPQXsX2eNfIk8h2muxJzmgI+PgEXj3HRLdThTcj4nezU3zezkPBPyPPI4o6i9LBvBgNL0qizqOBPnkNZWW4ddzKwPjvles=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742214961; c=relaxed/simple;
	bh=BduLESEt14qAYjvMDu4bBNsqylsCO8dE0ae1QKAQNdk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=e062jIcMvqAv1R7f0BPpSGIYN5zXaho1ytRe4/fcWTDMuIN6gG6H7k+NtnDdhyPP7rAr8zJ/sxOqMJU60H68LBLmZkyfEd9mvNcDOjcentFaZDPsEp5wrnlPR6zWS19iP1mtJAoSyvaZLk/ScsszVltMRohBo4CqX2U9GFmotsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BmwLtKkk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KkzKcQI8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NB+lTWxq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VkmEzqaV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E8AC52121F;
	Mon, 17 Mar 2025 12:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742214958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vs4DaU2bjg/xqSATgzKgwsLG8MPYB6tOnQxl2+mOLm4=;
	b=BmwLtKkkfPsCf8oZnMr5a34Lz2K0Jo8PPmzguiLqJSpmM21dr77w7JQdwTvvTknEKYYwdp
	UMwR8Vya92sLylF0tUNxWRdO/lPGGWTuoB268TaaJ8DfbvG4mjOENaJncu9Oq0ePsh5/D0
	/PWl6YrOPCTNwYrbD9QW6MXw6W/eqmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742214958;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vs4DaU2bjg/xqSATgzKgwsLG8MPYB6tOnQxl2+mOLm4=;
	b=KkzKcQI8CRlyEOJkLCMVK6fMwC9vaYhNOlz3Ff2tfZMQh17qibnngp7Ow9vedbDpTRfNdc
	KsEhUi5haCUGrzAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742214957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vs4DaU2bjg/xqSATgzKgwsLG8MPYB6tOnQxl2+mOLm4=;
	b=NB+lTWxqflBMt9hp2y89po34FvvWjEZbIn8aS1C8ZT7AlOMwKsyV/9gLQsqDZxPdIIbRUt
	g++O75lM+HD97E/AbuXfyBIGeUUv85fDXApZ1SpnYpxvC+eqHKJ16xRTklYO8fmb0WQoIO
	XhTInlrs+KqFaTsA/n9mXETJHcJ2GK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742214957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vs4DaU2bjg/xqSATgzKgwsLG8MPYB6tOnQxl2+mOLm4=;
	b=VkmEzqaVgvN3I59oUOLV96VP0rYO11rd3CGSVDuw+vn4+p9T3giwESaVFfQemNbkZ/Ofu9
	hrFpEABhbAcPETDA==
Date: Mon, 17 Mar 2025 13:35:58 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
    Peter Zijlstra <peterz@infradead.org>, 
    Brendan Jackman <jackmanb@google.com>, 
    Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 07/13] objtool: Consolidate option validation
In-Reply-To: <8f886502fda1d15f39d7351b70d4ebe5903da627.1741975349.git.jpoimboe@kernel.org>
Message-ID: <alpine.LSU.2.21.2503171335250.4236@pobox.suse.cz>
References: <cover.1741975349.git.jpoimboe@kernel.org> <8f886502fda1d15f39d7351b70d4ebe5903da627.1741975349.git.jpoimboe@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 14 Mar 2025, Josh Poimboeuf wrote:

> The option validations are a bit scattered, consolidate them.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M

