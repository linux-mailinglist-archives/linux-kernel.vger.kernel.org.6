Return-Path: <linux-kernel+bounces-550547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3927DA560FD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F4C41893A1D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA23719D08F;
	Fri,  7 Mar 2025 06:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y18z6bwF"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866CE154430
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 06:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741329479; cv=none; b=nkMoa3vPjUCy0dIziDaiWTvWqqqqaAcg1NK+bZdC0xDoW4qzIG/tpqPQbtMVHQpcprsPEqOiaT90p9F0LLb8MnX6EYPFJPBOzW86eUpff7UaS5nZicA0BQjIhCDtOjr+XIf3WSRhDxJCBAPvEmTiPTWkRW5x/D3Xv1GiOybXTJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741329479; c=relaxed/simple;
	bh=ZlcUYr5yWu1Y7clLcILm0C/oZAVn3s/8qp2rvM5dxIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kUEK6FGW1x9Uep+/cLOc8l9Dmh/z/pCq1jxBQdBwo4IyQj4/OC1ZiB0dLgv1v9a89nYRkybY0Z/azx8pI43R7asFF4C5CLm+xSaQNTM+zfAs6qfj1I54lTd/0l1/0tNdtsg68S+dGijGSR57qv36czK42HVx6Kyncfqk/t/VJKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y18z6bwF; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac25313ea37so96703766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 22:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741329476; x=1741934276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvkljfI5OM0sWl9hPIx96BIVm+ybsghHFKQXnESRZdc=;
        b=Y18z6bwFO7DN6srvJX2kx83MsCpcOwGGaPn4W5SQ1ujVUV7rTDNsCjhrL0Ml6qGhcE
         Mt1G04PO1I95kgKZSMIGeCj/9BbuMefOLfccH7NUQUu1uBnkTCztlvNS/XOMEvy3IwPe
         dJoWs1wHT5P11iGKj3QQPcQiSb2TK507EoWgs2NqaJcZihsOzKZwi0zXvGaY2tnkh2TM
         lQj0CWH8J+X1FTnZplu+VvV+sJyiIkB43KOIPbjmr/xs4uQ1Gkz+Rft6tfxlr77DqPhb
         ob7F3nu4x6dvNY9DUaRmRaPEx/2xQQ0Qy6VGUoyhrhtsufNlWxUfb1HpocNdS/sXRw5I
         hzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741329476; x=1741934276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JvkljfI5OM0sWl9hPIx96BIVm+ybsghHFKQXnESRZdc=;
        b=lBfzI/8Rd7ieKxStzt4NsNHZ5T0UJPtFUfASyS8h43RDqUIQn9Z08T7oe6OvpbvpWR
         8DtYVBQNozQEyCs+OAnTX/o5nXnNHF0F9J8dvDARpf6a5WBTDeIIS0y4qJwUypxau8p7
         f+LaZQizwPd1R29isdup14SK9hBee+eq2CJgxNC9zrUIIW8tfYsFXRXv+mawu5oXaXsd
         bB+jCA0XZFhzGTfU+f/JVSuwLoxiSz1GmiDU2xBYezBaHysXOyW8fnZ9z+7xI2VpsyWz
         C9DcfkjfRwiKCTXi7ZigyrPjnxFjp4EVZ4CDa3ol4GZ5tC14kIdm55p2OTsj4WJYIBGc
         UcDg==
X-Forwarded-Encrypted: i=1; AJvYcCUn3ZYnPi4BN2aLNzI6eJko448yQOlAuQniEsQuRhxlCxB/0aC3MDeh12/eOymT04hEm9CAxiliU0O2nvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOfODuTQvXgU3grZykxUr7q8ZHF1wuRQ8Ap9DqM8RHnnWBNdFm
	gD06XzKjqfJz6m3JwfJLiCARLsD8BzNMc/wwQgihSRPzBdAa0PUWD1HEZKU0SDc=
X-Gm-Gg: ASbGnctktfMah/y/M9EExou3vty93dPvmjU/SuCGQYCqcYwqqJQhtZ93ebmmlQK1fle
	Z6TBHqNSAiuQvPP/8JF3fkxB4j84d8ZklfCD6v/p7GbL47oqOZZ3KthfdcEfiMVjG6PayTwzD/y
	0pm7UcJClMAjENed9zV/OdVW80Q/1IKztGgY8QIjfnvxiVleVOa0aZs0vhTfFSZ7AV9R9tf4CgD
	q5LjpVpo66H1GJtG5RVjl8sd2E0zIPg7jrkCtE6IkeANk2e8T7O49pt7ehRDYYragGuT5X1q+1G
	Fwd2nQNgy7UeYsyIDIlgVS5rxAUBZ8/bmYBLKc4=
X-Google-Smtp-Source: AGHT+IGAzarraGWkhYKF2aTj2OCEKg2OAAe1utyZfoIrSzcKIpARDi+wNx+p/X90R1xILbhUDICHyQ==
X-Received: by 2002:a17:906:c18b:b0:abf:614a:3e48 with SMTP id a640c23a62f3a-ac252ed5fc0mr176511166b.50.1741329475752;
        Thu, 06 Mar 2025 22:37:55 -0800 (PST)
Received: from 1.. ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239482f51sm225778266b.57.2025.03.06.22.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 22:37:55 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: spi-nor: explicitly include <linux/math64.h>
Date: Fri,  7 Mar 2025 08:37:49 +0200
Message-Id: <174132945851.15531.6338270338581445804.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250223-snor-math64-v2-1-6f0313eea331@linaro.org>
References: <20250223-snor-math64-v2-1-6f0313eea331@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=565; i=tudor.ambarus@linaro.org; h=from:subject:message-id; bh=q3zzBEY1XijB7r0+7n9D3yoMpNzHtPWPJDqzNUhAJtM=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBnypQ85Vv9iFmzI5fD5akMsgw/nvBAKM+8Bhnb8 x2tnGiypiiJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZ8qUPAAKCRBLVU9HpY0U 6VPxB/9tWJF4xjammgHjVF+J0hBs8mkEpcKwI2q3mYER74YmDPqBoVLHKYHvZKxifAe4mmCah1i +MaWFN9c97J9sS/FOo6dTGWPD/I+m2N+qt5a4nDLRDZl2F+hAAu4E26a0QtmJ52bhNjtch7T6gD t5puPwLqMJ2IkB4NadKgYjIA7+gwThifZ1qsV+KNKiIWm4BeL0n/FVuvx8eTc5DBvSLJ5jDiLs0 /OCwOJgQ2qH0SUcmGkcNAOpOQJgHryEOirJ9NsP/2DQtBwcNmLoyi73vYbSMofS4tWnAwGusHH/ tYbp7OznTA8/hNQDsc9zC+DIsauWqOBIQKViF0ii7vw+uQ13
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit


On Sun, 23 Feb 2025 06:51:10 +0000, Tudor Ambarus wrote:
> swp and otp drivers use div_u64 and div64_u64 and rely on implicit
> inclusion of <linux/math64.h>.
> 
> It is good practice to directly include all headers used, it avoids
> implicit dependencies and spurious breakage if someone rearranges
> headers and causes the implicit include to vanish.
> 
> [...]

Applied, thanks!

[1/1] mtd: spi-nor: explicitly include <linux/math64.h>
      https://git.kernel.org/mtd/c/93020292fea7

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>

