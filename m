Return-Path: <linux-kernel+bounces-572338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C9FA6C92C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 11:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312023AE339
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 10:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A1C1F585F;
	Sat, 22 Mar 2025 10:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dVmOrvmq"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2AC1D9A50
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742638790; cv=none; b=qal4gcb02/mH7MFotDsqfxhTvXNJW6Ilkm3SKvbat6eTPAtB5daB3gPs15aG1b/Qb2xMcxifEUzgYubRkogeqTKXDi3RN5TtGuKPZXt99Qbuf1VEtUkZBHyxeFtzeJZ3ifOiNMQWQ83VLnF/BjNLiAxQev2Ar/4+se0uVZTuXMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742638790; c=relaxed/simple;
	bh=maMryLb5HMvpE5OP65ltf8GjK4I+0KtLt8vUom9lyjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGDwYBhGq9dJbKUVvhHLp5eATxh/in1m+mls+VYklJ6CZZBRvh2KwVo8vI0vDBtDzYzAJmVi4539yPk+crAE6ck5aHBUFEJHpZUXWqATOLcij8DQ6CgFvLD9vDvDZKvlSUqz12qa1pUMRlG1kvSn53ZDLVjNrfWTZyhpTbmocSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dVmOrvmq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so18012625e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 03:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742638786; x=1743243586; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hMfqR7BxervAfhU36qPFX9900VIMKC1P3TtL+FMdSXA=;
        b=dVmOrvmqdRDcKq2cU5QpVwDfoUzCNkj0Bihc1NXGXHs8j6i+HVqEZG+fN3PZaa2kyq
         LhhFi+HGQU+6B5bhWqLLckEPcIId5oBF3Mde8X27ZYOR4XFkCYi3eg7Q/OkAT/WZtRpK
         YawGvvB7Cw+5q7idFUuvrJJubHjBkiZ4+KRjIvatqkE3i9Q3cZv0H/Kao2hMZLvG/dOE
         K8jHbzwDa9rGZkpJ3vKPZDZ0FsD9EaIxgA1oxw6ecj8MlJN5CQdwjGpUrdjGVqahD7jQ
         t74P0H/cXY7NssmMahS7S0q8JAu172JGleYfhUchmP4ioTHOo+hamGvBe9PxKz3XklHv
         TIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742638786; x=1743243586;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hMfqR7BxervAfhU36qPFX9900VIMKC1P3TtL+FMdSXA=;
        b=YIEyKTd0Ul8tHyJbCdK3+v0j/4oSHLwFDEfSaLgiqlMBsSjyzEc8LokRl3dmX161Wu
         7d3fH3hLc1PRLQigAlBE3YLxkbbyB/cDyPCb5nP5tkDKTyVpbJEZ3GP/won6slqPbbUZ
         LYBQv/SoadVnEoD4NjuNxlyosAF8COniwN1SGbQt5TDFx9FHY1lVfS+oFQX8AqwPsMzY
         2Y3iF+sdRTwXen2ZOhp74F2rblYEtz8B6zPGquTTK/N+lZ6r5tP/v8Hf6EM5Y+qzzurW
         iaELnflKXbMNUQ4sSIjEeWOnOaksb81UGO2AixIGj5u3xoEpcFQH5CZd0qxFeQJFFzwJ
         fszA==
X-Forwarded-Encrypted: i=1; AJvYcCVIn5AibN0tq+7Qj1izn79IvXyAqeNjrhE9X1CZcKf8p68GGXF8PnhofO5fRyoM54QMdzNqcHcPLTO9RnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YypDlvNHXo25xpqC+PyuXw5cgUVy3ePup2rIoi/EM+LNuQGp6Op
	xWzMtdCibRBDW2gmAVK8rzY/NzoY6lC0q48lJwy7j2+e9073w09Kb/e7PWBH7C1JpcCz4jjnDr6
	w
X-Gm-Gg: ASbGnctUEE4RnEqzU0B8TMTTgxNRlY8RKYyVP3jSXUuMa02TASJqhPRG7qWIe9Q+a9M
	LcIkTBITyMrnF2haKmuOognofC+VGLIz4hmcWZiMKbiBcvph4Bualkz8i2QPvC3GfLmp1iSxG+I
	VLU9p3SggU7dp0D3Fh3jaqQKhbWSwbiGvFIDk5AkRmFf1+fE9K71J1XnDjcpakF9a4uczqrIb5R
	eRftmYu56XciCy+BNayv5mxtqpu3WWDjy/MDoIVR+vXDK9C9C47zQ9YEkYcIdCRN/VnayENe1c/
	ucjWbYguTHWUnBnWvyDSf5DkyaFhSCfePqpo8depr8JsMtcvnA==
X-Google-Smtp-Source: AGHT+IEPG1arfHtpohOj/xn036w6qfXf/DIsE1g/1+STIZT2hgcYRfebfuDsK3XXOFOXWdgPtcRXdQ==
X-Received: by 2002:a05:600c:3ca5:b0:43c:fceb:91a with SMTP id 5b1f17b1804b1-43d509ec5a9mr61035965e9.11.1742638786140;
        Sat, 22 Mar 2025 03:19:46 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3997f9a325csm4721308f8f.22.2025.03.22.03.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 03:19:45 -0700 (PDT)
Date: Sat, 22 Mar 2025 13:19:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Qasim Ijaz <qasdev00@gmail.com>, linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	LKML <linux-kernel@vger.kernel.org>,
	Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Bo Jiao <bo.jiao@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Peter Chiu <chui-hao.chiu@mediatek.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>
Subject: Re: [PATCH] wifi: mt76: mt7996: prevent uninit return in
 mt7996_mac_sta_add_links
Message-ID: <8b342640-f4e7-45a1-a6d4-471e687bbbc7@stanley.mountain>
References: <20250320201914.48159-1-qasdev00@gmail.com>
 <061ebbe3-557b-46d7-acb8-308ae87105dd@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <061ebbe3-557b-46d7-acb8-308ae87105dd@web.de>

On Sat, Mar 22, 2025 at 11:01:18AM +0100, Markus Elfring wrote:
> …
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> > @@ -998,16 +998,22 @@ mt7996_mac_sta_add_links(struct mt7996_dev *dev, struct ieee80211_vif *vif,
> >  			continue;
> >
> >  		link_conf = link_conf_dereference_protected(vif, link_id);
> > -		if (!link_conf)
> > +		if (!link_conf) {
> > +			err = -EINVAL;
> >  			goto error_unlink;
> > +		}
> >
> >  		link = mt7996_vif_link(dev, vif, link_id);
> > -		if (!link)
> > +		if (!link) {
> > +			err = -EINVAL;
> >  			goto error_unlink;
> > +		}
> …
> 
> I suggest to avoid such repeated error code assignments.
> Can an additional label be applied instead for this purpose?

Maintainers get the final vote but generally when someone is doing
the work they get to decide.

I would say that generally the way that Qasim did it is normally
more readable and more future proof.

regards
dan carpenter

