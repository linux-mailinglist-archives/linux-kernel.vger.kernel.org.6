Return-Path: <linux-kernel+bounces-231646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1977A919B51
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 01:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C878028158E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 23:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F2A19415C;
	Wed, 26 Jun 2024 23:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iRXaG7j+"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECCF173338
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 23:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719445212; cv=none; b=HiSoggcgFbvHRoXsOFtveH8WPjyYecijfmRCw69TPvnHcedMg0LP7iJKc0Vex+d+VL7ERzt765/kmc8i67WRr9rGSPY+fZgW//oHbT5qXQ1qpfM13ZN0QkHpH5zEbsWb0nGk/RgtWfexdfJooYR2DTlD07ppOFzzBHINS/m7IwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719445212; c=relaxed/simple;
	bh=019CaFVh3lhoS0w68HPIP9ng8eI8idSw76yT38lMbnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUyhe38/pIimbfk/vvXVIqRSVxAXbG4mg222tDGxa7BbNe9hagIZCD1D+zirlj9Gz2899As7vqT+OuzX+wAu305pR0TGblNCVe6B19D3JA37F32Eg6R4UF6z4lqVz4wfYmQU8Skl9W3hwCC//gFQam31x0mGK/pLyeSNS/aTqcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iRXaG7j+; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fa901ad6f3so39505ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719445211; x=1720050011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cYUt50CXgSrSaz+HXS9uk+LgKfhLcjaXpXf0DU8eqcI=;
        b=iRXaG7j+1XO5wSVH1ggF3Hk1ivlNRrYsOVzBOY4GSdqQ2D9W9tOFGubX47Y6t+coDo
         KvUf/2TygQAptptFsYn5OwjFPr739t8h/eEn7Fxht/K9Eue1Vx0NVezGkCdmVnITWA3Y
         GfzTjK9HmAH9+LMVYQ3LkQO8kMJ0Rfa8/FBJFf4OGXdb6Vd70UJ24kSbMlY+qegx7C4E
         Cxj22dgWVi7Tsp4frCCvw+v90w6rIZPjluEMKDBOOjksQVV++Y7QdP0w/hxdTEAZ1kla
         /uzzYawBQ8+zN8tFUwwwST9rgR7O7fCihtauBI5ZkxcEEXcLyhOAa0Jfn6kLFSfhNT/I
         lQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719445211; x=1720050011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYUt50CXgSrSaz+HXS9uk+LgKfhLcjaXpXf0DU8eqcI=;
        b=cCWChmUfWfuuCv9j1etmS1jMwq+fB3DoaYypb9+sxP7ufJYWVFKkCTl3mHLUMPk9hG
         kE6v1fIgOrzqDcYtaY4u10Qcr+AdKVDP6PMv15z2lDSdCaR6xUXb6lRuvezuMAhWYFPG
         yOtdjhsaRWrMQMzzsQnvcjjegreKs1IostufItP+4eyG3C1+3qfAlG8Wzl4SgoCJVuP8
         g829Ri97qeVdZC7+NcAoVN/KsJCpWYZ8No6Lf4JJF6Yii7wgqXIyo9+5budMx8rVHyZ/
         Bl17ZGQVKqsBN01k8uaNVq1FSCSa4u+q7gVYAJFrMj4cKLvjYJ8j453QC9UB8/3AXwi/
         OeCA==
X-Forwarded-Encrypted: i=1; AJvYcCWwZXTWmvGqIThlhl+Eg8w4cnpgcBIu4Qol+wKaQoKG/ry35odRGts25qU4A+zS4EYpJWVPOev7k9rkrKL+xszUC8/SI6aE9Pkd3nXi
X-Gm-Message-State: AOJu0YxnuZyD/Hm70j/xMzBgduRaAnpKI1nuv8XsqhAtmNAZKaAXORmo
	wLim8K+cJ5GNll5eYKY1Tg7BbZ2QOV5YqDVBgSup+Oxr5VH/5udW4Q3uSOUS+A==
X-Google-Smtp-Source: AGHT+IHlKaAmURTLh3ZeZvxHBLbh/zTd2wDSCpmqMl4TBrZZ7NKfHf0vVsBEj0+hsbeFfCuPgzzyhg==
X-Received: by 2002:a17:902:82c6:b0:1f4:7db0:afbd with SMTP id d9443c01a7336-1faa999eb47mr1582755ad.28.1719445209827;
        Wed, 26 Jun 2024 16:40:09 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac979499sm514875ad.144.2024.06.26.16.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 16:40:09 -0700 (PDT)
Date: Wed, 26 Jun 2024 16:40:06 -0700
From: William McVicker <willmcvicker@google.com>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	alim.akhtar@samsung.com, s.nawrocki@samsung.com,
	cw00.choi@samsung.com, mturquette@baylibre.com, sboyd@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org, andre.draszik@linaro.org,
	kernel-team@android.com, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH 3/3] clk: samsung: gs101: mark
 gout_hsi2_ufs_embd_i_clk_unipro as critical
Message-ID: <Znym1qR9hyYwy5Ll@google.com>
References: <20240626194300.302327-1-peter.griffin@linaro.org>
 <20240626194300.302327-4-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626194300.302327-4-peter.griffin@linaro.org>

On 06/26/2024, Peter Griffin wrote:
> The system hangs on poweroff when this UFS clock is turned off, meaning
> the system never powers down. For the moment mark the clock as critical.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

Reviewed-by: Will McVicker <willmcvicker@google.com>
Tested-by: Will McVicker <willmcvicker@google.com>

[...]

Thanks! I verified my Pixel 6 Pro reboots and powers off fine with these
changes.

Regards,
Will

