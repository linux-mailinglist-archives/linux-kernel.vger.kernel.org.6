Return-Path: <linux-kernel+bounces-293871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A28EB958602
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B2F0B221CA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A15918E768;
	Tue, 20 Aug 2024 11:42:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C0018E75A
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 11:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724154157; cv=none; b=i3Fc9ch7RGu5cPFXaSJHj9vt6TIv2Lf81jYwLhBbxRDfgb1hITfsxoEGDlki2dLD7uWvCT5M2POseDsuuNFWAg6G51ntm9XFM0kDsQTi4RBk9qaMV72hXO/y/r/KlCKvYRS3xh3YCgfA+mNE7qO+hSdJqFDrKoAsJZ4yDB13f5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724154157; c=relaxed/simple;
	bh=jxXqwgf/vJARc4L1LGNsvI12gTh7VtQKLKDk/iVpwr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=bHT1ZAHuVchXiAVwnjdhl2Oi4jABcPwQWn9U3Hs/V7qSjLefi6jAGKVXwATw4FUOoO5AYBnt0GrhagSJP69ncaKPu9GcYi3D707EfyVQERHZeisuBxPK+OTspflMbfPPqgl4G8I33NH4Ax6OAS/yaH6dwrjxxg0U1iGo000E6w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D56AFEC;
	Tue, 20 Aug 2024 04:43:01 -0700 (PDT)
Received: from [10.57.70.240] (unknown [10.57.70.240])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94FC43F73B;
	Tue, 20 Aug 2024 04:42:27 -0700 (PDT)
Message-ID: <32a3bb02-59b2-432d-a75b-d7951971cda6@arm.com>
Date: Tue, 20 Aug 2024 13:42:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] arm64: Prepare to switch to generic entry
To: Jinjie Ruan <ruanjinjie@huawei.com>
References: <20240629085601.470241-1-ruanjinjie@huawei.com>
 <20240629085601.470241-3-ruanjinjie@huawei.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com,
 tglx@linutronix.de, peterz@infradead.org, luto@kernel.org, kees@kernel.org,
 wad@chromium.org, rostedt@goodmis.org, arnd@arndb.de, ardb@kernel.org,
 broonie@kernel.org, mark.rutland@arm.com, rick.p.edgecombe@intel.com,
 leobras@redhat.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240629085601.470241-3-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/06/2024 10:56, Jinjie Ruan wrote:
> -#define on_thread_stack()	(on_task_stack(current, current_stack_pointer, 1))
> +static __always_inline bool on_thread_stack(void)
> +{
> +	return on_task_stack(current, current_stack_pointer, 1);
> +}

This looks reasonable but I wonder why this change is required (as the
commit message suggests)?

Kevin

