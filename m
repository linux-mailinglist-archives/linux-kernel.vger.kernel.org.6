Return-Path: <linux-kernel+bounces-390906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF179B7FE0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 408DA1F21F09
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531B21BC097;
	Thu, 31 Oct 2024 16:21:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6874F19C562
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391667; cv=none; b=XUWcGY+jlzRuuD1Mg1gZ03I3hXI/iF7FnvDilWQR3vjUK8VF8uRhQ0HqG3+e0EQywmHq1ZUM5g1vgekM1MhSmRl7IygsuXHDqVseZWxVyXhfqsxwL4hjId7hKsv9GtSFP8M7S1iBPPvXIbMU/+EFmASOKNHIU3rm3Un0lLBaaXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391667; c=relaxed/simple;
	bh=PCy0ezMn8efV46/eK2nN4/8YDl4LOXiSY2htiEijqhQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q3Yt7Sr00LtcxFrJLG9AONmItdTnIO8dFEMSCx04JmBkjRN9spYouICBieFs4A4V8vNRsugIpmvfUZKvQXscM5tPm9XggUcmqhLJK8Y+V05LafFN1f2dJgDMVzCfFRZENRd9LePjW8vL8Q0aXWR0N0vjU9iHEX3x5iTYwh5JIX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3da2d46b9so10346475ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730391664; x=1730996464;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NraVFbuwc5jloCkhDW5Lyeiud92LsrRCf4BZzcOY4WQ=;
        b=KKSGX0pbU5nDmwDLtHDH9K+y+CLrxpW/xK2yehbwccI7qzC0KglGi1Vj6A+xWDpjPp
         xOGYpTHxF1G+VSb0UlRd3Ef3yZIp7AMkVofgfOdAN0Tgvb/XrvxSQDFm7MiXFACQsDuB
         gz0wrZSa2rT2CI10tlJU0NhCPbDAjoqCZbtAkdGiE9Xk9DJFxwl7TGw7Txp9q+EaVDFC
         i604Y5jT5si5oKmZxdckUTn1gjZVv7UOi/nO+DU6tzluDOtZFLA6omOq/ub5eh2q6eIB
         gD5mN6sQrZCRw1me2P86TygaWbmopeKsJQgDQwO1bY/smHlOlT6X4lpMFUTJ3ki2EcEi
         /fLg==
X-Forwarded-Encrypted: i=1; AJvYcCX2orgp9A0cv2+RGbDjLwuyAQDmU/G6b3rj1sQqZfkvt/v79YYN9q0OWXEHbjPPOOP+Ew/arzSOuQcmi+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8yMsWMHUUB3Mz/upKaQRbB+89ZAfNRds+/G6+GlODNhkUSLgI
	UhHuyOiKhNay+rvfrJW7OwOX9QkyRZ14hB26gCwRRK5QKesfCFrD0UV0/zT6mrewQJdOF44akJ3
	9HJa/k+Fga0NyDZLFFTSLXM2CpemDnF87hFQDv78ebuidBZWTEZmNAd8=
X-Google-Smtp-Source: AGHT+IFFDQFq6G/ELDhXrU9kEmqSrWSZxqdcwmwfuZiVoygCByKvYH50nvEvlBFM2i5Vr7S6IOgtSthhk2YzS3ZeX+xm1tH60yt7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a44:b0:3a3:c4c9:8 with SMTP id
 e9e14a558f8ab-3a4ed2942bcmr197826665ab.13.1730391664526; Thu, 31 Oct 2024
 09:21:04 -0700 (PDT)
Date: Thu, 31 Oct 2024 09:21:04 -0700
In-Reply-To: <20241031124205.10372-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6723ae70.050a0220.35b515.0163.GAE@google.com>
Subject: Re: [syzbot] [exfat?] KMSAN: kernel-infoleak in pipe_read
From: syzbot <syzbot+41ebd857f013384237a9@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to copy syz-execprog to VM: timedout after 1m0s ["scp" "-P" "22" "-F=
" "/dev/null" "-o" "UserKnownHostsFile=3D/dev/null" "-o" "IdentitiesOnly=3D=
yes" "-o" "BatchMode=3Dyes" "-o" "StrictHostKeyChecking=3Dno" "-o" "Connect=
Timeout=3D10" "-v" "/syzkaller/jobs/linux/gopath/src/github.com/google/syzk=
aller/bin/linux_amd64/syz-execprog" "root@10.128.0.23:./syz-execprog"]
Executing: program /usr/bin/ssh host 10.128.0.23, user root, command sftp
OpenSSH_9.2p1 Debian-2+deb12u3, OpenSSL 3.0.14 4 Jun 2024
debug1: Reading configuration data /dev/null
debug1: Connecting to 10.128.0.23 [10.128.0.23] port 22.
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
debug1: Remote protocol version 2.0, remote software version OpenSSH_9.1
debug1: compat_banner: match: OpenSSH_9.1 pat OpenSSH* compat 0x04000000
debug1: Authenticating to 10.128.0.23:22 as 'root'
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
debug1: Server host key: ssh-ed25519 SHA256:g5LT3corcdQiP3+7S3QNYL7lzLWO1gp=
/6X86Qtf82jk
debug1: load_hostkeys: fopen /etc/ssh/ssh_known_hosts: No such file or dire=
ctory
debug1: load_hostkeys: fopen /etc/ssh/ssh_known_hosts2: No such file or dir=
ectory
Warning: Permanently added '10.128.0.23' (ED25519) to the list of known hos=
ts.
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
Authenticated to 10.128.0.23 ([10.128.0.23]:22) using "none".
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
 -ffile-prefix-map=3D/tmp/go-build1695445684=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at fb888278a6
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
/syzkaller/prog.GitRevision=3Dfb888278a6b21eda7fa63551c83fd17b90305ba1 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20241030-093306'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include -fpermissive -w -DGOOS_linu=
x=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"fb888278a6b21eda7fa63551c83fd17b90=
305ba1\"
/usr/bin/ld: /tmp/cccAwp7Q.o: in function `test_cover_filter()':
executor.cc:(.text+0x1426b): warning: the use of `tempnam' is dangerous, be=
tter use `mkstemp'
/usr/bin/ld: /tmp/cccAwp7Q.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking



Tested on:

commit:         0fc810ae x86/uaccess: Avoid barrier_nospec() in 64-bit..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4d4311df74eee96=
f
dashboard link: https://syzkaller.appspot.com/bug?extid=3D41ebd857f01338423=
7a9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D15cb655f9800=
00


