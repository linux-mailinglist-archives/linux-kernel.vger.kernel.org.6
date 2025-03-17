Return-Path: <linux-kernel+bounces-564316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B445AA65296
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA571893DDD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C5424168D;
	Mon, 17 Mar 2025 14:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GfmTwChY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MjyKqYV+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GfmTwChY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MjyKqYV+"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9498D20322
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220869; cv=none; b=IIJ3MXF6+VUD7PGW78RcMEvPyvNPJSvprQHfcIRJxa+08H5MtohUg84UjuzdgXfULiP86anBn0LolY/h742sCw3qLD/sa0U76ecw7ZJctZTuxMJZawdBO1P67BtiqwR/jRHj1pRNpiBAAQteXJN1353ab30aVhzuyMzJc8+p2zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220869; c=relaxed/simple;
	bh=QVlWw1919MkP3HCZOyLZw3RUE/k0cg3+lw6S6q28Xkw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Vkr7FYis+C9tC4/peaCdN3pQW6/fhzxuk7MKaYwAOyBIoQ8ZwONL/V58RVZ0RYDTbNXu2e0OX0NB5HxOuSzY2d4QSuUZzT/F90+PhzttG7+NdiqAtOYtkWYjy/fuXXlP+SUdewJ/ykN2cIImNreig6xwNwl6q7RwHgqonht+DUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GfmTwChY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MjyKqYV+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GfmTwChY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MjyKqYV+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 81D8021BEC;
	Mon, 17 Mar 2025 14:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742220865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AQfDeJ75EOri6vsUUpPlKmxoLJNQZwJ+1oJNbDKNfY8=;
	b=GfmTwChYc3lHwM7jLKy/DZIPKhNI+0au+l1Yjgkn+fMKQaUDe3fe7gGHc1fJtyn5G5bqnN
	zZuxmKDk3TFme5IRHPwbyySsmQJ/ckyEf71XOX31yYbk9W+FyS9gQeF708kcrW8gmBFu+D
	dx2c8PgSpApsmaKpeLeXJFHLwLPPrRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742220865;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AQfDeJ75EOri6vsUUpPlKmxoLJNQZwJ+1oJNbDKNfY8=;
	b=MjyKqYV+Kv4sY6uS81wKTCB5PeO1SzpwW9ZvMsW75sz1OhbJd9Qs2461OinvQUITKOPHyg
	bcUl/evr1PlscEBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742220865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AQfDeJ75EOri6vsUUpPlKmxoLJNQZwJ+1oJNbDKNfY8=;
	b=GfmTwChYc3lHwM7jLKy/DZIPKhNI+0au+l1Yjgkn+fMKQaUDe3fe7gGHc1fJtyn5G5bqnN
	zZuxmKDk3TFme5IRHPwbyySsmQJ/ckyEf71XOX31yYbk9W+FyS9gQeF708kcrW8gmBFu+D
	dx2c8PgSpApsmaKpeLeXJFHLwLPPrRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742220865;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AQfDeJ75EOri6vsUUpPlKmxoLJNQZwJ+1oJNbDKNfY8=;
	b=MjyKqYV+Kv4sY6uS81wKTCB5PeO1SzpwW9ZvMsW75sz1OhbJd9Qs2461OinvQUITKOPHyg
	bcUl/evr1PlscEBA==
Date: Mon, 17 Mar 2025 15:14:25 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
    Peter Zijlstra <peterz@infradead.org>, 
    Brendan Jackman <jackmanb@google.com>, 
    Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 13/13] objtool: Add CONFIG_OBJTOOL_WERROR
In-Reply-To: <3e7c109313ff15da6c80788965cc7450115b0196.1741975349.git.jpoimboe@kernel.org>
Message-ID: <alpine.LSU.2.21.2503171513220.4236@pobox.suse.cz>
References: <cover.1741975349.git.jpoimboe@kernel.org> <3e7c109313ff15da6c80788965cc7450115b0196.1741975349.git.jpoimboe@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Fri, 14 Mar 2025, Josh Poimboeuf wrote:

> Objtool warnings can be indicative of crashes, broken live patching, or
> even boot failures.  Ignoring them is not recommended.
> 
> Add CONFIG_OBJTOOL_WERROR to upgrade objtool warnings to errors by
> enabling the objtool --Werror option.  Also set --backtrace to print the
> branches leading up to the warning, which can help considerably when
> debugging certain warnings.
> 
> To avoid breaking bots too badly for now, make it the default for real
> world builds only (!COMPILE_TEST).
> 
> Co-developed-by: Brendan Jackman <jackmanb@google.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Brendan's SoB missing.

With 'default y' being present or not

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

and fingers crossed.

M

