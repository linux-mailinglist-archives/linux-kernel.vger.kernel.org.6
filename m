Return-Path: <linux-kernel+bounces-547261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D76A504FC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85CAC3A7D8F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D1819049B;
	Wed,  5 Mar 2025 16:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="AP3SOuko"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65EF3B1A2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192486; cv=none; b=mmJQmwZojCVv6VnQvzUxIbm468b4Y3PFExlIXF5tCbTWRIZKt1DnQbYO3QYJ/lS1z4naaoP0V/0EoR5UrGaQ3+tkMLdX0+YYyD+Uc3PIihtPcmfW25jain3sqO8MOSfgarX+8Q1PvgjqbshfqxGP+cQGFySXO4kHqdpsdOut73U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192486; c=relaxed/simple;
	bh=F16pw37MzKbIYdgjWhyi5x7YhfEMC6EULpZEwLqrfZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDW7DnXoRIEkHOyfWIvOQu/VasIFytaelVC3GNv1MAvwpmzg7z4RamqpoUxJjZkqgc5FUzGgJyszExRCsmKKh9t9zs30jI8Gnle81Fi3uak8Y8KE3s6nTPXQ4xIY/2D9vqkXbT4tcVe+Z3EY2lIVMCUVQ/FFI2qcJbiJlXIVBpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=AP3SOuko; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22349bb8605so136761805ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 08:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741192484; x=1741797284; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oj8IVT+RqMLY39cee6JwSmbfQ9wBQwtZAQ90NgyAiPk=;
        b=AP3SOukoZMkUK35fZRglHU9Im/hlJ1nhytXEFPHUjsvlq5lNBf+Chxv4+zBJFonekd
         1PrytuKvYYdR0zM+49Cxte8lpMl67OW5euDfXWQ2WVxKmujIGgZfjmSNJgCIySIfn8Ce
         7IsrnwTxKjnN8xTOu2t9lGmn2QvYvUKTa//ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741192484; x=1741797284;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oj8IVT+RqMLY39cee6JwSmbfQ9wBQwtZAQ90NgyAiPk=;
        b=b//9Kvajp/Ye+7xxN2bbVwe50cDZ7y6fq/I/you9qngsqshwa6U4SOaiNFpgIRI2Ka
         sN+XIjlkq3M2WBsG0ULULG3ZJgWLpTVgEayX+84k5TCMgh3h7n0f1U0YQoUeu36j+ipI
         4ngYdOr/PbksjcQW6NrK/9q67DGIEk8DT2c+TFqpEnjNtKANN7LCZH0gNFsg0MyTbYDM
         bbYu1ywSr7l3DE01NkuovgWAbHW2qAOrvYZJYlNu/cBH7S44OVFq5cn3pPfy+CcYkAvY
         GJblnGnBrGbgJOWV+ZzlJSUG5LUwXK2+uTxct9worQeGeiyHzX/TG5o4dgqybInSylKI
         emsA==
X-Forwarded-Encrypted: i=1; AJvYcCXpDuGtZLC9h6U4WpzGT0POabvOgTx0eC4645EJskHgFZR6nYQ2g5Xe1d/YRdzF6k/Pm8OGz+vDS+2QNbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZFSILtvbKF495IpmfWYK0R7UyHgwM/ORpNzulfDlcdFKpeAuz
	vOgKsd7zxWpqLEnMkQFaXieZr9hjfk6O4/TCw5BzpsLEfHlWDblmpu8TagI2Czk=
X-Gm-Gg: ASbGncsPtJe76wh9Do61o9m4LmNTgCUId0VbbvzEQIl8w/boVnhg5ofmYrmxMcpZSXQ
	zXA5iiq6qpvg3scI3hnfNS7KJtm03rNaXZqiNoQH7WeC2vDi3Ws2X8RBKo1cv/vkc2y0eCgKV5A
	bvwEwL+/xDEWICmlQbiNg4OGbH+sMzugtDB8bvpBotgCcGrRGcLDvSqs8HbbMNBSaN9ujfQxdcz
	hNX2/eTNtz4vLvNYYRRAeGMwBor3YZm1PSX25TdrFOsLDo8cCDcFjkRIOGVWkgi3nwNMP+5Vbqn
	reeBDxahAHyhQJQ9oH8ZFINQ70ZNCITRxtEGjMrsjfJSDgud0/R8JgnJmj8Vs7dXWbT9e1mfdhR
	3veoCUfj5mBg=
X-Google-Smtp-Source: AGHT+IEftC9eWQqraTxiAa+hjmeMT1GN59eEFcCvKCUxzOWXFqKmPKYERLKg+VujKszgU0HOvaMZMw==
X-Received: by 2002:a05:6a00:2e9f:b0:736:51ab:7aed with SMTP id d2e1a72fcca58-73682c8c058mr6003956b3a.16.1741192484001;
        Wed, 05 Mar 2025 08:34:44 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734ec1da824sm11266744b3a.170.2025.03.05.08.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 08:34:43 -0800 (PST)
Date: Wed, 5 Mar 2025 08:34:40 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, gerhard@engleder-embedded.com,
	xuanzhuo@linux.alibaba.com, mst@redhat.com, leiyang@redhat.com,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 3/4] virtio-net: Map NAPIs to queues
Message-ID: <Z8h9IKvGh4z8h35Y@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com, xuanzhuo@linux.alibaba.com,
	mst@redhat.com, leiyang@redhat.com,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
References: <20250227185017.206785-1-jdamato@fastly.com>
 <20250227185017.206785-4-jdamato@fastly.com>
 <20250228182759.74de5bec@kernel.org>
 <Z8Xc0muOV8jtHBkX@LQ3V64L9R2>
 <Z8XgGrToAD7Bak-I@LQ3V64L9R2>
 <Z8X15hxz8t-vXpPU@LQ3V64L9R2>
 <20250303160355.5f8d82d8@kernel.org>
 <Z8cXh43GJq2lolxE@LQ3V64L9R2>
 <CACGkMEug5+zjTjEiaUtvU6XtTe+tc7MEBaQSFbXG5YP_7tcPiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEug5+zjTjEiaUtvU6XtTe+tc7MEBaQSFbXG5YP_7tcPiQ@mail.gmail.com>

On Wed, Mar 05, 2025 at 01:11:55PM +0800, Jason Wang wrote:
> On Tue, Mar 4, 2025 at 11:09 PM Joe Damato <jdamato@fastly.com> wrote:
> >
> > On Mon, Mar 03, 2025 at 04:03:55PM -0800, Jakub Kicinski wrote:
> > > On Mon, 3 Mar 2025 13:33:10 -0500 Joe Damato wrote:

[...]

> > > Middle ground would be to do what you suggested above and just leave
> > > a well worded comment somewhere that will show up in diffs adding queue
> > > API support?
> >
> > Jason, Michael, et. al.:  what do you think ? I don't want to spin
> > up a v6 if you are opposed to proceeding this way. Please let me
> > know.
> >
> 
> Maybe, but need to make sure there's no use-after-free (etc.
> virtnet_close() has several callers).

Sorry, I think I am missing something. Can you say more?

I was asking: if I add the following diff below to patch 3, will
that be acceptable for you as a middle ground until a more idiomatic
implementation can be done ?

Since this diff leaves refill_work as it functioned before, it
avoids the problem Jakub pointed out and shouldn't introduce any
bugs since refill_work isn't changing from the original
implementation ?

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 76dcd65ec0f2..d6c8fe670005 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2883,15 +2883,9 @@ static void refill_work(struct work_struct *work)
        for (i = 0; i < vi->curr_queue_pairs; i++) {
                struct receive_queue *rq = &vi->rq[i];

-               rtnl_lock();
-               virtnet_napi_disable(rq);
-               rtnl_unlock();
-
+               napi_disable(&rq->napi);
                still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
-
-               rtnl_lock();
-               virtnet_napi_enable(rq);
-               rtnl_unlock();
+               virtnet_napi_do_enable(rq->vq, &rq->napi);

                /* In theory, this can happen: if we don't get any buffers in
                 * we will *never* try to fill again.

