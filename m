Return-Path: <linux-kernel+bounces-563039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CFCA63611
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 15:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1961891980
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 14:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E8C1AAE28;
	Sun, 16 Mar 2025 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jmc79cY2"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD921F941
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742134861; cv=none; b=mbyPKvrToCS52qPZNYXYifke2B7BZ3KAvhQXGkQl3RvtO7ujXpHzhUrMYicYqSgppU0ShvJGie5HzrMlybzJsfs6UpQ5YTin2ULZfyAwIYQtIt/MTjLJHLGv6h/8vgl1fyaRLWui5HKefIr0jtxIBZ6yowhrAY4SlhcGT0VWJAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742134861; c=relaxed/simple;
	bh=aX15elzBfzM4qmYjRk4JQXVRSIns/ntJViqVRDf2BOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8y0/gR2wphQzmZQqUzJoVu5V3SEj1QDV2y43K86mQLcAzxcAWScckcWS8qfX7NIwFQE3sEz6biN9vgs5cwaaknRX21SvqtHG3RIF32Piz5DQ8wi5GW+WG6gRlTGPIB+OwISGaYZcZtBhEBK8kxn4e6hVpBgiONrjHLN4A3QO7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jmc79cY2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43948021a45so13210975e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 07:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742134858; x=1742739658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JUBU31zWgTKBtgMae2gOeiKWDb462tD5YrmtMJoO2xs=;
        b=Jmc79cY25+MUCYmr7DJU+PXm3rTW/lEYJbnBa1p1u3jamrXUexEr58R30Q4+fMEAE0
         /7muLwVMY8MCttKIA0xTLb6E2Jbn+AdjpjjkCp3mFXixi8EgPVuDS0HBWeh/6eObQ+UK
         hTPeIcNo5jYBsEoPhlkXYykCQ1uI6kzUevsQGpbC86nEHWzhBKzeSez+TIjQ3+GCzrxa
         2qC7yFuzwOLZzujXSHJ9b2Z/w8hG5Yp5OwVI8F1SOTNqXALGWR26TxXwOemQW5s1CLSA
         TK9XimT+w9eEyxOkAc/W7L2TJ3UlAIXgsgzCIzgmOBtKJ+yulZNuRiOkoxupX05vXH8v
         j/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742134858; x=1742739658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUBU31zWgTKBtgMae2gOeiKWDb462tD5YrmtMJoO2xs=;
        b=glsEyv1wsmcxpU+bGp190Yd5aDV0OC3/mkkY3ta7A8Q/mvm+b6XsRCS45YVm362lJK
         qDlKIuw4789WcNHw6oqsOq1tm+U6P6DCchBiQYv6T+IFngTP2WSEC5UGiBZJNiZz3J48
         dm+bgYQ4PPatJy8V6h9eYIk9MTNy5+xiHHqzcZ90YJlaz7gVZ52KIDeaW21Yzf5afdOT
         HBSijjUe3VfeVncFbD2gkQcW+3AKg7E+ZI2jqzAQm+w3tnaAfcKOgyU05fNQPcbwUv9W
         1GbSfHcCO2tkzhpRmX/iLcmjQYaBlltYeMq8mRuEm86qWT0/UvlpEhxBERPBkj2QUcQY
         Ejpg==
X-Forwarded-Encrypted: i=1; AJvYcCWA3iNyqdO7LjEXGwq9+o/haPa68oLFwce7QzNwYfhdfZPZkkhmG8YguyZcO0wPNeF1j1C6yFocFXx+BLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrAgvAmEJ+s8TP3sdkCSe6ukTQFwpQOUPn5Ckao0xQ/xQPs9cd
	eBRYs3UR1dDRdF93YXfAqOfPeSO7DcvDno21US4BoHeodia2ggKgEP4EtJU9ibY=
X-Gm-Gg: ASbGnctDqNUOZUgxMdN5mKzvY0tdMHHO0rB+0iLuq9r/jwzSCvvoVmEe+bbBrvUf3co
	U7fn9VcLoI6lflm5Y8TCfmS+gl4S+7CocVHPw0HsMzb+8mT1Vt894pCFJNtAuZ7waHrvjIDQfan
	rcuWfqYcKFB6QwxTnXN2sHFyVsaDQe6VHlpNHmSC3KBiPDAfcCWwCLR70tENarsbef1nAr24ylg
	M21SxSowdfrRUn2ft+8MuYI0OdZmbgYYfrAE4ooqZY67/94S4ktXHOtFbVlnB1YBc2er4SgoIV3
	rK2SThm2Vpu5mvCfKiPKL5bOawyd6EMuYQHHkNHyVG6wZWTQ50CErLCvfZez
X-Google-Smtp-Source: AGHT+IH96kaFw1QLJUYn/w7ubUS3GRAHrcTkVQ5/aTCb0028F1HTQS+Kq49584fZ58voveSQBvqDqw==
X-Received: by 2002:a05:600c:3399:b0:43d:2230:300f with SMTP id 5b1f17b1804b1-43d2230311bmr87482185e9.0.1742134858143;
        Sun, 16 Mar 2025 07:20:58 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d1fe659b3sm77842155e9.34.2025.03.16.07.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 07:20:57 -0700 (PDT)
Date: Sun, 16 Mar 2025 17:20:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-riscv@lists.infradead.org, kernel-janitors@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, Drew Fustini <drew@pdp7.com>,
	Fu Wei <wefu@redhat.com>, Guo Ren <guoren@kernel.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH next] firmware: thead,th1520-aon: Fix use after free in
 th1520_aon_init()
Message-ID: <80b2d3dd-208e-4e2c-8b17-297be797084c@stanley.mountain>
References: <f19be994-d355-48a6-ab45-d0f7e5955daf@stanley.mountain>
 <d90c0678-d2ed-4e77-901a-fdbab7dfca71@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d90c0678-d2ed-4e77-901a-fdbab7dfca71@web.de>

On Sun, Mar 16, 2025 at 01:05:08PM +0100, Markus Elfring wrote:
> > +++ b/drivers/firmware/thead,th1520-aon.c
> > @@ -203,6 +203,7 @@ struct th1520_aon_chan *th1520_aon_init(struct device *dev)
> >  {
> >  	struct th1520_aon_chan *aon_chan;
> >  	struct mbox_client *cl;
> > +	int ret;
> >
> >  	aon_chan = kzalloc(sizeof(*aon_chan), GFP_KERNEL);
> >  	if (!aon_chan)
> > @@ -217,8 +218,9 @@ struct th1520_aon_chan *th1520_aon_init(struct device *dev)
> >  	aon_chan->ch = mbox_request_channel_byname(cl, "aon");
> >  	if (IS_ERR(aon_chan->ch)) {
> >  		dev_err(dev, "Failed to request aon mbox chan\n");
> > +		ret = PTR_ERR(aon_chan->ch);
> >  		kfree(aon_chan);
> > -		return ERR_CAST(aon_chan->ch);
> > +		return ERR_PTR(ret);
> >  	}
> >
> >  	mutex_init(&aon_chan->transaction_lock);
> 
> May the additional variable (for an information) be defined only for
> the affected if branch?
> Would a smaller scope be more appropriate here?

There are some variables which should always be at function scope and
"int ret" is one of those.

regards,
dan carpenter


