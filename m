Return-Path: <linux-kernel+bounces-321178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2CD97158B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CF84B22682
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763331B3F1A;
	Mon,  9 Sep 2024 10:42:06 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D774C2AD00
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 10:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725878526; cv=none; b=EmC4nkmNsuDqYvzI9HVal3H1scaMmDkoAzOrftYSX/YkkVy4TX6bGnxxuSJ76SEGYPm4/yodoiGnxcVoWIBkjhi3rVEImOr5ycCYnOD8LyIpRgTsyCHGA+HjtoY9BnYInDCmMczlP4I1X/RjP9mQoEZ+/rgjeOMnXojq6tn4JSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725878526; c=relaxed/simple;
	bh=+t6cB7vcrsfSAP6niWpWAyrPO6QRnva0RqkxzcX7yDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RsIcdOHNw9aIY48nu0shNB1C59OIIogLgE1z6ZxEsUQ9ja6ryQGQlNaYKpDMbcbmpIlP37WhQO+BfPph/pYxSR6G5yr/5HUeuUQ/ueIo2tQrhdjPVA1A2a3jzxbJCkw0CT667DxPDaq71QRWooO40PPzMhe8Q11RRkqg3za/nQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4X2NgY5G8tz9sPd;
	Mon,  9 Sep 2024 12:42:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jTL3thpeMbBO; Mon,  9 Sep 2024 12:42:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4X2NgY4MXDz9rvV;
	Mon,  9 Sep 2024 12:42:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 850368B767;
	Mon,  9 Sep 2024 12:42:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id NdyiFsYBEHOr; Mon,  9 Sep 2024 12:42:01 +0200 (CEST)
Received: from [172.25.230.108] (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5B6198B763;
	Mon,  9 Sep 2024 12:42:01 +0200 (CEST)
Message-ID: <6c84d516-a3fd-4b9f-a27d-8da8ff117c92@csgroup.eu>
Date: Mon, 9 Sep 2024 12:42:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: vDSO: ensure vgetrandom works in a time
 namespace
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org,
 adhemerval.zanella@linaro.org, xry111@xry111.site
References: <ZtnnZMa_Yi-UwhHT@zx2c4.com>
 <20240905173220.2243959-1-Jason@zx2c4.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240905173220.2243959-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jason,

Le 05/09/2024 à 19:31, Jason A. Donenfeld a écrit :
> After verifying that vDSO getrandom does work, which ensures that the
> RNG is initialized, test to see if it also works inside of a time
> namespace. This is important to test, because the vvar pages get
> swizzled around there. If the arch code isn't careful, the RNG will
> appear uninitialized inside of a time namespace.
> 
> Because broken code implies that the RNG appears initialized, test that
> everything works by issuing a call to vgetrandom from a fork in a time
> namespace, and use ptrace to ensure that the actual syscall vgetrandom
> doesn't get called. If it doesn't get called, then the test succeeds.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>   .../selftests/vDSO/vdso_test_getrandom.c      | 41 ++++++++++++++++++-
>   1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
> index 8866b65a4605..dfda5061f454 100644
> --- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
> +++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
> @@ -16,8 +16,11 @@
>   #include <sys/mman.h>
>   #include <sys/random.h>
>   #include <sys/syscall.h>
> +#include <sys/ptrace.h>
> +#include <sys/wait.h>
>   #include <sys/types.h>
>   #include <linux/random.h>
> +#include <linux/ptrace.h>
>   
>   #include "../kselftest.h"
>   #include "parse_vdso.h"
> @@ -239,9 +242,10 @@ static void fill(void)
>   static void kselftest(void)
>   {
>   	uint8_t weird_size[1263];
> +	pid_t child;
>   
>   	ksft_print_header();
> -	ksft_set_plan(1);
> +	ksft_set_plan(2);
>   
>   	for (size_t i = 0; i < 1000; ++i) {
>   		ssize_t ret = vgetrandom(weird_size, sizeof(weird_size), 0);
> @@ -250,6 +254,41 @@ static void kselftest(void)
>   	}
>   
>   	ksft_test_result_pass("getrandom: PASS\n");
> +
> +	assert(unshare(CLONE_NEWUSER) == 0 && unshare(CLONE_NEWTIME) == 0);

~# ./vdso_test_getrandom
TAP version 13
1..2
ok 1 getrandom: PASS
vdso_test_getrandom: vdso_test_getrandom.c:276: kselftest: Assertion 
`ret == 0' failed.
Aborted

That's too strong. When unshare() returns EINVAL it means the kernel is 
not built with CONFIG_TIME_NS. In that case the test should be SKIPPED.

And when unshare() returns EPERM, it means the user is not authorised to 
use unshare(), that's an expected error that shouldn't lead to an assert 
either, instead it should gracefully says FAILED I think.

> +	child = fork();
> +	assert(child >= 0);
> +	if (!child) {
> +		vgetrandom_init();
> +		child = getpid();
> +		assert(ptrace(PTRACE_TRACEME, 0, NULL, NULL) == 0);
> +		assert(kill(child, SIGSTOP) == 0);
> +		assert(vgetrandom(weird_size, sizeof(weird_size), 0) == sizeof(weird_size));
> +		_exit(0);
> +	}
> +	for (;;) {
> +		struct ptrace_syscall_info info = { 0 };
> +		int status, ret;
> +		assert(waitpid(child, &status, 0) >= 0);
> +		if (WIFEXITED(status)) {
> +			if (WEXITSTATUS(status) != 0)
> +				exit(KSFT_FAIL);
> +			break;
> +		}
> +		assert(WIFSTOPPED(status));
> +		if (WSTOPSIG(status) == SIGSTOP)
> +			assert(ptrace(PTRACE_SETOPTIONS, child, 0, PTRACE_O_TRACESYSGOOD) == 0);
> +		else if (WSTOPSIG(status) == SIGTRAP | 0x80) {
> +			assert(ptrace(PTRACE_GET_SYSCALL_INFO, child, sizeof(info), &info) > 0);
> +			if (info.entry.nr == __NR_getrandom &&
> +			    (info.entry.args[0] == (uintptr_t)&weird_size && info.entry.args[1] == sizeof(weird_size)))
> +				exit(KSFT_FAIL);
> +		}
> +		assert(ptrace(PTRACE_SYSCALL, child, 0, 0) == 0);
> +	}
> +
> +	ksft_test_result_pass("getrandom timens: PASS\n");
> +
>   	exit(KSFT_PASS);
>   }
>   

