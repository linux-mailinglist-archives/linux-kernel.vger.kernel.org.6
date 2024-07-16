Return-Path: <linux-kernel+bounces-253827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3728E932789
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63B32852FB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82BF19ADA1;
	Tue, 16 Jul 2024 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CCBLtgfN"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4249F19AD68
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136670; cv=none; b=GtOZg8SurBVz6bqVIgBmV99Z1BZPbLfBB03ujJJaNbHZyRS3XkymlSKWkqaF5ReQf+Yc56i30Fo6Yf+xCmL6hZYwwupE9iLylpwb5ulcSf20iiOX1dQidR1/9Xgz/iXwWBqM1hvSSGJrHzEdBtrdcJb0Ef+5X8J5PkI+mwkT2y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136670; c=relaxed/simple;
	bh=hqJ2gsde7kBN2UEjBf8Yu4hRqEF24u/CNTjZg4K0mfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tb55Of6XXVbihj8KNFtbQRrj9a36zDHOshaKRcnF3RXktBtLpcWWDbeycih+/xCKq4zcuUvr+ZDM0IVpaZNy12aZPck3Zsyvz0p59N5G0WlX5Bflxy1vgHDhcUcNhenpnVSxWj5wWi99FkSCu2M/K6gJFIjQOCby0tyk4MFL1uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CCBLtgfN; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5d31ef2c73cso271803eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721136667; x=1721741467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YbLE4D7cXU/UIoD+S3fx1M8F1qQ1hLWwZEveTtY2G4M=;
        b=CCBLtgfNGRy+/M6h4deHX+GafWdjnh098VzSsQiDM2eiBFDAfa92pu5SGUv4GOEgEG
         W6EVcKzrObvHqqE9GoG1K+6Ln1SgA6zJ+sTdxwmat+5HrXxCMeWLqLUwDU2BUkOQWqYN
         GPoeft3IDahqWpjBW5E+7Di10B22/BJId+BIQDdWFSWozoZf+FS1D/eg+86e7Mlt39qp
         gxAF0W0CIKduHA/Sv+imhsaT3nWRqs9hQEzPfoF8JwKeTFPnhtyTnzPFlHwzHgIAxaZa
         /Msfn+eUAy16v4oUK+BVLqKpu9SoBiNnYKC+4ihdhgceY4dEQsDkle0oIjLxOA6b5ip7
         /zhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721136667; x=1721741467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbLE4D7cXU/UIoD+S3fx1M8F1qQ1hLWwZEveTtY2G4M=;
        b=fXLG/iIiSBMg0GlY19yMwV9rxDu7SHAamzbD9nX+5a3P4Yw1Vt9HXpXNmSJkta+fs2
         J31kWVRgdNJUl4KIB1/seuOwJ5Nf+6bGrvpCVO+rwKNAxUk44yhen8D5ohntiuNkNdxN
         OMR9NwlHhHLiDXZyZWnPiL0pE9GO3eiuc9PkjHY+8EOy8wNs9k1IkljfIV7It8Vb2RmA
         +m4VsDmR5lRe5ks5wBGbhHr5ELGd8ckf0e0DurCVu6KM78qPiw+xn3iB7U0IjirkwSoE
         n4q6F3+83vfju1cZ6c1CNZYqkDkUsQ/cliIlQicLq95a4mmcQIQ60Z+wwSVU6zERLCCD
         iD4A==
X-Forwarded-Encrypted: i=1; AJvYcCWiMT61kiyPs6H2vLaYx3BNi5Jsx5g6dIrOfw9Ufrg0G/rzFoAqlfGA9nWJYoO7+zFrYFFiwWSmXFzdDfHCNJuCA9a9C8jNx7dfRZBe
X-Gm-Message-State: AOJu0YzT+7ZHnTeBhuoqcLLU6MuVnnWgMYBQgJFMz5fB3J2PAxzrQJuU
	3aJamQe7S+0XZULou9rCywY6s67LxzQk0Bk6nW6bGRuMROSVaNcvZJSAYhSwms8=
X-Google-Smtp-Source: AGHT+IHD7UKFr107jvXRoZeC323erDVlh/zenswtkNDTafomjSvAL2SvD+wvrcQyfb8I2kV3+PQltw==
X-Received: by 2002:a05:6820:983:b0:5c4:4787:1d4 with SMTP id 006d021491bc7-5d2897f132cmr2339179eaf.5.1721136667369;
        Tue, 16 Jul 2024 06:31:07 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:b5d2:9b28:de1e:aebb])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ce757ab0ddsm1106321eaf.19.2024.07.16.06.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 06:31:07 -0700 (PDT)
Date: Tue, 16 Jul 2024 08:31:05 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2] power: sequencing: fix an invalid pointer dereference
 in error path
Message-ID: <d0b079dd-28bd-4e61-9352-87f5a1b72d09@suswa.mountain>
References: <20240712194004.241939-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712194004.241939-1-brgl@bgdev.pl>

On Fri, Jul 12, 2024 at 09:40:04PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We may end up calling pwrseq_target_free() on a partially initialized
> target object whose unit is either NULL or an ERR_PTR(). Avoid
> dereferencing invalid memory by adding an appropriate check to
> pwrseq_target_free().
> 
> Fixes: 249ebf3f65f8 ("power: sequencing: implement the pwrseq core")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-pm/62a3531e-9927-40f8-b587-254a2dfa47ef@stanley.mountain/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> - check for ERR_PTR() in addition to checking for NULL
> - only add the check to pwrseq_target_free() as anywhere else unit is
>   always set and if it's not then it's another bug that needs fixing
> 

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


