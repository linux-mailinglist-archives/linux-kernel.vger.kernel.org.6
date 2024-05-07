Return-Path: <linux-kernel+bounces-172061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D2C8BEC90
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 21:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A51B51C23197
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 19:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AE316DEB5;
	Tue,  7 May 2024 19:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Lxncq+5j"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4314E16D4E7
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 19:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715110034; cv=none; b=CMYgXLUrET4Yd0r/juZWC5QUIybOz7A0EmTVWYEPB6PznigrI4xSDH843HVmNPTcyEtiqxjPzQiXKIFRISJIfKcc6ymbewNLaiT+GT+9S4Jm8wZgLVY8AfVM4JIWDL9b3PPR3GqaGg/URs3jyBwlogQoAVNIrsbanmkNU789bvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715110034; c=relaxed/simple;
	bh=WxaNBLrSeN8x4lvPhzVNPKCVxGFum1rUI9B+YBvM5Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lURyGlKjgAzIJwKJPlYMVcZ2BfOMycrqTo1SqH7B9y5cJ4om/QnLyvMwFmKtzStN9CFa0mWirSPCsD/Uu62rFUuUsId4nCa7kE5DBDe8OsdZ7DiiiqjePmIObh1FPQTx1+vGDJYikfNQRg+X8Eby/gb+uztNmn4pSOXQNuVCDiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Lxncq+5j; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8F04D40E01A1;
	Tue,  7 May 2024 19:27:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pKGFQKbUhIz6; Tue,  7 May 2024 19:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715110025; bh=gvTYQvtdmFkBWYBMVhiFfbISKmN7J/FVgrifaFJdSG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lxncq+5jJ2HsvOIS6PnAxN0lAK5rQCznC4CA+Aj7HrvQcnU0HfOqdeHSXaSL7986C
	 UoYqnj5rD0m6kUyCeE07WuaTWLkbysPSncjw7KmwY+NJQSwIg3ZBSnImCQvluG9XWZ
	 KUqWkHrx6tiA6jMkrff8jREXK/X7QJsURqn3OZDnKh6t7677hSxmwNUi/v+KsnP8Og
	 DrBMkpZL0bsWHpEkmN8lNHCuD9lReB7d/p6dljc8JVWW/THA1Kms6EQ/EO40iqLIXh
	 xLsHy3X/1/lReoeoZMymztUngnKAXzn6Ycf+eYpOWVE9m0dZlCR+9yv4khOhlf+yJd
	 AvPeUOlYsQAu82diAE6WuBuwa9KDUwiCfa2gA5skkvl+VF6rcZexFw+r46dUfVLhpn
	 t4F8+rzv7wI7PZZYcqxRQ+YtqTmFkyuIKv8L+P/R/iLkv0+IQAwHvwRXE3jp/FBh5t
	 X73mAzy4kgjTJZAu0dt5/cHDe32JvSmtr1ur7R+q2JUbmpfXzqJtCnEnQV+J8AdWR7
	 maQjZgRyJFIOGuW/F/zP89nKrygCyceqZxO7/XsbF2car6dyj1zT2ic/9cCS/uwY4m
	 DKq3x3BUmCC/SiNoCRxrM62BBonsrxov5VN9MtIYvElXVt2ndt5gap2mMZPsNpBKMJ
	 kC4mLRfWpNEwotMvaZz3W9ww=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4A6DB40E01A3;
	Tue,  7 May 2024 19:26:55 +0000 (UTC)
Date: Tue, 7 May 2024 21:26:50 +0200
From: Borislav Petkov <bp@alien8.de>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] x86/fault: speed up uffd-unit-test by 10x: rate-limit
 "MCE: Killing" logs
Message-ID: <20240507192650.GJZjqAeipgUw2AoCK9@fat_crate.local>
References: <20240507022939.236896-1-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240507022939.236896-1-jhubbard@nvidia.com>

On Mon, May 06, 2024 at 07:29:39PM -0700, John Hubbard wrote:
> Generating lots of memory poisoning events seems like a valid use case,
> by which I mean that this is not just a testing artifact. And that's why
> the fix applies to the code that directly generates the output, rather
> than the selftest that triggers it.

Sorry, not taking a "fix" for something hypothetical.

If this is a real issue on a real system and the printing is the
*actual* problem at hand in a hw error storm sure, but no, not because
a selftest runs slower.

I'm pretty sure in a hw error storm scenario, printk being slow is the
least of your problems.

And in such a scenario the *last* thing you wanna do is ratelimit prints
so that you can't even get all the logs which is *the* thing you need to
debug the hw.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

