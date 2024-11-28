Return-Path: <linux-kernel+bounces-424602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 501729DB6A2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B795B210B2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2001991A5;
	Thu, 28 Nov 2024 11:38:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5701482F3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 11:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732793908; cv=none; b=EbmOMzBetqKbcXsmyo0oH9Kvt9Iqj8ZrYzwZQBgXT8dxWEaHFZaUTdkvihn+TwvculIaHgABZawy4+ElqBwVGK1g4JIWxWcYITVLO50CsoU/0h48xku3aGB+GeB5AD19fNWX74rkb7uwms+yPXQTOUejx4nBO0waRqNgudB5h5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732793908; c=relaxed/simple;
	bh=OzZQ+sfy5qxKB7CoH7tnvfZgaDGKtxPai5a+x4iB1E4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FxxdHCYR0I0sud2skJmtruoTyxdsT/gaqDZGMNatL+ktTRA6gMPN1vwUaFh01uvkbnrOg1anXwsyuBhr7U+OhrSIC/aHuAUnWSN4qUG3qqLiDOZdCBxLu6YkcJMpd0jJWTTdK+4Pq4qmEmn3ouQ4AQJ8gDWpjMJ/PKw+938S2ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56ACE1474;
	Thu, 28 Nov 2024 03:38:54 -0800 (PST)
Received: from [10.1.26.37] (e122027.cambridge.arm.com [10.1.26.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 596E93F66E;
	Thu, 28 Nov 2024 03:38:22 -0800 (PST)
Message-ID: <f43e4057-8791-45a9-9aa0-5d2e979a9269@arm.com>
Date: Thu, 28 Nov 2024 11:38:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panfrost: Add GPU ID for MT8188 Mali-G57 MC3
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 boris.brezillon@collabora.com
Cc: robh@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
References: <20241113112622.123044-1-angelogioacchino.delregno@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20241113112622.123044-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/11/2024 11:26, AngeloGioacchino Del Regno wrote:
> The MediaTek MT8188 SoC has a Mali-G57 MC3 GPU and, similarly to
> MT8192, it has yet another special GPU ID.
> 
> Add the GPU ID to the list and treat it as a standard Mali-G57.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Pushed to drm-misc-next

Thanks,
Steve

> ---
>  drivers/gpu/drm/panfrost/panfrost_gpu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> index f5abde3866fb..174e190ba40f 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> @@ -236,6 +236,10 @@ static const struct panfrost_model gpu_models[] = {
>  	 */
>  	GPU_MODEL(g57, 0x9003,
>  		GPU_REV(g57, 0, 0)),
> +
> +	/* MediaTek MT8188 Mali-G57 MC3 */
> +	GPU_MODEL(g57, 0x9093,
> +		GPU_REV(g57, 0, 0)),
>  };
>  
>  static void panfrost_gpu_init_features(struct panfrost_device *pfdev)


