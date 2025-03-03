Return-Path: <linux-kernel+bounces-541731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9932BA4C0EB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA497172B00
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4876321146C;
	Mon,  3 Mar 2025 12:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fNAA+wUv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F7C20F09F;
	Mon,  3 Mar 2025 12:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741006020; cv=none; b=ERlBBaydM9zUWlYVTKQXBpITP9AVxeM4oKatIUl9lVpfzkhQF5KCJMlSjWcrTD6fPEux0Wa5Lr3aMyI7wJqp/aMpQ6hKFO1U/PH8gIJER23rn78FeR6YD4fGL+arsbmFHrO8nMwtZN7MtsqnROL00c4tp8MSIQ4BPRQwTYTQV1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741006020; c=relaxed/simple;
	bh=0qludJOfcE14GoAIem005xbhxqzGG+FTiqdROwQN3BM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Jzvx06l1OKphS9V9lO1rsExrLdF2ti4VbKZAKn2x2bKWfgmTUFrXmiqVg2i4HME3Fta7Z2N/BVwkk/pKLAApU6FIBIUazgZxp9C+e8S1oX44B57MPBdYzywYe18K7I4Fw1JtAKXlmdcb+gLvl9ifrYcYfDgxrCGa/5pcGUdM69Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fNAA+wUv; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741006020; x=1772542020;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=0qludJOfcE14GoAIem005xbhxqzGG+FTiqdROwQN3BM=;
  b=fNAA+wUvfoIxXATdquivs0nGpurQxiGjNazAMZV4I5ZCqIsleCMmfd4O
   NR/ZCM9+wniY7h92xyg0oMvvKBy/GTadPS1UNhkLYhj8k10KGOrAOCqBB
   aZf8VWge/VFHqAXeDsXavJRjfJmrbSJfoWSDn+WH56ecAO2gqpVVRq7vj
   ZcaW5KuLsxloDJXAjuanw0baS5ZPK9xBPXp/5/8Td0+SCFjoxJv6jjEnA
   6Z0JNTcDdJbpYmh/7G+xbQ6+W2DdIYAp7h2BUbyRgSZEHPvRn57oh9UMO
   fExzR7yRbAzJPmPZ9r3sMbcVRE7KbQW8ev2QzvWVvqnkNNHtz+yPCMMsV
   A==;
X-CSE-ConnectionGUID: OskG2H6QT/+x9zt5hvn5kg==
X-CSE-MsgGUID: 90l+vabwQHqQGRkreHiiuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="52855671"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="52855671"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 04:46:59 -0800
X-CSE-ConnectionGUID: KrBcVbT4QiiUFiYfHKifQA==
X-CSE-MsgGUID: YwnYZf91TJSzbsb5SRL8hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="148809753"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.14])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 04:46:56 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 ibm-acpi-devel@lists.sourceforge.net, Mingcong Bai <jeffbai@aosc.io>
Cc: Kexy Biscuit <kexybiscuit@aosc.io>, Fan Yang <804284660@qq.com>, 
 Xi Ruoyao <xry111@xry111.site>, 
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
 Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250221164825.77315-1-jeffbai@aosc.io>
References: <20250221164825.77315-1-jeffbai@aosc.io>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Add battery quirk for
 ThinkPad X131e
Message-Id: <174100601148.2518.13620286604796793066.b4-ty@linux.intel.com>
Date: Mon, 03 Mar 2025 14:46:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Sat, 22 Feb 2025 00:48:24 +0800, Mingcong Bai wrote:

> Based on the dmesg messages from the original reporter:
> 
> [    4.964073] ACPI: \_SB_.PCI0.LPCB.EC__.HKEY: BCTG evaluated but flagged as error
> [    4.964083] thinkpad_acpi: Error probing battery 2
> 
> Lenovo ThinkPad X131e also needs this battery quirk.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: thinkpad_acpi: Add battery quirk for ThinkPad X131e
      commit: d0d10eaedcb53740883d7e5d53c5e15c879b48fb

--
 i.


