Return-Path: <linux-kernel+bounces-206057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D41A39003BF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824971F21EC1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8571922E5;
	Fri,  7 Jun 2024 12:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2ttpKj3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC9516726D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 12:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763872; cv=none; b=q2TNy/dCfn3h0lN+YYh4co/hBG8bWPIi3UQx+ja0Vo3AZiniaLL+jgYkwdZXTtlL2fKMnGEvm8hxBJM+wnBMx72K9csfDqFIDIl+tngYTRuuQnOvoE/FzY30H1X6FB+Am8Kko9cI0+SxbtvLx1k18le8DWrPv+EepI0PGfaYp3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763872; c=relaxed/simple;
	bh=84636tFOi7V39CmK5CHIpwgBqFkCWq/2F3jmW+Jr/BQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qq9Kz/IIpfAld0KEnfW4/jGPpJ3kaYPopj1oTJKPmg5fvAXDRwC1W9qSIXtgELux/Jm9uaUaNoVy3bDOCmfB0MhfuWA2emz++nT/ulOYa+c15ywAsPFYFemp9Pqlu2rlMUKyRH7/YVbog30bGV+nwADi8xm8L2YjChsBPzNn22k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U2ttpKj3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6GgoPxB/ji/Pk/VvVdpRr7XCPGmqFTWzXgM8MhOw7M=;
	b=U2ttpKj3AdG/XssSmuky/J87x0fb8NEDmGfwYyEVx66xDXv+h9224ZnskstE1fDNv0gNQt
	CdwQ2VlK8wFcokMYJT7JXxWLRx37i1n+oEKQ8qTsX0RutGJ3tTCU4CJfKwRC/D693GTgZ3
	7jyvaFaNwBemru1TKfKpxrk5njVgBlE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-kz4UlyXzNPW8sLUFB4WWeg-1; Fri, 07 Jun 2024 08:37:48 -0400
X-MC-Unique: kz4UlyXzNPW8sLUFB4WWeg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ea95d34474so16267711fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 05:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763867; x=1718368667;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6GgoPxB/ji/Pk/VvVdpRr7XCPGmqFTWzXgM8MhOw7M=;
        b=H/IWGFi75Nsso6LbuPDJeEcTQhE4qEEgvdXsprpKrIH8OPb7ou/Hb9mvEERe+gwKmm
         XCFA2JEP2JrsfCuBqRjWJZNKGXR6iFUIf8VMF5YjRilTGacVupGMvxlPSgcyvG0FWxuV
         M+Gko5e1rsDOxhjSRBsByYHiJYaBB4YiBMh73VDz7BP+qBbbMul/CCXdyTe5dYB5HK2W
         FY1JCpJJ1k1RoVO8EJRFPdvyLwAwLBBfFFiBzgPb9cH1fTzTIEkuiiV1L78em4Iz+w4j
         yMdOoGS8Axs22S+ajA1k5H0YO52QZ28Rxn7VihXk54lVIQfsGVpOr0tSPNOW0F9qnW5z
         fkuw==
X-Gm-Message-State: AOJu0Yy9ljag92bXTmRUQ212wnHtKuUeLfvieTKrrDfKl15zEMWmEiGo
	hFGdFgc3bqJvUYRhd3b0xSch78G3HgQrIIkqc5DOxrAJZcIpBqU9I3NzfIsnEy3WQJiEXP86Q38
	hAs8+Kryhozk6mzHSdGl3MIKjSPvYE8qa38OSSpfAFe9hE0X5N9OoDc8Tuo6VQg==
X-Received: by 2002:a2e:a585:0:b0:2e8:60e2:3c8d with SMTP id 38308e7fff4ca-2eadce3446fmr19304471fa.12.1717763867334;
        Fri, 07 Jun 2024 05:37:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfdaDQLfxYRj9whdTwklDrvhu8U+rGdl3eDPKZ3aGGJAVI/BLPDYqbPnJxlvXYfHGILxaEvA==
X-Received: by 2002:a2e:a585:0:b0:2e8:60e2:3c8d with SMTP id 38308e7fff4ca-2eadce3446fmr19304321fa.12.1717763866905;
        Fri, 07 Jun 2024 05:37:46 -0700 (PDT)
Received: from localhost ([91.126.32.244])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5fc12a2sm3923992f8f.104.2024.06.07.05.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:37:46 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Jani Nikula <jani.nikula@intel.com>, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, airlied@gmail.com, Jani Nikula
 <jani.nikula@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] drm: have config DRM_WERROR depend on !WERROR
In-Reply-To: <20240516083343.1375687-1-jani.nikula@intel.com>
References: <20240516083343.1375687-1-jani.nikula@intel.com>
Date: Fri, 07 Jun 2024 14:37:45 +0200
Message-ID: <87tti5j5d2.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jani Nikula <jani.nikula@intel.com> writes:

Hello Jani,

> If WERROR is already enabled, there's no point in enabling DRM_WERROR or
> asking users about it.
>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Closes: https://lore.kernel.org/r/CAHk-=whxT8D_0j=bjtrvj-O=VEOjn6GW8GK4j2V+BiDUntZKAQ@mail.gmail.com
> Fixes: f89632a9e5fa ("drm: Add CONFIG_DRM_WERROR")
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---

The change makes sense to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


