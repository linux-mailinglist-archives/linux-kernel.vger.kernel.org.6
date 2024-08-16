Return-Path: <linux-kernel+bounces-289701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E600E954AB8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8141F2354F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798711B86DE;
	Fri, 16 Aug 2024 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nEf0lCrx"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475E01AE03E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723813486; cv=none; b=NZhrTocGejSrqP+1+tCu4xXZzi135Ny3A2bmCPtFyriw1xjm8yJe4rNfIWXRIbsjLV2lpwS7imBQLXin9AvGMTxfh3jrnma4L+N0V/C8u1PWOVaBk0r/UfEoeqWgT43/wxac2PMFNxRzKUK35UmqEmZJ8YBX7RhvvvDQodw3l2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723813486; c=relaxed/simple;
	bh=xCA+fzmmUO/Z2zZ9By4jXpGmtLk1cHqcR8WLtleZB8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffNvtens9S5xda1941/My4L2Uj1mhmX3yTZO63Vn9hJdhi7sPz9vLi0mAW9GfrAdst1FA1qsI8ksrO4WI9w6ez3MokjRxbAisWeEA98OZckQhGO04cieliVmYtzkzrLBwNmt4fSS8hdCe/uBn593KSdS8n79sOMCZ8HkWHxCdug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nEf0lCrx; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-428163f7635so15408085e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 06:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723813483; x=1724418283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LwH+A7WJGbb7oRUSLGU41BUJqJ7C+LPqpHnCCWzrpI8=;
        b=nEf0lCrx3Kt4mlN6xR1MexJZxfnHRhy/WfA3SZTAczhesCZcfQpJxg0ogCdQR/5nk7
         xJ561IRVDVEle6Xq/zxD3vzqYoD9ca0cEUP7FSh55BwIy/mHOEF5QjD0iq3NJlU7+tCI
         OgtIlFg2tA7QM/YrUe3Uxru4aWawBmw+Ie8Wujz0nKnTd1t1k40DEGRD9/nNDPHiqEpb
         irStWVJaI6HHWkkBa288EGMme2RYiBwkTVsCOar+AlCT61n8rt/dKvC/of14owjqhNUS
         k58S1hrnFLMupfjlqZspJgEKRsSkEuiLAh4dEHBnWhP/pnzjmXZ+ZKcE8EckOpBlDBAD
         rWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723813483; x=1724418283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwH+A7WJGbb7oRUSLGU41BUJqJ7C+LPqpHnCCWzrpI8=;
        b=U0DbgHguoFdPOOnL4C5/Qkxe14mWhYfEjXtcZXYVowDer6A/xmXadnExSE3jYxRoXT
         +7BYJTPx0uD/nnlJ8PP2VbsDQTySDbkZft6bZE86r9wJnmMWGs6opTkcGVHKLtajnN0e
         NKcSxo9fG8p2BuXC7Jc0YQ3mfSkrVfI/XZwca4UpvHNNUBSBVBOV4DLx8fqfBE0ySgu+
         LKnXyEDC+MrKXUGTUYe1bQizsHUmOk8EWsDzlD1pHcuVIHSRbs3MqijRYWnv9weWm3yV
         3ZoskjuX7VqaJiG07/xVqF+9B1uBHfQwcvWqkmoqDrEjX6b8CfyvtDJ6eslc4MxN4U8D
         HpKw==
X-Forwarded-Encrypted: i=1; AJvYcCVRTVscegkC8rms5gWj1kQJogu9qTAwp4MB0Ssp8YuqEut0tp4bC7GsP/+Hq/9eQRiECkLT1RYkjQEA9Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV7fa39FOLuQs1Oa1nY9mWwXlaZoeO0pEWyjq8Lkc3V7bsywfR
	bhMhWCEwWNSlfpjRLeucc66gPtaW3fZcAqPXt+FkmmG3bAIZ876QCftKZBtGZFs=
X-Google-Smtp-Source: AGHT+IGfiKnlklC0Ei5PXNRVvsnbaf8I+4iFsT9ypdhWM+np2PgwPcKV7gjfF++N+9WO7Z0ipv8AUw==
X-Received: by 2002:a05:600c:500d:b0:426:5e91:391e with SMTP id 5b1f17b1804b1-429ed7cf0f0mr17537005e9.26.1723813483555;
        Fri, 16 Aug 2024 06:04:43 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898aabdesm3610389f8f.99.2024.08.16.06.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 06:04:42 -0700 (PDT)
Date: Fri, 16 Aug 2024 16:04:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jack Zhu <jack.zhu@starfivetech.com>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [v2] staging: media: starfive: Add the dynamic resolution support
Message-ID: <0680445d-1108-4400-b150-4804da63ddba@stanley.mountain>
References: <20240816125132.514488-1-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816125132.514488-1-changhuang.liang@starfivetech.com>

On Fri, Aug 16, 2024 at 05:51:32AM -0700, Changhuang Liang wrote:
> Add the dynamic resolution support for video "capture_raw" device.
> 

What does this change look like from a use perspective if a user is reading the
git log?

> Fixes: e080f339c80a ("media: staging: media: starfive: camss: Add capture driver")
> 

This looks like a new feature and not a bugfix.  Please describe the bug more
clearly if it's really a bugfix.

regards,
dan carpenter


