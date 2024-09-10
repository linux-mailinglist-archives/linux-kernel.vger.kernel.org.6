Return-Path: <linux-kernel+bounces-323963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D27974628
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 00:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF74F1C20CAF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300611AC42A;
	Tue, 10 Sep 2024 22:52:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D3F1ABEC9
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 22:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726008778; cv=none; b=WliP2J/iM4KY0MBfmIkTlEkJypB0kErt75JfAglaGIugGEaIu4i9kwbiSIoKx7zcWkW6ao7035I/WSRZCioKmMQVDlfbCgTaX8k3MDCkPziW4N/5KteMZYBO7PkFZHnGA21VxrWwnl8Hy19HFAiw5n8UmHivL6inClJ9ECWS2C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726008778; c=relaxed/simple;
	bh=AEuOSjFvT2POu0UoYo87xUjZ0K93N0gXfdmoeTffjVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=hWT7mI1/eIgnivb+352/n7uPKcDinmByUOReHJvJgLrAO581bHmZb400MyeyRH/ml8FmM3bHgMcpmcQ8+i2LiaW6LgPNQ13WFtMZ8c8Vl0Yc+1dU8nuhx7do3fFnDvgbZL3nFj5+wCCY9fDwokS1Q6E+TFDIed5kZ4HKtWoCccw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4FFA113E;
	Tue, 10 Sep 2024 15:53:23 -0700 (PDT)
Received: from [10.57.19.207] (unknown [10.57.19.207])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CC823F66E;
	Tue, 10 Sep 2024 15:52:53 -0700 (PDT)
Message-ID: <fed980be-5082-4454-b696-6245d6a3d265@arm.com>
Date: Tue, 10 Sep 2024 23:52:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: vDSO: don't include generated headers for
 chacha test
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <20240904155817.1153783-1-Jason@zx2c4.com>
Content-Language: en-US
Cc: adhemerval.zanella@linaro.org, linux-kernel@vger.kernel.org,
 mark Brown <broonie@kernel.org>, Naresh Kamboju <naresh.kamboju@linaro.org>
From: Aishwarya TCV <aishwarya.tcv@arm.com>
In-Reply-To: <20240904155817.1153783-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 04/09/2024 16:58, Jason A. Donenfeld wrote:
> It's not correct to use $(top_srcdir) for generated header files, for
> builds that are done out of tree via O=, and $(objtree) isn't valid in
> the selftests context. Instead, just obviate the need for these
> generated header files by defining empty stubs in tools/include/asm,
> which is the same thing that's done for rwlock.h.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Hi Jason,

Currently when building kselftest against next-master with arm64 arch
and defconfig+kselftest-kvm, few errors due to undeclared variables are
observed in our CI. Hence unable to build and run kselftest-kvm tests.

I ran a bisect that pointed at this patch. I have attached the bisect
log and full log from failure below.

Failure log:
-----------
https://storage.kernelci.org/next/master/next-20240906/arm64/defconfig+kselftest/gcc-12/logs/kselftest.log


In file included from /tmp/kci/linux/build/usr/include/linux/kvm.h:15,
                 from include/kvm_util.h:14,
                 from aarch64/aarch32_id_regs.c:13:
aarch64/aarch32_id_regs.c:70:27: error: ‘SYS_ID_PFR0_EL1’ undeclared
here (not in a function); did you mean ‘SYS_ICC_AP1R0_EL1’?
   70 |         KVM_ARM64_SYS_REG(SYS_ID_PFR0_EL1),
      |                           ^~~~~~~~~~~~~~~
.
.
aarch64/aarch32_id_regs.c:149:44: error: ‘ID_AA64PFR0_EL1_EL0_MASK’
undeclared (first use in this function)
  149 |         el0 = FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_EL0),
val);
      |                                            ^~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/tools/testing/selftests/../../../tools/include/linux/compiler.h:17:23:
note: in definition of macro ‘__compiletime_assert’
   17 |                 if (!(condition))
       \
      |                       ^~~~~~~~~
/tmp/kci/linux/tools/testing/selftests/../../../tools/include/linux/compiler.h:37:9:
note: in expansion of macro ‘_compiletime_assert’
   37 |         _compiletime_assert(condition, msg,
__compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/tools/testing/selftests/../../../tools/include/linux/build_bug.h:39:37:
note: in expansion of macro ‘compiletime_assert’
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
/tmp/kci/linux/tools/testing/selftests/../../../tools/include/linux/bitfield.h:62:17:
note: in expansion of macro ‘BUILD_BUG_ON_MSG’
   62 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),
       \
      |                 ^~~~~~~~~~~~~~~~
/tmp/kci/linux/tools/testing/selftests/../../../tools/include/linux/bitfield.h:125:17:
note: in expansion of macro ‘__BF_FIELD_CHECK’
  125 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET:
");       \
      |                 ^~~~~~~~~~~~~~~~
aarch64/aarch32_id_regs.c:149:15: note: in expansion of macro ‘FIELD_GET’
  149 |         el0 = FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_EL0),
val);
      |               ^~~~~~~~~
aarch64/aarch32_id_regs.c:149:25: note: in expansion of macro
‘ARM64_FEATURE_MASK’
  149 |         el0 = FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_EL0),
val);
      |                         ^~~~~~~~~~~~~~~~~~
At top level:
cc1: note: unrecognized command-line option
‘-Wno-gnu-variable-sized-type-not-at-end’ may have been intended to
silence earlier diagnostics
make[4]: *** [Makefile:299:
/tmp/kci/linux/build/kselftest/kvm/aarch64/aarch32_id_regs.o] Error 1
make[4]: Leaving directory '/tmp/kci/linux/tools/testing/selftests/kvm'


Bisect log:
-----------
git bisect start
# good: [da3ea35007d0af457a0afc87e84fddaebc4e0b63] Linux 6.11-rc7
git bisect good da3ea35007d0af457a0afc87e84fddaebc4e0b63
# bad: [6708132e80a2ced620bde9b9c36e426183544a23] Add linux-next
specific files for 20240910
git bisect bad 6708132e80a2ced620bde9b9c36e426183544a23
# good: [b66d58fce82c825b3dbb57a46b9a74f081ef7ec7] Merge branch 'main'
of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect good b66d58fce82c825b3dbb57a46b9a74f081ef7ec7
# good: [a636a90415dbc59f005369e3053996f859f0af50] Merge branch
'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux
git bisect good a636a90415dbc59f005369e3053996f859f0af50
# good: [8e5ac35ddecbeddce79e915c226baaf577a2be6e] Merge branch
'driver-core-next' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
git bisect good 8e5ac35ddecbeddce79e915c226baaf577a2be6e
# good: [e9643b5e3a2f5f0607d3b71bebe22cc6d29b534c] Merge branch
'counter-next' of
git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git
git bisect good e9643b5e3a2f5f0607d3b71bebe22cc6d29b534c
# good: [150b9788d677f54650e1aceffde0eead5986baab] Merge branch
'pwm/for-next' of
git://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git
git bisect good 150b9788d677f54650e1aceffde0eead5986baab
# good: [b4c533038255b85a068b622f888e0a9e8096a199] Merge branch
'slab/for-next' of
git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git
git bisect good b4c533038255b85a068b622f888e0a9e8096a199
# bad: [b9a71f4a0f68d11be247fd7ff82d7a72e3503181] Merge branch
'rust-next' of https://github.com/Rust-for-Linux/linux.git
git bisect bad b9a71f4a0f68d11be247fd7ff82d7a72e3503181
# good: [aeb0e24abbebebff3b5ac65486c933d0ecd5cf81] kbuild: rust: replace
proc macros dependency on `core.o` with the version text
git bisect good aeb0e24abbebebff3b5ac65486c933d0ecd5cf81
# good: [b75eb4403eefde26f8f71a66dcc609a091fa40e6] random: vDSO:
minimize and simplify header includes
git bisect good b75eb4403eefde26f8f71a66dcc609a091fa40e6
# bad: [5bc8fca346995ada9a379369492620f5d1991a08] powerpc/vdso32: Add
crtsavres
git bisect bad 5bc8fca346995ada9a379369492620f5d1991a08
# good: [c2066b95688ab8d1c296d44e325f54630688e6a7] selftests: vDSO: also
test counter in vdso_test_chacha
git bisect good c2066b95688ab8d1c296d44e325f54630688e6a7
# bad: [a727d213f81c9ffba79e161f59e120c92b9ddb1b] selftests: vDSO: don't
include generated headers for chacha test
git bisect bad a727d213f81c9ffba79e161f59e120c92b9ddb1b
# good: [67e5214e51e767d4e04d9eb5754d320c918c5ed8] arm64: vDSO: Wire up
getrandom() vDSO implementation
git bisect good 67e5214e51e767d4e04d9eb5754d320c918c5ed8
# first bad commit: [a727d213f81c9ffba79e161f59e120c92b9ddb1b]
selftests: vDSO: don't include generated headers for chacha test

Thanks,
Aishwarya

