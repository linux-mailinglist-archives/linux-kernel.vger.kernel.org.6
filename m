Return-Path: <linux-kernel+bounces-206266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC319006BC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA84A1C23159
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C266219751A;
	Fri,  7 Jun 2024 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcHJ5YQB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE74194A6D;
	Fri,  7 Jun 2024 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770812; cv=none; b=e85c33LGvAz7wmhvmF1Ga69He5IWTBSLYYUYsyKfujB2Dvx3Ik//UfK2UMmAO/2RbTDCwYQdmQx+t0uBBV8GPgnOoUqupC9BOHowL+wXDx53y7uEhApSBpogF3IBoFrV/+QiF83wBb1OhO4EyVEBBZDUkVuRExGvx3hmC7CYGi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770812; c=relaxed/simple;
	bh=1fJgL+gvkpFtIMZd+hZjnYhZnWd6hhbAFJ2oi8aDz+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7TitMDNTthksOMMM6YYnsqHeTF8GVbwpJ3IR+NxLPlI8YTIAmZpbnTbAKGPAym9crvMs7In3KxhkomnVjfju//Zja2TRQLD++wwgSw5Ds2WNpc/8E/7tBv29Xgjf3yH7zkWkPRirxEBm4rO2HVzB80B+Fr9CcXxtxIbN9Ue/7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcHJ5YQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A68C2BBFC;
	Fri,  7 Jun 2024 14:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717770811;
	bh=1fJgL+gvkpFtIMZd+hZjnYhZnWd6hhbAFJ2oi8aDz+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qcHJ5YQBJrRPMtyAFbLlu9GHAeC9NT5Q3u8NINORsfudV7rkwjCMJMj+oDlRlJAmG
	 aKhGbMSICzRp1f56c9eAY7NrYb8ydXDLOp//wJKwCnPTbjiefiQZScBZraJstzyLFt
	 kfwFAf9X/51yuaGMBhTMoql4H8J2W/z+5rlPrlEyNavWtgiDzEZMlL0RHzvBkvA2Cg
	 XVltm72MTlhxeYj9bqhnuCOQwpwqXIqcbm8zofCqufbBS0kt6VKbiimDOReS+YNvh3
	 psJi6sGRhCFoNEMP7os6sCDSMN7e5ocsxTPYM5FIPZBBhLv7LgYB/EL6jl/ZfIHwkC
	 R7zQwnzaruNRw==
Date: Fri, 7 Jun 2024 07:33:29 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Christian Schrefl <chrisi.schrefl@gmail.com>
Cc: llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>
Subject: Re: [Bug] Failing kunit test on ARCH=arm and LLVM=1
Message-ID: <20240607143329.GA2483293@thelio-3990X>
References: <0bfc6b38-8bc5-4971-b6fb-dc642a73fbfe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bfc6b38-8bc5-4971-b6fb-dc642a73fbfe@gmail.com>

Hi Christian,

On Fri, Jun 07, 2024 at 02:37:19PM +0200, Christian Schrefl wrote:
> Greetings,
> 
> when trying to port Rust to ARM I noticed that the DEFINE_FLEX_test
> kunit test in lib/overflow_kunit.c:1188 fails when combining LLVM=1
> and ARCH=arm.
> 
> I have reproduced this on v6.10-rc1 and next-20240606.
> 
> Here is the clang/llvm version I'm using:
> clang version 18.1.6 (Fedora 18.1.6-3.fc40)
> Target: x86_64-redhat-linux-gnu
> Thread model: posix
> InstalledDir: /usr/bin
> Configuration file: /etc/clang/x86_64-redhat-linux-gnu-clang.cfg
> 
> I have not looked closer at the failure so I'm unsure if this is a
> problem with LLVM or if the test case is to speciffic.

Thanks a lot for the report! I can reproduce this with tip of tree LLVM
as well.

$ echo 'CONFIG_KUNIT=y
CONFIG_OVERFLOW_KUNIT_TEST=y
CONFIG_RUNTIME_KERNEL_TESTING_MENU=y' >kernel/configs/repro.config

$ make -skj"$(nproc)" ARCH=arm LLVM=1 {def,repro.}config zImage

$ boot-qemu.py -a arm -k .
...
[    0.000000] Linux version 6.10.0-rc2-00235-g8a92980606e3 (nathan@thelio-3990X) (ClangBuiltLinux clang version 19.0.0git (https://github.com/llvm/llvm-project e635520be888335dd59874038d33e60cca3a7143), ClangBuiltLinux LLD 19.0.0) #1 SMP Fri Jun  7 06:12:02 MST 2024
...
[    1.832472]     # castable_to_type_test: 75 castable_to_type() tests finished
[    1.833483]     ok 21 castable_to_type_test
[    1.834122]     # DEFINE_FLEX_test: EXPECTATION FAILED at lib/overflow_kunit.c:1188
[    1.834122]     Expected __builtin_dynamic_object_size(two, 0) == sizeof(struct foo) + sizeof(s16) + sizeof(s16), but
[    1.834122]         __builtin_dynamic_object_size(two, 0) == 8 (0x8)
[    1.834122]         sizeof(struct foo) + sizeof(s16) + sizeof(s16) == 12 (0xc)
[    1.834746]     not ok 22 DEFINE_FLEX_test
...

I don't see the same failure with GCC 13.2.0. This test fails when
building for arm64 and x86_64 as well, so it does not appear to be
architecture specific.

I think I see what is going on here. Looking at the documentation for
DEFINE_RAW_FLEX(), it states "Define an on-stack instance of structure
with a trailing flexible array member, when it does not have a
__counted_by annotation." but commit d8e45f2929b9 ("overflow: Change
DEFINE_FLEX to take __counted_by member") defined 'struct foo' with
__counted_by on it. __counted_by informs __builtin_dynamic_object_size()
about the size of the flexible array. With DEFINE_FLEX_RAW, the counter
is zero, so the size of array in 'struct foo' is zero, meaning this test
is incorrect when built with a compiler that supports __counted_by,
which is just Clang 18+ right now (it should land in GCC 15 if I
understand correctly).

I see two potential solutions that work for me.

One would be to stop using DEFINE_RAW_FLEX() and match the other uses
(but I assume testing DEFINE_RAW_FLEX() was intentional):

diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index 4ef31b0bb74d..883670adf0cc 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -1180,7 +1180,7 @@ struct foo {
 
 static void DEFINE_FLEX_test(struct kunit *test)
 {
-	DEFINE_RAW_FLEX(struct foo, two, array, 2);
+	DEFINE_FLEX(struct foo, two, array, counter, 2);
 	DEFINE_FLEX(struct foo, eight, array, counter, 8);
 	DEFINE_FLEX(struct foo, empty, array, counter, 0);
 

The other would be making the size of the array conditional on not
having __counted_by support (which is admittedly ugly):

diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index 4ef31b0bb74d..7eed0890e25f 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -1185,7 +1185,11 @@ static void DEFINE_FLEX_test(struct kunit *test)
 	DEFINE_FLEX(struct foo, empty, array, counter, 0);
 
 	KUNIT_EXPECT_EQ(test, __struct_size(two),
-			sizeof(struct foo) + sizeof(s16) + sizeof(s16));
+			sizeof(struct foo)
+#if !__has_attribute(__counted_by__)
+			+ sizeof(s16) + sizeof(s16)
+#endif
+			);
 	KUNIT_EXPECT_EQ(test, __struct_size(eight), 24);
 	KUNIT_EXPECT_EQ(test, __struct_size(empty), sizeof(struct foo));
 }

Kees, am I missing anything here?

Cheers,
Nathan

