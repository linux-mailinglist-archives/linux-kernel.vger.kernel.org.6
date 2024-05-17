Return-Path: <linux-kernel+bounces-182293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD128C894A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E4D281AA0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA2A12D219;
	Fri, 17 May 2024 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="OPGnQRbz"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90998479
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715959451; cv=none; b=eQtS9/7E6nep+Wx34XDUX5N75+O1PL6DgU9sHVYVTS6UWK6WCXhkp+zoMSI7Q9z0C4jbFziadVdsAofrTH5R+SRQAaby2Y3AdnFizLp2bI6gTwQ0H5o0XeW8rFhTCfxUqhToS3VFtZ91EhFPCmlvgXsaS2CjjZJ5crremO2o41M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715959451; c=relaxed/simple;
	bh=QXdfDXnhNP+XPVRy8IxZ7g7dZ6J4mPy+Da5kke7S0oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvzzf2gJE0FyFbeWeAjWSyjCgvxj4YPhyGOB9zo7/K+CVtgIUS+YGY1rfppXY302Mq67imnw9LBJF6z2P24EHPCPK3Y4QqORCFzuzefRXGDRsKlYKg4vvWHgK2VBJvl3jgsAWnZ/6Bgx/aM2spL4hklg3R2AZx9m5H27qLIikM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=OPGnQRbz; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-571be483ccaso5054847a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 08:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1715959448; x=1716564248; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CchMDZ298/IGI6kE9eLIhV6PqN0AhAFW2cfstX4Dhf0=;
        b=OPGnQRbzHLytCqVvmwp4DGYAWhMcQagGHAn1CLe7oZfPCz3/jXnAbbgtiflL7fT8w4
         q0fkXQ6ph4SDdb7+HY6Ilr9/YD6zjr1I2w5pbVP+/yRS0VAp0fPMTMm2DvGGYuDxVq5Y
         ggLvFjDBep1N2SSVaVF9Hwx/yqIhK+VpYrM9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715959448; x=1716564248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CchMDZ298/IGI6kE9eLIhV6PqN0AhAFW2cfstX4Dhf0=;
        b=u8b+LYYXn6exDvtMrzTv6EMYpd/SYtLKaoUTYp6nu70zlWe2Q4BU6fKClT3GDEYW9A
         3wdJSynGaXZhdCgGrixpJFOBpd9hKszZro9zrgDX0VfH2+1oMxRl17V83824WgXhxrit
         AJ2X9w85FCM/7QKc5Gb163wH/uQ9MGoJdptuVViEoDd5qDPoUO+mjaLuuORUh5hXPos3
         dVOO7tx4h198ZDvmzyRr8Qwvd6L1zoPn9KY41iwIVDExXLRKag6+vzz/r4wz8xxWW0im
         SdDuOxttonLt0/r6G0haxVcAfL0/SgfUMmuS4Gc4d1licGy6Hx4hXHlF00JTLWFkgQWQ
         1nFA==
X-Forwarded-Encrypted: i=1; AJvYcCU6HavlRECz1pDUayDMrfS6FRkbuLmUzWC43bTT0q6mJ/WkcFBgu8QLfVB1vV5c8zJX0nnIUqJwkHQkV1YHUhue2m92ag8wxbDzXWvb
X-Gm-Message-State: AOJu0Yx7AIWjb6fIyYB4c/GRm+L9Og5lutTehrvLQZgQfvWF1ejZVODM
	1/GEnSTs7KE/xuaHZ9v5Bg2T9loV7AVL/qVb3gTnLHfwFwpXBLzhfP1orYJY8c8vuZaulacHyEz
	hZ12S9ez//QdRHxnjQdmGGcKWJ9tLtjRyYIeJNQ==
X-Google-Smtp-Source: AGHT+IFiAkBo67FgjDFTRG6mQd98TKYWCrHgCGz/lmkQLZy75bavfdElw4HfutKdjY2fPP553NTo7I8eOEq/o0H1GVQ=
X-Received: by 2002:a17:906:da8b:b0:a59:bdb7:73f8 with SMTP id
 a640c23a62f3a-a5a2d66a3b4mr1968036666b.47.1715959448089; Fri, 17 May 2024
 08:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509125716.1268016-1-leitao@debian.org> <CAJfpeguh9upC5uqcb3uetoMm1W7difC86+-BxZZPjkXa-bNqLg@mail.gmail.com>
 <ZkIKfFs-0lfflzV-@gmail.com>
In-Reply-To: <ZkIKfFs-0lfflzV-@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 17 May 2024 17:23:56 +0200
Message-ID: <CAJfpegvr9Ufqg4oe7BnL2Kjsa6M_A-LTyZ9LdvbjnG0GVN_jdw@mail.gmail.com>
Subject: Re: [PATCH] fuse: annotate potential data-race in num_background
To: Breno Leitao <leitao@debian.org>
Cc: paulmck@kernel.org, 
	"open list:FUSE: FILESYSTEM IN USERSPACE" <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 May 2024 at 14:41, Breno Leitao <leitao@debian.org> wrote:

> That said, if the reader (fuse_readahead()) can handle possible
> corrupted data, we can mark is with data_race() annotation. Then I
> understand we don't need to mark the write with WRITE_ONCE().

Adding Willy, since the readahead code in fuse is fairly special.

I don't think it actually matters if  "fc->num_background >=
fc->congestion_threshold" returns false positive or false negative,
but I don't have a full understanding of how readahead works.

Willy, can you please look at fuse_readahead() to confirm that
breaking out of the loop is okay if (rac->ra->async_size >=
readahead_count(rac)) no mater what?

Thanks,
Miklos

