Return-Path: <linux-kernel+bounces-348560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6AB98E90C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 06:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B751F2395C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 04:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2717374F1;
	Thu,  3 Oct 2024 04:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NxALIxIe"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AE18F66
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 04:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727928550; cv=none; b=Fy+3pLw31ZF2GjopDdCl5sreJMRQrHJr75DGfVMHtDzN2aZqAC3BIjDzWhEH6iowf1gy6UtIS4fG5UaMR1kKlhqXrm8+rz7FE3Xbiuihcc1zaKfuRX+nbcagKelbGMt4Y9MyIWcvy/8E3fqgJqTDzK+pu4R02GmlNr29zIPIauw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727928550; c=relaxed/simple;
	bh=XeBkGsgnNUinbhkKskk1LlS4zxYxg034DyzgTy8EuFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzXKWZSGWOpx2Gvyb4R28JiPB2wHxoMgNYEra/ihfQxTDDwO5K3gXhYUUe/Km6Atc11LLkvMY0h9RKcCAPUfdB4cXax23o6CZoOTkwoOQGes0ALihX0pcmlbWPFF2OkFBEoXqXifd1nPdlKZu9ynmOBSjy2DVpa4mb1g6eOXVgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NxALIxIe; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20bb610be6aso5036135ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 21:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727928548; x=1728533348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Mm+sSVEZoPLZhWE/X27DKG75nOpfc/KIOgMps+wASo=;
        b=NxALIxIe/qAdC/FnheQtYaU85m3MJ3U1ZfhUlcl+5oJDN8yG2eN6sNCevju7uu4C5A
         cJ5YGVVB0pSHZ7E+89/+sy67PzfEGwgVtrttexKZNU78+3NRx40EF0/+5kooeNydRKW1
         ZzS2HkAwdvIOYWVazVrI4ofYA5wD11ujOw0v92FEyzTNcSTJYmrVPPNurW67ESbgZBr0
         T51W070FaX8l3hDEaioc4mVtUeJCNiPtcOlMKqDn6OQl71e2HGcgNghjDKOaD+YM7MxI
         KdkDEH4q9Jp9t+OuJN5iBaJEEFPbKD6MfaKdQ2U6XJbDXqX50SIU+0dGyANRiaQGvcsS
         UfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727928548; x=1728533348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Mm+sSVEZoPLZhWE/X27DKG75nOpfc/KIOgMps+wASo=;
        b=aXdS/hL2KyNV5z/6zdqnUo3+JfLqNd+cE3i5UEFaavoqG57hsfckg6MPiZOjOuEw8m
         fJ0Dtph+cpNS9N83Oxlu1HOF/eN3mQ2XH1B8s5YiTe6viqepDMNc8PUi8zjnFEPm3bBB
         r3allskA+oTGILvJswZLRy0Cz1oW2CygiXeUuAg6bvSj95/gHu+WOOo9bAXDvRPYDUmv
         qA9RAF4SXe98YV+3JnJ5NwGRxrxWNKb5ztTIPZWKXedAGg0jlIqu1dSQ6fv2lgnM/VCX
         8fvxd8ZvyZMb8dt1whHcVtM6OK3iudM3iSEo0EFgONkmczOuBPCvZZpQWzVsKCaSm4PP
         kLug==
X-Forwarded-Encrypted: i=1; AJvYcCXHKHCZ1lvmsnrdamqly/lYguoI0dccTfesIu/b2CwLIgdJqY3rVr/yRMB/n+eGiiFuizzJL+1B1N6CTBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv6AYfVZPAI9By0I0SkDXZe+XxgppapnkLJjO9GP2Eh4/KuelQ
	q2bzfkL2Ox0/lu1/tx49CihbFUA1qnZHXF1M6MUagrGb6fDHLQQ1NoIw1XjyxPjjQ8qJQtJQeoR
	P
X-Google-Smtp-Source: AGHT+IEP4SDn2AnLnAai+AHGFfLLboZlAfYeqXni2jF56stiOFGSo4HwH14+KvK34NuqqkfTEY3ZrQ==
X-Received: by 2002:a17:903:986:b0:205:968b:31ab with SMTP id d9443c01a7336-20bc5b0016amr90780425ad.58.1727928548129;
        Wed, 02 Oct 2024 21:09:08 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beefad16asm780935ad.193.2024.10.02.21.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 21:09:07 -0700 (PDT)
Date: Thu, 3 Oct 2024 09:38:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: mediatek: Fix resource leaks on
 mtk_cpu_create_freq_table() failure
Message-ID: <20241003040859.manukmwmrahgcqqi@vireshk-i7>
References: <20241001053906.mkhld5ufrmpdhfud@vireshk-i7>
 <20241001112908.6863-1-riyandhiman14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001112908.6863-1-riyandhiman14@gmail.com>

On 01-10-24, 16:58, Riyan Dhiman wrote:
> In this file, devm_kzalloc and devm_regulator_get are called. Do I need 
> to call this devm_platform_ioremap_resource instead of ioremap if devm_* 
> api need to be used?


Yes, that would do.

-- 
viresh

