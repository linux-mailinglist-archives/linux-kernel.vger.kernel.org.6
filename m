Return-Path: <linux-kernel+bounces-195371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B488D4BB3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026D51C21123
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 12:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A3D13212C;
	Thu, 30 May 2024 12:30:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B9313210B
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 12:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717072206; cv=none; b=SJkW5trTcA2QZCOGUCH3C0iX6BDNugw9CZPCvYKpWMhHk/YoY/Y2CC/ZlJs0DL2HtVoYbsORBVjdzsDHzksDgxqIr/WdZflfU8uNsAATlV92wP96q8gxcRXSShXPbcEybcwIIBvasqB23VfUuiFIgetoeF+wuIViBF1RA2QeAn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717072206; c=relaxed/simple;
	bh=Z86/bwzoIGTeheQvIOSjk3VXeGotywVyGsYhpCc041I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kpAi+eaA3OqAy008qLjF2L3v8UaTbonqETKHrInXV0XSKKGHCMK75/NAF++eAHLzEhzEn1P63XzPG7LQ6dtn1HPj3ciRBHja71WmMe6bfgx0hMq8bAA49TnzUKWJdtI2xHGPHokqKMqMO/aEHTe7i/7hnQIqSXRKVWi0GHMa9yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e6ff0120a5so100300439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 05:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717072204; x=1717677004;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eLhHAslkbviJaBdkblmjCqAmkbuuyjQmSFMgQ0wmIQ=;
        b=EZQ2y8dSdkFJnjisb3ldl/S/0NtvJbKo4xt1ygumVffuYW9QdZgwMAUCdf7CruHPDn
         +r80KtxNKM/Fmj2Yn3v8gyMaKZiwSUIs4pjBfKtEpDUZlS8Tq3EwS2PvhN7cyUE5WZDW
         YnB3+jSlYPuub9Qj9sVVwvBvCBqsbtLMT7cmYjU8KPnvBGlWpQgpuDz8hxxVHzzllOo1
         ap/6QVLdxi3noFsoXJeP084Om/GmBknA+a1NJprnmovZsEg+tu4zVw15Lk/m0YLFGYs6
         mnFUQe8rbNj6VYL416I2MK7ia/n4rpnufLbHfNGsJ8NxKsMmem0Ua043ZVzDy19WmJ+G
         Jy/A==
X-Forwarded-Encrypted: i=1; AJvYcCUq2nJMWdWHuGC1ZuwFPDE3jxIEdfGt42GWZnAcWJnAnHV7gZgjVWyh96E3nuz3Ik5qjOq1z2KL3crY1ytj9dqrWwXyP2/xs83HxEfQ
X-Gm-Message-State: AOJu0YxSwwNKsW7yHlt8HbSEsmdDl4ryGIji61KAG8ZioXqzICw2soxC
	3mOEUV5C88U8AEh2tFn7eB/hZs3XRHnzmsOvShsUW8oP/KBvL++z+q/k/gq+E8X4HA0x/C3IuxD
	0jp/33ZnPoDU4Alx2niSOoQh9jiikuHZSjnZ85SIcqyv2u9yllSvqr7g=
X-Google-Smtp-Source: AGHT+IHS64V4nxwqMzWi/qvVJE9dWbGyDcvb2zN0pVVaMptK0OvAt6EOKIAK320p7O628gefYufedum4ExJ+vooRgI+cGOSbFd+6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:ac84:0:b0:488:5bf6:f8ff with SMTP id
 8926c6da1cb9f-4b1ed16f4bbmr63451173.6.1717072204631; Thu, 30 May 2024
 05:30:04 -0700 (PDT)
Date: Thu, 30 May 2024 05:30:04 -0700
In-Reply-To: <20240530115726.3151-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cfa04f0619ab0668@google.com>
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in packet_release
From: syzbot <syzbot+a7d2b1d5d1af83035567@syzkaller.appspotmail.com>
To: edumazet@google.com, hdanton@sina.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, radoslaw.zielonek@gmail.com, 
	syzkaller-bugs@googlegroups.com, vinicius.gomes@intel.com, 
	vladimir.oltean@nxp.com
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
 -ffile-prefix-map=3D/tmp/go-build2710826618=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 4f9530a3b
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:32: run command via tools/syz-env for best compatibility, see:
Makefile:33: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D4f9530a3b62297342999c9097c77dde726522618 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20231220-163507'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D4f9530a3b62297342999c9097c77dde726522618 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20231220-163507'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D4f9530a3b62297342999c9097c77dde726522618 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20231220-163507'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"4f9530a3b62297342999c9097c77dde726=
522618\"



Tested on:

commit:         c53a46b1 net: smc91x: Remove commented out code
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-=
next.git main
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D98a238b2569af6d
dashboard link: https://syzkaller.appspot.com/bug?extid=3Da7d2b1d5d1af83035=
567
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D169aadec9800=
00


