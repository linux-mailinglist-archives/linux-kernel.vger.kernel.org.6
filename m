Return-Path: <linux-kernel+bounces-365485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2C499E30D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07074283429
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CAB1E04BD;
	Tue, 15 Oct 2024 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iwDMg2Qt"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D4E175A6
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 09:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728985721; cv=none; b=DTR6LVxR2zZDLF0C39w13AfeC/082qaR+nALoeHEcg7jHVzR9zxVQSz9kW7b+Dr/92kr+/6TgzFTSNF32YC8DcxEug0n2bd1TF6vQl60xNvHbxq5QdK6iaAhPxCF8y7xVC8sqUjsQGhXw+BejHLeyKFe3l91DOPvn8okqa0JXes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728985721; c=relaxed/simple;
	bh=yYb9sb5AxiXLVlD3bVkK64FKKxtA8VrXUNvbw1gtuts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TplW0uM03IKSul/iKaRaz6pipOA3RmgY0z1pbECuHBvkRcVYfS/+zN1qf3rupWujE+G4qLIb5c4T3oSsu1ZcVyIPM1Z3gC/IgbEsASaRGMVnj/aESLYoac9oU0h1HSj/U//yIYBLInzBA+MhPgDeBb1aXTb4nLPftQAY6xQbQGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iwDMg2Qt; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a2209bd7fso152891266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 02:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728985718; x=1729590518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1teDS0JJcna/90ckTpcvCS/IaGCA4XWx1Jz7qyJi5jg=;
        b=iwDMg2QteR0yvQQM8Nr9teOoWqzj45RezjE8fzK0xcJK1mpdZzVBOXiw5YrjND2Gn2
         Mqo4KoPBtdmjzEThnKdagd4ypoBC1COy25D+624kMRHZ1ld7KlairyjXLUxkrFDxUPtS
         vruKcjH7YHyLWQxFtKOHarjn1uv6vBJw8+vdesNq4GN6ZPXgB79JKynZt3eVoYBO8PhR
         09kKyjNo2F9CjbYkdI7+/hYOWMLeZ0Trn1zpeYwX31stqr7HpVxhHMnw1nmRAsDhkXzn
         By/WZbBBG8VJglj34kTh+hry6tBMoV00Lz4x0fwIiqPvW8kgqApwOMdzap/i6WjR2+Gf
         hytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728985718; x=1729590518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1teDS0JJcna/90ckTpcvCS/IaGCA4XWx1Jz7qyJi5jg=;
        b=mSHapljhzakOg3Du3Q3T/IwjGinHzuw4al14zn/nj/kWvHj8Eez05U2Gv+1X6s0P1/
         uYExhrMm2dpNcTT6LdQnqkmMeBz0y1GeYlYdTpIfn4vDuGjqlcp3bl7Z/UM+JCkA5byk
         7lVAuEeJarBJqqrg5Sk+O3c64FDje4lRRjJLzQ3Y5vptYibmG/g9tADD2sfUZx8EGnpo
         pct5SvGUPqGDA4qwJWYZFOkm10aNGDsbCYFjOIPd9FfhE+CA8k4+fujT7KU4ira8MK1f
         9eDNVW0vLVIGq+WBbvTTCdYUw0XI+f82J2fbJyVpHoIgzYDyzluBnl6ZiRx5WnRAtjud
         bSRA==
X-Forwarded-Encrypted: i=1; AJvYcCUmUu3NsXB8GKbGHnPHVDU5vA6A4aiMpucSoO2knZBPe2lW+8cYPo6C4BPzI7q0dnby14NkM8y/RVPnr10=@vger.kernel.org
X-Gm-Message-State: AOJu0YxejixmRhNEn7pxdQl2MmpSxrGiLojUiXXJgVC1jk8CPvjqrBFl
	aGuBEfJGBOFRgTbEecDQsJozZGEJG7hLYIpolJjOtLCuDZE2bKDbZ6U/NqujX38=
X-Google-Smtp-Source: AGHT+IHVV5gB4sO2s8rG8UOt0XzDKS6ScXRIKX4PKjbNf6jNN37IksWraaka1Knc+QX36AetoAcjJg==
X-Received: by 2002:a17:907:869f:b0:a99:fc3d:7c76 with SMTP id a640c23a62f3a-a99fc3d7e78mr723129666b.37.1728985718522;
        Tue, 15 Oct 2024 02:48:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29850a36sm49903666b.181.2024.10.15.02.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 02:48:38 -0700 (PDT)
Date: Tue, 15 Oct 2024 12:48:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Everest K.C." <everestkc@everestkc.com.np>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, skhan@linuxfoundation.org,
	kernel-janitors@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2][next] Bluetooth: btintel_pcie: Remove structually
 deadcode
Message-ID: <8a4a8915-d59a-407d-9f93-f047370cca62@stanley.mountain>
References: <20241015045843.20134-1-everestkc@everestkc.com.np>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015045843.20134-1-everestkc@everestkc.com.np>

The subject has a typo.  s/structually/structurally/

> The intel bluetooth module was successfully built after the change
> without any errors.
> 

Delete this sentence.  It should just be assumed that changes don't break the
build.  You can put that code isn't tested under the --- cut off line, if you
want to put a warning message.  But we don't need this in the permanent git log.


> This issue was reported by Coverity Scan.
> https://scan7.scan.coverity.com/#/project-view/51525/11354?selectedIssue=1600709
> 
> Fixes: 5ea625845b0f ("Bluetooth: btintel_pcie: Add handshake between driver and firmware")
> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> ---
  ^^^
Cut off line.

regards,
dan carpenter


