Return-Path: <linux-kernel+bounces-430894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A209E36E5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183F928346D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800B91AB50C;
	Wed,  4 Dec 2024 09:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="t+DCl+D0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sGNWuJ6t"
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE2919047F
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733305545; cv=none; b=HBhQd0AYbs1l1MhAGYF4ehpU2D/4qPvoQg/Bh18tYEOm56uCvxPvKl9T5eoBJqtxQuOrPpiBulse875VEaHQUZP1mmkiZTUeVTeBdkl+A3n7uUw/yNWvqtf/LghOujs6B6QAn6xs7pjUGhxKhxAaPlRW9zcNOjj37TATeTF018c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733305545; c=relaxed/simple;
	bh=3hmP2GLtJyx/Ce3WCOnWXO7Md8pT9O3C/RNQndJliGw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ai326NAXFE8Ud7cqEWrfh5NquoSZNCEbRNnDmj6siW696x51n7WITgcvp0TUMOIrcDKw/R9Yqd85VKLPQTTBDd7irhQwEl3Pp2zEBFeRciBl0354/kyaEwlTq2i2I10kqDqWK8fk4MfKFgXp36PYW9oxTTLqA54CjKAtQoLmBR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=t+DCl+D0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sGNWuJ6t; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2CF0F11401FF;
	Wed,  4 Dec 2024 04:45:42 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 04 Dec 2024 04:45:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1733305542;
	 x=1733391942; bh=Q0iilQonabL8W1eFHHpHrkvpB0yU8fGWMw4T6dNuayM=; b=
	t+DCl+D0PAuyGwKsA/btZjd7YY6aEJqPq+RLtGsZbrnCA4lBpCiThWuaXioyqIP2
	L+f+D5G+lU9/7M0CgHA4+80wjQ8xCEKmkipNCVDfEYqWLmvf0vhF1z1weDEU38kA
	MeQZUiO4rsmYy84qxiQjujZlN0VNlVjKaHywCeRwU+aiuOCD5pLFwCouxbJvUxx1
	38eojlppoMNoDaa0gfayYZADFNaaDoDPMNC38oG46dWC7QbPXwGrhqZUL8UXp5vJ
	nwrmgVoSVsWXNLV3Y0AS9k5346Umwl1F3s6hXbm2vpdBenk9DKA1ULJriTCg3eeC
	bAAkH/Cf/QSC1+cT1MTIow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733305542; x=
	1733391942; bh=Q0iilQonabL8W1eFHHpHrkvpB0yU8fGWMw4T6dNuayM=; b=s
	GNWuJ6tOzIpdXsVhMFFhCNZxsAQAiZPJ6+V/O1jam78YMb8XbVnOSKlCSvEJz0g8
	xc/UKnxlE2lbjsBtDXymjigzW4EScWFhE6A7QGeMzwTUzh9rJlZtDDa0eBFtH3ne
	yyBkVcZZeTm3uaUFjxLj7mIRow6W3wbdMra7q3mxHzfsiTzeTTp+S//f+zlx/tbV
	GWbS0EiSGm41lJyd25MK2HfUNUP998ZvXENKlCmidYnH3WtfQStX42Rp291R24LM
	z+SSjmqFmIgdBc2llOP5e23Yfi+5/Ot6lPtQqaQshAUpKc78eLSMJgxqHRBQ5jtp
	+vvqi50fnb6oeBhT7EAuA==
X-ME-Sender: <xms:xSRQZ9YsTluTHV7I5lRdgp2o_encj7eLAoDkMnCDWoV_8wTrcJp9iQ>
    <xme:xSRQZ0Z3z03RtGYfTATA_SPzcJrAt799yji-VF0tPPVGVW3Uq2IkTDXo1sQXXOSEh
    d9Hn0MNqPWgNnRc3SE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieehgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpeevkeevheeftddttdffgeelkeffjeffhefgffeuueei
    udduteejgefhteetjedthfenucffohhmrghinhepthhugihsuhhithgvrdgtohhmpdhlih
    hnrghrohdrohhrghdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtg
    hpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhgruhhnvghr
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhguvghrshdrrhhogigvlhhlsehlih
    hnrghrohdrohhrghdprhgtphhtthhopegsvghnjhgrmhhinhdrtghophgvlhgrnhgusehl
    ihhnrghrohdrohhrghdprhgtphhtthhopegurghnrdgtrghrphgvnhhtvghrsehlihhnrg
    hrohdrohhrghdprhgtphhtthhopehnrghrvghshhdrkhgrmhgsohhjuheslhhinhgrrhho
    rdhorhhgpdhrtghpthhtoheplhhkfhhtqdhtrhhirghgvgeslhhishhtshdrlhhinhgrrh
    hordhorhhgpdhrtghpthhtoheprhgvghhrvghsshhiohhnsheslhhishhtshdrlhhinhhu
    gidruggvvhdprhgtphhtthhopehlthhpsehlihhsthhsrdhlihhnuhigrdhithdprhgtph
    htthhopegthhhruhgsihhssehsuhhsvgdrtgii
X-ME-Proxy: <xmx:xSRQZ_8EZyYNT7xhudPkdJOFSERHbPr5pWFXqQ1TdGifE25O08HLKQ>
    <xmx:xSRQZ7qmUeouxhphfHus4Rxaooj67oh4s1Yqswb1BGSqSplT52wgSQ>
    <xmx:xSRQZ4rdSlx-oqaZH8dsCH5pDv-WuC94f9mGCqCEjlXRAvTbb9Y_Gg>
    <xmx:xSRQZxTsCPdH-Wh274beLuNj6vPEYU5kAV0YaCSc_-0VROB0s-TwPQ>
    <xmx:xiRQZ_3pZYvW91hUev1IiKyogQ0IapZjlSzlefID6soOH0lf-f455GXS>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8D6F42220072; Wed,  4 Dec 2024 04:45:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 04 Dec 2024 10:45:21 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "open list" <linux-kernel@vger.kernel.org>, "LTP List" <ltp@lists.linux.it>,
 lkft-triage@lists.linaro.org,
 "Linux Regressions" <regressions@lists.linux.dev>,
 "Christian Brauner" <brauner@kernel.org>
Cc: "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Benjamin Copeland" <benjamin.copeland@linaro.org>, chrubis <chrubis@suse.cz>
Message-Id: <0b91d70b-bc7a-462c-a52d-092df1f91e39@app.fastmail.com>
In-Reply-To: 
 <CA+G9fYv4tUvUj1+rv5AU98QT9P8-RYVTkLAc-fCbLvy3wLtpJw@mail.gmail.com>
References: 
 <CA+G9fYv4tUvUj1+rv5AU98QT9P8-RYVTkLAc-fCbLvy3wLtpJw@mail.gmail.com>
Subject: Re: next-20241203: LTP syscalls: name_to_handle_at01 and open_by_handle_at01
 failed
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Dec 4, 2024, at 10:38, Naresh Kamboju wrote:
> The following LTP syscalls name_to_handle_at01 and open_by_handle_at01
> / 02 tests
> failed on the Linux next-20241203 tag.
>
> First seen on Linux next-20241204 tag
> GOOD: Linux next-20241128 tag
> BAD: Linux next-20241203 tag

I see Christian Brauner's pidfs series getting merged between
those tags:

06b93f9cebca selftests/pidfd: add pidfs file handle selftests
c605dbc9850c pidfs: check for valid ioctl commands
fa3364a34c29 Merge patch series "pidfs: implement file handle support"
b3b0ad5f7eb3 pidfs: implement file handle support
6bf89dd80121 exportfs: add permission method
3fa98a43cb09 fhandle: pull CAP_DAC_READ_SEARCH check into may_decode_fh()
4afd8ca9c4b4 exportfs: add open method
e911ec82c48d fhandle: simplify error handling
a5eeba41d048 Merge patch series "pidfs: file handle preliminaries"
1010ba2fe904 pidfs: support FS_IOC_GETVERSION
5fe02e1e8f8c pidfs: remove 32bit inode number handling
799a5aeedc0d pidfs: rework inode number allocation
5dc3727ebd0b Merge patch series "exportfs: add flag to allow marking export operations as only supporting file handles"
4309a6099bfd ovl: restrict to exportable file handles
5e28f4a9d373 kernfs: restrict to local file handles
29b35e260929 exportfs: add flag to indicate local file handles

Adding Christian to Cc, he probably already knows what is
going on, and if this is a regression in the kernel or a
problem in the LTP test case.

    Arnd

> List of device :
>   - juno-r2 - arm64
>   - juno-r2-compat
>   - qemu-arm64
>   - qemu-arm64-compat
>   - qemu-armv7
>   - qemu-riscv64
>   - qemu-x86_64
>   - qemu-x86_64-compat
>   - x15 - arm
>   - x86_64
>   - x86-compat
>
> ltp-syscalls:
>     * open_by_handle_at01
>     * open_by_handle_at02
>     * name_to_handle_at01
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Test failed log:
> =================
> tst_buffers.c:57: TINFO: Test is using guarded buffers
> name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (0)
> name_to_handle_at01.c:98: TBROK: fstat(1,0x7fffda449ce0) failed: EBADF (9)
>
> Summary:
> passed   1
> failed   0
> broken   1
>
> tst_tmpdir.c:316: TINFO: Using /scratch/ltp-B0Mf6pVtaR/LTP_opehXJa6X
> as tmpdir (ext2/ext3/ext4 filesystem)
> tst_test.c:1860: TINFO: LTP version: 20240930
> tst_test.c:1864: TINFO: Tested kernel: 6.13.0-rc1-next-20241203 #1 SMP
> PREEMPT_DYNAMIC @1733269464 x86_64
> tst_test.c:1703: TINFO: Timeout per run is 0h 02m 30s
> tst_buffers.c:57: TINFO: Test is using guarded buffers
> open_by_handle_at01.c:101: TPASS: open_by_handle_at() passed (0)
> open_by_handle_at01.c:97: TBROK: fstat(1,0x7fff409f94e0) failed: EBADF (9)
>
> Summary:
> passed   1
> failed   0
> broken   1
> skipped  0
> warnings 0
> tst_tmpdir.c:316: TINFO: Using /scratch/ltp-B0Mf6pVtaR/LTP_opeN4blFw
> as tmpdir (ext2/ext3/ext4 filesystem)
> tst_test.c:1860: TINFO: LTP version: 20240930
> tst_test.c:1864: TINFO: Tested kernel: 6.13.0-rc1-next-20241203 #1 SMP
> PREEMPT_DYNAMIC @1733269464 x86_64
> tst_test.c:1703: TINFO: Timeout per run is 0h 02m 30s
> tst_buffers.c:57: TINFO: Test is using guarded buffers
> open_by_handle_at02.c:98: TPASS: invalid-dfd: open_by_handle_at()
> failed as expected: EBADF (9)
> open_by_handle_at02.c:86: TFAIL: stale-dfd: open_by_handle_at() passed
> unexpectedly
> open_by_handle_at02.c:85: TBROK: close(1) failed: EBADF (9)
>
> Summary:
> passed   1
> failed   1
>
> Links:
> ---
> - 
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2pjAOWmHmfmcNEt4XL6h7GdVCZf/
> - 
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241203/testrun/26192368/suite/ltp-syscalls/tests/
> - 
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241203/testrun/26192368/suite/ltp-syscalls/test/name_to_handle_at01/log
> - 
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241203/testrun/26192368/suite/ltp-syscalls/test/name_to_handle_at01/details/
> - 
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241203/testrun/26188858/suite/ltp-syscalls/test/open_by_handle_at02/history/
>
> Steps to reproduce:
> ------------
> - tuxmake \
>         --runtime podman \
>         --target-arch arm64 \
>         --toolchain gcc-13 \
>         --kconfig
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2pjAOWmHmfmcNEt4XL6h7GdVCZf/config
>
> metadata:
> ----
>   git describe: 6.13.0-rc1-next-20241203
>   git repo: 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   git sha: c245a7a79602ccbee780c004c1e4abcda66aec32
>   kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2pjAOWmHmfmcNEt4XL6h7GdVCZf/config
>   build url: 
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2pjAOWmHmfmcNEt4XL6h7GdVCZf/
>   toolchain: gcc-13
>   config: gcc-13-defconfig-lkftconfig
>   arch: arm64
>
> --
> Linaro LKFT
> https://lkft.linaro.org

