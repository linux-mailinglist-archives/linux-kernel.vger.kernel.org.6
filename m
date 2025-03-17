Return-Path: <linux-kernel+bounces-564189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B33CA64FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCDC218891AE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D9823ED6C;
	Mon, 17 Mar 2025 12:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dzCdsjVI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IHleJdvg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dzCdsjVI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IHleJdvg"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0225823C8D1
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215993; cv=none; b=CxMPj5Nw5p1Ve5XVvq2J8TlccjfsNEELxnrc+UNjYXUluF6A+RG2eHWPVOyL+95zTP3MA1kMhny5Sgf3S5nqM6zrjTm5XMwAD+ARPbbDKIusCYqOwm/AKJYc04+pqg9YYT5BJp4Zq38Hz5jHS9eYe5xpKljOomP4DYsHqLiEVPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215993; c=relaxed/simple;
	bh=3EZAx5nVQbEmbxHxOEIgu+zrRNJbaozapqGR2rf0Kj4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=at0VjLv+/Yg53qvWIaYaEvOV35fYOwQGnyHqAMyP0vEnHgdGgBxiJbaLqsUpNlM27xuQyO2aOwkclHk2FKIxpyOJGIuJVaZDWyHYFA80Y+MaIBx1CUd1b48IS8oRFZRkiY9kGfyFEDbHOgT7aJ1irx0PvMXwIWyeEQo9BcCxsu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dzCdsjVI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IHleJdvg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dzCdsjVI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IHleJdvg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 152EA21C18;
	Mon, 17 Mar 2025 12:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742215990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aGsH6QgIA++Fd8yvriC2jCRr27WERveOdOFTS8rRhts=;
	b=dzCdsjVI8c0DwvbAHOJv2/tCAxZMmaW6qlqXi2bY7wsSvU4vk1gKmn1odkzGL/q723Q8DO
	EHGmHGmVHxIfszLWrb6Z1DrWP8PSHndV3e8YP2PZEAMsbU99LFKYEcxUqGZCISzOroHVTX
	wWARUEhwpK/jZJVlUmevPDI9rJB6i9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742215990;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aGsH6QgIA++Fd8yvriC2jCRr27WERveOdOFTS8rRhts=;
	b=IHleJdvg4dYI3h+4HJH357WZmM0YgtkJx9IJtOaJPKHFPyiWOGwQoJT+bi0ozv4wpQj4ZI
	LMya98UQgE1wa+Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742215990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aGsH6QgIA++Fd8yvriC2jCRr27WERveOdOFTS8rRhts=;
	b=dzCdsjVI8c0DwvbAHOJv2/tCAxZMmaW6qlqXi2bY7wsSvU4vk1gKmn1odkzGL/q723Q8DO
	EHGmHGmVHxIfszLWrb6Z1DrWP8PSHndV3e8YP2PZEAMsbU99LFKYEcxUqGZCISzOroHVTX
	wWARUEhwpK/jZJVlUmevPDI9rJB6i9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742215990;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aGsH6QgIA++Fd8yvriC2jCRr27WERveOdOFTS8rRhts=;
	b=IHleJdvg4dYI3h+4HJH357WZmM0YgtkJx9IJtOaJPKHFPyiWOGwQoJT+bi0ozv4wpQj4ZI
	LMya98UQgE1wa+Cg==
Date: Mon, 17 Mar 2025 13:53:10 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
    Peter Zijlstra <peterz@infradead.org>, 
    Brendan Jackman <jackmanb@google.com>, 
    Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 10/13] objtool: Add --Werror option
In-Reply-To: <e423ea4ec297f510a108aa6c78b52b9fe30fa8c1.1741975349.git.jpoimboe@kernel.org>
Message-ID: <alpine.LSU.2.21.2503171352150.4236@pobox.suse.cz>
References: <cover.1741975349.git.jpoimboe@kernel.org> <e423ea4ec297f510a108aa6c78b52b9fe30fa8c1.1741975349.git.jpoimboe@kernel.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[pobox.suse.cz:helo,pobox.suse.cz:mid,suse.cz:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Fri, 14 Mar 2025, Josh Poimboeuf wrote:

> Any objtool warning has the potential of reflecting (or triggering) a
> major bug in the kernel or compiler which could result in crashing the
> kernel or breaking the livepatch consistency model.
> 
> In preparation for failing the build on objtool errors/warnings, add a
> new --Werror option.
> 
> [ jpoimboe: commit log, comments, error out on fatal errors too ]
> 
> Co-developed-by: Brendan Jackman <jackmanb@google.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Shouldn't be there also Brendan's SoB? I think these tags should always 
come in pairs.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M

