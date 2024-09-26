Return-Path: <linux-kernel+bounces-340816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE7998782F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7021C2185D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0797415B10E;
	Thu, 26 Sep 2024 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="suq9Iu35";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VkbNo08y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0592215A4B0
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727370825; cv=none; b=BKHAWcIUGeiXEPVzTZRimrrpBACgrVVITzi2tgdikKGb6TNyGJGCzgcQj1KGtAJixeQU0CD6bono7b4eVFVlFR7eg2xQsb6VaoqkxCVpakffrCeE33eUYr/KrbBUcKHn1WFDfxFSJ8tV4PWLv4IbsCn6ZoAaYHlYWCSRehrabWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727370825; c=relaxed/simple;
	bh=mWNKsYIWpxaogtNqsS6JvImdU0j79sOUoS0VnwfK5bI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DW2iZ609kaJdvxtl3GLRCB27lCVMckPKLViwn+5WUc748lFvBokzjZugVoBschnGrL1qxnE0pJfhoNfFoyE/KoQr4J54d/JprH8Zu13stZe/n8gq9gUo4/6UwUO6liSeFDDBG/FKKnHISLCGfsPuYbE2WXlftUJKaAvZqKGKqHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=suq9Iu35; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VkbNo08y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727370822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SmXKcRBnQIK8BbboNjLvPeXPPG+aoXFwXL972NcWxQY=;
	b=suq9Iu35jOkDGTU8Qk3ZlFY2a4SLYGgmcE6My6Pc0KyHAFjF9jWvYxFNJQE/hfecvLfLCy
	m+sXsOP2bsAwNmPY7wPRPwBPP8X2B3uwsBJX1h0Ji8goApIXYIfkBoosP7BJGZAWvx3Jco
	eaUrlQ31l/QS6//ljzoKv/MaBKHSctJyHQu98/VqPXZxs44sRRpUieeYdeQlmG5a9qyf+G
	oOUjPyDn14ONf+1NEkw9I6Nb/Jo2Z63yAMHLKVf6sHriC1Qld+zh67YSYkqV0ypZMckZTT
	W0pcp9QLMAr1pPDCQ1W4HDGv5ShuxcKRiNVZ1DvuV27EcaBrn7vbCRL8Q062fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727370822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SmXKcRBnQIK8BbboNjLvPeXPPG+aoXFwXL972NcWxQY=;
	b=VkbNo08ybE5luEGF7DH50WUm4nbzWd+YiBLc8X2CYfsuUdcxuibBJvFuM1MzCT7kLeykbL
	UZQu1nSL1bLEbsBA==
To: NeilBrown <neilb@suse.de>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Linus Torvalds
 <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7 v3] Make wake_up_{bit,var} less fragile
In-Reply-To: <20240925053405.3960701-1-neilb@suse.de>
References: <20240925053405.3960701-1-neilb@suse.de>
Date: Thu, 26 Sep 2024 19:13:41 +0200
Message-ID: <87a5fu2v96.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 25 2024 at 15:31, NeilBrown wrote:
>  this is a revised set of patches for cleaning up wake_up_bit and
>  wake_up_var and related.  They are the result of more proof reading,
>  and of trying to make use of the new interfaces anywhere in the kernel
>  where these interfaces are used.

Now I have two variants of a v3 patch set in my inbox. One with 7 and
one with 8 patches. Both sent within a couple of minutes....

Confused.

Thanks,

        tglx

