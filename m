Return-Path: <linux-kernel+bounces-576840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 475F2A71504
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6B3417423B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9981C84C9;
	Wed, 26 Mar 2025 10:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J5BQnGxL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928F41B424A;
	Wed, 26 Mar 2025 10:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742985567; cv=none; b=QFQOYESphpRfrYokrKyqf5m7+3Ghy5Eaj+1JgG3ar0xKUH/JokyY/irJszVnqIE1N2LZLWppkidlXh1ya9jE92dQnK3JCX7/qOeFXvsO7gmaG6Y+kyEZjAKkXMaIB4vuY684gGUj6JtSE4olw6E4xGLtgeeTNS2GjhcoMEix1XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742985567; c=relaxed/simple;
	bh=jzGCBkutBgzfiA+VlgU2fbb9z16gst/HAke89+6OrwA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BuBj82+cE0qcOuvL+zgznFqWPYuPisJ85ljlJJ6sZyV+yZsydeJI8BCZTHJlIFRQ//OdDYKPWilE9SjBuPkTlNQQMWgGGBZTVTXDNO/Q8MUQInN4kv5LNGmGcefaXxgeVxuRWcIZGJtaSS/8aPXTSIw0cGagSalA3wxIUb9AGb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J5BQnGxL; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742985566; x=1774521566;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=jzGCBkutBgzfiA+VlgU2fbb9z16gst/HAke89+6OrwA=;
  b=J5BQnGxLvpZXYXzxcSin+RHftXe9JR8PqMa4cUduh3FGdV1Bo6XeWJQB
   au1XkPJLrYPLtz7QKUorNKM1u4fjtEo8n6cVa0unKGGwuvvo3DcEkwnnY
   BDLp5Gc2c3eIrwAYQzWyKvTcBde6kVO8oboyPlI19Ro55XzlZHWMZXB8a
   KXIOgIZUTgu1R/J+dIO8U7YJ4N/5uHG5T0EOScVNc8f9gAUwW+vutQ9VO
   pdDQn8Rnc0RP87pv7Rsl2sDLHqE7+itPUmfLt5PDex57toRdC/ZMCvt9c
   8t8ETrPU9jLHZaJPftrQVhWIrHV9VeiVw85Eqt7aL1qQEaQ4Y5s6FgM5Y
   A==;
X-CSE-ConnectionGUID: g9ny3ka3SNm450JQR0ZL2A==
X-CSE-MsgGUID: +Hn+qYKwQoyj9NszBVoYeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="44144992"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="44144992"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 03:39:24 -0700
X-CSE-ConnectionGUID: 8tQtKnKxS7yJ/BafNRrroA==
X-CSE-MsgGUID: R2XbqdYXSyS3ofmm/GBCqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="124896092"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.210])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 03:39:18 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Lyude Paul <lyude@redhat.com>, Maxime Ripard <mripard@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, "open
 list:RUST:Keyword:b(?i:rust)b" <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm/edid: Use unsigned int in drm_add_modes_noedid()
In-Reply-To: <20250325212823.669459-2-lyude@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250325212823.669459-1-lyude@redhat.com>
 <20250325212823.669459-2-lyude@redhat.com>
Date: Wed, 26 Mar 2025 12:39:15 +0200
Message-ID: <87wmcc6ppo.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 25 Mar 2025, Lyude Paul <lyude@redhat.com> wrote:
> A negative resolution doesn't really make any sense, no one goes into a TV
> store and says "Hello sir, I would like a negative 4K TV please", that
> would make everyone look at you funny.

That is largely the point, though. You know something fishy is going on
when you have a negative resolution. Nobody blinks an eye when you ask
for 4294963K telly, but it's still just as bonkers as that negative 4K.

I think the change at hand is fine, but please let's not pretend using
unsigned somehow protects us from negative numbers.


BR,
Jani.


-- 
Jani Nikula, Intel

