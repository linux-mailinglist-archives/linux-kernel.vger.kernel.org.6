Return-Path: <linux-kernel+bounces-267169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9221940DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744C02862B6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81E1195980;
	Tue, 30 Jul 2024 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YKMboIxK"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F62194C8E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332067; cv=none; b=jc19iFyuEc42mTNDJu8xUt8OLlRXiyn67xnE/ORVpzvaGUzV1ppSOAZ7eA/hWOkSvDfWRo4fij24UWONdVs8ioUMOtet13d/ilAIGuRmgaNA8Zwb43CFCi8plr3/o+vKPgItuKWQntOF1QfVIqrtZKb6x17t4BSoIFjXhZphXCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332067; c=relaxed/simple;
	bh=U392Lou8sH3zXoESW/5Uec1AYG+M5rvnwiqZyT7YZ2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JX2ZTLJ7ywnzKiK6W42YDzHwwLqDY62C+tt59/jYWAC2kn5ivw2ySbkNY/HT6/uj8Ez9zt2MBU83EI8K6LY0Xy3hNm1TjxtzK/oxS3nGqXpU9mNuMqrjW5MQMn16jHvukCRLiBPk6PrJQoMW0ECWAQFkQ7J3H+yolmCMZrGa19U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YKMboIxK; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-260209df55dso2659738fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 02:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722332065; x=1722936865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WlIH/Z9lg65usVJ6Q+sWdgJtNwPdkT/vb1dBLC+klJ8=;
        b=YKMboIxKLRYkPhrAm5HM1rgm7eCg6HVp0cqiC6JjyQYTeiZkBqas43Qnt/YT7sp20U
         XZDIE+Be994rhGywgnEwgdHuji0uFhoNVglxNWTSxx1cAUHjaxuWcug9mgECFq23klcu
         wxDyry17yq3oJZY3GeB3qsU/KuZstWxC0yWCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722332065; x=1722936865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlIH/Z9lg65usVJ6Q+sWdgJtNwPdkT/vb1dBLC+klJ8=;
        b=Af7UJIPUqr5A8tVV5BJwSEaaVCOEjEH6sgMtM1aOE6m230e/YnPt5gq5ijXKykHQ8T
         6fxkV4t1zBXnD/kGaJdEWgqWe9VsBSJaW3Ga3w2OMIfd97CiXw5HHDAnVh4WjzjzQV6/
         uB7Xf7Js+/5UdAu5i93IPebkTfZVCQDoz+XOW8w1etpLAvsU/QKftTBjKObyyMxzMUDg
         BJZNqpN7xwDKrNBLW6zXwrafL80G6wVfMBpjFAsfr/a4F2K8gi1QYZtbauo7h1fAL5as
         WvgD8FQeByZ/EeOdzuh+sh+AcbNcYMdHWBGcp0sx54v85dOjrxqdFbNcadcx1hIkyQl8
         2qrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg96Pa/ZG4/bPt8Paxml7v3Wbfri7Fr/2q/b1+bjrXGSOSz+ArpCkOh0lCzu4rs170ZJuFpDtWcD/fX1b0YOyyG1ycTRugvox8UjrC
X-Gm-Message-State: AOJu0YzsGF365QJMwCRCSXKiFbs1P81CCDShQRUV1b0dr17w2VsuMKas
	wYcZwLcpaUAt8MqnzaTA53tRUPAaDu5zLZnC14gFjnOPCnfGGNgFJL1qv50kOg==
X-Google-Smtp-Source: AGHT+IEtpTNelSJsHuUJQEyjsPuC4VppOP9xG/HQ0SY22h82hmhZkLT8BMI401j3xIJhPhh6VNieAw==
X-Received: by 2002:a05:6871:3325:b0:25a:eca3:6b59 with SMTP id 586e51a60fabf-267d4f21ab3mr15030469fac.40.1722332064777;
        Tue, 30 Jul 2024 02:34:24 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:a51d:b844:f0ff:3c91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead89e53fsm8099158b3a.187.2024.07.30.02.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 02:34:24 -0700 (PDT)
Date: Tue, 30 Jul 2024 18:34:19 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: alexs@kernel.org
Cc: Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	minchan@kernel.org, willy@infradead.org, senozhatsky@chromium.org,
	david@redhat.com, 42.hyeyoo@gmail.com,
	Yosry Ahmed <yosryahmed@google.com>, nphamcs@gmail.com
Subject: Re: [PATCH v4 18/22] mm/zsmalloc: introduce __zpdesc_clear_movable
Message-ID: <20240730093419.GA16599@google.com>
References: <20240729112534.3416707-1-alexs@kernel.org>
 <20240729112534.3416707-19-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729112534.3416707-19-alexs@kernel.org>

On (24/07/29 19:25), alexs@kernel.org wrote:
[..]
> +static inline void __zpdesc_clear_movable(struct zpdesc *zpdesc)
> +{
> +	__ClearPageMovable(zpdesc_page(zpdesc));
> +}

[..]

> @@ -846,7 +846,7 @@ static void reset_zpdesc(struct zpdesc *zpdesc)
>  {
>  	struct page *page = zpdesc_page(zpdesc);
>  
> -	__ClearPageMovable(page);
> +	__zpdesc_clear_movable(zpdesc);
>  	ClearPagePrivate(page);

Just a quick question, I see that you wrote wrappers for pretty
much everything, including SetPagePrivate(), but not for
ClearPagePrivate()?

