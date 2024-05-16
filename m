Return-Path: <linux-kernel+bounces-180868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB978C7421
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61CEB1F246DA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 09:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9963143868;
	Thu, 16 May 2024 09:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EVBHi22Z"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515F914293
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715853032; cv=none; b=IkNPrq0j3R2ToEYcrU0rdjiQ6wLAZ945n+7094xFmm2091tJHZErC2sAU/jP7aziQvCpk5Ty9BydxuZKh5/jHlIDDkPrJvoX7uD1o6Mygx8b/3/TE8hINsAcNWICQuTaU7Sis86qpkPMqgXDyyBaa8mphiLhgjIYSDEnyhapp+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715853032; c=relaxed/simple;
	bh=kOccNjr5/hA7QcukxcZpdGmePq4x2MivzWPwdLfpmaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fZb9Dx47QfmKExsIe6L4ZtJg3UJ+hboth6lfhp2Vd7h6hPaqg4hLAeHAfIQPkztl/V8zQ6xrLH2UPA7FqiM423ZBtMkdc1o9KmHYKV7fC7J3k/6gzjObT5CDyoJ63Sa5erWRG08HmSkhcFHC53KcVTawHI8exLN+RnG0rb//EZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EVBHi22Z; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: markus.elfring@web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715853028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6YKA4zorDccEaUD4FxmIdziK3ss8eQh9e6ImT4g2z1M=;
	b=EVBHi22ZdnZhzLJGxJwndqBVFVodvGsm8J1TgD9j2s0a4FlBRG+fqJ498/ggdGpuAnAGbR
	MjzDOcuMU6Lxi7Tiplo7sGvivuZvzHqQwGRL4nt41AxEVELEGIPs5mdCXyLRzqGipszaup
	tVl3zLhxbylFIUIEeRhtrzFMsiXuiDQ=
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: kernel-janitors@vger.kernel.org
X-Envelope-To: mripard@kernel.org
X-Envelope-To: tzimmermann@suse.de
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: suijingfeng@loongson.cn
Message-ID: <1de308ad-568f-41da-9dd4-258cd07556f0@linux.dev>
Date: Thu, 16 May 2024 17:50:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] drm/loongson: Refactor lsdc device initialize and the
 output port
To: Markus Elfring <Markus.Elfring@web.de>, dri-devel@lists.freedesktop.org,
 kernel-janitors@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Sui Jingfeng <suijingfeng@loongson.cn>
References: <20240513001243.1739336-4-sui.jingfeng@linux.dev>
 <dc34d171-dc47-4817-a6f0-9f23a3afb8e7@web.de>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <dc34d171-dc47-4817-a6f0-9f23a3afb8e7@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 5/16/24 14:26, Markus Elfring wrote:
> …
>> fullfill the implement under the new framework.
> 
> fulfil the implementation?
> 
> Please improve your change descriptions another bit.

I'll accept you suggestions, with pleasure. Thanks.


> Regards,
> Markus

-- 
Best regards
Sui

