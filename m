Return-Path: <linux-kernel+bounces-285657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 006A99510E6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 02:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA131F2312F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F94A3B;
	Wed, 14 Aug 2024 00:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IHoY/9Zr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AC5620
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 00:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723594257; cv=none; b=V31xXrw8PqsV5UpWCsFH11fTojunjbhLK3pMznr48gHxrdzrky6FYhpqKAkq5oIJPEy2fQl4pda+wGEvC/bP17FEWFlRqF+X+yo1zVDGpeJQicNS/DXEGq5qeHoIVS9Ywk1rjaDUH14PIB+ybjbTUFcN7ISS9vx3mFzBcb6umQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723594257; c=relaxed/simple;
	bh=c7r5OUmvaJQiZogtT5yLK0btcxbn7sNq/ZTe8Wov/6c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EILnJMWxgcZ3F0AVzNdOIJT86profcI+S0OlPmbIEaVXZNaMCECXH5zcrbb2r7Fj0DTjqg9S14SGkrM1q659GaC52HsRTd8PPe6o6+HKuK7rjpBm8flOdIHX3wYoq0vbco46dMrLHzIDvINOx6Zt/0P/MGIB/fPg41zw2MNrAJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IHoY/9Zr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5883BC32782;
	Wed, 14 Aug 2024 00:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723594256;
	bh=c7r5OUmvaJQiZogtT5yLK0btcxbn7sNq/ZTe8Wov/6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IHoY/9ZrpQJOK/DT41cyEvhebsBWlOij3Ygq4bBZKodxAgT6oUW2b/vDDa6zk8qOu
	 fpQPKjnhIQqiK1cGtDaHVQkhmBjQ5foFuCgAj3UTUFsQED4ojiCah5e3uI7salS6O9
	 Jw0iF3qWL7RATbT07B0ik4z4oV4DCHcA79KmX8fE=
Date: Tue, 13 Aug 2024 17:10:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Florian Rommel <mail@florommel.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Jason Wessel
 <jason.wessel@windriver.com>, Daniel Thompson <daniel.thompson@linaro.org>,
 Douglas Anderson <dianders@chromium.org>, Lorena Kretzschmar
 <qy15sije@cip.cs.fau.de>, Stefan Saecherl <stefan.saecherl@fau.de>, Peter
 Zijlstra <peterz@infradead.org>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>, Randy Dunlap <rdunlap@infradead.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Geert Uytterhoeven
 <geert+renesas@glider.be>, kgdb-bugreport@lists.sourceforge.net,
 x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] kgdb: x86: fix breakpoint removal problems
Message-Id: <20240813171055.f8805c1db539dfa18e80026b@linux-foundation.org>
In-Reply-To: <20240811232208.234261-1-mail@florommel.de>
References: <20240811232208.234261-1-mail@florommel.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Aug 2024 01:22:06 +0200 Florian Rommel <mail@florommel.de> wrote:

> This series fixes two problems with KGDB on x86 concerning the removal
> of breakpoints, causing the kernel to hang.  Note that breakpoint
> removal is not only performed when explicitly deleting a breakpoint,
> but also happens before continuing execution or single stepping.

Neat.  It would be nice to fix earlier kernels; for that it is
desirable to identify a Fixes: target.  From a quick look it appears
this issue is more than a decade old, in which case I don't believe a
Fixes: is needed - our request becomes "please backport to everything".


