Return-Path: <linux-kernel+bounces-353718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F26C9931AA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1541C21BA8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7561D958A;
	Mon,  7 Oct 2024 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s2BeBh98"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767A71D7986
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315801; cv=none; b=s+HgzzUuNfAnlQtg9/MHc2uXtopmKMrOd7e4ZFrNN6mi72FLfzPYSkvZ597rHOE0owYRSsJM+Sf+Oq602UrtWI8o/gQTkwv6mQKpx7S6kqRBF6NGWT55Gc0wQsYOcyatD3lx9/xW6O6awjV+KrgZ+vlTSKKftb/5ZA/Xq78AQKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315801; c=relaxed/simple;
	bh=kSkSqHhmhDBjaBptoqL2+wVR6+Rxvbf4cBcn8HyCGwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVUnos76Yr/a+CSZ23nyE9HO9HGc4tQMr7pMhOkA4k51drk71vf8wE7VcqE4UoIvpxhYZdKrCzGP7cHEwEWu4S4S+bJmELOFY3wc9Y/2YnflXuwShNXTiPn/jjc8EQYmpYW4UxFQFJ/RqR+Tdnf3IYfWWvcCJH3i8hF7Uaaeps0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s2BeBh98; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37cd5016d98so3489364f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 08:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728315798; x=1728920598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WSvmE8n5QuavFu63BnKGQtIIFsakEPc33Q76Ua00ugw=;
        b=s2BeBh987wzKEOLsl2GwNOpWYWqMfNlrUmkKYznvELLRltVbazu2gjYiUtbudpKcqE
         xhdzPZoCI5dkyj8GOwCEtUTdza1Y2gC/5fuaugy4Zf65XlimEHTvzhxH7JbFatRoh0rl
         WwZJO3jF7lRUf0eXQf57UqmbJvgZI2a67zdX8S9xFucr8WQ6wZ9mJZTSwz+vF0eV5vBL
         rQpTm3xpGx0ASaHu885JmHTfhaDvtLswwGMaIZZOyXNBtDt5yy6yfAGLQAOzXZY5GQNp
         xIlwaEfZRwZOmlbKQZqauuO8wa99t91BkI25M5Pg+lSei1ssJIibpDPYGijeoN146Wjo
         lcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728315798; x=1728920598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSvmE8n5QuavFu63BnKGQtIIFsakEPc33Q76Ua00ugw=;
        b=rndDC0vH54VrXQW36jevQdgtBsF3aKU3KkWxOxpmsozZNRhxKeThETXv54861VLcfH
         ICXf5LEMsrQZVYcNr07ck80SCq5RssIOYrrfHHkDyhxgyIAwQLnNqjh1nESPLpBRd0wQ
         bydH8OdUIdswQgP1v4rYDjcSrZBL3oW7v380viTwoOklkjY7ajQ/KFpglD3fQVf/pkJZ
         XZF6vX4ZLfPBgCX2iT6BV4tBxBtWJWm8B30TTb2SkG/emZXUwL6eDrQS8Xq+dKZd6CyH
         eYjwuXxzx3anI77m5r/e8YCpuD+u9g4yoXwdaSYsGCf65krU0SQYMgfgPz2WZSy5PROG
         kAnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlWTuQHcNvIM6ga5JKxxQpqhw+yw9hQ+6UGiGKYKg5i/EcaAsi2wpgP8/n+jTwbe5UGvt8I0kKItiJdko=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSYtjX+G/znm0Qgy36DAsl7Lz6IlFqAldcnN7jpfzSsUKaxjP8
	lU/UQeiW9GHqA+yaJk6BcPkzQHd6sqEsxA0qvhTIPByzg1uRUw5CurU3hAjiTxw=
X-Google-Smtp-Source: AGHT+IGjHRwsGmvROZcACos6DIixkRGOFRJsUfnF/uGhv9Kl6uH4bJ3AmZ7oBHWLx6CZhF59ANd3Vg==
X-Received: by 2002:a5d:5f4e:0:b0:374:c1a9:b97b with SMTP id ffacd0b85a97d-37d0e6bbab9mr8562598f8f.8.1728315797735;
        Mon, 07 Oct 2024 08:43:17 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1690f79bsm6011795f8f.18.2024.10.07.08.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:43:17 -0700 (PDT)
Date: Mon, 7 Oct 2024 18:43:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hridesh MG <hridesh699@gmail.com>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Umang Jain <umang.jain@ideasonboard.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: Re: [PATCH] staging: vchiq_core: Fix code indent errors
Message-ID: <6c860738-07b2-4c72-9c99-1b394482a186@stanley.mountain>
References: <20241007152214.23240-1-hridesh699@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007152214.23240-1-hridesh699@gmail.com>

On Mon, Oct 07, 2024 at 08:52:12PM +0530, Hridesh MG wrote:
> Replace spaces with tabs to adhere to kernel coding style.
> 
> Reported by checkpatch:
> 
> ERROR: code indent should use tabs where possible
> 
> Signed-off-by: Hridesh MG <hridesh699@gmail.com>
> ---

Thanks.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


