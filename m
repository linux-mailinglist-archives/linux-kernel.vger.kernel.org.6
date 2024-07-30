Return-Path: <linux-kernel+bounces-267959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD533941DEC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B762898B0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E3C1A76BE;
	Tue, 30 Jul 2024 17:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7ZqNx4f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835631A76AB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360199; cv=none; b=K6TliTa/6LgzMzfhErG79qOzADcrS3ItDB5VkTIVlB/aQxMoHNcibuBzHasT6ASfTvdmmTOkb8+LlRGaaz3AQkEvUBKhcdKwEcDcD5W4yoKfx5xaOUApnHXoShHn7dw7J6aT+h0cUzsrubwyjEqt4mcTEYgf2wr3gi0xrIUFU/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360199; c=relaxed/simple;
	bh=WSLbTFOqtwvBvuu2Pk3Vz3v059bdDQQYXqnULrM1dyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvBjyrGWGGDmdySO4GzoyncbiLsxiVxEAgQ0CScnthQgedCJGrSAMdP3JJINvf3aXl3s9qGOfBs20pAsPdyPLXN/hPPoxSyePTJPH+Nl6gAxB1fGAal0N9uEUFubuItErxV0Lg/7895x8Fe82CSnFBiCAJnliRg278/nBIZgPK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i7ZqNx4f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722360196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IGuwjnT9GWQX6tSgZYcf238XJcRm98rHlMAflHHg3Kw=;
	b=i7ZqNx4ftmSP7ownxAakaMXW3GwAuraCjBKrJGU9GDCzdQZjlGmkZhS+ZBCBLOZOv+8n38
	4DOJ0Oj3LVbExurp6Jnbi0vCxoyvT+cX+4zH4ZVQIVVkTJDdSQmU1X9HjtUQdyOXVE+yEX
	lB2eF2o0b1Nra6Vv4P1oUSS7E+Bo3z4=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-ao0ThDHnMbK0ByVhzmuN_A-1; Tue, 30 Jul 2024 13:23:15 -0400
X-MC-Unique: ao0ThDHnMbK0ByVhzmuN_A-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-4f52d5b872bso1326043e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 10:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722360194; x=1722964994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGuwjnT9GWQX6tSgZYcf238XJcRm98rHlMAflHHg3Kw=;
        b=bYrSV8httIPNIP7Pve0LGx/2fiWJakfYirDadD3k3AbfWFUHbZiiVv+hj6ucBYhuK4
         VeoQ02kE6nHGEr8UrADjUGWnYFiF0pF+4oErRwfd5Dd9E5cDromYBGiiBgtlMlIdLdoC
         T7149LnIUFCcyME1l9U56XHDVqFBM2ako1hItWIl5iD74fyU41cCKmwhuIvcGvuXLOzp
         RfoxWsEGbbTWbQ9xyV9opbrDRRtUdGDknOlTwja3RdfT6QtXdZqy70MC1NJ03hAWnepO
         agaGM4SC/raVRFqlU26U5BEyBf1ZjNptfIZnXaFTPEhf4W7jHMALfjcWITMeKtT2pG+u
         7Kmw==
X-Forwarded-Encrypted: i=1; AJvYcCUxjodWmlo7Lyjlg5mthx+73UtbyUxvHQ+4a5xafs1Gk2Z8yv5UwtK6SYMAWpRMXQTVi9fxQt7Ky/I3tLFiwBARV5+dOawuGTjK+/Wi
X-Gm-Message-State: AOJu0YwYceH1+iQid5Wpn5PFGq6v2qRjsrdk/qjhDsLUXLH4q3i7q8VO
	D3TT/yDXwjlU1ztdCff5LNyPuSc8xFv85UXLKjgcHcfpX91GDXWe9MgBV4G0E450wBzmqStlCta
	3Dz0LL0m+fz9yyghVj2cSJrX/ufNnAupCty1a94+dUyzXgq2azevhR0xti2Y3Ng==
X-Received: by 2002:a05:6122:411f:b0:4eb:5cb9:f219 with SMTP id 71dfb90a1353d-4f6e66da493mr13681485e0c.0.1722360194383;
        Tue, 30 Jul 2024 10:23:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWbirP7h94q0zBxDXPvLWzG9yiO2xstVTbnFEvAf7XvK6WAL4K2A8c3RqeBtWZrGGc6bL7ow==
X-Received: by 2002:a05:6122:411f:b0:4eb:5cb9:f219 with SMTP id 71dfb90a1353d-4f6e66da493mr13681461e0c.0.1722360194024;
        Tue, 30 Jul 2024 10:23:14 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8201583sm51136421cf.69.2024.07.30.10.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 10:23:13 -0700 (PDT)
Date: Tue, 30 Jul 2024 12:23:11 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Elliot Berman <quic_eberman@quicinc.com>, 
	Amirreza Zarrabi <quic_azarrabi@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [PATCH 2/2] firmware: qcom: qseecom: remove unused functions
Message-ID: <ftbxl4e3fwsylm2nsewcklnmnknqfkaircphlq5ypziovweekt@ucyhurn6ps47>
References: <20240730-tzmem-efivars-fix-v1-0-bb78884810b5@linaro.org>
 <20240730-tzmem-efivars-fix-v1-2-bb78884810b5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730-tzmem-efivars-fix-v1-2-bb78884810b5@linaro.org>

On Tue, Jul 30, 2024 at 05:38:49PM GMT, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> qseecom_scm_dev(), qseecom_dma_alloc() and qseecom_dma_free() are no
> longer used following the conversion to using tzmem. Remove them.
> 
> Fixes: 6612103ec35a ("firmware: qcom: qseecom: convert to using the TZ allocator")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>


