Return-Path: <linux-kernel+bounces-447096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDAA9F2D3F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30AC167FE3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56D2201271;
	Mon, 16 Dec 2024 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QM3Vol3G"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55263202C38
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734342332; cv=none; b=PhRV2SY9ZigmsyokHkYg5MnFZvZSI6gS+IGm2aV08YvR8QVcZQI/R1r4p+M3IUiyODI4vfUF9Qqw9UFa9P2KYd6djMLaFdVLy3TUTSpjraMpgZAL27PaVdX+bShFfXhRakCvyHE0huFDEVDL8bwpb83BcERm3pwnyvVayCRGnj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734342332; c=relaxed/simple;
	bh=JRmzcGKr+C1GZ2afbWPHsrKQ/+3opStKZJzgRZVI+OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3Qa9K8vf6ugecUmPRHhQe45nWdQxEvJd7EQRo3uaKskuVSwGVs1bJbbZ/Vbq6nQMjK4uVg+nfcgBM8KhH9OVbw/mcaJMuJCVywyXVSZ9X9tjpX3peyiz8imTrXmQHy+Vx+6r5DGJ6RsZdCknTejI8WNZQhnNketNIPeFFuepPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QM3Vol3G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734342329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mUEqVhqEm411y2btyANp0nQYhhxxqt+IdHIRX6Fy7yA=;
	b=QM3Vol3GXTJ7BNjcP+KwoJhydUdIpmJ2UB6dA1/xZBrnPxDEguuG7cx3+AMd6KhXh0C9Jm
	3XDL2elXlu4qSKfGBib8csQXg5yzOsmjzkytQecgpg4CKQwWg2goK/yDKbTYq1snsx1Xlt
	sHkrZ6sR6bFsbNIbPYRUUtsrPHr5w7o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-BnH-XBrSOFuCFb8ImeBlxw-1; Mon, 16 Dec 2024 04:45:27 -0500
X-MC-Unique: BnH-XBrSOFuCFb8ImeBlxw-1
X-Mimecast-MFC-AGG-ID: BnH-XBrSOFuCFb8ImeBlxw
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa69e84128aso335014866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 01:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734342326; x=1734947126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUEqVhqEm411y2btyANp0nQYhhxxqt+IdHIRX6Fy7yA=;
        b=tMoLi2MKrFf3DNjEYI1J+F1aoTXqSCZm8m8oH9dhTSjBsRN7N/FyKEgs3cGwZQPmiE
         hkj26leNoIHFqTgtxXGwQyYZ5fNetbl29XN+eEDpb5iyAdnA0X56b5sdNhkQ1y45u9lZ
         n5ZnA5gcQhVOGuWFJ3Y4emkP0k56jel9WpNI0ysiFlkE7ShKwQSv5+Uz/7vytwQDZFCE
         RS8Un/7kFOaqGjUmPfeXP6V/0+I4+DFpAOnYcSZKGaTFcZAVIFx5J1oEgmqrev0d/dOg
         LW0WCc+4ITT+v1Vk+Sao0dUi036eHe42Z+lFY3qKRLRgaE6lBfAxRjdcxUiXgo9PQqLy
         lbRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSw8oxVtxS6dPm5u/eD2P6eZno1POKdoHtSoEermfKF6jqffbMCycXzoYqcOfbhknFSh575xA/8iRy5/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOiIwIHkpmm0cRVJI3vVH7NT6mqyIXcadduG3pT7Rjg0R7G6TG
	FBQE8YcEbJ7/1qF7HOeqFq2shpKFkRHJDGOaeB704Y61WYYWKhaV4t8kQUIa1ekwbhmyHSACZdJ
	fi3oOWU1+huYNB2VGDT7ilifl4Pfykgr387E23NNeaaYRheUWOWFKE7IvRcAeQA==
X-Gm-Gg: ASbGncugE8PeF8bycfVG806OY0sDBcvwdEzK7ohxzjAE/U7uINEeDwaDaM7o8t5lHpM
	hKjpvwxC/WtLOMxR8t8rNVhrcMRjT/IF1c/WrT179iKCR8XPyRFfeQPwKoQtnRScrWQ6xQG2v4C
	oKnIKjw6Hz7szcH+WU5PbdsyDxOquhQ6FlF0/IiR7mqa8jJVIkMNhPrLIiAkl9Jfz1Z7O2kOdlR
	OvOs0xU1dWun0eMtOrtTyYB2iV8Uop1FJksU1/b0BXHiSL1ElcH
X-Received: by 2002:a17:906:3289:b0:aa6:7470:8efe with SMTP id a640c23a62f3a-aab77907930mr922253066b.13.1734342326536;
        Mon, 16 Dec 2024 01:45:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZ1z2lzdh2iwu9u26o1qjT8nMT8Dfj1jXT3HMa99NlV9SwaueXBmTZhsa9d+oTc6bnLe3cWQ==
X-Received: by 2002:a17:906:3289:b0:aa6:7470:8efe with SMTP id a640c23a62f3a-aab77907930mr922251066b.13.1734342326159;
        Mon, 16 Dec 2024 01:45:26 -0800 (PST)
Received: from cassiopeiae ([2a00:79c0:644:6900:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652f35365sm3093068a12.80.2024.12.16.01.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 01:45:25 -0800 (PST)
Date: Mon, 16 Dec 2024 10:45:22 +0100
From: Danilo Krummrich <dakr@redhat.com>
To: Zhanxin Qi <zhanxin@nfschina.com>
Cc: kherbst@redhat.com, lyude@redhat.com, airlied@gmail.com,
	simona@ffwll.ch, dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/nouveau: Fix memory leak in nvbios_iccsense_parse
Message-ID: <Z1_2sugsla44LgIz@cassiopeiae>
References: <20241216015246.141006-1-zhanxin@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216015246.141006-1-zhanxin@nfschina.com>

Thanks for the patch, some notes below.

On Mon, Dec 16, 2024 at 09:52:46AM +0800, Zhanxin Qi wrote:
> The nvbios_iccsense_parse function allocates memory for sensor data
> but fails to free it when the function exits, leading to a memory
> leak. Add proper cleanup to free the allocated memory.
> 
> Signed-off-by: Zhanxin Qi <zhanxin@nfschina.com>

Please also add a "Fixes:" tag and "Cc: stable@vger.kernel.org" for this.

> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
> index 8f0ccd3664eb..502608d575f7 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
> @@ -291,6 +291,9 @@ nvkm_iccsense_oneinit(struct nvkm_subdev *subdev)
>  			list_add_tail(&rail->head, &iccsense->rails);
>  		}
>  	}
> +
> +	kfree(stbl.rail);

I think it's a bit subtile why this is needed here; better add a new inline
function (nvbios_iccsense_cleanup()) to include/nvkm/subdev/bios/iccsense.h that
frees the memory and call this one instead.

While at it, you may also want to send a separate patch, adding a brief comment
to nvbios_iccsense_parse() which notes, that after a successful call to
nvbios_iccsense_parse() it must be cleaned up with nvbios_iccsense_cleanup().

> +
>  	return 0;
>  }
>  
> -- 
> 2.30.2
> 


