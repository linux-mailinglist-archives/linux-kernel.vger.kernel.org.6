Return-Path: <linux-kernel+bounces-516498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A410A37292
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 09:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1D9188E33E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 08:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D600F1632F2;
	Sun, 16 Feb 2025 08:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="GY6Nhm3z"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED1E148FF9
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739694826; cv=none; b=aI1/t55ZFyZhaIatEUDGksmIPtQrysAd4CiTmH/7VKNS3OJlgPLOfngsWvUBCeHeTvthb6JoKn+48WQX0GIjVWSEoE0Izg8YHYXdxU1gcT2DchLnBRCNNS4iQqYgXSNdNnN4Cv/RjR+cu3fgxmgvF44Da/UKUyqHU7yQkB6Gjn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739694826; c=relaxed/simple;
	bh=SGk1CCw5m9Pr9/GlSK19f+XaRP74gb/sLOUf6100GvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PS+A82HArxTAYO4BTrqY5PW5DaTbDhStInAb8xDdOaFvVm7j4Paby5h41vUi0jqAE69r3SBhBqPc12aloUBh1VPaHO8FYgaX2/d9bl8XLiKebLj9i7AosS51dMtNTiYgQRO9jOsi121xLnKDJkOmPTf5rRmBQfdmIc/kEZNlKf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=GY6Nhm3z; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0D67240E0184;
	Sun, 16 Feb 2025 08:33:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cgj4-db-pTtP; Sun, 16 Feb 2025 08:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739694813; bh=5TtKbjLJKwz2lvbh4IMqDMgz0l4A5uDV0LDSRztYufU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GY6Nhm3zH3dJlrI/Q+sKANPyHywP0fOKTxKc5stvQwmakKO/0DRAnB4xHitZMFC3J
	 qbfqAxdUunElWJ5tZxpPS7DYzFnxYgoautQ7hNgjkbPnFM/1qbK34SY0RXCEes0u5p
	 4OqOuHeq55Hww5nkctR6SlzgM+T9yJz0d65fVj5YDwgPO0dDe3KDoh5FNkqvAamCOu
	 +dGMbiTikfVUnV7tgmGffcde2iIr7DgCOS9913CAZ9v0p4MZbz88jha2goqJU9ZnP2
	 VF9PYhe4xxqKeNK+tNLpOVFM1KBAsbhw1fU6MrwX4U/sHNfn74q8QvUvGMppu6Rv3j
	 GgkD5ONhYgIl5F7ZRXlJB3kLagjFaNVtSNP7HvVQJBfK+ZvZmEfu4vZJKnVl1L7GNy
	 ii7dgIBPbj5AG3FnG5Ey5TyLsSF1bDcz2Icn0ks8RgpyyMAwuJA8MBkClE3pq0src+
	 B4mkJ72ubWd2OUpTYsAcSRBpddCMbhYTz117RWzAuTNPBww6k9iAAX54XoFPUbRHhx
	 vNXc8z0t59XI1HErXVLe/kZhh9sYXLo1Qv4/HH83NzR5SsOPOOLK9ZT1G4Te0c62z+
	 TBF+bUhUEGYyB9W9qJnobcbJvGQ1FYpv8w2wWjWfvrbbo3wOHNtcaxnuZp7O5tDuFR
	 KuCZcINohIW1UrTsnMH/Prjk=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 707A440E016A;
	Sun, 16 Feb 2025 08:33:25 +0000 (UTC)
Date: Sun, 16 Feb 2025 09:33:19 +0100
From: Borislav Petkov <bp@alien8.de>
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ard Biesheuvel <ardb@kernel.org>, Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH v5 08/16] x86/stackprotector/64: Convert to normal percpu
 variable
Message-ID: <20250216083319.GAZ7Giz6eTkQ7zpc3R@fat_crate.local>
References: <20241105155801.1779119-1-brgerst@gmail.com>
 <20241105155801.1779119-9-brgerst@gmail.com>
 <20250215142714.GFZ7CkQtdXoUM-xKMo@fat_crate.local>
 <CAMzpN2h05N+KZzpFY6YXZjMViK+_U9gks36mOfRJpSOMY-Xm5A@mail.gmail.com>
 <20250215211854.GFZ7EEvlYTQ2USmKiW@fat_crate.local>
 <CAMzpN2hTYCB6f1v2RjzCZV_Kx0WjVzE0U1ALhZ-C=Rjya9Puvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMzpN2hTYCB6f1v2RjzCZV_Kx0WjVzE0U1ALhZ-C=Rjya9Puvw@mail.gmail.com>

On Sat, Feb 15, 2025 at 05:10:55PM -0500, Brian Gerst wrote:
> If you want it changed, please just say so.  I don't care either way.

No need to do anything now - if it turns out only trivial touchups are needed,
they can be done while applying.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

