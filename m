Return-Path: <linux-kernel+bounces-525537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40B5A3F0F3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB779424970
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BB41C3C1F;
	Fri, 21 Feb 2025 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CCTjV4Pp"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AD113AF2
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131395; cv=none; b=c0loNzLSsmRJKjUWGtrpL/Ryh7PKYjmCl+1RNaJ6er5eIOGKS86iOEnSJxgde4O3TjV8IrRZW6NY+ELfHjrSIfCo3fHZPyPV0N7jFNhh1eDWwsBzg8z3EbloyM52ygswHl5DyTlW1FdI7MIVyK07gv+4c5HMGbGo6vIjhT5NsVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131395; c=relaxed/simple;
	bh=QWzDwjYqf8F9AheoQ4G+bdhMrG1rMkB1FkY9QF50vog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiKQl+/hVG3oMWcDSStzocfkc0+j2L9QSBX3T3KqMEHwkIerDfnWtZAMU50i2DgnGx7KYOIQxvlbo0sTN4Gv4AuZlGmZty74JlqNzdKnfMLFPAiwJ4cp3HkVvgP2bAkIgrNHR6kndVtJhu61QURYEfShm4FExNn6GTkL/pgJ8vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=CCTjV4Pp; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f2b7ce2e5so1064563f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1740131392; x=1740736192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+bqdYT2vB++aLYRe6uuUn4Zzo34myKw/ce5O2MaFJ8=;
        b=CCTjV4Ppj3B5YBp/2w6LiyV3Qe2BKPFnWKK4S/Hjb+Oi0jWA78q4ITMyBMcw7JBrBB
         IUUKnGtkwQq5ZUnBe0oqN7GpSyI+Iu7ROi88Zzo64DwalXkZuex1oqnEpFT+BvMtvlby
         fZRsKiSYARwZ9FDDSoKTXFMLuPJFNuSId6cSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740131392; x=1740736192;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+bqdYT2vB++aLYRe6uuUn4Zzo34myKw/ce5O2MaFJ8=;
        b=iF8uYV232G7M9JRjOO+15sRg9EQRG2tdNG8OaN2ib7lPNjlp2j+GejehwexOAxnKUn
         CpqWuRyGHuhuVUXzj6Fe698nAt7cg5rsJ9EyeDB9Y4Nt3v++x0pGtI7bAmcA3w8cWMdI
         AWqufJJT/sTWAyj6B83s3ya9EW63BN3K2gJYAImiLmdnLt6yuB0yKw8BuNEUMuoJ06j6
         QRUkWsr9+gN9/8PMH4BhPOU2BrNVlZH1ZzvabrrKCeecbsAikmUOu54eCFP26/Y6wxiI
         0NQnHlUQM+XoueIaAw9QZSn7HAfwQNN83v0Fdp+bvCnPTtQQw6DkYz6zT/tFRkn6DYA6
         knQw==
X-Forwarded-Encrypted: i=1; AJvYcCWv8NQujIYRG2npplCRO0+mc+V+q8p4QnI1yp7xuQfbVEI9u8Liq3ICOH1t1joqxD/wv/eHQtmdWFupd6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOJXGWxr5zHiO+CcDFt7/BOcygVDqZZH7DcnNT9V9yZML8fSwA
	cQD6EZFxQ/db/7cQQIbEi4Jvxuesww96/GzK5lx+WTfTiI/ZgBEjpv3/2OepWqU=
X-Gm-Gg: ASbGnctCprXxvUqWjJjor/WjDlXK+N9ZAIOMZGFmaZyswyvfvPun+8bM7R10bFYh9N9
	dNhq3qXtfVNQGtCkE+Xxk72k/xCwWeyGOFAqo45me7cLnjLkUTmUQNApG6uDyLcAPDsCNcnjToh
	oKZSi4QX6EFoawK/5vTS+XqGAYkfxVAiVEWTbo0G6wR2/F5KVWi4iGdV7w0kIN8p2egCGcwFUSi
	8Y0sAOmF6TrwdwKAVG+/FJQbe8D3SgrDid8N+2MLgm+HmVHQSUCR/S3gLR5mDpLEGntQHYHx72r
	W9KTeR5efWUptBHLW/wkNlZTHx6I7knjb1xhLw==
X-Google-Smtp-Source: AGHT+IEmJ5MipungHbiWmtpuUqPEucmYmkgvTIqBEX4X1VrM8Q8aJe0Kqf+wyOXqX27kcNvBWgGf0Q==
X-Received: by 2002:a5d:598c:0:b0:38f:48ee:ddb1 with SMTP id ffacd0b85a97d-38f6e95d5e2mr2850300f8f.18.1740131391626;
        Fri, 21 Feb 2025 01:49:51 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5eeesm23289252f8f.63.2025.02.21.01.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 01:49:50 -0800 (PST)
Date: Fri, 21 Feb 2025 10:49:48 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Raag Jadav <raag.jadav@intel.com>, arnd@arndb.de,
	andriy.shevchenko@linux.intel.com, airlied@gmail.com,
	simona@ffwll.ch, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/draw: include bug.h
Message-ID: <Z7hMPIxFyd6cqbC0@phenom.ffwll.local>
Mail-Followup-To: Greg KH <gregkh@linuxfoundation.org>,
	Raag Jadav <raag.jadav@intel.com>, arnd@arndb.de,
	andriy.shevchenko@linux.intel.com, airlied@gmail.com,
	simona@ffwll.ch, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
References: <20250221050804.2764553-1-raag.jadav@intel.com>
 <20250221050804.2764553-3-raag.jadav@intel.com>
 <2025022135-aviation-evident-2518@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025022135-aviation-evident-2518@gregkh>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Fri, Feb 21, 2025 at 07:05:12AM +0100, Greg KH wrote:
> On Fri, Feb 21, 2025 at 10:38:04AM +0530, Raag Jadav wrote:
> > Directly include bug.h for WARN() helpers instead of relying on
> > intermediate headers.
> > 
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > ---
> >  drivers/gpu/drm/drm_draw.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/gpu/drm/drm_draw.c b/drivers/gpu/drm/drm_draw.c
> > index cb2ad12bce57..0a0e1eebf481 100644
> > --- a/drivers/gpu/drm/drm_draw.c
> > +++ b/drivers/gpu/drm/drm_draw.c
> > @@ -5,6 +5,7 @@
> >   */
> >  
> >  #include <linux/bits.h>
> > +#include <linux/bug.h>
> >  #include <linux/iosys-map.h>
> >  #include <linux/types.h>
> >  
> > -- 
> > 2.34.1
> > 
> 
> Does patch 1 break this file without this patch so this series is not in
> order?
> 
> I'll be glad to take patch 1 in my tree, but I don't want to break
> anything else.

Yeah looks inverted. In case this is all there is I'm happy to land this
patch through your tree, that seems like the simplest approach.

Acked-by: Simona Vetter <simona.vetter@ffwll.ch>

Cheers, Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

