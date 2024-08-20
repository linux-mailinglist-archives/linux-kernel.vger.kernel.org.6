Return-Path: <linux-kernel+bounces-294291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFD3958BB4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD47C1F22C98
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA461946A7;
	Tue, 20 Aug 2024 15:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="VJ0TzxDD"
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D6818E34B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724169436; cv=none; b=lRq3IKjUYcgbJJp7d+tyJ826ij6j1gvm3sMiK14Zgui3hCgdZWN6bdqQ5CGUz9l8HNxx4XSxi1e1Du4RCr6fvtKIk3HcBbj1acT49qhPHoSoEuwT+UgQRXt+zo5Ucv46X+V0EhdXTkIR+iaBUWI7HumTvJOAFDGhtsYdWa0uUTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724169436; c=relaxed/simple;
	bh=rot5ssAQC6xB48W1ZjfbNWWaT6lj9IF2CovUML3pLm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGsM5t0EoLGbvVNH5dbAjg98WxVPpCXz1DTUI5DJyr23GOHcY08eXWPDZzhB1qiM6zvkab8wg9d1M++nPXdNdPfvqwNELWKNKUMnaCOD1a3a4GU/IpZECxoqcY+ooMOQE6qotXGTjmpkN3iwI5glpFYC9YdkNzTcNFGEuS+sQJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=VJ0TzxDD; arc=none smtp.client-ip=83.166.143.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WpDcR58YZzlsY;
	Tue, 20 Aug 2024 17:57:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1724169431;
	bh=i1/S+bliI3pEIcUPFtodPYjZw+/nzKl6ifmV0VHTYXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VJ0TzxDDI2NlEzCfEI2mwOLzZjYuCWJf+LmP0qc0UvYSrcKL+oD3EWHKXHS/JJPyD
	 pUHZlXscb5l/sq5IcjR0ktFQNuLQkmFOfp5dabNFPkeIz1H3FEzg80CwRgwodHLXq7
	 neRdWrKPQPktn8HfdSdsKw6Wd5pXtMubezcgF6Xs=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WpDcQ5zlqzR1h;
	Tue, 20 Aug 2024 17:57:10 +0200 (CEST)
Date: Tue, 20 Aug 2024 17:57:07 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 4/6] selftest/Landlock: pthread_kill(3) tests
Message-ID: <20240820.eesaifai6Goo@digikod.net>
References: <cover.1723680305.git.fahimitahera@gmail.com>
 <f9ddc707873b30f440779feb1f284fc2a4aae40b.1723680305.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f9ddc707873b30f440779feb1f284fc2a4aae40b.1723680305.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

Please make sure all subject's prefixes are correct, there is two errors
in the prefix and the description can be made more consistent with other
patches, something like this: "selftests/landlock: Add
signal_scoping_threads test"

On Thu, Aug 15, 2024 at 12:29:23PM -0600, Tahera Fahimi wrote:
> This patch expands the signal scoping tests with pthread_kill(3)
> It tests if an scoped thread can send signal to a process in
> the same scoped domain, or a non-sandboxed thread.
> 
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> ---
>  .../selftests/landlock/scoped_signal_test.c   | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/testing/selftests/landlock/scoped_signal_test.c
> index 92958c6266ca..2edba1e6cd82 100644
> --- a/tools/testing/selftests/landlock/scoped_signal_test.c
> +++ b/tools/testing/selftests/landlock/scoped_signal_test.c
> @@ -10,6 +10,7 @@
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <linux/landlock.h>
> +#include <pthread.h>
>  #include <signal.h>
>  #include <sys/prctl.h>
>  #include <sys/types.h>
> @@ -18,6 +19,7 @@
>  
>  #include "common.h"
>  
> +#define DEFAULT_THREAD_RUNTIME 0.001
>  static sig_atomic_t signaled;
>  
>  static void create_signal_domain(struct __test_metadata *const _metadata)
> @@ -299,4 +301,31 @@ TEST_F(signal_scoping, test_signal)
>  		_metadata->exit_code = KSFT_FAIL;
>  }
>  
> +static void *thread_func(void *arg)
> +{
> +	sleep(DEFAULT_THREAD_RUNTIME);

Using sleep() may make this test flaky.  It needs to be removed and the
test should work the same.

> +	return NULL;
> +}
> +
> +TEST(signal_scoping_threads)
> +{
> +	pthread_t no_sandbox_thread, scoped_thread;
> +	int err;
> +
> +	ASSERT_EQ(0,
> +		  pthread_create(&no_sandbox_thread, NULL, thread_func, NULL));
> +	create_signal_domain(_metadata);
> +	ASSERT_EQ(0, pthread_create(&scoped_thread, NULL, thread_func, NULL));
> +
> +	/* Send signal to threads */
> +	err = pthread_kill(no_sandbox_thread, 0);
> +	ASSERT_EQ(EPERM, err);
> +
> +	err = pthread_kill(scoped_thread, 0);
> +	ASSERT_EQ(0, err);
> +
> +	ASSERT_EQ(0, pthread_join(scoped_thread, NULL));
> +	ASSERT_EQ(0, pthread_join(no_sandbox_thread, NULL));
> +}
> +
>  TEST_HARNESS_MAIN
> -- 
> 2.34.1
> 
> 

