Return-Path: <linux-kernel+bounces-547720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CE9A50C9B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFEF716D961
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694401DD543;
	Wed,  5 Mar 2025 20:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Y+VAO4oI"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A51134CF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741207019; cv=none; b=jMqpfYA9f0gD1LhaOnqfcBoEK/qa+7KzKwz9e+ZHfdI9h6+LeSa26TKlUZKE2oJhzXOT/VLYdAojyzJWIclDCxckZ0835zo3mswk1NCv/fZk83LTwwucnd19/axk3yQpJWkOm3ks7ft3z3NGPgiVHQP6Fjkd5ugkkiBZmKdpK+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741207019; c=relaxed/simple;
	bh=Y4wsv55qhHcL/Zho21A5rZ0kTf5ADRuxoCKCJEhfbmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVNdxXE97z4QyDA+jbBdmjdjGo2hers8H2yuS3bFJ427miIbYyaWXi4LehUOVu1724IhD/Cha4WcWel/gGb2eCkEN6dubvqWpZqFUQ/xIsoE0RZ9oH3T79xnJnPOuzcIzvUvg4SBq5yKL31JCg8kZ3SPDHvA32u3AIy5xccO8dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Y+VAO4oI; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7A82340E01AD;
	Wed,  5 Mar 2025 20:36:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JOLGayWy1R4l; Wed,  5 Mar 2025 20:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741207010; bh=pCeZpzO7JCyOfsfrl+Bj2UOW0E2SeUucCem6y6NU8vg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y+VAO4oIJfaiuakZV/k66FUR/h5WMIZaJMoxKKlfvHklHs1bu8ZehSNvgW3lcqWkY
	 yupA8xFMJqLd7l3EC4wsrDux84SUrGFfV5D5GdsC0NtcMbRp2PW2K84ic4Nmz11aB9
	 s68sF5hu/OfiSI8Ff+rnGc501mP9lpNig0EdfQ3OKWBGz5rZ+h74vSA9JDT80uIoPl
	 yRqbmQHbJjvMXYGTCJlwM9jG1JAM2VVYAHdZCtDfha+BI1wE11BFSzcCHML9a2juMS
	 +4tZs+FI2D/D9NYcijsdrr0hRFUnELoIX2Be+Izc5hJ4mnmjl6OAplSyMaGu66QNAU
	 CUxoWRhO4Y9y6Oql+SSXw6/f17sFfCA07+uN6j91praoHmLBNXIIKhPy/Wkao2Qnfv
	 3WzpTCqLK17i7a6hY3kfx+OBNraLV4HHI6r8GcbVsoUcM6RsBExNsRF2YD77xyMjnH
	 CGRkZ7vDBA70/Ew+sb3eJwRXZA8Xkk0SjFmQ30LK3EclgzINWvgylTotYOhLGw1OeX
	 Ig3gejayFqqk5H+l1FGNrSNforg6t4eHZIcub6fSmF3BUuqtHNTKADtCbgGk+IYatQ
	 x0PQ3eKkixlE2vBoSg2ABxDmd77XRo42fytaCGL1td3bhOtkAOcuDuTK3ygWhaBF5w
	 mHNGGgbIh7kT9ro9tg0Fz8n8=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5C57240E01A5;
	Wed,  5 Mar 2025 20:36:40 +0000 (UTC)
Date: Wed, 5 Mar 2025 21:36:33 +0100
From: Borislav Petkov <bp@alien8.de>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
Message-ID: <20250305203633.GNZ8i10cVCCnhhULis@fat_crate.local>
References: <20250228123825.2729925-1-ubizjak@gmail.com>
 <20f1af22-71dc-4d62-9615-03030012222e@intel.com>
 <CAFULd4bpHGE83qc37sbh=rpGj+SFqQrsNDLzL_-NQpo6pQH3jw@mail.gmail.com>
 <c4aca08a-95c1-48ee-b4da-55a69b74101c@intel.com>
 <CAFULd4YVOEtT+bsp9H7ijaoJn2e2108tWhiFarRv=QxoUMZaiw@mail.gmail.com>
 <20250301123802.GCZ8L_qsv7-WwUwqt5@fat_crate.local>
 <CAFULd4b=4rHcVAVSg_3yMb8=3ReiSriw_rM4vJL9_HvheXE92w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFULd4b=4rHcVAVSg_3yMb8=3ReiSriw_rM4vJL9_HvheXE92w@mail.gmail.com>

On Wed, Mar 05, 2025 at 09:54:11AM +0100, Uros Bizjak wrote:
> The -Os argument was to show the effect of the patch when the compiler
> is instructed to take care of the overall size. Giving the compiler
> -O2 and then looking at the overall size of the produced binary is
> just wrong.

No one cares about -Os AFAICT. It might as well be non-existent. So the effect
doesn't matter.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

