Return-Path: <linux-kernel+bounces-253837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6789327B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE59285D11
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29E119ADA1;
	Tue, 16 Jul 2024 13:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ti5z71mi"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D4819AA46
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721137218; cv=none; b=I8tedbQAhvQtcjYior45harQ5kR5RgqFFgGXCOnZ/SENqRVdASP8KRNPIuP329X58MsA910IVXr/VuGzsyylx9vjJByJFNpXp69GTo2c/tC8J1taZCLnCR/G/ppYvg8rVfgmXZwWqPQM/Ry2fuuEsYDX4UcSI1YHknxyfv/TEZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721137218; c=relaxed/simple;
	bh=b3A4E23cok5k7mnxSEw6irXzoXzTbKnV0WgS92byiYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGtCGJBdauEHoAyuEV6Wze3uPdM1t5OTasq85v0NVGd2hduUNFM/rqMO0YWEJW33W5yKpQPnTNoZ9d/U3as6LXq0Ky79kWD0n936p0HsG7dWF+zkE1SolXjtUpfzpEvuVwnHoMmSa4303ikBUGzQ4BclbMa3AYab5tWr4ZSDEdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ti5z71mi; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b5f128b18bso30550996d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1721137215; x=1721742015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzddLqE5sbJXB4ZLkKSMkOisLHuczB5WDxgyMvz+RuM=;
        b=Ti5z71mibd1c29itRflK6DzZxmi3yLHwRCtkR8/1eKLBhApuktY6O8fwAk+1faf1Yf
         SBlE6qzLs4KW0Dm4TFOrGUQA9XMsV3cjHIXFjPkoUNlDvLaPFd5U2+pl+aMXAHffZBgf
         nlwV4rvzMjSm4JNj1EduQHRfan2h9w2wQKnwD5c0kEXYxqDMfXlrbtvtZpGHqJ1iRnDo
         /CCL7PHuJmnvgPXJDvWuwWP7rBZh3w+Wt6Mq7g+rwZBpJO7ttASpOnBsRRiLweIh/W75
         EjhQnYzSon15njD+4OH8MOUQvrFLIEfCaJ/l+EsI8v2nrLUIb5B2qAU04kJOS8Gk1UpG
         1UOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721137215; x=1721742015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzddLqE5sbJXB4ZLkKSMkOisLHuczB5WDxgyMvz+RuM=;
        b=u6zxKpSShEQZKE3jNLosjDdjbjrM+YdJfWG+KKBRrl7yM1Zpa4AIM9iWYX8D8pJ0U2
         Cnydjx6CLiBwq+UtzqnPMTsEQu4Lv2pqiNcJw5Q+K2tMhdUgqLeGGUJB0T6nP5/aLh70
         2tM/LJYP1oPZWkLHcy9KkeHqN5FKDjNnVV2Yo3WhrJ5fsYzdFKu5qh3JtdW/TJGZpkHf
         22LqQwTMaWeruspZtBc8OQQgG8QQRlPBAspBgpOBtBM5lJLCoLwOVFcAwvRCO3YW+ahl
         LQjRIG4sYGfFLSlUQGIvrasGQXD7UfRJUgtnMR+chVur4X6nzlKiqo8AjLJqQKS9JD9z
         f10Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyWbiCtWrKtO59+cxn6wkcp1TUMNpCfdq71sLq+zTNmk8sis+cTDOw6oB+fig4VohQWI0REfUDkKy0XlNPkevRo5TYLAloMfSp4B3g
X-Gm-Message-State: AOJu0YwCXD447PxPN/heFdH5W+S2SI86sgVpYBw/Tz+9b0PFvEixnHkm
	3M7YrxpRfjCURFyzJrgn52FjUvXDfedIzPoddKw7tJDQ3nF0einLJSHZIHJ7lmf5AhU8hN6KEsV
	K
X-Google-Smtp-Source: AGHT+IFrKlyzzJnVHLLxNmw34TVxVG87O64wpA44pESjU6PrkfeOnqAxIZcSzyXzUUspO+reEwe3BQ==
X-Received: by 2002:a05:6214:5290:b0:6b0:7f36:8ae3 with SMTP id 6a1803df08f44-6b77f54230emr22415396d6.32.1721137215461;
        Tue, 16 Jul 2024 06:40:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7733ee169sm19763146d6.26.2024.07.16.06.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 06:40:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sTiPd-009Qyg-QU;
	Tue, 16 Jul 2024 10:40:13 -0300
Date: Tue, 16 Jul 2024 10:40:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Omer Shpigelman <oshpigelman@habana.ai>
Cc: Leon Romanovsky <leon@kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"ogabbay@kernel.org" <ogabbay@kernel.org>,
	Zvika Yehudai <zyehudai@habana.ai>
Subject: Re: [PATCH 11/15] RDMA/hbl: add habanalabs RDMA driver
Message-ID: <20240716134013.GF14050@ziepe.ca>
References: <20240613191828.GJ4966@unreal>
 <fbb34afa-8a38-4124-9384-9b858ce2c4e5@habana.ai>
 <20240617190429.GB4025@unreal>
 <461bf44e-fd2f-4c8b-bc41-48d48e5a7fcb@habana.ai>
 <20240618125842.GG4025@unreal>
 <b4bda963-7026-4037-83e6-de74728569bd@habana.ai>
 <20240619105219.GO4025@unreal>
 <a5554266-55b7-4e96-b226-b686b8a6af89@habana.ai>
 <20240712130856.GB14050@ziepe.ca>
 <2c767517-e24c-416b-9083-d3a220ffc14c@habana.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c767517-e24c-416b-9083-d3a220ffc14c@habana.ai>

On Sun, Jul 14, 2024 at 10:18:12AM +0000, Omer Shpigelman wrote:
> On 7/12/24 16:08, Jason Gunthorpe wrote:
> > [You don't often get email from jgg@ziepe.ca. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > On Fri, Jun 28, 2024 at 10:24:32AM +0000, Omer Shpigelman wrote:
> > 
> >> We need the core driver to access the IB driver (and to the ETH driver as
> >> well). As you wrote, we can't use exported symbols from our IB driver nor
> >> rely on function pointers, but what about providing the core driver an ops
> >> structure? meaning exporting a register function from the core driver that
> >> should be called by the IB driver during auxiliary device probe.
> >> Something like:
> >>
> >> int hbl_cn_register_ib_aux_dev(struct auxiliary_device *adev,
> >>                              struct hbl_ib_ops *ops)
> >> {
> >> ...
> >> }
> >> EXPORT_SYMBOL(hbl_cn_register_ib_aux_dev);
> > 
> > Definately do not do some kind of double-register like this.
> > 
> > The auxiliary_device scheme can already be extended to provide ops for
> > each sub device.
> > 
> > Like
> > 
> > struct habana_driver {
> >    struct auxiliary_driver base;
> >    const struct habana_ops *ops;
> > };
> > 
> > If the ops are justified or not is a different question.
> > 
> 
> Well, I suggested this double-register option because I got a comment that
> the design pattern of embedded ops structure shouldn't be used.
> So I'm confused now...

Yeah, don't stick ops in random places, but the device_driver is the
right place.

> I'll look into the option of using notifier chains in this case, although
> as I saw it, the notifier chains are more suitable for broadcast updates
> where the updater is not necessarily aware of the identity nor the number
> of the subscribers. 

Yes, that is right.

Jason

