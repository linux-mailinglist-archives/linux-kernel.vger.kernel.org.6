Return-Path: <linux-kernel+bounces-280603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 494BB94CCBA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF18FB20D03
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC2C18F2F8;
	Fri,  9 Aug 2024 08:52:25 +0000 (UTC)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDAC4431
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723193545; cv=none; b=qbc5gQnWEYFMNFlPu3CPMBshXNwqpYdCTS0mB5Zu8YHEJ0x25MVQ1QrUed2Ku/xr4PLZy3hG5Dy56TfTHIcBbOKls7DYlNEYg5BgHqOr4+KIs3GozwYOq+EaFCDr9gSJjwWulxVgY5hJXGip728cgIeYkqwBWdmMKORJXEy5XkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723193545; c=relaxed/simple;
	bh=vLgz4I6Wrr/+j59mAlK2Oe6EtTSUzJLKDtuaJ2pAmFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4rniHlC7fr6JsbDQzmz+6Hqy193EDxvps13wIzxB7Nb65Ly2c5HMu/IIoZ67ldhrIkKvLFBHsR/XQDN65EtCrQ4UrpeySUmuNIrxILf8DIJrD+Qg1mUFOI/QeEvYsKTYzyNawMZQZu9T+7EXGP8qZVqjfyFOxCim9K3MHk8Rb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-49291b02e20so646913137.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 01:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723193543; x=1723798343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLgz4I6Wrr/+j59mAlK2Oe6EtTSUzJLKDtuaJ2pAmFo=;
        b=tjjGqcLgpOXU9XIWXvmxsVBn0cxSJ092So08z6a+WT30T3cRxpynKQNw5FOS4PDfqm
         tBT+qzVHzzpFeJWqApnBhWmTR+5KbTFhel+q+Aq2428qXI2AlOnCUF48m4yhAWJw6yR6
         nLqU0qdsCYzYuL0bpC3CF8zK/A+isxg66idt4ba0HtacZXxlEkoSyuapQid+z8SKmzKa
         1ZfiAwPRR9mYDp6U69EkqeCDFD3AfM/lhdRKB5B3lT5U+1Zf49uccD1y9+8i8ogBkTWT
         k6rVK4JNaqM/bBsy2KEJlwzQCHDvkPtvYhlyliEkMqU31Tv88D1MjB/bLsL6wLVxpYi0
         PMAA==
X-Forwarded-Encrypted: i=1; AJvYcCW1oTXQ4mE74dzsgjEf45aMzGMO+Ytwxba9z2PzTipDtwfXgm5lvQKWaLlWjsAX+5G9MpevH8033815CQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDnZr5CnbrZ0GfFIxVd01vOCMk5Qr58g+Z8RDaSGYgOFup8pHi
	+Liwo+Nixl+VXFTMm49RanKPlKHMw9l3127F05e4N55dCSUD8BMC9K+5wageGGiz6wl/Uf66PXH
	iVl2QQpBJsomp6WsM1PHgrlEafJp/18G6
X-Google-Smtp-Source: AGHT+IHDt4iGySwB9cb5dyfABSDX/qrBc/uh6c66pGSteqMkipqG7mIxjyHIWSn9Bg/Ml0xb/eL3lOi5kpxa5tuqkaw=
X-Received: by 2002:a05:6102:290a:b0:493:dee7:9b8e with SMTP id
 ada2fe7eead31-495d841086fmr921207137.7.1723193542971; Fri, 09 Aug 2024
 01:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808101700.571701-1-ryan.roberts@arm.com>
In-Reply-To: <20240808101700.571701-1-ryan.roberts@arm.com>
From: Barry Song <baohua@kernel.org>
Date: Fri, 9 Aug 2024 16:52:10 +0800
Message-ID: <CAGsJ_4yV6uqwiRsy-Je_WysgUuN2s6MC6n3az9aP_C+3ZKS+mA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Override mTHP "enabled" defaults at kernel cmdline
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 6:17=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> Add thp_anon=3D cmdline parameter to allow specifying the default
> enablement of each supported anon THP size. The parameter accepts the
> following format and can be provided multiple times to configure each
> size:
>
> thp_anon=3D<size>[KMG]:<value>
>
> See Documentation/admin-guide/mm/transhuge.rst for more details.
>
> Configuring the defaults at boot time is useful to allow early user
> space to take advantage of mTHP before its been configured through
> sysfs.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Tested-by: Barry Song <baohua@kernel.org>
Reviewed-by: Barry Song <baohua@kernel.org>

Thanks
Barry

