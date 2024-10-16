Return-Path: <linux-kernel+bounces-367479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC079A02D2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C83D7B2587A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297041B6D00;
	Wed, 16 Oct 2024 07:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c8C523os"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A5018C039
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 07:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064456; cv=none; b=ofJ1NSzejaRTKY0x54rx/kmqiuX2O+NYAU5dmmM8vkZtpkv739TfOaEjhQHrwJHq7vm+JxaFiojHZOrtJyCP0bedPaCRZ80RiRaHHvbS0R8WjSozNomiyVsbCFWXUvRoPCJ/fnmBTnSBeth8ymOpOX4R2CJRHGhOykfHg2RfiQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064456; c=relaxed/simple;
	bh=5GVAi+bhcePsWEYVLMgDG/0Qx7jWgHtNbLsxjBpZDrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xcf88fKZdS+TqxYZoJ4AI2MqXzDmI13nXiqlsD07ue7T6C6jFPYkubKQqoCsz5HRLVVIfqlWKBZvnigF+TZ+T7GAYB7ZYCbYCI5w5NakxdjNPmsoj8YirW8E3qW9E4l4KAt6kT8dIJDLvgxPTpn2hRZmYrVOBXZNAyp4KaoOG2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c8C523os; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-50d46cfcbc1so1178004e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 00:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729064453; x=1729669253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fxdEiMjI1kbFJLU9iCKob8gjry+HYoZGnvhFNVGwWc=;
        b=c8C523os+6JKXWlZeRAf/OiH01dDmI3aLfGbBJqXzi+/qBkqGq1qRuHqfjeah7h0Uc
         bCBZ/3QAXonT6lJIqwe3cludAkzAJ2GAHiXIyLMXDUTMu3U+bLljj7w6fH6qQXkLlCdO
         oI3uNROdY6t7HgqC3o3pdaxovemQHyrKgQxzKt3xazOtFK7iuW71/97FzsrIediV1LZs
         +qGPMHGe15hogJ67+nC8IgrJ/DTVHYEIPIlMYYAdyqa1swcGynrv2ZpFoyQeoP3CW7/E
         QCnBIe9Tt9l5Ydgyh9oUXFSBhOnqk7oFky3ubsvvp0IWR6jxIHcAVcnmZn57vp5cL3/X
         4CzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729064453; x=1729669253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fxdEiMjI1kbFJLU9iCKob8gjry+HYoZGnvhFNVGwWc=;
        b=KWJeUws0Vy55clWwXMVLFfjHSZE0XaUdcBsXEvlt+H0IEzj8gbaAaE0YKjTB1+ZbQ1
         eaao43kJtQATaHEjQCJ0nFMvGLkk25OTmiXv1x4jwgbaFcmklI4zX5+8lEwJ1KElQF0+
         ZyVTdhEqHI99CI4LTSMjHFUfftmbTKqVpHbkDWlqjEiZ+MYNO0r7zTm9W91sqSz+L3Io
         PPlhCCTt9HdnkYxNNy4QqMzMueSOLx/PElWCqoYj/ziORp6z+dFQSdOMXbaJy8OzkuZF
         N1kMp0ocg8vA3qkYy2QPY38G1pblMYbatj7gIR8GtFTTOhISIuXP/tfLFIZwUy/algEU
         Pmlw==
X-Forwarded-Encrypted: i=1; AJvYcCU/SmoyQCXuk0kIpw344o2Etxb/eyHjgpM/3o0RH4mI9i+aSU52eNNWcS2p2KtsEk3YizBkxE9uSua/pz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDinCpsb3Pxapx+PTj1gIdbpjyTUj5bAbzOnaYzoxrvFiU8HJc
	6wmgdl8JLIDUFEQFQOnd5/ZwarrhGgf0ZO7dNxrIUqCotj7WNBK0TV1P7sGX1nh91S/wc8JT1Gj
	tYqWy+VnMwVeFSfHthoqs3kYeezzeAtaoP70ToA==
X-Google-Smtp-Source: AGHT+IHgEMfsjH9bzsZHBJgDDw+V22MXAo6YY84e6SPiz5FA1A06KLQhyeLPZTen3pbZWCvJC+YyQN6kc+2u67SjUsk=
X-Received: by 2002:a05:6122:4688:b0:50d:869a:e542 with SMTP id
 71dfb90a1353d-50d869ae972mr4197374e0c.9.1729064453520; Wed, 16 Oct 2024
 00:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015112329.364617631@linuxfoundation.org> <48040478-dda1-9424-9dc8-4a8bdce0987b@w6rz.net>
In-Reply-To: <48040478-dda1-9424-9dc8-4a8bdce0987b@w6rz.net>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 16 Oct 2024 13:10:42 +0530
Message-ID: <CA+G9fYuWHakzSbBeLWeL=0A47j1TXJY+eDt_cRRz7zzQ_bF+Qw@mail.gmail.com>
Subject: Re: [PATCH 6.11 000/212] 6.11.4-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Gabriel Krisman Bertazi <krisman@suse.de>, Ron Economos <re@w6rz.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Oct 2024 at 20:48, Ron Economos <re@w6rz.net> wrote:
>
> On 10/15/24 4:25 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.11.4 release.
> > There are 212 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 17 Oct 2024 11:22:41 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.11.4-rc2.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.11.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.11.4-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 9e707bd5fc5996c97d762a16515399c2afc4d70d
* git describe: v6.11.3-213-g9e707bd5fc59
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.11.y/build/v6.11=
.3-213-g9e707bd5fc59

## Test Regressions (compared to v6.11.2-559-gdd3578144a91)

## Metric Regressions (compared to v6.11.2-559-gdd3578144a91)

## Test Fixes (compared to v6.11.2-559-gdd3578144a91)

## Metric Fixes (compared to v6.11.2-559-gdd3578144a91)

## Test result summary
total: 168728, pass: 140205, fail: 2283, skip: 26240, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 131 total, 129 passed, 2 failed
* arm64: 43 total, 43 passed, 0 failed
* i386: 18 total, 16 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 16 total, 14 passed, 2 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 35 total, 34 passed, 1 failed

## Test suites summary
* boot
* commands
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-efivarfs
* kselftest-exec
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-filesystems-epoll
* kselftest-firmware
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
* kselftest-kvm
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memfd
* kselftest-mincore
* kselftest-mqueue
* kselftest-net
* kselftest-net-mptcp
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-rust
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-tc-testing
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
* kunit
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-test
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-hugetlb
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

