Return-Path: <linux-kernel+bounces-222645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E12291053F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AC0C1F226E3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E861AE0B5;
	Thu, 20 Jun 2024 12:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="iv+mI5s9"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD1C1ACE86
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888239; cv=none; b=AXm9LlWN/V15HEGRhcXkFBJNrEKbgJhyFy+h+7CwcvZ397M/KTUN/QSRi/VEN7gvcKUr6r/1xeXuHn0/7feNTKAikv9rGNwrhhD4Av8MGNcWu8n83ZZ/jdLH9wVK1KrkSEjXBFZDdW/AGxDqDjPua3HjWcMSejOyDmE9MfkuWdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888239; c=relaxed/simple;
	bh=/kJ1Twhq0c3VLeIy80ABE2e4kQ5O1ifTyfThn1FYtb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ge2CXakWEdThX2bTir2iTV+ir1ca0btIga6d14K5sy8SG0y+OrCy8+tcaR/vwTD8E7bA4k5fdRh8c93J9RZ0P3JLGcS06mMvx+ZiFsfqLpcXHlkb3s4mDUsClH1eSW5nngNmGnlRGKZR416W5r0vKLgar2lqzCvROI596fNBo7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=iv+mI5s9; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718888236; x=1750424236;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/kJ1Twhq0c3VLeIy80ABE2e4kQ5O1ifTyfThn1FYtb8=;
  b=iv+mI5s9cyhS3NVrCiBBYAFFnY8+hNehNK6ZKhTfqjjhPcWmwgHBh+Yu
   VV8iXkwo0QImWKuN0PEgXc3K9MrfSb3Acw5wOsa3NQ7IBhoyWz4wyPz1L
   ghbURhGAAyVzfZPkEMnSfZoWqzOrV6xhVvcoaec5xgzKpGE2GgdTXhV2q
   cuQft7QadW5W+TwlCSvVn91sncDqa+l1Ucchwk0bVSE3KNFrA5xEQdvdj
   jIfUr0SZJYObVhzvS7rr3fU1MhKB8ZvefR3wUKdhb884TVv4//Vr4rSOQ
   BrTvlqZk/KrS/heV7WguW2k1l0LMcl1ZFsMYkZ2dmRVw/giuGlFf7WXIr
   A==;
X-CSE-ConnectionGUID: +1QWA2btSLaG39LyRA/spA==
X-CSE-MsgGUID: Hqq+slJXTj2ra7Znb9UTcA==
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="28917768"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2024 05:57:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 20 Jun 2024 05:56:45 -0700
Received: from [10.180.117.30] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 20 Jun 2024 05:56:43 -0700
Message-ID: <9b7c09b6-24a5-419f-b361-6c0dddbbb0d0@microchip.com>
Date: Thu, 20 Jun 2024 14:57:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update Microchip's Atmel-HLCDC driver
 maintainers
To: Manikandan Muralidharan <manikandan.m@microchip.com>,
	<linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
CC: <Hari.PrasathGE@microchip.com>, <Dharma.B@microchip.com>,
	<sam@ravnborg.org>, <bbrezillon@kernel.org>
References: <20240620095856.777390-1-manikandan.m@microchip.com>
Content-Language: en-US, fr-FR
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20240620095856.777390-1-manikandan.m@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 20/06/2024 at 11:58, Manikandan Muralidharan wrote:
> Drop Sam Ravnborg and Boris Brezillon as they are no longer interested in
> maintaining the drivers. Add myself and Dharma Balasubiramani as the
> Maintainer and co-maintainer for Microchip's Atmel-HLCDC driver.
> Thanks for their work.
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>

Thanks Sam and Boris,
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Best regards,
   Nicolas

> ---
>   MAINTAINERS | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d1566c647a50..8f2a40285544 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7290,8 +7290,8 @@ F:	drivers/gpu/drm/ci/xfails/meson*
>   F:	drivers/gpu/drm/meson/
>   
>   DRM DRIVERS FOR ATMEL HLCDC
> -M:	Sam Ravnborg <sam@ravnborg.org>
> -M:	Boris Brezillon <bbrezillon@kernel.org>
> +M:	Manikandan Muralidharan <manikandan.m@microchip.com>
> +M:	Dharma Balasubiramani <dharma.b@microchip.com>
>   L:	dri-devel@lists.freedesktop.org
>   S:	Supported
>   T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git


