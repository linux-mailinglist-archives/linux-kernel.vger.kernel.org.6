Return-Path: <linux-kernel+bounces-564183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4886A64FAF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1ED33B18D7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C7C236A84;
	Mon, 17 Mar 2025 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UNuMep/j";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FBdRfIp+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vhKu5r4c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b6gff4vq"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE024222594
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215730; cv=none; b=H29l7inIED3j0GJ4WtSrzomjASZXs9Q7VEXZ1NV67f2w575+6aYlXRuFp56K5WWG+hlPq6EjhNEgf06B/nEXEy+gCdrOwu79TQPRWhf+4DNHA3Pz/z9zO+7ozjOThDx2bDEZmF/d0h5l0u2tYXTjA74bqLaimWLNO2IbUTckGJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215730; c=relaxed/simple;
	bh=OkMulsM/cx7fBZxAWko6B9e5uWQM+rwz2mkNJEmQ9uQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VWQjszNzTO1Gc8dGvoqNjK3CA91AZOr5fF4hQhDu094LknE3wD8Ps9AuuopydH3rNZYIXsStPiB4j0XSHKiT46C7hAgtAw1NEadrqFJEwX0cDgsqoQ9KO9hMou8f4vdKtLfnkDAwsiHPytJdRFH8Zckrx3yXqxlwq5JEQTbR/a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UNuMep/j; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FBdRfIp+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vhKu5r4c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b6gff4vq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D86F121209;
	Mon, 17 Mar 2025 12:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742215727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jxMRh+HKZycxxIczcxBBPpKquapYaTO+NvLoRdwKnD8=;
	b=UNuMep/jLh8vTSG5kLKOXYydDAgccHmiyiNdhEiINPUY1yHJHgXeyhqv7qpxtKNh2jHcdE
	R3rUAOIEH7ctusoZyXEfasWB75BDeNZ9yd9LqJH165DMG2PgzLm8qohhMzOLMFLM0l9cu+
	xyxpPgMgaZ1YI0r20dfaX2cxclBUOow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742215727;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jxMRh+HKZycxxIczcxBBPpKquapYaTO+NvLoRdwKnD8=;
	b=FBdRfIp+qXd7yUVsXzAEIeCDxZWOJkTZhWeS331e+ul3gZyVcOFIbOp0ZXkPW5tZh50r+h
	YPrT4+BYTkRfXSBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742215726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jxMRh+HKZycxxIczcxBBPpKquapYaTO+NvLoRdwKnD8=;
	b=vhKu5r4cE0P8toE4gLQQY5/uACrVnL2x9JLCtVx7W1zkon4aRtmuDHvzJUeEyZ/ENHZPTh
	rKtiKQnilWGRvCElJ5YB2VBxzIPNHhKVFND1uHVe9awvpVLMeRu9gdPPgoL3KZ2zmAMWvD
	JYbD4xqVDru336hpnodSKsMw8MrG8ik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742215726;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jxMRh+HKZycxxIczcxBBPpKquapYaTO+NvLoRdwKnD8=;
	b=b6gff4vqD8GOKlqObzyLvLwQPziefnjnhqHeScK0ayLbGk3CQrIlaul070MrQ8ForlSjRa
	RW2G9fDSHhIAALAg==
Date: Mon, 17 Mar 2025 13:48:47 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
    Peter Zijlstra <peterz@infradead.org>, 
    Brendan Jackman <jackmanb@google.com>, 
    Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 09/13] objtool: Add --output option
In-Reply-To: <0da308d42d82b3bbed16a31a72d6bde52afcd6bd.1741975349.git.jpoimboe@kernel.org>
Message-ID: <alpine.LSU.2.21.2503171348250.4236@pobox.suse.cz>
References: <cover.1741975349.git.jpoimboe@kernel.org> <0da308d42d82b3bbed16a31a72d6bde52afcd6bd.1741975349.git.jpoimboe@kernel.org>
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Fri, 14 Mar 2025, Josh Poimboeuf wrote:

> Add option to allow writing the changed binary to a separate file rather
> than changing it in place.
> 
> Libelf makes this suprisingly hard, so take the easy way out and just
> copy the file before editing it.
> 
> Also steal the -o short option from --orc.  Nobody will notice ;-)
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M

