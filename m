Return-Path: <linux-kernel+bounces-190797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5921F8D02C9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3911F236AD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCF815EFAB;
	Mon, 27 May 2024 14:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ATKFYzzI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ABB13A248
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716818796; cv=none; b=ohH9opH86gd2G5uyxZ1M736XBrnXV0TXBX1dZPiY5FbRZCl41J05M5D6LqmOauDNuFYd0Yilyh+qOIF8bykaE78CinatRh4LIPxNIGHI6Ayxh9GXaVaP33Tsmdy+Ce9aDzSQ8dmYOd2S7N4XFe8POhQpIDMie0FTP9nScgvUH8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716818796; c=relaxed/simple;
	bh=esIMTSoe6zhhWKEKkt5wS7n9Xn3QvTEZP+DHoYjHzU8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PRJD4ZK+0+/P8eBr+okecJG4JqZgmqRpZG36LB7GfAUo2jlljGNvV22Kgu97kxGLupoYIQiQoNhl84jP4DET4Zc/ki29R6YVPIILdNbViSTMj1eQnO5nIbx+EVLwqxFRPgyBP2qH5kAxX3I33szOyNz/+3vox6LT5ifKcZJ0CFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ATKFYzzI; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716818795; x=1748354795;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=esIMTSoe6zhhWKEKkt5wS7n9Xn3QvTEZP+DHoYjHzU8=;
  b=ATKFYzzIsf2+U6xydAlgQ3eqLc49wzopNkQVjDUaNcIsaxSatNfMtGEb
   JA9olKH2YASp//sD+JkoSfgK5fkjSyJ22VmkDEmxkVK9es4/cDqPKeNVk
   Wg1aDnWGvT9ps4NViygumJTYJfOMmC/D6Mk+UapPIJ/TmaqOAhwbCYdrB
   hiV7T+T4a9ytbyeEXYdpHV92i0tjmqy1BiKBBBn/ap6YgK7Z5OghOoFeW
   wHggYvwcq9qH8dpd+CSKzJ6hGaM2cI5pOVSjeCeCFC7+P1JNhcOmK5pW4
   8Ir08Wd+1zY1KEf4zrrX6JHr+dwYoflhtA17fUQl5+ZQWWQQaM1PTeSJU
   g==;
X-CSE-ConnectionGUID: I0rErUnDQyW8T5HnDgyirg==
X-CSE-MsgGUID: FmvaITcNSDC3LWLK1P10KQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="24267954"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="24267954"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 07:06:34 -0700
X-CSE-ConnectionGUID: vqCrNranR/GTPXOOHJpqbw==
X-CSE-MsgGUID: a8cmA0bQR5WQoakChsMkzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="35260746"
Received: from lfiedoro-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.200])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 07:06:32 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, Kees Cook <keescook@chromium.org>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 1/2] string: add mem_is_zero() helper to check if memory
 area is all zeros
In-Reply-To: <CAHp75VcWXCeQo4n67cfq0VQaO-+YW-=iqKx+r4NtFfYnJBTBFA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240527094320.2653177-1-jani.nikula@intel.com>
 <CAHp75VcWXCeQo4n67cfq0VQaO-+YW-=iqKx+r4NtFfYnJBTBFA@mail.gmail.com>
Date: Mon, 27 May 2024 17:06:28 +0300
Message-ID: <87jzjfmjrv.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 May 2024, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Mon, May 27, 2024 at 12:43=E2=80=AFPM Jani Nikula <jani.nikula@intel.c=
om> wrote:
>>
>> Almost two thirds of the memchr_inv() usages check if the memory area is
>> all zeros, with no interest in where in the buffer the first non-zero
>> byte is located. Checking for !memchr_inv(s, 0, n) is also not very
>> intuitive or discoverable. Add an explicit mem_is_zero() helper for this
>> use case.
>
> ...
>
>> +static inline bool mem_is_zero(const void *s, size_t n)
>> +{
>> +       return !memchr_inv(s, 0, n);
>> +}
>
> There are potential users for the 0xff check as well. Hence the
> following question:
> Are we going to have a new function per byte in question, or do we
> come up with a common denominator, like mem_is_all_of(mem, byte)?

No. As I wrote in the commit message rationale, "Almost two thirds of
the memchr_inv() usages check if the memory area is all zeros". This is
by far the most common use case of memchr_inv().

BR,
Jani.


--=20
Jani Nikula, Intel

