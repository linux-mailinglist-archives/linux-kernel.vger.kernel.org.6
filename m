Return-Path: <linux-kernel+bounces-378054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0487A9ACAB8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B191B23C39
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75D51AD9EE;
	Wed, 23 Oct 2024 13:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="LPNjDJDy"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCAE1AB6FB
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 13:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729688776; cv=none; b=A90pkX2ZKJcg2otUVmN8nSQvj1SOiBcPMULtRR2qPKZX2Hhetm1SU+1W9LZme0fX2bFpQr392uuz5aknuKA+Hiaw7805bgAF61WdKGlM6Ha+wPDHBHyfke4eJatojAZQkFwXKIB3DFgzauacJCOJbSh1VQHKYltpl5RfGy0Nrjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729688776; c=relaxed/simple;
	bh=flfO60TWeuxQF01508WOwBdKE/thtg0nWRNabeZ0mGY=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=OtXSkpKbOpqCRGde/HI09vV29rwVJik6MwVQRLp/sEmIqxJfub0SrFq40Bx6KDPe4QJ9IteVqKTqlVdyRQyOihfuuH8UVaJTR7mfRVK3yCc2Fw6VFa/PC/xswwSkq/4mEReGnwOrolN2/4k3C6EtFo9sSLXyQBlvFE8ms+4AwMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=LPNjDJDy; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTPS
	id 3aoNtonyciA193b40tUJiS; Wed, 23 Oct 2024 13:06:12 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 3b3zt36VQib8Q3b3zt6lD3; Wed, 23 Oct 2024 13:06:11 +0000
X-Authority-Analysis: v=2.4 cv=T4qKTeKQ c=1 sm=1 tr=0 ts=6718f4c3
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7vwVE5O1G3EA:10 a=HaFmDPmJAAAA:8
 a=VwQbUJbxAAAA:8 a=fxJcL_dCAAAA:8 a=NEAV23lmAAAA:8 a=G7piZchHOouoqsGl2bUA:9
 a=QEXdDO2ut3YA:10 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WLBEG65iDfq4Oq3j0KXR8fkux6/NdKD8wZ6AX1HNr8k=; b=LPNjDJDyN1Va9HjdzSdw2kagT0
	CRMzFAVwRROtcB8GcyKv047bGMCYHqedVdAv5spxHwHxh4toBVhAMM+06KaF6t9qalwgwzp6hnVFO
	vpT0W9zFnzJtD4E3YdAPBcaqTxTVsaD3orLiAzBq7zCliR9oezMeiYFJ8ZVLkwUnb4SrhySfi/tWQ
	XE6tuyLhzJtyVByPjOTdI3OlCHdBsnwdT3/JkawoKGJDnKGroqsHz2gdp0F0do72tHpBLvMASFOjl
	JQONTDKFGFpQdqW/PrxryCuKrhVD88FyHEovlqBXKbcxLMGHb2l7gm0rrK6DfMXTWSS9KbSmbY4GY
	yAXDJjBg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:49836 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1t3b3y-003lNZ-1z;
	Wed, 23 Oct 2024 07:06:10 -0600
Subject: Re: [PATCH 2/3] kbuild: deb-pkg: add
 pkg.linux-upstream.nokernelheaders build profile
To: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org
Cc: Ben Hutchings <benh@debian.org>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Nicolas Schier <nicolas@fjasle.eu>, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20241022181703.1710116-1-masahiroy@kernel.org>
 <20241022181703.1710116-2-masahiroy@kernel.org>
In-Reply-To: <20241022181703.1710116-2-masahiroy@kernel.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <6fca7450-95e0-1bc0-7556-8889a398d0b6@w6rz.net>
Date: Wed, 23 Oct 2024 06:06:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.223.253.157
X-Source-L: No
X-Exim-ID: 1t3b3y-003lNZ-1z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:49836
X-Source-Auth: re@w6rz.net
X-Email-Count: 9
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGEGbDecpRlWDH4uMrACDttkXaq6sUKY0Ef0eg6GMxJffHskhwY0efpzhbUm4b7yuIaVW23uvZ8unuVtrgsqFC21YEhCPhlew8464/CwJl+atSHhr8qo
 O4nWtbSMbmDTeoZu+3WMALRxgujeN3n263J/5fPWDOfdSO5NgjpIKv4/HuENCYzO4RedVKxGnVH3F4cdFoJEi5gC1u9UInErjRw=

On 10/22/24 11:16 AM, Masahiro Yamada wrote:
> Since commit f1d87664b82a ("kbuild: cross-compile linux-headers package
> when possible"), 'make bindeb-pkg' may attempt to cross-compile the
> linux-headers package, but it fails under certain circumstances.
>
> For example, when CONFIG_MODULE_SIG_FORMAT is enabled on Debian, the
> following command fails:
>
>    $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- bindeb-pkg
>        [ snip ]
>    Rebuilding host programs with aarch64-linux-gnu-gcc...
>      HOSTCC  debian/linux-headers-6.12.0-rc4/usr/src/linux-headers-6.12.0-rc4/scripts/kallsyms
>      HOSTCC  debian/linux-headers-6.12.0-rc4/usr/src/linux-headers-6.12.0-rc4/scripts/sorttable
>      HOSTCC  debian/linux-headers-6.12.0-rc4/usr/src/linux-headers-6.12.0-rc4/scripts/asn1_compiler
>      HOSTCC  debian/linux-headers-6.12.0-rc4/usr/src/linux-headers-6.12.0-rc4/scripts/sign-file
>    In file included from /usr/include/openssl/opensslv.h:109,
>                     from debian/linux-headers-6.12.0-rc4/usr/src/linux-headers-6.12.0-rc4/scripts/sign-file.c:25:
>    /usr/include/openssl/macros.h:14:10: fatal error: openssl/opensslconf.h: No such file or directory
>       14 | #include <openssl/opensslconf.h>
>          |          ^~~~~~~~~~~~~~~~~~~~~~~
>    compilation terminated.
>
> This commit adds a new profile, pkg.linux-upstream.nokernelheaders, to
> guard the linux-headers package.
>
> There are two options to fix the above issue.
>
> [option 1] Set the pkg.linux-upstream.nokernelheaders build profile
>
>    $ DEB_BUILD_PROFILES=pkg.linux-upstream.nokernelheaders \
>      make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- bindeb-pkg
>
> This skips the building of the linux-headers package.
>
> [option 2] Install the necessary build dependencies
>
> If you want to cross-compile the linux-headers package, you need to
> install additional packages. This is a one-time installation step.
>
> For example, on Debian, the packages necessary for cross-compiling it
> to arm64 can be installed with the following commands:
>
>    # dpkg --add-architecture arm64
>    # apt update
>    # apt install gcc-aarch64-linux-gnu libssl-dev:arm64
>
> Fixes: f1d87664b82a ("kbuild: cross-compile linux-headers package when possible")
> Reported-by: Ron Economos <re@w6rz.net>
> Closes: https://lore.kernel.org/all/b3d4f49e-7ddb-29ba-0967-689232329b53@w6rz.net/
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>   scripts/package/builddeb             | 2 +-
>   scripts/package/install-extmod-build | 6 ++----
>   scripts/package/mkdebian             | 9 ++++++++-
>   3 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> index 404587fc71fe..441b0bb66e0d 100755
> --- a/scripts/package/builddeb
> +++ b/scripts/package/builddeb
> @@ -123,7 +123,7 @@ install_kernel_headers () {
>   	pdir=debian/$1
>   	version=${1#linux-headers-}
>   
> -	"${srctree}/scripts/package/install-extmod-build" "${pdir}/usr/src/linux-headers-${version}"
> +	CC="${DEB_HOST_GNU_TYPE}-gcc" "${srctree}/scripts/package/install-extmod-build" "${pdir}/usr/src/linux-headers-${version}"
>   
>   	mkdir -p $pdir/lib/modules/$version/
>   	ln -s /usr/src/linux-headers-$version $pdir/lib/modules/$version/build
> diff --git a/scripts/package/install-extmod-build b/scripts/package/install-extmod-build
> index d2c9cacecc0c..7ec1f061a519 100755
> --- a/scripts/package/install-extmod-build
> +++ b/scripts/package/install-extmod-build
> @@ -44,13 +44,11 @@ mkdir -p "${destdir}"
>   	fi
>   } | tar -c -f - -T - | tar -xf - -C "${destdir}"
>   
> -# When ${CC} and ${HOSTCC} differ, we are likely cross-compiling. Rebuild host
> -# programs using ${CC}. This assumes CC=${CROSS_COMPILE}gcc, which is usually
> -# the case for package building. It does not cross-compile when CC=clang.
> +# When ${CC} and ${HOSTCC} differ, rebuild host programs using ${CC}.
>   #
>   # This caters to host programs that participate in Kbuild. objtool and
>   # resolve_btfids are out of scope.
> -if [ "${CC}" != "${HOSTCC}" ] && is_enabled CONFIG_CC_CAN_LINK; then
> +if [ "${CC}" != "${HOSTCC}" ]; then
>   	echo "Rebuilding host programs with ${CC}..."
>   
>   	cat <<-'EOF' >  "${destdir}/Kbuild"
> diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
> index 10637d403777..93eb50356ddb 100755
> --- a/scripts/package/mkdebian
> +++ b/scripts/package/mkdebian
> @@ -179,6 +179,8 @@ fi
>   
>   echo $debarch > debian/arch
>   
> +host_gnu=$(dpkg-architecture -a "${debarch}" -q DEB_HOST_GNU_TYPE | sed 's/_/-/g')
> +
>   # Generate a simple changelog template
>   cat <<EOF > debian/changelog
>   $sourcename ($packageversion) $distribution; urgency=low
> @@ -196,7 +198,11 @@ Priority: optional
>   Maintainer: $maintainer
>   Rules-Requires-Root: no
>   Build-Depends: debhelper-compat (= 12)
> -Build-Depends-Arch: bc, bison, cpio, flex, kmod, libelf-dev:native, libssl-dev:native, rsync
> +Build-Depends-Arch: bc, bison, cpio, flex,
> + gcc-${host_gnu} <!pkg.${sourcename}.nokernelheaders>,
> + kmod, libelf-dev:native,
> + libssl-dev:native, libssl-dev <!pkg.${sourcename}.nokernelheaders>,
> + rsync
>   Homepage: https://www.kernel.org/
>   
>   Package: $packagename-$version
> @@ -224,6 +230,7 @@ cat <<EOF >> debian/control
>   
>   Package: linux-headers-$version
>   Architecture: $debarch
> +Build-Profiles: <!pkg.${sourcename}.nokernelheaders>
>   Description: Linux kernel headers for $version on $debarch
>    This package provides kernel header files for $version on $debarch
>    .

Tested with option 2 for RISC-V. On Ubuntu 24.04, the following must be 
added to the file /etc/apt/sources.list.d/ubuntu.sources for apt update 
to fetch the correct repositories:

Types: deb
URIs: http://ports.ubuntu.com/ubuntu-ports
Suites: noble noble-updates noble-backports
Components: main universe restricted multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
Architectures: riscv64

Then:

sudo dpkg --add-architecture riscv64
sudo apt-get update
sudo apt-get install libssl-dev:riscv64

The tool chain at https://github.com/riscv-collab/riscv-gnu-toolchain 
can also be made to work. See:

https://github.com/riscv-collab/riscv-gnu-toolchain/issues/1590

Tested-by: Ron Economos <re@w6rz.net>



