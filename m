Return-Path: <linux-kernel+bounces-403866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CD99C3BFB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E416E1F212F0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C0B176ABA;
	Mon, 11 Nov 2024 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Dz+4af/d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="louDERMs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Dz+4af/d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="louDERMs"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6984A157E88
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 10:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321078; cv=none; b=Hk5qkWTeJD6Ot+kY8N0GbdOE12RqI2NA9ZjEtLKmaeS9z6Yly39kk2BPp6kPDmZ1cXR83xG5TCeOTnS1hIA8EJv8COoz7MdFO+i3enC0VpAgrMERK9jYB4i1Rf1zCzdeRdAiaPmoH4hyek4BsBAw3pnhHm5n4eRiAD+buNZzYvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321078; c=relaxed/simple;
	bh=Cyc3IPwGtaxueoMVpW08NpBzJnA7BqxYrCiyl5yf46I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p9Whfrp8pUJDz5bJRxj+P1Lc1c/tZaGByfmPhtjZLF/R3S9RDAYmgm71CWRaLc44CqPqaC7DAsBC/b5ygzRjlvsdG3PzIdG/DPFd8CvZa3DVpUOdnRCefqf6pa6c+3h178VW2U2oBsLAbawhHKtANB9GG9iXqiRyWNSz9ApLbvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Dz+4af/d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=louDERMs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Dz+4af/d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=louDERMs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
	by smtp-out2.suse.de (Postfix) with ESMTP id 719041F38E;
	Mon, 11 Nov 2024 10:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731321075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nfi7a58jU32D1+tZqSR1uyYTpo3a6Ot5dHSnFw3swqs=;
	b=Dz+4af/diseO0gevlrqmnutwAcUhTfiCz/BxXQTeID18P/+AQsxcWb6ua6GcOYs7q1RUfB
	wFWaQYHW0RUX1YFc1VzVn+VXEcxT7pxgVx9Lo/z1IyLAt7W85drf6n3Ek2AcNevgF96UQA
	rDdZU+sFCMJYjlM2FcLrkAo2PD2DaEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731321075;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nfi7a58jU32D1+tZqSR1uyYTpo3a6Ot5dHSnFw3swqs=;
	b=louDERMs0Kojt+RlAyOIpBV8mOMMXHEHQ/WCoMRRvgqNmYPcWCY0ONQte7njrst+NNSQKx
	oMuWqtH3JNfR4+DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731321075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nfi7a58jU32D1+tZqSR1uyYTpo3a6Ot5dHSnFw3swqs=;
	b=Dz+4af/diseO0gevlrqmnutwAcUhTfiCz/BxXQTeID18P/+AQsxcWb6ua6GcOYs7q1RUfB
	wFWaQYHW0RUX1YFc1VzVn+VXEcxT7pxgVx9Lo/z1IyLAt7W85drf6n3Ek2AcNevgF96UQA
	rDdZU+sFCMJYjlM2FcLrkAo2PD2DaEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731321075;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nfi7a58jU32D1+tZqSR1uyYTpo3a6Ot5dHSnFw3swqs=;
	b=louDERMs0Kojt+RlAyOIpBV8mOMMXHEHQ/WCoMRRvgqNmYPcWCY0ONQte7njrst+NNSQKx
	oMuWqtH3JNfR4+DQ==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
	id 6295F4A0564; Mon, 11 Nov 2024 11:31:15 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org,  =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>,
  Charlie Jenkins <charlie@rivosinc.com>,  Paul Walmsley
 <paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>,  Albert
 Ou <aou@eecs.berkeley.edu>,  Andrea Parri <parri.andrea@gmail.com>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: add forwarding header for
 arch/riscv/include/asm/fence.h
In-Reply-To: <26452229-7461-48aa-987a-28444ace4f28@ghiti.fr> (Alexandre
	Ghiti's message of "Mon, 11 Nov 2024 11:28:37 +0100")
References: <mvm5xq44bqh.fsf@suse.de>
	<d380fd10-ebc4-4d66-becb-13995372d41a@ghiti.fr>
	<mvmfrnyxg2n.fsf@suse.de>
	<26452229-7461-48aa-987a-28444ace4f28@ghiti.fr>
X-Yow: I want a VEGETARIAN BURRITO to go..  with EXTRA MSG!!
Date: Mon, 11 Nov 2024 11:31:15 +0100
Message-ID: <mvmbjymxdsc.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Level: 
X-Spamd-Result: default: False [-2.70 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_NO_TLS_LAST(0.10)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,rivosinc.com,sifive.com,dabbelt.com,eecs.berkeley.edu,gmail.com,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Score: -2.70
X-Spam-Flag: NO

On Nov 11 2024, Alexandre Ghiti wrote:

> Indeed, Bjorn's patches did not make it into rc7...

That needs to be fixed ASAP!

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

