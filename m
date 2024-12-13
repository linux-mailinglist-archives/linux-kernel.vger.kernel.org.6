Return-Path: <linux-kernel+bounces-444244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FAC9F034A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 04:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFDBF281163
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 03:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C159161320;
	Fri, 13 Dec 2024 03:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxcD3OnA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B781C7DA62
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 03:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734062086; cv=none; b=ZT7SDlsZ4zQqvmQiRlB8QYA/ylM8SeXqHrZoL62tOi5H67swPcRgS09vTqG5zRn94MvpEzU8kAZaWIUFo6RrUaoLNIVr6LC/Zfwzl5Z/2ekbgt9ajkKoFx4ShepHVRNeucAIjhvW1strgJbUpmTmRes1TCAQNkfznHfL64uafto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734062086; c=relaxed/simple;
	bh=6L49LIDBnPtAmFf9YVbV95zViPnHl/I9PqKvrSf2KzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btJJZ9C9t/ODzVRrmzbDk6eEpmKr4C5EpmZkIKNnX5EcA0BDXcz7/UtTiWhJWkSNbldKVrRhfispOZMyJJ9I04eDHrRJvUfCAYWD3jK9onw3L4vFx8v7sFjzAj+6pjPUpmgL+6Hf1HajNI5nDxETfJhCzqe/46rGzUl0v84PYGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dxcD3OnA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734062083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6L49LIDBnPtAmFf9YVbV95zViPnHl/I9PqKvrSf2KzA=;
	b=dxcD3OnAw8e36Lpt5lIMgblp0rSxoYvGpY03A4BZDq9nHD6SP1oNAteW1sKGKZOEc+4KHh
	H+bwETDrH8KXK6uUrDkUgZhCU8SRZzMnYmter3y5kV1bMXz1SJibYZWMrCHj3BnM3KJrsO
	3ObdyPsa5S7UaTUKiVp2m3FthCU3H/U=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-lX08KaXzM1m2D3BF65snUw-1; Thu, 12 Dec 2024 22:54:42 -0500
X-MC-Unique: lX08KaXzM1m2D3BF65snUw-1
X-Mimecast-MFC-AGG-ID: lX08KaXzM1m2D3BF65snUw
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7f80959f894so2088609a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 19:54:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734062081; x=1734666881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6L49LIDBnPtAmFf9YVbV95zViPnHl/I9PqKvrSf2KzA=;
        b=LRYMEs05lryngCXUeBA0IvY9luAIHgSKA/QdxvcaPoahT/YkFTDAqz99vGwVoGZPax
         VWRni/Zbqgw/zLwGe77w+8phw6CpqcbnWumjuxDL9P0e6QurcfJK2pHKN+rjvLpUqFdP
         cma6RtSIZNJWBAwkPvt++uBOkIs6JHR2+oduHsbiNJN+P45fO8Dk2jz4Fn3jh2YWzTI2
         q+/hKHd7CyrRmrW4cZl85ktSneJzduG8WbGv90wUJBJB4vZEOlfNG7ebiy4HmmarSo5l
         /fIwZBfZ2DAOqWV+6YvmAoyOOjQML/uSKr5Z9wseQvFlYh7JdSLLlK+ZJwD1Jyus7B6r
         le/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZwHMW1y4+oDzTaSQhLsqQA/DnADp9pj3tKS1JVOdGrqIt18+BF5W8zNI//1KMFyeBtwInNIq0xXmlZHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyORhY1A8m1rh5m7TLXCdHbSKdzc/FEATM/YYtwr8DpUrTQLvV9
	rEg41p+NGxh+OY1exixgJMYCEX5kN3Kyv9XzsNRSlaGMi7e8ja+BYLo1mTNRTnZgtAP69FH6OOA
	skz4Sa9fqisng0JnKcQA1uqnAX9rP86/Eh7497t98v1bsMxxWJaa9oF/M+gk+6nMZOXNPpWszJF
	k3X8zCasFDxQYtCFaY//hXQ8JxuOHRxESK3XzP
X-Gm-Gg: ASbGncsQ876vqxqhP61fLCMbvtnbLVb3E9uCGTAoZDFekz/uNHutE6NFXwj/DV+oB3U
	m/kXvgZXowoCSQYSynt+6j6oEmyx6reyMMk+8fzc=
X-Received: by 2002:a17:90b:1c03:b0:2ee:9229:e4bd with SMTP id 98e67ed59e1d1-2f29153af6bmr1438483a91.2.1734062081244;
        Thu, 12 Dec 2024 19:54:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8woS+FSzGPbZaXG/65WstiqgVlj19rVJ9CgQq5B6jZDC+MUUXTBy8QYoodj0m1qywxCN3pvydmNyh0wUIz2o=
X-Received: by 2002:a17:90b:1c03:b0:2ee:9229:e4bd with SMTP id
 98e67ed59e1d1-2f29153af6bmr1438465a91.2.1734062080857; Thu, 12 Dec 2024
 19:54:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209151427.3720026-1-sthotton@marvell.com>
In-Reply-To: <20241209151427.3720026-1-sthotton@marvell.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Dec 2024 11:54:29 +0800
Message-ID: <CACGkMEv5fNRPebMWpUSjdPtxn100egGT0bikYe2=P14Rwy9JFA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] vdpa/octeon_ep: enable support for multiple
 interrupts per device
To: Shijith Thotton <sthotton@marvell.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, dan.carpenter@linaro.org, 
	schalla@marvell.com, vattunuru@marvell.com, ndabilpuram@marvell.com, 
	jerinj@marvell.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Satha Rao <skoteshwar@marvell.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 11:16=E2=80=AFPM Shijith Thotton <sthotton@marvell.c=
om> wrote:
>
> Updated the driver to utilize all the MSI-X interrupt vectors supported
> by each OCTEON endpoint VF, instead of relying on a single vector.
> Enabling more interrupts allows packets from multiple rings to be
> distributed across multiple cores, improving parallelism and
> performance.
>
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


