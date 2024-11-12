Return-Path: <linux-kernel+bounces-406861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 825A79C655D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5B20B27DFE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1AB219E48;
	Tue, 12 Nov 2024 23:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HoIzRvBg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2137018BBA2
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 23:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731454248; cv=none; b=lBbKG7QITwE6BTXIsdV41Dwgr372zGpkAX2UmYHDviCYiU/OK1t4syIt+mbGbSZDUxQ7Bj3P8ve0b15G/6/aBCo4MZg36GOpV39domV9QfmSeSTkULun77LDMBQCrQ8m5ASm3yGDTlmXCIF2g7IakTn/wghzbA/hxAvHBuw/Fno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731454248; c=relaxed/simple;
	bh=QPZOFakwbsms/8IqUz2OaUZCjNqpmAIZnLYHPR78u4M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=On/L2VvsjQ4NbuW61nTsPF9+0Qi6Uwc4NJWCw/2SyPlOANG3z1vjcu9030Gx1Jj5rW1BF2Kv/aTSgyUh50NdImnYTWHpl/kc2dApsRrr3tGbLZuEsmk928cwFpMTDVmvUpg96xiVezrM13vaA4U1m8m4CySyOyYRAeQXl1X828c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HoIzRvBg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731454246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=pahYg5ShvYI1JYFWF5WGQMVXj9AMRp+maWU01U95G10=;
	b=HoIzRvBg+IFws7rUo/HZgj6MrkSA4WBfKdpd4/2nkkmbJSh/2xIrFt5u/22UrJmAKhXF5V
	a//D86x4uCMRK43GUyYnShFNI4+VXSVtyBsRr/b5YRXcmLSbnol0/tsB1LsHsdHfbAXD7C
	/IWxJa9s4jmInUbgy7CrGbrY0736MfA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-Qo6HnxVfM56y8UBybvfyDw-1; Tue, 12 Nov 2024 18:30:43 -0500
X-MC-Unique: Qo6HnxVfM56y8UBybvfyDw-1
X-Mimecast-MFC-AGG-ID: Qo6HnxVfM56y8UBybvfyDw
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2fb5cdaba8aso45820161fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:30:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731454242; x=1732059042;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pahYg5ShvYI1JYFWF5WGQMVXj9AMRp+maWU01U95G10=;
        b=pQD4ud+1H5JS6Jws0DYPWwZrcyMwUIIGuKYiiCXui6MagZw8x65w1+BjtX1RPD1kBQ
         N5Rb5PoIiLtbmYJkncgFS+4AEj/boKw4nKyw1a4Fy3EiGdqyDIQRRP3iTg8TJ3Hnf8YP
         q0FWbMSj66zxVRfPcCs09Ztezj2oEkQqU8hj2ouz36b24eaWpZ87JowLHeYqvmz+/yUs
         lfJo1euhXtQXKivFCquEngBU4L7u7fB3ZQ5AhbDYlyMlkTKHZzbY/MAUZ0MtT8f3AOWW
         AL8Q+5ZTnL/Ebv3kdP5VH+feR99f8aD3PWZvdEpKHh/uVMQNDx2Bjkchw8VYv/AoaL/2
         QE0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGJZAOKltWhM/3DWnKiivzzkEw8riM5GfM9UhMhLK+6HXDTwEuMweMTSeNPThxf+SF8RAHMGmeNxKq1Jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIHrESTzkV65PrCnr0E4klw+lywWZg8BsAYGtddUWwSzliQEGW
	2uvQH4VfTX5nfG86GjIGkQLEnm7Xv7RfWLV4JwUPNaz22OvVdkDPFiKBdh/MzxZ1gpHaMYCPxDQ
	rXelKV+4npEKa1ea1Q/LqJolU5D7ATAGgl7tpNHYDFgOutdxcj/Lv4E7wYXKx6A==
X-Received: by 2002:a2e:b896:0:b0:2fa:fdd1:be23 with SMTP id 38308e7fff4ca-2ff2028aadamr130045291fa.28.1731454242083;
        Tue, 12 Nov 2024 15:30:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZ8235xoIzEDFqX8Iqts1f1b/TTKzRbzsKbik0jYFi7YnSriOxnAuUaNNRZk63pcxv8z4I2w==
X-Received: by 2002:a2e:b896:0:b0:2fa:fdd1:be23 with SMTP id 38308e7fff4ca-2ff2028aadamr130045111fa.28.1731454241621;
        Tue, 12 Nov 2024 15:30:41 -0800 (PST)
Received: from redhat.com ([31.187.78.204])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a17662sm796178366b.28.2024.11.12.15.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 15:30:40 -0800 (PST)
Date: Tue, 12 Nov 2024 18:30:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	dtatulea@nvidia.com, jasowang@redhat.com, mst@redhat.com,
	si-wei.liu@oracle.com
Subject: [GIT PULL] virtio: bugfix
Message-ID: <20241112183037-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

The following changes since commit 83e445e64f48bdae3f25013e788fcf592f142576:

  vdpa/mlx5: Fix error path during device add (2024-11-07 16:51:16 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 29ce8b8a4fa74e841342c8b8f8941848a3c6f29f:

  vdpa/mlx5: Fix PA offset with unaligned starting iotlb map (2024-11-12 18:05:04 -0500)

----------------------------------------------------------------
virtio: bugfix

A last minute mlx5 bugfix

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Si-Wei Liu (1):
      vdpa/mlx5: Fix PA offset with unaligned starting iotlb map

 drivers/vdpa/mlx5/core/mr.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)


