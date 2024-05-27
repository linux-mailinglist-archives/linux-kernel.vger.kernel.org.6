Return-Path: <linux-kernel+bounces-190799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5543E8D02FF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06104B2ED9B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6089715EFC1;
	Mon, 27 May 2024 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i2fkXIN3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5347DF503
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716818921; cv=none; b=bC/4/N5EVJu6e0QDgZXWO3GTCVMDl97SzS5HfiHjA9Jn1xOIiV3/MovwPOir2I+iJ06E6ki2Fd16TFTviHqsTK/9iWTPPXI5Iwrc45pidCnyRIM1L4kNR5YErwoyL2odF308PQPEdP6E2JluMtzwZv1vG8mieyYv8DoysLlDm7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716818921; c=relaxed/simple;
	bh=ZXwbZiy8td+gubmN1p/8TtpDqubSKNzO4ViE717nqXo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I13oI6NSMSjtdgyG5s8dx8aYZhfuqfnt0HhVmMfDnBfi1rvY2+7JaEmLJjPb1ud3/lK6fybkaJV74sM4D79NDu4T3VK1iTx3QPpimpF03OehgbV3N7EoDjeC6hqknGCpMGssPvLH5NQ73cAlCZ8GSr/dm6i/l3ANf7MPm9/eJJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i2fkXIN3; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716818921; x=1748354921;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=ZXwbZiy8td+gubmN1p/8TtpDqubSKNzO4ViE717nqXo=;
  b=i2fkXIN3qIZXOB6GjN8+mdHyAdSxcYPQrg4uqgFOaN5L+oxERO6bMHW6
   2fLcZoiLTlIFRMge9mHZ8O7/DlC3LSQH2isSURHETggYYomos77puKs91
   BEhH+FXlOffStyKDfwbNmT/xHwISpc/mpZ/DHUVLD30a3vH6Nycje4UP8
   A3SBtftCVqQVa/oPcvTUIryrllkOEFQ+bhg4uQr6MMUyLZiQi+cvmY4xH
   71rsqSjHv5bhxpS2wnaXo2K1osDORWq6DUairG4zBR4+4pFpgRRr777w/
   t0D/qx4dWSMhODTC3/8R8UJcZN5E+y8GMs39x7Ck8JwmsbKxm27PFXlI3
   w==;
X-CSE-ConnectionGUID: AtWyVuEjTjqpSOl6Ht7E5A==
X-CSE-MsgGUID: CaAhchByRZO2TYEyAtGTOA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13314252"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="13314252"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 07:08:40 -0700
X-CSE-ConnectionGUID: WclyaCNiQxKBcSASf3gFJQ==
X-CSE-MsgGUID: e/YtuAi0SRKK8zGxEOOCBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="39318700"
Received: from lfiedoro-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.200])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 07:08:37 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, Kees Cook <keescook@chromium.org>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 2/2] drm: use mem_is_zero() instead of !memchr_inv(s, 0, n)
In-Reply-To: <CAHp75Ve0vyOv3KNY_7286wLKd8u6HOvu0Trm17rs46h-BOGsfA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240527094320.2653177-1-jani.nikula@intel.com>
 <20240527094320.2653177-2-jani.nikula@intel.com>
 <CAHp75Ve0vyOv3KNY_7286wLKd8u6HOvu0Trm17rs46h-BOGsfA@mail.gmail.com>
Date: Mon, 27 May 2024 17:08:34 +0300
Message-ID: <87h6ejmjod.fsf@intel.com>
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
>> Use the mem_is_zero() helper where possible.
>
> ...
>
>> -       if (memchr_inv(guid, 0, 16) =3D=3D NULL) {
>> +       if (mem_is_zero(guid, 16)) {
>>                 tmp64 =3D get_jiffies_64();
>>                 memcpy(&guid[0], &tmp64, sizeof(u64));
>>                 memcpy(&guid[8], &tmp64, sizeof(u64));
>
> What is the type of guid? Shouldn't it be guid_t with the respective
> guid_is_null()

I can leave out these parts of the patch.

BR,
Jani.

>
> ...
>
>> -       if (memchr_inv(guid, 0, 16))
>> +       if (!mem_is_zero(guid, 16))
>>                 return true;
>
> Ditto.

--=20
Jani Nikula, Intel

