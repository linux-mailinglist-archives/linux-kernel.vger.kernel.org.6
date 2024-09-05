Return-Path: <linux-kernel+bounces-316417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AD396CF4F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782ED1C22175
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 06:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC39E18BC38;
	Thu,  5 Sep 2024 06:32:24 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E667E18BC2D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 06:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725517944; cv=none; b=lD0G04rWnD48QNt/9zu13udEwWnIVLPNJj+pWOqcJzy6BcbNqqlqIMI1WXW3DUNsSlpw7bNPvcEcXLF1JD+aUk4IlZq/FMEzxvuF0A1wJVvbwHpMm4nc+95t6XznSqBi4YJ02NkqQ+UkM94OZ+o3u1Hj71tLjzpo0E7r9YRZTfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725517944; c=relaxed/simple;
	bh=FF/v0cO56JdeEGGQmy8iK56K3pm0dCsbB4CmCDcIRxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PN8T+fGP9xlJfiwmW/ld61CS0PNxhEbN3udGdRPiBt2Tiue63W4k+Z72anunsPN1IM6tkMFUu++H2Lf6ZnMT4G3yhCUHT3WWC6ChVa4D3F/TtEAOOZ9Yj1pXHevm8zfG1UXuUP/gbWSLAGr68CO99kYnh+E5ZDV3LRmu0H81avE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by mail.home.local (8.17.1/8.17.1/Submit) id 4856WErN001383;
	Thu, 5 Sep 2024 08:32:14 +0200
Date: Thu, 5 Sep 2024 08:32:14 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] nolibc for 6.12-rc1
Message-ID: <ZtlQbpgpn9OQOPyI@1wt.eu>
References: <3b9df0a1-7400-4c91-846d-b9e28982a7c3@t-8ch.de>
 <9de5090f-038f-4d68-af96-fbb9ed45b901@linuxfoundation.org>
 <f882fa56-c198-4574-bb12-18337ac0927e@linuxfoundation.org>
 <9440397d-5077-460d-9c96-6487b8b0d923@t-8ch.de>
 <13169754-c8ea-4e9e-b062-81b253a07078@linuxfoundation.org>
 <e594db6c-5795-4038-bcb2-1dc3290bfb27@t-8ch.de>
 <ZtlOGkADy7OkXY9u@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtlOGkADy7OkXY9u@1wt.eu>

On Thu, Sep 05, 2024 at 08:22:18AM +0200, Willy Tarreau wrote:
> > 
> > ./run-tests.sh -p -m user
> > 
> > These toolchains can then also be used for direct "make" invocations
> > through CROSS_COMPILE.
> 
> I really suspect an empty CC variable somewhere that could explain why
> only CROSS_COMPILE is used. I'll try to find time today to give it a
> try here as well, just in case I can reproduce the same issue.

In fact I'm getting it without any options:

  $ ./run-tests.sh
  realpath: /home/willy/.cache/crosstools/gcc-13.2.0-nolibc/i386-linux/bin/i386-linux-: No such file or directory

It comes from here in test_arch():

        cross_compile=$(realpath "${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}/bin/${ct_arch}-${ct_abi}-")

Thus it's indeed related to the absence of the toolchain there. It's
just that the way the error is reported (due to set -e) is a bit harsh.

What about this ?

  $ ./run-tests.sh 
  No toolchain found in /home/willy/.cache/crosstools/gcc-13.2.0-nolibc/i386-linux.
  Did you install the toolchains or set the correct arch ? Rerun with -h for help.
  Aborting...

or anything similar, achieved by this patch (warning copy-paste, mangled
indents):

diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
index e7ecda4ae796..0f67e80051dc 100755
--- a/tools/testing/selftests/nolibc/run-tests.sh
+++ b/tools/testing/selftests/nolibc/run-tests.sh
@@ -143,6 +143,13 @@ test_arch() {
        arch=$1
        ct_arch=$(crosstool_arch "$arch")
        ct_abi=$(crosstool_abi "$1")
+
+       if [ ! -d "${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}/bin/." ]; then
+               echo "No toolchain found in ${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}."
+               echo "Did you install the toolchains or set the correct arch ? Rerun with -h for help."
+               return 1
+       fi
+
        cross_compile=$(realpath "${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}/bin/${ct_arch}-${ct_abi}-")
        build_dir="${build_location}/${arch}"
        if [ "$werror" -ne 0 ]; then

Willy

