Return-Path: <linux-kernel+bounces-572936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A9FA6D08A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 19:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0258B16C22D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 18:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67451482E8;
	Sun, 23 Mar 2025 18:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XkNggL/t"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD80819644B
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742753715; cv=none; b=mvW41ji8hBM/TcxBeUbSDLjVB1qMtlxQclRDLLvMj5BV2XiHhoQEMWOODS2cnS5ZfXhwHz05Q5wpRSpti5agOtWzfM4gvGZtfgpDbFroZlXYOwgQ7Q1/N15a3bJfVJxD5LFnbxvzOLT+aPwaE3TGPCWTuwwDfMQiqqv91k3FjRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742753715; c=relaxed/simple;
	bh=gVA3JCX04/vCsbB4HcDlaTmKquk3ta8AlG6E4Wkbm/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpvJgUe53c4BMaqPGy1nnTbp8h7BygrgPUSF31YuaU0pst8ouTQaCMCG1/7CKjmAYNyNJam/K5ijeJYNKFOVABidWsN8ox8WhWNTe9TcA3a7GvHmxCd70mGyfWY3urCVR567A7t0QVGKSzldGftEImrgzbda6h5eJX67OrBnmfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XkNggL/t; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 24B2B40E0196;
	Sun, 23 Mar 2025 18:15:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RFP44gPZprFw; Sun, 23 Mar 2025 18:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742753699; bh=PIIWjnrfA984bOqJi5eOt7MWu8DHV+mIsqq/VA99BJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XkNggL/t5g8IniNgywso8rgSv21YakXchEAZgz2CaVKWw1GJQHnORBKypn7jwBeXO
	 gFzDqVgWerFAB+C/mgw6kIJ+WXOAZ+yYD8TBLS+BEA+CtkO7L3OVaf50Am5kyOtDwV
	 cXnAWVA0ggHpUueks5zQSIY85jc8AlQBbteozYBHivSyEHn/eeYC0VzS+ybIs6KtL3
	 UGcwpSejJcBSlySF5C+RMKeYxx24jBbmMG3aZkIbaSgFldhx8kuXMlPPiOL6ZVqy0Z
	 x3wMuC2y0ZRXY4z83mQ7jNC/OtA497BwhsvbDAL40dhV7hGlhUtG6+EuXKP0T/782i
	 HrXKQVyg04TxdduCJY8svlusqtjP7N10MgXIr08FcQ35jLUeCg7zFrM1pmXcmQLsHe
	 KDzfYPCyIcbapaLf/gcHGta5Y3rqfRPgkG/s8P61MIuC+WsZoD1sscliSRMJpQuQ7Q
	 KV4fMpf9IUNu/womUnZ5m2BbCPwPQiSigvcxcWOkcYKodeRq7+mQDGp8DY01oOyC5J
	 KXpeneSH/cph5FZjp/QbSDpFejWaG2otdB2VjdrdEw2yFK3WqUqEU1fIwgk2TOOgE5
	 JV1yEQAUBH9zEjFpTaFh8gwL8sBmIqqtyA0Ab4u1+PFNAgOAbu/MBxvxEnlbI/H3Ds
	 9AjhlqdwO0kreqacjeYzZhIQ=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4CEC040E01FF;
	Sun, 23 Mar 2025 18:14:50 +0000 (UTC)
Date: Sun, 23 Mar 2025 19:14:44 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
	dave.hansen@linux.intel.com, kernel@gpiccoli.net,
	kernel-dev@igalia.com
Subject: Re: [PATCH] x86/tsc: Add debugfs entry to mark TSC as unstable after
 boot
Message-ID: <20250323181444.GCZ-BPlCAhtO7AIsS7@fat_crate.local>
References: <20250226132733.58327-1-gpiccoli@igalia.com>
 <1238b1d0-275c-9117-a2e3-5e7684404980@igalia.com>
 <EA2BAF2F-3F8E-4F81-B71C-7B97677216C9@zytor.com>
 <b43e2353-41ff-f2de-881c-c9a3348552b7@igalia.com>
 <87iko213qo.ffs@tglx>
 <c9ce2eb1-bf90-3ce4-0adf-3f4e43f4a5bd@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9ce2eb1-bf90-3ce4-0adf-3f4e43f4a5bd@igalia.com>

On Sun, Mar 23, 2025 at 02:53:05PM -0300, Guilherme G. Piccoli wrote:
> But what about AMD systems? Even the modern ones apparently lack
> TSC_ADJUST - or is it changing recently?

Yes, it is.

> Checking TSC code, it is full of checks "if Intel" as well, like in
> native calibration. Our issue is present on AMD and my impression is
> that, in this respect, these systems are way more unstable (from TSC
> perspective) than the ones having TSC_ADJUST.

The only one I know of is a Zen2 laptop where BIOS botches a perfectly fine
TSC because those BIOS programmers are soo smart.

If you know of other cases, where are those bug reports?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

