Return-Path: <linux-kernel+bounces-345622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB8698B841
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 541F0B22971
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D68419D8B2;
	Tue,  1 Oct 2024 09:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aiftIwu6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456ABB67D;
	Tue,  1 Oct 2024 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727774778; cv=none; b=edHoaPTEfbKqpxqOJtnb0ncYcGNh32874lqDDrg85wGDWu8lrRF3jHfdQA/7nDWJRyBd7Qyo46GmlhSpNr9zwqPouisZgEF17Nx6jQOoo/KkZ/32nj8HXxrrtxmyVRksP2znX/q4mVDS30Ee3eUgG2XMFmX5apPSrjVrjpQXmsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727774778; c=relaxed/simple;
	bh=/zTxW2Q4rdr/1ja5lFCscVDf0DCutjtKqBZkiH6uLoc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QQhTa4Yzm9pB2QJCF7yqsRueKcskmas/Aehfg1BeJLdEwA1a+APw9swHNa4xoRMxH53QXUOHolF6RKL+Dk5s1+jZBzc1bbzi/cBTBisyfq6+HhGzegd/KpexMy+jPWII7Vb0q0aiJuvL/OwjlW46Q5Tx6o5ococEURKvc62WSdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aiftIwu6; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727774776; x=1759310776;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=/zTxW2Q4rdr/1ja5lFCscVDf0DCutjtKqBZkiH6uLoc=;
  b=aiftIwu6wJyksF/ovdqFztgPWuuys22S1rF36uIcjBoB2FynhtBmk/xk
   2jF/eEmfY2OABFqea/Rz9XXu2ljNGysStqTvYEpytRl717HR90t9p3Ucl
   R7ICBOahdrWWf+tzTYqf7L1Vk+aMfKacRfQlLrIbuzsYud/1afrW4WRly
   qPfNF8GqorTPH5f0lvfp34apGKEkKNjZPYzFMqBTmCWdoXR6XsDypjheT
   mbTQTqGfTNqtPMzzDc3/1SyvrfZ0/ERjELVYlaM+c/8EjoU2RqnOSUz5Q
   qDIE0L6ONKbUddoudzzMZQBunUYOkrq7L1MjqXO/PFuTXjJa60fN5g3/e
   g==;
X-CSE-ConnectionGUID: Qf/O3iUoS9qDXKq+swP8UA==
X-CSE-MsgGUID: olIHPeqGSQ6G44wv8GLnYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="30781568"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="30781568"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 02:26:15 -0700
X-CSE-ConnectionGUID: 76G6BrhES1ChPPJWS/k47A==
X-CSE-MsgGUID: K4Tt8maWQkG40hKqSfKtgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="104390946"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 02:26:08 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Cc: Asahi Lina <lina@asahilina.net>, Danilo Krummrich <dakr@kernel.org>,
 mcanal@igalia.com, airlied@redhat.com, zhiw@nvidia.com, cjia@nvidia.com,
 jhubbard@nvidia.com, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun
 Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@redhat.com>, Mika
 Westerberg <mika.westerberg@linux.intel.com>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [WIP RFC v2 01/35] WIP: rust/drm: Add fourcc bindings
In-Reply-To: <20240930233257.1189730-2-lyude@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240930233257.1189730-1-lyude@redhat.com>
 <20240930233257.1189730-2-lyude@redhat.com>
Date: Tue, 01 Oct 2024 12:25:54 +0300
Message-ID: <87wmisuqcd.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 30 Sep 2024, Lyude Paul <lyude@redhat.com> wrote:
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index b2e05f8c2ee7d..04898f70ef1b8 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -9,6 +9,7 @@
>  #include <drm/drm_device.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_file.h>
> +#include <drm/drm_fourcc.h>
>  #include <drm/drm_gem.h>
>  #include <drm/drm_gem_shmem_helper.h>
>  #include <drm/drm_ioctl.h>

Unrelated to the patch, sorry, but... what's the idea with putting all
the bindings in the same file? Does it mean every time any of the files
or their dependencies get changed, *all* the rust bindings get
regenerated? Should there be more granularity?

BR,
Jani.

-- 
Jani Nikula, Intel

