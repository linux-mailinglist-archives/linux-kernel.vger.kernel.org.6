Return-Path: <linux-kernel+bounces-190224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F748CFB92
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D206EB212D6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528F86CDB3;
	Mon, 27 May 2024 08:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ht1Rq6zI"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBD762171
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716798885; cv=none; b=imo/oEHCb0vaaLEih7JYxpgDeU+H89v6lNrvi5mjS35dHVjFO5c7lrjy30HkYLg9/d2YBMwTGnwVFXhs/sPAUeMoFnSZQ6Dg92uaHorYlYlBVNN8LPRuEJ2Im3GX0rav7IQ1BdkHgSDjqgQVqoi7ikKSo46KXk+p+crIGvz4UYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716798885; c=relaxed/simple;
	bh=tXZRx81eEbuHAbCFv747A3OILagB8p7XaUeXKqNAqYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TwmYm2MoFYOtMhw/h9xXDjLJ9pL5rAxhpStZEP0l4UUUCLzLoNqiyJPKwOqw3kqA4gJgfmvKSghwaQ/beZG3ReWbOA7+nnaDjNa6CznuxFE6M9ku8bhMZUrwn/71/t6peF54kynoMVuTG32mfk1OZbQEvCiZ5MepKBvCUQJpp6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ht1Rq6zI; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a5dcb5a0db4so1039374566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 01:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716798882; x=1717403682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=89gTVpqQz2vQMBQkvJrye9cud+oZDcIzouNNJ3W/FMU=;
        b=Ht1Rq6zIGFJUmPm2iFnDj6wYBjwNVjXxFmLQPZORfTasZ/csqA7brLlbTAqZLSL3Y0
         KrKGx2uzs+n1yCEvJwwH4YmrqoFkeQb18fE8ZP6WHEbUuPY+S7ioFP1mGKtT8WOp2Gt/
         RX3jZLu15Nrqi9Dv4+t3z0mrCpFXcrYFTnQla4vicPrc9jjYgllUHKcZNHzGX/2ThjVD
         bNab7eSV7K2jynuYTP4cVPigvA89nk6sF2NbG3WVFGpXiMN5dS2SddhVeud3WHYx+MtC
         WmzvBgxKwyCO5Afwtv/Z+zdd09ii98JslF7KLQfB/cKbjv9oSCR2VAY29wYm+gl0eOhy
         ZC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716798882; x=1717403682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=89gTVpqQz2vQMBQkvJrye9cud+oZDcIzouNNJ3W/FMU=;
        b=CE4+7P+0ymHwYAZqbFVlabUCmJr+Mxg6VkArqE3prAvMIxgmrKi8jJRIxn83e+3Ga2
         T93i9kXUNAbdaefWaMimLELebCOAWnTxBuq0MRz8WVkNXWdPVxD/AjJh1zPrS3xnVMGS
         TyDtcZOr1DZbVyf0N8dIGLmaANsYpsAGp2RhvaCco6nzsjYacPOuyNshkEkbx78m4ZZH
         ZT4if5BzC87VKd/h527CbDcqDJLN4Y32jFTKEqmPjtKDksRQOdGSjpaInK8AB7YV8DZE
         rF5TRf95UoC0u0N/2WAu1Fb7bYueO4XoYg3UA4OGDbwAtbbcpaRb0puyVLf8DRbvNXZM
         cf7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXyMkIxv9k+VgkAr50plKPH2lVC6S1mL6V2dsDpJVjgX1ggLVmyiye4QfdPLrPJEWSkqFNx3WoUIZriXCxhkf3cTxjo2klXCileeHjv
X-Gm-Message-State: AOJu0YwNEVAtKvEU6zQFHXQZJlYpyY1JgryBgHh7YEgXfM7Dv/FrM2wA
	UoGET8JP+W0EwmQEB4RdY56DyDqyo/xgJVbnsvf66Hxmo6W9q/2Y
X-Google-Smtp-Source: AGHT+IFFsAlnRfTxFBbD6kdBrEdB+GYdJ0PgJkCPnudEYrx6FH/H3dhbyckfurrAOLMPIEw+bI7VGw==
X-Received: by 2002:a17:906:28ce:b0:a52:6fcb:564a with SMTP id a640c23a62f3a-a62641a8d45mr526028266b.9.1716798882222;
        Mon, 27 May 2024 01:34:42 -0700 (PDT)
Received: from [192.168.0.101] (ip-77-25-34-87.web.vodafone.de. [77.25.34.87])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c93a807sm465270866b.85.2024.05.27.01.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 01:34:41 -0700 (PDT)
Message-ID: <2d1dab52-72ab-4f4d-8f77-ae54f16b9b4a@gmail.com>
Date: Mon, 27 May 2024 10:34:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] staging: rtl8192e: remove dead code
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Nam Cao <namcao@linutronix.de>, gregkh@linuxfoundation.org,
 philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240526111928.14574-1-straube.linux@gmail.com>
 <20240526111928.14574-4-straube.linux@gmail.com>
 <20240526143100.FmVupNWq@linutronix.de>
 <e25831a9-9913-43da-831b-d37bdc4d9dd3@gmail.com>
 <9802cc9e-5962-44a1-a384-3e5ee226cbcb@moroto.mountain>
Content-Language: en-US
From: Michael Straube <straube.linux@gmail.com>
In-Reply-To: <9802cc9e-5962-44a1-a384-3e5ee226cbcb@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 27.05.24 um 09:39 schrieb Dan Carpenter:
> This patch doesn't affect behavior at all, but to me the original
> author wrote the do nothing case for readability, and I don't have a
> problem with that.  In fact, I applaud the author for caring about
> readability at all which is not a given in staging code.  :P

Then I think it's better to leave it as is. :)
Should I send a v2 with this patched removed or will Greg just apply
the first two patches and ignore this one?

thanks,
Michael


