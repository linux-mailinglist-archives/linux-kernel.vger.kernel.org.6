Return-Path: <linux-kernel+bounces-564201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB18AA6502D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87FF71886C3B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6F723C39A;
	Mon, 17 Mar 2025 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KSFZMo2C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AuudW1XH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b/SsGPN9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hjoNYyQL"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C858F5E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 13:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742216646; cv=none; b=MFlEmP/bg+RAJIQnNyn0y2/uTS6U7B7+hWO/A21u2KIR31yyuBxwcqWfVuRlD+686XNDEVmCepUOuUd1uJYvtY2BDyq34iK2PSYzHq+kzhXDGBuTrJKZqgQ7m31qN6UknR163InLugUedY24msfuh/D85HEYviNmF+q6Q9WQn2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742216646; c=relaxed/simple;
	bh=QJK8ijm5hOqBgDrLDzLf+CfEU/prs9FB2WajFUUyhsg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=axWjuiz78UYe66GOw93fUr0fe/YcXJYXH0rrO5KEHgcJMIWLU0Sh8c9OlKvxcO/TAKpQE7bmCXQNZeMxjbhbOLiLqt8k4Ei3K7HlSk66oW3YI2Aqv+mn7KU8yqE4pw4FWsMR0nOwVfNMN4XnjqtV2BhMxY1PK+QT0WZSffscY1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KSFZMo2C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AuudW1XH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b/SsGPN9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hjoNYyQL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F3C8721206;
	Mon, 17 Mar 2025 13:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742216643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0sEuen0bC8rf/5QoYodGmqk6k8gRlnVoJgSAywbjU94=;
	b=KSFZMo2ClECKgS93ynrQnjODqRTNmB+6i2LNAP/ftAz8c1QMfTd2A8eaPS/TGMKF3BtpNI
	Rt42oqYrKQ03fBKnYF0EOhtBKKjgZb19ME2nl0wbJ4tWSsUkSoqn0pff/nmsdKk8w1g7B6
	1sKToVitl6K/Z92X9Q9PnDQwiL3KZxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742216643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0sEuen0bC8rf/5QoYodGmqk6k8gRlnVoJgSAywbjU94=;
	b=AuudW1XHOv4bvUxoa/d+bAp+bHj2fsLmRGYxlQrndbMu3jVVA/lDkdaO5bb2ChIhaMt1z+
	IvAAx1P65qu+cICg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742216642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0sEuen0bC8rf/5QoYodGmqk6k8gRlnVoJgSAywbjU94=;
	b=b/SsGPN9bPJvgY2HS8ESvxMnRmWJyiToF0/0h6QHH80hsFM6V3b/PWm64wzfnhxrmxU/94
	s/cpI55I0/jSmquWzdJ/8G/zOTTlPbFxqIpcco+25KxGc34O1wcy1xwyN8+ZdG6hV00B0A
	5MP7t8fCa6oNSYpU3Ozh2vDr20twfAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742216642;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0sEuen0bC8rf/5QoYodGmqk6k8gRlnVoJgSAywbjU94=;
	b=hjoNYyQLz5orSKLhZYuvmQixWDzOj/iwUtw8r/Z+Jq5D4DbUGM4sFP8Q6oyTH9Dm2k48kt
	H6sxrzWKb8nOjwAg==
Date: Mon, 17 Mar 2025 14:04:02 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
    Peter Zijlstra <peterz@infradead.org>, 
    Brendan Jackman <jackmanb@google.com>, 
    Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 11/13] objtool: Change "warning:" to "error:" for
 --Werror
In-Reply-To: <56f0565b15b4b4caa9a08953fa9c679dfa973514.1741975349.git.jpoimboe@kernel.org>
Message-ID: <alpine.LSU.2.21.2503171403520.4236@pobox.suse.cz>
References: <cover.1741975349.git.jpoimboe@kernel.org> <56f0565b15b4b4caa9a08953fa9c679dfa973514.1741975349.git.jpoimboe@kernel.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[pobox.suse.cz:mid,pobox.suse.cz:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 14 Mar 2025, Josh Poimboeuf wrote:

> This is similar to GCC's behavior and makes it more obvious why the
> build failed.
> 
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M

