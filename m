Return-Path: <linux-kernel+bounces-327305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E659773C2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 23:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B711C23D8D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5D019C562;
	Thu, 12 Sep 2024 21:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MfLT6cLC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3331C2325
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 21:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726177502; cv=none; b=T4acF7kvYheN2RbwSYhZXVRGn8t5PQgZJI8SM70rN+dWHXqn/SA32/dlLLA4AWEpiCjjDFtQgmcBbP26hw5qjjW+LDOh+KNtAR5oi1jsLQmyL0WWmOUtmunusXPUDmwuhQJiy/JR28/DCvJHP3JnOwhaOexn9Dce19+i6DwtAgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726177502; c=relaxed/simple;
	bh=YX9Sq1P1x68PKmsIgRtlVGwnwcsUwX46fD5A58fpkCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiQ8uqcl5mlTPY4EyrGL3VEgRTT+tM725dsbUq8yUtkqI+tsgxd75kS5AJI1WQjaecWv37Ls/zgflz6zsuEK2bTSxWKRCDqjE4pzmhsCOa/iKRHiD0IZYjL+WTvTOfTo8sktyJIaSPkqNtmwG7/sVl+LphO8Fj4tKbLMKZSO7Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MfLT6cLC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726177499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LdWPfLJMdgjvfegYvi5NNo76eeOdhcq5LsVGADnslwU=;
	b=MfLT6cLC0AGx7KqCMwJVylhtFWxSGtRW/pfP4QGZCjrY5yO5xY2OxVZ8wy9DdQA8B0s/tH
	mtYgT2hurborTV2xBtFYN/L9+2w7uagSPS5D+EBbn1E76x2NrB8sRTYs4JqHCr3ihvJB2W
	/TafUcctu2B6obUk6PfcCK5H0LSvjic=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-D2TS7IGmOMmRelf0paACww-1; Thu, 12 Sep 2024 17:44:58 -0400
X-MC-Unique: D2TS7IGmOMmRelf0paACww-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6c37028ee66so28853306d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726177498; x=1726782298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdWPfLJMdgjvfegYvi5NNo76eeOdhcq5LsVGADnslwU=;
        b=gHn2fTrfIC20F+n5Cn2+tl5pKfGU8pNy5hmn82d2ipRRKi+Y968ejsTH19KfjkHzu8
         EpVfjxgLJqd2MfQ77aLIUP6So2bzHqkCyPAIXuz5LoleGhwLNOSuEA+JdbD1D0WvYpIs
         oo1QPR+6W/mwjw55FccYWdPNAeTpGB83ODQSHhD4dGMvcu5oQHCKz+lxFfIGXWO8zHnM
         lM5XY2o9PfiRvMAPr+SDBpKlYevtLPtNhF7cTB/lo3fcmAgyYpVQqq6lIgoCpCVgXhPA
         bVw6k1MMqWcBdt6rlsSzHlLUF5W5nWw8e7vSsx2M/HJ89nfXTjKQXfHvpWCkqg+qTQoh
         m5aA==
X-Forwarded-Encrypted: i=1; AJvYcCViPNLHYoHfa6wae6VFneKMaNRSGa4pvozgGJZvVBrgDnBB6bj25FX7gH0KM1qwUbpIkg3l6RLHteMoMPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNjDAe94GvXkM0j1jdhXg0S9Gspn5zgOBvjlDN23Pd9VylOtK3
	2OVDqaW6RpqZVllMuY3AMb+lC89Bt4JgmZZfoZtKnTHP6fgRqzkxNPJJeuqMiYt/odZ9t6HbT4W
	2NdWcMssj5L+F/RVRMNzcwLfJXjK55A9UlhLcCQEcVTODg/6bnQ3Uq9U/14MVQw==
X-Received: by 2002:a05:6214:3c8f:b0:6bf:79e5:b129 with SMTP id 6a1803df08f44-6c57358f603mr67686766d6.49.1726177497674;
        Thu, 12 Sep 2024 14:44:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE/NWkPqwUt7Wnb8G+NCwIzrvRbMj/H8FdfBBi21HmBardcXcnuVFiEXhPR/VFHQFmrZ602Q==
X-Received: by 2002:a05:6214:3c8f:b0:6bf:79e5:b129 with SMTP id 6a1803df08f44-6c57358f603mr67686556d6.49.1726177497294;
        Thu, 12 Sep 2024 14:44:57 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c5343296a4sm58893506d6.18.2024.09.12.14.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 14:44:56 -0700 (PDT)
Date: Thu, 12 Sep 2024 16:44:54 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Devarsh Thakkar <devarsht@ti.com>
Cc: jyri.sarha@iki.fi, tomi.valkeinen@ideasonboard.com, airlied@gmail.com, 
	daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	praneeth@ti.com, nm@ti.com, vigneshr@ti.com, r-ravikumar@ti.com, 
	j-choudhary@ti.com, grandmaster@al2klimov.de, caihuoqing@baidu.com, 
	cai.huoqing@linux.dev, colin.i.king@gmail.com, javierm@redhat.com, 
	dmitry.baryshkov@linaro.org, geert+renesas@glider.be, laurent.pinchart@ideasonboard.com, 
	dakr@redhat.com, u.kleine-koenig@pengutronix.de, robh@kernel.org, 
	sam@ravnborg.org, simona.vetter@ffwll.ch, ville.syrjala@linux.intel.com, 
	wangxiaojun11@huawei.com, yuanjilin@cdjrlc.com, yuehaibing@huawei.com
Subject: Re: [PATCH] drm/tidss: Add MIT license along with GPL-2.0
Message-ID: <mdpjvdik4eu7eruaslidf35hhybswwbyd5gusx2dgxkzcaoel2@z57f3eyppfac>
References: <20240912171142.3241719-1-devarsht@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912171142.3241719-1-devarsht@ti.com>

On Thu, Sep 12, 2024 at 10:41:42PM GMT, Devarsh Thakkar wrote:
> Modify license to include dual licensing as GPL-2.0-only OR MIT license for
> tidss display driver. This allows other operating system ecosystems such as
> Zephyr and also the commercial firmwares to refer and derive code from this
> display driver in a more permissive manner.
> 
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>

Acked-by: Andrew Halaney <ahalaney@redhat.com>


