Return-Path: <linux-kernel+bounces-564306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BEBA6525C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C343F3B942A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FA123F439;
	Mon, 17 Mar 2025 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dWDelYiD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1eLhkirC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wq6rFTyY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O7rKO6a3"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9D454652
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220564; cv=none; b=ARaodXU+ZDEB28KbwTaHoFyqdarldsKdpWEsOPGcaR6SAMFHoZ7Vv4mmCMaXW1+DDVDvXTFSHXEc67xAokODpkqAZabNragaD8xD6pfeYFSp2BiwV7WUX83Q7LRXzRl8rv3MysNWQxPsGJtvllhfHg3FQiw0ccSLt9zXbHx1mfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220564; c=relaxed/simple;
	bh=MNw7UnBG+ygO0oIWosbuTBGCsuDhsvZNnmzDpKcdXmE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ECHAHKGqt3bgC+Yg4F0YfA3CTi8lPAeSReQlog9MORZE6KyF3k6U3xc2s/1nKkG/189iKIjePZJFmnRDZDU//TAew7WQRyC2ZoWyKQwJ0s0spV7+cW8e7Nuv0d4VXWCRATsD1yjxfgwSkl57KRLNuZBAIY5b6RTVtO0KAHtbdbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dWDelYiD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1eLhkirC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wq6rFTyY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O7rKO6a3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA52821BC8;
	Mon, 17 Mar 2025 14:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742220561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7mSIclVZV0URw7y1Fbp+WwCW0DPdbm1tY2NRXrH6VmQ=;
	b=dWDelYiDObi/zpxt2+w82Gn1MOq3zfqQe07TD2JIlkm5FzW/vxpQhkkHlPNRXPu4In23LR
	s6ZyMuXgqRkHQr8kQUf0zdPUMICSGuvwjLFqf4WpHektL1OVm0HcfkU5VcP3DTIfoe/y9Y
	MbsS3yAjJZ+JXqotxWAem//WF2aPyiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742220561;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7mSIclVZV0URw7y1Fbp+WwCW0DPdbm1tY2NRXrH6VmQ=;
	b=1eLhkirCcTsAlYjfHxsY/L1KKQ2OM2j3vgVzx8MuynIgozQaPCToCXBJ5tnBT3YEEguV35
	YXU6A+ZnK1lnd1AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742220560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7mSIclVZV0URw7y1Fbp+WwCW0DPdbm1tY2NRXrH6VmQ=;
	b=wq6rFTyYWrLItdXNqXhSUJUKINlPT4P5Zsi6bvX205cQEmwX/FHG5Xl8R+ithvDkHiS5/z
	6incE/6XysMxd5k10PSyzoHwOH2G16b0pjWbwsvCaLxiO7EwXLfrexClv/+Ux0N2DZ51kW
	hQE+PQafs/y1XiQqGOPncP7rZ9BSz2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742220560;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7mSIclVZV0URw7y1Fbp+WwCW0DPdbm1tY2NRXrH6VmQ=;
	b=O7rKO6a3om8oq3LGw18OcdwIn0twmKz8rJCI2gE5IGi9t/u4pgPDqKJ8LZsV+OU1xEo5vA
	IfkRFAr112e0KqAg==
Date: Mon, 17 Mar 2025 15:09:21 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
    Peter Zijlstra <peterz@infradead.org>, 
    Brendan Jackman <jackmanb@google.com>, 
    Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 12/13] objtool: Create backup on error and print args
In-Reply-To: <7571e30636359b3e173ce6e122419452bb31882f.1741975349.git.jpoimboe@kernel.org>
Message-ID: <alpine.LSU.2.21.2503171508590.4236@pobox.suse.cz>
References: <cover.1741975349.git.jpoimboe@kernel.org> <7571e30636359b3e173ce6e122419452bb31882f.1741975349.git.jpoimboe@kernel.org>
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
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 14 Mar 2025, Josh Poimboeuf wrote:

> Recreating objtool errors can be a manual process.  Kbuild removes the
> object, so it has to be compiled or linked again before running objtool.
> Then the objtool args need to be reversed engineered.
> 
> Make that all easier by automatically making a backup of the object file
> on error, and print a modified version of the args which can be used to
> recreate.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M

