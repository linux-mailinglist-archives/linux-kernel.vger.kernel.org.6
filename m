Return-Path: <linux-kernel+bounces-443256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E357C9EE952
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4776284CFE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C52F215764;
	Thu, 12 Dec 2024 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jt5lMQHU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D6E20E716;
	Thu, 12 Dec 2024 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014850; cv=none; b=lzFlOrMSb5EvCu5ZXwPqSdUTQQDtxkshXA4m1ynCzymlX/4XXU7ohImS9/hPafBmcFGzezCKYzE995Ub4//AP7vOIWPFIB0RCndcXPumIQLJQSF/pTPsjqHE24y4EZZyIoSQVmE5aKLolt53Ebts8foarxvM+7Fn8O9VPc8JD7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014850; c=relaxed/simple;
	bh=+zs4fhABxYe5hRUYmT61bMrTFSgId4rbEFnfYJc7Swo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dRgRtggPuWItjh/zyLHHd+UHIJrUl1/8R4P3KKIaZODApVa7L8x5G57XBvXfkhABY7aytDShwi+bZDbjX06O//9AW2IUFIyYVxWn9Ps3qM3IgFwY5CXoQIjexYrE8vOQ4WAkb2Ach7o9IzoF167EUl7VtaZhB1KhjLgeu7jfQVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jt5lMQHU; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734014849; x=1765550849;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=+zs4fhABxYe5hRUYmT61bMrTFSgId4rbEFnfYJc7Swo=;
  b=jt5lMQHUImCwxhfjQ455JFbUeG9VayQjqrmoPVmYzz2mYHV1ZvuH/mDs
   mAJt0WXJfk3FIPoijYrhU/g6VrALCTnYBs7wJJlOUr1/xefxcumKb8/pP
   YxAJj6asxX7x9QF5OVDnasK2bYj68i2WmZQ8gh8vFazQ1nnWCsjraJ0Hj
   F/jqLudsFjv3S9iwVpYCPyiXj1jHpznejFLKghjlwOhb4t4r1Nxgy5ZLE
   AmyH8goFc9b5udCtp4og5ISNqpohJhgB2vMcd55sE7kgL4BBLYdBu7ZMd
   QzpA04QEwBcRyIbIjlLOp25Bfb/3L/I1rOWNwxGMscw7vSMAWnlzNNGHi
   Q==;
X-CSE-ConnectionGUID: l72Rf87qTQWEXWSsxh6I1g==
X-CSE-MsgGUID: 6DaouwIbSoCH5ADgXEvxpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="51961694"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="51961694"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 06:47:28 -0800
X-CSE-ConnectionGUID: 6/o/JdPER5WYmHAloDahNg==
X-CSE-MsgGUID: YTHMn645T6qa9taktOrqGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="127052030"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.137])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 06:47:24 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Stuart Hayes <stuart.w.hayes@gmail.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 "David E. Box" <david.e.box@linux.intel.com>, 
 Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>, 
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241202-sysfs-const-bin_attr-pdx86-v1-0-9ab204c2a814@weissschuh.net>
References: <20241202-sysfs-const-bin_attr-pdx86-v1-0-9ab204c2a814@weissschuh.net>
Subject: Re: [PATCH 0/5] platform/x86: Constify 'struct bin_attribute'
Message-Id: <173401483637.7675.4916640925263412084.b4-ty@linux.intel.com>
Date: Thu, 12 Dec 2024 16:47:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Mon, 02 Dec 2024 20:38:31 +0100, Thomas Weißschuh wrote:

> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> The usage of read_new/write_new/bin_attrs_new is a transition mechanism
> and will be removed after the tree-wide transition to
> const struct bin_attribute.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/5] platform/x86: dell: dcdbas: Constify 'struct bin_attribute'
      commit: f05a99b0d5f16bb82d91f602ade9a2f199c5abde
[2/5] platform/x86: dell_rbu: Constify 'struct bin_attribute'
      commit: e7bcc60c87369c22dfd5e3f13c0aac58a7a3e1d9
[3/5] platform/x86/intel/sdsi: Constify 'struct bin_attribute'
      commit: b5a3e35615948ab5faf773d4e5a0206020403538
[4/5] platform/x86/intel/pmt: Constify 'struct bin_attribute'
      commit: 75e76075f2df25ed4e726b722aeb3ed1afd4b12a
[5/5] platform/x86/amd/hsmp: Constify 'struct bin_attribute'
      commit: 2c62a6ed6fe5e084d3ef47d07087088c2e718290

--
 i.


