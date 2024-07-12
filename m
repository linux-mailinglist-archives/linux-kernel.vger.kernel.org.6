Return-Path: <linux-kernel+bounces-250855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA75E92FDA7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D0D285441
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C60174EDF;
	Fri, 12 Jul 2024 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pvq7449h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A100174EC8
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720798368; cv=none; b=VgCNGXG7/VHgvw9M0O3ryXEXbNKmQxOZcpCZmtotj3IUIMBYswv2dj4IBlphy5YxWXbYDlE5asIxalv1yGe7xpr4YaH522OVOo7BTPjDRQLzfovbwhiXxUcS+0wBqWg/0xU/g9qmruZqP6H3cWN80mKNYNHWQrx6AofZkQz0Nfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720798368; c=relaxed/simple;
	bh=ykurxgkKshUAh4zNAKMa/tJIoSjpi6lHqJ00J6sTWAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWUvTh9tWPSPR/JrazlRyjYb7IRakzz4OARlco7hLqLZ3D8iDwj+kOJ19ATWZmAgiP6ZvhPRDoLV6xWzVqABmMdHZecXiid4+2VFeHEtw4qFSm4jN4N6LgwiWY1a1i05pigPHH6Ls+1RV5HtqYLuJuyCEYlM+ZO84X7mQs2iQXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pvq7449h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720798366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IEz8WMihH5dvgSwOSmQJ46Poh9tPzMYsjL7lTQ558D8=;
	b=Pvq7449hJevV+D5WDEw/PI0inrxEWm6kibwb7/TpwhQ0jT2Ty/bbk+Hn66oNxRj3UYWzDx
	x61WXMLHyw6mIuMHMWuhRhgWoYl4IOzpWUFnmV7qYl+c5tQmOJ/inyk9BIUV0Ohunu7t2W
	UXsxMvw7H8K7Tjkx2FDkx/0t58Rj4Oc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-RGURkUToPSeZZ1uI8VznLg-1; Fri, 12 Jul 2024 11:32:45 -0400
X-MC-Unique: RGURkUToPSeZZ1uI8VznLg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42668699453so19728625e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 08:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720798363; x=1721403163;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IEz8WMihH5dvgSwOSmQJ46Poh9tPzMYsjL7lTQ558D8=;
        b=F+aTD7KNB3y2ielUXOoX5dmEpvHhy2E/KDswzS/CZGYMJD4FomESJ7tW1LMhbyd9DS
         URv/733GoqrCIsUZzUR87V5lsXG4Q6TeaB8RcSaviquZzG0OZcpPZj17M9epcnIWQ4+8
         r/JT2IQjYGc06bDF93frvASA9N0fkkh9O4CLmZKU4nl6pYZuF8FG9YGFeIAV74Ve/Z9y
         /kx/D9tK6pgBSI8CJoCDhQUof/UHfyBOD+5gp5Clj1ywrBmFbjPUb8CTgLTvL55MFSy0
         hHVA3MHDYwNvvVYae532AcPRnJB84PVrczfWzCpDtqnkaLJfwXO3JR/8PMXJoLbj5eWX
         vUvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZUCRcHO3SeGXmsn8WWCc4BR92ZFfQf9incnm4cA9UnrldewHefUbkwqLNNzw9n68rShbx1UD7eYFjuAOS8eJGgXKgwDWQ7rFuoreq
X-Gm-Message-State: AOJu0YxeKp+584ngMKnrDEZVUTWmsrnTxoN1J5vllrAK0HBtF1G9houi
	EMvR58+C2bMs2dFa8rNOMYpglroeXHcSPnQijhlJs2K3zxwyuehWYx6eHbvvrGNRNQUoLjfM5fj
	Wok9JL6EBGRssf9y/3DoJFBDDghajC5ugaWUAVw9OnVVXUIBIyDygSoZTtPBqmhOODrzC/A==
X-Received: by 2002:a05:600c:2d84:b0:426:5e8e:aa48 with SMTP id 5b1f17b1804b1-426707db6d5mr103615675e9.22.1720798363156;
        Fri, 12 Jul 2024 08:32:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBacZIavOtT2JsUQI/j71t/YaxvZW9vrhlVVDFlkJPuemKNmocYH6M4zKWmAbtWgl9yPmxGg==
X-Received: by 2002:a05:600c:2d84:b0:426:5e8e:aa48 with SMTP id 5b1f17b1804b1-426707db6d5mr103615495e9.22.1720798362825;
        Fri, 12 Jul 2024 08:32:42 -0700 (PDT)
Received: from cassiopeiae ([2a02:810d:4b3f:ee94:a4d3:4896:56d4:f050])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab161sm10420558f8f.91.2024.07.12.08.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 08:32:42 -0700 (PDT)
Date: Fri, 12 Jul 2024 17:32:40 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Steven Price <steven.price@arm.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>, ojeda@kernel.org,
	lyude@redhat.com, robh@kernel.org, lina@asahilina.net,
	mcanal@igalia.com, airlied@gmail.com,
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] drm: panthor: add dev_coredumpv support
Message-ID: <ZpFMmAEdqo1dhj0s@cassiopeiae>
References: <20240710225011.275153-1-daniel.almeida@collabora.com>
 <fe84a028-01a8-4987-b1b7-141fb76d263c@arm.com>
 <4344B22F-D859-4C64-A351-69FFB5208362@collabora.com>
 <ZpFDeajsuVONbSYJ@cassiopeiae>
 <0A0C1EFC-29A1-4D73-8B02-CC1C693D6A7A@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0A0C1EFC-29A1-4D73-8B02-CC1C693D6A7A@collabora.com>

On Fri, Jul 12, 2024 at 12:13:15PM -0300, Daniel Almeida wrote:
> 
> 
> > On 12 Jul 2024, at 11:53, Danilo Krummrich <dakr@redhat.com> wrote:
> > 
> > You could also just define those structures in a C header directly and use it
> > from Rust, can't you?
> > 
> 
> 
> Sure, I am open to any approach here. Although this looks a bit reversed to me.
> 
> i.e.: why should I declare these structs in a separate language and file, and then use them in Rust through bindgen? Sounds clunky.

The kernel exposes the uAPI as C header files. You just choose to do the
implementation in the kernel in Rust.

Hence, I'd argue that the uAPI header is the actual source. So, we should
generate stuff from those headers and not the other way around I think.

> 
> Right now, they are declared right next to where they are used in the code, i.e.: in the same Rust file. And so long as they’re #[repr(C)] we know that an equivalent C version can generated by cbindgen.
> 

I'm not sure whether it's a good idea to generate uAPI header files in general.

How do we ensure that the generated header file are useful for userspace in
terms of readability and documentation?

How do we (easily) verify that changes in the Rust code don't break the uAPI by
due to leading to changes in the generated header files?

Do we have guarantees that future releases of cbindgen can't break anything?


