Return-Path: <linux-kernel+bounces-388600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5735C9B61EF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAECE1F24271
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8B01E5726;
	Wed, 30 Oct 2024 11:35:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AFC1E570D
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730288106; cv=none; b=rGcX6n4VcsjeBsp7+CjIh5rPcmWFE5tuFYZTb/gVLweC+GZfCGVpsHQCtewv9c2LuHqeKRY/2lEqrxUOAXe22C6GyVmjQe9yZOcoLqwNBGYb9HMECifyJpzDvR0/MPgoIRRl2dGnQBPaWUdLszBxKZDi4LbPssUq0w8yFVUDL3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730288106; c=relaxed/simple;
	bh=tSVexJBBFeot/zw+hPzSF3NrCZw/O7ZrSkYO939Wc+Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AkAsKTgJ+ULJA2nRPqNssOKyRLY7PHb7r4QpsIXCDNnQZByHjC/H2hGEzE+aOHZibtbCSv5pEQ0Fp67dvH3Xed2ndRJnE0Am8NuHV5CHMawdHklBhswSv5f9iOTsdym05Cw89ZBh+9c+ZzbfGZ6cK2vZQKDM4BoWrOHj4iCNnfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a4f01d43c0so34204045ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 04:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730288103; x=1730892903;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTzz9E7xna+BPnJdoHplL+4CeQ8+WnIa2T/d1Hhy4Do=;
        b=MoSaef7NGH3cTr7AGZDEM6Ihbe/10VfwgbD1+lPBxn4rfuRAm0o5a7FAaLpNFxG3Op
         ydw4H1ROaQx7dg06n4v5YWoItgFu2vaCytx6f7UKEd4TJwhEEN/s+h9l+zU20nXPYHpN
         /MoOQ8vu2me5qQw9ZyYpulsgdEFwtoTD6KpGzsF1cp+FKvU8uI0jiB4sy2xM3RgX//eE
         OjOMGwhj0LNhIVNtf9i3aK+36iirNgDG8sZ1qPvkqXZpc9QxTsjgmyzpkaqeRtIFr6mD
         ZMwqYlDlXdpdAH1+vWPSrOObUzVJZ/fUC6/hlsS0XcBad1rde0HmTppHKfRENFjwdepY
         7LbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa/oZBkqjWAexKTnDq0G47qJvNEb6jqQfAUtCDVEMcrY1Fts5pJX0qpQlX8bG+KC0xRZwu2wVguK6v7cs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj8gZjCqr/mTZREy3bzYhB2XYpv8j7BsW0pE5T3fnVcDktK/mF
	4GxGzKW5q0Q4g1EpBO49/FHkrMZqj6wgHp7iIgzZXNKeXzDxLXUm0avPh4qmVSm+S8zg6rme3GX
	K/Rej1VkiKLrWM3cdUxxrXt8tbm4/8J8CqXwzHw+wHHotoud+pM9DOgE=
X-Google-Smtp-Source: AGHT+IEOnfnPFvhAq39ffapqXB3EAoAVVNfSl4YJqfz6qRhOmYvc1OrKIuVyw+TnrhacjfMUH9+Bti2vJj/1xjNVCXNcaKm21cKl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17ce:b0:3a3:b254:ca2c with SMTP id
 e9e14a558f8ab-3a4ed3524e1mr152453985ab.25.1730288102950; Wed, 30 Oct 2024
 04:35:02 -0700 (PDT)
Date: Wed, 30 Oct 2024 04:35:02 -0700
In-Reply-To: <tencent_889A2EFAAEE6CC9827D206E6D2F286794906@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672219e6.050a0220.35b515.0021.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Write in ext4_insert_dentry
From: syzbot <syzbot+0c99c3f90699936c1e77@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to copy syz-executor to VM: failed to run ["scp" "-P" "38194" "-F" "=
/dev/null" "-o" "UserKnownHostsFile=3D/dev/null" "-o" "IdentitiesOnly=3Dyes=
" "-o" "BatchMode=3Dyes" "-o" "StrictHostKeyChecking=3Dno" "-o" "ConnectTim=
eout=3D10" "/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/bi=
n/linux_amd64/syz-executor" "root@localhost:/syz-executor"]: exit status 1
Warning: Permanently added '[localhost]:38194' (ED25519) to the list of kno=
wn hosts.
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
 -ffile-prefix-map=3D/tmp/go-build1339989871=3D/tmp/go-build -gno-record-gc=
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
/usr/bin/ld: /tmp/ccC7uJRr.o: in function `test_cover_filter()':
executor.cc:(.text+0x1424b): warning: the use of `tempnam' is dangerous, be=
tter use `mkstemp'
/usr/bin/ld: /tmp/ccC7uJRr.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking



Tested on:

commit:         c1e939a2 Merge tag 'cgroup-for-6.12-rc5-fixes' of git:..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D35698c25466f388=
c
dashboard link: https://syzkaller.appspot.com/bug?extid=3D0c99c3f90699936c1=
e77
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D10a4255f9800=
00


