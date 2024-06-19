Return-Path: <linux-kernel+bounces-221148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC0A90EF7A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AAD21C215C0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D1814EC60;
	Wed, 19 Jun 2024 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dr3GV2WD"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E79A14F111
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805281; cv=none; b=n8Dh4EJKXHVP4NO/ThscWYhRY4c5zDGSXn4YLiatLGFz41AwG0pV4yRAMAe+ed+WcivR3rCM0b/zRuB9QnrfgLcS4JVE51HdrVIqgYADnUIR0e+VW0vUohbQYHAbcE93CZFOomX3YMHBS73z67oWdqfSQxXqA2IrR/OGwvo1+FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805281; c=relaxed/simple;
	bh=uULrUp2XdmogMLrSqTrBAy9ErEQY1du4cURnaRxIxRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePWGYwsBaKiwLxq4bk2eqlwqxK221Ku2Rk1/wFOvK+TrriviNhn1gdc9LTKf8tlrA2lLvGcAvOu+e9tfw0C+1mTkkECi+LZQI1gtM06nR32i0VvoZdzyFAtC8xA7QO2Gj3QPTT6RI9mSnrFVMw86h3RJKA9I6cHpptI5TzUUsv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dr3GV2WD; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57d0eca877cso1020200a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 06:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718805277; x=1719410077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4/X1uyeKMm+LCTojyS0F0YrzqYsr5hKB4jznu/4UFt8=;
        b=Dr3GV2WDhu+Oakvc9fi144SccNziLRxLThNP4Qx7A0aONjP0VtnxKsb1RFoI3mJlL3
         n6tXBbVyuLZhTL6txHvCe8tNa/C+d2URoonemRNS96TH4o5UoJL+Tm8c4IelsHffWhom
         Y9S2Sa1Bqgv9KvIvQPmNnIR2G/EKcHyWrqVSZ1dBst6ceZSAIsqHgVT3ZCptEnGw1s8a
         987TvSWFgK758PXiVcV8H4ignvAsCdR6MT4+kFmm/VWSoT7YjywXU8ZvlLSWwgcI3Nhj
         Im1dmT5spUnfO/VfGHAsA0BzmLPkFgC3+kzBxyhkXJ3SVd5K0cl4YVtj/mTqgoDayimN
         7k/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718805277; x=1719410077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/X1uyeKMm+LCTojyS0F0YrzqYsr5hKB4jznu/4UFt8=;
        b=AousZ2lL4MLhhYosSIjBA288scyRrMw1sDl8xaK/oyQD/pfpgxg5PjQKBfBySsR6OS
         u4GYYZ2Tx1kJwEVorabBntMDNigrgvvQYN47tKzZ6+7JdcZ3+nZWXgylgXIf6QqkrFcP
         17D7nF/vpHk54qpVNxKqTXoxWM7qZJE5gdKX2rPnV+WpztKU3GQFqv/ZUyFKPapMoG46
         eg0n12caVtQVy5rDal8M3bL51OqSUo18KY7C4Tuavcb/eMC9qf574W841wmNEreuBm55
         c5KpZuxvEzlmmr8CjIgo8cxvLCkcNVJ7K8iQ2FlrGCnpdtffLdWwmGb8nLt1mV6zapcY
         Qa6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBYwNmzkFnqZ9LOwKo/tsmFQqkjyMRKJ1bEWWxnM9zfMv0hWJsnRsjgbMZsFE4sFbLVd/JRSnQhrAVWZbt687CqIdtIcPk+fij/Laq
X-Gm-Message-State: AOJu0YyCL8npVmPzplbIFIg41xhRRRNxDoLCPpONr5Py6sOJTO4EMuzO
	fZESyxb+x00+D5ahI0k2ybW5Ku1bprqUwu1M12fMUdUDK36D08t4pLHu1NYKSg8=
X-Google-Smtp-Source: AGHT+IEoW9z9RL64fJJ6JJy+WiDYy6vtGgzuIi7TtyXXpU/XYPbgwsdqNS38T+1EnBxDOF0tEBmOZQ==
X-Received: by 2002:a17:906:16ce:b0:a6f:cb3:55cc with SMTP id a640c23a62f3a-a6fab7d6d8emr139748966b.73.1718805277329;
        Wed, 19 Jun 2024 06:54:37 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56fa67ecsm657146566b.215.2024.06.19.06.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 06:54:37 -0700 (PDT)
Date: Wed, 19 Jun 2024 16:54:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Vladimir Oltean <olteanv@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Simon Horman <horms@kernel.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Casper Andersson <casper.casan@gmail.com>,
	linux-kernel@vger.kernel.org,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 net-next] net: dsa: Allow only up to two HSR HW
 offloaded ports for KSZ9477
Message-ID: <a213ea45-53fa-454d-8989-49dbab806313@moroto.mountain>
References: <20240619134248.1228443-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619134248.1228443-1-lukma@denx.de>

You went above and beyond.  Thanks so much! :)

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


