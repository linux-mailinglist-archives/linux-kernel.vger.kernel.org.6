Return-Path: <linux-kernel+bounces-333729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CDD97CD03
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 19:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594721C217AE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AF81A256F;
	Thu, 19 Sep 2024 17:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dJV4egmH"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE86191F74
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726766659; cv=none; b=fj3/0KdmBTpAtqz11AZUmTZ9Se7STV+Cyu3j3FncjCXFNLZpRvWPLsLwI6WwQTUmF4m2bZ3lb6lf7gc6+6Sp4U/KhjXQBPnrjwVcBTZQB6Ck8f406A66fvL/80MWq6L4y2J6uWKFIUnkvzRCQ7kV27eGw5POz7PhPtmqlzOq2kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726766659; c=relaxed/simple;
	bh=9UPuffiJEpTMQNa/RgZa0HUXQrmRq+s6vEz5epvuDDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECLXG7R8nGB9JAwM44PNNtulhTtWypzituW6IeVqDHUyIGezJn70uKDffpoXDFBqtbUFWK7dLPgKEjKiYX3f8s4r7HsSjtGYFV/cs1zXKqtndZAJur238ZBoLJMuwP2LEMGP9ud4nQPFJ9u/j75v6Ty4o6ysTOhMm/h8JWaiv+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dJV4egmH; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20543fdb7acso10521615ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 10:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1726766657; x=1727371457; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CNbiO/82DP9u2sWzbvovvrFbtPlTZFQedx6KNu76pJM=;
        b=dJV4egmHLlbQy+NSqL3cQ3Y4tDnFtWPd2q65mYmVVOZISRDzjoDfMvWdl4ov4xXTjD
         vIzLieHmCrB9q5t+7shCsKJeLNkFqZOZ+y7ngExJUkiKzD48fkUDjfM4iOS1Rx/++pbc
         Y72AFHiIy+PDuMTmwgLIA34CVK76cCRXAPI4B4LFdRz31o2SsciFsywGwGVvKP4VEZ7I
         pY3D0i3abSPJhHOEwtfGdDr9rDhLzQrglsonSANfMYom2RrY5OENikIzkcG/bLv6Nl0P
         NMas6EkDxDcGHkhyjL/LfXrmkz515avu/UoFv/fM287Tc86nqs/a0Qnv4kiH4DGwi9W1
         nguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726766657; x=1727371457;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CNbiO/82DP9u2sWzbvovvrFbtPlTZFQedx6KNu76pJM=;
        b=bsiHUXSv0/KraQo+Gt4OjutGfJD3F6HOZ1dxopj+zy/xZTcctY6OCLs4DVBWm4788A
         QNxao2u89085gS2Kayi90TUhnAFaDubrcfjGE0DFMY3ByxJUPtEgT1w5TrsZf31HxlZ7
         4JwSkOW5jjIsReMfPsjONU9f5NqrSp7KjE49cMhrAe+0CyAnLZ+Uqp2zgLZw1Vn3Wttw
         pbsvNrTo7sE8IfylSn6xxK+RWyLEYfiCbhjDELa+1/24R+f75OrFhiQTHN063bKVbwf+
         KTx3zxu2lIBYzFxJUan19i1RxPFNdDFwqC50o8pqAI999eZMHH2kcn6LVDHDw2gQCoRe
         tmcg==
X-Forwarded-Encrypted: i=1; AJvYcCWMBgXTNRIdtAX9vryhuVtz9797sWha/uGVg4o7s9IPodybMUuui5kERB7OY0y1RyzwFpK8YBNUNgcFi14=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDuwIVEVWDfwBX0J9ZfoIWgKKRNlx3zouGYCxi1i/MGot8vAHc
	4E1h62N5+WHJ00mUGfqJ28RRp+pVsg6iGapQ6gG+JYhvOjHuGkig0V4w7HHEPDI=
X-Google-Smtp-Source: AGHT+IHPfY4TEkVvMUVnLR9vZZuyYLKJtFhdGuuG5hbLTNkoQGtK2vgWZ0VNokhT+DVllzTi43tO6w==
X-Received: by 2002:a17:902:ecc1:b0:206:9519:1821 with SMTP id d9443c01a7336-208d8397bf2mr1158685ad.14.1726766657486;
        Thu, 19 Sep 2024 10:24:17 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-207a09593f6sm73088405ad.220.2024.09.19.10.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 10:24:16 -0700 (PDT)
Date: Thu, 19 Sep 2024 10:24:14 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Moshe Shemesh <moshe@nvidia.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, yzhong@purestorage.com,
	Shay Drori <shayd@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH v2 0/1] net/mlx5: Added cond_resched() to crdump
 collection
Message-ID: <ZuxePhq3V4ag8WTz@apollo.purestorage.com>
References: <20240829213856.77619-1-mkhalfella@purestorage.com>
 <ZtELQ3MjZeFqguxE@apollo.purestorage.com>
 <43e7d936-f3c6-425a-b2ff-487c88905a0f@intel.com>
 <36b5d976-1fcb-45b9-97dd-19f048997588@nvidia.com>
 <ZtknozCovDvK7-bL@ceto>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZtknozCovDvK7-bL@ceto>

On 2024-09-04 20:38:13 -0700, Mohamed Khalfella wrote:
> On 2024-08-30 12:51:43 +0300, Moshe Shemesh wrote:
> > 
> > 
> > On 8/30/2024 10:08 AM, Przemek Kitszel wrote:
> > 
> > > 
> > > On 8/30/24 01:58, Mohamed Khalfella wrote:
> > >> On 2024-08-29 15:38:55 -0600, Mohamed Khalfella wrote:
> > >>> Changes in v2:
> > >>> - Removed cond_resched() in mlx5_vsc_wait_on_flag(). The idea is that
> > >>> �� usleep_range() should be enough.
> > >>> - Updated cond_resched() in mlx5_vsc_gw_read_block_fast every 128
> > >>> �� iterations.
> > >>>
> > >>> v1: 
> > >>> https://lore.kernel.org/all/20240819214259.38259-1-mkhalfella@purestorage.com/
> > >>>
> > >>> Mohamed Khalfella (1):
> > >>> �� net/mlx5: Added cond_resched() to crdump collection
> > >>>
> > >>> � drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c | 4 ++++
> > >>> � 1 file changed, 4 insertions(+)
> > >>>
> > >>> -- 
> > >>> 2.45.2
> > >>>
> > >>
> > >> Some how I missed to add reviewers were on v1 of this patch.
> > >>
> > > 
> > > You did it right, there is need to provide explicit tag, just engaging
> > > in the discussion is not enough. v2 is fine, so:
> > > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > 
> > Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
> > And fixes tag should be:
> > Fixes: 8b9d8baae1de ("net/mlx5: Add Crdump support")
> 
> Will add the tag in v3.

A quick follow up on this patch. I posted v3 [1] of this patch with
minor changes. There are no functional differences between v2 and v3 of
this patch. The commit messsage on v3 has information why call
cond_resched() every 128 iterations, so that could be useful to add.

Is there anything I need to do to get v2 or v3 of this patch merged?

[1] https://lore.kernel.org/all/20240905040249.91241-1-mkhalfella@purestorage.com/

