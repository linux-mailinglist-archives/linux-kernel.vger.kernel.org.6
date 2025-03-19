Return-Path: <linux-kernel+bounces-568194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46962A691D4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B38AF1B87895
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839E61E1A33;
	Wed, 19 Mar 2025 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpCSKzzt"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F4E2144BC
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395043; cv=none; b=NH2cNiVg1HdnY3GM/k3SPDDWIJC3rSAyCU8t2j5Rv4Tx2CuzZVnvo8Dq4z0pAbK/dxYIXEADTJKtUgSbeOmysTyPFKYpKJHZLsBkMox6JSYA9mkKrto//h2EVpJi7SOGC6qsjtgA4j89OKQ4WaLZBk38P8NaJzsURZCj7HzA640=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395043; c=relaxed/simple;
	bh=UeUag6u+mlyY/+Xz8cSIJV4pmTqdRgd7JuCvEy76i7U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cs6HpFN0mcvI40+m+qnpmbbMcA6cASQUaI19Zj5Bm92Ysj1cFF9+kvWUg7Extla6F7b0lXij6bqgoFJB3IylDfazu53Y6XD/R/6ZRSi/Ny8ntteYwXtYN6Ip452esUJtiuyQnrJWJugG+yRRsOFSKnniaVo9BcQsU82m1pyPU6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpCSKzzt; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39143200ddaso4426110f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 07:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742395040; x=1742999840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qwWz96WiNV/Z94zFabBGjqU24HjPe/PcBjDRR61jt5s=;
        b=gpCSKzztvzHUfo2ALqx/zCW0EocPSAWo8LRYBLPPxx9nFH5p7pEEY2iaaVYDa2AKR+
         I8DruarfV3Z1e0Ec/mhGDJWeAmAL3cDv2Xf8hFn1+LOIxsnMzi2xDOEkTvYlNMJ77i4x
         LYoHj7kN7isaCyuUNo/EDL04pE6/eQmBIyQO+iSfkqxPxexVep1eO0cbvx03xXpURQyK
         ckND0imQ/QcYK40Mm1+9QdpRM5sWBNrc1MLgVtcgv8oHdVAiUdwcHyr2RDGW/tIMG8G/
         xzLbs7i7gAigU6FCWBISmDke+GhJ4S3W93YFPg+D3fiZ+C5qEzOq+TMaPOY0wOdrI7Oj
         r2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742395040; x=1742999840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwWz96WiNV/Z94zFabBGjqU24HjPe/PcBjDRR61jt5s=;
        b=sel2gG6JTlDyNBk2UWW1ErvtqjptvUwhgcdKkptA6zzR23BDTvgfVvEx6rNzRSV8e3
         fpScz5pIYv17pfj+aOGEKjvwDTTTSHpnTXu5tYXpGerZocHMzT9JRTcI3Rsb6o3GslKM
         2mx7UHj5/sBTnaeMMe0ivdV13VdLTC9o7Cp7Z8hAkpfB1mPbTGTCJQbBvE+zyuIbxnD7
         WpTCINfwPcE7FKK/robAG1wo7lg2HwSIPSPx936m/BiWuUaPOn3QzY0MaO4VERORMiI3
         d4rWT4a0CsM16skJ6z/gEAuvRcLRg4RMqfUcCMHgIVrNFg9F6IW3yw5Uh/uxsumKtRc4
         GgDw==
X-Forwarded-Encrypted: i=1; AJvYcCUH0VMpIxheMMZtPsf9Kde4EdtJs6WIqfVQvX5rbcgHcaGhKb+ne4dJLkax3EKV5KEekKXkJ0WfWv64n7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzdre/Z6cr8gEMmfm71ryc+DdGwXBmakoI/nqngsBxzenp9khg
	ZT9xtmnIFhDhTzE5OqVntnOa3PIiB4YqdJI2mLyB1yCb7lefOG1t
X-Gm-Gg: ASbGncueGiGsDIJ3rCNjNDujaNF8xga/cAGuW+5OJBFEjoiVzXAY9hghnnAIo2W0pIZ
	vOa6syU9e6xRG9CqZFc7wb+e5g3YopIJGQS8w5zcIJc0SvH+QOxhAqGj4MpSiF8zL6N0yNWlBqJ
	KdwkzEUZmdnbnpTd3ESXoXpHK+L469FPDOcJI2FujiELdabDRes5Xabz0K6opkzlykSWYbWbLJx
	kklOYWczGKK5Z5xzLzyG6pag8lXELFBYVtiRDC+QRDHVnLq8B6uXaMVbe7l2pkkcMpLxd9aaoFE
	JswlnAFVwwGZv+axOKCwt74GIQjVY7sZme7mRg==
X-Google-Smtp-Source: AGHT+IFtIK5/HoxjyU6cRp8SW0XpNS59br2BtHuZQtnjwPjJXipWpI2kDpDSc48YZNj/b8KWExMBMQ==
X-Received: by 2002:a05:6000:2711:b0:38f:2b77:a9f3 with SMTP id ffacd0b85a97d-39973b027e5mr2188360f8f.43.1742395039871;
        Wed, 19 Mar 2025 07:37:19 -0700 (PDT)
Received: from krava ([2a00:102a:401d:cac0:6b77:a4c1:6f71:6634])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8881544sm20751303f8f.43.2025.03.19.07.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 07:37:19 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 19 Mar 2025 15:37:16 +0100
To: kernel test robot <lkp@intel.com>
Cc: Tony Ambardar <tony.ambardar@gmail.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: net/bpf/test_run.c:511:1: warning: 'retain' attribute ignored
Message-ID: <Z9rWnFnf6Wkc6Ghm@krava>
References: <202503191909.SHOCLBzK-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202503191909.SHOCLBzK-lkp@intel.com>

On Wed, Mar 19, 2025 at 07:30:45PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   81e4f8d68c66da301bb881862735bd74c6241a19
> commit: 7bdcedd5c8fb88e7176b93812b139eca5fe0aa46 bpf: Harden __bpf_kfunc tag against linker kfunc removal
> date:   9 months ago
> config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20250319/202503191909.SHOCLBzK-lkp@intel.com/config)
> compiler: mips-linux-gcc (GCC) 11.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250319/202503191909.SHOCLBzK-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202503191909.SHOCLBzK-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):

hi,
we hit similar issue before:
  https://lore.kernel.org/bpf/CAMuHMdUaYP3-2JHk-OE9B-AWNU3ikhBdLyWDm0R8DwQpUS9eCw@mail.gmail.com/

solution was to upgrade gcc

jirka


> 
> >> net/bpf/test_run.c:511:1: warning: 'retain' attribute ignored [-Wattributes]
>      511 | {
>          | ^
>    net/bpf/test_run.c:557:1: warning: 'retain' attribute ignored [-Wattributes]
>      557 | {
>          | ^
>    net/bpf/test_run.c:566:1: warning: 'retain' attribute ignored [-Wattributes]
>      566 | {
>          | ^
>    net/bpf/test_run.c:573:1: warning: 'retain' attribute ignored [-Wattributes]
>      573 | {
>          | ^
>    net/bpf/test_run.c:579:1: warning: 'retain' attribute ignored [-Wattributes]
>      579 | {
>          | ^
>    net/bpf/test_run.c:608:1: warning: 'retain' attribute ignored [-Wattributes]
>      608 | {
>          | ^
>    net/bpf/test_run.c:613:1: warning: 'retain' attribute ignored [-Wattributes]
>      613 | {
>          | ^
>    net/bpf/test_run.c:619:1: warning: 'retain' attribute ignored [-Wattributes]
>      619 | {
>          | ^
>    net/bpf/test_run.c:623:1: warning: 'retain' attribute ignored [-Wattributes]
>      623 | {
>          | ^
> --
> >> net/core/filter.c:11863:1: warning: 'retain' attribute ignored [-Wattributes]
>    11863 | {
>          | ^
>    net/core/filter.c:11876:1: warning: 'retain' attribute ignored [-Wattributes]
>    11876 | {
>          | ^
>    net/core/filter.c:11889:1: warning: 'retain' attribute ignored [-Wattributes]
>    11889 | {
>          | ^
>    net/core/filter.c:11910:1: warning: 'retain' attribute ignored [-Wattributes]
>    11910 | {
>          | ^
>    net/core/filter.c:12096:1: warning: 'retain' attribute ignored [-Wattributes]
>    12096 | {
>          | ^
> --
> >> net/core/xdp.c:713:1: warning: 'retain' attribute ignored [-Wattributes]
>      713 | {
>          | ^
>    net/core/xdp.c:736:1: warning: 'retain' attribute ignored [-Wattributes]
>      736 | {
>          | ^
>    net/core/xdp.c:769:1: warning: 'retain' attribute ignored [-Wattributes]
>      769 | {
>          | ^
> --
> >> net/ipv4/tcp_cong.c:455:1: warning: 'retain' attribute ignored [-Wattributes]
>      455 | {
>          | ^
>    net/ipv4/tcp_cong.c:469:1: warning: 'retain' attribute ignored [-Wattributes]
>      469 | {
>          | ^
>    net/ipv4/tcp_cong.c:495:1: warning: 'retain' attribute ignored [-Wattributes]
>      495 | {
>          | ^
>    net/ipv4/tcp_cong.c:514:1: warning: 'retain' attribute ignored [-Wattributes]
>      514 | {
>          | ^
>    net/ipv4/tcp_cong.c:522:1: warning: 'retain' attribute ignored [-Wattributes]
>      522 | {
>          | ^
> --
> >> net/ipv4/fou_bpf.c:46:1: warning: 'retain' attribute ignored [-Wattributes]
>       46 | {
>          | ^
>    net/ipv4/fou_bpf.c:88:1: warning: 'retain' attribute ignored [-Wattributes]
>       88 | {
>          | ^
> --
> >> net/ipv4/tcp_bbr.c:300:1: warning: 'retain' attribute ignored [-Wattributes]
>      300 | {
>          | ^
>    net/ipv4/tcp_bbr.c:333:1: warning: 'retain' attribute ignored [-Wattributes]
>      333 | {
>          | ^
>    net/ipv4/tcp_bbr.c:1028:1: warning: 'retain' attribute ignored [-Wattributes]
>     1028 | {
>          | ^
>    net/ipv4/tcp_bbr.c:1040:1: warning: 'retain' attribute ignored [-Wattributes]
>     1040 | {
>          | ^
>    net/ipv4/tcp_bbr.c:1082:1: warning: 'retain' attribute ignored [-Wattributes]
>     1082 | {
>          | ^
>    net/ipv4/tcp_bbr.c:1091:1: warning: 'retain' attribute ignored [-Wattributes]
>     1091 | {
>          | ^
>    net/ipv4/tcp_bbr.c:1102:1: warning: 'retain' attribute ignored [-Wattributes]
>     1102 | {
>          | ^
>    net/ipv4/tcp_bbr.c:1130:1: warning: 'retain' attribute ignored [-Wattributes]
>     1130 | {
>          | ^
> --
> >> net/ipv4/tcp_cubic.c:130:1: warning: 'retain' attribute ignored [-Wattributes]
>      130 | {
>          | ^
>    net/ipv4/tcp_cubic.c:143:1: warning: 'retain' attribute ignored [-Wattributes]
>      143 | {
>          | ^
>    net/ipv4/tcp_cubic.c:325:1: warning: 'retain' attribute ignored [-Wattributes]
>      325 | {
>          | ^
>    net/ipv4/tcp_cubic.c:342:1: warning: 'retain' attribute ignored [-Wattributes]
>      342 | {
>          | ^
>    net/ipv4/tcp_cubic.c:359:1: warning: 'retain' attribute ignored [-Wattributes]
>      359 | {
>          | ^
>    net/ipv4/tcp_cubic.c:449:1: warning: 'retain' attribute ignored [-Wattributes]
>      449 | {
>          | ^
> --
> >> net/ipv4/tcp_dctcp.c:90:1: warning: 'retain' attribute ignored [-Wattributes]
>       90 | {
>          | ^
>    net/ipv4/tcp_dctcp.c:119:1: warning: 'retain' attribute ignored [-Wattributes]
>      119 | {
>          | ^
>    net/ipv4/tcp_dctcp.c:128:1: warning: 'retain' attribute ignored [-Wattributes]
>      128 | {
>          | ^
>    net/ipv4/tcp_dctcp.c:184:1: warning: 'retain' attribute ignored [-Wattributes]
>      184 | {
>          | ^
>    net/ipv4/tcp_dctcp.c:194:1: warning: 'retain' attribute ignored [-Wattributes]
>      194 | {
>          | ^
>    net/ipv4/tcp_dctcp.c:244:1: warning: 'retain' attribute ignored [-Wattributes]
>      244 | {
>          | ^
> --
> >> fs/verity/measure.c:121:1: warning: 'retain' attribute ignored [-Wattributes]
>      121 | {
>          | ^
> 
> 
> vim +/retain +511 net/bpf/test_run.c
> 
> 391145ba2accc4 Dave Marchevsky         2023-10-31  509  
> 400031e05adfce David Vernet            2023-02-01  510  __bpf_kfunc int bpf_fentry_test1(int a)
> faeb2dce084aff Alexei Starovoitov      2019-11-14 @511  {
> faeb2dce084aff Alexei Starovoitov      2019-11-14  512  	return a + 1;
> faeb2dce084aff Alexei Starovoitov      2019-11-14  513  }
> 46565696434095 Kumar Kartikeya Dwivedi 2022-01-14  514  EXPORT_SYMBOL_GPL(bpf_fentry_test1);
> faeb2dce084aff Alexei Starovoitov      2019-11-14  515  
> 
> :::::: The code at line 511 was first introduced by commit
> :::::: faeb2dce084aff92d466c6ce68481989b815435b bpf: Add kernel test functions for fentry testing
> 
> :::::: TO: Alexei Starovoitov <ast@kernel.org>
> :::::: CC: Daniel Borkmann <daniel@iogearbox.net>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

