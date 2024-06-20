Return-Path: <linux-kernel+bounces-222317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 897E390FFA1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844171C213DD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DD81AB35B;
	Thu, 20 Jun 2024 08:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXVBFWFk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C1F2139D7
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873594; cv=none; b=MLqklTXhd91yalYCty37g1TtWYt5V2ByziFgI+/LiYvzHRoZwraG8yDY8xJ1oMKjA3D41JuU73Xzmiq1Xw/NutHzb3wJ6UzGQk9qhQmEPUYgFAvP8yMBSnhwgs7Eo6KSY1FO4rki19RgbmpqgK+uCkPEn0s1Uq3NwVfd1QHWjs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873594; c=relaxed/simple;
	bh=hRpD2oSJk3bfMnna+VloVB0FekUlFFz8OfKZw12xrRU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d/HzVA2T/aLri1uFOb3jGrQ3OvECosoVGXCYE4uSnibef8Af6q7JZQtUd8oHHjn7ZzD8i5pqhsBjCp/F8FcyhIjqzA3CGo2IyTofM6Ff/QOyuK7/0P3Oc/i/tVIuJPB2mYuZWeF33rZ9UOxTDXE8U5gxcL4XDRgHmaA5Oua7aCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXVBFWFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750ACC2BD10;
	Thu, 20 Jun 2024 08:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718873594;
	bh=hRpD2oSJk3bfMnna+VloVB0FekUlFFz8OfKZw12xrRU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oXVBFWFkXYMboO01m5otd0aUgNt+XduBzRcoZwzQzUUsguH91kQLxHK72/Di9yUu2
	 NtML8B0Lo01QCAElbiyt3DmLcvo4Nr2sWqA866m/A/OY4cYOHyNTIJsFtFpPVngQzF
	 IfWECGvvHGJJbsJ3PYv1V9X63T6Jv/E6nYWS7nd/fPBZCf8gaOIrE4KfrJTZu1ulFh
	 DPk9GkKoVJFfnhPDDpS+sB/CjLtXtlNPHpfheZ4bGvmAW7BHniyk9avJ3wdw74C8hX
	 3ePOuNj2TdTfmh5jHKBJQf13CbmIdRWk28jS5gZBZJF6W9l6YNzh1Bvhyb6Rmh6ByU
	 PfD5IXSeGkpAg==
From: Maxime Ripard <mripard@kernel.org>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Amaranath Somalapuram <Amaranath.Somalapuram@amd.com>, 
 Andi Shyti <andi.shyti@linux.intel.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Boqun Feng <boqun.feng@gmail.com>, 
 Christian Koenig <christian.koenig@amd.com>, 
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Huang Rui <ray.huang@amd.com>, Ingo Molnar <mingo@redhat.com>, 
 Karolina Stolarek <karolina.stolarek@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Waiman Long <longman@redhat.com>, 
 Will Deacon <will@kernel.org>
In-Reply-To: <20240619144630.4DliKOmr@linutronix.de>
References: <20240619144630.4DliKOmr@linutronix.de>
Subject: Re: (subset) [PATCH REPOST^2] drm/ttm/tests: Let ttm_bo_test
 consider different ww_mutex implementation.
Message-Id: <171887359115.3857922.3484081720728678081.b4-ty@kernel.org>
Date: Thu, 20 Jun 2024 10:53:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 19 Jun 2024 16:46:30 +0200, Sebastian Andrzej Siewior wrote:
> PREEMPT_RT has a different locking implementation for ww_mutex. The
> base mutex of struct ww_mutex is declared as struct WW_MUTEX_BASE. The
> latter is defined as `mutex' for non-PREEMPT_RT builds and `rt_mutex'
> for PREEMPT_RT builds.
> 
> Using mutex_lock() directly on the base mutex in
> ttm_bo_reserve_deadlock() leads to compile error on PREEMPT_RT.
> 
> [...]

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime


