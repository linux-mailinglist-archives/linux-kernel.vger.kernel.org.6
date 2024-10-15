Return-Path: <linux-kernel+bounces-366940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A3D99FC79
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9606EB21C79
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D381D63FE;
	Tue, 15 Oct 2024 23:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XZk+Oo+/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7F41D2B34
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034949; cv=none; b=Z+99Dq1JRh6QzIbyr3FeqnKZ4kt+QHpzCkjyudunQ8PFILrYwhlW0vUu7B3jhZVL9mlbp1Vap1C0rWFpyLfleZCB6Ycv9WtUKAbXJf9WmW4OK5ZgyFW2w9BTaKwDNcfkuH226ZlkHeOL3Xiq9IHUD/duLfVLVocCDuxUbEEUXxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034949; c=relaxed/simple;
	bh=oh6/s/+JCpbzRz14BY0hEXJT1wEU6TbgEQaQA6kvSmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gh+/gp/wqQ/IgdsM/b9kla8J4uf+oYqvOmrSNjQIf+ZUb+RpdQNdrGwzOF3QTYMEbRAzGGTN8KJyTe6QTuEF3hxMdK0gEpZIWjeuZE8TU0GpCcgv3I8uhByZiUg3dfhxfz2NUsqzNRTu8enQBlbGdSWaFltF3aFBBDtlxfoq3Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XZk+Oo+/; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729034948; x=1760570948;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oh6/s/+JCpbzRz14BY0hEXJT1wEU6TbgEQaQA6kvSmg=;
  b=XZk+Oo+/If9xmRZ0vMLBZ/3tTg9pWBcdky4cwRtD/dyK1GCory3bXu6w
   HvZlUNZZf8/64yTptoDyLbpHTINv1gIl9SD0DKy2JVGefAlt8I4A7fMyg
   AKQAd+edkf4BeXU21Ztot28ocNrmRAWyLyhoxGSt6itIv22VKwSgjyHns
   lMwknL6/Uks/XME0lfy0Am9rzOwj57fknd7i6vo4PCQRzbr+UIrEfUemT
   jvruvsJPyx7z4JJ3ZWF4nBr/dmssNCFB7YKlNpYn0C5zWtr7cTYNTx+IO
   ggHwm/U8fhMHHF+KaRrK1BDFLmNgBxJgnsF1l0FCzbYyoCC4KF8FEoR2/
   w==;
X-CSE-ConnectionGUID: 2PxwPuazRGylD8vhqDW8aQ==
X-CSE-MsgGUID: Y7SjzXDDR2e+0MRLmL8EAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39011700"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39011700"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 16:29:07 -0700
X-CSE-ConnectionGUID: +UE3xrSUS3K+WIYPdlTSKQ==
X-CSE-MsgGUID: 9f14yDEMQReNMiuKFFfkIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="115491165"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 16:29:05 -0700
Date: Tue, 15 Oct 2024 16:29:04 -0700
From: Tony Luck <tony.luck@intel.com>
To: James Morse <james.morse@arm.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH v5 06/40] x86/resctrl: Remove data_width and the tabular
 format
Message-ID: <Zw76wLvdGax2eSiP@agluck-desk3.sc.intel.com>
References: <20241004180347.19985-1-james.morse@arm.com>
 <20241004180347.19985-7-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004180347.19985-7-james.morse@arm.com>

On Fri, Oct 04, 2024 at 06:03:13PM +0000, James Morse wrote:
> The resctrl architecture code provides a data_width for the controls of
> each resource. This is used to zero pad all control values in the schemata
> file so they appear in columns. The same is done with the resource names
> to complete the visual effect. e.g.
> | SMBA:0=2048
> |   L3:0=00ff
> 
> AMD platforms discover their maximum bandwidth for the MB resource from
> firmware, but hard-code the data_width to 4. If the maximum bandwidth
> requires more digits - the tabular format is silently broken.
> If new schema are added resctrl will need to be able to determine the
> maximum width. The benefit of this pretty-printing is questionable.

Agreed. It's particularly non-useful for L2 resources on systems with
hundred+ cores. The L2 line in schemata is very long and doesn't look
"pretty" at all. Padding may make it even longer.

It never worked with the mba_MBps mount option because the field
width wasn't updated for prettiness. E.g.

$ cat schemata
MB:0=4294967295;1=4294967295
L3:0=fff;1=fff

> Instead of handling runtime discovery of the data_width for AMD platforms,
> remove the feature. These fields are always zero padded so should be
> harmless to remove if the whole field has been treated as a number.
> In the above example, this would now look like this:

Huzzah!

Reviewed-by: Tony Luck <tony.luck@intel.com>

-Tony

