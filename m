Return-Path: <linux-kernel+bounces-561843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D46A6174C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A911B60F6C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838572046A2;
	Fri, 14 Mar 2025 17:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KSXOOM8Y"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF2A204683
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741972615; cv=none; b=S3OgJFlwl4Pon0NgT0keox+bhAazYuuz3dzfF3tpHWX7qOXtEk+xhzKHYKytgj2VFDYHC5bhF0bTlMF6M/lDRepAHCWEhCrB0aLvNEJhvgKvm1LVg5b3ittBhG6tfSgMHePbhZ1VOA7q5SJPYumzsffzRZIU/og26c+ifYryPLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741972615; c=relaxed/simple;
	bh=MCmgIQx9pPLqWzAwKDi73Ci/x2pgTim3gRZat5AGGm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEbFx+lumnZQEhUdv60VqE2rNwKvIben1dmK9/LLgbrLqToe+q87DL1MhYguIMgrVgVeyWxWrElDp8uzNE+SzVmKrr/IFhW1tMoRsaYXteU8rRJpA5QvpBkFD/U1hAtDEn4Jroe+qjkHlsItlHhDNk8ymjz7H7m8eSM698cflhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KSXOOM8Y; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-223f4c06e9fso43879125ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741972613; x=1742577413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CDdp6JPsZHB45CMyh1swLsd39KS9lz9tRFCDBXIEVj8=;
        b=KSXOOM8Y769JXyxgsQjCdR7R3wDPATpkgTtAdj56BMbLmC1vJizqMZI77b+6DNUkW5
         dJ0hn7cmq83oDb4Z8cgaigxXfm8gVQG0ulxZ3jNdDu1AXG+1BxqrfB16FSLNb7Vj+n41
         A7r7qXgeGR+GERkXNlru0BBST+pos2BNhQplHchjwxysoRfi1gi32fDWRkXEd2UWkNjC
         rhlz2Ln2gV0GPIov9T64c6Wmbv6XNGL5NKsWzDjRKnmsQyeSbMikgvDmLWO1Zvu1o0Zz
         1XMeot+6LTMmCBZMtZtKTispN3RVXFBFrNPw2WqLrFzmYeWhOzTaoh2dIkP3U4NIdmTP
         44fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741972613; x=1742577413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDdp6JPsZHB45CMyh1swLsd39KS9lz9tRFCDBXIEVj8=;
        b=rWodMLwwyl+yoc3m9bf379hZsZgmth8FsJLvo156MMRLavwkWNHRuLFLZnzabi+fd3
         8EscCJeihaqgwIx/Lb+2gvQJG193GwGQqrz3hTSaBu4Rtg4fI6rQD7hofQtS3XEalmt4
         YC2lF93Z9OOCK4g7wEjX4Ib1FLJ+/9s1gye2f8lHHzwSwLmLByBz2WPogLFocWMqgknn
         gm1pqCsLOl98aoueLvFANY3QQAgjhKBcpSb9pqIgXnIwFuaO2TSZr2ePbJCtYUIbv9Jc
         4oboblwV14TILcU4RvWptPqGh1Vvhdm1hG9o+sWshAX9zPUhndnXrNMCYSjQwifgoAVJ
         iYiA==
X-Forwarded-Encrypted: i=1; AJvYcCWU3r+qMIpEMvYTcS761y7X7vape47HCfDoEWWMJiWpEickuj5zKpOceJarsaFUeDFe4auQVcURISgfGHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNaxbYXUERR8Yvy1JBY/A4e9IWq+4xuJa++wl2mh/Vz55EAsYT
	a8XbMfqyp8FIUhYteVmmew7ooJLVFJ5HbGrUjCqL+J30znKuIp+NKw35bas9Mw==
X-Gm-Gg: ASbGnctBtFhWjtY/D3xPvNrQEnsdIGLy3+W71fKYddY3oNOiLLRd6XJfYuSK9wTGoy7
	KETWSodGj55ERck4Co1ITF+BCFQ6H7AG4v6QdK2FbSH8+E6q/Do5cLk3XZE5g7hpsZEUqPJASPp
	uE688ihKPK4RJcOeKK8x/N9oBe3ov3ciXZLHVxoDXWTz0rcYAWkfB7CxTkFP5cXYFJC5QVwjRPq
	CXomNJ7Ja9gD6kEa5bTFhaoNNR3kMteg3Irc5fr48thnQLYJAhvx3ucvIrgD2uy7vjoSAkzlG7O
	PtkTw/rhrYWnUUuxjyIZLk6tSFhZCctNO2pqD29CXIvmGhFKCVhJwaq8E80fJkvFTkzSYbAluFH
	8KKLls2kE8xUr7pQ=
X-Google-Smtp-Source: AGHT+IESV7lf4zH31HRl2I8byc8Hhj6aLdJrikr6gIoStXmwWR0DzwK8g18nrHPo3RniArFYGonCrg==
X-Received: by 2002:a17:903:40c5:b0:21f:7078:4074 with SMTP id d9443c01a7336-225c6617ddfmr87561165ad.7.1741972613410;
        Fri, 14 Mar 2025 10:16:53 -0700 (PDT)
Received: from google.com (198.103.247.35.bc.googleusercontent.com. [35.247.103.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a84besm31146555ad.79.2025.03.14.10.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 10:16:53 -0700 (PDT)
Date: Fri, 14 Mar 2025 10:16:49 -0700
From: William McVicker <willmcvicker@google.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Peter Griffin <peter.griffin@linaro.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	kernel-team@android.com, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] Add dma-coherent for gs101 UFS dt node
Message-ID: <Z9RkgY3gnx6Xp0nc@google.com>
References: <20250314-ufs-dma-coherent-v1-0-bdf9f9be2919@linaro.org>
 <0d7a8cad-adfc-4cac-bcc6-65d1f9c86b43@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d7a8cad-adfc-4cac-bcc6-65d1f9c86b43@acm.org>

On 03/14/2025, Bart Van Assche wrote:
> On 3/14/25 8:38 AM, Peter Griffin wrote:
> > ufs-exynos driver enables the shareability option for gs101 which
> > means the descriptors need to be allocated as cacheable.
> 
> Shouldn't that code be modified such that the shareability option is
> only set if the dma-coherent property is present in the device tree?

That's what we do downstream and would fix any issues when booting with an
older DT that doesn't have the `dma-coherent` property set. So I agree that
would be a worthy fix (which I did verify fixes the stability issues).

Regards,
Will

> 
> Thanks,
> 
> Bart.

