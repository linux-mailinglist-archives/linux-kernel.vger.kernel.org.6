Return-Path: <linux-kernel+bounces-383556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBB49B1D43
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 11:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEDD01C20B04
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 10:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DD713CFA8;
	Sun, 27 Oct 2024 10:40:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F7F7E110
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730025605; cv=none; b=aJeGTVVPlOJdtrfkho3d9lHuVMFK3j2nPm4QfQGgj45740k1XBXy7w36DLkVAbAg6IvQo4iWAP7nRP3vYwPzToRb+2Hme/6PHMu/LscxsntbcJkXY/2GaVjBwyygNwSTj2RuswVMF7bR5G40L5exNTM/tREE1Os7VB8KkJtEpRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730025605; c=relaxed/simple;
	bh=+tP+u899qXmYp+GGvqTNkGbzvGjtEMnt55m9w8hVxtM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fFztQLhw7NcIgQ7msvYyo8fUDax9TFND/AReK6C5ifkJKBKTGWeYuEQmDX/anithChK9gCMoIyGknLdEzqn2wuT9IOTbVkP/OXiKuoB72TnLO21rH/FRwn8/Zfxypuy2VhxicwNWxZ6FwEr7+rZmBf6VSQ7vTV1ejcmb/5iJp7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a4eb49864dso15077245ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 03:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730025602; x=1730630402;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kurBb5dtm1d/jNK7JKAIvHiDCjpUMHDfsqNinyK2krY=;
        b=JdnhhZMat0I1U2IUZzCCpXoFeS1Z/yCGo8v2k2nwbT1mti9fHBIlK5uXiuqk1F2aF0
         RWdx4iHWvi1/jNOeITW3PdBxPqsXGhFSBfmaRms4FAkuxGIyFaMUO56M9h7K14q52Coh
         X6xITfRjneV4ElmTg2B+w83vha+bZFX/TybTmJBRekBBUortlsKQaVyyYaAL75tWrYlY
         i3p8c0hQlbg8gXdhojyGXAUGPJJ6eRmrPlBxyXIW1ICUetnhHx/tMl30Coo8odmMlFjS
         Ux2NkPl0XIf8VUKhCe+tYhGeURbHvTXX9lkNcq623ojPJT5zRrXPuwHpJcutgZq942ze
         0x5g==
X-Forwarded-Encrypted: i=1; AJvYcCWWhzS5kgCtqSdKEPm++Mo1Wk4Mt9glrfwmeY9klAotb9kZR3wTWgJEAdG0bBmtP+ADCWhiQJo7LyvpVUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJc4OlNCJQdXCDb+iDTNLskuzAsQcopmA18VSMXj2QOcr+0LP7
	OX1SyOMZc6Qgz7kT9F3CnYZXzyDASzfhgqE22+WDtNqrB2XQZRrHOf/Eu3Qm3uywQNTOmF133ac
	qV+5olTy7rgNvcGhoQW+CwTXz377KxPkrL+u3yajq7QCM6r5szY+VKB0=
X-Google-Smtp-Source: AGHT+IHc4fsKaFNEI4qqSW5dFXyI9WxiiqMKLMlKrQyTa7G9QZZcu8nZSBVCO9JpQAKI6O6Yg4nlGfZIibMVKI3bSvDwVKE++zsG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1886:b0:3a0:8d60:8ba7 with SMTP id
 e9e14a558f8ab-3a4ed2f666amr36849865ab.14.1730025602168; Sun, 27 Oct 2024
 03:40:02 -0700 (PDT)
Date: Sun, 27 Oct 2024 03:40:02 -0700
In-Reply-To: <tencent_982EDE6ECA0C9127E346D612C6866189AC06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671e1882.050a0220.2b8c0f.01d1.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Write in ext4_insert_dentry
From: syzbot <syzbot+0c99c3f90699936c1e77@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to copy syz-executor to VM: failed to run ["scp" "-P" "4280" "-F" "/=
dev/null" "-o" "UserKnownHostsFile=3D/dev/null" "-o" "IdentitiesOnly=3Dyes"=
 "-o" "BatchMode=3Dyes" "-o" "StrictHostKeyChecking=3Dno" "-o" "ConnectTime=
out=3D10" "/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/bin=
/linux_amd64/syz-executor" "root@localhost:/syz-executor"]: exit status 1
Warning: Permanently added '[localhost]:4280' (ED25519) to the list of know=
n hosts.
scp: dest open "/syz-executor": Failure
scp: failed to upload file /syzkaller/jobs/linux/gopath/src/github.com/goog=
le/syzkaller/bin/linux_amd64/syz-executor to /syz-executor




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
 -ffile-prefix-map=3D/tmp/go-build2867736819=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 14517542a3b
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
/syzkaller/prog.GitRevision=3D14517542a3bd08a1b323746361cf4d09eedeed9e -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20241021-111043'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include -fpermissive -w -DGOOS_linu=
x=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"14517542a3bd08a1b323746361cf4d09ee=
deed9e\"
/usr/bin/ld: /tmp/ccgVaAIk.o: in function `test_cover_filter()':
executor.cc:(.text+0x1424b): warning: the use of `tempnam' is dangerous, be=
tter use `mkstemp'
/usr/bin/ld: /tmp/ccgVaAIk.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking



Tested on:

commit:         850925a8 Merge tag '9p-for-6.12-rc5' of https://github..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dfc6f8ce8c536904=
3
dashboard link: https://syzkaller.appspot.com/bug?extid=3D0c99c3f90699936c1=
e77
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D13493e5f9800=
00


