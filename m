Return-Path: <linux-kernel+bounces-325678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E11D0975D0C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95C01C224E9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAC61B86D0;
	Wed, 11 Sep 2024 22:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="OpTinlDO"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9374A15665E
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 22:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726093247; cv=none; b=CJB6cS6bAKADk49gSYpcTekKROtAhVvLCqf0RxuG6WLFtZm1Olyb63S8+36JfMghI+9UILY61TYLM86sq6qzIMSVGfgZ55h9HK+FjA6SQkJBxoBk0vbnbNt0dXo73ctQ6pRKM4MtHBPn6CZrpLdJ3jHP1WNYYkTK+hH2cd+xsbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726093247; c=relaxed/simple;
	bh=6fLxcYrOQQA+m+AIGGkPMdruL+3RcmZdzbX5zPpJ20k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=lY6PO7s/QEPxu8yvfy0gPdQUr2HMMSt8BHafWOFtKSXCnnYl3ZpLJYjDic9lQReXO9dzzl7gyXnNO1LC/1X9IKcCBQv6jXniDHF45V5Pc5vNsdaafu4gUn9hsVqtpgejFu3ruFPOVuYKdjwWqb0GahSy2A6J++wX6Z2a4qfiLvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=OpTinlDO; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 58F4E3F2F2
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 22:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1726093243;
	bh=6fLxcYrOQQA+m+AIGGkPMdruL+3RcmZdzbX5zPpJ20k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type;
	b=OpTinlDOINa6ENiUpnKKGjJQ/6d2jbvwtVG4GZhNBX0oLs11yL+v2QDYlsbgB1kve
	 ZXFMT6TTrwOE1ooDh0Yp+jwfYnuZF569Oxi9S+7Mlwv7MhR95DgeLCaaNqB7pU+g2E
	 g1RrwskSC85xNfGO2YwFLiDIeM7LYPpUAUjZVk972WBQl85PWxsYA2erzF1bPDg3qz
	 coCw5wHNMHGdxXL0tFfd3PwW2UjDkE1jllhIy36IfeVYfaQSuY2BbcQ1ePi6PkSJte
	 Hnp9w30nmPGuh/9g/xNoCBd09OcaiJg81P9gMaySJjHVAAXBb3I97z531IDpReP2w8
	 qJ5tO3bD2yIWg==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5c3c27141c9so149391a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 15:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726093241; x=1726698041;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6fLxcYrOQQA+m+AIGGkPMdruL+3RcmZdzbX5zPpJ20k=;
        b=RGWGhW99IEnCBpPo/R7zy+7kYtqpJrApQNC3KmCLukF6/yWMmdgcEyJvKTm5x36y3y
         cKzF2dXSnzuSeDmPf4Aqohjdu3gaImZ8s1xP/PAQ+rMZ9j5wc5Ey6y0KwtwJ9nYsBRs/
         8WwJ6+tefNWAHkd80TE4AOB493XYXYcwnas6j32vP/oFnKPoddgTRw/NH3UEqHbmayx4
         FQFplJUF2HPM7GwF4NooBDlstKFwf09OTqXFCn/X0860GF80ZuqRFgYmtZwwO+pBEBYH
         ZVj7IpwblmPAa3GFoFJKUx/PbiAwEVO7zN6DNvWcr4tlIK3ACs8ytIzsd0XWlasQqUyF
         mKSw==
X-Forwarded-Encrypted: i=1; AJvYcCUJfvqYCpVKPHAJqCly0vKqINb8pb0n0hi8TPpl7Bq4p3pBm45Rxk66DK1jiX0xpcLSa3Jw/oqw9xvHv0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIgkG0OSRknjPA91HBE9ngY0e5r/2YPyJgv0B3ZkA6/CzXSYzV
	Ll/e9YNqXKaFJr7MS2fe3gqAGMuGt5gH9xm2/wyth6pj3RUvGWMOXT/XYsXA3P4WSAGV2U5Mcbg
	1AsXc6XFnzXdzjGlhqg8FiEDMz+O4B0i6GFfGlyBf5D4Pg4Bw+pya7s1gEk1LIbmIAG3mUx5+Xt
	Yi7cocbWb2qWESY389o+7lyhfOUm1dPQTy/clHBpwcV8eAUJW03XpI
X-Received: by 2002:a05:6402:d06:b0:5c3:d0d9:dafb with SMTP id 4fb4d7f45d1cf-5c413e204ddmr549369a12.18.1726093241539;
        Wed, 11 Sep 2024 15:20:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTcajhxeWWd3SregpvGVod0mzMDtfb5zLZ0X+BcACSQzdaH3TPTPrPigfHLi4IPATA+RiiRvRAaups9GPR8as=
X-Received: by 2002:a05:6402:d06:b0:5c3:d0d9:dafb with SMTP id
 4fb4d7f45d1cf-5c413e204ddmr549341a12.18.1726093240493; Wed, 11 Sep 2024
 15:20:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Wed, 11 Sep 2024 17:20:29 -0500
Message-ID: <CAHTA-uZDaJ-71o+bo8a96TV4ck-8niimztQFaa=QoeNdUm-9wg@mail.gmail.com>
Subject: Namespaced network devices not cleaned up properly after execution of
 pmtu.sh kernel selftest
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jacob Martin <jacob.martin@canonical.com>, dann frazier <dann.frazier@canonical.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

We recently identified a bug still impacting upstream, triggered
occasionally by one of the kernel selftests (net/pmtu.sh) that
sometimes causes the following behavior:
* One of this tests's namespaced network devices does not get properly
cleaned up when the namespace is destroyed, evidenced by
`unregister_netdevice: waiting for veth_A-R1 to become free. Usage
count = 5` appearing in the dmesg output repeatedly
* Once we start to see the above `unregister_netdevice` message, an
un-cancelable hang will occur on subsequent attempts to run `modprobe
ip6_vti` or `rmmod ip6_vti`

Jacob and I have both investigated various conditions under which this
bug state does / does not occur, which is documented more thoroughly
in the following BugLink:
https://bugs.launchpad.net/ubuntu-kernel-tests/+bug/2072501

We expect that veth_A-R1's refcount should be cleaned up by the time
execution of pmtu.sh finishes since the relevant namespaces are
deleted during cleanup of the test suite. We've observed this behavior
on several kernels, at least as old as stable branches like
linux-6.1.y and as recent as v6.11-rc6, so this does not seem like a
new regression. (did not have a chance to test on rc7 yet).

This issue also only occurs very infrequently, and reproducibility is
extremely susceptible to very minor timing variations in the pmtu.sh
test case. (in fact, I was unable to reproduce the bug with the
version of pmtu.sh and lib.sh in v6.11-rc6 - not because the kernel is
unaffected (it is affected, as confirmed by running an older kernel's
pmtu.sh on it), but because v6.11-rc6 introduces some unrelated
functional changes to the tests that cause a slightly longer test
execution time.)
It is also difficult to reproduce the bug on slower CPUs, or even on
faster CPUs where the cpufreq scaling governor is not set to
`performance`.

However, I can easily reproduce the issue on an Nvidia Grace/Hopper
machine (and other platforms with modern CPUs) with the performance
governor set by doing the following:
* Install/boot any affected kernel
* Clone the kernel tree just to get an older version of the test cases
without subtle timing changes that mask the issue (such as
https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/noble/tree/?h=Ubuntu-6.8.0-39.39)
* cd tools/testing/selftests/net
* while true; do sudo ./pmtu.sh pmtu_ipv6_ipv6_exception; done

If running on an appropriately fast CPU, you should start seeing
`unregister_netdevice: waiting for veth_A-R1 to become free. Usage
count = 5` in dmesg at some point. (On Grace/Hopper, it happens in
under a minute, reliably). After that point, attempts to interact with
ip6_vti will hang.

Please let me know if there is any other info I can provide to assist
in debugging this.

Thanks,
Mitchell Augustin
Software Engineer - Ubuntu Partner Engineering

