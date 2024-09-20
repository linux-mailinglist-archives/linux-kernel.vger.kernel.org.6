Return-Path: <linux-kernel+bounces-334323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A074C97D5BE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 14:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C2328462C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 12:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F02316A395;
	Fri, 20 Sep 2024 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TFpe+4kj"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE02165EEB
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 12:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726836481; cv=none; b=HvKhfNW0Uvpwr9RSsFa0Bw6Fo6xMLTUmPlQcnn+teB0k28eqkR/lpEaii3uD5TeR0JsMJFpg5wovYrhfCCje5bGgS0ajvh64sfwpojDsr6dHM9EQClWCJ1P6YG8fxYVvGxJYEp56o6ROXBeHr4g6MxnTFxL9GGGLnkPxuL6izP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726836481; c=relaxed/simple;
	bh=4aywC+B5Om4OSHCxCkeV1IQJG+CDm7m2zEJ8aYzXg8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJyxMPxfx3MpHEINQqiUeQCWiattQubzf+hl7DZH0n5D0+Gc6Xl2jXKYWPszmXSwtXlpBSrUAx7zN4Wqp+Tf+6ssOCgmg6df8AaVmD7gbqWtkWdSMBmKemfQZHF/u6kWs2/wBSu8E9nyZP/Q9bSPeQN+5rFRN64ANkeAGYFjgxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TFpe+4kj; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8b155b5e9eso270905566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 05:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1726836478; x=1727441278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X2xJE7hCuiR6rhROHcQFlHj6IQHUA6H+IS+eLm/arhQ=;
        b=TFpe+4kjfb979MT2TpXFlM88p3t/ljWVgsLLNWeJGsDOJm787uVJe7g1Vij2bjcFFN
         wdIuD4j2l7w4JtGnA0/0H0xXgJRpVyf6XasNX7hHbZuJU4F8vHBJlnMkD743gaph0UdS
         CjD3YvsUNbWNdlBvHw6aPhsov+ILnVYQFZAkx7yqsyX6yFwkWNEqIKHndoDldx9Hr9pu
         g9irk+OS6xK0RzXoNrFvn7tidqYs2FkIv2gffVZr5awe6QTRtXz0WO+4YDnI2MtD31KE
         rYp6AhN1tBU0y9f7z6oGU9to4WAt1f0TfT+isWcJOirlU254n/93fcKrRDbLCJAimmux
         AK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726836478; x=1727441278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2xJE7hCuiR6rhROHcQFlHj6IQHUA6H+IS+eLm/arhQ=;
        b=N2b7VBL306Fi+O9kx3sl0TEJM3hHSxfFoCpDLTJotcntY9bBBr9jENGILJ4b8ZdSxR
         krCKcSGyAEVsCO/6fqd5lL/iUaKFB8D6kmLq9eAbArfaT3rVaXPshmE5fAkSw491TnAP
         dKknB/Tfb4lHioPzywaELACxQ9Lr3d7c4SQjn+DLKjVi6NfStSydqDIQGTTP4odsFO4S
         rpe3TZ1qoVSOCFyy2avhmxkP9wtpqxuvsSaEFuOR3a+mXY7atOWf+M9YXHib98BKGm8p
         6NA00wFfF7acszWx0tzBh1HnSU8I2AYN7bHW+aS5Ak5tdwdQDrCkv91fI9Sgi6ryInDG
         AN4A==
X-Forwarded-Encrypted: i=1; AJvYcCXH4SQr3qRmRywsnNwQ/Tnvbj143qsCOugJWzXJ/e67ofAbI+Oz89f50WTYADO5n/Q98OhowPEQsivsIWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCE77wL0JYfrcfgtfhh+b7x2saWUDAMAr27uPtm9LFkHptlv0T
	nSly0hMOMIdpK2Emnk4XIHlGKBe93pV0pVygip6TxsVGP0o1bw9vcynoNTFxi9c=
X-Google-Smtp-Source: AGHT+IE4F67aGCJpQ0MA7SSdlxROIwB102izDy/PQaIh7Yf9dNwfHp5Up+3oQi50poFc1poRs/PJZg==
X-Received: by 2002:a17:907:e25a:b0:a86:8832:2fb7 with SMTP id a640c23a62f3a-a90d4fe825bmr205726366b.20.1726836478358;
        Fri, 20 Sep 2024 05:47:58 -0700 (PDT)
Received: from ziepe.ca ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f42e6sm842024666b.78.2024.09.20.05.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 05:47:57 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1srd3F-00017y-1U;
	Fri, 20 Sep 2024 09:47:57 -0300
Date: Fri, 20 Sep 2024 09:47:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linuxarm@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 for-next 2/2] RDMA/hns: Disassociate mmap pages for
 all uctx when HW is being reset
Message-ID: <Zu1u/aiOAooVUeq2@ziepe.ca>
References: <20240913122955.1283597-1-huangjunxian6@hisilicon.com>
 <20240913122955.1283597-3-huangjunxian6@hisilicon.com>
 <20240916091323.GM4026@unreal>
 <595ec9f3-c3cd-66b3-c523-452f88e079ac@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <595ec9f3-c3cd-66b3-c523-452f88e079ac@hisilicon.com>

On Fri, Sep 20, 2024 at 05:18:14PM +0800, Junxian Huang wrote:

> >> diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
> >> index 4cb0af733587..49315f39361d 100644
> >> --- a/drivers/infiniband/hw/hns/hns_roce_main.c
> >> +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
> >> @@ -466,6 +466,11 @@ static int hns_roce_mmap(struct ib_ucontext *uctx, struct vm_area_struct *vma)
> >>  	pgprot_t prot;
> >>  	int ret;
> >>  
> >> +	if (hr_dev->dis_db) {
> > 
> > How do you clear dis_db after calling to hns_roce_hw_v2_reset_notify_down()? Does it have any locking protection?
> > 
> 
> Sorry for the late response, I just came back from vacation.
> 
> After calling hns_roce_hw_v2_reset_notify_down(), we will call ib_unregister_device()
> and destory all HW resources eventually, so there is no need to clear dis_db.

Why can't you do the unregister device sooner then and avoid all this
special stuff?

I assumed you'd bring the same device back after completing the reset??

Jason

