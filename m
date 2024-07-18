Return-Path: <linux-kernel+bounces-256396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B332934DB9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 940A6B23725
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580D013BC30;
	Thu, 18 Jul 2024 13:04:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CA813213A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721307845; cv=none; b=WXofdwJ44PPwNE7FwdaXbdWddfLPa/n4P/oSVH0Syr4JPG3D9NfVAp99LckEujqakj/GYqpWh084PZl8VEyFeFgKW0lD8+nE0KfO6rYxms8/8sY0nvDGii/jVxgAcN/+u47esUubTxVdJNlhSYb+xAKCSjKcpBKS3NbE2R2uvDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721307845; c=relaxed/simple;
	bh=K7uIgvMf0nJ3U4oViwHBbtKyYRzwNniJIeTKPCPi//c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GJH1Wwc2aAVuO2ZhShMtu1knbYddhWMDpoKLmpIE4Lsue5uOJUZipJDYPttDgSMhd9l32r/9fWxfD0pDgFNEkaRzPlrJkiBHlg2vEpSITCgjZqYo4OB0pX8xMn+3RVEX9gIgJsMFMf9KIZlVUSm+9CsxdWCczp+TyVocwtNe1KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8048edd8993so118474139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 06:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721307843; x=1721912643;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVodG+pJ7qP/ZXN0iBdskzdUvzPKCSAWWW87EbNRQ40=;
        b=POJNJQjEJ/1sWy2aLyFPp/9YuzXxInkYgq3EFjyULkvMjMTBiblglDQay8NaeEXKJc
         TkneBqcwkr0VnCgua08Tm9jiP1btssZSlrY0tYAkk135CoPyjuVGxkKriJqMBVKBQgnC
         BGMyqEQVeEJE/1XYcM0Tl5suOKhimXKEpDYAXXOBcCoInsXolIA3DteK0l5fyBlqPggP
         v06wRUj8SkgUGHZzMfDm/4nujOU26ROyl5hL7GBaETxIaQQrnVS7Mo9ubtL/eClC50+t
         xuJuJ4MlHs3gjUgTgXo90OQ3Ob6rN0ENYGi6ZCSBG7MjuqnSpxgPQhFT7pdsvYA/NxIv
         DUAA==
X-Forwarded-Encrypted: i=1; AJvYcCWyrK0L0JNKsc+lgkGSi1Y4TNfW53syERTjpMPSpHyYy/gMRSDgLQCA3dEKMf+2QANmubhiDhNzRMwJy1MZBZAwCWCl2QREyP4Ic3NI
X-Gm-Message-State: AOJu0YwApxiYxWVDBp8TQcCba9gSi3og+BgZBE1QHwy13109JtOYTALi
	JqFXlDsfFqx0kD3c3Fu4Uolw5Mu3UAhPbr80iPwpdTvJ5mpY6Q9MDap4CWDlr8EudQN9a4X8kGU
	i4x++TqJ8bVSiWXg/dpSTl/MNxNmCfPH7SQWqiifynrIMXCexGEUpsO0=
X-Google-Smtp-Source: AGHT+IEw5mvZTMud4Cyo61lT5keK7mLRr7Yr9bm0YlQiJL3Yr/KhOrarR6e8wTyz9S8tQHYJbJ6ZRN8W/hAChIlmuJ1reI82KYLe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1390:b0:4b9:3703:4adf with SMTP id
 8926c6da1cb9f-4c215aefcd3mr278252173.3.1721307843250; Thu, 18 Jul 2024
 06:04:03 -0700 (PDT)
Date: Thu, 18 Jul 2024 06:04:03 -0700
In-Reply-To: <20240718123404.59833-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008bdce1061d853675@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in hsr_get_node (3)
From: syzbot <syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to copy syz-execprog to VM: timedout after 1m0s ["scp" "-P" "22" "-F=
" "/dev/null" "-o" "UserKnownHostsFile=3D/dev/null" "-o" "IdentitiesOnly=3D=
yes" "-o" "BatchMode=3Dyes" "-o" "StrictHostKeyChecking=3Dno" "-o" "Connect=
Timeout=3D10" "-v" "/syzkaller/jobs-2/linux/gopath/src/github.com/google/sy=
zkaller/bin/linux_amd64/syz-execprog" "root@10.128.0.244:./syz-execprog"]
Executing: program /usr/bin/ssh host 10.128.0.244, user root, command sftp
OpenSSH_9.2p1 Debian-2+deb12u2, OpenSSL 3.0.11 19 Sep 2023
debug1: Reading configuration data /dev/null
debug1: Connecting to 10.128.0.244 [10.128.0.244] port 22.
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
debug1: Local version string SSH-2.0-OpenSSH_9.2p1 Debian-2+deb12u2
debug1: Remote protocol version 2.0, remote software version OpenSSH_9.1
debug1: compat_banner: match: OpenSSH_9.1 pat OpenSSH* compat 0x04000000
debug1: Authenticating to 10.128.0.244:22 as 'root'
debug1: load_hostkeys: fopen /etc/ssh/ssh_known_hosts: No such file or dire=
ctory
debug1: load_hostkeys: fopen /etc/ssh/ssh_known_hosts2: No such file or dir=
ectory
debug1: SSH2_MSG_KEXINIT sent
debug1: SSH2_MSG_KEXINIT received
debug1: kex: algorithm: sntrup761x25519-sha512@openssh.com
debug1: kex: host key algorithm: ssh-ed25519
debug1: kex: server->client cipher: chacha20-poly1305@openssh.com MAC: <imp=
licit> compression: none
debug1: kex: client->server cipher: chacha20-poly1305@openssh.com MAC: <imp=
licit> compression: none
debug1: expecting SSH2_MSG_KEX_ECDH_REPLY
debug1: SSH2_MSG_KEX_ECDH_REPLY received
debug1: Server host key: ssh-ed25519 SHA256:88IuL3orPAmVsyjIy2DvkKzVRHqGoDX=
xazNYOfOHasg
debug1: load_hostkeys: fopen /etc/ssh/ssh_known_hosts: No such file or dire=
ctory
debug1: load_hostkeys: fopen /etc/ssh/ssh_known_hosts2: No such file or dir=
ectory
Warning: Permanently added '10.128.0.244' (ED25519) to the list of known ho=
sts.
debug1: rekey out after 134217728 blocks
debug1: SSH2_MSG_NEWKEYS sent
debug1: expecting SSH2_MSG_NEWKEYS
debug1: SSH2_MSG_NEWKEYS received
debug1: rekey in after 134217728 blocks
debug1: Will attempt key: /root/.ssh/id_rsa=20
debug1: Will attempt key: /root/.ssh/id_ecdsa=20
debug1: Will attempt key: /root/.ssh/id_ecdsa_sk=20
debug1: Will attempt key: /root/.ssh/id_ed25519=20
debug1: Will attempt key: /root/.ssh/id_ed25519_sk=20
debug1: Will attempt key: /root/.ssh/id_xmss=20
debug1: Will attempt key: /root/.ssh/id_dsa=20
debug1: SSH2_MSG_EXT_INFO received
debug1: kex_input_ext_info: server-sig-algs=3D<ssh-ed25519,sk-ssh-ed25519@o=
penssh.com,ssh-rsa,rsa-sha2-256,rsa-sha2-512,ssh-dss,ecdsa-sha2-nistp256,ec=
dsa-sha2-nistp384,ecdsa-sha2-nistp521,sk-ecdsa-sha2-nistp256@openssh.com,we=
bauthn-sk-ecdsa-sha2-nistp256@openssh.com>
debug1: kex_input_ext_info: publickey-hostbound@openssh.com=3D<0>
debug1: SSH2_MSG_SERVICE_ACCEPT received
Authenticated to 10.128.0.244 ([10.128.0.244]:22) using "none".
debug1: channel 0: new session [client-session] (inactive timeout: 0)
debug1: Requesting no-more-sessions@openssh.com
debug1: Entering interactive session.
debug1: pledge: network
debug1: client_input_global_request: rtype hostkeys-00@openssh.com want_rep=
ly 0
debug1: Sending subsystem: sftp
debug1: pledge: fork
scp: debug1: stat remote: No such file or directory




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
 -ffile-prefix-map=3D/tmp/go-build1182856952=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 0d592ce46e
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
/syzkaller/prog.GitRevision=3D0d592ce46ebc504d579c07e5bc3f7f3f2038c4cf -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240415-175759'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D0d592ce46ebc504d579c07e5bc3f7f3f2038c4cf -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240415-175759'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D0d592ce46ebc504d579c07e5bc3f7f3f2038c4cf -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240415-175759'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"0d592ce46ebc504d579c07e5bc3f7f3f20=
38c4cf\"



Tested on:

commit:         b1bc554e Merge tag 'media/v6.11-1' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbb3ca33fe161b0c=
c
dashboard link: https://syzkaller.appspot.com/bug?extid=3Da81f2759d022496b4=
0ab
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D15796f2d9800=
00


