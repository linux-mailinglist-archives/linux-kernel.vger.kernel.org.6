Return-Path: <linux-kernel+bounces-265458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B0A93F18E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5DF61C20B93
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D131713E40D;
	Mon, 29 Jul 2024 09:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EEFvBQyg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S6CzZ6hF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C590A84FDF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246504; cv=none; b=gkpF9irrgnEvDTZRFzDLvLwdgyYmi8KSZI4SL3eiPRF7Ipalmmg21cvmDid0uURu+rLBeJi1OsEO6grKuud10AoFRUxp5lpmoId5AbCBe95KCZig/n5bX5GLsRNf56MzDOUcCQAG5kZXuGI65ef8hiW9igApOJGNn2N0qByjMmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246504; c=relaxed/simple;
	bh=jyQSrwETJrUYG7JZ3cfIb1oba3+qpqPrbWutSpX7N0Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qFLkwcbFXmIjxPiSTH3F7GRU3mT6h7JTSK0lv77wGJT+rAduX0bMK0swA4w/WOoUHcACAjXTje/+s324CPS+ULqVAgPMg7VsDbR5pA8POr0CfzbbSovrOWUGBmy1xHBfytV/CFPVFDOuhrsGlS8ITQZrTquOk89D61fvtEoL8eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EEFvBQyg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S6CzZ6hF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722246501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=scy5GNLyCVPvAA5J9VSYbLUa7zArNl9+ZZGGqimm8II=;
	b=EEFvBQygRPCgLIRplU+wxNf8jwrrzLG6bvHRLhOecqOg61a8Q1nHhmc8MD/Di6Cf3UmuZG
	8R9v1gHOXtQLvjjLLCWwvKbSbOtGGi1BZVbGxzpsFmgdSqaIvikNB7FceW2M+RkVOIct+3
	wBPH3n44u7q165icqKSufZsbTDX0cV8p8yvmFHC7btg2/Tse2zrRxdR+WM5d8F5l2WStgy
	XnFq4vbwA0Q1KF/mZRbHTL92CZm7wJel6xnmjBj23T1XbhoWTL7SFcK6cyOEYo1osYdZES
	w7M6F9+jUaU0mHK5XXP6LjV3Yegcy3VfmAUaba02fpbWy4rvfnMwNAf4/kx2iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722246501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=scy5GNLyCVPvAA5J9VSYbLUa7zArNl9+ZZGGqimm8II=;
	b=S6CzZ6hFuRuyLA44FkWP9NNK027WOf/jj85WiBcXcJd+Wko7CrOWicWH/Nj6sVAq4Oo1vL
	Zm+pf4BEDC2LsBCw==
To: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Zhou
 Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH] irqchip/gic-v4: Fix ordering between vmapp and vpe locks
In-Reply-To: <86y15k1wz3.wl-maz@kernel.org>
References: <20240723175203.3193882-1-maz@kernel.org> <875xsrvpt3.ffs@tglx>
 <86y15k1wz3.wl-maz@kernel.org>
Date: Mon, 29 Jul 2024 11:48:20 +0200
Message-ID: <87ttg88r6j.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 29 2024 at 08:25, Marc Zyngier wrote:
> On Fri, 26 Jul 2024 21:52:40 +0100,
> Thomas Gleixner <tglx@linutronix.de> wrote:
>> Confused. This changes the locking from unconditional to
>> conditional. What's the rationale here?
>
> Haven't managed to sleep much, but came to the conclusion that I
> wasn't that stupid in my initial patch. Let's look at the full
> picture, starting with its_send_vmovp():
>
>         if (!its_list_map) {
>                 its = list_first_entry(&its_nodes, struct its_node, entry);
>                 desc.its_vmovp_cmd.col = &its->collections[col_id];
>                 its_send_single_vcommand(its, its_build_vmovp_cmd, &desc);
>                 return;
>         }
>
>         /*
>          * Protect against concurrent updates of the mapping state on
>          * individual VMs.
>          */
>         guard(raw_spinlock_irqsave)(&vpe->its_vm->vmapp_lock);
>
> The vmapp locking *is* conditional. Which makes a lot of sense as the

Misread the patch ...

