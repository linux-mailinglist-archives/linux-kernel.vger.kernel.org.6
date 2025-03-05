Return-Path: <linux-kernel+bounces-547138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D53A50355
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F20113A8771
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE0324EA91;
	Wed,  5 Mar 2025 15:22:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA9284D02
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741188125; cv=none; b=nZwB4f9+SdPhhcxW6gcWs5RTuwm+2M1Z1i0Sr7Vm0abeO8EybR4t/Kg31lOWTvIFa5RepnXJZ7g3bzQZ6IcNWDum0voIVAWc3WDs5ZV3kS67dI88PIbfoQTv94z3A2Egg60C54mPeQKQasxZDl0CI5lLUtUvdkKCYiQGcnLOYb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741188125; c=relaxed/simple;
	bh=g4To4NJ/kWMJ6NbFWOmRxZy5ginIDFLKgGir/dhBXlA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NBOFKgmxi+zm2pzpoqky0PkR38Lg5rWuTvaP4h/rqCaZVP+5P2zYMka0i+W7sXakq8QDYRRwFSE4BTJTn3dpnuhZoD7WjkEuQmSQsLKvmVNP8s0u4r4wkeF0UxA6/bRiKdxgdBm3jBn250xCyNmwMIijo+oKwhvbbnyWyIXsxB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d2b3882febso54864675ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 07:22:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741188122; x=1741792922;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLUgStS0aIc57rDwTMm2Bqw2QpbMS8AM1r907Hj2gLM=;
        b=p/UuLY0BtOBa1ZjDjvTLvKOSN5/B1AFtKAGXH6o/6oc9PTS0qyyg3HC0qcsHWWZwzv
         GMP+w2StOgq0D6CB5wtODmn8AorLWdURLNtDHZc6AcW805c2xWcKDOXwXrGDEhkq/pXd
         FCO6a8vlt7bbgkDE4HOxCxjzZsyFJB53mc35rvd/2hXxrHIsrhXD+/XJ0BrI80P5+y9z
         AJkayiXbHfOZWsPouJ276ICN6j+QfkBK6QrihufG78x4TFtUBWk7fWMIji1yNpK1n3au
         TJSDvMstFZvVIAaTkqG4vuMExWtWLxqkkYZ7YyvZq1PeJ5IbupS1weSl0DAy/jHxBsUe
         hEIA==
X-Forwarded-Encrypted: i=1; AJvYcCVseZPcPY77gg2W2dQDB1hg6PquxXj1LQPo5b5B6Aar07PHsOvoUS6Og8t2Ts3W96x2cC/lIlBm70Q9GCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVRDxzjubksmrjegdETqY1hYKiYgZlWfl/nQYm/F/EcN0y1EXG
	KRZ4yqhGdBXS1Afs+uxEPJEZ0mJBRpEDhxxjP0SPckZI1SanNXBHI5yGeFSHQIjDKtuW18su8Np
	CsxpWp/eeRRkZ++uR3NwoPCQ/1THlkT9CT2eDmn5Sm7z0ofT5Pb71Fn0=
X-Google-Smtp-Source: AGHT+IF32AIiGGHYG0TU9f+ACI5R8o9cgsYgfeJ34Igk9uXRFwPO8I/+sVZsDZ9kzYwHQhjZvAw4hL/LaO8G5Y+7ReXMN/6l0Ouc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2207:b0:3cf:c9b9:3eb with SMTP id
 e9e14a558f8ab-3d42b753dddmr43666625ab.0.1741188122306; Wed, 05 Mar 2025
 07:22:02 -0800 (PST)
Date: Wed, 05 Mar 2025 07:22:02 -0800
In-Reply-To: <tencent_10C152FCC67009A26ED12ED48CB0E7C28606@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c86c1a.050a0220.15b4b9.0025.GAE@google.com>
Subject: Re: [syzbot] [xfs?] [mm?] WARNING: bad unlock balance in __mm_populate
From: syzbot <syzbot+8f9f411152c9539f4e59@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to copy syz-execprog to VM: timedout after 1m0s ["scp" "-P" "22" "-F=
" "/dev/null" "-o" "UserKnownHostsFile=3D/dev/null" "-o" "IdentitiesOnly=3D=
yes" "-o" "BatchMode=3Dyes" "-o" "StrictHostKeyChecking=3Dno" "-o" "Connect=
Timeout=3D10" "-v" "/syzkaller/jobs/linux/gopath/src/github.com/google/syzk=
aller/bin/linux_arm64/syz-execprog" "root@10.128.1.159:./syz-execprog"]
Executing: program /usr/bin/ssh host 10.128.1.159, user root, command sftp
OpenSSH_9.2p1 Debian-2+deb12u4, OpenSSL 3.0.15 3 Sep 2024
debug1: Reading configuration data /dev/null
debug1: Connecting to 10.128.1.159 [10.128.1.159] port 22.
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
debug1: Local version string SSH-2.0-OpenSSH_9.2p1 Debian-2+deb12u4
debug1: Remote protocol version 2.0, remote software version OpenSSH_9.1
debug1: compat_banner: match: OpenSSH_9.1 pat OpenSSH* compat 0x04000000
debug1: Authenticating to 10.128.1.159:22 as 'root'
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
debug1: Server host key: ssh-ed25519 SHA256:JxoRyAn13fCyQtNtBXvSgkCC2njD9yP=
7DAIyaauX8OU
debug1: load_hostkeys: fopen /etc/ssh/ssh_known_hosts: No such file or dire=
ctory
debug1: load_hostkeys: fopen /etc/ssh/ssh_known_hosts2: No such file or dir=
ectory
Warning: Permanently added '10.128.1.159' (ED25519) to the list of known ho=
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
Authenticated to 10.128.1.159 ([10.128.1.159]:22) using "none".
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
GOMODCACHE=3D'/syzkaller/jobs/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/syzkaller/jobs/linux/gopath/pkg/mod/golang.org/toolchain@v0.0.1-=
go1.23.6.linux-amd64'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/syzkaller/jobs/linux/gopath/pkg/mod/golang.org/toolchain@v0.0=
.1-go1.23.6.linux-amd64/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.23.6'
GODEBUG=3D''
GOTELEMETRY=3D'local'
GOTELEMETRYDIR=3D'/syzkaller/.config/go/telemetry'
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
 -ffile-prefix-map=3D/tmp/go-build303386079=3D/tmp/go-build -gno-record-gcc=
-switches'

git status (err=3D<nil>)
HEAD detached at c3901742785
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
GOOS=3Dlinux GOARCH=3Darm64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dc3901742785ff25afdc6f470af7b25b69d7c4f2f -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20250301-144328'" -o ./b=
in/linux_arm64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_arm64
aarch64-linux-gnu-g++ -o ./bin/linux_arm64/syz-executor executor/executor.c=
c \
	-O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-l=
arger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-ove=
rflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -stati=
c-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH_arm6=
4=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"c3901742785ff25afdc6f470af7b25b69d=
7c4f2f\"
/usr/lib/gcc-cross/aarch64-linux-gnu/12/../../../../aarch64-linux-gnu/bin/l=
d: /tmp/cchp7I18.o: in function `Connection::Connect(char const*, char cons=
t*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0xd8): warning: Using 'gethostbyname' in statically linked applicati=
ons requires at runtime the shared libraries from the glibc version used fo=
r linking



Tested on:

commit:         e056da87 Merge remote-tracking branch 'will/for-next/p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.g=
it for-kernelci
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd6b7e15dc5b5e77=
6
dashboard link: https://syzkaller.appspot.com/bug?extid=3D8f9f411152c9539f4=
e59
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D109d75a85800=
00


