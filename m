Return-Path: <linux-kernel+bounces-218834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E76D90C6D6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455511F22AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9BB143865;
	Tue, 18 Jun 2024 08:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQ/TnENh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADB213DDAC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718698249; cv=none; b=ojTAElTd4Pq5SEDG+0benWc+eH2TV7kpq6MgSKrl5fTpBGVW3qiKjzCYVHtqcr7oMvoZfzGsnJcOtHl/TgyrMb0STJa2njXHVwhoNPeD6X6hyYJwrHH8hqtzTLT4gqYtJ9KtBSWk67ny/UH3XsuA2JJbVKtoaSyI7nstRy9wKiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718698249; c=relaxed/simple;
	bh=QCWRJZJr4Tdjl6AVZ/clpTWi5kNIaNs6ny/W36aLeWA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mGfRH9aRrfHutYERSRr5UzuZHED7ZL/Bt3DoYudBXzBW7sWapFQkLOCv1zZr2d+8AnPlgkkwASRviJVKdNBIcJec2IHiGfcN2mpuqmJpvlMIIIXUEOt5JhI4+ZT9YogyI9NaDUWp2mUvLh73fjt/F52t1KuwDGcwP+T+RnzzVjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jQ/TnENh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718698246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Um1eLXbNm7/kO9kxYoAyA7cpz6u+PzGiTgv0zhQ+dT4=;
	b=jQ/TnENhisysgy4z1bFrCgGo6Q7PbG27Bfd1leKjoC93GeCZpOu3zEJ9PJ3SMWpPXqwVPk
	PDz/pCYC8HjRyZI1hLPsohQ5RxQvosak6L7qR+bxjPFWQIeWL1n3LDpvk1Z5K44c4U7EmZ
	rqk1bJscMUQYpvSL7HhbghNq9fWSwKI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-NrtV-halPKi1F_lLhoUnpg-1; Tue, 18 Jun 2024 04:10:42 -0400
X-MC-Unique: NrtV-halPKi1F_lLhoUnpg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4227e29cd39so29454755e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 01:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718698241; x=1719303041;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Um1eLXbNm7/kO9kxYoAyA7cpz6u+PzGiTgv0zhQ+dT4=;
        b=bUiVYT7Z9WcA7NVQ+UUseVZR0GUfPPbhA4P2/YbAxDyK5Inhi7yVzt7/ofpYBi6S+A
         +/KT4JZuSUF2qLTylFakMkV0/8eod7EYfr+i7US4wFVqETizkYy2Uu79witx83eUrEXi
         5pvCXv4hYaOKJmH3QMH2+okOEgSGh8TJsjpR43aINzITd6ROJcOqWfuwCBPGd2OhJbfB
         0Wzdu/C6sRD9+9bVss4+SAqJUPH/s9YH1I5n7GGPk3Duri8CHZ+0pOB0JfQQqndLdoTY
         Fn6tHvnQ4Og3DkzKSR35pYR9z+2k+xPj1s60G8ubwdXxOnw4uULhWbf5Jtjl1NZ8bL6P
         VD3w==
X-Forwarded-Encrypted: i=1; AJvYcCXszWSy7ViwbHu5n3zdu0QtHa1HdsMLErQ7SIhwR8dkZHa+T6PJd18pVNXsxwPYkntzeQZil9mssz4/odmWJR9G0inMpw3MhB38lArO
X-Gm-Message-State: AOJu0Yz61yWhUCZzQuKUtOpREP3MhauML2mwo8a5u7cMzSkHTVIk8FbP
	1Lc81ZqHO3a+zH3SPEwzAoWs1QHt/bW3hDKd1nSWJISbZkR3hr7CmdAJrAg7DLBYfK7GI7kugmN
	NJ2HcXsGTmTLCu08rM3pIIZwb1pPVot/IYJo93Y/HBLDx4Y9u6N6Cz+U5I7lAww==
X-Received: by 2002:a05:600c:63c7:b0:421:7e88:805 with SMTP id 5b1f17b1804b1-42304854f53mr106111425e9.35.1718698241431;
        Tue, 18 Jun 2024 01:10:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGujlRvR3wLYaDhL+bjHS0YMSIKJQPeHPyGKXuWssS+5GLM1BTKQbjeA6ZgLAn4CXaK4hTlzg==
X-Received: by 2002:a05:600c:63c7:b0:421:7e88:805 with SMTP id 5b1f17b1804b1-42304854f53mr106111215e9.35.1718698240907;
        Tue, 18 Jun 2024 01:10:40 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c8b7sm13517206f8f.26.2024.06.18.01.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 01:10:40 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Aradhya Bhatia <a-bhatia1@ti.com>, linux-kernel@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Daniel Vetter <daniel@ffwll.ch>, David Airlie
 <airlied@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Tomi Valkeinen
 <tomi.valkeinen@ideasonboard.com>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/tidss: Add drm_panic support
In-Reply-To: <1d914332-9300-4dee-8d33-0a806cb22aa4@ti.com>
References: <20240615085326.1726262-1-javierm@redhat.com>
 <1d914332-9300-4dee-8d33-0a806cb22aa4@ti.com>
Date: Tue, 18 Jun 2024 10:10:39 +0200
Message-ID: <878qz27jsw.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aradhya Bhatia <a-bhatia1@ti.com> writes:

> Hi Javier,
>
> I tested the patch, and it was good to see the panic screen on SK-AM62.
> Thanks for adding this feature in tidss. =)
>
> On 15/06/24 14:23, Javier Martinez Canillas wrote:
>> Add support for the drm_panic module, which displays a pretty user
>> friendly message on the screen when a Linux kernel panic occurs.
>> 
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>
> Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>
>

Thanks Jocelyn and Aradhya for the review and test! I've pushed this
patch to drm-misc (drm-misc-next).

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


