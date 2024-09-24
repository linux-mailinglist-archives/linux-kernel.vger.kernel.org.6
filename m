Return-Path: <linux-kernel+bounces-337035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDEB984474
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F101F23F9C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6B51A3A9A;
	Tue, 24 Sep 2024 11:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uzanYcNi"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785C61A270
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 11:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727177015; cv=none; b=AuT3sHSubbkpa7EynAIHVWQHotQ+BuUq4EjXWs+JbdrLjZsLdh3ooa5HXAPnhAutffRYUhTtAeAFAPprb9Nd27sRqqdiob1QgYNmBG1b5kTqoQ85Q6KxZCQuZWwSRjV6Gm0nQmidzKOwRlBQMDjNc/3f9rrBD0UwaioFlAP8rm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727177015; c=relaxed/simple;
	bh=bQRUkudaiO8uCsCczaXYpDU5zY+jAYNiEvB1WHfLw9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zkv/YnSrAIktKkmKrhXwoLCWwij/AIctfnymTvhHKC6pTsNDjb7fON/BZk0bf+AkvLRFUW1ll5o+zkhvtb8FDTRHLTrIbL3zg3uM6bsCZFbDFTAfARYa69s38camRqRMQs1tZOp2QGdG/MWseipT4K3vH8yu4lgCChqGkZNI4W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uzanYcNi; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-502af8a83daso1674362e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 04:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727177011; x=1727781811; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KjdEl0kfRqlw8okFJhhXvORQBqugd848yp2a6Kz7jtI=;
        b=uzanYcNiTobz+EUbzYKDJ34bFtRNGWkdxvLooX5wgJyq/KgQ8BUvORZIX1RzSf6KWQ
         aAf8FnlN92WT2wYW3EoVfQ6L6FsPYNQ3I9EDkvH9+H9Pod8RRcnuTuJqpfcAusqa+qIC
         j1L4JU2uFsh0T5BaJKXpfyaIYRtP4n6kD4auFWsBrDOBzTychWYsB6B0158ZAGdfbPKh
         VTDD3auXiSpSfvMDUkaKEwR2hRTdz0b8nJI9Ykw1zBrJWUfHVnktLSqql6EPvHxyyW8y
         9JGwEOq8MhgYTTnDcXEEXubtFnUOnsACNuc72euMImJOUUc0OEIEzQ6JEiPDnK7LBwR1
         KKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727177011; x=1727781811;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KjdEl0kfRqlw8okFJhhXvORQBqugd848yp2a6Kz7jtI=;
        b=k98sm1dlPKmV8xxAvNGwZ0j0VbZvr8PP+1DEAkiFQqVYTF8BtqcnUoDuPUU9cd9zaW
         w1A8b+BhRCMpSEyx86GWNfEyW5/zrVdM3jvOJmLYV0P9SPbuh3Nb53krRU/tP+bisvgi
         UoD/zGGx4RSlfIOA21rHWybgl1i/zJJWolNOGN0vapen2zE4XoYkWqj34gbp0mdiSA5J
         KOsf0Vq/7DwY5mmjoTUwZG5n8XeiuNx6fcafwsUQKoilr5j4VRFj24EGlgMfmrT+E3HP
         YDK+WuhR7yFbowKWt05XpXvXfQIElXUBkw3gQ/rIqXUEmyjrS33H9Mb1mQVreeYDo9mB
         cwvw==
X-Forwarded-Encrypted: i=1; AJvYcCW6XrD64zibzdtgIDWq24AURQ6hgjIANCitQ8UJ770BOZ5yc8oED9aUr/ebGmH7g7O+a2ksRh3lVnhAkcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQihBDRdwAM6tCyE3RA2Krnn87Gwy3mKptEctVn8zhR8XJAhUU
	Ie9ksUcv47rTU6LgsI4LFej/VuPNekc8H0Gv3G1IFJ/nBkzpQTF2Zwr93VPDZjOD+oISWIFNI0N
	n7HCiPkkTyRr33Rhjc0nU6eAf00t9JDZ6zLdjihUmci3Iue0WeYk=
X-Google-Smtp-Source: AGHT+IEI7XjbuorHGWTR1E3X/+r/7ORf73vJlzjELjbAYRDPDVaPLPO0nhzOjurzdZrh5ZpFYfyg/8r0kv6TUteT69Y=
X-Received: by 2002:a05:6122:2213:b0:503:d875:6a26 with SMTP id
 71dfb90a1353d-503e0400c97mr9329354e0c.5.1727177011299; Tue, 24 Sep 2024
 04:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYtu-h_pp_hNfmx1pBg48oGeRiEDnEc4b-r3AiC_QfWiKg@mail.gmail.com>
In-Reply-To: <CA+G9fYtu-h_pp_hNfmx1pBg48oGeRiEDnEc4b-r3AiC_QfWiKg@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 24 Sep 2024 16:53:18 +0530
Message-ID: <CA+G9fYsHQ_q9e5GYVpdMmaRrgR1zvoyFH0wP0RzbqUFBTuNq9Q@mail.gmail.com>
Subject: Re: af_alg01.c:36: TFAIL: instantiated nested hmac algorithm ('hmac(hmac(md5))')!
To: LTP List <ltp@lists.linux.it>, open list <linux-kernel@vger.kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc: "David S. Miller" <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, chrubis <chrubis@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Sept 2024 at 15:16, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> The following LTP crypto tests failed on Linus mainline master branch.
>
> LTP
>   ltp-crypto:
>     * af_alg03
>     * af_alg01
>
> First seen on e8fc317dfca9 (v6.11-2185-ge8fc317dfca9)
>   Good: v6.11-rc7
>   BAD:  e8fc317dfca9 (v6.11-2185-ge8fc317dfca9) and (v6.11)

Also seen on Linux next from next-20240909 tag.

Good:  next-20240906
Bad:   next-20240909

>
> Devices and qemu's:
>   - dragonboard-410c
>   - dragonboard-845c
>   - e850-96
>   - juno-r2
>   - arm64
>   - qemu-arm64
>   - qemu-armv7
>   - qemu-riscv64
>   - qemu-x86_64
>   - rk3399-rock-pi-4b
>   - x15
>   - x86_64
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Warning log:
> ----------
> tst_test.c:1617: TINFO: Timeout per run is 0h 02m 30s
> af_alg01.c:36: TFAIL: instantiated nested hmac algorithm ('hmac(hmac(md5))')!
> tst_af_alg.c:46: TBROK: unexpected error binding AF_ALG socket to hash
> algorithm 'hmac(hmac(md5))': EINVAL (22)
>
> HINT: You _MAY_ be missing kernel fixes:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=af3ff8045bbf
>
> HINT: You _MAY_ be vulnerable to CVE(s):
>
> https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-17806
>
> HINT: You _MAY_ be missing kernel fixes:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=af3ff8045bbf
>
> HINT: You _MAY_ be vulnerable to CVE(s):
>
> https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-17806
>
> ...
> tst_test.c:1617: TINFO: Timeout per run is 0h 02m 30s
> af_alg03.c:22: TFAIL: instantiated rfc7539 template with wrong digest size
>
> HINT: You _MAY_ be missing kernel fixes:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e57121d08c38
>
>
> boot Log links,
> --------
>  - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.11-8836-gf8eb5bd9a818/testrun/25191971/suite/ltp-crypto/test/af_alg03/log
> - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2m983y1hatxwkXBtrAYvCPw6pK2
>
> Test results history:
> ----------
> - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.11-8836-gf8eb5bd9a818/testrun/25191971/suite/ltp-crypto/test/af_alg01/history/
> - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.11-8836-gf8eb5bd9a818/testrun/25191971/suite/ltp-crypto/test/af_alg01/history/
>
> metadata:
> ----
>   git describe:  v6.11-2185-ge8fc317dfca9 .. v6.11-5002-g200289db261f
>   git repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
>   git sha:  abf2050f51fdca0fd146388f83cddd95a57a008d  (v6.11)
>   kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2m980TaGzPk0qjtFUPnMNoDj7Sw/config
>   build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2m980TaGzPk0qjtFUPnMNoDj7Sw/
>   toolchain: gcc-13
>
> Steps to reproduce:
> ---------
> - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2m983y1hatxwkXBtrAYvCPw6pK2/reproducer
> - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2m983y1hatxwkXBtrAYvCPw6pK2/tux_plan
>
> --
> Linaro LKFT
> https://lkft.linaro.org

- Naresh

