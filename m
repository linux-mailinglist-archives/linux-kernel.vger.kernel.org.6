Return-Path: <linux-kernel+bounces-345618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B21D498B834
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C270EB25186
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63E019C565;
	Tue,  1 Oct 2024 09:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ty2G+xcQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TtNiM9mc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ty2G+xcQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TtNiM9mc"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B428B1C693
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727774407; cv=none; b=ADVtx2W+F+kuy48QvqFqPEArUdNaOzMbZS0yyNexE2D4HZ3EIL+N14Y5ET8dt11LWu0B2O2VqLFnugI8EnJw6fmzxzwn+EQ1A7dmrVv9OY+tDGsbDSe0SYU0Z855ix2TfyTOpEiJnOjhyN5/zpqA2V1U+jhv/zHqIB/lnll4zHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727774407; c=relaxed/simple;
	bh=H0Az8qhL7WtCL2GZLAtPQ4zY2gP1RaRigCO/zWk+rHA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DsYRV9zDgHVSC249u24Gq2nJhfD2UXgyWWbp5LWJqBJntDAV6BTgjlmi8EXVsSAo9FOPoBgxLshNyp/5g1kYcDDHM1C6DwP7XCFoksACQI0kmCLu6HSGYiYhXqMRr8LyoIJlF7W2mzCDYXvOUaSKFMOpx47qbaTea7F8W3VMdJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ty2G+xcQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TtNiM9mc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ty2G+xcQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TtNiM9mc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
	by smtp-out1.suse.de (Postfix) with ESMTP id BA1BE21BAB;
	Tue,  1 Oct 2024 09:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727774400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HKELQnd0lptbgWZh5W/6+B1GByxe5acTxmAXcam6ftw=;
	b=ty2G+xcQ/EI/33+Wh2hLQ6UKOSNNFE1dyO1sFJwY1QrO9G3JY35CEED4qysy3KdwlUxsqX
	MaRyj2uT4JlBbYBefKf1JecqqlJ/YzSK1YfZgC5srT0zAYbVaqrVmdQ7/daAP5LRlvNDXE
	Y9WRJ2x3bmQ/iUwnkDLQouhLr1LXeBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727774400;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HKELQnd0lptbgWZh5W/6+B1GByxe5acTxmAXcam6ftw=;
	b=TtNiM9mc3Lchdffh25WEo3gp7tVjjrywzRC5P5xCVfQIhT5nW/O1NIqz6dujexOQ1jp/Tb
	GcSUjquhZ+Vm9SDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727774400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HKELQnd0lptbgWZh5W/6+B1GByxe5acTxmAXcam6ftw=;
	b=ty2G+xcQ/EI/33+Wh2hLQ6UKOSNNFE1dyO1sFJwY1QrO9G3JY35CEED4qysy3KdwlUxsqX
	MaRyj2uT4JlBbYBefKf1JecqqlJ/YzSK1YfZgC5srT0zAYbVaqrVmdQ7/daAP5LRlvNDXE
	Y9WRJ2x3bmQ/iUwnkDLQouhLr1LXeBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727774400;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HKELQnd0lptbgWZh5W/6+B1GByxe5acTxmAXcam6ftw=;
	b=TtNiM9mc3Lchdffh25WEo3gp7tVjjrywzRC5P5xCVfQIhT5nW/O1NIqz6dujexOQ1jp/Tb
	GcSUjquhZ+Vm9SDg==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
	id 550094A055D; Tue,  1 Oct 2024 11:20:00 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,  Palmer Dabbelt
 <palmer@dabbelt.com>,  Albert Ou <aou@eecs.berkeley.edu>,  Andrea Parri
 <parri.andrea@gmail.com>,  linux-kernel@vger.kernel.org,
  linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/2] tools: Add riscv barrier implementation
In-Reply-To: <20240806-optimize_ring_buffer_read_riscv-v2-1-ca7e193ae198@rivosinc.com>
	(Charlie Jenkins's message of "Tue, 06 Aug 2024 15:01:23 -0700")
References: <20240806-optimize_ring_buffer_read_riscv-v2-0-ca7e193ae198@rivosinc.com>
	<20240806-optimize_ring_buffer_read_riscv-v2-1-ca7e193ae198@rivosinc.com>
X-Yow: Uh-oh --  WHY am I suddenly thinking of a VENERABLE religious leader
 frolicking on a FORT LAUDERDALE weekend?
Date: Tue, 01 Oct 2024 11:20:00 +0200
Message-ID: <mvmo74441tr.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: 
X-Spamd-Result: default: False [-2.20 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	RCVD_NO_TLS_LAST(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
	RCVD_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[sifive.com,dabbelt.com,eecs.berkeley.edu,gmail.com,vger.kernel.org,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TAGGED_RCPT(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -2.20
X-Spam-Flag: NO

On Aug 06 2024, Charlie Jenkins wrote:

> Many of the other architectures use their custom barrier implementations.
> Use the barrier code from the kernel sources to optimize barriers in
> tools.

This appears to break compilation of tools/bpf/resolve_btfids:

+ make prepare ARCH=3Driscv --output-sync -j12 V=3D1
make --no-print-directory -C /home/abuild/rpmbuild/BUILD/kernel-default-6.1=
2~rc1/linux-6.12-rc1/linux-obj \
-f /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/Makef=
ile prepare
make -f ../scripts/Makefile.build obj=3Dscripts/basic
make -f ../scripts/Makefile.asm-headers obj=3Darch/riscv/include/generated/=
uapi/asm \
generic=3Dinclude/uapi/asm-generic
make -f ../scripts/Makefile.build obj=3Dscripts/dtc
mkdir -p ./tools
make LDFLAGS=3D MAKEFLAGS=3D" --jobserver-auth=3Dfifo:/tmp/GMfifo6534" O=3D=
/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/linux-ob=
j subdir=3Dtools -C ../tools/ bpf/resolve_btfids
# WRAP    arch/riscv/include/generated/uapi/asm/fcntl.h
  echo "#include <asm-generic/fcntl.h>" > arch/riscv/include/generated/uapi=
/asm/fcntl.h
# WRAP    arch/riscv/include/generated/uapi/asm/ioctls.h
  echo "#include <asm-generic/ioctls.h>" > arch/riscv/include/generated/uap=
i/asm/ioctls.h
# WRAP    arch/riscv/include/generated/uapi/asm/ioctl.h
  echo "#include <asm-generic/ioctl.h>" > arch/riscv/include/generated/uapi=
/asm/ioctl.h
# WRAP    arch/riscv/include/generated/uapi/asm/errno.h
  echo "#include <asm-generic/errno.h>" > arch/riscv/include/generated/uapi=
/asm/errno.h
ln -fsn .. source
# GEN     Makefile
  { echo "# Automatically generated by ../Makefile: don't edit"; echo "incl=
ude ../Makefile"; } > Makefile
test -e .gitignore || \
{ echo "# this is build directory, ignore it"; echo "*"; } > .gitignore
# WRAP    arch/riscv/include/generated/uapi/asm/ipcbuf.h
  echo "#include <asm-generic/ipcbuf.h>" > arch/riscv/include/generated/uap=
i/asm/ipcbuf.h
# WRAP    arch/riscv/include/generated/uapi/asm/mman.h
  echo "#include <asm-generic/mman.h>" > arch/riscv/include/generated/uapi/=
asm/mman.h
# WRAP    arch/riscv/include/generated/uapi/asm/msgbuf.h
  echo "#include <asm-generic/msgbuf.h>" > arch/riscv/include/generated/uap=
i/asm/msgbuf.h
# WRAP    arch/riscv/include/generated/uapi/asm/param.h
  echo "#include <asm-generic/param.h>" > arch/riscv/include/generated/uapi=
/asm/param.h
set -e; mkdir -p include/generated/uapi/linux/; trap "rm -f include/generat=
ed/uapi/linux/.tmp_version.h" EXIT; { 	if [ 0 -gt 255 ]; then echo \#define=
 LINUX_VERSION_CODE 396543; else echo \#define LINUX_VERSION_CODE 396288; f=
i; echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + ((c) > 2=
55 ? 255 : (c)))'; echo \#define LINUX_VERSION_MAJOR 6; echo \#define LINUX=
_VERSION_PATCHLEVEL 12; echo \#define LINUX_VERSION_SUBLEVEL 0; } > include=
/generated/uapi/linux/.tmp_version.h; if [ ! -r include/generated/uapi/linu=
x/version.h ] || ! cmp -s include/generated/uapi/linux/version.h include/ge=
nerated/uapi/linux/.tmp_version.h; then : '  UPD     include/generated/uapi=
/linux/version.h'; mv -f include/generated/uapi/linux/.tmp_version.h includ=
e/generated/uapi/linux/version.h; fi
# WRAP    arch/riscv/include/generated/uapi/asm/posix_types.h
  echo "#include <asm-generic/posix_types.h>" > arch/riscv/include/generate=
d/uapi/asm/posix_types.h
# WRAP    arch/riscv/include/generated/uapi/asm/resource.h
  echo "#include <asm-generic/resource.h>" > arch/riscv/include/generated/u=
api/asm/resource.h
../scripts/remove-stale-files
# WRAP    arch/riscv/include/generated/uapi/asm/poll.h
  echo "#include <asm-generic/poll.h>" > arch/riscv/include/generated/uapi/=
asm/poll.h
# WRAP    arch/riscv/include/generated/uapi/asm/sembuf.h
  echo "#include <asm-generic/sembuf.h>" > arch/riscv/include/generated/uap=
i/asm/sembuf.h
# WRAP    arch/riscv/include/generated/uapi/asm/shmbuf.h
  echo "#include <asm-generic/shmbuf.h>" > arch/riscv/include/generated/uap=
i/asm/shmbuf.h
# WRAP    arch/riscv/include/generated/uapi/asm/siginfo.h
  echo "#include <asm-generic/siginfo.h>" > arch/riscv/include/generated/ua=
pi/asm/siginfo.h
# WRAP    arch/riscv/include/generated/uapi/asm/signal.h
  echo "#include <asm-generic/signal.h>" > arch/riscv/include/generated/uap=
i/asm/signal.h
# WRAP    arch/riscv/include/generated/uapi/asm/sockios.h
  echo "#include <asm-generic/sockios.h>" > arch/riscv/include/generated/ua=
pi/asm/sockios.h
# WRAP    arch/riscv/include/generated/uapi/asm/socket.h
  echo "#include <asm-generic/socket.h>" > arch/riscv/include/generated/uap=
i/asm/socket.h
# WRAP    arch/riscv/include/generated/uapi/asm/stat.h
  echo "#include <asm-generic/stat.h>" > arch/riscv/include/generated/uapi/=
asm/stat.h
# WRAP    arch/riscv/include/generated/uapi/asm/statfs.h
  echo "#include <asm-generic/statfs.h>" > arch/riscv/include/generated/uap=
i/asm/statfs.h
# WRAP    arch/riscv/include/generated/uapi/asm/swab.h
  echo "#include <asm-generic/swab.h>" > arch/riscv/include/generated/uapi/=
asm/swab.h
# WRAP    arch/riscv/include/generated/uapi/asm/termbits.h
  echo "#include <asm-generic/termbits.h>" > arch/riscv/include/generated/u=
api/asm/termbits.h
set -e; mkdir -p include/config/; trap "rm -f include/config/.tmp_kernel.re=
lease" EXIT; { ../scripts/setlocalversion ..; } > include/config/.tmp_kerne=
l.release; if [ ! -r include/config/kernel.release ] || ! cmp -s include/co=
nfig/kernel.release include/config/.tmp_kernel.release; then : '  UPD     i=
nclude/config/kernel.release'; mv -f include/config/.tmp_kernel.release inc=
lude/config/kernel.release; fi
# WRAP    arch/riscv/include/generated/uapi/asm/termios.h
  echo "#include <asm-generic/termios.h>" > arch/riscv/include/generated/ua=
pi/asm/termios.h
# WRAP    arch/riscv/include/generated/uapi/asm/types.h
  echo "#include <asm-generic/types.h>" > arch/riscv/include/generated/uapi=
/asm/types.h
set -e; mkdir -p include/generated/; trap "rm -f include/generated/.tmp_com=
pile.h" EXIT; { ../scripts/mkcompile_h "riscv64" "gcc (SUSE Linux) 14.2.0" =
"ld"; } > include/generated/.tmp_compile.h; if [ ! -r include/generated/com=
pile.h ] || ! cmp -s include/generated/compile.h include/generated/.tmp_com=
pile.h; then : '  UPD     include/generated/compile.h'; mv -f include/gener=
ated/.tmp_compile.h include/generated/compile.h; fi
set -e; mkdir -p include/generated/uapi/linux/; trap "rm -f include/generat=
ed/uapi/linux/.tmp_suse_version.h" EXIT; { 	sh ../scripts/gen-suse_version_=
h.sh; } > include/generated/uapi/linux/.tmp_suse_version.h; if [ ! -r inclu=
de/generated/uapi/linux/suse_version.h ] || ! cmp -s include/generated/uapi=
/linux/suse_version.h include/generated/uapi/linux/.tmp_suse_version.h; the=
n : '  UPD     include/generated/uapi/linux/suse_version.h'; mv -f include/=
generated/uapi/linux/.tmp_suse_version.h include/generated/uapi/linux/suse_=
version.h; fi
set -e; mkdir -p include/generated/; trap "rm -f include/generated/.tmp_uts=
release.h" EXIT; { 	if [ `echo -n "6.12.0-rc1-4-default" | wc -c ` -gt 64 ]=
; then echo '"6.12.0-rc1-4-default" exceeds 64 characters' >&2; exit 1; fi;=
 echo \#define UTS_RELEASE \"6.12.0-rc1-4-default\"; } > include/generated/=
.tmp_utsrelease.h; if [ ! -r include/generated/utsrelease.h ] || ! cmp -s i=
nclude/generated/utsrelease.h include/generated/.tmp_utsrelease.h; then : '=
  UPD     include/generated/utsrelease.h'; mv -f include/generated/.tmp_uts=
release.h include/generated/utsrelease.h; fi
mkdir -p /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1=
/linux-obj/tools/bpf/resolve_btfids && make O=3D/home/abuild/rpmbuild/BUILD=
/kernel-default-6.12~rc1/linux-6.12-rc1/linux-obj subdir=3Dtools/bpf/resolv=
e_btfids --no-print-directory -C bpf/resolve_btfids=20
# SYSHDR  arch/riscv/include/generated/uapi/asm/unistd_64.h
  sh ../scripts/syscallhdr.sh --emit-nr  --abis common,64,riscv,rlimit,memf=
d_secret ../scripts/syscall.tbl arch/riscv/include/generated/uapi/asm/unist=
d_64.h
# SYSHDR  arch/riscv/include/generated/uapi/asm/unistd_32.h
  sh ../scripts/syscallhdr.sh --emit-nr  --abis common,32,riscv,memfd_secre=
t ../scripts/syscall.tbl arch/riscv/include/generated/uapi/asm/unistd_32.h
make -f ../scripts/Makefile.asm-headers obj=3Darch/riscv/include/generated/=
asm \
generic=3Dinclude/asm-generic
# WRAP    arch/riscv/include/generated/asm/early_ioremap.h
  echo "#include <asm-generic/early_ioremap.h>" > arch/riscv/include/genera=
ted/asm/early_ioremap.h
# LEX     scripts/dtc/dtc-lexer.lex.c
  flex -oscripts/dtc/dtc-lexer.lex.c -L ../scripts/dtc/dtc-lexer.l
# WRAP    arch/riscv/include/generated/asm/flat.h
  echo "#include <asm-generic/flat.h>" > arch/riscv/include/generated/asm/f=
lat.h
# WRAP    arch/riscv/include/generated/asm/kvm_para.h
  echo "#include <asm-generic/kvm_para.h>" > arch/riscv/include/generated/a=
sm/kvm_para.h
# WRAP    arch/riscv/include/generated/asm/mmzone.h
  echo "#include <asm-generic/mmzone.h>" > arch/riscv/include/generated/asm=
/mmzone.h
# WRAP    arch/riscv/include/generated/asm/parport.h
  echo "#include <asm-generic/parport.h>" > arch/riscv/include/generated/as=
m/parport.h
# WRAP    arch/riscv/include/generated/asm/spinlock.h
  echo "#include <asm-generic/spinlock.h>" > arch/riscv/include/generated/a=
sm/spinlock.h
# WRAP    arch/riscv/include/generated/asm/spinlock_types.h
  echo "#include <asm-generic/spinlock_types.h>" > arch/riscv/include/gener=
ated/asm/spinlock_types.h
# WRAP    arch/riscv/include/generated/asm/qrwlock.h
  echo "#include <asm-generic/qrwlock.h>" > arch/riscv/include/generated/as=
m/qrwlock.h
# WRAP    arch/riscv/include/generated/asm/qrwlock_types.h
  echo "#include <asm-generic/qrwlock_types.h>" > arch/riscv/include/genera=
ted/asm/qrwlock_types.h
# WRAP    arch/riscv/include/generated/asm/user.h
  echo "#include <asm-generic/user.h>" > arch/riscv/include/generated/asm/u=
ser.h
# WRAP    arch/riscv/include/generated/asm/vmlinux.lds.h
  echo "#include <asm-generic/vmlinux.lds.h>" > arch/riscv/include/generate=
d/asm/vmlinux.lds.h
# WRAP    arch/riscv/include/generated/asm/device.h
  echo "#include <asm-generic/device.h>" > arch/riscv/include/generated/asm=
/device.h
# WRAP    arch/riscv/include/generated/asm/div64.h
  echo "#include <asm-generic/div64.h>" > arch/riscv/include/generated/asm/=
div64.h
# WRAP    arch/riscv/include/generated/asm/dma-mapping.h
  echo "#include <asm-generic/dma-mapping.h>" > arch/riscv/include/generate=
d/asm/dma-mapping.h
# WRAP    arch/riscv/include/generated/asm/dma.h
  echo "#include <asm-generic/dma.h>" > arch/riscv/include/generated/asm/dm=
a.h
# HOSTCC  scripts/dtc/fstree.o
  gcc -Wp,-MMD,scripts/dtc/.fstree.o.d -Wall -Wmissing-prototypes -Wstrict-=
prototypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/include -i=
nclude /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h -I ../scripts/dtc/l=
ibfdt -DNO_YAML  -I ./scripts/dtc -c -o scripts/dtc/fstree.o ../scripts/dtc=
/fstree.c
# WRAP    arch/riscv/include/generated/asm/emergency-restart.h
  echo "#include <asm-generic/emergency-restart.h>" > arch/riscv/include/ge=
nerated/asm/emergency-restart.h
# WRAP    arch/riscv/include/generated/asm/hardirq.h
  echo "#include <asm-generic/hardirq.h>" > arch/riscv/include/generated/as=
m/hardirq.h
# YACC    scripts/dtc/dtc-parser.tab.[ch]
  bison -o scripts/dtc/dtc-parser.tab.c --defines=3Dscripts/dtc/dtc-parser.=
tab.h -t -l ../scripts/dtc/dtc-parser.y
# WRAP    arch/riscv/include/generated/asm/hw_irq.h
  echo "#include <asm-generic/hw_irq.h>" > arch/riscv/include/generated/asm=
/hw_irq.h
# WRAP    arch/riscv/include/generated/asm/irq_regs.h
  echo "#include <asm-generic/irq_regs.h>" > arch/riscv/include/generated/a=
sm/irq_regs.h
# WRAP    arch/riscv/include/generated/asm/kmap_size.h
  echo "#include <asm-generic/kmap_size.h>" > arch/riscv/include/generated/=
asm/kmap_size.h
# WRAP    arch/riscv/include/generated/asm/local.h
  echo "#include <asm-generic/local.h>" > arch/riscv/include/generated/asm/=
local.h
mkdir -p /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1=
/linux-obj/tools/bpf/resolve_btfids/libbpf/
# WRAP    arch/riscv/include/generated/asm/local64.h
  echo "#include <asm-generic/local64.h>" > arch/riscv/include/generated/as=
m/local64.h
# WRAP    arch/riscv/include/generated/asm/msi.h
  echo "#include <asm-generic/msi.h>" > arch/riscv/include/generated/asm/ms=
i.h
make -C /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/=
tools/build CFLAGS=3D LDFLAGS=3D /home/abuild/rpmbuild/BUILD/kernel-default=
-6.12~rc1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/fixdep
# WRAP    arch/riscv/include/generated/asm/percpu.h
  echo "#include <asm-generic/percpu.h>" > arch/riscv/include/generated/asm=
/percpu.h
# WRAP    arch/riscv/include/generated/asm/preempt.h
  echo "#include <asm-generic/preempt.h>" > arch/riscv/include/generated/as=
m/preempt.h
# WRAP    arch/riscv/include/generated/asm/runtime-const.h
  echo "#include <asm-generic/runtime-const.h>" > arch/riscv/include/genera=
ted/asm/runtime-const.h
# HOSTCC  scripts/dtc/dtc.o
  gcc -Wp,-MMD,scripts/dtc/.dtc.o.d -Wall -Wmissing-prototypes -Wstrict-pro=
totypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/include -incl=
ude /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h -I ../scripts/dtc/libf=
dt -DNO_YAML  -I ./scripts/dtc -c -o scripts/dtc/dtc.o ../scripts/dtc/dtc.c
# WRAP    arch/riscv/include/generated/asm/rwonce.h
  echo "#include <asm-generic/rwonce.h>" > arch/riscv/include/generated/asm=
/rwonce.h
# WRAP    arch/riscv/include/generated/asm/serial.h
  echo "#include <asm-generic/serial.h>" > arch/riscv/include/generated/asm=
/serial.h
# WRAP    arch/riscv/include/generated/asm/shmparam.h
  echo "#include <asm-generic/shmparam.h>" > arch/riscv/include/generated/a=
sm/shmparam.h
# WRAP    arch/riscv/include/generated/asm/softirq_stack.h
  echo "#include <asm-generic/softirq_stack.h>" > arch/riscv/include/genera=
ted/asm/softirq_stack.h
# WRAP    arch/riscv/include/generated/asm/trace_clock.h
  echo "#include <asm-generic/trace_clock.h>" > arch/riscv/include/generate=
d/asm/trace_clock.h
# WRAP    arch/riscv/include/generated/asm/unaligned.h
  echo "#include <asm-generic/unaligned.h>" > arch/riscv/include/generated/=
asm/unaligned.h
# WRAP    arch/riscv/include/generated/asm/vga.h
  echo "#include <asm-generic/vga.h>" > arch/riscv/include/generated/asm/vg=
a.h
gcc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer=
 -std=3Dgnu11   -I ../scripts/include   -o /home/abuild/rpmbuild/BUILD/kern=
el-default-6.12~rc1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/fixde=
p /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/tools/=
build/fixdep.c
# WRAP    arch/riscv/include/generated/asm/video.h
  echo "#include <asm-generic/video.h>" > arch/riscv/include/generated/asm/=
video.h
# HOSTCC  scripts/dtc/data.o
  gcc -Wp,-MMD,scripts/dtc/.data.o.d -Wall -Wmissing-prototypes -Wstrict-pr=
ototypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/include -inc=
lude /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h -I ../scripts/dtc/lib=
fdt -DNO_YAML  -I ./scripts/dtc -c -o scripts/dtc/data.o ../scripts/dtc/dat=
a.c
# HOSTCC  scripts/dtc/srcpos.o
  gcc -Wp,-MMD,scripts/dtc/.srcpos.o.d -Wall -Wmissing-prototypes -Wstrict-=
prototypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/include -i=
nclude /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h -I ../scripts/dtc/l=
ibfdt -DNO_YAML  -I ./scripts/dtc -c -o scripts/dtc/srcpos.o ../scripts/dtc=
/srcpos.c
# SYSTBL  arch/riscv/include/generated/asm/syscall_table_32.h
  sh ../scripts/syscalltbl.sh  --abis common,32,riscv,memfd_secret ../scrip=
ts/syscall.tbl arch/riscv/include/generated/asm/syscall_table_32.h
# HOSTCC  scripts/dtc/treesource.o
  gcc -Wp,-MMD,scripts/dtc/.treesource.o.d -Wall -Wmissing-prototypes -Wstr=
ict-prototypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/includ=
e -include /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h -I ../scripts/d=
tc/libfdt -DNO_YAML  -I ./scripts/dtc -c -o scripts/dtc/treesource.o ../scr=
ipts/dtc/treesource.c
mkdir -p /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1=
/linux-obj/tools/bpf/resolve_btfids//libsubcmd
# HOSTCC  scripts/dtc/util.o
  gcc -Wp,-MMD,scripts/dtc/.util.o.d -Wall -Wmissing-prototypes -Wstrict-pr=
ototypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/include -inc=
lude /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h -I ../scripts/dtc/lib=
fdt -DNO_YAML  -I ./scripts/dtc -c -o scripts/dtc/util.o ../scripts/dtc/uti=
l.c
# SYSTBL  arch/riscv/include/generated/asm/syscall_table_64.h
  sh ../scripts/syscalltbl.sh  --abis common,64,riscv,rlimit,memfd_secret .=
./scripts/syscall.tbl arch/riscv/include/generated/asm/syscall_table_64.h
make  -C /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1=
/tools/lib/bpf/ OUTPUT=3D/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc=
1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/    \
	    DESTDIR=3D/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.=
12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/ AR=3D"ar" CC=3D"gcc" LD=
=3D"ld" ARCH=3D"riscv" CROSS_COMPILE=3D"" EXTRA_CFLAGS=3D"" prefix=3D subdi=
r=3D \
	    /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/lin=
ux-obj/tools/bpf/resolve_btfids/libbpf/libbpf.a install_headers
# HOSTCC  scripts/dtc/libfdt/fdt_wip.o
  gcc -Wp,-MMD,scripts/dtc/libfdt/.fdt_wip.o.d -Wall -Wmissing-prototypes -=
Wstrict-prototypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/in=
clude -include /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h -I ../scrip=
ts/dtc/libfdt -DNO_YAML  -I ./scripts/dtc -c -o scripts/dtc/libfdt/fdt_wip.=
o ../scripts/dtc/libfdt/fdt_wip.c
# HOSTCC  scripts/dtc/libfdt/fdt.o
  gcc -Wp,-MMD,scripts/dtc/libfdt/.fdt.o.d -Wall -Wmissing-prototypes -Wstr=
ict-prototypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/includ=
e -include /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h -I ../scripts/d=
tc/libfdt -DNO_YAML  -I ./scripts/dtc -c -o scripts/dtc/libfdt/fdt.o ../scr=
ipts/dtc/libfdt/fdt.c
# HOSTCC  scripts/dtc/flattree.o
  gcc -Wp,-MMD,scripts/dtc/.flattree.o.d -Wall -Wmissing-prototypes -Wstric=
t-prototypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/include =
-include /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h -I ../scripts/dtc=
/libfdt -DNO_YAML  -I ./scripts/dtc -c -o scripts/dtc/flattree.o ../scripts=
/dtc/flattree.c
make -C /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/=
tools/lib/subcmd/ OUTPUT=3D/home/abuild/rpmbuild/BUILD/kernel-default-6.12~=
rc1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd/ \
	    DESTDIR=3D/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.=
12-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd/ AR=3D"ar" CC=3D"gcc" L=
D=3D"ld" ARCH=3D"riscv" CROSS_COMPILE=3D"" EXTRA_CFLAGS=3D"" prefix=3D subd=
ir=3D \
	    /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/lin=
ux-obj/tools/bpf/resolve_btfids/libsubcmd/libsubcmd.a install_headers
# HOSTCC  scripts/dtc/libfdt/fdt_strerror.o
  gcc -Wp,-MMD,scripts/dtc/libfdt/.fdt_strerror.o.d -Wall -Wmissing-prototy=
pes -Wstrict-prototypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scrip=
ts/include -include /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h -I ../=
scripts/dtc/libfdt -DNO_YAML  -I ./scripts/dtc -c -o scripts/dtc/libfdt/fdt=
_strerror.o ../scripts/dtc/libfdt/fdt_strerror.c
# HOSTCC  scripts/dtc/libfdt/fdt_empty_tree.o
  gcc -Wp,-MMD,scripts/dtc/libfdt/.fdt_empty_tree.o.d -Wall -Wmissing-proto=
types -Wstrict-prototypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scr=
ipts/include -include /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h -I .=
./scripts/dtc/libfdt -DNO_YAML  -I ./scripts/dtc -c -o scripts/dtc/libfdt/f=
dt_empty_tree.o ../scripts/dtc/libfdt/fdt_empty_tree.c
/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/scripts/=
bpf_doc.py --header \
	--file /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/=
tools/include/uapi/linux/bpf.h > /home/abuild/rpmbuild/BUILD/kernel-default=
-6.12~rc1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/bpf_help=
er_defs.h
# HOSTCC  scripts/dtc/livetree.o
  gcc -Wp,-MMD,scripts/dtc/.livetree.o.d -Wall -Wmissing-prototypes -Wstric=
t-prototypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/include =
-include /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h -I ../scripts/dtc=
/libfdt -DNO_YAML  -I ./scripts/dtc -c -o scripts/dtc/livetree.o ../scripts=
/dtc/livetree.c
make -C /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/=
tools/build CFLAGS=3D LDFLAGS=3D /home/abuild/rpmbuild/BUILD/kernel-default=
-6.12~rc1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd/fixdep
\
		if [ ! -d ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.1=
2-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf' ]; then inst=
all -d -m 755 ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6=
.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf'; fi; insta=
ll -m 644 bpf.h ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux=
-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf'
\
		if [ ! -d '/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12=
-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd//include/subcmd/' ]; then=
 install -d -m 755 '/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/lin=
ux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd//include/subcmd/';=
 fi; install exec-cmd.h -m 644 '/home/abuild/rpmbuild/BUILD/kernel-default-=
6.12~rc1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd//inclu=
de/subcmd/'
\
		if [ ! -d '/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12=
-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd//include/subcmd/' ]; then=
 install -d -m 755 '/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/lin=
ux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd//include/subcmd/';=
 fi; install help.h -m 644 '/home/abuild/rpmbuild/BUILD/kernel-default-6.12=
~rc1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd//include/s=
ubcmd/'
\
		if [ ! -d ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.1=
2-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf' ]; then inst=
all -d -m 755 ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6=
.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf'; fi; insta=
ll -m 644 libbpf.h ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/li=
nux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf'
\
		if [ ! -d ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.1=
2-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf' ]; then inst=
all -d -m 755 ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6=
.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf'; fi; insta=
ll -m 644 btf.h ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux=
-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf'
\
		if [ ! -d '/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12=
-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd//include/subcmd/' ]; then=
 install -d -m 755 '/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/lin=
ux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd//include/subcmd/';=
 fi; install pager.h -m 644 '/home/abuild/rpmbuild/BUILD/kernel-default-6.1=
2~rc1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd//include/=
subcmd/'
\
		if [ ! -d ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.1=
2-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf' ]; then inst=
all -d -m 755 ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6=
.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf'; fi; insta=
ll -m 644 libbpf_common.h ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12=
~rc1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf'
gcc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer=
 -std=3Dgnu11   -I ../scripts/include   -o /home/abuild/rpmbuild/BUILD/kern=
el-default-6.12~rc1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libsu=
bcmd/fixdep /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-=
rc1/tools/build/fixdep.c
\
		if [ ! -d '/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12=
-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd//include/subcmd/' ]; then=
 install -d -m 755 '/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/lin=
ux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd//include/subcmd/';=
 fi; install parse-options.h -m 644 '/home/abuild/rpmbuild/BUILD/kernel-def=
ault-6.12~rc1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd//=
include/subcmd/'
# HOSTCC  scripts/dtc/libfdt/fdt_ro.o
  gcc -Wp,-MMD,scripts/dtc/libfdt/.fdt_ro.o.d -Wall -Wmissing-prototypes -W=
strict-prototypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/inc=
lude -include /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h -I ../script=
s/dtc/libfdt -DNO_YAML  -I ./scripts/dtc -c -o scripts/dtc/libfdt/fdt_ro.o =
../scripts/dtc/libfdt/fdt_ro.c
\
		if [ ! -d ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.1=
2-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf' ]; then inst=
all -d -m 755 ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6=
.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf'; fi; insta=
ll -m 644 libbpf_legacy.h ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12=
~rc1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf'
\
		if [ ! -d '/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12=
-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd//include/subcmd/' ]; then=
 install -d -m 755 '/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/lin=
ux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd//include/subcmd/';=
 fi; install run-command.h -m 644 '/home/abuild/rpmbuild/BUILD/kernel-defau=
lt-6.12~rc1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd//in=
clude/subcmd/'
# HOSTCC  scripts/dtc/libfdt/fdt_addresses.o
  gcc -Wp,-MMD,scripts/dtc/libfdt/.fdt_addresses.o.d -Wall -Wmissing-protot=
ypes -Wstrict-prototypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scri=
pts/include -include /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h -I ..=
/scripts/dtc/libfdt -DNO_YAML  -I ./scripts/dtc -c -o scripts/dtc/libfdt/fd=
t_addresses.o ../scripts/dtc/libfdt/fdt_addresses.c
\
		if [ ! -d ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.1=
2-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf' ]; then inst=
all -d -m 755 ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6=
.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf'; fi; insta=
ll -m 644 bpf_helpers.h ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~r=
c1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf'
\
		if [ ! -d ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.1=
2-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf' ]; then inst=
all -d -m 755 ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6=
.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf'; fi; insta=
ll -m 644 bpf_tracing.h ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~r=
c1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf'
\
		if [ ! -d ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.1=
2-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf' ]; then inst=
all -d -m 755 ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6=
.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf'; fi; insta=
ll -m 644 bpf_endian.h ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc=
1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf'
\
		if [ ! -d ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.1=
2-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf' ]; then inst=
all -d -m 755 ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6=
.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf'; fi; insta=
ll -m 644 bpf_core_read.h ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12=
~rc1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf'
\
		if [ ! -d ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.1=
2-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf' ]; then inst=
all -d -m 755 ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6=
.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf'; fi; insta=
ll -m 644 skel_internal.h ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12=
~rc1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf'
\
		if [ ! -d ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.1=
2-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf' ]; then inst=
all -d -m 755 ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6=
.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf'; fi; insta=
ll -m 644 libbpf_version.h ''/home/abuild/rpmbuild/BUILD/kernel-default-6.1=
2~rc1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bp=
f'
# HOSTCC  scripts/dtc/libfdt/fdt_sw.o
  gcc -Wp,-MMD,scripts/dtc/libfdt/.fdt_sw.o.d -Wall -Wmissing-prototypes -W=
strict-prototypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/inc=
lude -include /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h -I ../script=
s/dtc/libfdt -DNO_YAML  -I ./scripts/dtc -c -o scripts/dtc/libfdt/fdt_sw.o =
../scripts/dtc/libfdt/fdt_sw.c
\
		if [ ! -d ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.1=
2-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf' ]; then inst=
all -d -m 755 ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6=
.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf'; fi; insta=
ll -m 644 usdt.bpf.h ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/=
linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf'
\
		if [ ! -d ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.1=
2-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf' ]; then inst=
all -d -m 755 ''/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6=
.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/'/include/bpf'; fi; insta=
ll -m 644 /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc=
1/linux-obj/tools/bpf/resolve_btfids/libbpf/bpf_helper_defs.h ''/home/abuil=
d/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/linux-obj/tools/bpf=
/resolve_btfids/libbpf/'/include/bpf'
# HOSTCC  scripts/dtc/libfdt/fdt_rw.o
  gcc -Wp,-MMD,scripts/dtc/libfdt/.fdt_rw.o.d -Wall -Wmissing-prototypes -W=
strict-prototypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/inc=
lude -include /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h -I ../script=
s/dtc/libfdt -DNO_YAML  -I ./scripts/dtc -c -o scripts/dtc/libfdt/fdt_rw.o =
../scripts/dtc/libfdt/fdt_rw.c
gcc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer=
 -std=3Dgnu11   -I ../scripts/include   -o /home/abuild/rpmbuild/BUILD/kern=
el-default-6.12~rc1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbp=
f/staticobjs/fixdep /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/lin=
ux-6.12-rc1/tools/build/fixdep.c
# HOSTCC  scripts/dtc/fdtoverlay.o
  gcc -Wp,-MMD,scripts/dtc/.fdtoverlay.o.d -Wall -Wmissing-prototypes -Wstr=
ict-prototypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/includ=
e -include /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h -I ../scripts/d=
tc/libfdt -DNO_YAML  -I ./scripts/dtc -c -o scripts/dtc/fdtoverlay.o ../scr=
ipts/dtc/fdtoverlay.c
# HOSTCC  scripts/dtc/checks.o
  gcc -Wp,-MMD,scripts/dtc/.checks.o.d -Wall -Wmissing-prototypes -Wstrict-=
prototypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/include -i=
nclude /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h -I ../scripts/dtc/l=
ibfdt -DNO_YAML  -I ./scripts/dtc -c -o scripts/dtc/checks.o ../scripts/dtc=
/checks.c
# HOSTCC  scripts/dtc/libfdt/fdt_overlay.o
  gcc -Wp,-MMD,scripts/dtc/libfdt/.fdt_overlay.o.d -Wall -Wmissing-prototyp=
es -Wstrict-prototypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../script=
s/include -include /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h -I ../s=
cripts/dtc/libfdt -DNO_YAML  -I ./scripts/dtc -c -o scripts/dtc/libfdt/fdt_=
overlay.o ../scripts/dtc/libfdt/fdt_overlay.c
# HOSTLD  scripts/dtc/fdtoverlay
  gcc   -o scripts/dtc/fdtoverlay scripts/dtc/libfdt/fdt.o scripts/dtc/libf=
dt/fdt_ro.o scripts/dtc/libfdt/fdt_wip.o scripts/dtc/libfdt/fdt_sw.o script=
s/dtc/libfdt/fdt_rw.o scripts/dtc/libfdt/fdt_strerror.o scripts/dtc/libfdt/=
fdt_empty_tree.o scripts/dtc/libfdt/fdt_addresses.o scripts/dtc/libfdt/fdt_=
overlay.o scripts/dtc/fdtoverlay.o scripts/dtc/util.o=20=20=20
  gcc -Wp,-MD,/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.1=
2-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd/.exec-cmd.o.d -Wp,-MT,/h=
ome/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/linux-obj/=
tools/bpf/resolve_btfids/libsubcmd/exec-cmd.o -ggdb3 -Wall -Wextra -std=3Dg=
nu99 -fPIC -O3 -Werror -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_GN=
U_SOURCE -I/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-r=
c1/tools/include/ -Wbad-function-cast -Wdeclaration-after-statement -Wforma=
t-security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-protot=
ypes -Wnested-externs -Wno-system-headers -Wold-style-definition -Wpacked -=
Wredundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef=
 -Wwrite-strings -Wformat -Wno-type-limits -Wstrict-aliasing=3D3 -Wshadow -=
D"BUILD_STR(s)=3D#s" -c -o /home/abuild/rpmbuild/BUILD/kernel-default-6.12~=
rc1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd/exec-cmd.o =
exec-cmd.c
  gcc -Wp,-MD,/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.1=
2-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd/.pager.o.d -Wp,-MT,/home=
/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/linux-obj/too=
ls/bpf/resolve_btfids/libsubcmd/pager.o -ggdb3 -Wall -Wextra -std=3Dgnu99 -=
fPIC -O3 -Werror -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_GNU_SOUR=
CE -I/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/too=
ls/include/ -Wbad-function-cast -Wdeclaration-after-statement -Wformat-secu=
rity -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -=
Wnested-externs -Wno-system-headers -Wold-style-definition -Wpacked -Wredun=
dant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwri=
te-strings -Wformat -Wno-type-limits -Wstrict-aliasing=3D3 -Wshadow -D"BUIL=
D_STR(s)=3D#s" -c -o /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/li=
nux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd/pager.o pager.c
  gcc -Wp,-MD,/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.1=
2-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd/.help.o.d -Wp,-MT,/home/=
abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/linux-obj/tool=
s/bpf/resolve_btfids/libsubcmd/help.o -ggdb3 -Wall -Wextra -std=3Dgnu99 -fP=
IC -O3 -Werror -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_GNU_SOURCE=
 -I/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/tools=
/include/ -Wbad-function-cast -Wdeclaration-after-statement -Wformat-securi=
ty -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -Wn=
ested-externs -Wno-system-headers -Wold-style-definition -Wpacked -Wredunda=
nt-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwrite=
-strings -Wformat -Wno-type-limits -Wstrict-aliasing=3D3 -Wshadow -D"BUILD_=
STR(s)=3D#s" -c -o /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linu=
x-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd/help.o help.c
  gcc -Wp,-MD,/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.1=
2-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd/.parse-options.o.d -Wp,-=
MT,/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/linux=
-obj/tools/bpf/resolve_btfids/libsubcmd/parse-options.o -ggdb3 -Wall -Wextr=
a -std=3Dgnu99 -fPIC -O3 -Werror -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=
=3D64 -D_GNU_SOURCE -I/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/l=
inux-6.12-rc1/tools/include/ -Wbad-function-cast -Wdeclaration-after-statem=
ent -Wformat-security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmis=
sing-prototypes -Wnested-externs -Wno-system-headers -Wold-style-definition=
 -Wpacked -Wredundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-e=
num -Wundef -Wwrite-strings -Wformat -Wno-type-limits -Wstrict-aliasing=3D3=
 -Wshadow -D"BUILD_STR(s)=3D#s" -c -o /home/abuild/rpmbuild/BUILD/kernel-de=
fault-6.12~rc1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd/=
parse-options.o parse-options.c
  gcc -Wp,-MD,/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.1=
2-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd/.run-command.o.d -Wp,-MT=
,/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/linux-o=
bj/tools/bpf/resolve_btfids/libsubcmd/run-command.o -ggdb3 -Wall -Wextra -s=
td=3Dgnu99 -fPIC -O3 -Werror -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64=
 -D_GNU_SOURCE -I/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-=
6.12-rc1/tools/include/ -Wbad-function-cast -Wdeclaration-after-statement -=
Wformat-security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-=
prototypes -Wnested-externs -Wno-system-headers -Wold-style-definition -Wpa=
cked -Wredundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -=
Wundef -Wwrite-strings -Wformat -Wno-type-limits -Wstrict-aliasing=3D3 -Wsh=
adow -D"BUILD_STR(s)=3D#s" -c -o /home/abuild/rpmbuild/BUILD/kernel-default=
-6.12~rc1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd/run-c=
ommand.o run-command.c
  gcc -Wp,-MD,/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.1=
2-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd/.sigchain.o.d -Wp,-MT,/h=
ome/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/linux-obj/=
tools/bpf/resolve_btfids/libsubcmd/sigchain.o -ggdb3 -Wall -Wextra -std=3Dg=
nu99 -fPIC -O3 -Werror -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_GN=
U_SOURCE -I/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-r=
c1/tools/include/ -Wbad-function-cast -Wdeclaration-after-statement -Wforma=
t-security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-protot=
ypes -Wnested-externs -Wno-system-headers -Wold-style-definition -Wpacked -=
Wredundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef=
 -Wwrite-strings -Wformat -Wno-type-limits -Wstrict-aliasing=3D3 -Wshadow -=
D"BUILD_STR(s)=3D#s" -c -o /home/abuild/rpmbuild/BUILD/kernel-default-6.12~=
rc1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd/sigchain.o =
sigchain.c
  gcc -Wp,-MD,/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.1=
2-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd/.subcmd-config.o.d -Wp,-=
MT,/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/linux=
-obj/tools/bpf/resolve_btfids/libsubcmd/subcmd-config.o -ggdb3 -Wall -Wextr=
a -std=3Dgnu99 -fPIC -O3 -Werror -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=
=3D64 -D_GNU_SOURCE -I/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/l=
inux-6.12-rc1/tools/include/ -Wbad-function-cast -Wdeclaration-after-statem=
ent -Wformat-security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmis=
sing-prototypes -Wnested-externs -Wno-system-headers -Wold-style-definition=
 -Wpacked -Wredundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-e=
num -Wundef -Wwrite-strings -Wformat -Wno-type-limits -Wstrict-aliasing=3D3=
 -Wshadow -D"BUILD_STR(s)=3D#s" -c -o /home/abuild/rpmbuild/BUILD/kernel-de=
fault-6.12~rc1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd/=
subcmd-config.o subcmd-config.c
  gcc -Wp,-MD,/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.1=
2-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/staticobjs/.libbpf.o.d -Wp,=
-MT,/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/linu=
x-obj/tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf.o -g -O2 -std=3Dgnu=
89 -Wbad-function-cast -Wdeclaration-after-statement -Wformat-security -Wfo=
rmat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -Wnested-e=
xterns -Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-decl=
s -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwrite-string=
s -Wformat -Wno-type-limits -Wstrict-aliasing=3D3 -Wshadow -Wno-switch-enum=
 -Werror -Wall -I/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-=
6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/ -I/home/abuild/rpmbuild=
/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/tools/include -I/home/abuild/=
rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/tools/include/uapi -f=
visibility=3Dhidden -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -D"BUILD=
_STR(s)=3D#s" -c -o /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/lin=
ux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf.o l=
ibbpf.c
  gcc -Wp,-MD,/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.1=
2-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/staticobjs/.nlattr.o.d -Wp,=
-MT,/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/linu=
x-obj/tools/bpf/resolve_btfids/libbpf/staticobjs/nlattr.o -g -O2 -std=3Dgnu=
89 -Wbad-function-cast -Wdeclaration-after-statement -Wformat-security -Wfo=
rmat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -Wnested-e=
xterns -Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-decl=
s -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwrite-string=
s -Wformat -Wno-type-limits -Wstrict-aliasing=3D3 -Wshadow -Wno-switch-enum=
 -Werror -Wall -I/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-=
6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/ -I/home/abuild/rpmbuild=
/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/tools/include -I/home/abuild/=
rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/tools/include/uapi -f=
visibility=3Dhidden -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -D"BUILD=
_STR(s)=3D#s" -c -o /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/lin=
ux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/staticobjs/nlattr.o n=
lattr.c
  gcc -Wp,-MD,/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.1=
2-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/staticobjs/.bpf.o.d -Wp,-MT=
,/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/linux-o=
bj/tools/bpf/resolve_btfids/libbpf/staticobjs/bpf.o -g -O2 -std=3Dgnu89 -Wb=
ad-function-cast -Wdeclaration-after-statement -Wformat-security -Wformat-y=
2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -Wnested-externs=
 -Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-decls -Wst=
rict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwrite-strings -Wfo=
rmat -Wno-type-limits -Wstrict-aliasing=3D3 -Wshadow -Wno-switch-enum -Werr=
or -Wall -I/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-r=
c1/linux-obj/tools/bpf/resolve_btfids/libbpf/ -I/home/abuild/rpmbuild/BUILD=
/kernel-default-6.12~rc1/linux-6.12-rc1/tools/include -I/home/abuild/rpmbui=
ld/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/tools/include/uapi -fvisibi=
lity=3Dhidden -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -D"BUILD_STR(s=
)=3D#s" -c -o /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.1=
2-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/staticobjs/bpf.o bpf.c
  gcc -Wp,-MD,/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.1=
2-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/staticobjs/.btf.o.d -Wp,-MT=
,/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/linux-o=
bj/tools/bpf/resolve_btfids/libbpf/staticobjs/btf.o -g -O2 -std=3Dgnu89 -Wb=
ad-function-cast -Wdeclaration-after-statement -Wformat-security -Wformat-y=
2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -Wnested-externs=
 -Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-decls -Wst=
rict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwrite-strings -Wfo=
rmat -Wno-type-limits -Wstrict-aliasing=3D3 -Wshadow -Wno-switch-enum -Werr=
or -Wall -I/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-r=
c1/linux-obj/tools/bpf/resolve_btfids/libbpf/ -I/home/abuild/rpmbuild/BUILD=
/kernel-default-6.12~rc1/linux-6.12-rc1/tools/include -I/home/abuild/rpmbui=
ld/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/tools/include/uapi -fvisibi=
lity=3Dhidden -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -D"BUILD_STR(s=
)=3D#s" -c -o /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.1=
2-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/staticobjs/btf.o btf.c
# HOSTCC  scripts/dtc/dtc-lexer.lex.o
  gcc -Wp,-MMD,scripts/dtc/.dtc-lexer.lex.o.d -Wall -Wmissing-prototypes -W=
strict-prototypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/inc=
lude -include /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h -I ../script=
s/dtc/libfdt -DNO_YAML -I ../scripts/dtc -I ./scripts/dtc -c -o scripts/dtc=
/dtc-lexer.lex.o scripts/dtc/dtc-lexer.lex.c
In file included from /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/l=
inux-6.12-rc1/tools/include/asm/barrier.h:12,
                 from /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/l=
inux-6.12-rc1/tools/include/linux/ring_buffer.h:4,
                 from libbpf.c:37:
/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/tools/in=
clude/asm/../../arch/riscv/include/asm/barrier.h:13:10: fatal error: asm/fe=
nce.h: No such file or directory
   13 | #include <asm/fence.h>
      |          ^~~~~~~~~~~~~
compilation terminated.
  gcc -Wp,-MD,/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.1=
2-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/staticobjs/.libbpf_errno.o.=
d -Wp,-MT,/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc=
1/linux-obj/tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf_errno.o -g -O=
2 -std=3Dgnu89 -Wbad-function-cast -Wdeclaration-after-statement -Wformat-s=
ecurity -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototype=
s -Wnested-externs -Wno-system-headers -Wold-style-definition -Wpacked -Wre=
dundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -W=
write-strings -Wformat -Wno-type-limits -Wstrict-aliasing=3D3 -Wshadow -Wno=
-switch-enum -Werror -Wall -I/home/abuild/rpmbuild/BUILD/kernel-default-6.1=
2~rc1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/ -I/home/abu=
ild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/tools/include -I/=
home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/tools/inc=
lude/uapi -fvisibility=3Dhidden -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=
=3D64 -D"BUILD_STR(s)=3D#s" -c -o /home/abuild/rpmbuild/BUILD/kernel-defaul=
t-6.12~rc1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/statico=
bjs/libbpf_errno.o libbpf_errno.c
make[5]: *** [/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.1=
2-rc1/tools/build/Makefile.build:106: /home/abuild/rpmbuild/BUILD/kernel-de=
fault-6.12~rc1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/sta=
ticobjs/libbpf.o] Error 1
make[5]: *** Waiting for unfinished jobs....
# HOSTCC  scripts/dtc/dtc-parser.tab.o
  gcc -Wp,-MMD,scripts/dtc/.dtc-parser.tab.o.d -Wall -Wmissing-prototypes -=
Wstrict-prototypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/in=
clude -include /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h -I ../scrip=
ts/dtc/libfdt -DNO_YAML -I ../scripts/dtc -I ./scripts/dtc -c -o scripts/dt=
c/dtc-parser.tab.o scripts/dtc/dtc-parser.tab.c
# HOSTLD  scripts/dtc/dtc
  gcc   -o scripts/dtc/dtc scripts/dtc/dtc.o scripts/dtc/flattree.o scripts=
/dtc/fstree.o scripts/dtc/data.o scripts/dtc/livetree.o scripts/dtc/treesou=
rce.o scripts/dtc/srcpos.o scripts/dtc/checks.o scripts/dtc/util.o scripts/=
dtc/dtc-lexer.lex.o scripts/dtc/dtc-parser.tab.o=20=20=20
make -f ../scripts/Makefile.build obj=3Dscripts
make -f ../scripts/Makefile.build obj=3Dscripts/genksyms \
need-builtin=3D \
need-modorder=3D \

make -f ../scripts/Makefile.build obj=3Dscripts/selinux \
need-builtin=3D \
need-modorder=3D \

make -f ../scripts/Makefile.build obj=3Dscripts/selinux/genheaders \
need-builtin=3D \
need-modorder=3D \

make -f ../scripts/Makefile.build obj=3Dscripts/selinux/mdp \
need-builtin=3D \
need-modorder=3D \

# LEX     scripts/genksyms/lex.lex.c
  flex -oscripts/genksyms/lex.lex.c -L ../scripts/genksyms/lex.l
# YACC    scripts/genksyms/parse.tab.[ch]
  bison --version >/dev/null; bison -o scripts/genksyms/parse.tab.c --defin=
es=3Dscripts/genksyms/parse.tab.h -t -l ../scripts/genksyms/parse.y 2>/dev/=
null
# HOSTCC  scripts/selinux/genheaders/genheaders
  gcc -Wp,-MMD,scripts/selinux/genheaders/.genheaders.d -Wall -Wmissing-pro=
totypes -Wstrict-prototypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../s=
cripts/include -include /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h -I=
../include/uapi -I../include -I../security/selinux/include  -I ./scripts/se=
linux/genheaders   -o scripts/selinux/genheaders/genheaders ../scripts/seli=
nux/genheaders/genheaders.c=20=20=20
# HOSTCC  scripts/selinux/mdp/mdp
  gcc -Wp,-MMD,scripts/selinux/mdp/.mdp.d -Wall -Wmissing-prototypes -Wstri=
ct-prototypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/include=
 -include /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h -I../include/uap=
i -I../include -I../security/selinux/include -I./include  -I ./scripts/seli=
nux/mdp   -o scripts/selinux/mdp/mdp ../scripts/selinux/mdp/mdp.c=20=20=20
# HOSTCC  scripts/sorttable
  gcc -Wp,-MMD,scripts/.sorttable.d -Wall -Wmissing-prototypes -Wstrict-pro=
totypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/include -incl=
ude /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h -I../tools/include -I =
./scripts   -o scripts/sorttable ../scripts/sorttable.c   -lpthread
# HOSTCC  scripts/kallsyms
  gcc -Wp,-MMD,scripts/.kallsyms.d -Wall -Wmissing-prototypes -Wstrict-prot=
otypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/include -inclu=
de /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h  -I ./scripts   -o scri=
pts/kallsyms ../scripts/kallsyms.c=20=20=20
   ld -r -o /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-=
rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd/libsubcmd-in.o  /home/abui=
ld/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/linux-obj/tools/bp=
f/resolve_btfids/libsubcmd/exec-cmd.o /home/abuild/rpmbuild/BUILD/kernel-de=
fault-6.12~rc1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd/=
help.o /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/l=
inux-obj/tools/bpf/resolve_btfids/libsubcmd/pager.o /home/abuild/rpmbuild/B=
UILD/kernel-default-6.12~rc1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btf=
ids/libsubcmd/parse-options.o /home/abuild/rpmbuild/BUILD/kernel-default-6.=
12~rc1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd/run-comm=
and.o /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/li=
nux-obj/tools/bpf/resolve_btfids/libsubcmd/sigchain.o /home/abuild/rpmbuild=
/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_b=
tfids/libsubcmd/subcmd-config.o
# HOSTCC  scripts/genksyms/genksyms.o
  gcc -Wp,-MMD,scripts/genksyms/.genksyms.o.d -Wall -Wmissing-prototypes -W=
strict-prototypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/inc=
lude -include /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h  -I ./script=
s/genksyms -c -o scripts/genksyms/genksyms.o ../scripts/genksyms/genksyms.c
rm -f /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/li=
nux-obj/tools/bpf/resolve_btfids/libsubcmd/libsubcmd.a && ar rcs /home/abui=
ld/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.12-rc1/linux-obj/tools/bp=
f/resolve_btfids/libsubcmd/libsubcmd.a /home/abuild/rpmbuild/BUILD/kernel-d=
efault-6.12~rc1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libsubcmd=
/libsubcmd-in.o
# HOSTCC  scripts/genksyms/parse.tab.o
  gcc -Wp,-MMD,scripts/genksyms/.parse.tab.o.d -Wall -Wmissing-prototypes -=
Wstrict-prototypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/in=
clude -include /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h -I ../scrip=
ts/genksyms -I ./scripts/genksyms -c -o scripts/genksyms/parse.tab.o script=
s/genksyms/parse.tab.c
# HOSTCC  scripts/asn1_compiler
  gcc -Wp,-MMD,scripts/.asn1_compiler.d -Wall -Wmissing-prototypes -Wstrict=
-prototypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/include -=
include /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h -I../include -I ./=
scripts   -o scripts/asn1_compiler ../scripts/asn1_compiler.c=20=20=20
# HOSTCC  scripts/sign-file
  gcc -Wp,-MMD,scripts/.sign-file.d -Wall -Wmissing-prototypes -Wstrict-pro=
totypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/include -incl=
ude /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h -DOPENSSL_LOAD_CONF -I=
 ./scripts   -o scripts/sign-file ../scripts/sign-file.c   -lcrypto
# HOSTCC  scripts/genksyms/lex.lex.o
  gcc -Wp,-MMD,scripts/genksyms/.lex.lex.o.d -Wall -Wmissing-prototypes -Ws=
trict-prototypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/incl=
ude -include /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h -I ../scripts=
/genksyms -I ./scripts/genksyms -c -o scripts/genksyms/lex.lex.o scripts/ge=
nksyms/lex.lex.c
# HOSTLD  scripts/genksyms/genksyms
  gcc   -o scripts/genksyms/genksyms scripts/genksyms/genksyms.o scripts/ge=
nksyms/parse.tab.o scripts/genksyms/lex.lex.o=20=20=20
make -f ../scripts/Makefile.build obj=3Dscripts/mod
# CC      scripts/mod/empty.o
  gcc -Wp,-MMD,scripts/mod/.empty.o.d -nostdinc -I../arch/riscv/include -I.=
/arch/riscv/include/generated -I../include -I./include -I../arch/riscv/incl=
ude/uapi -I./arch/riscv/include/generated/uapi -I../include/uapi -I./includ=
e/generated/uapi -include ../include/linux/compiler-version.h -include ../i=
nclude/linux/kconfig.h -include ../include/linux/compiler_types.h -D__KERNE=
L__ -fmacro-prefix-map=3D../=3D -std=3Dgnu11 -fshort-wchar -funsigned-char =
-fno-common -fno-PIE -fno-strict-aliasing -fPIE -mabi=3Dlp64 -march=3Drv64i=
mac_zicsr_zifencei -mno-save-restore -DCONFIG_PAGE_OFFSET=3D0xff60000000000=
000 -mcmodel=3Dmedany -fno-asynchronous-unwind-tables -fno-unwind-tables -m=
no-riscv-attribute -Wa,-mno-arch-attr -mstrict-align -fno-delete-null-point=
er-checks -O2 -fno-allow-store-data-races -fstack-protector-strong -fno-omi=
t-frame-pointer -fno-optimize-sibling-calls -fno-stack-clash-protection -fs=
trict-flex-arrays=3D3 -fno-strict-overflow -fno-stack-check -fconserve-stac=
k -Wall -Wundef -Werror=3Dimplicit-function-declaration -Werror=3Dimplicit-=
int -Werror=3Dreturn-type -Werror=3Dstrict-prototypes -Wno-format-security =
-Wno-trigraphs -Wno-frame-address -Wno-address-of-packed-member -Wmissing-d=
eclarations -Wmissing-prototypes -Wframe-larger-than=3D2048 -Wno-main -Wno-=
dangling-pointer -Wvla -Wno-pointer-sign -Wcast-function-type -Wno-stringop=
-overflow -Wno-array-bounds -Wno-alloc-size-larger-than -Wimplicit-fallthro=
ugh=3D5 -Werror=3Ddate-time -Werror=3Dincompatible-pointer-types -Werror=3D=
designated-init -Wenum-conversion -Wextra -Wunused -Wno-unused-but-set-vari=
able -Wno-unused-const-variable -Wno-packed-not-aligned -Wno-format-overflo=
w -Wno-format-truncation -Wno-stringop-truncation -Wno-override-init -Wno-m=
issing-field-initializers -Wno-type-limits -Wno-shift-negative-value -Wno-m=
aybe-uninitialized -Wno-sign-compare -Wno-unused-parameter -g -gdwarf-5 -I.=
./scripts/mod -Iscripts/mod    -DKBUILD_MODFILE=3D'"scripts/mod/empty"' -DK=
BUILD_BASENAME=3D'"empty"' -DKBUILD_MODNAME=3D'"empty"' -D__KBUILD_MODNAME=
=3Dkmod_empty -c -o scripts/mod/empty.o ../scripts/mod/empty.c=20=20
# cmd_gen_symversions_c scripts/mod/empty.o
  if nm scripts/mod/empty.o 2>/dev/null | grep -q ' __export_symbol_'; then=
 gcc -E -D__GENKSYMS__ -Wp,-MMD,scripts/mod/.empty.o.d -nostdinc -I../arch/=
riscv/include -I./arch/riscv/include/generated -I../include -I./include -I.=
./arch/riscv/include/uapi -I./arch/riscv/include/generated/uapi -I../includ=
e/uapi -I./include/generated/uapi -include ../include/linux/compiler-versio=
n.h -include ../include/linux/kconfig.h -include ../include/linux/compiler_=
types.h -D__KERNEL__ -fmacro-prefix-map=3D../=3D -std=3Dgnu11 -fshort-wchar=
 -funsigned-char -fno-common -fno-PIE -fno-strict-aliasing -fPIE -mabi=3Dlp=
64 -march=3Drv64imac_zicsr_zifencei -mno-save-restore -DCONFIG_PAGE_OFFSET=
=3D0xff60000000000000 -mcmodel=3Dmedany -fno-asynchronous-unwind-tables -fn=
o-unwind-tables -mno-riscv-attribute -Wa,-mno-arch-attr -mstrict-align -fno=
-delete-null-pointer-checks -O2 -fno-allow-store-data-races -fstack-protect=
or-strong -fno-omit-frame-pointer -fno-optimize-sibling-calls -fno-stack-cl=
ash-protection -fstrict-flex-arrays=3D3 -fno-strict-overflow -fno-stack-che=
ck -fconserve-stack -Wall -Wundef -Werror=3Dimplicit-function-declaration -=
Werror=3Dimplicit-int -Werror=3Dreturn-type -Werror=3Dstrict-prototypes -Wn=
o-format-security -Wno-trigraphs -Wno-frame-address -Wno-address-of-packed-=
member -Wmissing-declarations -Wmissing-prototypes -Wframe-larger-than=3D20=
48 -Wno-main -Wno-dangling-pointer -Wvla -Wno-pointer-sign -Wcast-function-=
type -Wno-stringop-overflow -Wno-array-bounds -Wno-alloc-size-larger-than -=
Wimplicit-fallthrough=3D5 -Werror=3Ddate-time -Werror=3Dincompatible-pointe=
r-types -Werror=3Ddesignated-init -Wenum-conversion -Wextra -Wunused -Wno-u=
nused-but-set-variable -Wno-unused-const-variable -Wno-packed-not-aligned -=
Wno-format-overflow -Wno-format-truncation -Wno-stringop-truncation -Wno-ov=
erride-init -Wno-missing-field-initializers -Wno-type-limits -Wno-shift-neg=
ative-value -Wno-maybe-uninitialized -Wno-sign-compare -Wno-unused-paramete=
r -g -gdwarf-5 -I../scripts/mod -Iscripts/mod    -DKBUILD_MODFILE=3D'"scrip=
ts/mod/empty"' -DKBUILD_BASENAME=3D'"empty"' -DKBUILD_MODNAME=3D'"empty"' -=
D__KBUILD_MODNAME=3Dkmod_empty ../scripts/mod/empty.c | scripts/genksyms/ge=
nksyms  -T scripts/mod/empty.symtypes   -r /dev/null >> scripts/mod/.empty.=
o.cmd; fi
# CC      scripts/mod/devicetable-offsets.s
  gcc -Wp,-MMD,scripts/mod/.devicetable-offsets.s.d -nostdinc -I../arch/ris=
cv/include -I./arch/riscv/include/generated -I../include -I./include -I../a=
rch/riscv/include/uapi -I./arch/riscv/include/generated/uapi -I../include/u=
api -I./include/generated/uapi -include ../include/linux/compiler-version.h=
 -include ../include/linux/kconfig.h -include ../include/linux/compiler_typ=
es.h -D__KERNEL__ -fmacro-prefix-map=3D../=3D -std=3Dgnu11 -fshort-wchar -f=
unsigned-char -fno-common -fno-PIE -fno-strict-aliasing -fPIE -mabi=3Dlp64 =
-march=3Drv64imac_zicsr_zifencei -mno-save-restore -DCONFIG_PAGE_OFFSET=3D0=
xff60000000000000 -mcmodel=3Dmedany -fno-asynchronous-unwind-tables -fno-un=
wind-tables -mno-riscv-attribute -Wa,-mno-arch-attr -mstrict-align -fno-del=
ete-null-pointer-checks -O2 -fno-allow-store-data-races -fstack-protector-s=
trong -fno-omit-frame-pointer -fno-optimize-sibling-calls -fno-stack-clash-=
protection -fstrict-flex-arrays=3D3 -fno-strict-overflow -fno-stack-check -=
fconserve-stack -Wall -Wundef -Werror=3Dimplicit-function-declaration -Werr=
or=3Dimplicit-int -Werror=3Dreturn-type -Werror=3Dstrict-prototypes -Wno-fo=
rmat-security -Wno-trigraphs -Wno-frame-address -Wno-address-of-packed-memb=
er -Wmissing-declarations -Wmissing-prototypes -Wframe-larger-than=3D2048 -=
Wno-main -Wno-dangling-pointer -Wvla -Wno-pointer-sign -Wcast-function-type=
 -Wno-stringop-overflow -Wno-array-bounds -Wno-alloc-size-larger-than -Wimp=
licit-fallthrough=3D5 -Werror=3Ddate-time -Werror=3Dincompatible-pointer-ty=
pes -Werror=3Ddesignated-init -Wenum-conversion -Wextra -Wunused -Wno-unuse=
d-but-set-variable -Wno-unused-const-variable -Wno-packed-not-aligned -Wno-=
format-overflow -Wno-format-truncation -Wno-stringop-truncation -Wno-overri=
de-init -Wno-missing-field-initializers -Wno-type-limits -Wno-shift-negativ=
e-value -Wno-maybe-uninitialized -Wno-sign-compare -Wno-unused-parameter -I=
../scripts/mod -Iscripts/mod -DKBUILD_MODFILE=3D'"scripts/mod/devicetable-o=
ffsets"' -DKBUILD_BASENAME=3D'"devicetable_offsets"' -DKBUILD_MODNAME=3D'"d=
evicetable_offsets"' -D__KBUILD_MODNAME=3Dkmod_devicetable_offsets -fverbos=
e-asm -S -o scripts/mod/devicetable-offsets.s ../scripts/mod/devicetable-of=
fsets.c
# HOSTCC  scripts/mod/mk_elfconfig
  gcc -Wp,-MMD,scripts/mod/.mk_elfconfig.d -Wall -Wmissing-prototypes -Wstr=
ict-prototypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/includ=
e -include /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h  -I ./scripts/m=
od   -o scripts/mod/mk_elfconfig ../scripts/mod/mk_elfconfig.c=20=20=20
# HOSTCC  scripts/mod/ksym-provides.o
  gcc -Wp,-MMD,scripts/mod/.ksym-provides.o.d -Wall -Wmissing-prototypes -W=
strict-prototypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/inc=
lude -include /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h  -I ./script=
s/mod -c -o scripts/mod/ksym-provides.o ../scripts/mod/ksym-provides.c
# MKELF   scripts/mod/elfconfig.h
  scripts/mod/mk_elfconfig < scripts/mod/empty.o > scripts/mod/elfconfig.h
set -e; mkdir -p scripts/mod/; trap "rm -f scripts/mod/.tmp_devicetable-off=
sets.h" EXIT; { 	 echo "#ifndef __DEVICETABLE_OFFSETS_H__"; echo "#define _=
_DEVICETABLE_OFFSETS_H__"; echo "/*"; echo " * DO NOT MODIFY."; echo " *"; =
echo " * This file was generated by Kbuild"; echo " */"; echo ""; sed -ne 	=
's:^[[:space:]]*\.ascii[[:space:]]*"\(.*\)".*:\1:; /^->/{s:->#\(.*\):/* \1 =
*/:; s:^->\([^ ]*\) [\$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; s:->::;=
 p;}' < scripts/mod/devicetable-offsets.s; echo ""; echo "#endif"; } > scri=
pts/mod/.tmp_devicetable-offsets.h; if [ ! -r scripts/mod/devicetable-offse=
ts.h ] || ! cmp -s scripts/mod/devicetable-offsets.h scripts/mod/.tmp_devic=
etable-offsets.h; then : '  UPD     scripts/mod/devicetable-offsets.h'; mv =
-f scripts/mod/.tmp_devicetable-offsets.h scripts/mod/devicetable-offsets.h=
; fi
# HOSTLD  scripts/mod/ksym-provides
  gcc   -o scripts/mod/ksym-provides scripts/mod/ksym-provides.o   -lelf
# HOSTCC  scripts/mod/symsearch.o
  gcc -Wp,-MMD,scripts/mod/.symsearch.o.d -Wall -Wmissing-prototypes -Wstri=
ct-prototypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/include=
 -include /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h  -I ./scripts/mo=
d -c -o scripts/mod/symsearch.o ../scripts/mod/symsearch.c
# HOSTCC  scripts/mod/sumversion.o
  gcc -Wp,-MMD,scripts/mod/.sumversion.o.d -Wall -Wmissing-prototypes -Wstr=
ict-prototypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/includ=
e -include /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h  -I ./scripts/m=
od -c -o scripts/mod/sumversion.o ../scripts/mod/sumversion.c
make[4]: *** [Makefile:164: /home/abuild/rpmbuild/BUILD/kernel-default-6.12=
~rc1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids/libbpf/staticobjs/li=
bbpf-in.o] Error 2
make[3]: *** [Makefile:63: /home/abuild/rpmbuild/BUILD/kernel-default-6.12~=
rc1/linux-6.12-rc1/linux-obj/tools/bpf/resolve_btfids//libbpf/libbpf.a] Err=
or 2
make[2]: *** [Makefile:76: bpf/resolve_btfids] Error 2
make[1]: *** [/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc1/linux-6.1=
2-rc1/Makefile:1393: tools/bpf/resolve_btfids] Error 2
make[1]: *** Waiting for unfinished jobs....
# HOSTCC  scripts/mod/modpost.o
  gcc -Wp,-MMD,scripts/mod/.modpost.o.d -Wall -Wmissing-prototypes -Wstrict=
-prototypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/include -=
include /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h  -I ./scripts/mod =
-c -o scripts/mod/modpost.o ../scripts/mod/modpost.c
# HOSTCC  scripts/mod/file2alias.o
  gcc -Wp,-MMD,scripts/mod/.file2alias.o.d -Wall -Wmissing-prototypes -Wstr=
ict-prototypes -O2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/includ=
e -include /home/abuild/rpmbuild/SOURCES/host-memcpy-hack.h  -I ./scripts/m=
od -c -o scripts/mod/file2alias.o ../scripts/mod/file2alias.c
# HOSTLD  scripts/mod/modpost
  gcc   -o scripts/mod/modpost scripts/mod/modpost.o scripts/mod/file2alias=
.o scripts/mod/sumversion.o scripts/mod/symsearch.o=20=20=20
make -f ../scripts/Makefile.build obj=3D. prepare
set -e; mkdir -p include/generated/; trap "rm -f include/generated/.tmp_tim=
econst.h" EXIT; { echo 300 | bc -q ../kernel/time/timeconst.bc; } > include=
/generated/.tmp_timeconst.h; if [ ! -r include/generated/timeconst.h ] || !=
 cmp -s include/generated/timeconst.h include/generated/.tmp_timeconst.h; t=
hen : '  UPD     include/generated/timeconst.h'; mv -f include/generated/.t=
mp_timeconst.h include/generated/timeconst.h; fi
# CHKSHA1 ../include/linux/atomic/atomic-instrumented.h
  if ! command -v sha1sum >/dev/null; then echo "warning: cannot check the =
header due to sha1sum missing"; exit 0; fi; if [ "$(sed -n '$s:// ::p' ../i=
nclude/linux/atomic/atomic-instrumented.h)" !=3D "$(sed '$d' ../include/lin=
ux/atomic/atomic-instrumented.h | sha1sum | sed 's/ .*//')" ]; then echo "e=
rror: ../include/linux/atomic/atomic-instrumented.h has been modified." >&2=
; exit 1; fi; touch .checked-atomic-instrumented.h
# CHKSHA1 ../include/linux/atomic/atomic-long.h
  if ! command -v sha1sum >/dev/null; then echo "warning: cannot check the =
header due to sha1sum missing"; exit 0; fi; if [ "$(sed -n '$s:// ::p' ../i=
nclude/linux/atomic/atomic-long.h)" !=3D "$(sed '$d' ../include/linux/atomi=
c/atomic-long.h | sha1sum | sed 's/ .*//')" ]; then echo "error: ../include=
/linux/atomic/atomic-long.h has been modified." >&2; exit 1; fi; touch .che=
cked-atomic-long.h
# CHKSHA1 ../include/linux/atomic/atomic-arch-fallback.h
  if ! command -v sha1sum >/dev/null; then echo "warning: cannot check the =
header due to sha1sum missing"; exit 0; fi; if [ "$(sed -n '$s:// ::p' ../i=
nclude/linux/atomic/atomic-arch-fallback.h)" !=3D "$(sed '$d' ../include/li=
nux/atomic/atomic-arch-fallback.h | sha1sum | sed 's/ .*//')" ]; then echo =
"error: ../include/linux/atomic/atomic-arch-fallback.h has been modified." =
>&2; exit 1; fi; touch .checked-atomic-arch-fallback.h
# CC      kernel/bounds.s
  gcc -Wp,-MMD,kernel/.bounds.s.d -nostdinc -I../arch/riscv/include -I./arc=
h/riscv/include/generated -I../include -I./include -I../arch/riscv/include/=
uapi -I./arch/riscv/include/generated/uapi -I../include/uapi -I./include/ge=
nerated/uapi -include ../include/linux/compiler-version.h -include ../inclu=
de/linux/kconfig.h -include ../include/linux/compiler_types.h -D__KERNEL__ =
-fmacro-prefix-map=3D../=3D -std=3Dgnu11 -fshort-wchar -funsigned-char -fno=
-common -fno-PIE -fno-strict-aliasing -fPIE -mabi=3Dlp64 -march=3Drv64imac_=
zicsr_zifencei -mno-save-restore -DCONFIG_PAGE_OFFSET=3D0xff60000000000000 =
-mcmodel=3Dmedany -fno-asynchronous-unwind-tables -fno-unwind-tables -mno-r=
iscv-attribute -Wa,-mno-arch-attr -mstrict-align -fno-delete-null-pointer-c=
hecks -O2 -fno-allow-store-data-races -fstack-protector-strong -fno-omit-fr=
ame-pointer -fno-optimize-sibling-calls -fno-stack-clash-protection -fstric=
t-flex-arrays=3D3 -fno-strict-overflow -fno-stack-check -fconserve-stack -W=
all -Wundef -Werror=3Dimplicit-function-declaration -Werror=3Dimplicit-int =
-Werror=3Dreturn-type -Werror=3Dstrict-prototypes -Wno-format-security -Wno=
-trigraphs -Wno-frame-address -Wno-address-of-packed-member -Wmissing-decla=
rations -Wmissing-prototypes -Wframe-larger-than=3D2048 -Wno-main -Wno-dang=
ling-pointer -Wvla -Wno-pointer-sign -Wcast-function-type -Wno-stringop-ove=
rflow -Wno-array-bounds -Wno-alloc-size-larger-than -Wimplicit-fallthrough=
=3D5 -Werror=3Ddate-time -Werror=3Dincompatible-pointer-types -Werror=3Ddes=
ignated-init -Wenum-conversion -Wextra -Wunused -Wno-unused-but-set-variabl=
e -Wno-unused-const-variable -Wno-packed-not-aligned -Wno-format-overflow -=
Wno-format-truncation -Wno-stringop-truncation -Wno-override-init -Wno-miss=
ing-field-initializers -Wno-type-limits -Wno-shift-negative-value -Wno-mayb=
e-uninitialized -Wno-sign-compare -Wno-unused-parameter -I../. -I. -DKBUILD=
_MODFILE=3D'"./bounds"' -DKBUILD_BASENAME=3D'"bounds"' -DKBUILD_MODNAME=3D'=
"bounds"' -D__KBUILD_MODNAME=3Dkmod_bounds -fverbose-asm -S -o kernel/bound=
s.s ../kernel/bounds.c
set -e; mkdir -p include/generated/; trap "rm -f include/generated/.tmp_bou=
nds.h" EXIT; { 	 echo "#ifndef __LINUX_BOUNDS_H__"; echo "#define __LINUX_B=
OUNDS_H__"; echo "/*"; echo " * DO NOT MODIFY."; echo " *"; echo " * This f=
ile was generated by Kbuild"; echo " */"; echo ""; sed -ne 	's:^[[:space:]]=
*\.ascii[[:space:]]*"\(.*\)".*:\1:; /^->/{s:->#\(.*\):/* \1 */:; s:^->\([^ =
]*\) [\$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; s:->::; p;}' < kernel/=
bounds.s; echo ""; echo "#endif"; } > include/generated/.tmp_bounds.h; if [=
 ! -r include/generated/bounds.h ] || ! cmp -s include/generated/bounds.h i=
nclude/generated/.tmp_bounds.h; then : '  UPD     include/generated/bounds.=
h'; mv -f include/generated/.tmp_bounds.h include/generated/bounds.h; fi
# CC      arch/riscv/kernel/asm-offsets.s
  gcc -Wp,-MMD,arch/riscv/kernel/.asm-offsets.s.d -nostdinc -I../arch/riscv=
/include -I./arch/riscv/include/generated -I../include -I./include -I../arc=
h/riscv/include/uapi -I./arch/riscv/include/generated/uapi -I../include/uap=
i -I./include/generated/uapi -include ../include/linux/compiler-version.h -=
include ../include/linux/kconfig.h -include ../include/linux/compiler_types=
.h -D__KERNEL__ -fmacro-prefix-map=3D../=3D -std=3Dgnu11 -fshort-wchar -fun=
signed-char -fno-common -fno-PIE -fno-strict-aliasing -fPIE -mabi=3Dlp64 -m=
arch=3Drv64imac_zicsr_zifencei -mno-save-restore -DCONFIG_PAGE_OFFSET=3D0xf=
f60000000000000 -mcmodel=3Dmedany -fno-asynchronous-unwind-tables -fno-unwi=
nd-tables -mno-riscv-attribute -Wa,-mno-arch-attr -mstrict-align -fno-delet=
e-null-pointer-checks -O2 -fno-allow-store-data-races -fstack-protector-str=
ong -fno-omit-frame-pointer -fno-optimize-sibling-calls -fno-stack-clash-pr=
otection -fstrict-flex-arrays=3D3 -fno-strict-overflow -fno-stack-check -fc=
onserve-stack -Wall -Wundef -Werror=3Dimplicit-function-declaration -Werror=
=3Dimplicit-int -Werror=3Dreturn-type -Werror=3Dstrict-prototypes -Wno-form=
at-security -Wno-trigraphs -Wno-frame-address -Wno-address-of-packed-member=
 -Wmissing-declarations -Wmissing-prototypes -Wframe-larger-than=3D2048 -Wn=
o-main -Wno-dangling-pointer -Wvla -Wno-pointer-sign -Wcast-function-type -=
Wno-stringop-overflow -Wno-array-bounds -Wno-alloc-size-larger-than -Wimpli=
cit-fallthrough=3D5 -Werror=3Ddate-time -Werror=3Dincompatible-pointer-type=
s -Werror=3Ddesignated-init -Wenum-conversion -Wextra -Wunused -Wno-unused-=
but-set-variable -Wno-unused-const-variable -Wno-packed-not-aligned -Wno-fo=
rmat-overflow -Wno-format-truncation -Wno-stringop-truncation -Wno-override=
-init -Wno-missing-field-initializers -Wno-type-limits -Wno-shift-negative-=
value -Wno-maybe-uninitialized -Wno-sign-compare -Wno-unused-parameter -I..=
/. -I. -DKBUILD_MODFILE=3D'"./asm-offsets"' -DKBUILD_BASENAME=3D'"asm_offse=
ts"' -DKBUILD_MODNAME=3D'"asm_offsets"' -D__KBUILD_MODNAME=3Dkmod_asm_offse=
ts -fverbose-asm -S -o arch/riscv/kernel/asm-offsets.s ../arch/riscv/kernel=
/asm-offsets.c
set -e; mkdir -p include/generated/; trap "rm -f include/generated/.tmp_asm=
-offsets.h" EXIT; { 	 echo "#ifndef __ASM_OFFSETS_H__"; echo "#define __ASM=
_OFFSETS_H__"; echo "/*"; echo " * DO NOT MODIFY."; echo " *"; echo " * Thi=
s file was generated by Kbuild"; echo " */"; echo ""; sed -ne 	's:^[[:space=
:]]*\.ascii[[:space:]]*"\(.*\)".*:\1:; /^->/{s:->#\(.*\):/* \1 */:; s:^->\(=
[^ ]*\) [\$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; s:->::; p;}' < arch=
/riscv/kernel/asm-offsets.s; echo ""; echo "#endif"; } > include/generated/=
.tmp_asm-offsets.h; if [ ! -r include/generated/asm-offsets.h ] || ! cmp -s=
 include/generated/asm-offsets.h include/generated/.tmp_asm-offsets.h; then=
 : '  UPD     include/generated/asm-offsets.h'; mv -f include/generated/.tm=
p_asm-offsets.h include/generated/asm-offsets.h; fi
# CALL    ../scripts/checksyscalls.sh
  sh ../scripts/checksyscalls.sh gcc -Wp,-MMD,./.missing-syscalls.d -nostdi=
nc -I../arch/riscv/include -I./arch/riscv/include/generated -I../include -I=
./include -I../arch/riscv/include/uapi -I./arch/riscv/include/generated/uap=
i -I../include/uapi -I./include/generated/uapi -include ../include/linux/co=
mpiler-version.h -include ../include/linux/kconfig.h -include ../include/li=
nux/compiler_types.h -D__KERNEL__ -fmacro-prefix-map=3D../=3D -std=3Dgnu11 =
-fshort-wchar -funsigned-char -fno-common -fno-PIE -fno-strict-aliasing -fP=
IE -mabi=3Dlp64 -march=3Drv64imac_zicsr_zifencei -mno-save-restore -DCONFIG=
_PAGE_OFFSET=3D0xff60000000000000 -mcmodel=3Dmedany -fno-asynchronous-unwin=
d-tables -fno-unwind-tables -mno-riscv-attribute -Wa,-mno-arch-attr -mstric=
t-align -fno-delete-null-pointer-checks -O2 -fno-allow-store-data-races -fs=
tack-protector-strong -fno-omit-frame-pointer -fno-optimize-sibling-calls -=
fno-stack-clash-protection -fstrict-flex-arrays=3D3 -fno-strict-overflow -f=
no-stack-check -fconserve-stack -Wall -Wundef -Werror=3Dimplicit-function-d=
eclaration -Werror=3Dimplicit-int -Werror=3Dreturn-type -Werror=3Dstrict-pr=
ototypes -Wno-format-security -Wno-trigraphs -Wno-frame-address -Wno-addres=
s-of-packed-member -Wmissing-declarations -Wmissing-prototypes -Wframe-larg=
er-than=3D2048 -Wno-main -Wno-dangling-pointer -Wvla -Wno-pointer-sign -Wca=
st-function-type -Wno-stringop-overflow -Wno-array-bounds -Wno-alloc-size-l=
arger-than -Wimplicit-fallthrough=3D5 -Werror=3Ddate-time -Werror=3Dincompa=
tible-pointer-types -Werror=3Ddesignated-init -Wenum-conversion -Wextra -Wu=
nused -Wno-unused-but-set-variable -Wno-unused-const-variable -Wno-packed-n=
ot-aligned -Wno-format-overflow -Wno-format-truncation -Wno-stringop-trunca=
tion -Wno-override-init -Wno-missing-field-initializers -Wno-type-limits -W=
no-shift-negative-value -Wno-maybe-uninitialized -Wno-sign-compare -Wno-unu=
sed-parameter -g -gdwarf-5 -I../. -I.    -DKBUILD_MODFILE=3D'"./missing-sys=
calls"' -DKBUILD_BASENAME=3D'"missing_syscalls"' -DKBUILD_MODNAME=3D'"missi=
ng_syscalls"' -D__KBUILD_MODNAME=3Dkmod_missing_syscalls=20
make: *** [../Makefile:224: __sub-make] Error 2

--=20
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint =3D 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

