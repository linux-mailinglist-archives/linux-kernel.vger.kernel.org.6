Return-Path: <linux-kernel+bounces-347530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EFB98D3F0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39171C210BF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A280B1D015F;
	Wed,  2 Oct 2024 13:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qyEVUdV4"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760B11CF28B
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727874155; cv=none; b=iyvZgtOuiSXYM+QWl7mbRGsnmMBxP3obRnTTwvsS+ei40ev1RGyFYXEdqiQl5nxEm52f5Tktku1faJxOyqlB3DfTNEP5DP8B4aOvnk8xk6KWfKw7qcD97JYoYfFEitC+piDIAoOVUwiv9i/RQm9ACf7K+I/zRKUSvIGMnT8D0KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727874155; c=relaxed/simple;
	bh=SaGx1GdhB/+cQFThb4TF9eDAGIdoFqYrG1PO8YaBRBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raDPsGcfuzUOSLin94OTwC5WYgKQ5csDPd6CkZ/SDrOW15K0hTZ2cv4+RLp65Co7d4bgrpo6VjX8/Xjp5JwIedifGnPU3B5uUte3OcsUGYXSVUhVbWlTb9IAw+QMF4piLbMisxk5olPq2KNA2KVhwFhzyN+jFZCGo5lbgkEbQ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qyEVUdV4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cbc38a997so5319825e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 06:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727874152; x=1728478952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MRdEMpb3P4AfeWlV/F/t1Wfo5VDpiOTTekBJOd+V3gc=;
        b=qyEVUdV4wXfgPoU/mjqaN/L6U5CAnGQa8HVjJspVFJ0jZIURzsdGDtbR74p7I0aCCi
         xWjFB/V+yMhvPmKJlnwmHsRTQlpxTC3OIXpCfLy/v/IEVVx7ssDP10Kpk4ze9sJXf40Y
         v3PHsMt+yF/RX3dy893AryMBfaTLe62Ozs9IZFXBrollxLkA78RvTzcsxrtUJhgTl5gy
         qQLButdeQq9p0vL7y7pVc2zBwwaxKgscuu6ipGS101I2/dww+za+dMtmPzGCajYT3ns7
         eW7XwWoqTLz+/8X69end8GPuVqDrRCvMxT1L8QH7k8AN8OeLQm+xxA5sVQsF+iypfRsF
         JnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727874152; x=1728478952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRdEMpb3P4AfeWlV/F/t1Wfo5VDpiOTTekBJOd+V3gc=;
        b=CudsjAErdrcDdvesvf9k26JbUzR8j14F/sZuYSOYF471BAKqylEYyAYdNLzRw6mwg7
         A2fEmResP8zI0aCTZXy5yUFe7x35E/kywYStuEBkWgs87n4phatTpOxsKz7UyRaIjuQP
         06mNfrhb33E+LB7SfuQi7A7ZjGD1j70PnedB065UIHcZ/ek3+GiZFdUZXtiz1FeE6rtT
         zZPTISqJJYm8cvhDqy8YkwG1OSrm/FZ93F0p6O38x92tbyxyPkouFxDU+qMTNiUi/VsK
         T8jvgvcYBgD/Zav+6BTBcH2fYE5qi4K1Ohmruqw71IPih9/yvwNgOoDsWO04QLmz+DFW
         X3RA==
X-Forwarded-Encrypted: i=1; AJvYcCXw3eqTXUrcBTKjkIuxiIuKhawSlQDXqcQIn5b4GMICgbbwqttlG0YItP3QywACfhx9Fh7e7Nex+RxG5fY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+2praZ+ckvnVsAmRfQH6IL85MggpyDFWr5QhadyKZmp8llGlB
	LjmGCXpMo/WYshgIip5M7cZK1/shXc9u26fcIjkUjZnU0GKYtE0HVLQJR8cmCgE=
X-Google-Smtp-Source: AGHT+IGISZ8UcZWKdTj4ER9q1eUecjB1xz1bXx+pdmXID3SSnIj5uWSuHrzdnFb5v9gFQnoyAqIenA==
X-Received: by 2002:a05:600c:512a:b0:42c:b332:1619 with SMTP id 5b1f17b1804b1-42f71306febmr40360025e9.2.1727874151209;
        Wed, 02 Oct 2024 06:02:31 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79d8d1fasm18291635e9.10.2024.10.02.06.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 06:02:28 -0700 (PDT)
Date: Wed, 2 Oct 2024 16:02:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hridesh MG <hridesh699@gmail.com>
Cc: linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] staging: media: fix spelling mistakes
Message-ID: <bfc3e170-7949-4f92-b434-8cf5d08f6e58@stanley.mountain>
References: <20241002101106.56658-1-hridesh699@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002101106.56658-1-hridesh699@gmail.com>

On Wed, Oct 02, 2024 at 03:41:04PM +0530, Hridesh MG wrote:
> fix two minor spelling/grammar issues
> 
> Signed-off-by: Hridesh MG <hridesh699@gmail.com>
> ---
> Fixes:
> 	chunck -> chunk
> 	procotol -> protocol

The other thing which changed it "follow -> following".  Put this information in
the commit message instead of the meta notes.  Probably avoid Using "Fixes:"
like that because it's not an English sentence and it looks like a Fixes: tag.

Fix three minor spelling/grammar issues:
	chunck -> chunk
	follow -> following
	procotol -> protocol

regards,
dan carpenter


