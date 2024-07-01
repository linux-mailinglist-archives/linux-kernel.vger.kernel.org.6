Return-Path: <linux-kernel+bounces-235514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EEA91D605
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 04:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899D81F218F8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 02:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE35C8F66;
	Mon,  1 Jul 2024 02:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ipe0QGb4"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966FD1865
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719800435; cv=none; b=T8xCRI15Q6MyASaXuIYLqBQpRiSKqkkE7yQfNEEK7gGLJcmWgPc7ElJ4OQ03eCjZuVI9ofyI9aXU52qC6dsG6oHH8Lvm5IFh0mGshGFyHztLZhVB5EtARy9DHlBP70+gWGbO3f585TJ2YmbyTEb9VodCBgJ4cFfUU9IT1KPqUVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719800435; c=relaxed/simple;
	bh=+78tp+o56b5vm1tyXZH947iOwJ8HRVPFdg2Z34wP0ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pEb6IPrXpwMpJ5ZPZM5hhY4Dk8Uemn/l3acS1A0A/hk9RCAlK3tnVo1Dt8yoTXXKOEeW0cCrq0xuCF2ZtLamFxEMVG/A6LTyXW4932439qhWuWUW2wrRAeG8z0A8V80zCDsy51r24dbONBT6XwRrbfe0bLRrE9vo566P0E8FdY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ipe0QGb4; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: senozhatsky@chromium.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719800428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DVJmOoi2i62EReBrG/8p9Ry1S9OQU3jsozOFXNT/nj4=;
	b=ipe0QGb4Rj4Wg7h48JG/zxwc0z6AKdKZrYm59ISytrr44qRECc6pa4QTGgRtAgFbHP+hHx
	OSmjEWMp05XqZoZH3Rs804YDiO0A0ANmkgvLaOxALahB2h/7CxireJ4FQdv0i8wuJM923+
	Qpjb70wH8zogTf1dSGJARODmnGHvdY0=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: minchan@kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <4f2a5cf1-3132-4bc6-965f-8dc5a8ffc05a@linux.dev>
Date: Mon, 1 Jul 2024 10:20:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] mm/zsmalloc: fix class per-fullness zspage counts
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: akpm@linux-foundation.org, minchan@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240627075959.611783-1-chengming.zhou@linux.dev>
 <20240628005523.GC15925@google.com> <20240628010812.GD15925@google.com>
 <caf4b05d-6adf-4976-9961-fa30d3a9969c@linux.dev>
 <20240701013731.GA3232210@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240701013731.GA3232210@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/7/1 09:37, Sergey Senozhatsky wrote:
> On (24/06/28 11:19), Chengming Zhou wrote:
>> Andrew, could you please help to change the subject as Sergey asked?
>> Sorry, I should have noted these details in the changelog when I wrote
>> this subject.
> 
> Chengming, can I ask you to resend these patches with a proper commit
> message?

Of course, will update and send later.

