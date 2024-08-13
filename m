Return-Path: <linux-kernel+bounces-283935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FCA94FAA4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 02:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01018282641
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 00:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5756817FF;
	Tue, 13 Aug 2024 00:25:02 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45D4184F;
	Tue, 13 Aug 2024 00:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723508701; cv=none; b=SngbPTgH+JBorJ5405R4vp1QgSrp2pi9EGree/ZFw/v5heuykek2cqFcsRNvkosGW0trxrrIv2+7SBnfwjCZ360jzhtqekLmHxB07ZTtXWsAfWn7uI00SycAIPfZHdqvq9zz3X7hMiVNGnlO9aWTNby4vfZLnMjp5dafrKHu6pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723508701; c=relaxed/simple;
	bh=E3UgAigyPZ4GktOoWU3YxcQofkYxoQ2A8IuYC2xknQM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cMKAsHmY7Z6T5gJ60PFotV53Y53lY8EgHv7HaHe0yPqfJras1kCaR0xJnJvcromq5Pu68EKmsVhrPH5Lk3TDGfby08Ok+eY95TpvAlopmNfNHvV3jLS9toof1K4L62W2yGQgkEPR9/3Qa5pWWHZuvWzRUly6LuSfOVWaVoMxk+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F620C4AF0E;
	Tue, 13 Aug 2024 00:24:57 +0000 (UTC)
Date: Mon, 12 Aug 2024 20:25:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <kees@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, David
 Gow <davidgow@google.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Andy
 Shevchenko <andy@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Masami Hiramatsu <mhiramat@kernel.org>, Mark Brown
 <broonie@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>,
 linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-trace-kernel@vger.kernel.org, Palmer
 Dabbelt <palmer@rivosinc.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Charlie Jenkins <charlie@rivosinc.com>,
 Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Shuah Khan <skhan@linuxfoundation.org>, Daniel
 Latypov <dlatypov@google.com>, Guenter Roeck <linux@roeck-us.net>, David
 Howells <dhowells@redhat.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?=
 <mic@digikod.net>, Marco Elver <elver@google.com>, Mark Rutland
 <mark.rutland@arm.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Nathan Chancellor <nathan@kernel.org>, Fangrui Song
 <maskray@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib: Move KUnit tests into tests/ subdirectory
Message-ID: <20240812202507.453bda6b@gandalf.local.home>
In-Reply-To: <20240720181025.work.002-kees@kernel.org>
References: <20240720181025.work.002-kees@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Jul 2024 11:10:30 -0700
Kees Cook <kees@kernel.org> wrote:

> Following from the recent KUnit file naming discussion[1], move all
> KUnit tests in lib/ into lib/tests/.
> 
> Link: https://lore.kernel.org/lkml/20240720165441.it.320-kees@kernel.org/ [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---

Strong-Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

I was talking with Masami and asking him where the kunit test code lives
and after pointing to lib/ I was disgusted with what I saw. I told him,
"why isn't this in its own "tests/" directory"? And he mentioned this patch
(which I forgot about).

So yes, please move it.

Thanks,

-- Steve


> I can carry this in the hardening tree. To disrupt people as little as
> possible, I'm hoping to send this either at the end of -rc1 or early
> in -rc2.
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: David Gow <davidgow@google.com>
> Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
> Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Matti Vaittinen <mazziesaccount@gmail.com>
> Cc: linux-hardening@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Cc: linux-trace-kernel@vger.kernel.org
>

