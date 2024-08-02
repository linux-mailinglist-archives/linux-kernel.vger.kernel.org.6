Return-Path: <linux-kernel+bounces-272875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02470946222
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349CF1C21344
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D8914EC57;
	Fri,  2 Aug 2024 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="mJDkb/85"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6156D16BE0E
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 16:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722617678; cv=none; b=gDOdS4ZfM/GifJklFOq3ZWfTeCMpPt/6th/oEYyUIhAlWxptdZyGH8M166HXi6njGmS/vrnY0H6tP+F7+cJ7uPQLkYqzzk1XRu7p9OBylckEXz9BSp8V69Z5TNKzx1J67rLVcG78L4JfB7vNext1bNPybIHjiToMFety7hq777o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722617678; c=relaxed/simple;
	bh=UrP3HhsatFJ/POnSxRQO4EEVsdae1qfwVXCWvxkxe0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DoWEDQjoGMEvmXXEJWON1jpgRwKfL6OdnhQ8iHABNTbX654StBRBwFUqe3F8Xn11UZtZM3/Pp9XCYHjxaR78wrRDnbT6sb7avdmeo65uE+NkoUOv/PpijnlXnGVAV9ac5bgyAnAW/X8J6P2qZ54F1UqWgTwHMgLlUupFl1f9xks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=mJDkb/85; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc66fc35f2so25305675ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 09:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1722617674; x=1723222474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrAppcAAzagZXUnPObci2usi/RqmUcn+ruLZgDFl8+g=;
        b=mJDkb/85l35UDkvE0gpAsAp8ZPbOHC0ojvq2ZjTU3EiW7wg3ZyxDIF1PAPLhmQc0s5
         s26LkjIi1GIEZDJKQ0wbgrNE7lGVegPNU+9yF8/We2Cl4GQWJk/AxrIW/VtaqEgE+fcZ
         0nIAOg4V+bKJhswpPtCmPL4heCzzqUjlshBsVX6JMQs2U3t7eik1/+ArTeO2cXRqwQTA
         wtitotroXKBRe+GwUIyXFAY/YfXOeVWFhvuROGY8MVr/123puztxDzpERM4LVcXC0zWr
         OkETCldVrceQrByci8gnjAPyP/0JpKcgswSuVaV+WlPppagWP8lgvBRIaY7coiNgQ8Ur
         FqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722617674; x=1723222474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrAppcAAzagZXUnPObci2usi/RqmUcn+ruLZgDFl8+g=;
        b=beo+bKOJ/LheOiOvZBSpbvALgloIVHpIz88TQm/nMYAL3oGRVANXW89UtfkIjcXs2Q
         /QKXRBs+Wvjr04JkNtzJYncfKUJ6x9UoQbrAkF8+9XwXQqtBd9fz3a8P6BBsQIGVLBcq
         WskM2GItiNBud/tsM+uuhP1B/8SYOZ8B8XsdKbrOdskvAGuGSkkU2CoKDQYoqGHcYFOz
         X0eVZq0LyVaYyvJNKxtjU/ns49rfZ19My5ZMQIHQ1WL8kiDRcihmKkM/X67DDJnAoFBU
         4Q2dG3DT241/EDgul64mW4YMziTAqcmtq4FOLaXr0nC1jz0q7w35XfuMACjBHFpgrjk1
         AEJA==
X-Forwarded-Encrypted: i=1; AJvYcCWQvw/I6AYB+NZfoot346a6BTcYYUwqDyxHV56cjB5hXWi5XGdv6r02q3VvukfHYlH1/9B36UH6y2r23hiR1+rpbldzsA/i/nlUJR5c
X-Gm-Message-State: AOJu0YzDM4xfBenWHdO9w7FhcYuYLUu566l+0GpMtiV3/O61fWF5vOnK
	bE+g/ysVP/ykfdaKlgjhcnkPWKQ3Et2Bkb6Nk2pyUbmIHbgJi2yNb0Mc/MDbO08=
X-Google-Smtp-Source: AGHT+IEYt+XIwdpCJv+hJ1/4V8vHGn2ZEIPipNfIFiZFUexUC8izLQsYMLzSM2ChZaQeCXsqOEIZLw==
X-Received: by 2002:a17:902:e548:b0:1fb:8e29:621f with SMTP id d9443c01a7336-1ff57bc50demr60862605ad.16.1722617674449;
        Fri, 02 Aug 2024 09:54:34 -0700 (PDT)
Received: from localhost.localdomain ([185.153.176.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f29cebsm19358205ad.35.2024.08.02.09.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 09:54:34 -0700 (PDT)
From: David Tadokoro <davidbtadokoro@usp.br>
To: jiapeng.chong@linux.alibaba.com
Cc: Rodrigo.Siqueira@amd.com,
	Xinhui.Pan@amd.com,
	abaci@linux.alibaba.com,
	airlied@gmail.com,
	alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org,
	chaitanya.dhere@amd.com,
	christian.koenig@amd.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	harry.wentland@amd.com,
	jun.lei@amd.com,
	linux-kernel@vger.kernel.org,
	sunpeng.li@amd.com
Subject: Re: [PATCH] drm/amd/display: remove unneeded semicolon
Date: Fri,  2 Aug 2024 13:54:09 -0300
Message-ID: <20240802165409.93652-1-davidbtadokoro@usp.br>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802025942.62734-1-jiapeng.chong@linux.alibaba.com>
References: <20240802025942.62734-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

> No functional modification involved.
> 
> ./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c:6463:166-167: Unneeded semicolon.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9633
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  .../display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c    | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
> index c54c29711a65..8f3c1c0b1cc1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
> @@ -6464,8 +6464,8 @@ static void CalculateSwathAndDETConfiguration(struct dml2_core_internal_scratch
>  			p->SwathHeightC[k] = l->MaximumSwathHeightC[k] / 2;
>  			l->RoundedUpSwathSizeBytesY[k] = p->full_swath_bytes_l[k] / 2;
>  			l->RoundedUpSwathSizeBytesC[k] = p->full_swath_bytes_c[k] / 2;
> -			p->request_size_bytes_luma[k] = ((p->BytePerPixY[k] == 2) == dml_is_vertical_rotation(p->display_cfg->plane_descriptors[k].composition.rotation_angle)) ? 128 : 64;;
> -			p->request_size_bytes_chroma[k] = ((p->BytePerPixC[k] == 2) == dml_is_vertical_rotation(p->display_cfg->plane_descriptors[k].composition.rotation_angle)) ? 128 : 64;;
> +			p->request_size_bytes_luma[k] = ((p->BytePerPixY[k] == 2) == dml_is_vertical_rotation(p->display_cfg->plane_descriptors[k].composition.rotation_angle)) ? 128 : 64;
> +			p->request_size_bytes_chroma[k] = ((p->BytePerPixC[k] == 2) == dml_is_vertical_rotation(p->display_cfg->plane_descriptors[k].composition.rotation_angle)) ? 128 : 64;
>  		}
>  
>  		if (p->SwathHeightC[k] == 0)
> -- 
> 2.32.0.3.g01195cf9f

Reviewed-by: David Tadokoro <davidbtadokoro@usp.br>

