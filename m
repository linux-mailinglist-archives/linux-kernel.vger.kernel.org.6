Return-Path: <linux-kernel+bounces-321705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67460971E57
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBB1FB235AD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A504D44375;
	Mon,  9 Sep 2024 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HAuuLHH3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DCB1BC39
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725896651; cv=none; b=Xipzzo5nakD3FgxaIwvtpVX/KCqBJq6XsE9dVihh5aK+1F88wDh1PoYkpegWB/p5u45cWSMPGg8sbdEsdk8bCz5e75g5aAhw9ilQRX2/a8WEfpZc3evZKlmFsHGqUkwFBsyYrHEkrIaW7/SJlxBEcFJDjGVDdK5/0+lt3DNqo6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725896651; c=relaxed/simple;
	bh=GWrMWmwL9o2ROtectZpGV79uursoTc4LFervW2EwbGo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cx/SHsrxv+xNm5KZcxvpkivzoxmdja1LkRYZzaAGmE7/0TTp1dJM4ha/4LL5j/MJdiiVlm8aZJxpwtCzZJ291NHPyT1xQc0efds6JxTlmBeWqJn1vWm560zyuDsO5iHvkJz9tNNYDLXGaeVDVvrkGW5V/yhBUS7a+g+pGti+KGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=HAuuLHH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8EEC4CEC5;
	Mon,  9 Sep 2024 15:44:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HAuuLHH3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725896648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RkuPp9W5/TQRbtH9WylYk70MKARzGJFtdzqLeOX6YXc=;
	b=HAuuLHH3yFN4Nr7lrkX0EFgrhoFdQI2/B06gYK3fM06S/LHFZag/1yizPXNy69fIBJZJnx
	Nyf50aU3ODNyTjWVf+J2gj9QfudRIJ/rdjZ0/f/dNstXYCbFglWUhSZYxl6qrlt1BNexwQ
	OF2qiC7A5cVmB4SaS+QH7tu9r1xlBCw=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f58e9301 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Sep 2024 15:44:07 +0000 (UTC)
Date: Mon, 9 Sep 2024 17:44:06 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH tip] x86: vdso: Compute timens page offset statically
Message-ID: <Zt8XxiQrma1R2a70@zx2c4.com>
References: <20240906190655.2777023-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240906190655.2777023-1-Jason@zx2c4.com>

Hey tglx,

On Fri, Sep 06, 2024 at 09:06:55PM +0200, Jason A. Donenfeld wrote:
> The expression `((void *)&__timens_vdso_data - (void *)&__vdso_data)`
> seems harmless, but it actually results in quite a bit of code and two
> jumps, in a place that's supposed to be somewhat lean on code. The value
> of that calculation is always 3*PAGE_SIZE, as it turns out. Changing it
> to that results in a more modest cmov instruction being emitted. It also
> makes it a bit more clear what's happening.
> 
> To accomplish this, define offset macros in vvar.h, which can be shared
> by C code and by the linker script that decides where these pages will
> actually go.

I noticed we've only got a week left til the merge window opens, so I
thought I should poke you about this, if you want to take this through
tip. I can also take it through my random.git tree with your ack, if
that's easier for you. (Assuming, of course, that this patch is actually
correct.) Let me know.

Jason

