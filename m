Return-Path: <linux-kernel+bounces-565607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE86A66BC1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5008516ED32
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33A11E8354;
	Tue, 18 Mar 2025 07:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mNXz8GvR"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0056D1DE2CB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283284; cv=none; b=HUC+6g87X15R5RO1Oay9PgFqKMkwoOjFQqv3YGQzquOAtgShD7PGkD530OvBtE4QW2QTjt/ott/0g5cJidCwInimxJonHvFL6Pgsuk6my/3rY5aCTQxk4/QNIgBRMFuk1JlvKk3m7EfLM3FieStqShQ6p8yq6fToj1vpDCcZ4K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283284; c=relaxed/simple;
	bh=Ie3if0QiE8quGYnbhmI4RJUqhXhjhyS2w8nEhrhhJJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLQbQfxO3YEmyq6Ws0oH4RHl94j4PljBB70PDkpFfBU2WGMKhNeRxysXRhTi5TnlzYl97ZeJwlc5nLveQUjipgH0ZzuRw0s7F9duCSNjZR8oZinpBU+rs8ePGhnzfAZLmlU1zHoW3R8FvZJnZQq+s+1D21/Yuf9hIzAWyevciZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mNXz8GvR; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2260c91576aso33139435ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 00:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742283282; x=1742888082; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sch7la5qdb49duMOy4vFgMfr/xMO2MbtEqZ0tC+N5Co=;
        b=mNXz8GvRVxSPnyWWROXnh144OIxi65p3zvhUJSmXMoCYmi9k544L8HVvVRzNUBXrgj
         h7DIRId/X/BWpo4rcPaVD3RgYiX3DmQGrIAsDZzcvU3jrVrNEqhVlKKinnYHFNIlMQjA
         QFF/exKiN/Eeu5EM1V1u+p1pzzdaECiLsiyOfjdiN6h+FcxEWufNSgv3jWhp6C7K/8aK
         4xpu5nahnGovm0T0+jVkB2b2T7pEAR1RRc7zOlijvjci4az1a0UqM8Xn8UM0TDRXy+lj
         EAwZtS1PAX4/BM6Svg4AohM7Q6WVWn5FFQrctZF7oYuKZFmeraoFI6v7WiycmJ5O0q3d
         CS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742283282; x=1742888082;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sch7la5qdb49duMOy4vFgMfr/xMO2MbtEqZ0tC+N5Co=;
        b=Fe/72kkgSk0Xyir/aEWQ5f284H+rnhli8/MxGcoEx+ZM7Gx2WuQOodIG9EIzdKAs1E
         c1omrD1eSc5URyLHhb0uJriaNAz/Iqxk7MF2T/D6kRezVSpF7odnzLd+sKul8aI11zep
         irZsUBcQCU/Xf6S9DpTpe7D/bbaMItbXqohAP5MVrMx4YAVABT1bXvAVyc7SBKO2y5U9
         3buwdGCEFzxZ2iBr4O8ob6tATmHZvDv4Pf+XECQsmOAFIwJnV9oEfGg4qDlYhOPvoR5B
         EbFvx1g7l4kfWfUFGbDNfSHVC1YE/vqHBjZddVKB7+WEiq8mdBNVnc9T1T1oUXTN3Uhb
         MFOg==
X-Forwarded-Encrypted: i=1; AJvYcCXCr0nfDUV9rThMzYQE6CF0HoixQicT15RpTNiOCV9q72JW8EGI2djYoVlNUAwEFHQ7aShD8nxErzixWPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YylVBggnqSpG2HBM5bHAUG/rnML8iCVt/LPXYPaonGaZ9MUI/03
	Uz3yuwB0yVauhJv2Vk68MVqAocV3MotwmpA8qq8/hGx0nBP+HeaWfHHfacXanA==
X-Gm-Gg: ASbGncv6USz4JpLQeoHJdRNByYf7VVRwAwuSjrQCh9tWQIfpnDYZc4k2PSlFAgBflTi
	zxkFlrK0dPzPqY0y+gN0TnmPZNvRzcVK6NWRxxITan5mNI/6bSUS/7H2FLqoTd2kD5cfg2cw2YZ
	F3BQ0jThQjuKqpWr76a79H/QAUZcsiROfGnGuMAIFuYKV+xeANaRuHA3DRhnpiP6GSxxryxfq9y
	Ar4U8nrKd/bkyl7Z/fjHhq0cNEb9AutZ1jgHG0eJhVMtFwq56FZuzSLNQby1N0n9aZhcu/oZdL2
	MOnzkfegnE1RZ+tQhSy+DVSw/tD4CPQADMXWxTTHQrBbTaWtvFm5xHgT
X-Google-Smtp-Source: AGHT+IG5yxqfLmJatVY82JIyTMbAGWoGx5aMvFHioASOebuvnlP+jZZ+3cmaakAsF9c4YjxeoRTg9Q==
X-Received: by 2002:a17:903:230d:b0:220:e1e6:4457 with SMTP id d9443c01a7336-225e0a8dff2mr180297405ad.26.1742283282287;
        Tue, 18 Mar 2025 00:34:42 -0700 (PDT)
Received: from thinkpad ([120.56.195.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba7260sm87304195ad.110.2025.03.18.00.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 00:34:42 -0700 (PDT)
Date: Tue, 18 Mar 2025 13:04:37 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	broonie@kernel.org, bbrezillon@kernel.org,
	linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 3/4] mtd: rawnand: qcom: Fix read len for onfi param
 page
Message-ID: <20250318073437.hmunilehmqdfkyg3@thinkpad>
References: <20250310120906.1577292-1-quic_mdalam@quicinc.com>
 <20250310120906.1577292-4-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310120906.1577292-4-quic_mdalam@quicinc.com>

On Mon, Mar 10, 2025 at 05:39:05PM +0530, Md Sadre Alam wrote:
> The minimum size to fetch the data from device to QPIC buffer
> is 512-bytes. If size is less than 512-bytes the data will not be
> protected by ECC as per QPIC standard. So while reading onfi parameter
> page from NAND device set nandc->buf_count = 512.
> 
> Cc: stable@vger.kernel.org
> Fixes: 89550beb098e ("mtd: rawnand: qcom: Implement exec_op()")
> Tested-by: Lakshmi Sowjanya D <quic_laksd@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

-- 
மணிவண்ணன் சதாசிவம்

