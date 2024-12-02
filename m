Return-Path: <linux-kernel+bounces-426966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 635FA9DFAB0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333301626C7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 06:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562461F8F0D;
	Mon,  2 Dec 2024 06:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GWJYGs1v"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83911F8AC5
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 06:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733120873; cv=none; b=l8WSNwyY2ui7627G4vJAfZtjCEmUSQa9Pu2k2ZwZUq3CBgBd/0nwlsAT+5jkW0/rpaPc0gJNJGWG4rUYFYjyY2aB3j9fGW+ULdH3LBdpxc15gKJt0qBrnG8h5e8x+fqAjF9XhkQjStXxpazvoun7hAe1sjlakarVvVyyalHr4N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733120873; c=relaxed/simple;
	bh=9MQsm1lwlQXSK0j+dZpbTdVf0ZGd/Jt0lAMnHjIo+rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CGChNQgPYB12SARU9pxm3P1bLOgN63Cwxc749Ix9PjVzp+oHg8CLJiiewtBV9FJpgIQeG1OReTPOzqhMe6Vt+Zrvoghy6uetTtXvNmKnim7eYPXOOgEBM4nzdoQ0vlv+RB0XvfNoeTiC2uF7IOCA251bi4PGE7iVoULV3qNuEmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GWJYGs1v; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9bf93351-b2e1-449f-8d86-86a53cb55555@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733120867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I36bdO1o/ERQB7hy2W15wzWFD1Wr3GzIpc0nBv478Ls=;
	b=GWJYGs1vcCE8YLqDtLC06G+yOfgu/fQD4d2JjJjVTFz4vJgXJ2m6+e24/Ql9UYxFhvU4dH
	CPq2vCK9c01DeXNfDpAltqIHKpFFnRozH4GL27n178V7CczQs8CcJx5ZnRxaMI/O197fMo
	DoququJ9GzTSBbLKHs5ckr3wBqH5JSA=
Date: Mon, 2 Dec 2024 14:27:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm/msm: Check return value of of_dma_configure()
To: Markus Elfring <Markus.Elfring@web.de>, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Konrad Dybcio <konradybcio@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Cc: LKML <linux-kernel@vger.kernel.org>, David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Simona Vetter <simona@ffwll.ch>
References: <20241104090738.529848-1-sui.jingfeng@linux.dev>
 <e1de6040-dba3-40d3-9088-5555735224fc@web.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <e1de6040-dba3-40d3-9088-5555735224fc@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/11/30 22:51, Markus Elfring wrote:
>> Because the of_dma_configure() will returns '-EPROBE_DEFER' if the probe
>                                        return?
>
>
> …
>> Stop pretending that it will always suceess, quit if it fail.
>                                        succeed?            failed?
>
>
> How do you think about to add any tags (like “Fixes” and “Cc”) accordingly?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.12#n145


Thanks you for providing the grammar check, will be fixed at the next version.

> Regards,
> Markus

-- 
Best regards,
Sui


