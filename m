Return-Path: <linux-kernel+bounces-215048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23674908DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FFEF1C21123
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F57310979;
	Fri, 14 Jun 2024 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nxFx4Xx9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310182107
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718376339; cv=none; b=NGI9iVHLXdJCIglCH9/CWQUK7n0czRCm2Gsx02AIW35+hgZ1ZzAh+eeseXuzbMGBhKA99IhjsYtGqIQn4gRyRlwwYCpAu67+W7cAsg1ilOIFCd45uL2HtRoiIc32aXcudM97t8JZRNkk1Uoy9x0LW3TctgxSmbKD8m4yBN/kfnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718376339; c=relaxed/simple;
	bh=tOMEMKP3YAb0IwVhlwIcqUkQ0Y2efmjm8SNUhhUG0T4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J+cml4GoO6Sf27iWVob400dkidiGIiNTBjljSN67iK+WAf97QcDBZT9TzvotAvrZ0CUF2+o16UPehfKK3dBRQPLTZiqBtCkAL9uO/wTqIKljWdL0VA8t89s5SeYjjNgzHEJOF5jbLtwfRdF8RKc3sXNN/xpxFYvKgr3rF8Z3c5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nxFx4Xx9; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718376338; x=1749912338;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=tOMEMKP3YAb0IwVhlwIcqUkQ0Y2efmjm8SNUhhUG0T4=;
  b=nxFx4Xx955gEXrpEU49t++Za4TXmGishYlPP+9lb8ACpxWa/oT8pWAUf
   Ml9BEXJaOwaRPblZGup1OUoVpvkJtHs+ZyAjyqH7jQLfTC7prQ3//iuyX
   jfNwzeLpg+wxiLFvmaUJ3zxjX43qedZqunCyqeayZObbMG2QY5gUkP3GT
   HVGzQNDh4wTE08M1yg/MYJhN0OB5K67S4rYIaG/UaMQWjQJUwF0Azs942
   r7Z4tGlK0pZxX9iPWG+94Abk/y+iBtKOvnJRf5Pc2AVAhRCfhKDUxwlXy
   LktnD7nKFs0vQq/a6980/FNd0FWtkb2kleJk8ijbkYGITSpRBfota7mkC
   Q==;
X-CSE-ConnectionGUID: s+/12Ql3Q4aDcHxpKgdUbQ==
X-CSE-MsgGUID: R+Jle5jMQneCib0pqFdd1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="15389986"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="15389986"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 07:45:38 -0700
X-CSE-ConnectionGUID: Rlxw343pRhedGyMyue1lYQ==
X-CSE-MsgGUID: XWMDZ4yQRcSuekhmgcgEHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="45636124"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by orviesa004.jf.intel.com with ESMTP; 14 Jun 2024 07:45:38 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id 365123057C6; Fri, 14 Jun 2024 07:45:37 -0700 (PDT)
From: Andi Kleen <ak@linux.intel.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org,  hannes@cmpxchg.org,  shakeel.butt@linux.dev,
  david@redhat.com,  ying.huang@intel.com,  hughd@google.com,
  willy@infradead.org,  yosryahmed@google.com,  nphamcs@gmail.com,
  chengming.zhou@linux.dev,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  kernel-team@meta.com
Subject: Re: [PATCH v5 1/2] mm: store zero pages to be swapped out in a bitmap
In-Reply-To: <20240614100902.3469724-2-usamaarif642@gmail.com> (Usama Arif's
	message of "Fri, 14 Jun 2024 11:07:05 +0100")
References: <20240614100902.3469724-1-usamaarif642@gmail.com>
	<20240614100902.3469724-2-usamaarif642@gmail.com>
Date: Fri, 14 Jun 2024 07:45:37 -0700
Message-ID: <87ed8zmvla.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usama Arif <usamaarif642@gmail.com> writes:

> Approximately 10-20% of pages to be swapped out are zero pages [1].
> Rather than reading/writing these pages to flash resulting
> in increased I/O and flash wear, a bitmap can be used to mark these
> pages as zero at write time, and the pages can be filled at
> read time if the bit corresponding to the page is set.
> With this patch, NVMe writes in Meta server fleet decreased
> by almost 10% with conventional swap setup (zswap disabled).
>
> [1] https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03d1344dde9fce0@epcms5p1/

But how much did the CPU time increase? Surely the new loop is not free?

-Andi

