Return-Path: <linux-kernel+bounces-369688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9009A2118
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09111C21C71
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6471DC04D;
	Thu, 17 Oct 2024 11:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PDkPc30P"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691DD1D517C;
	Thu, 17 Oct 2024 11:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729165166; cv=none; b=VCS0sOHbuYZRDtiM7erWgqHo+40fHiPNza8Gm42Y8ZPHTCcQzFzlcF/K/ez4ppwB1d81XvzOe8+12aRnof9QqeknByIlmwdrrFp4RLcd3dA+BKrpqXHKtypwfIa5DNAUv9z0f8QQzZjfP0FTE5EnZdxvRrKRXOKPiGsWZaoViHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729165166; c=relaxed/simple;
	bh=z76vLyDMvBNsHLScSM6/6X7rvP+qA/GeX4JNYITLiZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4rl9hs6eQ4Zn5c8kkmAP+t5OX3Vos4ujrYG4NkFVcSdrzr0pHoDb22i3yKAxu9KSUUIt7mitaeJoPWexjg8cQ4oZYPcWuArvok+r7t4ggQ+LEL5N44JSY8RJ1no93gc+6WRGU/0id5clgic41TbW75OIJrYffWk3HA6nBNMEyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PDkPc30P; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729165163; x=1760701163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z76vLyDMvBNsHLScSM6/6X7rvP+qA/GeX4JNYITLiZc=;
  b=PDkPc30PvtuWw7SzRyZb5VFN3+v5uIHAyIckRMQRJ5T3UyaQYN4+20xm
   7c4yOYt/0gfFPLisN7MDFkQK6+yyM3mJq5EKgBahnqx+4Z33zScyv21uG
   4IO3hQWL+1Vhg3R2wMFqHG5SbyDFa5FqHuDoztyub2/alWws6dY4CcEka
   hdA6ohKcSue4OOrF9+3c3QConLCVWhw4HFklq3X8iZp77nL6baFznKlE6
   7rWSsbTxIYckP8jmGARzoCsJ71BKGMe7RZzzRz0j+S3Chrb7bhaWzAJsB
   AjPBbOejEnVYvmpDraecpkHHN2jZ8n0MtnHS8oA3v4kS0eO2l/UQN+l3U
   Q==;
X-CSE-ConnectionGUID: To4exRfMRqmxqUpSy1/TlQ==
X-CSE-MsgGUID: XYzrsNQSQKaF/g7VqlpUrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28531383"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28531383"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 04:39:23 -0700
X-CSE-ConnectionGUID: tN5mlECVTQmS+sJTalLTpQ==
X-CSE-MsgGUID: YDePhtYnSZm+oHqcHR2U1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="78130060"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 17 Oct 2024 04:39:19 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1Oqb-000MFr-09;
	Thu, 17 Oct 2024 11:39:17 +0000
Date: Thu, 17 Oct 2024 19:38:23 +0800
From: kernel test robot <lkp@intel.com>
To: Josef Zoller <josef@walterzollerpiano.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Josef Zoller <josef@walterzollerpiano.com>
Subject: Re: [PATCH 1/3] rust: char_dev: add character device abstraction
Message-ID: <202410171902.1Oyg06At-lkp@intel.com>
References: <20241011-rust-char-dev-v1-1-350225ae228b@walterzollerpiano.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011-rust-char-dev-v1-1-350225ae228b@walterzollerpiano.com>

Hi Josef,

kernel test robot noticed the following build errors:

[auto build test ERROR on ce1c54fdff7c4556b08f5b875a331d8952e8b6b7]

url:    https://github.com/intel-lab-lkp/linux/commits/Josef-Zoller/rust-char_dev-add-character-device-abstraction/20241012-030853
base:   ce1c54fdff7c4556b08f5b875a331d8952e8b6b7
patch link:    https://lore.kernel.org/r/20241011-rust-char-dev-v1-1-350225ae228b%40walterzollerpiano.com
patch subject: [PATCH 1/3] rust: char_dev: add character device abstraction
config: x86_64-randconfig-016-20241017 (https://download.01.org/0day-ci/archive/20241017/202410171902.1Oyg06At-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241017/202410171902.1Oyg06At-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410171902.1Oyg06At-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0658]: associated type bounds are unstable
   --> rust/kernel/char_dev.rs:140:42
   |
   140 |     type OpenPtr: for<'a> ForeignOwnable<Borrowed<'a>: Deref<Target: OpenCharDevice>>;
   |                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   |
   = note: see issue #52662 <https://github.com/rust-lang/rust/issues/52662> for more information
   = help: add `#![feature(associated_type_bounds)]` to the crate attributes to enable
   = note: this compiler was built on 2024-04-29; consider upgrading it if it is out of date
--
>> error[E0658]: associated type bounds are unstable
   --> rust/kernel/char_dev.rs:140:62
   |
   140 |     type OpenPtr: for<'a> ForeignOwnable<Borrowed<'a>: Deref<Target: OpenCharDevice>>;
   |                                                              ^^^^^^^^^^^^^^^^^^^^^^
   |
   = note: see issue #52662 <https://github.com/rust-lang/rust/issues/52662> for more information
   = help: add `#![feature(associated_type_bounds)]` to the crate attributes to enable
   = note: this compiler was built on 2024-04-29; consider upgrading it if it is out of date

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

