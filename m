Return-Path: <linux-kernel+bounces-426971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C79899DFABD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 674F916271F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 06:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189351F8F01;
	Mon,  2 Dec 2024 06:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rFYnVibo"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C5041C6A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 06:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733121144; cv=none; b=cD2jICt+Cl9nwvkRNEdBZkEBQgasCMEjtg1n/4jgs9KnSOotv1RbY/kTaTfuFUr13dCsj8rj+qMzmU20cyEbJ4+CkP1lhdSGLVg1O5vrFmUAsgDVww6QTb2Q3ZSGYLPPaxFMWQ5vi+oq8d1gevBnber9SBCTp6ni0pl/hae/9bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733121144; c=relaxed/simple;
	bh=QQLnYmKvGqFJ7sA2gHqV0Upd6Bo/7oU8H7gUN18PrYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEZFS5UP7rTVh8N6ffn+OeQTChDjT/hbkgSdffvKJX0a10qwxB/o5Jh5bvYdi8Hjpo/nypAosGLgf3KQacXGZo+mtHGtZol5s7udzaPes06kGD3qR/Nywk8EaWih12NOan5sXhXS17Vn5lbo2sY5zD6OQtQ8r+6E8Z5xmBvLnWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rFYnVibo; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21568166415so10833515ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 22:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733121142; x=1733725942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QaAjXlMahWaPPK8kYZPf2znqjEQMRsE6lGjRgJChzrk=;
        b=rFYnViboTz63rorSBARNeVPsXGYa8+3OZUe0OflwbmEi1EtVtfRfFp8QeT0S8eHefx
         dNI6Ch0J+kjlJJDBxyhNOJPBLpC5L57iTm4motjKL2Rv9DR7V2eJH++alH3vs0gz4isK
         G6jsfenRn9LXlg2Q8qtgVEP1hZeDFX60kIr9EKtvVkfi/yI7+9KNOeNa2xNV1TH3a22b
         5j+NTabCaFh2Vap0r+vgh2x1F/20T7/kR47snLV6DfcoPT2RGnmVAbl2t/SZGfj0cGt2
         fm9pISuddgwNVNDWewMMJ9uTfNnQlzpyCUcNuflz9TyRH+wcTopIYIbmQ+lRCx9G7VS/
         ay3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733121142; x=1733725942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaAjXlMahWaPPK8kYZPf2znqjEQMRsE6lGjRgJChzrk=;
        b=GpGajeJ9MpTv9c8nalcMEicpBoycyb101nKiTY5/HQMkgt4ZVyQPFYk/HEwZQ5HhQv
         xa5m5+MTHYGBlCUXMMtLIAOATYOhcEybTrSTaCg5flPF/7DFCav95ks9olLoj5CzKWH/
         k11VsvKRMBwGMJCS2qdMb/z9OBOdu54ocW7XK9eyWGbHiezQU6YGhanxClMK4445lRXl
         4uhKGckvWIHc6IfUfNaVC+9AuLXlRRHc8akhWc4yWOzsajjVCXU/s67kfQ7HsVFWds9i
         LPjjeyGH3Wz7wffr49nQK1g0ZIQvhsZV3h2/e2KTEtw5O91YLvoTplRmkNS+zxmHokfT
         /mfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXngcxjlAeDh96nZ32sEH5PPikqrvWtOBeGpX726FBmNnOzOUmmLfjQqsWlyZKnHBs1gRiTg5Th6ESRKg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx//XuJtCKJ2xamNiqW9UBNW8V3Gkjg+qqQCzgb72D+i7rKs9KF
	6JjrWgnyhMDcwZ9BKYeFdMh9m9n7YMCc3zgBXmogxd+jktlLkNUNqeC8q/Agye0=
X-Gm-Gg: ASbGnctVvXFOxNSdSPECDXeVv3wpiIk8GcWAXHYRJ3wudo9l4MJfU2Egd/9pKIuPB9g
	ZNk+noEkUobt0lCh6oEjB3+zbVZvetWxEPY893WcfY42dFJFYn/4857WuswcekHcKv5l1Pz64+d
	kOSyTBtqv4f1Z3SEI6cWru3C5E6++5OXzePQ15Vx/g6KSMrWIhYxLJvmOjZg4pWDFEKdgo3uH2v
	uzMkw290B+rpTs7aobB/0Byc/jwSvWC7ATBdqicsQ+JI5Vonm2b
X-Google-Smtp-Source: AGHT+IGYhjUoHDCLwzmR+4DgTs9bkKuenJfFo+6JvE40VkbLu5HidScSvlyxpJil/9dg5jbAH9nNVw==
X-Received: by 2002:a17:90b:3c11:b0:2ee:b4d4:69 with SMTP id 98e67ed59e1d1-2eeb4d40232mr6275373a91.35.1733121142397;
        Sun, 01 Dec 2024 22:32:22 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee72dea03dsm4216447a91.27.2024.12.01.22.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 22:32:21 -0800 (PST)
Date: Mon, 2 Dec 2024 12:02:19 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] opp: core: Fix off by one in dev_pm_opp_get_bw()
Message-ID: <20241202063219.evknbyimnldqrymn@vireshk-i7>
References: <41ae307c-f6ff-49fb-a962-eb488152de71@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41ae307c-f6ff-49fb-a962-eb488152de71@stanley.mountain>

On 30-11-24, 13:07, Dan Carpenter wrote:
> The "opp->bandwidth" array has "opp->opp_table->path_count" number of
> elements.  It's allocated in _opp_allocate().  So this > needs to be >=
> to prevent an out of bounds access.
> 
> Fixes: d78653dcd8bf ("opp: core: implement dev_pm_opp_get_bw")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/opp/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index d4a0030a0228..09a1432561f6 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -121,7 +121,7 @@ unsigned long dev_pm_opp_get_bw(struct dev_pm_opp *opp, bool peak, int index)
>  		return 0;
>  	}
>  
> -	if (index > opp->opp_table->path_count)
> +	if (index >= opp->opp_table->path_count)
>  		return 0;
>  
>  	if (!opp->bandwidth)

Applied. Thanks.

-- 
viresh

