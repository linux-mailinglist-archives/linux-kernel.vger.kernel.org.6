Return-Path: <linux-kernel+bounces-241659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1637E927DB4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 21:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 372B61C2359A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7A113665A;
	Thu,  4 Jul 2024 19:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFD+u1UB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C7A4CB28
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720120739; cv=none; b=FWZKR1ZDlBq1/RdY7TIKRZn0a1xVkqe5Hgj07HIP/IhBr+AgWFpEC6mPdTviX6Qil8TSMhZGZYlhD7VwnvGCnPGFUHnF4WWv7BgXFhnJgHp8hwDyr9k7SDp+Z+dPHTPESi18UzFo+zQ6VHbNWTBnkb119WPO3nl3YVVviL20VL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720120739; c=relaxed/simple;
	bh=s220n8X2nhm1THi0+P5Yi7KI/flzymriSlcmI0M2fDw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Sbx8B4gNWOJ0R8ZhEMs/sCD4qMHOQJRzJxswH17O+HxLK6Xhg6vQ+BlDkSACHOBEIFGEj+Oi+HNP0uXVkLOuzDplQ2i5Y4hxmbazcUa98MGPCN4/pZXN6DS00hoZ0uPkKCyLbG5h5bzzJ1+fbotE+j35MDXK9Gx3O5Cx9YvbcAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFD+u1UB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38974C3277B;
	Thu,  4 Jul 2024 19:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720120738;
	bh=s220n8X2nhm1THi0+P5Yi7KI/flzymriSlcmI0M2fDw=;
	h=Date:From:To:Cc:Subject:From;
	b=TFD+u1UB/jJ5FPBj1sHWe9Fa+x93EcH91O7TJVKp1Pb+6x4SJjaZ16Ev8GpLjMKxi
	 2QWH/08KjuMkjIt87g4aJiBOaC1vJ8TXqdGh5xyJIBxHhnhWzqpayF0lrf6wB/4+rk
	 rvcYmLmlYNftjinun5vCcR8VZ/PqssPb3UtFkLybVqlRBZNXrbkhdjOcs3BjVkYAWF
	 yzM2l7NHpAC9Nj5iGvMgG7RtwRJles+EeOztAPbD1pwTsJ5YZ0sC7MCz4nd4bdyLNy
	 /+TXJiyz+gEDJQDd7PqJ/BaAgfLZBCuFKFNTFF92DJ7PVLvpVYWXnTgLihGHJgNuNf
	 j4a4wQN9/23eg==
Date: Thu, 4 Jul 2024 16:18:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Build failure for perf daemon on perf-tools-next
Message-ID: <Zob1n0hC6uavZKT9@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

	I hadn't notice this before, its like this code isn't being
built and some change made it build or that daemon->start field (or curr
local variable) changed its type or we have a new compiler that has a
new type check, I'm still checking:

perfbuilder@number:~$ dsh debian:experimental-x-mips
$ bash
toolsbuilder@84768d80be97:/$ cat /etc/os-release=20
PRETTY_NAME=3D"Debian GNU/Linux trixie/sid"
NAME=3D"Debian GNU/Linux"
VERSION_CODENAME=3Dtrixie
ID=3Ddebian
HOME_URL=3D"https://www.debian.org/"
SUPPORT_URL=3D"https://www.debian.org/support"
BUG_REPORT_URL=3D"https://bugs.debian.org/"
toolsbuilder@84768d80be97:/$ mips-linux-gnu-gcc -v
Using built-in specs.
COLLECT_GCC=3Dmips-linux-gnu-gcc
COLLECT_LTO_WRAPPER=3D/usr/libexec/gcc-cross/mips-linux-gnu/13/lto-wrapper
Target: mips-linux-gnu
Configured with: ../src/configure -v --with-pkgversion=3D'Debian 13.2.0-25'=
 --with-bugurl=3Dfile:///usr/share/doc/gcc-13/README.Bugs --enable-language=
s=3Dc,ada,c++,go,d,fortran,objc,obj-c++,m2 --prefix=3D/usr --with-gcc-major=
-version-only --program-suffix=3D-13 --enable-shared --enable-linker-build-=
id --libexecdir=3D/usr/libexec --without-included-gettext --enable-threads=
=3Dposix --libdir=3D/usr/lib --enable-nls --with-sysroot=3D/ --enable-cloca=
le=3Dgnu --enable-libstdcxx-debug --enable-libstdcxx-time=3Dyes --with-defa=
ult-libstdcxx-abi=3Dnew --enable-libstdcxx-backtrace --enable-gnu-unique-ob=
ject --disable-libitm --disable-libsanitizer --disable-libquadmath --disabl=
e-libquadmath-support --enable-plugin --enable-default-pie --with-system-zl=
ib --enable-libphobos-checking=3Drelease --without-target-system-zlib --ena=
ble-multiarch --disable-werror --enable-multilib --with-arch-32=3Dmips32r2 =
--with-fp-32=3Dxx --with-lxc1-sxc1=3Dno --enable-targets=3Dall --with-arch-=
64=3Dmips64r2 --enable-checking=3Drelease --build=3Dx86_64-linux-gnu --host=
=3Dx86_64-linux-gnu --target=3Dmips-linux-gnu --program-prefix=3Dmips-linux=
-gnu- --includedir=3D/usr/mips-linux-gnu/include --with-build-config=3Dboot=
strap-lto-lean --enable-link-serialization=3D8
Thread model: posix
Supported LTO compression algorithms: zlib zstd
gcc version 13.2.0 (Debian 13.2.0-25)=20
toolsbuilder@84768d80be97:/$



 21     6.70 debian:experimental-x-mips    : FAIL gcc version 13.2.0 (Debia=
n 13.2.0-25)=20
    builtin-daemon.c: In function 'cmd_session_list':
    builtin-daemon.c:691:35: error: format '%lu' expects argument of type '=
long unsigned int', but argument 4 has type 'time_t' {aka 'long long int'} =
[-Werror=3Dformat=3D]
      691 |                 fprintf(out, "%c%lu",
          |                                 ~~^
          |                                   |
          |                                   long unsigned int
          |                                 %llu
      692 |                         /* session up time */
      693 |                         csv_sep, (curr - daemon->start) / 60);
          |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
          |                                                         |
          |                                                         time_t =
{aka long long int}
    builtin-daemon.c:703:52: error: format '%lu' expects argument of type '=
long unsigned int', but argument 3 has type 'time_t' {aka 'long long int'} =
[-Werror=3Dformat=3D]
      703 |                         fprintf(out, "  up:      %lu minutes\n",
          |                                                  ~~^
          |                                                    |
          |                                                    long unsigne=
d int
          |                                                  %llu
      704 |                                 (curr - daemon->start) / 60);
          |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
          |                                                        |
          |                                                        time_t {=
aka long long int}
    builtin-daemon.c:730:43: error: format '%lu' expects argument of type '=
long unsigned int', but argument 4 has type 'time_t' {aka 'long long int'} =
[-Werror=3Dformat=3D]
      730 |                         fprintf(out, "%c%lu",
          |                                         ~~^
          |                                           |
          |                                           long unsigned int
          |                                         %llu
      731 |                                 /* session up time */
      732 |                                 csv_sep, (curr - session->start=
) / 60);
          |                                          ~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
          |                                                                =
  |
          |                                                                =
  time_t {aka long long int}
    builtin-daemon.c:748:52: error: format '%lu' expects argument of type '=
long unsigned int', but argument 3 has type 'time_t' {aka 'long long int'} =
[-Werror=3Dformat=3D]
      748 |                         fprintf(out, "  up:      %lu minutes\n",
          |                                                  ~~^
          |                                                    |
          |                                                    long unsigne=
d int
          |                                                  %llu
      749 |                                 (curr - session->start) / 60);
          |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          |                                                         |
          |                                                         time_t =
{aka long long int}
    cc1: all warnings being treated as errors
    tests/workloads/landlock.c:27:15: error: packed attribute causes ineffi=
cient alignment for 'allowed_access' [-Werror=3Dattributes]
       27 |         __u64 allowed_access;
          |               ^~~~~~~~~~~~~~
    tests/workloads/landlock.c:28:15: error: packed attribute causes ineffi=
cient alignment for 'parent_fd' [-Werror=3Dattributes]
       28 |         __s32 parent_fd;
          |               ^~~~~~~~~
    cc1: all warnings being treated as errors
    make[4]: *** [/git/perf-6.10.0-rc3/tools/build/Makefile.build:158: work=
loads] Error 2
    make[3]: *** [/git/perf-6.10.0-rc3/tools/build/Makefile.build:158: test=
s] Error 2


