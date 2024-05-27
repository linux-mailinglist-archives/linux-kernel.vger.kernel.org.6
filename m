Return-Path: <linux-kernel+bounces-190525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6808CFF82
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45945282BB6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0496715DBB7;
	Mon, 27 May 2024 12:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VRgtj16q"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D9113A3EF
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716811304; cv=none; b=W5cc+f7mgC5Jd+KQkohBoqJGaqK0JD1iWXKD4yoJd8TlOdIRydp3YSP7DHmQpdTmvtloCck6Y6m6jIxuwJc7xB6bcYIrQRpD/aCEgZjHsySGodHA5ebeXVlq+a8n/GYxu4ZYKuowHkaJK1guy+d7jEBySjwYW8TUJEwlzMaHsqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716811304; c=relaxed/simple;
	bh=EAW5TG3gc2j1wPF4Y5JoxihPW3GzF9GGQCjYRG1CCA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZ5R95EpSFSgr5jVX6j9Sd3r8BnUWk8nlf1AERGEycstRz+K7V27Qy0x8Fz4c3cMvSTMDXMRiJG3QtpZAlB2+YNflrcfZguS1XwaiKraOiDc2AKzaEy0qhHgTTLznOG+3XgyAYyGiMM7u2pJdLZNRDhKcVQ/qwRWsKgFRjzTrCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VRgtj16q; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1491840E01E8;
	Mon, 27 May 2024 12:01:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4YV-ZnbxMjNN; Mon, 27 May 2024 12:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716811295; bh=kFJbAAz0Ge0oQNpUds7hPofKuWTKPhhEYoWu+CDfR7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VRgtj16qkJpX3zuhQokUE9F7o0l8Z6Hduxi/hxfNla+AptmoJJGyoKSZxLyepgE+7
	 udOjNmeZIHJX9vIK2yKWfTGrtDYJKLRQ8VEZh7TmKwrF5JlaVZGCyFEW+HE7wbJMAd
	 MyFLBnwJrKDU1LR+29UEh/fItXxnQvagSwvk7kyS67UYuoKwsOYtH2ZuPbW6ZGXGVZ
	 Payjce71JOapupgHLm3r0SVT2yzfKZxcPWGCqs/BVD7lmwvA50r7X1uUvYn1op4+CW
	 650GkjNXwQqg4dPWfs5IM8OpPhAD1b6035EEjHQZXYjI4e0A+DfGpVBQeJ2AtOUU6s
	 5NOSiSgOtU3S5ue+dHn9J5DE6W35qR/SCl9fRzTITFl9W1QtB51KmGEdh3OVx/dw9I
	 2S70fsSS6NeNX9vHknF9V0ys2dQ/9qwM4DOGdzaBC29DSrxPoQkpEGegd65QR/2s8r
	 Px7OG1RwFeb97NwslBEgvU6hdgSXdwUkjU9l3gznGoIzSKeaxScIAuV4mgdbmiJGQP
	 3uvaIUiorY6yNj3Y/wkyeLVYXD4iRSFWYuCotPOf2xCIpSNBPVaUy+2XoDE+V0TrZH
	 6S0U65tOh1WantTuA5gj9DJ53tG3XdlYlomiFPeJluGqGnE+hjshSE2CoNbRQJQuMG
	 Cj7CTYij63C7u8xIa5Dh3S2E=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D112C40E016A;
	Mon, 27 May 2024 12:01:20 +0000 (UTC)
Date: Mon, 27 May 2024 14:01:14 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v4 06/15] x86/sev: Perform PVALIDATE using the SVSM when
 not at VMPL0
Message-ID: <20240527120114.GCZlR2Cpu_8rJXlMOS@fat_crate.local>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <ce5f7ded87868adce2f4724415313229a8bf3eb3.1713974291.git.thomas.lendacky@amd.com>
 <20240522182403.GAZk44Q7DalfDBk7Br@fat_crate.local>
 <408e9902-d9b1-d087-a44d-fb27342cf21f@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <408e9902-d9b1-d087-a44d-fb27342cf21f@amd.com>

On Wed, May 22, 2024 at 04:14:54PM -0500, Tom Lendacky wrote:
> Right, changing that from previous comment. But are you also asking that the
> if / else style be used?

Yeah, please. It is trivial and thus more readable this way.

> Sure, I'll add more comments or expand the comment above.

Yes, and pls split it into helpers. Those bunch of nested loops are
kinda begging to be separate function helpers.

> That's because you can only pass a certain number of entries to the SVSM to
> handle at one time. If the kernel is in the process of validating, say,
> 1,000 entries, but the CA can only hold 511 at a time, then after it reaches
> the 511th entry, the SVSM must be called. Upon return, the kernel resets the
> CA area and builds up the entries in there again, calling the SVSM again
> when the area is again full or we reach the last entry to be validated.
> 
> I'll add more detail in the comments.

Yeah, that "portioning" must be explained there.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

