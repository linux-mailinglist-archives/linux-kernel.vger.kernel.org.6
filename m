Return-Path: <linux-kernel+bounces-550540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD00A560F2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12595176B35
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6CD1A01CC;
	Fri,  7 Mar 2025 06:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zzu0zy15"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4F119F13F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 06:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741329330; cv=none; b=DI8ZCxWUz9tydWGer8imvhfdnqKUSyzpqs/tAhTJV2Nxin641pH0jNp61z/XVhnNp1z8bvu9/DWOO/ybqr2NSQmDTuiPqTRJrCK0XiHA7wDBqRGSWS1veXNVTX0vv25xGmq4tZS+GlWcr12f34WJcKPNObeO2dhiv2j36rKS++Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741329330; c=relaxed/simple;
	bh=0uqoWEgzpYuN6zDTqvNJLl3F4SkXsdkSom/6bW0VVtI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UOSNR3B8u0TiAaZMmR2Y1gfgk8QRqvTqO2sXfa7Kc7KbF8+6DZCV615eRNYFHVMp+9WA4HQ8NvZUlgHANkszJxAp8L3T3R3WEegmtgrvDSruFVCzgKu2ao8ezMJJTzgARov65KdTUKzAs8y3DRj17H3q0FuyD9tscdxWLwPuy2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zzu0zy15; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e4ad1d67bdso2255433a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 22:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741329327; x=1741934127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xC5VwCWT2LJCm6ZRZSOjjJkdJ8MXuyRlJ6NhhOHusZA=;
        b=Zzu0zy15zlgowuVH4Hj/WubB1zcs0p+6sjWDWS9yWnUI32UqwiESIWhPRUMUm7eLwF
         Jr1SaD0iVodIReCNyilKlwUcUhBZr7FTOjiw92oBPhaWZZKcvlkLh0SvLQ7hI0Ctt+FH
         QEzjsaVWKCggmT+N5H++IZ88Cu8GBwiST7UhMO+BmxBbUK1EJawO8SdKBO++rwC30qZg
         wno80PNm70pwy4PomtKYgvQ75rUcuItgkgEBve5fw7OGzhbqJzvVEwLh8H6i4XlQGgTl
         mSbFQ17h0oNWph6ZuXh4SE2j6XtZc3rrSvB8vTcdX+M9l0zV3BSaqf6s/RZzHKkw3qNI
         +tbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741329327; x=1741934127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xC5VwCWT2LJCm6ZRZSOjjJkdJ8MXuyRlJ6NhhOHusZA=;
        b=fgQMk16TFUcm6c5jR+dOayghw2mn5CUABNEzamfmaU8bPaMT1vRHfinR+wFqfI3fzE
         j/auC3+wYVTp870Ti6+AI6o/4xBowGs1ISzb32W9BdQlWwuIgj5Znyf5IdDFoVerGb1O
         /qS/QP81PaTLaPNTsXzNs7IkhspqbeAzHS2lnWyul9tEniX0yHGPqNYovuAadwx5y9O+
         bwyJPmjhiQJja0CDm6k4AdoBNfUgnACLGzm4ReqUn/NFFJfVxpTLCOOAMnbNamR1DyEz
         XAacQsvToD2qiKuS8SJZcLWgQtqRNv2hC8HRZHomRVU8JWZVRjD5Wuo9PmTY8Yzj1hoT
         tEsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsMw9MBY9liAMVHayhUZUtQS6Rgh5aBeSpuL8fegnijwoGYnCrGGANGNAd38pMZbU7XL+/hu121yyUnPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd3rwIFKxRVaJ6tQZNemoN7T7e/Aae/XdIaZgiD89JOP4e/C/D
	7KbtHIqT7rIXmED2D+jOlsZefzdVDAShEItz+FIg3TJVxl08oLfuhMwTuQDd6PM=
X-Gm-Gg: ASbGncvDyiFbrKwh4RwfCjaeH2Y1J5WSUEKFGCcW78GdhEnPPWFm7qiQOipALmeY7jJ
	Nf5Oij0WYnNuoRsSkXU0wAf9pHAuQjV5SoSjJTuw1ryJNRiTIgJRGXwTUM1+e3YlmyP8F6prtC9
	/Uuxx5IrWhzINTuyrJhRGBcjTLRlZlZdKgM4isXiiOU+TZuYxMtf9A6ZkF1zP1bJnSvKnh/cXuo
	wId25S2KPrkLii/sRG8/VWMKnXwIKQby3MZLH3VQIZ3PIOQPXUfFtfe7uwXXgZz1ebl0N25cD+h
	lCC0IzQSERRHFuB1Db/LNIaLROrFSXF4qjKQlYc=
X-Google-Smtp-Source: AGHT+IGmV9SnVFHLoe52Ux0Kua4ViyrVZwKYM+EnPJMxaRyCAPo1MU0AgZT5uA54UKN88UQv/AQseg==
X-Received: by 2002:a05:6402:4405:b0:5e5:2c0a:448e with SMTP id 4fb4d7f45d1cf-5e5e22c0718mr2151757a12.6.1741329327171;
        Thu, 06 Mar 2025 22:35:27 -0800 (PST)
Received: from 1.. ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c74a8f2fsm2102492a12.41.2025.03.06.22.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 22:35:25 -0800 (PST)
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
Subject: Re: [PATCH v2 0/2] Add support for Quad Input Page Program
Date: Fri,  7 Mar 2025 08:35:20 +0200
Message-Id: <174132918169.12801.10830790202971847088.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211063028.382169-1-linchengming884@gmail.com>
References: <20250211063028.382169-1-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=829; i=tudor.ambarus@linaro.org; h=from:subject:message-id; bh=VAkcBe8TuoHKHgxEi1kvuNIyeheghrDSIHviG1pL63U=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBnypOm9gSRom0HvcKAO8bjyLOkZrHZruvez9DHu fUqC9rGRYOJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZ8qTpgAKCRBLVU9HpY0U 6dB/B/97UX7pGf7VAEfye1+hDLB+vCPvTlYvqwFCXvPPaZuIaD90047BZC9X5JWrP+WPm2/VkWz i/fws302J2Stuthpc0CYAE4kSNSEhUTkTGTqTX0iC25n1LqiV2BjeqCklnfRsKmPAzaLmYWtve6 RibkZkrhKzs3Rk+SgpSUNwr1p97i2bQU89280tIw/CF2EAZG9QsQ6pPrqUSOsG5UXNLavC2w8eD j4brIV2EwXYgnZlBRj9BWj1dTxra7oABIR04uD9X0h7ek2Hz1pymiKFQdql/nDUh5smKd6g7Yzm wf1CnKd9fckTgd8f7szuXkeFlg1B0wXjiHFEqmaXeXIa5yXd
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit


On Tue, 11 Feb 2025 14:30:26 +0800, Cheng Ming Lin wrote:
> Support for the Quad Input Page Program feature.
> 
> Some Macronix NOR flash support the Quad Input Page Program feature, but
> the 4-Byte Address Instruction Table definition in the SFDP is incorrect.
> To properly enable this feature, a post_sfdp fixups implementation is
> introduced.
> 
> [...]

Please rnu ./scripts/checkpatch --strict before submitting. Fixed alignment
to match open pharenthesis, updated commit subject.
Applied, thanks!

[1/2] mtd: spi-nor: macronix: Add post_sfdp fixups for Quad Input Page Program
      https://git.kernel.org/mtd/c/798aafeffb36
[2/2] mtd: spi-nor: macronix: Add support for Macronix NOR Flash
      https://git.kernel.org/mtd/c/797bbaa7531f

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>

