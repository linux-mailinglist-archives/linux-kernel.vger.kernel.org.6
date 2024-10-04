Return-Path: <linux-kernel+bounces-350944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ADE990B65
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2DAA1C2299A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1511F1D967C;
	Fri,  4 Oct 2024 18:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kIUlbU6+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CD31D9672
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 18:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065977; cv=none; b=hLotI/fKfRbgj592yMm24MOpOU9eMwodcQAtR+LAZeY/HfbaHKO3rkW6s+lLTDnvvsIS7EsA1oV7BVh3rq0thrP2j3Q3YqTsMIxt/uZ+5y2dbWuZjriScvHpdzlJeOmmEQQwlRf7AK4nvdBpH8HtuaGCaslaqhDLohOWydHYAGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065977; c=relaxed/simple;
	bh=XrVZxWQZ+e3/LNrgbAFkiSgxRDsOKeEBt7/+ZHbn3bc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JpLMlKs9QHqBoyni97RpxmnljuP0wnN/n9950PvTLt3L6mTlanVrR8EVaezEPUgiCPDzR9va5W1teFSgdHGPdKomqpcj5S1QZbYg046xSI1SfTVmW38fupu8EERIviKUw0UfCER1cWATNx/HAPntPcAmDQXDOjzA3/dJfL8H8Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kIUlbU6+; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728065976; x=1759601976;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XrVZxWQZ+e3/LNrgbAFkiSgxRDsOKeEBt7/+ZHbn3bc=;
  b=kIUlbU6+RxwC7Dzs0F5J9Q1FpYTAR2XXJyncUh2RU36Kv8bf9sItjOg0
   q+zX2+7xki97cqUUOWx+XTfbGW8Cs2vYIhlUfS4LxTdclolboyz23EZPu
   AaHXMQ1CJ8dzXIdHSfdN3XmW1UpKIfjzVqVzlngGf3CvpqzvGgvFjSS3F
   HlJPNJsalXJepH68whkrHFK1obNhpYQK393C1ybqaeyo25fN/YaLM8Qgq
   DX5NVuybNWlDhgkY/joARukYEt6zRs4BXXQ6WGGxzU+m4kB4DZTYTddvS
   +nNWAyYiNBscoBnrZJNOTB3xZ8hDsmCCQu6jAhDN29O1yZ+uZ+aEEleSN
   Q==;
X-CSE-ConnectionGUID: Akjj6WO1Sk6LQsDG5ft45w==
X-CSE-MsgGUID: aE9AQ5IwQouJB1f2XyqMQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="37903191"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="37903191"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 11:19:35 -0700
X-CSE-ConnectionGUID: VICI/CSIRIGHqXkSpxcozw==
X-CSE-MsgGUID: w5ersl13SWKV1Tvi/qTcyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="74900806"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 04 Oct 2024 11:19:34 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swmtn-00023k-2W;
	Fri, 04 Oct 2024 18:19:31 +0000
Date: Sat, 5 Oct 2024 02:18:44 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20241003 14/14]
 kernel/bpf/core.c:2505:22: warning: comparison of distinct pointer types
 ('struct bpf_prog_array *' and 'struct bpf_prog_array_hdr *')
Message-ID: <202410050215.8zVNACRw-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20241003
head:   ec64acf2dce7577a42c01241e78b24afebc26e96
commit: ec64acf2dce7577a42c01241e78b24afebc26e96 [14/14] treewide_some: fix multiple -Wfamnae warnings that must be audited separately
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241005/202410050215.8zVNACRw-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241005/202410050215.8zVNACRw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410050215.8zVNACRw-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/core.c:2505:22: warning: comparison of distinct pointer types ('struct bpf_prog_array *' and 'struct bpf_prog_array_hdr *') [-Wcompare-distinct-pointer-types]
    2505 |         if (!progs || progs == &bpf_empty_prog_array.hdr)
         |                       ~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +2505 kernel/bpf/core.c

8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2502  
8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2503  void bpf_prog_array_free_sleepable(struct bpf_prog_array *progs)
8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2504  {
8c7dcb84e3b744 Delyan Kratunov 2022-06-14 @2505  	if (!progs || progs == &bpf_empty_prog_array.hdr)
8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2506  		return;
8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2507  	call_rcu_tasks_trace(&progs->rcu, __bpf_prog_array_free_sleepable_cb);
8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2508  }
8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2509  

:::::: The code at line 2505 was first introduced by commit
:::::: 8c7dcb84e3b744b2b70baa7a44a9b1881c33a9c9 bpf: implement sleepable uprobes by chaining gps

:::::: TO: Delyan Kratunov <delyank@fb.com>
:::::: CC: Alexei Starovoitov <ast@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

