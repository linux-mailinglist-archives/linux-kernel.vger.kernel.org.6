Return-Path: <linux-kernel+bounces-434250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB589E63EA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 03:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A033D284528
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 02:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363A414AD29;
	Fri,  6 Dec 2024 02:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5HpXs5F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BBB13B79F
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 02:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733451245; cv=none; b=EEDtcgZolQLdMu17eLHYOywjmNLz8AzEuYqSfgJG3ofsc0xCWCzR47Z76y1q8KOS9wYsKEKrrbgpP1WQ3SWxfvSE0iY7UGliIV7Pqtmv4PuAgY//TB/oyLrnzAumkXTsN3GoPFjICTRmbHHwhaKNoOzwjydJepfiVHIJW5r8XzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733451245; c=relaxed/simple;
	bh=52B59EF4+Qike1E1hse4ywDaNMu5si+7dpn1ePMJmBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s02QS7z0f6tsmxPmiYbIXVo3gB9JvNC4oz1mbC549p9Q7wpS4AHiliuKXCpqIhcNMafCQvJ1uVdDIhhsHMjEh7mg+OWuGKainzplRyi5fdwUC0b3FwJFSUUkfMkZs40jdsoiYTDduOKT7L6IzIZc6yFwznlelI77q1e/YfoGBiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b5HpXs5F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733451242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=52B59EF4+Qike1E1hse4ywDaNMu5si+7dpn1ePMJmBM=;
	b=b5HpXs5FXCNFBNMJVpRmsK8M5bBAoshKQgpaDyAcMixnZ4JRA6M/a4ZSH9WhoLEIhQg419
	epPnmRnCkuV3qn1HygYeMULXotTp9EQm6+8657z+i59lyD4bvzSIgE+SClHZjF+Zg3t3w2
	ATBRq9wnwWnfYYtE9sPk8H/crAyKLbo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-UwRNiBqpMJe_NptO3fN3kA-1; Thu, 05 Dec 2024 21:14:01 -0500
X-MC-Unique: UwRNiBqpMJe_NptO3fN3kA-1
X-Mimecast-MFC-AGG-ID: UwRNiBqpMJe_NptO3fN3kA
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ee6b027a90so2396388a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 18:14:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733451240; x=1734056040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52B59EF4+Qike1E1hse4ywDaNMu5si+7dpn1ePMJmBM=;
        b=tgYgrmdl/LUDK9Iahj4hYwUNKLzq7QxNdUZmA5H5rOn6u9L666copEbiw7FAjWEsq3
         uSrIS3y3Uy98teMscleJRRF8iCrZMrfM5feFilq98a0LVIor6XObl0BQrLIouFCbtN0N
         XKVI4qtDhJNaKmGng6DnKvPwYGopqFVzhvEi3k8FAPRLu9XREsWRrZC01at7Lzp8iJmt
         0Fx8RmwVcD3vEpV3tFeK/AKdIB/Bf+dLwUexCCxqZu5KgVGKguhSOxsJIfrUY92GdJp0
         pfX3OyJy5XRSiM9okqqFyU4eXOCsoht1Ugn0YAf2b1dfwxk05+SHLkrxEqsjHK/6+qjM
         rq3w==
X-Forwarded-Encrypted: i=1; AJvYcCWjTU9TJP+xCbnGWyMk7cwe7Cyq13yM3JHlF2JWHqtcNc0PzwlxyMY5NH1DsqR+LejdTIqOPyYLhep8hKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwGGXJV+333GuUGZLHMlxWYpUNowVMyO0GzqmyS6fPuUFlf2mK
	1Fp4LVSM0XcjcFioY6w02AGcjyf8JG+dK2pk22gx4x8DNs1Dn2vZ5GRe961QqIRFwRi1QxcXDti
	Tiv6hJPqwsvQf+455T5TX25vzy1FV3brUupHq4u5Cf6kwbcdL0tAe8I3fmpOKr2hOYUs4+//pwM
	Lb2T9VzUtnfTsqbx71TE+/b+JCUCjy7P7+CKUM
X-Gm-Gg: ASbGnctdC+cMF2r9/k6OGGrYcGVXFdmqjgE9QdoqC0s2qjgEPOcpIPRxPJ4q0/qIEfF
	Q+PUBgZm3zVv08ZiLGMwf8H2aSw2RreOfLQ==
X-Received: by 2002:a17:90b:1344:b0:2ee:d024:e4fc with SMTP id 98e67ed59e1d1-2ef6ab29247mr2280764a91.33.1733451240549;
        Thu, 05 Dec 2024 18:14:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoyWBvL42D5I+BKxxZpJ8z8W7yojfHD1r0mUIPdrlJIdJf6rKoqA7FX/g1u6TBTKpROREgMAXrwnDSyeEO/DA=
X-Received: by 2002:a17:90b:1344:b0:2ee:d024:e4fc with SMTP id
 98e67ed59e1d1-2ef6ab29247mr2280726a91.33.1733451240167; Thu, 05 Dec 2024
 18:14:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121134002.990285-1-sthotton@marvell.com> <20241121134002.990285-2-sthotton@marvell.com>
In-Reply-To: <20241121134002.990285-2-sthotton@marvell.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 6 Dec 2024 10:13:45 +0800
Message-ID: <CACGkMEt0tcE8USpCefbDTU+cTO=31ABwwXg1=zbYvBjRGWXM9A@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] vdpa/octeon_ep: handle device config change events
To: Shijith Thotton <sthotton@marvell.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, dan.carpenter@linaro.org, 
	Satha Rao <skoteshwar@marvell.com>, schalla@marvell.com, vattunuru@marvell.com, 
	ndabilpuram@marvell.com, jerinj@marvell.com, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 9:43=E2=80=AFPM Shijith Thotton <sthotton@marvell.c=
om> wrote:
>
> From: Satha Rao <skoteshwar@marvell.com>
>
> The first interrupt of the device is used to notify the host about
> device configuration changes, such as link status updates. The ISR
> configuration area is updated to indicate a config change event when
> triggered.
>
> Signed-off-by: Satha Rao <skoteshwar@marvell.com>
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


