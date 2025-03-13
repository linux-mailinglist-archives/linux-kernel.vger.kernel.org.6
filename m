Return-Path: <linux-kernel+bounces-559260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD79BA5F182
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57841895872
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02BC2686B3;
	Thu, 13 Mar 2025 10:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TnmNYBQE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADD1268FD9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862914; cv=none; b=mMIP1WMi6+qOZdfQrSl3Sl0kTP79Qd6O6hAA8ehbN1f6mSGrJq/ldVglijPx9GwZMAfMu4Xqbfg4Bx1JBqM7VmO9snctm8Hr15HLDXeGJkwlks59k/9STv/7A4Mmr/ZnKV9hiHwAJ4Pei+YWkwIcfQMqsMRxoP58XOY6VzNYTxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862914; c=relaxed/simple;
	bh=Jmvl8EX5DkvtuZEU3inPTKIXywN5zwJZsdjqePPph9Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BGbpkFnGRgDuQ5wRdYtie30bm6v4Urp3/42jWDOqMQozd7u/u3R5JZj686Ly5H/Go8iTK5eo+hd9W4VV81dMeGFQztpJ+DmXmzbjEd6MIGF9Vx2G0gWqe4bk7CEpofeY8Yl2HFBSAG+QVgUAkPf+eqWFqPjPpzagDQxG3oGE3+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TnmNYBQE; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741862912; x=1773398912;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Jmvl8EX5DkvtuZEU3inPTKIXywN5zwJZsdjqePPph9Y=;
  b=TnmNYBQEYpJhHrt0/cO/naMXeEdhJYF6zVCZm7bpSsiF7sjALC4cpGvw
   kcJ6ayBqjwq9gkfPCdeVBJDcsM45Ce/CaxjsT8V57asDvpXxS/UvMkojh
   JVNzzs7p+wtaRVVDV5mf1ejxWI/we3TJCtaxABKTPW378gBLeattzWr1Q
   QikNSFgpHA0fmQtxnLxhPnaBQM9m5HGqRMcrZqYBCEdhtVxUgFPEyoDqd
   NNKHMUx+pt7/LmS8sJmuYFzMwx3Wj9gil5TQ26bwIA1SBEpqjnf2FZE2t
   NqMvofcg+ED4UAVqrGa1bN/R4EYPvZNnyGcpMIeX0u39jhk576At0tqOH
   Q==;
X-CSE-ConnectionGUID: qO9NOpAPQgOUJMHyg2MRrQ==
X-CSE-MsgGUID: BKUYjoCiQz6LUyjbRHHOaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="60514139"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="60514139"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 03:48:31 -0700
X-CSE-ConnectionGUID: FrkTloA9TMO0Zg3K+dXd4A==
X-CSE-MsgGUID: j7wWwXkwSX26abe4bq8WXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="126104435"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.115])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 03:48:27 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: "Yo-Jung (Leo) Lin" <leo.lin@canonical.com>
Cc: leo.lin@canonical.com, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: add .hdrtest to .gitignore under drm directories
In-Reply-To: <20250313041711.872378-1-leo.lin@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250313041711.872378-1-leo.lin@canonical.com>
Date: Thu, 13 Mar 2025 12:48:23 +0200
Message-ID: <878qp9dx54.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 13 Mar 2025, "Yo-Jung (Leo) Lin" <leo.lin@canonical.com> wrote:
> The header self-contained tests in drm may leave .hdrtest files in
> include/drm/ and drivers/gpu/drm/. Omit them by adding .gitignore

This has already been the case with usr/include for
CONFIG_UAPI_HEADER_TEST=y but I guess nobody noticed before.

Maybe fix that too?

BR,
Jani.


>
> Signed-off-by: Yo-Jung (Leo) Lin <leo.lin@canonical.com>
> ---
>  drivers/gpu/drm/.gitignore | 1 +
>  include/drm/.gitignore     | 1 +
>  2 files changed, 2 insertions(+)
>  create mode 100644 drivers/gpu/drm/.gitignore
>  create mode 100644 include/drm/.gitignore
>
> diff --git a/drivers/gpu/drm/.gitignore b/drivers/gpu/drm/.gitignore
> new file mode 100644
> index 000000000000..d9a77f3b59b2
> --- /dev/null
> +++ b/drivers/gpu/drm/.gitignore
> @@ -0,0 +1 @@
> +*.hdrtest
> diff --git a/include/drm/.gitignore b/include/drm/.gitignore
> new file mode 100644
> index 000000000000..d9a77f3b59b2
> --- /dev/null
> +++ b/include/drm/.gitignore
> @@ -0,0 +1 @@
> +*.hdrtest

-- 
Jani Nikula, Intel

