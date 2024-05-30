Return-Path: <linux-kernel+bounces-194989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA168D4591
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 08:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536801F22977
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 06:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379693DABF3;
	Thu, 30 May 2024 06:45:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5988A79EF
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 06:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717051505; cv=none; b=k/B1pns1Z2ug25zG8Lc/x5WErZcmL6FJUxESJ6plHIe+EvgAaybsZJAYiYLnCVYSyBQBVRRoGBNZeF+ZxSBgJr+Bw65uFNN9mukoSiZ9fQNkfbLmh53fODZe8P1prdRjjyxfAUI6tVxwJEdH89lKJk01wEXtPUJC3d+QLEMT2KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717051505; c=relaxed/simple;
	bh=fZ6JVj9FVsmG5Va9ODPnUUwA3gdkY5wqGiOv2twyTaI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ob/eXSqc6VhC2oOMxAtmtRjRQUDY8znZD6zKGxGeByu8JvW8DiJQFLau/7++t+hFWPkVMsqv3yn1QlnCunHZCr31mH2+cyc7L14NazVIPiLf0tAWm7Zftw5gz91T0tj2vU0nNvDmuGW8k1xLzNt3ULtrIOK0PskcxElkeBqwaok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e255f62e6cso60222639f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 23:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717051503; x=1717656303;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9de7HyQccscfkAIwx6rdRHkvZj81cQPTUecwCb2VX8=;
        b=X+Lfzn0iujD+yJjaEfyuoBX19Ncevqu4t8HeCSDCJsdgC403cdBM6/AFUDk62Goyi7
         icQonuFv3vWgqGTlOv83raThvxsqS6prAuEN/q4L0h7fVgwo7qlqz2geyLo0zvemQdyk
         737bcnUXGdblyFt8h827Rbe1cCzwEFpOh4GnwI4SE3GbXJRqpQ1rak43eFXjm5+aBEqQ
         vqce5ob7DqQA7oEBV7Vst78mJlG0gyOFC6B2FebBpud3EUof5wppV/uBsg5U3mpz1AAj
         OlanWLBp5j8+WgdPNQMjgM/LX7UzAONO2pPvqzIPDK4smV4QrPRuv6jE7ZhrvTtuoFiN
         4loQ==
X-Gm-Message-State: AOJu0YwBiiS6YR3FY9mrjtsRDU8SjvxB1/bpFnNJ0X/LvFG3MOGyCLfK
	Begpf9VF6xyIl8ohOKy5IQhmFtkvVxjv0ZE7NpfmuWa29EYy+FLg5OylpgevVmocy567odi8CaH
	H0FyPWLW2FN6OA4ypQbG1pm4IROcH40iTrERgSEoevCnhIZIilzScdtE=
X-Google-Smtp-Source: AGHT+IGNz91takmQ5WyLwU7XzMo5OOYjgYEZSvIsMwO1oEljHcsRyKdVK/uFoGg9RURYgXXltIuPqMC0UVWMQ/xZp+hY2jD17Ol5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3403:b0:7da:bccd:c3e3 with SMTP id
 ca18e2360f4ac-7eaf5d0930fmr4640439f.1.1717051503612; Wed, 29 May 2024
 23:45:03 -0700 (PDT)
Date: Wed, 29 May 2024 23:45:03 -0700
In-Reply-To: <20240530063233.3019071-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef1fb40619a63482@google.com>
Subject: Re: [syzbot] [fscrypt?] WARNING in fscrypt_fname_siphash
From: syzbot <syzbot+340581ba9dceb7e06fb3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

lost connection to test machine





syzkaller build log:
go env (err=3D<nil>)
GO111MODULE=3D'auto'
GOARCH=3D'amd64'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFLAGS=3D''
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMODCACHE=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs-2/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.21.4'
GCCGO=3D'gccgo'
GOAMD64=3D'v1'
AR=3D'ar'
CC=3D'gcc'
CXX=3D'g++'
CGO_ENABLED=3D'1'
GOMOD=3D'/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.=
mod'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build2598401150=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at a10a183e2
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Da10a183e260f0ea1a0c37e84ca5c60f28c13e3fd -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240524-152400'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Da10a183e260f0ea1a0c37e84ca5c60f28c13e3fd -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240524-152400'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++14 -I. -Iexecutor/_include -fpermissive -w -DGOOS_linu=
x=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"a10a183e260f0ea1a0c37e84ca5c60f28c=
13e3fd\"



Tested on:

commit:         74eca356 Merge tag 'ceph-for-6.10-rc1' of https://gith..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dee7b962709a5f5a=
5
dashboard link: https://syzkaller.appspot.com/bug?extid=3D340581ba9dceb7e06=
fb3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D1220bb3a9800=
00


