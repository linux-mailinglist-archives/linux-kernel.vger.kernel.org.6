Return-Path: <linux-kernel+bounces-282792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A2194E8B6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C677B281102
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D69016BE2D;
	Mon, 12 Aug 2024 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wb5w7ZsX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1D616B38E
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723451602; cv=none; b=XhWJv+GGP5X2EOEQQR2YTune8aDHND3GKVaSLXNy2lcROy8tG0D4LOH/jT0F9f7TUP0FUfZ9AhjYO65ks+pIyHUp7JrKMfRDmD/T4BpaTm8ftplInr1aaxuM90W8VnfSOCatTNN/+njsqk4TjXxsAOoWu2htlVeXf6Etqk0uQEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723451602; c=relaxed/simple;
	bh=tH1upEpZw6dKFx1PLF3qJ5JJveaPcggY1DqwJ+M1ZTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YNbLm/rMufTGxNXpf5YPXM29Z8nzWPot2l7acdRxlLvJY+WGQgdi6c0B8xsMsMnu/Znz5MB4xFg+9gJVqBtM1qrk1yNoDqOfpZ60NQq3soYl1uIEzADO4s3lJIIO9J29yZRbaBNO1b895uZ3OOtN9orfL9MjQpLxNFv54JDe2yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wb5w7ZsX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723451600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eJ8d8OgEOA0fkg4NJTf/zsYw0k58Jv8qYMf7Ezn/m+Y=;
	b=Wb5w7ZsXdZHCNbhtBnRkJV2S43rcu8cqCfuf3T1d9cMt2XtEHTh6sayQLEm3/DCSlVa51s
	9KExEOFuolWMM07/G7qLXcazEkXnivCGCVrSx4XfIF7EovrcPWOmiqSvj23VEAU8SpvkwO
	lDHn2xZnbCOE5AUzAgw127SaTGsNrMw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-E3AbGsTuNLKXxtsDzrw5eg-1; Mon, 12 Aug 2024 04:33:18 -0400
X-MC-Unique: E3AbGsTuNLKXxtsDzrw5eg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a7ac5d81e2dso313504766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 01:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723451597; x=1724056397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJ8d8OgEOA0fkg4NJTf/zsYw0k58Jv8qYMf7Ezn/m+Y=;
        b=uez2BcqWojLY13SycAvcgxY5A4k0DRkIv15WlU/lLiQbdBtJlrNI1tvb9Ry2IOu++u
         cus8UZK0sdP8sDcbBjFdZhU/+i60vb49W9zoDTqVxRc+XCsakRsCMRlxaRrmssofu3RR
         XOXC8M6B0Q2KJOkGL+zbKkysW1atU0TM0DwkWjiIp3tfrXVeGKWIzaGTbr2ZQoBOs1UV
         Wn/YWE5FNwytjoKSCiznn7GLqlvTFaeBzY/Rfo6pxHjiLNDKMgMEIm0BggCGf2lpuP+J
         Soe3E/UXCC0Ng42DrkiUq45guk65P6TZKGWX7tf47YvOKMrvAmFlDyQdF3/EXOEdIcZv
         WYfg==
X-Forwarded-Encrypted: i=1; AJvYcCVWJpTGzfGGIH4wKpPy3XenSxzt9taQtwetvllgGLf3SW+2GLLZ9zdHxiCMl4fEaaWcIfC4Dax1aVx+Pyhp9mYeOeYX8/RI7I670PVc
X-Gm-Message-State: AOJu0YwdK4XS4P5QqP1YT6cTeZA1uFOHHwXzexEt5wmyLkE6VwiuyCiP
	Oj3q0y/lECr+l83RpdlzzbEi7UARI1ShlftGRsYVkDep0QjUYCzAliqWXLm3Of3yL7U3HC0a89f
	pcWD62hdDOZilponxuCc17xe0D9Lp7liYvOheGRaIN7vlbDwgQ8ASDhM0zsK6NA==
X-Received: by 2002:a17:907:c892:b0:a7a:aa35:4089 with SMTP id a640c23a62f3a-a80aa594542mr616823666b.24.1723451596689;
        Mon, 12 Aug 2024 01:33:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEK0nBLU/MVTNoXatVis/dgwbEc+SNmcfw5FHlEcSXydiaoBuSEPGo7FAfPhCfum9qOBh24qQ==
X-Received: by 2002:a17:907:c892:b0:a7a:aa35:4089 with SMTP id a640c23a62f3a-a80aa594542mr616821766b.24.1723451596152;
        Mon, 12 Aug 2024 01:33:16 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb1cd3d2sm209575266b.132.2024.08.12.01.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 01:33:15 -0700 (PDT)
Message-ID: <8dfa02e3-a603-40a3-884a-72c7eeef6561@redhat.com>
Date: Mon, 12 Aug 2024 10:33:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 0/2] drm: panel-orientation-quirks: Add quirks for
 AYN loki zero/max
To: Bouke Sybren Haarsma <boukehaarsma23@gmail.com>,
 maarten.lankhorst@linux.intel.com
Cc: mripard@kernel.org, luke@ljones.dev, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240728124731.168452-1-boukehaarsma23@gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240728124731.168452-1-boukehaarsma23@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/28/24 2:47 PM, Bouke Sybren Haarsma wrote:
> Add orientation quirks for AYN loki devices:
> - Ayn Loki Zero
> - Ayn Loki Max
> 
> The quirks have been tested by the JELOS team and ChimeraOS
> who have been patching their own kernel. This has been
> confirmed working by users in the ChimeraOS discord
> servers.
> 
> Since there are additional Ayn Loki devices I have
> made separate matches for the devices.
> 
> Bouke Sybren Haarsma (2):
>   drm: panel-orientation-quirks: Add quirk for Ayn Loki Zero
>   drm: panel-orientation-quirks: Add quirk for Ayn Loki Max
> 
>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Thanks, both patches look good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I have pushed this to drm-misc-fixes now, sorry for being
a bit slow with picking these up.

Regards,

Hans




