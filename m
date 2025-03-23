Return-Path: <linux-kernel+bounces-572966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1110AA6D0EE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 20:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07FB18951B7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 19:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC82219E83E;
	Sun, 23 Mar 2025 19:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UH2jBKc6"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637B528E7
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 19:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742759487; cv=none; b=s5sI32mwU7V5pcBO0qlScu78NbzdTj7bvTKMXI+OC0sekhtIbdgGgX5o0PYGqr7cq4fM3TPwx2hJyK1kZt4Jha77OH90yqXyEeVnHtYWB56thhssYfT3mUQabgY5u+F5c3CvFIZv2dqcx2ZsdnKAgMXJPeMZP/Yj5j7x31PXTfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742759487; c=relaxed/simple;
	bh=2z8DIs/MfUWa4qmP6/wlHkaufzH2IeAdTj7tuhZKYfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDufFBvlDEfesiTMMiS87pI575++C1USfVzodH72GW9SttFQN/lCdsveNiEQluw8evt3FOYcnS2HC28/zoobvcqyS9Dy/iGqCpU2EJeCxdKztCCQtjemqA++ddDU+wfIYUYRW0gOtLdrEhfIYsc2wvIHXH3SyQSNbh91pSFaHYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UH2jBKc6; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EA50A40E01FF;
	Sun, 23 Mar 2025 19:51:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cG2-PWExDVlH; Sun, 23 Mar 2025 19:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742759477; bh=vQw69BVbIRV1aaHYirCZ/+GJ4s80ZDu6SI8BvHKYn8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UH2jBKc6jVqAIqZubq7aY1UJ3vXE5wMiTbd6k8MXHRVQefXBfpw+asyn4ui9kkVxg
	 fjxrj20aZesbat3Pftq70yxH4ozNE65xVl8nX9oBhOlkgqGz5ZqP0/PipPaQj6SWKG
	 hEg4nL3H1bOHJhjTugbWmceHCXQVr+e2g66DQmxkYgt0Y5SwqzaYP05yVhH2oB3G6R
	 f4ngt764A3gM481M+IXAdwkelzftbVD9YyLUujpKxtGsdIwebZY6zpqjdUWz3H6KNP
	 8prqHf8PS3qLs/RYardt9/JxxlpowVTyaxxLRozsrv16z+TrVa2IqUTw/r3PbKmJjI
	 gv4q9+yVFBY9fngGdvGaoVyM7bWVGE6KwNhbuhPTOe0mLnGNi/FUar+osX0r4w0knL
	 ubZckyZAJTfjp5dcpgezyAWmm4uXDWxFNib86ptdn305vHmJMoLcY+jApwms0xxB0i
	 aRa/CT8mChQvNDcX3m+HJgeRPkVHH6Hxl+9V0BWSng6UDlbXe82oFEvJIfbpbsQyEC
	 Z1yPxEik31BBsINuWwVqAFpS/7L3I5EZFXoX0qaQKcEPVkG4s0BXG0jyl9ASrXEzaQ
	 qEZz9WSh9mNTbA4jBwsxfKdDO37HTZrVtx4VP6LRo8I79yscKSILRbcw50iLzDX3r/
	 4fhVH1BVeTBI4gyUSdlqBNZM=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 86A3240E0196;
	Sun, 23 Mar 2025 19:51:08 +0000 (UTC)
Date: Sun, 23 Mar 2025 20:51:02 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
	dave.hansen@linux.intel.com, kernel@gpiccoli.net,
	kernel-dev@igalia.com
Subject: Re: [PATCH] x86/tsc: Add debugfs entry to mark TSC as unstable after
 boot
Message-ID: <20250323195102.GDZ-BmJgDWLieuUaJs@fat_crate.local>
References: <20250226132733.58327-1-gpiccoli@igalia.com>
 <1238b1d0-275c-9117-a2e3-5e7684404980@igalia.com>
 <EA2BAF2F-3F8E-4F81-B71C-7B97677216C9@zytor.com>
 <b43e2353-41ff-f2de-881c-c9a3348552b7@igalia.com>
 <87iko213qo.ffs@tglx>
 <c9ce2eb1-bf90-3ce4-0adf-3f4e43f4a5bd@igalia.com>
 <20250323181444.GCZ-BPlCAhtO7AIsS7@fat_crate.local>
 <8247f64e-316d-0eca-9e5d-0c63c7dfc862@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8247f64e-316d-0eca-9e5d-0c63c7dfc862@igalia.com>

On Sun, Mar 23, 2025 at 04:21:44PM -0300, Guilherme G. Piccoli wrote:
> This is great to hear - is there any starting point model that you know
> AMD introduced/is introducing TSC_ADJUST?

Zen5.

> We don't know yet what's going on, some TSC skews reported eventually in
> some machines, in a fleet - but "old" processors, Zen 1st gen.  Once things
> are more clear, definitely could provide a more mature report of the issue.

Sure.

Zen1 should not have TSC problems either. If it does, whack BIOS people.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

