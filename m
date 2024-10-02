Return-Path: <linux-kernel+bounces-347883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D8998DFD7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C34141F2A32C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4073F1D0BB7;
	Wed,  2 Oct 2024 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tKLQ7PTM"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47C01CF7DD
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 15:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884418; cv=none; b=IX1e7Gp/CrZwXQ6NCCrgd/uzRsrTiCjgDayDPGt1bIvadaCiK7qWAvwSwh7TZj6WSZCTYsmc6ttcYCN86bV5mGKxOjNRbylWiaiuolAxow+ViwWIvQ9HOPTdgnfCkq/6d23m71GaFkqT3OlVB3kSlXVC6L/GvhN2NKWZ4U3096w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884418; c=relaxed/simple;
	bh=sdxpKH9V4c5yfJjsw3qgNvWJOgyXW68pU2J1QpqbmCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkOToruQH939GfsHV/fHz7aG0CuWDtxOeIyjRaCsyo04OpBQ3VnRynmCpucMc0GUEfHwNsYlo0+4DnZRcXzr26u4xTasoPnylKyWar6OrBqozQYwirV067Khon3isuRMkd2DrJ1ps7OwJXiUMsmyX/UAZB4yw7I3IuLAbprg/sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tKLQ7PTM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cafda818aso66560175e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 08:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727884415; x=1728489215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MdHSrW/ChJntpJXVDEopdglyYp7fbBJgyKHsyD0baf4=;
        b=tKLQ7PTMOzs6RQwnnu2CknlyaMsxc1GOig5/p8ywjUGH7oE3WIFixrzD2JSi5bvvyK
         SnDnSO5V1XFWSZ7Q4+TP3Aq3aDQm+nL2NJfqzufi0wONDMh29Qa0FNFk+yPPkK+DmGpb
         lfc4HoIqlJjT4n8EWUNL4WQjUCufWWo66ZuF84IgNkjUzLIjiPvCqV98sgfYuHWNsS5O
         sOO4JqL9/4hvebEzlMKlFBgxPiYnkXB9ZKCzVnAdh0Ig3Bti3y81DlYbMewHsgqDAJVC
         23rSKcIUURDGr5xkOCFYhED+nJbCWabb+KWBK6co7mzaBazBRqr5xQqH5MkDzCYnxLFy
         p3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727884415; x=1728489215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdHSrW/ChJntpJXVDEopdglyYp7fbBJgyKHsyD0baf4=;
        b=KaHr6dUt5HuzUZFXBsoL2AFFlBuLTWzDfS9//8uQ2U//WoTum7vSC7iLMpYQ+EJZB9
         YGGjVlN95cQ9kRvmb1PNSif1Hn/5QaZYIndxRDkrBOFvOAKlSFqLMw4LsBboDBHpRXfK
         Ag7Yst5OuD8pLGrK09oQxgB5Kqtt8p66AJT3yg78fgBw6yrd86hG3oB6fpDjTHTvQJgo
         NSs7ybdfYpUt+9fq0ei+fVMypnhZyAAh22OSlQ1zvMOYXNV6ZEPFvvUNHHRr+cvJ4Tcl
         Lmb058WR9GnLOgzl45/RrxRDNbjErM1bR5h/fS4yiquahMcqhHtPcNnVfDfbVXn3CAnE
         gkIA==
X-Forwarded-Encrypted: i=1; AJvYcCW6e9Y530HsARK/I0kI2cSEVww7L7dy4TMYnDSNL2zv5ydYyzg1EUBzO62TIdbiGsB9SRN/jHW57qNGSac=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN63fC90YC5ZEQznBu7lDcoB8/Rd7TEp40C+KAn8J2ay08MP5U
	lmogSGT8so9P8e9grNi2gsfzgpOxgLmJIezw5cG3d+0+uHdL9tESCRTdgZyAKSY=
X-Google-Smtp-Source: AGHT+IErKLNJPzyffjAz6YIrrKSomVc/nej9Sz/s59zloqG0Mzrd8SoXK+sB4+dGv+nZ3cX0x1Gm+A==
X-Received: by 2002:a05:600c:358e:b0:42c:df54:18ec with SMTP id 5b1f17b1804b1-42f777ee3f9mr24259735e9.28.1727884415231;
        Wed, 02 Oct 2024 08:53:35 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79c67c5csm22433425e9.0.2024.10.02.08.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 08:53:32 -0700 (PDT)
Date: Wed, 2 Oct 2024 18:53:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hridesh MG <hridesh699@gmail.com>
Cc: linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] staging: media: fix spelling mistakes
Message-ID: <8c62e5ce-3c01-4c1f-b8e0-1c6a0164670c@stanley.mountain>
References: <20241002152231.8828-1-hridesh699@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002152231.8828-1-hridesh699@gmail.com>

On Wed, Oct 02, 2024 at 08:52:30PM +0530, Hridesh MG wrote:
> Fix three minor spelling/grammar issues:
> 	chunck -> chunk
> 	procotol -> protocol
> 	follow -> following
> 
> Signed-off-by: Hridesh MG <hridesh699@gmail.com>
> ---

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


