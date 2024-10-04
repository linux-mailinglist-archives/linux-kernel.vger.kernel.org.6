Return-Path: <linux-kernel+bounces-350775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D93990988
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 486DD2887AB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A99C1C82EE;
	Fri,  4 Oct 2024 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="llkXN3mf"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5561E3798
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728060093; cv=none; b=H3XsnOuZmmoQcb1iUHGD46mFzV91j5rqRTeWTeJM4sNQHukx2kDg/07Uxj5x7ABejbN60yTAeQabojeiEAiopPrZpmIqgfhJDqnPyQRdXZEnUgVeUTyTf41Du2R8SxI+rqyXLH3hcdvY5CL1P1MImu8uejL0YT1dAG7v0qJS4xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728060093; c=relaxed/simple;
	bh=oLTGhDFlQPHsCgimoIuovUbgfVjz2YHngDsEIfIQ7/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkXmj8g0H7tbofLz8OBbVp8rcdFaExDEB0qbNTE0VA0Pq+fIic9/qPujIIllpfJ4+/sndk4OE4gA+clWmmfILEhvvaP3ILmIi+ZeQboGDd6M9ejWuyU2N4U82PRwWaY2XJ2A6Yx9pljUBkGl0s0t/kx5Ib2K/QNhDy8coRAeevo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=llkXN3mf; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7ae6f77f3a0so88742185a.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 09:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728060091; x=1728664891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cNo54GXkVm6CFb67YgwSrwHjh7UB2oNyFIVxqdJOafA=;
        b=llkXN3mfvrsoodm6w+tDqYqTzIleCaUW59HZUD90krA1bzYmAwQjW91UAFpBgxDmjO
         +poIC47fdedlUpP4EnixaQQU8VhL926guv8Kl8n9Nt4+ymduH33gFivFo1ZXPn3nOrNk
         axWwPTxS1kd5ClrLvGxSam4TrQHcbT0kesbx9Yk/5BIWMFh+o9TU3cNp3uwc7vn+I3g3
         2D4K4k4I543Cbi7Mf61IW90+wlC3o3w6WOBX84iifVZofcbPnRI4zm1fuLL9huvE90Vl
         jSpk24aJjzP4V+2tv6Qm9N/Utskq6ZJvsF9YBFM0hWYyDQS6k5AtfrTxSeeGwSWGv7zf
         RdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728060091; x=1728664891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNo54GXkVm6CFb67YgwSrwHjh7UB2oNyFIVxqdJOafA=;
        b=wu8vVg62AyESU4RzOjXiuxNcm4nGLeLwKSn84jKS6mS9b0mwQ2IWkv//gnXkPrz4Np
         +xbcwDZo5BSPvJaf8a+u7efeMj3EVLWQ990RNamZIgQs4XLYF5K8K3AVKxZF+1kkX2mV
         ++AZvFlTcycoll4KI2BVNidFERnsHYlHYhuxBX8S11u9ZXAw6SWV98OSwJuQ0zlZ2DiK
         Kx8SIgBaKU13i3kjQrk0e+k+c9mZwnAqno1Z4V43auQHJSJeoU6bDBrp7yOd9e3JddBG
         SK4hSQ3UA9FlQT+A9PUKNbarR0M6nOh78xB/5Fb/t4J54pg+XiPZ/0qXuqR2+26KgeSA
         wnzw==
X-Forwarded-Encrypted: i=1; AJvYcCWx782wIUEe2Jcev0CNMtxbSptwM5UPfjSWXROuVO8syjmdFeT9gIkbDf82LUeuNjBDamWATnEx3aN8n+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn+s7Hq1AOzoDVJU8xWSSbV+s935YbCNeXVxw+n34vlLPRAtas
	kV76RdagaeUDQYdiBQuLQgyTLmOwA9k/A/rQrozpv5GsP+jksHqabt+BdwJw8pQ=
X-Google-Smtp-Source: AGHT+IHxS1rReuR3uNB96tDmATg9U/Vxhje8tNVMGz45YlEaBfb5RwW5aZT+p2GKniBLo3EodEd+AA==
X-Received: by 2002:a05:620a:4611:b0:7ab:36c7:b9f6 with SMTP id af79cd13be357-7ae6f44c77cmr465612585a.31.1728060091222;
        Fri, 04 Oct 2024 09:41:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae75615955sm434685a.19.2024.10.04.09.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 09:41:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1swlMw-00DXzM-Be;
	Fri, 04 Oct 2024 13:41:30 -0300
Date: Fri, 4 Oct 2024 13:41:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, james.morse@arm.com,
	will@kernel.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
Message-ID: <20241004164130.GK2456194@ziepe.ca>
References: <Zv2diJDU6v60hKtU@Asurada-Nvidia>
 <20241002194004.GT1369530@ziepe.ca>
 <f28cab76-8030-477a-84b1-461dc02451ff@os.amperecomputing.com>
 <20241003111603.GU1369530@ziepe.ca>
 <43c2227a-71c9-4cbf-bfec-5a2fbf698f27@os.amperecomputing.com>
 <20241004124343.GE2456194@ziepe.ca>
 <26ee77f2-720d-4e16-9f6c-fa15fd13d305@os.amperecomputing.com>
 <20241004161408.GJ2456194@ziepe.ca>
 <7ad66e5f-d6f8-4144-8ab2-d4ea499e2665@os.amperecomputing.com>
 <9f28e3b3-a47d-4a83-911d-fd7a6b95fd60@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f28e3b3-a47d-4a83-911d-fd7a6b95fd60@os.amperecomputing.com>

On Fri, Oct 04, 2024 at 09:37:10AM -0700, Yang Shi wrote:
> 
>         size = num_sids * sizeof(struct arm_smmu_ste);
> +       if (size > SIZE_4G)
> +               return -EINVAL;

If you want to do it like that then 'size >= SIZE_MAX' is the right
expression

Jason

