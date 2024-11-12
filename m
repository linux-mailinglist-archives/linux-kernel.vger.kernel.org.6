Return-Path: <linux-kernel+bounces-405402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD2A9C50D1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02FFD2821C4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D440F20CCFF;
	Tue, 12 Nov 2024 08:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mRxybAQx"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E09E20B80E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400604; cv=none; b=N+hxBNXaXxTFF+MPGux/3Pcb5AQeJ/4+I4doktM0r9DkBJEx1QwjG1D+UDHf0PnYOMM3YPs4D/cP3fzRRPPaS3/O0UlspEEhUmz2OxGepe7UNhpMQtAV0/eMHLimvTQCRAewT2Xw/YEiJ+q3jGlQqHrtGgk0CIxC+FOWVwn17SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400604; c=relaxed/simple;
	bh=zSXFW/oyFW9vE6iFtUr8ls9uKO/cy2uyRakjkwXxb04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rxKfiTX9LX7lSLrleD0ZffkfiHo5Cy2gpHcXlDuZo+oeHTavFR5gTAZJYtgHWORetxDTsBnn1shZFTuN49Td/3igefJNVwlelcxmlNp6zQZTpz1qUcAlRAs6zfpuC5CWBZqzXU6eITJiBPCtXdtSl9C7AlZbTH4RjGibJEyMH1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mRxybAQx; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d4fd00574so2957729f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 00:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731400601; x=1732005401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkF//j2lyFiMSsO2mZwpCdvFZLUTEGIV2xOA7nXV6ZY=;
        b=mRxybAQxi5yrxdGt2W6w34owZQSfCK/smmM33AvNetnT3pw2uEIRh9ageCOcD3FTFn
         /f+07PmiYXK5D6OtKSkylquxOydq8Wdb3LOql6sUkKn0ikhjrzJ96Nn9dSkDl2++9fZ+
         4pyGL+zPoHQZJh1lL8VTFfa5cAPXG+UzxRoApWla548bCoSzGKEqtex06n/kQiBgz7G5
         B59taJdHIk836esvJwzhewf+qhgbfOWHnWswQNfWMlo28rFXHIFi4bZasOUoQFCN9EoS
         FCudjHzC/V5x25YHoPT4BiiEpePVuHnbI97KjPEOoKXf5McMVlAP0uPVfIVVmTyIKL02
         QEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731400601; x=1732005401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkF//j2lyFiMSsO2mZwpCdvFZLUTEGIV2xOA7nXV6ZY=;
        b=k/CWfbSzQ7Zdlf56iRBU7tT6DznmdR7TyFZP5OWLMGeUZK1nDPDB4xep1bVgEnElJZ
         ROYyX1CdWKQn36gG3Ew53QGDrU8uC+/lCdX1y36x7OYN329mzPycLExY7ukr6cT7t/Pq
         v1lGocb7ZoHMrQu0RBNBhBOu3JTTg9PXPtQbWjQkQRezIW1aC5K1fspe5C1OrdxU62mc
         aZJ63O62byW+Rdap2+hGgujoPYyTo2mKDCXeI+tK9/wyC3HJxyJi8LVlZIDoZ+sn70LM
         9QqGY9LjhIpq0p1+Hu+QhJll6UWoCzJGkeqfVRcNO6w2Z+Nx7R/zxqqaEZsbA/uIDzF5
         RiuA==
X-Forwarded-Encrypted: i=1; AJvYcCWEK46f0miCkY9oAHBGOiuHBiI3XiTjhipwBI+jUjb3qPMDxXkVopJj6n+Tnm08dJJSHwB9SRm6lGhp1Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTvMjamTNlkny0HsP1QMI41AXHOxaBnuoLjSgK/cJklenx3MGT
	nHhA5ot5oMk3SG99xTjqJPl7a3jaGJASMvDcqlFeOxnmG/CuqLFUb9dxUtNCot0=
X-Google-Smtp-Source: AGHT+IGMqfX/H5pdDKyvAVJcF4DgjN4iAMagrtLPcRu2CX11loCBxf1pGfhSsH4z13A1w54+Oo3HoA==
X-Received: by 2002:a5d:6da8:0:b0:381:eba9:12c7 with SMTP id ffacd0b85a97d-381f0f871fcmr15140698f8f.27.1731400600525;
        Tue, 12 Nov 2024 00:36:40 -0800 (PST)
Received: from 1.. ([79.115.63.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6c11f8sm234562515e9.25.2024.11.12.00.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 00:36:40 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Cheng Ming Lin <linchengming884@gmail.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH v2 0/1] mtd: spi-nor: core: replace dummy buswidth from addr to data
Date: Tue, 12 Nov 2024 10:36:37 +0200
Message-Id: <173140050742.5304.12768268448288985195.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112075242.174010-1-linchengming884@gmail.com>
References: <20241112075242.174010-1-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=975; i=tudor.ambarus@linaro.org; h=from:subject:message-id; bh=zSXFW/oyFW9vE6iFtUr8ls9uKO/cy2uyRakjkwXxb04=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBnMxOTQiqpBhQmKEPwUCUncct3k614561DJda1y gnFg4Uxfa+JATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZzMTkwAKCRBLVU9HpY0U 6ea4B/wMqM79quNktN1UOacNKNdprDvPzW04PD7vlFaNYE7vClvp5DgDCVCAfrspaKY7PwqPSrC 5BlxnEg7Es/YqReZkX4CNalOorLLz3IerP4NtYnPXeuNtllXE9Qvg2P7w3/J4RZqb4Zw8b0Xe/4 vASoQqhlAdasKHJN+o2e8CNIlce6V5ACNOJWduT7YLRXNkxU79dEKJ07Jm0aM/Vu1eykvHJRLmV /oRpKLtzlw9ErV+5dqWuSIxO56XtkFDnjYTNgF4d2CWCnSud40XJmrpCWEx90Zu8gPvKe5qDLtc fDdWzVUimbLKwVGnVnBk3rEcAbohz/41Q9OtIrssgQBGy02R
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit

On Tue, 12 Nov 2024 15:52:41 +0800, Cheng Ming Lin wrote:
> Set the dummy buswidth to match the data buswidth.
> 
> v2:
> * Add fixes tag and cc to stable.
> 
> Cheng Ming Lin (1):
>   mtd: spi-nor: core: replace dummy buswidth from addr to data
> 
> [...]

You had some warnings which I fixed while applying:
WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: 0e30f47232ab ("mtd: spi-nor: add support for DTR protocol")'
#19: 
Fixes: 0e30f47232ab5 ("mtd: spi-nor: add support for DTR protocol")

WARNING: Non-standard signature: 'Reviewd-by:' - perhaps 'Reviewed-by:'?
#21: 
Reviewd-by: Pratyush Yadav <pratyush@kernel.org>

Applied to git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git,
spi-nor/next branch. Thanks!

[1/1] mtd: spi-nor: core: replace dummy buswidth from addr to data
      https://git.kernel.org/mtd/c/98d1fb94ce75

Cheers,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>

