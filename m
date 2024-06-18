Return-Path: <linux-kernel+bounces-220191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 647E890DDE8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0541C1F24AA4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6381741FE;
	Tue, 18 Jun 2024 21:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ERsVAp+o"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FD815E5CA
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 21:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718744546; cv=none; b=Qy6sgCRsFYRFMTizV57OiYHNcw3lAEhS+qMNrvhivxfh1M02ywBA9DNCJerMRf7ul+uuuxZjVgszHw5Vz7xYkJbvXZu/Zqydz4OVv+0w76/wfE4va8v+Rjgfq1ksF1S6+hwum/B1+qqa66+8orn3V8Ja30KJWIqRxpE4WgwHWq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718744546; c=relaxed/simple;
	bh=ZtlWpZazkZMr9hjqcT0x7ELefnO6avTkg5CabtOR7jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=In58l/nkH/QPQpwUuYszGV9awM4l49cCgS9HCBYTQipAI7WiPBPQqx1p17X5rNsLacK5bCJKZHg6mCJc77Z286mpi0ndeTQwlrBO4E6EEJ5R5sQ1MTg4ZvC6Gow0aYRn7Kv49ylZ0usyBjeOJlipX36U/oXae9mbSC7mJjOMUMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ERsVAp+o; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718744545; x=1750280545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZtlWpZazkZMr9hjqcT0x7ELefnO6avTkg5CabtOR7jo=;
  b=ERsVAp+o8h7vhcfNej+RfKaCtpSe2Eh3qlTX4kazs8wTlyiTW8lN/1Nv
   cF9tSoRfG8Fn3QGHCppKiYEdk0EC9j9XmV4jTVZyMcNU4BJIghdaJ2USE
   pwRYZYNq+YeFYMuU9O5punaLAQHj0qNfFOr3g5t0vJ3mp9XLZMlpzYzBA
   I6N8GjD0Gh++DzAvEAOPc/ZNX2SnD6QwGqP6/2ANVUUBHjLJKt5sS1BJ5
   NpQA0lmXo2wO62L9RC4RVUVz5klH4STP1wNfqlJeCrwnZkpl7p8cXaPJ6
   prCWQs9ZhLAsLAD9UPBHLC6w/a3BEEav57YQrE5ja4GqKo7S7OLqziUx3
   A==;
X-CSE-ConnectionGUID: 9FX3tB66RVG+fGr2La7ttA==
X-CSE-MsgGUID: UbVKeY+jSt+pnOkrWEOuIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="41061977"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41061977"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 14:02:24 -0700
X-CSE-ConnectionGUID: +GH3mnq+RBOf6kxw23WGQQ==
X-CSE-MsgGUID: oyGdrqUoRKKa7VmngOHzwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="42394361"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 18 Jun 2024 14:02:22 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJfy7-0005uQ-0t;
	Tue, 18 Jun 2024 21:02:19 +0000
Date: Wed, 19 Jun 2024 05:02:13 +0800
From: kernel test robot <lkp@intel.com>
To: Douglas Anderson <dianders@chromium.org>,
	Daniel Thompson <daniel.thompson@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, kgdb-bugreport@lists.sourceforge.net,
	Douglas Anderson <dianders@chromium.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jason Wessel <jason.wessel@windriver.com>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] kdb: Abstract out parsing for mdWcN
Message-ID: <202406190433.U3alc3Xi-lkp@intel.com>
References: <20240617173426.11.I899d035485269f5110a3323fbb1680fbba718e4c@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617173426.11.I899d035485269f5110a3323fbb1680fbba718e4c@changeid>

Hi Douglas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.10-rc4]
[also build test WARNING on linus/master next-20240618]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Douglas-Anderson/kdb-Get-rid-of-minlen-for-the-md-command/20240618-084245
base:   v6.10-rc4
patch link:    https://lore.kernel.org/r/20240617173426.11.I899d035485269f5110a3323fbb1680fbba718e4c%40changeid
patch subject: [PATCH 11/13] kdb: Abstract out parsing for mdWcN
config: arc-randconfig-001-20240619 (https://download.01.org/0day-ci/archive/20240619/202406190433.U3alc3Xi-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240619/202406190433.U3alc3Xi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406190433.U3alc3Xi-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/debug/kdb/kdb_main.c:1606: warning: Function parameter or struct member 'bytesperword' not described in 'kdb_md_parse_arg0'


vim +1606 kernel/debug/kdb/kdb_main.c

  1593	
  1594	/**
  1595	 * kdb_md_parse_arg0() - Parse argv[0] for "md" command
  1596	 *
  1597	 * @cmd:         The name of the command, like "md"
  1598	 * @arg0:        The value of argv[0].
  1599	 * @repeat:      If argv0 modifies repeat count we'll adjust here.
  1600	 * @bytesperword Ifargv0 modifies bytesperword we'll adjust here.
  1601	 *
  1602	 * Return: true if this was a valid cmd; false otherwise.
  1603	 */
  1604	static bool kdb_md_parse_arg0(const char *cmd, const char *arg0,
  1605				      int *repeat, int *bytesperword)
> 1606	{
  1607		int cmdlen = strlen(cmd);
  1608	
  1609		/* arg0 must _start_ with the command string or it's a no-go. */
  1610		if (strncmp(cmd, arg0, cmdlen) != 0)
  1611			return false;
  1612	
  1613		/* If it's just the base command, we're done and it's good. */
  1614		if (arg0[cmdlen] == '\0')
  1615			return true;
  1616	
  1617		/*
  1618		 * The first byte after the base command must be bytes per word, a
  1619		 * digit. The actual value of bytesperword will be validated later.
  1620		 */
  1621		if (!isdigit(arg0[cmdlen]))
  1622			return false;
  1623		*bytesperword = (int)(arg0[cmdlen] - '0');
  1624		cmdlen++;
  1625	
  1626		/* After the bytes per word must be end of string or a 'c'. */
  1627		if (arg0[cmdlen] == '\0')
  1628			return true;
  1629		if (arg0[cmdlen] != 'c')
  1630			return false;
  1631		cmdlen++;
  1632	
  1633		/* After the "c" is the repeat. */
  1634		return kstrtouint(arg0 + cmdlen, 10, repeat) == 0;
  1635	}
  1636	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

