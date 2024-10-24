Return-Path: <linux-kernel+bounces-379401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E009ADE2F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3191B23073
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 07:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF1819CD16;
	Thu, 24 Oct 2024 07:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QblCnSFm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E77C1AB530
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 07:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729756223; cv=none; b=eumQQoEvUrX6slCngNf2Niw/Jt9KZ6PhfFEV32hcxXQHko+ZV+6K0K2I/y70TJ9DQKX+KeZ3FXZ8mj/ns2PGhGACR/E0GZxQembX+7z3imDtiAtfbGTFdxbxIpU2VPb9zzVDcKnKob32vN5o0E4mrCCuFAVSfG7DrMdaxpljxpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729756223; c=relaxed/simple;
	bh=dtorg9b+UfLM2MFgOG/5B1BrTmLwgsqf53ciwfG1vwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f7fKrlcqSFvUjeyzGAvdiFeoeAdaxdcHaANGPtDUVFL8YGVkTPUTyuf1N5LDM+7DqNavsV8W1mC7mBC6nWoi/8pMfd0m6qrhSKqMgutU80AqnVHJLWVg+k9fNRi/PgRDYWQSHeLwYT5IAllJaBld8U7t14zNVs28XEYfNU6D23I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QblCnSFm; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729756222; x=1761292222;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dtorg9b+UfLM2MFgOG/5B1BrTmLwgsqf53ciwfG1vwk=;
  b=QblCnSFmssxkULAAQnvlJvEJs8OlBOGDDnZJSx0LQFCUj0q+13QqSzsP
   LozvRUKmXEBcbijJQvWlHKLlxOeIaB4mdGS1dmJKxQsGOKe/exk/xmGXm
   6pHEevbHs+lhju1JhBgi6fXBfgruIMg45C8QktF4BGvmMr8/Y2xWc1TVH
   jx/NEO9SfjHQJ2X5tB5Bcjo96tGWeWjqQlLpmtf7qpyjkPMft4vuDRU6k
   MHQBfVb9Orr+uWPacFwooYIYKQAxli745e3pV2GyXjz4iX+mpxc2gkgrG
   pt6CGK49guF4LLDWqgzYia9aGmrkqjtVl8IAQQ7kMFpIqr1HsCaa6rvYf
   A==;
X-CSE-ConnectionGUID: NWzUfnXwRLm5U7fzkYFFKA==
X-CSE-MsgGUID: X3XNzrJkTc2NkMT4JgALGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51914139"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51914139"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 00:50:22 -0700
X-CSE-ConnectionGUID: HrLGc2RsTH+wCJ9ulNuVzg==
X-CSE-MsgGUID: hdZUgsdERUeFI27TI64+qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80171957"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.8.107]) ([10.94.8.107])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 00:50:19 -0700
Message-ID: <a9009cec-ce43-4288-98bf-1b6f216131c3@linux.intel.com>
Date: Thu, 24 Oct 2024 09:50:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] firmware_loader: Fix possible resource leak in
 fw_log_firmware_info()
To: Gaosheng Cui <cuigaosheng1@huawei.com>, mcgrof@kernel.org,
 russ.weight@linux.dev, dakr@redhat.com, gregkh@linuxfoundation.org,
 rafael@kernel.org, cezary.rojewski@intel.com, wangweiyang2@huawei.com
Cc: linux-kernel@vger.kernel.org
References: <20241016110335.3677924-1-cuigaosheng1@huawei.com>
Content-Language: en-US
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20241016110335.3677924-1-cuigaosheng1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/16/2024 1:03 PM, Gaosheng Cui wrote:
> The alg instance should be released under the exception path, otherwise
> there may be resource leak here.
> 
> To mitigate this, free the alg instance with crypto_free_shash when kmalloc
> fails.
> 
> Fixes: 02fe26f25325 ("firmware_loader: Add debug message with checksum for FW file")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---

Makes sense, thanks!

Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

