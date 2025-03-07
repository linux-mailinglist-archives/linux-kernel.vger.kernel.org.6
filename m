Return-Path: <linux-kernel+bounces-551428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B147EA56C4F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A1C97AA7DE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D128E21E0A2;
	Fri,  7 Mar 2025 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NUA5GE16"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7398621D3DF
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361989; cv=none; b=qMEZeqQ1XtjePNUIuyRVmXtQAQqkyNqyJs8mh6c4LPdPY37TgL6KlFweYWE4jJh+LY5Lk9CAyBIZS0vH8a7dUVrs/wCwhcO1XhyiTqMEFxcqIU/MAhj2u5rjEyMpfRlMMDPcDK5w+4o1Xyy7HC5+gjcA6BJK3ud1eNKSaZ4W0OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361989; c=relaxed/simple;
	bh=cFaihPn015bfDllZvZJrY2c7R0fEEw/M16SbO4kDyrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gdhh1IgsV0bRlpd3q79dwSlyxkniPIMcdV9WfwgvVDAEN0CVNm3jl2qVxGSEHLF0l4BZ3M6uRqnia6EodZ/USIfzL2fkxqzWdDSgffJsGfiKlRuw8ExGSQHpGzpwWzZlRXL8L552R3h0gJ1ThIIz+794CLvJ2iw7m8gzDPxSmJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NUA5GE16; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abf4802b242so363016066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 07:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741361985; x=1741966785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eJnVPeYafZvgHsrO+i6TK6Bs+zps5W9oOYtXQuffALk=;
        b=NUA5GE16MUGUuYP+485he0gsfBWGJPlHSOQRCYJoQnLWoXR2Yoc32Ah2Xz9Rz7AeUv
         NacTbN4iz7zbLtiaaCYI/3hs7r45C7axG/Tq5iJt1GCv9hzEGhKJcoWXDn0wxIXcPCVo
         zSiNzqYlc8cbvr1xRBMxnbeYp8h1r3Mh6xwIRDBK9zY9PhAx9GOCK5M0uvOoQQ4GmNNQ
         MKeLDgJtol6Bh8gbvGw2VEdjwzZn2+J9q+HbQntxJPjZswsBoX/rUoo1yZARm1HA2VVb
         5QSR/u9ftibhM5pBH2jfNtIDF+OyPfwbNR8TtAmdXx6SVJUUGu426y1rWXyQyT+foTrn
         EpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741361985; x=1741966785;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJnVPeYafZvgHsrO+i6TK6Bs+zps5W9oOYtXQuffALk=;
        b=OGyz8yZhocoT/x0CbayC3FtaZ3G8BHqI2RnO731BNjqVnBzkYXOPqUMuyxZBEYbMCE
         FTIKhCxZgchSiSdiBH7HUiZArTKvMeITNYZ2VLz/ml4/Ouj29ATlLEDJzdFDWmv+j+HI
         Uf0nl2X5CrLdg72POjOWIXw9HzMNwcSr9OW5I3RM2eG5F9V8cy6yq9QGiCu26PuX6h5n
         Y/KXBlC4mPDvrfLgmrG9MLg9qGYt8drKm3eEviWMKyArbtkG6OS+U/l4wbTX3DjFCCAf
         dPJ7Dtf2rnRzQ9DBBPV+n5879ARbd/n7c+NkronwY9idMD6K+/XOVIh5ebI5lhb1lVCY
         7a6A==
X-Forwarded-Encrypted: i=1; AJvYcCWOhmO7fG7e+ohtyX80whcSsFKvaRu1n8JNq6EObN0t4ESSLhs8XY2cs5WnGd05iW+CHGX6IYhA5NWGYTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQyyJJq4kAEKf4CJvVfk3g9jsGnSvwfzRyGTNI4RtUtmMwcTWc
	XBOlAHTv2d7an6qnQBN6imInGerMRbf3x+Q5T5F+DRV4rq+USxAEdz+ccXM3n8M=
X-Gm-Gg: ASbGncuAbfoMsDhxt5omOcIsnmtP/Q77Q51HO2bqmzKpmTSb2Dsh60q0GwLd9aaP2IA
	Opy5+9GC4zm3t3xTDnUQiKBl+NSsU8rKFiCHh8dFlbTPrn0bydOJwFUAJD+RyTVkTOMlwGRG+Kz
	DcvWl525e6KiMZkWdLgoQD5F11uv6fX59b4To0XYHo/xHXxFRu5OWOjgDp8jtW9XzRdSS4TsFfv
	81J4FfSM8pMxexj2VPcI9rdZv1HMzUWvdaEj+Z+i68TSyB9MeVXgIAp3lIs2HRfB5SRNWy3nYQN
	NnU416tTKAi1EF0aJvwnyX3/x7tIgUSXKyWZAI2UjVe+9EKJfY+n/A==
X-Google-Smtp-Source: AGHT+IGuXNtyZP42uxMpXFuXCVaR2WuOwofap6VO1OWEa4yHj33RgMikNGqzDq06MdXQjNJZWtTcvg==
X-Received: by 2002:a17:906:f593:b0:ac1:db49:99a3 with SMTP id a640c23a62f3a-ac252fc6bdemr449710966b.40.1741361985480;
        Fri, 07 Mar 2025 07:39:45 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239488be1sm293181466b.74.2025.03.07.07.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 07:39:45 -0800 (PST)
Message-ID: <80da4df1-cd35-469b-a636-8f405358ef00@linaro.org>
Date: Fri, 7 Mar 2025 15:39:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/21] mtd: spinand: Use more specific naming for the
 write enable/disable op
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Santhosh Kumar K <s-k6@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <michael@walle.cc>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <stlin2@winbond.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250307-winbond-6-14-rc1-octal-v1-0-45c1e074ad74@bootlin.com>
 <20250307-winbond-6-14-rc1-octal-v1-2-45c1e074ad74@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250307-winbond-6-14-rc1-octal-v1-2-45c1e074ad74@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/7/25 3:08 PM, Miquel Raynal wrote:
> -#define SPINAND_WR_EN_DIS_OP(enable)					\
> +#define SPINAND_WR_EN_DIS_1S_0_0_OP(enable)				\
>  	SPI_MEM_OP(SPI_MEM_OP_CMD((enable) ? 0x06 : 0x04, 1),		\
>  		   SPI_MEM_OP_NO_ADDR,					\
>  		   SPI_MEM_OP_NO_DUMMY,					\

here too, I lean towards keeping the name as it was, but maybe others
can jump in.

