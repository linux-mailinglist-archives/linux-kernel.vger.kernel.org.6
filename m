Return-Path: <linux-kernel+bounces-294293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DAF958BBC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75D77B21EB1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13016194149;
	Tue, 20 Aug 2024 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="x00s4fu6"
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D851429A
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724169491; cv=none; b=K8CIEdAUZSbqodjdnCytsjQM3xc7YA83kIXRIjqLfKRVuG8oMXInqzeXcsvOW8iDHHqiF4EBpbB9dND+ml4c6RhBJq3RqaE+jJKbgNBnP5Z9RxC9y6+pc3hqlfx7rwZKLQhowuOb+KLMNYj+bpmEUJWNOzrFSalo6Lu4ZdoqWgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724169491; c=relaxed/simple;
	bh=qau0AZsttkTMDre7qzTMPATogDqEToRJf7Gckq4n0As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rG1HRcMxA7a5OnhaAS+AFFWK7KFs4mCyiF6G65JUap2spbhinBnlRsricRY27KpGFsQDr049zdAQx52/H4R18oLcyKBV6WT5fXvSzdakbs//qYG4j/3ahQfj1e8coFpE6aN7UfFb/pJaaVhhn6AP/RzIbPSFCRYhiwQQF/kRwDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=x00s4fu6; arc=none smtp.client-ip=83.166.143.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WpDdV5BVFzFQp;
	Tue, 20 Aug 2024 17:58:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1724169486;
	bh=+BR8L0axucrbNk5CJOLL6QFgYFq0cmy2eGES+WXtrdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x00s4fu6OWYfApJPJyMssLpi6cNIM9UiwB+BAru6VNxzde4Ed/APfusz2LokH5+ow
	 psGM/lbTXtX5efMde9XXuwyteJlTDpEUBewPSoJa/DMpCtKjnus9bY/9x09Y513VEP
	 ZG9WV45Bp5jksGuEuVSbfqplxD1RiQMVpVvWKltI=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WpDdV1gQZzvmZ;
	Tue, 20 Aug 2024 17:58:06 +0200 (CEST)
Date: Tue, 20 Aug 2024 17:58:02 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v10 2/6] selftests/Landlock: general scoped restriction
 tests
Message-ID: <20240820.nah8bahngaiF@digikod.net>
References: <cover.1724125513.git.fahimitahera@gmail.com>
 <6c0558cefc8295687f8a3a900b0582f74730dbb2.1724125513.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c0558cefc8295687f8a3a900b0582f74730dbb2.1724125513.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

"Re: [PATCH v10 2/6] selftests/Landlock: general scoped restriction"
This subject is still incorrect, please use this instead:
"selftests/landlock: Add common scope tests"

The same rule for the subject prefix should be followed for all other
commits (see my previous review).

On Mon, Aug 19, 2024 at 10:08:52PM -0600, Tahera Fahimi wrote:
> The test function, "ruleset_with_unknown_scoped", is designed to
> validate the behaviour of the "landlock_create_ruleset" function
> when it is provided with an unsupported or unknown scoped mask.
> 
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> ---
>  .../testing/selftests/landlock/scoped_test.c  | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 tools/testing/selftests/landlock/scoped_test.c
> 
> diff --git a/tools/testing/selftests/landlock/scoped_test.c b/tools/testing/selftests/landlock/scoped_test.c
> new file mode 100644
> index 000000000000..aee853582451
> --- /dev/null
> +++ b/tools/testing/selftests/landlock/scoped_test.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Landlock tests - Scope Restriction

Landlock tests - Common scope restrictions

> + *
> + * Copyright © 2024 Tahera Fahimi <fahimitahera@gmail.com>
> + */
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <linux/landlock.h>
> +#include <sys/prctl.h>
> +
> +#include "common.h"
> +
> +#define ACCESS_LAST LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET
> +
> +TEST(ruleset_with_unknown_scoped)

"ruleset_with_unknown_scope" makes more sense (also in the commit
message).

> +{
> +	__u64 scoped_mask;
> +
> +	for (scoped_mask = 1ULL << 63; scoped_mask != ACCESS_LAST;
> +	     scoped_mask >>= 1) {
> +		struct landlock_ruleset_attr ruleset_attr = {
> +			.scoped = scoped_mask,
> +		};
> +
> +		ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr,
> +						      sizeof(ruleset_attr), 0));
> +		ASSERT_EQ(EINVAL, errno);
> +	}
> +}

Good!

> +
> +TEST_HARNESS_MAIN
> -- 
> 2.34.1
> 
> 

