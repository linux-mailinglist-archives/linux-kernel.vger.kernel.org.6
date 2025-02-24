Return-Path: <linux-kernel+bounces-528817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C0DA41CB2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72543A7974
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3C9266197;
	Mon, 24 Feb 2025 11:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="IOM5tliM"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9189B265CDC
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395901; cv=none; b=RFI5x+Ob2REG3J/oPUKtHasp1/+m1hzHc/bmZKI9CNR/eLTgxicNPUgJiTUiTEL7PxcbMpIn0PJ6swembSCxzIDtARxtblBOxcFdvb/usiZYs1tvxOhfFfN8i/5VlvJ1yzKhOPH1MsB1b0toquIiIolqyzz/Zn57CisMEDyeaMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395901; c=relaxed/simple;
	bh=fEikObLI+PJPm7Km4x/KqXSkIAGyKsU6Oid+W+SKd7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Dh/hnXbMwjIX+CHi9dvYn8v02xSP4eZ+eiWKknCmd1KZtapYa3LP2H2yIVsST8ljWSJsIzbH7rYeXbVdgVHgiLzRBhRTy2m0ZMHv62Zq12N0VGUZ+lqIQ+zdXoF0xukVYxWLlfj3EAPMV0NWes1tPOmsviCNX7w0RTDxwfg9udA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=IOM5tliM; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Z1dWq3hyNz9sp9;
	Mon, 24 Feb 2025 12:18:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1740395895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=poEXpB9K1y9vdfQWtg9Kt9vHNV/RTZ0L7LaGGPuin2E=;
	b=IOM5tliMYHrHklJCslpc23Y2z9qSc7C4myDYgRpC2yRS4Rx4N0vUSGEVnDFE8k/xRT/NeW
	JCKnIzueuGXXCYIyTeyaebgSwvg0VVfICr3BiHLJA47tS0TG8sQ+fjoncPPV35DpWrp2by
	M4RnY1lOjYRqzZYqP43eyY4QAWlVd7kwWMwPOzdV8Y4aDm7EtC71BsoSq1otL+jsThOTd8
	LM/wMtjOE8UEJKzSGNlXSvDzB4L107H+GWqZcFsEJ27IkAz/l3HPpbhj2i9YGosBxVy0df
	ujbK/n1Wyfef3m2CRBFZ8zFCb1L2di2eHQ1UtutrUQV1sBSSdyfvwdHWdgkXZg==
Message-ID: <055fb477-c369-414b-98e4-d2677213fb9e@mailbox.org>
Date: Mon, 24 Feb 2025 12:18:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] drm/amdgpu: Log the creation of a coredump file
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?B?J0NocmlzdGlhbiBLw7ZuaWcn?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, siqueira@igalia.com
References: <20250219213517.281556-1-andrealmeid@igalia.com>
 <20250219213517.281556-2-andrealmeid@igalia.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: de-CH-frami, en-CA
In-Reply-To: <20250219213517.281556-2-andrealmeid@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: m4n5jh5nm7i7j4fubmeks4qk69itcojw
X-MBO-RS-ID: f8b276519071cec9aea

On 2025-02-19 22:35, André Almeida wrote:
> After a GPU reset happens, the driver creates a coredump file. However,
> the user might not be aware of it. Log the file creation the user can
> find more information about the device and add the file to bug reports.
> This is similar to what the xe driver does.
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index 824f9da5b6ce..7b50741dc097 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -364,5 +364,9 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
>  
>  	dev_coredumpm(dev->dev, THIS_MODULE, coredump, 0, GFP_NOWAIT,
>  		      amdgpu_devcoredump_read, amdgpu_devcoredump_free);
> +
> +	drm_info(dev, "AMDGPU device coredump file has been created\n");
> +	drm_info(dev, "Check your /sys/class/drm/card%d/device/devcoredump/data\n",
> +		 dev->primary->index);
>  }
>  #endif

Maybe this should be done in dev_coredumpm instead of in the driver?

Could make it a single line:

	drm_info(dev, "Device core dump created in /sys/class/drm/card%d/device/devcoredump/data\n",
		 dev->primary->index);

(AFAICT drm_info prints the driver name twice already, no need for a third time :)


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast

