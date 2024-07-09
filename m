Return-Path: <linux-kernel+bounces-245695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE4D92B633
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF9E28378C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB27B157A72;
	Tue,  9 Jul 2024 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="avuRZpGY"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3296D38382
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 11:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523475; cv=none; b=Wv6/otmw1cgaGtp5d4BJToq+L5mCIZgFKCJBKr96nbIBtPYF/62fP8e3bGsWb+BNmSldjfW/zgC5r7/MgjMJSj9gRAH0lDZNnHQnDNL6bs5E/FmTQ6KV9my/LDDgK2klzLWVMewB9v71DYDi/VeY9UXbn+CZD6i0am/q/VFee7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523475; c=relaxed/simple;
	bh=wR/osTrCsqIJK2ntSWy4PYmOdTp+ipbfIjytG93Lz/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Idk0WbMHG2lOss4eG9WYKwecYE7sne7us2e1RoRfHCuWET3mGj1zhnTUlcsM7OKqfYUssHVicHTwj5KP7YsYzwixBicNvfVa2ys1izvc5dCjmWNh4ZbXsU4uJuT2e4mdwVnBHAAHvafQFBAF+REZwggJ50NvTR0W/G6ijUe+Nvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=avuRZpGY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1F76540E0206;
	Tue,  9 Jul 2024 11:11:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8AAwEIqEjuCH; Tue,  9 Jul 2024 11:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720523468; bh=9zm8/e4MfRpZGzUXVBnxAThpREpk06/D+qV75RsIw34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=avuRZpGYFr6AuRR0cvCeOPJ0Jj1qNRiId613hNr/sRfRcNUgY31DiIe7412A0laVA
	 X+LH/bPF7HHu3hDVSGF520reXD8sG+mg3p9DCkiT7jO9TCvKVXxPWkJbNyi+Fq9Def
	 Ptb5Zd61Ui/azTtm9QmMy/JNQNNxgjquAn0fteKznizhpqNBWI60z4CoOlaM4A+QBX
	 TFo0AkdYpz86WnPclP4SxxS4Ryg+u0mo75+f7DhN2WeOhyV1sZPH+JAO0Im1fxkJaD
	 k5ICmHimJnJ4CaYjzBtHScXf8GvvZgEMDG31VkKBleHVTNndmAVE0N6N3ekfMsPhTj
	 lYDvkM6dhjjPFeTeJzpS4KpA5EiggK3w3MXkayq4x8ptLZC0o0p3uvZDO4Q6wXf5SZ
	 vm+Fv/eno11or8BQaeDQ+q0kFUNOoGqZh7kgJVuejwDXIct8pDPcXcFy97ZmEPrCgr
	 OB+p6oFu3LufXeqayp1VBDDOdd1fZF1DlVUTDJl10DyK+Xaej3isM7AyKh02q/T2pM
	 ADJ+T02GmIIcw+7m2c0Aw6pr9u6H8S6C7e/1mPA618vw0P1nq7Y+tJHz5yt0n4I0d7
	 6+LSWSMxKp/aLTv6SvipSKT8z7qzhrfga2IbAdt227yCBpFjvEss+5DyAQ6AU/zkPI
	 zWDFTrwMGgPTSTnVwNEN7qVc=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 660B440E0192;
	Tue,  9 Jul 2024 11:11:02 +0000 (UTC)
Date: Tue, 9 Jul 2024 13:11:01 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jim Mattson <jmattson@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Greg Thelen <gthelen@google.com>
Subject: Re: [PATCH 5.10] x86/retpoline: Move a NOENDBR annotation to the
 SRSO dummy return thunk
Message-ID: <20240709111101.GFZo0axWLVb2e-n_fK@fat_crate.local>
References: <20240708164319.3801778-1-jmattson@google.com>
 <20240708170541.GGZowcZZ0tZmt7znYA@fat_crate.local>
 <2024070949-blame-emperor-a764@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024070949-blame-emperor-a764@gregkh>

On Tue, Jul 09, 2024 at 07:15:37AM +0200, Greg Kroah-Hartman wrote:
> Sending fixups like this, for things that are already committed are
> fine.  But note, someone needs to at least send them to the right place
> (i.e. no one cc:ed stable@vger.kernel.org...) if they wish to see them
> applied to a stable kernel...

Jim, should I or you want?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

