Return-Path: <linux-kernel+bounces-187954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C4F8CDB33
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 22:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87DC6283FFE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 20:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037C9282E2;
	Thu, 23 May 2024 20:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtqPOKGA"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE88535D4
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 20:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716494848; cv=none; b=j2j/v6Tz/1A67RrwdVAViD8lAixJKLj84Vp8l8UdbcFi1pql2WpUBZtFKF33NrFu/xLW4aFT/G02JEGNRAR6O6ZwfRP8jI9IALA6xqUnuh6gv/OFHJpn/ji5g6Nc5eBLpS0Ikb3zQDebcv9wMAcDbI8IHhuzMAXfWmGzYoJlUMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716494848; c=relaxed/simple;
	bh=2d1CJhorrDMIVYkpTcXwLIMkbxnSfCS2p0mDoQiNPwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PiKWuccDlSt0zqnoF5CFPwL1cWIv35lxsJKF313uJIAy7VDcAyIffbe/tld8Hg2e1d7ArO24Z1nZAJ6O5G4vYA/RbLlgkOFfeRVJLgUO+qpRjxWAjqF+mM3799pzYMZqK8WmaOGS9JizW5Q1Z44pitqRddPGhEWXFIDoYepvKHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtqPOKGA; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5238d49dd5eso210604e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 13:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716494845; x=1717099645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZaW0YeWd9W9RWy2XGhmCKnTq6HAsW7a5Iz8eTGNYJ14=;
        b=DtqPOKGAi5baKmmCddmNZyu/HEDw+awr6GhMEP51maeygigOPDkmvkzqyG4Q1vq+GX
         4lRX4LihSV7MF9afIYfrcSqIMj/S9XDt6dmSuTdq/mtp+NaOaNKlPQYKbLX7BaOix0+6
         8qhqRDJM6Xq+mc8wN3fNe5u2L4wC2ZHp1Sg+XiQ5kXK2D+YhLh7R8jQGGYyqWRsrfzJW
         yD8GYeNu6FmX/I6xWW6GSKbkrHXz02XlZhasuQVfb70i5uSvCRCsPn34Qq4mBGFOI2E9
         rEn653ffifKiXPtfWr/ZW/XKEb/bCfE2V6Nk8l7ahdjLVb+/x2jZOQ5ynjuQLeLztQ/t
         TTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716494845; x=1717099645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZaW0YeWd9W9RWy2XGhmCKnTq6HAsW7a5Iz8eTGNYJ14=;
        b=naXMQ//eTtRKwrZilviXIxXMdJj0prtGFi72uePkpdXW0cdRdTP4yCjigs3h1Xo9cU
         g0qYjxHAInEg+49qBzkQv4BkcxFy/O31jF02P+/tEkedKqEpSu+M4eOUd6nqpndaeVOj
         1kGTNvXFPgk4ovx6dlYPjJHPvkDg4R/0+ukJ/TtuLq8aWJEySj0NqLe+aHS8LRID+sT4
         oK1kCQaimfSzjOKyuqxPllUSWu7Ur4DJI3kgZs8wPBbPtdu0SUfx+lP9xosxuGDW9BYu
         wp/ZhFe+fmGyZnnwn5OvxDVMqL9lKLN+J4lOCRVNZPE1NC9fjsJEFt5SmxGtaq5zFru9
         zX9g==
X-Forwarded-Encrypted: i=1; AJvYcCUqUOrN813UoycssiLx+SDdAqGxP9b83Cw9RsHaDTyGAPSdjLVY8/W3JhMhI5SG7VSnf0U2nxlcYVEY+obYMxFOvOKNJ/rMZC5+GLUX
X-Gm-Message-State: AOJu0Yx1S97mYH11d3DmuPK9CWJLtN+637UcZTD7/kuyVUX1NR9+GJOX
	SUAOKUI0rUDQCWC6Vb6NXdtPKeA01z3IkVWzUzmx0VV3Z4aClir8
X-Google-Smtp-Source: AGHT+IECPlwCDpDrzkV9K4kzMzuvIu2MUp1Nz/mNd/l/h0qCNqTxfv04Qrg3eQ9DyAzjPy9VotCIxg==
X-Received: by 2002:a05:6512:68f:b0:51f:6b63:75a6 with SMTP id 2adb3069b0e04-529619867acmr109619e87.0.1716494844854;
        Thu, 23 May 2024 13:07:24 -0700 (PDT)
Received: from [192.168.0.102] (p57935690.dip0.t-ipconnect.de. [87.147.86.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c817088sm4265866b.24.2024.05.23.13.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 13:07:24 -0700 (PDT)
Message-ID: <ab941550-b78a-4b30-a3eb-68c8967f6cb0@gmail.com>
Date: Thu, 23 May 2024 22:07:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8192e: Fix spelling mistakes in
 rtllib_softmac.c
To: Roshan Khatri <topofeverest8848@gmail.com>, gregkh@linuxfoundation.org,
 tdavies@darkphysics.net, garyrookard@fastmail.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240523035952.59724-1-topofeverest8848@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240523035952.59724-1-topofeverest8848@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/24 05:59, Roshan Khatri wrote:
> codespell reported misspellings of temporarily, possibly, notify and
> param on rtllib_softmac.c. This patch fixes the misspellings to increase
> code readability and searching.
> 

Hi Roshan,

please do not describe what you do in the description. What you do can 
be seen in the patch. It is not important which tool found the isssue. 
Keep the why.

Thanks.

Bye Philipp




