Return-Path: <linux-kernel+bounces-561736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E9EA6156F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D914F18945B5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573FF202C50;
	Fri, 14 Mar 2025 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQhFt/v9"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3251202C36
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741967789; cv=none; b=SCMjqTzmQDemtPsPkycdLk/Ln2swCAiQ9E0hQ+IM4BR+kcaMk0gZGmdltN5RicOXVRjhuHDfzUkGSXF2Grh6/Eu7W1m+Ih3fRd+YNrRGIFNpxq0bgbta6BjCRb/jGyUuSjA0sZ1nrRr17/AZ3JG1rSx+sJsTEm8VmViA0KuPKD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741967789; c=relaxed/simple;
	bh=I7WfoJdrMa7iiui5bCs39L2nw3ehuuL7qs8ypQidpC4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WMGuqgg0XkFpL7Vrn3rmL6M9zOCDSbrdwIecKIRInYNCwFuIgsQAzqFzpwE7yog1zT5nf+j3P0NDvgQtgj5F8Qf0T9BDm7OI6HCV2SIoP1LsU73u7MeAd9MMkBhZWQAS9Q0G94owhtKlsjlCWl9mcoJg3mUM9VjzyQw7VPaeNxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DQhFt/v9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso15431175e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741967786; x=1742572586; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I7WfoJdrMa7iiui5bCs39L2nw3ehuuL7qs8ypQidpC4=;
        b=DQhFt/v9nfss5saXPC3XavcuxWFTs4+kZPx2c6sMgZkJcT5H1QyDCwtx7KfdHdWlw4
         7qQGuMQZgaBFbOCq2rKep2nZXV4jVkdhzAMei0ciuvz5tj9fDVWocl29IQ5N0HVrtoxi
         qZoORn1Upqt4+iAu2iKRBh6rZxAIShrGJhidZC6nKs4+eYBChyJAANDqmDy2i8e+mmlU
         aIeeZP5GQR8SDlhuM80Xd6jvshkKE3kgLExTbc0zSbBUZVkXxInQW4WCzayYI03RAXmY
         71cLUcY7kYAXNLd5nXtNINmE+UDyQzVZvkH/8xkOVhBbjKkm0FSmczHgk65WUzsUnYhA
         zMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741967786; x=1742572586;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I7WfoJdrMa7iiui5bCs39L2nw3ehuuL7qs8ypQidpC4=;
        b=Cj39cw+LGJ5JukhdO+1yQpllwLYIUIRSdnq7u9hB1vlhLepxCHUynuoPgViN6ET3xn
         /Vmoy1bY5ZDtFRpMN8GqRkSqM9P8JMcw1oq6BxhyFLUCg4i1OvkUGkVySmGppch+Fvst
         3SbOoTppYg+gsp0KEphfzFf/nS2DgVjfTi6Jg9B1z4E+g/hgI17lwbYfXcNjvj7dMhbZ
         n5JgHrpYCkG+PQt+kpmIJ72P3paQrZwfL5TP0pweCfXbxYFjGzbLOuoHonPDv1KtCOaY
         du8u6nH+U78PB8XomYqK9TRHUuisL+1Yqh9XQLB9K/rBlHu1m18pqiwLodfEFMMG1wrQ
         TFxg==
X-Forwarded-Encrypted: i=1; AJvYcCVxl36SEj1O+mKHBGh5Dw5ofYjy3Z8sfIvN5K0qmWAOvz9LPldjTVxWru715EWL65zX/a5dQdoq2KqD4iA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9dXvLQ2wntH8eBVh/tUw9R/Jgs0fELi/syt3J++jZxXC2w07e
	tmQlEtCZAe2C/SsiVHQgCDkvVGa4/zI2eXzHxNyyJ0VTpG4ry7LK/6hlFRlgObc=
X-Gm-Gg: ASbGnctOz/8fTHNY2uokl7auACX+HNFCDZAvGhxr7Zn9lG0M5Gt2j4YsiYqJu+xPtAs
	Uxf8OXJz5jfkMN2LvVuLY5k+4SD2LZ/jV5RfvIkTpMd9s/cj8KUr27rzHn25VCkiL6THeBEah1u
	bwBezOt236m+088yO0BNaMEroTrvJ9U6YT0seGqlFUSRAWMYnAIVM7PnrecpBnxz4sqPUaAVCn7
	R9LFYBunInCvGPHNEYWDRH3wtJzE6O4MFJ/iKyYmszxEc9jvDcpd6QqHZPKfR35CQCqkB3qe+X7
	69UpZt0h47lRPuO4fb86uSfTNdD4c+ytPTO/PTVRnxiUCkan+hMdEU7gmT0=
X-Google-Smtp-Source: AGHT+IHCF3yVkeabT3o+pvpbobh6GwFZochyn0C61kckJRZQkd4Gy9mZ0YDU7EMFdvPBpYowc1DQVw==
X-Received: by 2002:a05:600c:4f87:b0:43b:c6a7:ac60 with SMTP id 5b1f17b1804b1-43d1f235e45mr40033045e9.10.1741967785964;
        Fri, 14 Mar 2025 08:56:25 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe60b91sm21467905e9.31.2025.03.14.08.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 08:56:25 -0700 (PDT)
Message-ID: <8ccfdccefaf0cd651a3f085aa78227907f03a478.camel@linaro.org>
Subject: Re: [PATCH 1/2] arm64: dts: exynos: gs101: ufs: add dma-coherent
 property
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus	
 <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Alim
 Akhtar	 <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, Bart
 Van Assche	 <bvanassche@acm.org>, "Martin K. Petersen"
 <martin.petersen@oracle.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-scsi@vger.kernel.org, kernel-team@android.com,
 willmcvicker@google.com, 	stable@vger.kernel.org
Date: Fri, 14 Mar 2025 15:56:24 +0000
In-Reply-To: <20250314-ufs-dma-coherent-v1-1-bdf9f9be2919@linaro.org>
References: <20250314-ufs-dma-coherent-v1-0-bdf9f9be2919@linaro.org>
	 <20250314-ufs-dma-coherent-v1-1-bdf9f9be2919@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-03-14 at 15:38 +0000, Peter Griffin wrote:
> ufs-exynos driver configures the sysreg shareability as
> cacheable for gs101 so we need to set the dma-coherent
> property so the descriptors are also allocated cacheable.
>=20
> This fixes the UFS stability issues we have seen with
> the upstream UFS driver on gs101.
>=20
> Fixes: 4c65d7054b4c ("arm64: dts: exynos: gs101: Add ufs and ufs-phy dt n=
odes")
> Cc: stable@vger.kernel.org
> Suggested-by: Will McVicker <willmcvicker@google.com>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

Tested-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>


