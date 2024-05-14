Return-Path: <linux-kernel+bounces-178217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BF08C4A87
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 02:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C15DF283AE2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 00:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA2B15A8;
	Tue, 14 May 2024 00:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FysXF6Zf"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044A6A34
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 00:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715647271; cv=none; b=arysx/2MuMgtk5ZOXevqqfQTZM1kPayOxZesD2pXEE/tz2HPqSQJ/wDUgOlCu1Y5qQpqUkZW08kJ480nnmBkA9y6ZTJMM36rhAYmf1pgDNucXmQr2refw1NCLMJQyfwGmjGQfRvN2o2rxCIINonTcEHBF96Go+kSSrnPWyNIE6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715647271; c=relaxed/simple;
	bh=eoGtjap5QlA3MvcIJ5JSN+ws7FodXjXzqRBbTDCCoUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0AXO+/0o9K9qpp7y89K/HNju8cu2cqwtmrMBkW6aYKuBSCxlxMCazEeCYNrQaFQWri6Mdik0EsScFw6KNvgD6Kw4ZIRLfvUluEtjBvWglMpkQmuLIxfCGrD24KP90al3qvT9wbpGuElKq8g/c8y4s2ZjNpeTl/p3woYUYNOrAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FysXF6Zf; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f490b5c23bso4219073b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 17:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715647269; x=1716252069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4+jXX/hz5Sn9kr6jAJ2T/dJnnr4GmboRRKaDLKSwuY4=;
        b=FysXF6ZfuDPDfpu3I6s0fPWVHtmR72igycBDJp8Bbwxcmeewt0Jg7v2XiYMS9Ci9bg
         23U7nJc+YqZiUMMjUkzkU4oAsdrzGYIHx8PsuVeYy6It1aoEFSdZVuEPcXHmW1cHj8Lk
         GnnZ1T8aCGgZ/66EPt46H170qIx+WVRrkelIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715647269; x=1716252069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+jXX/hz5Sn9kr6jAJ2T/dJnnr4GmboRRKaDLKSwuY4=;
        b=TMq5KibYw36ISDeAo/Oq9kF4QSMMLqmyA8JzfFwjwrN1cRA8ATQ4gnAYZ5a9mYaSqu
         XKii9knsaHQzgTVStw4miWq3M/MToPc0Tt8fYJjyG5s9UV3zR+RakApSrsX9GuwBnSP2
         LiqPHmBdm8m4Wa8YDgvXree4xopXiLQQjzFdKTi7bXXI0H/yOqzTV4jDy97f9mhtinE5
         ZgpBJSNtjBFO5XJBcps4lHdgkoU/0rzPNKq1LqcGAKp+bvjdTqrQP2NWxGwNpuK3efq6
         ESKKXw8M+GLPSuE07KqmcIf8fNIb7y4cIOO+4bxcBOKLj9JErgq36Ro4PmmQJJttk0OF
         AWrg==
X-Forwarded-Encrypted: i=1; AJvYcCXRoCHPSHQAFE1PGwfDgbeysr8GMQuPUschHtfGsweyr9gpWbP7Xfu/k2ND4AoObr40tMmodQ5JwPf2i57MX+X2Mi9Q1HujV6p/ovHX
X-Gm-Message-State: AOJu0Yw1n3pEE0+/b1OGs1CRGmATn8NQrbMeWZpjCsiGi2m07g0Nn7r1
	S2nW+czenakWscE8K85xQGi3xYQG1EBRWtrtpnQyS34LUAFXjTmlE+U/xW3b7g==
X-Google-Smtp-Source: AGHT+IGLcp2R02aMZE62qqvfeUrmc8ZAzn6tSbdPdjuVH6xTRIbv6IEEgHDBiOkgf+/3WV73AJ0zVw==
X-Received: by 2002:a05:6a00:1816:b0:6ed:9493:bc6d with SMTP id d2e1a72fcca58-6f4e02ad1dbmr11266559b3a.12.1715647268814;
        Mon, 13 May 2024 17:41:08 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:3d25:e0fe:b3d2:e626])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a665ccsm7965977b3a.23.2024.05.13.17.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 17:41:08 -0700 (PDT)
Date: Tue, 14 May 2024 09:41:03 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH 4/4] mm/zsmalloc: add MODULE_DESCRIPTION()
Message-ID: <20240514004103.GE950946@google.com>
References: <20240513-mm-md-v1-0-8c20e7d26842@quicinc.com>
 <20240513-mm-md-v1-4-8c20e7d26842@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513-mm-md-v1-4-8c20e7d26842@quicinc.com>

On (24/05/13 12:37), Jeff Johnson wrote:
> Fix the 'make W=1' warning:
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in mm/zsmalloc.o
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

