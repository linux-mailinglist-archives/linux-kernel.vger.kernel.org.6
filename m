Return-Path: <linux-kernel+bounces-312595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E85969891
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D22A61F23E77
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23281AD268;
	Tue,  3 Sep 2024 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6JFqxfP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE5A1AD25E
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725355065; cv=none; b=MXfv7Y++pF0N4tid6HE02Eu2J94jGzxQ/u41HleivHK91ikBLLbz/3tkoBFAStVVpxng8xb1r3thoM1Vee57obJe1D26u0c7A0dNJo7sQiWN61CeGs/IaEo1ULMBW2/7ZQAdPxFt8wVKyRGNmfYHi7Ij2BLuo+Hj/rDzv+Ap6IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725355065; c=relaxed/simple;
	bh=xPOB/Td0YOX7rUyJhql0/J3I8D/m/0TzQpE86H5G0Jk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qVnrvPji+Ub+COP6eJ1bm/IoIsWyrnuUhnGxqfSVRuHZLHT9Thu/Y+y+vlGsNiWo0ZxlVcJZHwkE+5W9BWeSaIriBwX2e3JMCjP9J8esNxRxlwawuOqgBPvLZ86IXVoIRTV/v+DI7zZ8WS56Bj5l5R+E+cgZ7XunmwkVDnITD2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a6JFqxfP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725355062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d9X1NNLzucsrIUJA/W+nkx3jW6oIqsnKng1xNjblM64=;
	b=a6JFqxfPzFXBAJ6f601AKSO6d2x7GnFWnevFRNupPWw4MLPuSJ37QCXSBtX2R07XyYSKib
	YqTa/rLHU1OEhr+RADvWcq1FUVUNZUUBupSSCyuDzlOZ+RMAebAonXanle+g274unNu6xp
	wHhU270BVolF7eSqlJxznsAGu3B/Cjg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-4kQLyKVePTCGr2IPiec1vg-1; Tue, 03 Sep 2024 05:17:41 -0400
X-MC-Unique: 4kQLyKVePTCGr2IPiec1vg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5334e41c3acso5017919e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 02:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725355060; x=1725959860;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d9X1NNLzucsrIUJA/W+nkx3jW6oIqsnKng1xNjblM64=;
        b=nIoLqHTn2DIxk6Z+/GVTyAVMiPANENvoplCf72huVZPPNvH3mIfwq08+WovefRxLwA
         Oy4dKZbUn1SnIiRinhZT3gZBUFhS0EtV4lng/UPfHquoVsDSTfTIjhvmw/U0hZ36Vd/d
         Y35BhWNXaCrEPm4RwbbHu7W1O+hpyqmgvh2YzsELWTDkDqZdrZ8i/eVHDg+7sEP4tliu
         zPO0kl+HzijMIc9bmchLwhHtfcd/TQKYNLkz8g49ac0dgBAmJyyqY9H3CKsMkE3/B2zD
         UA8c2LIWAeJ+Ike/0OxiVGZF7BZxl+pA7SSsHqqYYv7KpvwF+HLZPIaoSFTZsqlbYWmx
         svOA==
X-Forwarded-Encrypted: i=1; AJvYcCXFppYvVuC5JTF1pzF/kYj1NETdGAg3pzeK6oQ9Q2hVrxVDK7OVZ2DgsDj9e/O7lNE32Ca9jxB5LUWx80A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsdy2gxIkuCQbRrBUwuoShPu/9MoOIi3Tz4H8GPKQXc38q4U8n
	lJjkwPtCz7FGSbQonkTpeSc4BFZIZIm6gEAAfRcP+Zjm9ybORGPk3TjoicdCslVNZhD6GCVmQQ2
	X0fDEZxVXDq583boPoLyHgIJUEKyO1SJu5z4mX55XJs591RZ4WymdfpsPXYOoDA==
X-Received: by 2002:a05:6512:1328:b0:52e:7656:a0f4 with SMTP id 2adb3069b0e04-53546b93f39mr8985509e87.41.1725355059626;
        Tue, 03 Sep 2024 02:17:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3xeKyziMqcDCx9+tKLN9bJxYrhVG6uCV34wc0/n7HkAIUcH0MBCdLafl7DwaQE1ysW+KWKQ==
X-Received: by 2002:a05:6512:1328:b0:52e:7656:a0f4 with SMTP id 2adb3069b0e04-53546b93f39mr8985480e87.41.1725355059058;
        Tue, 03 Sep 2024 02:17:39 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bacaac810sm183985045e9.33.2024.09.03.02.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 02:17:38 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Abhishek Tamboli <abhishektamboli9@gmail.com>,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 daniel@ffwll.ch
Cc: quic_jesszhan@quicinc.com, skhan@linuxfoundation.org,
 rbmarliere@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: hx83112a: Switch to wrapped mipi_dsi functions
In-Reply-To: <20240902170153.34512-1-abhishektamboli9@gmail.com>
References: <20240902170153.34512-1-abhishektamboli9@gmail.com>
Date: Tue, 03 Sep 2024 11:17:37 +0200
Message-ID: <87plplgkpa.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abhishek Tamboli <abhishektamboli9@gmail.com> writes:

Hello Abhishek

> Use the new mipi_dsi_*_multi wrapped function in hx83112a_on
> and hx83112a_disable function.
>

IMO commit messages should explain why the change is needed and
not just what the patch is changing (for this one can just look
at the diffstat).

> Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> ---

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


