Return-Path: <linux-kernel+bounces-414975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC149D2FDB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 22:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C3C28439D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE5C19E838;
	Tue, 19 Nov 2024 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="iI1arhl6"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A8719755B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 21:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732050242; cv=none; b=qVOcatu1Ms1rOPuXi5tEdDOZaINiZryzj5Qn8emaV3zbABtaq7oS+KUTcuTbDqYXnE/sY8kNQ6xto8Fuv+LCFFbvUhgttH0M8VogauljQ+v7yrpl0IkImZFAFviAqdxbmTcvZh95FngSBrQBPqiJmvtW2dLi+6iBeyogKuOfBZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732050242; c=relaxed/simple;
	bh=Mezs3R4Y45/J48KC3hFH25jrdIFUJKKYqoeYY8BWz3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wf4KC7eUBNK/koNGyvvdbZjdO+ga5O+/MMj/wPWqeE+V53gWvEYnKEXyUEq2bpVElWbgHxMFWZBV8mkj4KZphNRf8eqzXrfXq6IK/Y5OlujT9AorL+gzPhBTRDMVIhQTu/tiMcObwXLiZyGnLsT3JYGzJwDOLTBpKkaVAsgS26k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=iI1arhl6; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 30A5640E0261;
	Tue, 19 Nov 2024 21:03:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kp9hAphuhN0L; Tue, 19 Nov 2024 21:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1732050229; bh=tA3nDmIZQ2Hx9sc/b+PfGGSMtQh/HYvARhmv5kQfjq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iI1arhl6yh3kU3hAJ7I7x86MYIF3YOUohj0TXVOHp1f7AwdZMWwJyxSYTX1xQTZ2T
	 FynN/z5uoNgtPJhTosV1uoxSQXhedIc02xFmBmR5SW6HnTMFMssT61Xcheh1U4XgEm
	 1kBC0INen0hsslOFoqkj5RnxVLPJDCuCmjXX9btJiy7g7rN4TaQYpqFTon9oI9Ooim
	 2o7MgPiMsolnPNqCpJenUju2qx/8jAE2PzctGlu3E8WIE+TFqnfeUtb0Cgp+fnjK30
	 OjbWbuQf25OBV/FRAblo/4Btbq5vydK8E2yTMXLaROjtnNOpRrvrX++Vvl2QXtRpsQ
	 7cknA9W+qXiIc4WeN1gcRJY22sETbbW7hAK4PSeM4BnGPWOQeTQqzCnmlW0+JipyD6
	 boSg2PVPkJWoGlWNG5hOh5C7fatPW587nFiL2UeTBmNMJHu3ggyEmxRkr+UuPowYrx
	 bjxw9wf3M2SxHMcDO/sbXHKYqM8rKd4Xg40h+59vTzqg/sncdAybnwMVcdl2wrfiGu
	 ++8FT2AK9C0H+iUklPULZJ3MAM7QE2pxk7lE6VZq3JyooXTNkHtt7XfDRiQoTmlWjY
	 kiEyT5RnBrqBLouuDcPImki8T3YDwiZqK/23fkN3pACJXBNMFc+ax3I3PLFC2M2VX5
	 8ayEMs9ZbCOlKLTd7kCkSOh4=
Received: from zn.tnic (pd9530b86.dip0.t-ipconnect.de [217.83.11.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4181D40E021C;
	Tue, 19 Nov 2024 21:03:42 +0000 (UTC)
Date: Tue, 19 Nov 2024 22:03:36 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shresth Prasad <shresthprasad7@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/sev: Fix dereference NULL return value
Message-ID: <20241119210336.GEZzz9KMiZwf6R9hwd@fat_crate.local>
References: <20241120-fix-dereference-null-x86-sev-v2-1-7e637851dfe2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241120-fix-dereference-null-x86-sev-v2-1-7e637851dfe2@gmail.com>

On Wed, Nov 20, 2024 at 02:21:13AM +0530, Shresth Prasad wrote:
> Prevent a NULL pointer dereference in snp_kexec_finish() by checking the
> value returned by lookup_address() call.

Can this really happen?

> This issue was reported by Coverity scan:
> https://scan7.scan.coverity.com/#/project-view/52279/11354?selectedIssue=1601527

I can't open this page - all coverity folks: you either describe what the
issue is or don't bother sending patches.

> Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")

So I'd hope if you report a bug against some patch, the least you could do is
CC its author...

To give you the same spiel:

Please read

https://kernel.org/doc/html/latest/process/development-process.html

and especially

https://kernel.org/doc/html/latest/process/submitting-patches.html

before you submit more patches.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

