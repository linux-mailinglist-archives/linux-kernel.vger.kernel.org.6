Return-Path: <linux-kernel+bounces-560230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F569A5FFEF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1501B42244E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D061EFFAE;
	Thu, 13 Mar 2025 18:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsR2FsKb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F051EF099
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 18:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741891750; cv=none; b=UN/zIKyPjPhOTCeQGeuNKaqyIWaV/kWEPmj+a0ZunqXuKMZQY6SH5c74cm3mEE070CgqMiZjqfBcJ9PgvCQYx26UNRn6HfApAB9a1qRpHkeu9FyY1EQ4Qds7uHck9Zc+c+1Zt7Zg4rYjdnVtgHwFrKKDqczUMR/9JFj9cvwHXRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741891750; c=relaxed/simple;
	bh=vGaveTKeKgCxAmnC9EQ4sn2CMv/qBrgjuvuYfa1RVkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jg086jadta+51sb/1I4FWneQFcMyB94ATODwU/c4H7dKrRrKNcLTnjk1U/GCtW9L0P+GQIjFDmVyCElwqYKWCNawR25pGriu614SumYdBE7KhY4+xiYUifj4Xfaj0mEz3jMvoZhI2l46tpQEUtohMWkYP2J6wR4hHovJp7zKZ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OsR2FsKb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741891748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D9aZe+iaudDpMDo0mPe7/sxlSIcMfnUdZ2EM2OaZ1sk=;
	b=OsR2FsKbcKOIQ2NO4ex2AUaP5RsapStbiaazWEwSaJI3x0ur/4z7BSVRJy4rBGzCH0efS8
	1snKELsbtOIENb1Y8N+LZNabBmNlKE/rr1rAK4CKRTF3UpzOGvTeApt9FD5H+OTL1WSEqJ
	qRjLccObvjzXHRfrobdaIctnzZokzug=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-qlzTh5TPOmqmEFhs5n00aA-1; Thu, 13 Mar 2025 14:49:04 -0400
X-MC-Unique: qlzTh5TPOmqmEFhs5n00aA-1
X-Mimecast-MFC-AGG-ID: qlzTh5TPOmqmEFhs5n00aA_1741891738
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4394c747c72so6720785e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741891738; x=1742496538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9aZe+iaudDpMDo0mPe7/sxlSIcMfnUdZ2EM2OaZ1sk=;
        b=XGSM+sYlFKxXL4e8O53KuBw8ZBmBzsMWjMXzz8OxDBfd2Lzw+ZCcms/sC6KIL0oS5l
         VbLSSXcWtLEIWROo+dTe8e5aTZ/o2YmgpO638nYlFrTK/QQK3ZrzrqmSY/I3LPTnoeF0
         4Qbiq+bHqoiqeNgjbuNGStsA8HBWar2pyJNnLvIlssPbtnZoUwCE1RQG7HflN5b4QKHc
         lPQUZYFZJiyfvn9JapSpq/OEamUaJGvVOH6Vq1vGDElqfuD4NEGuBfR6y8qmAstLKdx+
         6tGV2oZSlY2MJYEL57HBhAvtM7ZjZHqLXs4kGVYzeRDeMHc0PgUvOjcczB0Uk0b9xFRC
         9DZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVnh+dlCrbAy99ZlT1fmPXaY38x8hmypwLc7Ps4rXo5ZeYutIB79nzqHWeo0oofmYUsNMT3TXicqRG8tE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHmV1vy/ZiaXg3TOocAwmLPk7HAnTfgHvcVz+jiKOs/ywgaVVM
	9IjOLW0QOC4RbL36rMXHOL5h8czHAOWXWh5k1Hr3PDsF0ev/gvWyq7tKeTIW9Z3br7wC1Qg1wt1
	6GojQi2K4sK/fi/nZImRPzU/W+20fUT0f9HTUMHqAuybtRfRRU5j5Uh0XL4U7Sw==
X-Gm-Gg: ASbGncu6IbtUQEJAhy80ME9yOEJwXk+Bf4+31Ja4X4dwsz8IDquezytfjmWYlK1oRit
	EgOMk9nRtO4Ivb7V0vkPVcVb9qesRxF/9IiAHebmjUM4uucZ0ztkxTLSle3qlE4hlptGyvo7o3M
	n3VGa9+SmsEc/mn2lHUq9OHIlG8HbsOPXhSRvehSFLZk2ldh92beCayqEKve0b0jq7+moELwK+N
	V6HqOB4DdafkmvqQJtsgzw2ESXRyrLRtx/tzeExjG0DClk74ao7OIGzw+fy71d61via3cmorfiQ
	7iIZzkWmdg==
X-Received: by 2002:a05:6000:178b:b0:391:c78:8895 with SMTP id ffacd0b85a97d-396eb8c4c24mr52385f8f.50.1741891738540;
        Thu, 13 Mar 2025 11:48:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFiTFy8KH7Dv3eYYsTrcbBbEoTNapIuB3vn5zSLGQGf/vt0sASshS9p0fTfDPLfBsj9yQoDA==
X-Received: by 2002:a05:6000:178b:b0:391:c78:8895 with SMTP id ffacd0b85a97d-396eb8c4c24mr52362f8f.50.1741891738209;
        Thu, 13 Mar 2025 11:48:58 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df3506sm3076694f8f.11.2025.03.13.11.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 11:48:57 -0700 (PDT)
Date: Thu, 13 Mar 2025 19:48:55 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Harald Mommer <harald.mommer@opensynergy.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>,
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
Message-ID: <Z9Molw9U+1MYCtFh@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <a366f529-c901-4cd1-a1a6-c3958562cace@wanadoo.fr>
 <0878aedf-35c2-4901-8662-2688574dd06f@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0878aedf-35c2-4901-8662-2688574dd06f@opensynergy.com>

On Thu, Feb 01, 2024 at 07:57:45PM +0100, Harald Mommer wrote:
> Hello,
> 
> I thought there would be some more comments coming and I could address
> everything in one chunk. Not the case, besides your comments silence.
> 
> On 08.01.24 20:34, Christophe JAILLET wrote:
> > 
> > Hi,
> > a few nits below, should there be a v6.
> > 
> 
> I'm sure there will be but not so soon. Probably after acceptance of the
> virtio CAN specification or after change requests to the specification are
> received and the driver has to be adapted to an updated draft.
> 

What are the changes in the specification that should be taken into
account for the next series?

Thanks, Matias.


