Return-Path: <linux-kernel+bounces-563952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F0DA64AC1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125E01886159
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70312376ED;
	Mon, 17 Mar 2025 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KGPsqoIE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NNUVn0Gw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KGPsqoIE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NNUVn0Gw"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A441459F7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208464; cv=none; b=BPUUegobHbvFTsRxFiiFShQpvvBlhY0yAIfgsku5DQ8ag+b4n+6CMF8IsIqecUbCIiyMEJsj0ZXycqjP9+3myFOd4wD6SUV/LjMq59IXp+GQuOmgST2X4GqefI1H1gxhZVDHU7RHW5U2eRXG3n2M+HKWoV9vhNzZ+MGQNpC89hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208464; c=relaxed/simple;
	bh=ZerXAXmpDy6K4Ogkwe7J3dTkJ+y3uxbs/zAbktqBgyo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pF/cCiL0WqTmF/XzEf00psphvu2BvRcoXrOOItjvvFymQxxKTm0Gu7eVpaPQcjr6iIJW3xaNw5WMWQxYP2eTfqNgKWOGSl9f/WrBLrD7Hrtxb/jw1Y2gIxq/bcDKsrX48YXoYLssh1ltMjVDViK8UaoW1caXsD9KoMOGYNbNlTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KGPsqoIE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NNUVn0Gw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KGPsqoIE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NNUVn0Gw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E7759218F1;
	Mon, 17 Mar 2025 10:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742208460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CYZG1apzRGQlhURhtP3wA66cd8UelmuWL6SHPv4W7tg=;
	b=KGPsqoIE64fIKXBH66HCt1k2kWs+q8Y6g3ZpTQeMn67d5s3lHCzyr2SFpxZdOfn7bzbXp2
	TspQlNvCozlPVRuxEHhnCE8Qg8JprciKMe6LityoHR02ShuQAckIbLOLlSh2lynHzLT0o/
	sfEgpClhdzjremzZnk4bhJkFWlITtMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742208460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CYZG1apzRGQlhURhtP3wA66cd8UelmuWL6SHPv4W7tg=;
	b=NNUVn0GwxtS0VypIa75wNwEfjDZaKP8+J3ykpeTwlGkE8clzjOUuAEqRzQO00zPM3MHOKR
	i7LdAkgB/CNnRxDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742208460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CYZG1apzRGQlhURhtP3wA66cd8UelmuWL6SHPv4W7tg=;
	b=KGPsqoIE64fIKXBH66HCt1k2kWs+q8Y6g3ZpTQeMn67d5s3lHCzyr2SFpxZdOfn7bzbXp2
	TspQlNvCozlPVRuxEHhnCE8Qg8JprciKMe6LityoHR02ShuQAckIbLOLlSh2lynHzLT0o/
	sfEgpClhdzjremzZnk4bhJkFWlITtMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742208460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CYZG1apzRGQlhURhtP3wA66cd8UelmuWL6SHPv4W7tg=;
	b=NNUVn0GwxtS0VypIa75wNwEfjDZaKP8+J3ykpeTwlGkE8clzjOUuAEqRzQO00zPM3MHOKR
	i7LdAkgB/CNnRxDQ==
Date: Mon, 17 Mar 2025 11:47:41 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
    Peter Zijlstra <peterz@infradead.org>, 
    Brendan Jackman <jackmanb@google.com>, 
    Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 02/13] objtool: Fix error handling inconsistencies in
 check()
In-Reply-To: <0f49d6a27a080b4012e84e6df1e23097f44cc082.1741975349.git.jpoimboe@kernel.org>
Message-ID: <alpine.LSU.2.21.2503171147330.4236@pobox.suse.cz>
References: <cover.1741975349.git.jpoimboe@kernel.org> <0f49d6a27a080b4012e84e6df1e23097f44cc082.1741975349.git.jpoimboe@kernel.org>
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
	NEURAL_HAM_SHORT(-0.20)[-0.977];
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

> Make sure all fatal errors are funneled through the 'out' label with a
> negative ret.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M

