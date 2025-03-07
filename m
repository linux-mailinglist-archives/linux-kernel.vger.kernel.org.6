Return-Path: <linux-kernel+bounces-551429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB2DA56C51
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504BA3AC1CA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E615421D3ED;
	Fri,  7 Mar 2025 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EgtheGxd"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DABB2E822
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362057; cv=none; b=j+IspUEPGTqH1691Gbr0tqTaSmlgH9847PKMoQWjEqjCNQZc3PALV9akjF8uMCOoCdGPHG1+ZDpS230t/p+/z6KAl70ivR1/FVX246BML6Eg373+HGvlYfcPa2RePLtxpZFcw9LBe14QGwQiKxvf7SPiE4nTIo2chEhcM6pO1L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362057; c=relaxed/simple;
	bh=x8ucU4q6SmOpheHnhUL4FJdsjMpQUlYRWnS31d2zfvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cn1fPwd18j8lZbtEOkMNqVM5Qeacb0wb/My8VVjloS19JzkAOC6qF4hXJsWZq9FZf71lf7CDRpatX1fr6dyUqJi7im8SGA452pFpdywa2HaANMSEKTVCYBkxbUpagZdhl1tXgRhtSgiP07rKxHtDQby0Njg8ntsVtj4vN6xutGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EgtheGxd; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abf4802b242so363226866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 07:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741362054; x=1741966854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eSl/dEjQciG1GeYbhromFxZ+Uhk0mE0cLN7r3JcDdtE=;
        b=EgtheGxdElDS9k3oEsQ+Zx5VGBulZcduCVYVmxDWAmEZvbQBNfZzHpSLocwL6FEJhA
         Vkz03cQa/p2nQuY5r+t5Q0wxIxqlaHNTylL52GLXr355bBZIwvwwJ7pPwz03IkDYgrqB
         JQoRRBvI+/V9JSdl61UO9M6lCheh+LpdbhMpNqyWLQ8bhXD9JwWMXUbWyxJH68nlqL44
         sydRy7Vz2FJkTYn4JxU3Z0Xu9epiV4hyNjGS9IP8WgxStItzrL9uUrpCNQWvQerMfQ2O
         XeOylwf4TpKWdp37J4qGjdUOaqnVo7NRusHiRLtZc+v3WEFmhA6UWKMwUz38v9+mKkw2
         BdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741362054; x=1741966854;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eSl/dEjQciG1GeYbhromFxZ+Uhk0mE0cLN7r3JcDdtE=;
        b=ioSELxAvfFmXHahvh+6oOFgs01lVnFFUjOJwA8zwElRkROFFAGUutMe0aXuuJQVatE
         8HV8qZM95Cex3jtoQtjA0vEtz6Yz4wcl9advTqyTldqJyTw0J3bYfEWJLAV55FB5b1bP
         2FYLBRYYiQ91Wbaf3H+AU6zeZVpFx8IThp1jzb6bkRa33+JxIGUufJoGUV3aWxj6M7ZV
         +yWMqni2mb6+GqIfr+zuPsgbwMPOd0jXTMfKY4ZwLwH7C+wzSGMHhFm1rbcxGfzK7nWQ
         y+kfz35Ns1xZlyXRc9q99mzQePpCH3kMPmqRZ426TG8SuvtXjXgjP6p/6sTAowT7pS1u
         NBgA==
X-Forwarded-Encrypted: i=1; AJvYcCWiVq4Z0ky0iTzwq54GKbL7HxCXJhrYeMcz16d78Gpc5ajXAC9G+D4o75zL7pbEpeixw09UtXiB0ALs7Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcB86t5kc0rTA34tiCly/z2b28/23PRsQ3xd4QFPgCtPJyttZb
	xsPcLN65hii29K7dQdyAYxw+Sg5+73g4KcCitrCY4RqnSmlJj29NPKOtEtkKfo0=
X-Gm-Gg: ASbGncu4FhRKBkFfvP5mClWZ7Yak4c/drkZPCCHhTTPj+00dTAcMUF/VDtZfbNzlDV2
	QrmmugjJ5SxowrA6Osibm2QcIankBTWkN+6a5vZUuTqb1IhpuFGCCCElfZosHC41fjJEQoK6jap
	sRMLUdgGfNynGqsnOy4/9RuoF6TNsYKOmbsnMco4AEZOqyw/ku87P7SCX52qcTFLStl0vg/u3d9
	f0pAAcHKxXhCOkchEL3OLtiP5qnNB4OLN83FgJ6QoU1RxZi47h0XI5kKXYxIYyM3PaeTdPuCVx+
	dy6BlCus0CWRVD0pwwLZwsQLCGgBKIIsVB1AnX3BVMv+0nbJoFC4yw==
X-Google-Smtp-Source: AGHT+IE3kPBlfRlwlVOOHzKMT+qO/vZkpa4nFjsoBxnsYH6U5Z69MZDHUDvslCagD52u87+mkZIFQg==
X-Received: by 2002:a17:907:94ce:b0:abf:69e6:4372 with SMTP id a640c23a62f3a-ac252749adcmr504056266b.4.1741362053829;
        Fri, 07 Mar 2025 07:40:53 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23948432dsm289187666b.44.2025.03.07.07.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 07:40:53 -0800 (PST)
Message-ID: <087e97d0-c91f-41a4-ab17-3d98e7af84ff@linaro.org>
Date: Fri, 7 Mar 2025 15:40:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/21] mtd: spinand: Use more specific naming for the read
 ID op
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Santhosh Kumar K <s-k6@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <michael@walle.cc>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <stlin2@winbond.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250307-winbond-6-14-rc1-octal-v1-0-45c1e074ad74@bootlin.com>
 <20250307-winbond-6-14-rc1-octal-v1-3-45c1e074ad74@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250307-winbond-6-14-rc1-octal-v1-3-45c1e074ad74@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/7/25 3:08 PM, Miquel Raynal wrote:
> -#define SPINAND_READID_OP(naddr, ndummy, buf, len)			\
> +#define SPINAND_READID_1S_1S_1S_OP(naddr, ndummy, buf, len)		\
>  	SPI_MEM_OP(SPI_MEM_OP_CMD(0x9f, 1),				\
>  		   SPI_MEM_OP_ADDR(naddr, 0, 1),			\
>  		   SPI_MEM_OP_DUMMY(ndummy, 1),				\

I think there are 8d-8d-8d read id ops, so:
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

