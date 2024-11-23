Return-Path: <linux-kernel+bounces-418918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87799D6729
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 03:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54734B21F0A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 02:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97338273F9;
	Sat, 23 Nov 2024 02:12:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF86414A91
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 02:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732327926; cv=none; b=QLVqIdMXGK8AFO3QNYzTsjoVxk7Yq/yn89olUw0P0XbkXRqQq4N5aqs/cHcY6r8glKCO9Ukd/JZwwwEAQs4Fpq3E7uPbc7uHejcraQoNQc5f0hpAZMDItCu7oevBbUsnEtrOPM6g0bkjRQJWXu/NMfvqc6FDGiSQpOY8pHOA0Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732327926; c=relaxed/simple;
	bh=3B5aQWMC5VJlW+cKcJu2EbBMW0cJZE2qsb8H8LbJ6Kw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ciLF4wtgYpfcVxKPuKcPPX+LPM7/F1s81FO101cEYGo4PL8qCsfY81Y3wikcEjWBtwcFltM1mBZMgcyg0olNmChBn9frCUFX/PhaSagvgszARW1XuPgB8SYvdVpgfnQiMFU232a1WqQOIi6AIKBmzzTkVdyeTj8nNLudcjqf8ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83ab369a523so268079239f.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 18:12:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732327924; x=1732932724;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qUtOoOIZEyDIDEh4t9dMujP0vrSmyU7YaqINQmuf8dw=;
        b=YwHRBERyEb6aI6s4BkDlFF68eSQ8ualEP0UejPNaAbyT0vo6XN+dWX1HEj+OBcalph
         kKX0OFo7wCE9Z5CbFxjh+e3EXfBX2lOZNUQfrSjmMDnAMk17uCWHqE1v6KSESt9Yje/Q
         xRH08QQ0VTTCOGPLu7neV1yhQEDlvV8yqjgwguLspY2YIZnuNZlfuOUyELBZ0+tfr1Se
         F98M5STiTqWla/e9+/iO8pPFgB7xNinxTloSboza13Vg/W9saFZaypg18h5AO4EvhQv8
         ULPYVgHsLWN1YX3766lLGwtvSpCC3sLHxHHGl+UW6svl6xVuM6LdhHPy9wCNtLP/cd06
         sbuw==
X-Forwarded-Encrypted: i=1; AJvYcCWnZVHucfBAermnKtDRd+aCwWxS2ho2XiYW7zJG/F+GM/MnwVWKyoYeG30iUa9g++6dRe/+LCUoAaCFAV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhuN50jomg2q+5b6FnjTZL1UhcUHY4i9A6Yeml7A722HQ3+v88
	ogdKmxiYywfcTkG0d7xpB74e1NM/MFvWQI405R3exc8KorTJ84NyYccn4T9Zii7JbEhuEcKyjhk
	qhQErE4IbTL7aN6NT1UA+L/gcQUcaQqwQ+MH4Oht3bWob8qe/+LucWak=
X-Google-Smtp-Source: AGHT+IEd+r/+gg4KxBdsVHBFb3Lk23F+avkFjZI0lC+kFwu6XVD+50oE3PwT/8s/y0OD8AqEBxs4h4AOTSouhlTafyYfteJzqukc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190b:b0:3a7:7d26:4ce4 with SMTP id
 e9e14a558f8ab-3a79ad0fb5dmr61031195ab.9.1732327923914; Fri, 22 Nov 2024
 18:12:03 -0800 (PST)
Date: Fri, 22 Nov 2024 18:12:03 -0800
In-Reply-To: <20241123021058.1381-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674139f3.050a0220.363a1b.0152.GAE@google.com>
Subject: Re: [syzbot] [kernel?] WARNING in enqueue_dl_entity
From: syzbot <syzbot+00a022dc9979d67df050@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

syzkaller build failed: failed to run ["make" "target"]: exit status 2
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contributing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sys/syz-sysgen
go: error obtaining buildID for go tool compile: fork/exec /syzkaller/jobs/linux/gopath/pkg/mod/golang.org/toolchain@v0.0.1-go1.22.1.linux-amd64/pkg/tool/linux_amd64/compile: resource temporarily unavailable
error obtaining VCS status: exit status 128
	Use -buildvcs=false to disable VCS stamping.
make: *** [Makefile:147: descriptions] Error 1

go env (err=<nil>)
GO111MODULE='auto'
GOARCH='amd64'
GOBIN=''
GOCACHE='/syzkaller/.cache/go-build'
GOENV='/syzkaller/.config/go/env'
GOEXE=''
GOEXPERIMENT=''
GOFLAGS=''
GOHOSTARCH='amd64'
GOHOSTOS='linux'
GOINSECURE=''
GOMODCACHE='/syzkaller/jobs/linux/gopath/pkg/mod'
GONOPROXY=''
GONOSUMDB=''
GOOS='linux'
GOPATH='/syzkaller/jobs/linux/gopath'
GOPRIVATE=''
GOPROXY='https://proxy.golang.org,direct'
GOROOT='/syzkaller/jobs/linux/gopath/pkg/mod/golang.org/toolchain@v0.0.1-go1.22.1.linux-amd64'
GOSUMDB='sum.golang.org'
GOTMPDIR=''
GOTOOLCHAIN='auto'
GOTOOLDIR='/syzkaller/jobs/linux/gopath/pkg/mod/golang.org/toolchain@v0.0.1-go1.22.1.linux-amd64/pkg/tool/linux_amd64'
GOVCS=''
GOVERSION='go1.22.1'
GCCGO='gccgo'
GOAMD64='v1'
AR='ar'
CC='gcc'
CXX='g++'
CGO_ENABLED='1'
GOMOD='/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mod'
GOWORK=''
CGO_CFLAGS='-O2 -g'
CGO_CPPFLAGS=''
CGO_CXXFLAGS='-O2 -g'
CGO_FFLAGS='-O2 -g'
CGO_LDFLAGS='-O2 -g'
PKG_CONFIG='pkg-config'
GOGCCFLAGS='-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=0 -ffile-prefix-map=/tmp/go-build10930050=/tmp/go-build -gno-record-gcc-switches'

git status (err=<nil>)
HEAD detached at 4dfba2774
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contributing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sys/syz-sysgen
go: error obtaining buildID for go tool compile: fork/exec /syzkaller/jobs/linux/gopath/pkg/mod/golang.org/toolchain@v0.0.1-go1.22.1.linux-amd64/pkg/tool/linux_amd64/compile: resource temporarily unavailable
error obtaining VCS status: exit status 128
	Use -buildvcs=false to disable VCS stamping.
make: *** [Makefile:147: descriptions] Error 1



Tested on:

commit:         [unknown 
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=5606b6814de0f638
dashboard link: https://syzkaller.appspot.com/bug?extid=00a022dc9979d67df050
compiler:       
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=174836e8580000


