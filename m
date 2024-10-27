Return-Path: <linux-kernel+bounces-383473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 741F99B1C3A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 06:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6ED21F2156E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 05:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6BE39FD9;
	Sun, 27 Oct 2024 05:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUQ78tIG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E114217F2C;
	Sun, 27 Oct 2024 05:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730007078; cv=none; b=uQRnjtZQIkGftww35Kb4qbFVPUGoelBOaNBXHXZH2dgGYE35fphlUxBa3okXif4Y9+dmUb6KjyZVyrRJ5D5dL6X3/hSjzG8NUb8sK+iC1R1yHqpuqnW3yupivYSLeEzbXmYhQ1T4n70jgERK0WgDv7WPQjpjvfw2s+4DuxNdVbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730007078; c=relaxed/simple;
	bh=pjW8AVHIzHCGMscn1YH8JH5wxY6uHqnQQGAR2HPmKDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCJYF6sEqTL2BxBpfAUOlz9kX1tZ+K0k+4gsRFMC7hRbk1hraLCC06pc+h/4aJ42/1bY7r1AynH9WGpOu8zfnirO3Be7VyHpSWpSWprXjZr/NcDzocWkiBeiWbuIeplsej+45NR/gEOMUHb6pmQrseO480FndR9vsetzSa8mWvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bUQ78tIG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730007074; x=1761543074;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pjW8AVHIzHCGMscn1YH8JH5wxY6uHqnQQGAR2HPmKDo=;
  b=bUQ78tIGKATu27UZd3/syh3NJqgyQ3+PO2ZjOec/IgdEJ87+IMZEkV5D
   EEzQxeeBN7s4xNhxaxwq7JPXOi0TSP2ZYOi3utqatrtuxk/KncZy4Cy05
   Rf+C2UExSIU04jgdpysrAHG0p5R2D5A4ksu2Tc8qpi4MxV7X4F88821LA
   NtFTmM5aHkT16Z3u2tzWNngK8EGlBeyGSc6ivZJMCC2JcVYwkED0ZIIs+
   Pu/Pr2cyO7fhp4iHovraOGenqrQ8SpfgDOF1zwrHArEmjxrFUU9sd6o4e
   8cZ8BkVl5X0ZRmj3ZYW3ioloSoELYB94njjl8/tdkbb5qwWLzoMMMla8g
   g==;
X-CSE-ConnectionGUID: JVsm5Ut/RS+jHqq4/xf5IQ==
X-CSE-MsgGUID: FVy5wmdIQz2ozMdhNL4aCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11237"; a="29740887"
X-IronPort-AV: E=Sophos;i="6.11,236,1725346800"; 
   d="scan'208";a="29740887"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2024 22:31:14 -0700
X-CSE-ConnectionGUID: fyxYp0mlQR6XN6oG2ZA6gA==
X-CSE-MsgGUID: ueLv2YnHS+OzKx0o3pyQPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,236,1725346800"; 
   d="scan'208";a="81413079"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 26 Oct 2024 22:31:10 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4vro-000aOq-1Z;
	Sun, 27 Oct 2024 05:31:08 +0000
Date: Sun, 27 Oct 2024 13:30:16 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Almeida <daniel.almeida@collabora.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>
Subject: Re: [PATCH] rust: irq: add support for request_irq()
Message-ID: <202410271331.Kh0GAuXf-lkp@intel.com>
References: <20241024-topic-panthor-rs-request_irq-v1-1-7cbc51c182ca@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024-topic-panthor-rs-request_irq-v1-1-7cbc51c182ca@collabora.com>

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on 33c255312660653cf54f8019896b5dca28e3c580]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Almeida/rust-irq-add-support-for-request_irq/20241024-222633
base:   33c255312660653cf54f8019896b5dca28e3c580
patch link:    https://lore.kernel.org/r/20241024-topic-panthor-rs-request_irq-v1-1-7cbc51c182ca%40collabora.com
patch subject: [PATCH] rust: irq: add support for request_irq()
config: riscv-randconfig-001-20241027 (https://download.01.org/0day-ci/archive/20241027/202410271331.Kh0GAuXf-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241027/202410271331.Kh0GAuXf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410271331.Kh0GAuXf-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0432]: unresolved import `kernel::irq::Registration`
   --> rust/doctests_kernel_generated.rs:1837:5
   |
   1837 | use kernel::irq::Registration;
   |     ^^^^^^^^^^^^^^^^^^^^^^^^^ no `Registration` in `irq`
   |
   help: consider importing one of these items instead
   |
   1837 | use kernel::irq::request::Registration;
   |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1837 | use kernel::net::phy::Registration;
   |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
>> error[E0432]: unresolved import `kernel::sync::lock::SpinLock`
   --> rust/doctests_kernel_generated.rs:1839:5
   |
   1839 | use kernel::sync::lock::SpinLock;
   |     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ no `SpinLock` in `sync::lock`
   |
   help: a similar name exists in the module
   |
   1839 | use kernel::sync::lock::spinlock;
   |                         ~~~~~~~~
   help: consider importing this type alias instead
   |
   1839 | use kernel::sync::SpinLock;
   |     ~~~~~~~~~~~~~~~~~~~~~~
--
>> error[E0412]: cannot find type `ThreadedIrqReturn` in module `irq`
   --> rust/doctests_kernel_generated.rs:1955:34
   |
   1955 |     fn handle_irq(&self) -> irq::ThreadedIrqReturn {
   |                                  ^^^^^^^^^^^^^^^^^ not found in `irq`
   |
   help: consider importing this enum
   |
   3    + use kernel::irq::request::ThreadedIrqReturn;
   |
   help: if you import `ThreadedIrqReturn`, refer to it directly
   |
   1955 -     fn handle_irq(&self) -> irq::ThreadedIrqReturn {
   1955 +     fn handle_irq(&self) -> ThreadedIrqReturn {
   |
--
>> error[E0433]: failed to resolve: use of undeclared type `ThreadedIrqReturn`
   --> rust/doctests_kernel_generated.rs:1963:9
   |
   1963 |         ThreadedIrqReturn::WakeThread
   |         ^^^^^^^^^^^^^^^^^ use of undeclared type `ThreadedIrqReturn`
   |
   help: consider importing this enum
   |
   3    + use kernel::irq::request::ThreadedIrqReturn;
   |
--
>> error[E0412]: cannot find type `ThreadedFnReturn` in module `irq`
   --> rust/doctests_kernel_generated.rs:1968:33
   |
   1968 |     fn thread_fn(&self) -> irq::ThreadedFnReturn {
   |                                 ^^^^^^^^^^^^^^^^ not found in `irq`
   |
   help: consider importing this enum
   |
   3    + use kernel::irq::request::ThreadedFnReturn;
   |
   help: if you import `ThreadedFnReturn`, refer to it directly
   |
   1968 -     fn thread_fn(&self) -> irq::ThreadedFnReturn {
   1968 +     fn thread_fn(&self) -> ThreadedFnReturn {
   |
--
>> error[E0412]: cannot find type `Registration` in module `irq`
   --> rust/doctests_kernel_generated.rs:1975:64
   |
   1975 |     fn register_irq(irq: u32, handler: Handler) -> Result<irq::Registration<Handler>> {
   |                                                                ^^^^^^^^^^^^ not found in `irq`
   |
   help: consider importing one of these items
   |
   3    + use kernel::irq::request::Registration;
   |
   3    + use kernel::net::phy::Registration;
   |
   help: if you import `Registration`, refer to it directly
   |
   1975 -     fn register_irq(irq: u32, handler: Handler) -> Result<irq::Registration<Handler>> {
   1975 +     fn register_irq(irq: u32, handler: Handler) -> Result<Registration<Handler>> {
   |
--
>> error[E0433]: failed to resolve: use of undeclared type `ThreadedRegistration`
   --> rust/doctests_kernel_generated.rs:1976:28
   |
   1976 |         let registration = ThreadedRegistration::register(irq, irq::flags::SHARED, "my-device", handler)?;
   |                            ^^^^^^^^^^^^^^^^^^^^ use of undeclared type `ThreadedRegistration`
   |
   help: consider importing this struct
   |
   3    + use kernel::irq::request::ThreadedRegistration;
   |
--
>> error[E0433]: failed to resolve: could not find `flags` in `irq`
   --> rust/doctests_kernel_generated.rs:1976:69
   |
   1976 |         let registration = ThreadedRegistration::register(irq, irq::flags::SHARED, "my-device", handler)?;
   |                                                                     ^^^^^ could not find `flags` in `irq`
   |
   help: consider importing this module
   |
   3    + use kernel::irq::request::flags;
   |
   help: if you import `flags`, refer to it directly
   |
   1976 -         let registration = ThreadedRegistration::register(irq, irq::flags::SHARED, "my-device", handler)?;
   1976 +         let registration = ThreadedRegistration::register(irq, flags::SHARED, "my-device", handler)?;
   |
--
>> error[E0432]: unresolved import `kernel::irq::Registration`
   --> rust/doctests_kernel_generated.rs:1934:5
   |
   1934 | use kernel::irq::Registration;
   |     ^^^^^^^^^^^^^^^^^^^^^^^^^ no `Registration` in `irq`
   |
   help: consider importing one of these items instead
   |
   1934 | use kernel::irq::request::Registration;
   |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1934 | use kernel::net::phy::Registration;
   |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
>> error[E0432]: unresolved import `kernel::sync::lock::SpinLock`
   --> rust/doctests_kernel_generated.rs:1936:5
   |
   1936 | use kernel::sync::lock::SpinLock;
   |     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ no `SpinLock` in `sync::lock`
   |
   help: a similar name exists in the module
   |
   1936 | use kernel::sync::lock::spinlock;
   |                         ~~~~~~~~
   help: consider importing this type alias instead
   |
   1936 | use kernel::sync::SpinLock;
   |     ~~~~~~~~~~~~~~~~~~~~~~
--
>> error[E0405]: cannot find trait `Handler` in module `kernel::irq`
   --> rust/doctests_kernel_generated.rs:1855:19
   |
   1855 | impl kernel::irq::Handler for Handler {
   |                   ^^^^^^^ not found in `kernel::irq`
   |
   help: consider importing this trait
   |
   3    + use kernel::irq::request::Handler;
   |
   help: if you import `Handler`, refer to it directly
   |
   1855 - impl kernel::irq::Handler for Handler {
   1855 + impl Handler for Handler {
   |
..

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

