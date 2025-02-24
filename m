Return-Path: <linux-kernel+bounces-528032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CECEDA412AC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 02:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 602087A7810
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 01:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272B51537C8;
	Mon, 24 Feb 2025 01:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITfsYMlC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D36802
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 01:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740360999; cv=none; b=hgvvPcQD1Rh80aLe3fnCEfS5LVfYX0CRopSnhRA45OEgQgJlHA+Lx/Z83k7CxQ52VwzBa12V+UB4uvYUaKbkuKPhM9/O05UcMFTuoObiJglTJYNTdguhtEU+X19fcF54Dg+uMv5BS1JWrLXcVmyPadyNU05ZzhGizLyfnSdw8I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740360999; c=relaxed/simple;
	bh=xotTqisRghDcxyjI2q2t2iC1Av+pZimZy4YwMWpa64Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O9Pl0uM93jVX6womYW/0U3dbhX+cn5mIuqBdgynLTsrrnniEdag7qzaRgPwgxY0eYomfSAzu60Lr8iNcAWIQd0rqZDgD8oGEHWElmCTjlJRL72FCGJan9xlkMNVQm41XbgRWO9TrL/bT4sMKPDVRmzRwJv3MImbmurh7A70Ndas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ITfsYMlC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740360996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xotTqisRghDcxyjI2q2t2iC1Av+pZimZy4YwMWpa64Q=;
	b=ITfsYMlCxad7+W6ZUA56k42Iboq9P7Y8/hgEZFbVV1xhbFab547ENrb/BK4S7UdJiXff91
	ONiMNSSLBvd2HEO+3r9Xyl88xfeC5zB5cqFAANOZAf/oE12/mPrRZnQ0jUjPeHGy+yi2Oa
	eBwOm59u4kTdIpQolSIHOI6yqtp1Myk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-dZcGk1qDNlKv6u0ZekN2Ew-1; Sun, 23 Feb 2025 20:36:34 -0500
X-MC-Unique: dZcGk1qDNlKv6u0ZekN2Ew-1
X-Mimecast-MFC-AGG-ID: dZcGk1qDNlKv6u0ZekN2Ew_1740360994
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fbfa786aa4so7864941a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 17:36:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740360993; x=1740965793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xotTqisRghDcxyjI2q2t2iC1Av+pZimZy4YwMWpa64Q=;
        b=Pnlnuvr4XFzTS9CBkpQUwRqGAai+wKwRMC4bITkruHUmUfPHclXxynwymVGlZ7ay3P
         jOToztSAJReNPwlyhp3ic9watQx6BYpFvMmbfsnyscI1PwfYQjswCbcn/3eKpk8IPIOL
         uJcfg8n/c10opPX0lEFLorHqxVgWdxbQNUANQGhO35xPlCc/Y/8Lx9O3bEhB65+j8IQH
         n4j3vZGhOQ7tGbOjch2GrX4cITHBxQyWcZFtGGNaBcsCRPwF4+xWt5Mo9cGtkW7KEUMC
         cRs+zM4N+7yiF8qlpJpJl5TKKENpcO8ADjrU7glJBibqGWJboQKiMwnL4XZGZ/Tk/dOC
         z6JQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/CdFwLNHzZeX2onv1D4/W2J87X8ihf6tuf5jobIuv/xyHe0wsj5wEoqkqdXNSg9sl38H/WaRRsuK6uEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmlHPlDDjYuMW+hm+LeoP8yHA1kjpQunbNFpXH9gv2MTLW3Se9
	qEjusOrFAsM9QcBMVHeyXlMd1CwdN9iugH2KKtEg4Xj1LEMTsCZ/5QsjXd+ya92CXGbQn/pTX4O
	MsddkKu9+mC1dXdIR6sLr70cY62tAfCYbvc42v87iFldGfIIFkwG6BJAIILC5UYRz6OaZqh1xPm
	cm4Rz55npc5BVo+mVLcKEmhwMRcuS6LqwR7Lib
X-Gm-Gg: ASbGncvMAs0q5nff/suAf/bwev2D69DDxx8hgQW912XN2VZs+IMEfBfKUUxTvrYhyFy
	OHkvg3++8ELjkoFMemEaiAHokxTucS87NkkUsmmuUfPFL9xAbXzB9Z2YRv+e3C5MAcQ7gyDpkLA
	==
X-Received: by 2002:a17:90b:4c04:b0:2ee:8253:9a9f with SMTP id 98e67ed59e1d1-2fccc97a25bmr26776706a91.11.1740360993719;
        Sun, 23 Feb 2025 17:36:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdpEZuC2ughhZHzH398Wnf911hWUS3XNFhm3aiYtLUwM/DJUati7wFDAoaJ6jggj1FoQ8gleBOESVt4o4W74c=
X-Received: by 2002:a17:90b:4c04:b0:2ee:8253:9a9f with SMTP id
 98e67ed59e1d1-2fccc97a25bmr26776675a91.11.1740360993337; Sun, 23 Feb 2025
 17:36:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223154042.556001-1-lulu@redhat.com> <20250223154042.556001-2-lulu@redhat.com>
In-Reply-To: <20250223154042.556001-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Feb 2025 09:36:22 +0800
X-Gm-Features: AWEUYZkkWiq9RM5OoXawlOjb8hi-Xzqh0EdRsTvUVm2UbTIaH-IMbmewVYe9VzM
Message-ID: <CACGkMEtRQguy5dg9X_8AYj=88DC_yn+HXPx0Lu_=e1JK02PhtA@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] vhost: Add a new parameter in vhost_dev to allow
 user select kthread
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 11:40=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> The vhost now uses vhost_task and workers as a child of the owner thread.
> While this aligns with containerization principles,it confuses some legac=
y
> userspace app, Therefore, we are reintroducing kthread API support.
>
> Introduce a new parameter to enable users to choose between
> kthread and task mode.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


