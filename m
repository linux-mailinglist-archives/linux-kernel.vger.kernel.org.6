Return-Path: <linux-kernel+bounces-354489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FE6993E31
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 07:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C81328437D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C324113959D;
	Tue,  8 Oct 2024 05:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ceDYxMeW"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E441525779
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 05:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728364055; cv=none; b=az2uDGb9pv8OYYj5qiTlKQD7QhMvOu8LK2uVTZeBeNC3fu25PRxVLmi2a1XA21ptajunIf4TU7apWwEp10ADpa3ruaANuZdPpQnXNUiZKhZOjjulUlp8dsc3RgAFyo8yY0M26rjP1zEC93zBwM+B0uzBC9BGLXAUSLPRs60uN48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728364055; c=relaxed/simple;
	bh=cs08hUINLa1tlIJc1zutA8MoZsueAc8wZTaJqeQFTH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVG6YOD52sNCdAAViFTQiixx6HrhWDlUsZdbQAgqQ9tCpYiSQGQR255ppNkZx+DqPKpdhKxy2fIPZnMVtjI9myx2VtSoJivWOp3PB7FWDXKgJxxHwMpwhlU0iq5tq8tlzKy0GS9UBNfs0KBu12grc6Bge3RIDVVQxGp/cdXrHhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ceDYxMeW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cbbb1727eso52595355e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 22:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728364051; x=1728968851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=84v3jYX53zy7Wa0lGMm3t9R0biCjWmrfDRpiGVo6OyQ=;
        b=ceDYxMeWifYnI6vgbC07NVjs1OdtCvVjobWGmlDYqa2uqm1iUSnHGcdG5i0TAVCbHG
         UWR/syIWuGsrzGp1OBjvi41Q+PTrdUh0XD1wAjpzd5oN+reBTej4Ihp+xHqi4TBCbHBE
         3LSwyp/dpEv/JeH9Ke4XHp+0cHXajZ/7FKWBn4NnxEG5K2JtZYRKWcvXJmTi+oUq7TR2
         Hyk1ZkhcAVGCRsvFmiXK2J0jm3TGGd8EFrU4FLDm769zY1IIyQ40t7AUB2sdlmTISsvB
         DcI1ZZK6/abU58yzNT6qxkKE4PXoobdqjOzRSYFd/cyCeQ9qAbb1bcZxMKlGGC4EkzMY
         zYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728364051; x=1728968851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84v3jYX53zy7Wa0lGMm3t9R0biCjWmrfDRpiGVo6OyQ=;
        b=Y2Eif+vTPuLbG511lxjx7NMmhrmPsDOBL2VrvFCOAmFlWRAdjDNfJ1uWqV12t1vHcX
         IphJT1Wsy59a/aisrHArnLoMQlZbsiNvHtYAQwpw1ZRTBjpCarSy3A7QUdzAXp9Ub6Nv
         8i7e/Nzccv2+ZLpgFoK3kalpXdZLuuBFroxEtP6T+b3XnDgBHpVejPVLr5D39tNVN/4I
         21ILVzoUQvAZKDEC+oXB6Djz8nYG+bks/rugs8c3bw0Is+rw2b0fClj9M00yow/qtzuu
         gT7IiVJi02KxaKa4hAq1zmxJMcThkyB1Tfu0U0YwTk+n8g39adz5OtcboqRehvDoj9VP
         S4nw==
X-Forwarded-Encrypted: i=1; AJvYcCV1Jk7UMuGrZs6tnTUKUNNIGZd1YM8iu3DOnRDIeeAn0hjL6XWDlOuaSsSZUINQKzd2f4vEzZ8PEteadDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw55cOxCCHOl2GGqh97WNrHR5PZkqeAv24RRaZzlYcs3rKBd1sI
	MGiewwHvxJLd0V3/1b3alqlIqSeVNffUduUhEGecysMDZuyqF9P1PduMd7xyItc=
X-Google-Smtp-Source: AGHT+IH4bDBi1UKehbkFaXFJoAQiq9eJL5S6z2YFW7QYwTtih9HbBqO6OL21q/hrn82RdbRuK1CGGg==
X-Received: by 2002:a05:600c:3b07:b0:42c:b8cc:205a with SMTP id 5b1f17b1804b1-42f85af039fmr96877525e9.32.1728364051187;
        Mon, 07 Oct 2024 22:07:31 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ed9d4bsm95581635e9.42.2024.10.07.22.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 22:07:30 -0700 (PDT)
Date: Tue, 8 Oct 2024 08:07:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: jonathankim@gctsemi.com, deanahn@gctsemi.com,
	gregkh@linuxfoundation.org, ~lkcamp/patches@lists.sr.ht,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: gdm724x: fix returning -1 with return
 equivalent errors
Message-ID: <15bd50de-94f3-4976-b819-6942e028898f@stanley.mountain>
References: <20241007211124.170540-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007211124.170540-1-rodrigo.gobbi.7@gmail.com>

On Mon, Oct 07, 2024 at 06:11:24PM -0300, Rodrigo Gobbi wrote:
> As in the TODO file, use proper error codes from PM callbacks and init.
> 
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> ---
> Changelog
>     v2 minor changes at packet_type_to_tty_index() and gdm_usb_lte_init()
>     v1 https://lore.kernel.org/linux-staging/20241004203458.6497-1-rodrigo.gobbi.7@gmail.com/T/#m258452a56ddade60b2209479f036213e72d43f02

Thanks.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


