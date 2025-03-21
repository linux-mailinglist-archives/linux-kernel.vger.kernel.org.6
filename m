Return-Path: <linux-kernel+bounces-571643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8F6A6C015
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF829463D42
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7E822CBC0;
	Fri, 21 Mar 2025 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sQDh2FHd"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1AA22B5AB
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575011; cv=none; b=VBaE17/H0C8BAP4t/Vh9ML5j8EYtZN4hfEdakDEhq6QkU3ynERf+3ac01PaH7ARoBgJE07B/M0YrB39u4RAiYAKqvZ1U76hOuNSbgpk0LONo7rvfwftUmYeSM+XAJUbF746f4jPzYz1bETE/YpOied+PhCQKlgd+LEAoci0wui4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575011; c=relaxed/simple;
	bh=EYXvUxlOmseeifJZO5lf+exAGIwHnoh8eUMozDOfeNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nj3IMQKxE3ZB5ZQt/L1iWAMXpziXTZoXLsbO5jcb5Olzq6XcYP7IiuNabUzhkay3bj+lNJQWZBbH8Dd/6hyU1TsQRWCyx5JUdvMlHxpzaY7YHzFiVgItJIGZrvZaXGhzkjMhqp+bc8+Z5wZNciOJKCfxyxeX88KXIcjL2nLH3dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sQDh2FHd; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3913958ebf2so1862117f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 09:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742575007; x=1743179807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5dfJ83Y79NwDQ+8qNzxM+p5WkOeUg86p4gkdxrYkNv4=;
        b=sQDh2FHdP1ifr+hdjjuM9zb3UOf2lzxVRZCMxlPXwICKwVkXF5ByDKUUpo2NO+xsa7
         rHT3koL2aeIK96CpVBS5u53o7hsXSZvTs/O41DuuQpbHdseDfiQmYBgUci4c4n3nyEI3
         56C0yjvCtML7NVVUNvu67hsdK5xgb+MLl0cg2paN6lsmFLjyuv4XXAon2DoeVexv0AH4
         FfI5q4srAwJnjqgnIvc+xlMrgiL6QxA4hbvRJxYEqe8tVuiqv5OPYS7j/XSQP5XmZTTs
         pV3//M6X6skmM/G094GIVDpl5UUIa/4DGgHIQtqwHTE3lUveBRM7Ob7136u6bUpWU1Ca
         nIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742575007; x=1743179807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dfJ83Y79NwDQ+8qNzxM+p5WkOeUg86p4gkdxrYkNv4=;
        b=VYlwg7ugTtgEYbN6P+LD74hay4twQ1dMAjopxeSsx6cfQP6HyqimMUtMLdQm1hyrk1
         7/ItDWvmK10whCEN+MFjW59/w5oiQzYlJXBBpeAj0Li//bCMEoBFX1CbHPfiAT/SRgwn
         8HYN4sj4OPI9oWw+wwe6+LNSVcvFHPj7zGH+23OatqQO4xCmFWEPS5CmAAOY/pyfDEvJ
         U1KRIvpD+ZuTfUqRJHJFQ7XHg/YenxwqYF6vX0cd3lsbCBilkkwyG3vjO1IvYVpB17zp
         JYAfih1u023CKW6PIaTBNjqNfwopmN0EiXaGOzKi+Ck/i6a6CpcyfEp+HXxoNqIEcr+a
         FRiA==
X-Forwarded-Encrypted: i=1; AJvYcCXyqy6pms2DYiAlDP0USA1HCg0zfkoPMTmXYuI+n9LrYKWh09yEArOGfn08IIMQHjwg2F1wic/cnXxkAyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ0UGNk0LNrGre3U0F/exvSex6UPylkEfOGgKxCk73pBAD26O9
	5JhVIqdbyx4+CzomUqIjlyLRPQYdB8+YPnnWpkmamPc7P6SfwMgxt+k9Ia4F5KY=
X-Gm-Gg: ASbGncsrumBS7F1oF16ZBVHzXd7ex+Ma0pVic/QgLljaDufQBhJYo3V+I46m0390Rxu
	gO+xzGthY3mHuS0FUbbXdkpnTzeRzioA8E+R+uheyALbgeiUo5H+pkiKcTI6z1h4lFzNqz6USe2
	kfq5I7ITFR71/Y5eYQG+tlrTDEpxUn0nTo4qOjhdXQUWXsA5ox1ttmobED6dawtCD9bvhQf2RzL
	U4BIurIb+a+LJboxN4oUAc40PeWyRUo61mvqdEF+vDfRzRfhfGLjqOLFQB8QwUeMP6/yCAMKNQo
	2QgkpL5DKU4QBLEVHfVwTIlFOtQGrc3pTxUWSXFBAjYBTOk6xQ==
X-Google-Smtp-Source: AGHT+IH1Gh+yAviT4FQBLCA4J0rbTJcI0EGBOTqg0d19KW+FNDv9FqBQEn8luqW5P6A+FmDu+T7bTA==
X-Received: by 2002:a5d:6485:0:b0:391:4231:414 with SMTP id ffacd0b85a97d-3997f9397e6mr4352017f8f.40.1742575007313;
        Fri, 21 Mar 2025 09:36:47 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d440eda26sm82421375e9.36.2025.03.21.09.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 09:36:46 -0700 (PDT)
Date: Fri, 21 Mar 2025 19:36:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
	shayne.chen@mediatek.com, sean.wang@mediatek.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	chui-hao.chiu@mediatek.com, Bo.Jiao@mediatek.com,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: mt76: mt7996: prevent uninit return in
 mt7996_mac_sta_add_links
Message-ID: <46a714fb-8a14-4d24-a0a6-a22cc9d45768@stanley.mountain>
References: <20250320201914.48159-1-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320201914.48159-1-qasdev00@gmail.com>

On Thu, Mar 20, 2025 at 08:19:14PM +0000, Qasim Ijaz wrote:
> If link_conf_dereference_protected() or mt7996_vif_link() 
> or link_sta_dereference_protected() fail the code jumps to
> the error_unlink label and returns ret which is uninitialised.
> 
> Fix this by setting err before jumping to error_unlink.
> 
> Fixes: c7e4fc362443 ("wifi: mt76: mt7996: Update mt7996_mcu_add_sta to MLO support")
> Fixes: dd82a9e02c05 ("wifi: mt76: mt7996: Rely on mt7996_sta_link in sta_add/sta_remove callbacks")
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7996/main.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> index 91c64e3a0860..78f7f1fc867e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> @@ -998,16 +998,22 @@ mt7996_mac_sta_add_links(struct mt7996_dev *dev, struct ieee80211_vif *vif,
>  			continue;

What about if the list is empty or we hit this continue on every link?

regards,
dan carpenter

>  
>  		link_conf = link_conf_dereference_protected(vif, link_id);
> -		if (!link_conf)
> +		if (!link_conf) {
> +			err = -EINVAL;
>  			goto error_unlink;
> +		}
>  
>  		link = mt7996_vif_link(dev, vif, link_id);
> -		if (!link)
> +		if (!link) {
> +			err = -EINVAL;
>  			goto error_unlink;
> +		}
>  
>  		link_sta = link_sta_dereference_protected(sta, link_id);
> -		if (!link_sta)
> +		if (!link_sta) {
> +			err = -EINVAL
>  			goto error_unlink;
> +		}
>  
>  		err = mt7996_mac_sta_init_link(dev, link_conf, link_sta, link,
>  					       link_id);
> -- 
> 2.39.5
> 

