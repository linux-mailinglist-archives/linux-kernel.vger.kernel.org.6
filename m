Return-Path: <linux-kernel+bounces-386819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C529B483E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAD21B210F8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D316205120;
	Tue, 29 Oct 2024 11:29:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DA91DED5A
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730201345; cv=none; b=UAkPvLEQAA89fTu7dylyDzyQ/elUU53AnYk5MmUtEF0eHX0o75QNwZyfViZHR8BHJXzC088MEbkuou783rA+3lCB31zWH4FpRS9x1gw2lEXLg5FKybkfmeXzD2Y4n/6bRqR6HIBDMPd84Pjl0gaJeU4R4t6gxwICOuoo7gTMasI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730201345; c=relaxed/simple;
	bh=fOBDd2J0hX3LqvaCtaIVPmnNqTjZUrM2zjM1L2xU0cw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pihaf1SZewKIEYQVb9DBliJ01YGDOy3bNoyW24DBHgU/J2YFMf23CgCX4Gajg4yFJ6R+eEfuvoR0tkQWN5m0VUxUeXqoajSMMzAPEKL4gEe1mwSh4SItHKhI13Lk4pbQm/TCm43UbpAXAs/K8tX6Vk9o/JrXfpvOCwBanZGfb3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a4ee7817b3so26133315ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 04:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730201342; x=1730806142;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMiHNZA7MovsSmz60eF2vEP0EIwEQI9MtX6E0CccO34=;
        b=xUgevDARUkjAI79q/4pftWE6MXDOkHMqV1tEkjkYw8FP/cL74sfX9BVvgwAXqp+NQW
         3pvz7rOPTa7y4xiZqfOEmtdw46H+P9t3DpDaeF/+mXs9oA/xtCLcniEjHbAMEIYAWVqi
         vCNUvJlK6j1RmPwcZ9/HBjieWzz6gCt/5BZv4lCJAIrpIvJ1fKLq8mevKMH8uWIJA8Lx
         UwPJaYUI4j2zMSACoq60qsyiFH8pYvdERPCEiFYGQeNkPX2/gSSJcWcDdKTWynq4zO37
         CNf/G/a9MtbL+g9rs+8DpQa6WqnlvVI2IEkiCvr8CxQtSYgISVIunfJVLcZCtD/nDF30
         TT1g==
X-Forwarded-Encrypted: i=1; AJvYcCUHWqCzB+ez1mU937s6w2q08qolY9hdAJz8JtiNoWrz7GHgqNTI9ZNiV0WNasaW1GYJfKKGJ+x5jaIAVkM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy650sC3eRqlnRGhAH8+Z0rqhlOr+IzlBWpoaMBcBLy3052M4U2
	oDJcCv5god92nljJpn/73F/UiM/hT4KM9WfyKV5Lb2K4wPSfptA0q/GG9mBTioBGU3K7a6DBJVZ
	kw1gJTHCthjwwcrLogrJzjVRXx72T7z5ykMp0T7bLpiYJemAj3yym+Mw=
X-Google-Smtp-Source: AGHT+IE0OkzJwXuWhM+2R54HxwbsG3zteuwpl3Cd2O4srQmZ6srAJl8X5/bNeKfDcwBeSEdy9Dkk1r7x/ffkxLkYipCo9JMV48DX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1445:b0:3a3:b45b:a8cc with SMTP id
 e9e14a558f8ab-3a4ed2b5cb9mr106866605ab.15.1730201341966; Tue, 29 Oct 2024
 04:29:01 -0700 (PDT)
Date: Tue, 29 Oct 2024 04:29:01 -0700
In-Reply-To: <20241029110726.2433-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6720c6fd.050a0220.11b624.04c0.GAE@google.com>
Subject: Re: [syzbot] [kernfs?] INFO: task hung in do_coredump (3)
From: syzbot <syzbot+a8cdfe2d8ad35db3a7fd@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to copy binary to VM: failed to run ["scp" "-P" "22" "-F" "/dev/null=
" "-o" "UserKnownHostsFile=3D/dev/null" "-o" "IdentitiesOnly=3Dyes" "-o" "B=
atchMode=3Dyes" "-o" "StrictHostKeyChecking=3Dno" "-o" "ConnectTimeout=3D10=
" "-v" "/tmp/syz-executor448792031" "root@10.128.1.66:./syz-executor4487920=
31"]: exit status 255
Executing: program /usr/bin/ssh host 10.128.1.66, user root, command sftp
OpenSSH_9.2p1 Debian-2+deb12u3, OpenSSL 3.0.14 4 Jun 2024
debug1: Reading configuration data /dev/null
debug1: Connecting to 10.128.1.66 [10.128.1.66] port 22.
debug1: fd 3 clearing O_NONBLOCK
debug1: Connection established.
debug1: identity file /root/.ssh/id_rsa type -1
debug1: identity file /root/.ssh/id_rsa-cert type -1
debug1: identity file /root/.ssh/id_ecdsa type -1
debug1: identity file /root/.ssh/id_ecdsa-cert type -1
debug1: identity file /root/.ssh/id_ecdsa_sk type -1
debug1: identity file /root/.ssh/id_ecdsa_sk-cert type -1
debug1: identity file /root/.ssh/id_ed25519 type -1
debug1: identity file /root/.ssh/id_ed25519-cert type -1
debug1: identity file /root/.ssh/id_ed25519_sk type -1
debug1: identity file /root/.ssh/id_ed25519_sk-cert type -1
debug1: identity file /root/.ssh/id_xmss type -1
debug1: identity file /root/.ssh/id_xmss-cert type -1
debug1: identity file /root/.ssh/id_dsa type -1
debug1: identity file /root/.ssh/id_dsa-cert type -1
debug1: Local version string SSH-2.0-OpenSSH_9.2p1 Debian-2+deb12u3
Connection timed out during banner exchange
Connection to 10.128.1.66 port 22 timed out
scp: Connection closed




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
GOMODCACHE=3D'/syzkaller/jobs/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.22.7'
GCCGO=3D'gccgo'
GOAMD64=3D'v1'
AR=3D'ar'
CC=3D'gcc'
CXX=3D'g++'
CGO_ENABLED=3D'1'
GOMOD=3D'/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mo=
d'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build236127509=3D/tmp/go-build -gno-record-gcc=
-switches'

git status (err=3D<nil>)
HEAD detached at 5fe1d0f516
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
go fmt ./sys/... >/dev/null
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D5fe1d0f516ac169c2b6e3a268aea92df864ea3a6 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20241028-155739'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include -fpermissive -w -DGOOS_linu=
x=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"5fe1d0f516ac169c2b6e3a268aea92df86=
4ea3a6\"
/usr/bin/ld: /tmp/ccsbdreI.o: in function `test_cover_filter()':
executor.cc:(.text+0x1426b): warning: the use of `tempnam' is dangerous, be=
tter use `mkstemp'
/usr/bin/ld: /tmp/ccsbdreI.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking



Tested on:

commit:         e42b1a9a Merge tag 'spi-fix-v6.12-rc5' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1940f73a609bb87=
4
dashboard link: https://syzkaller.appspot.com/bug?extid=3Da8cdfe2d8ad35db3a=
7fd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D1729eca79800=
00


