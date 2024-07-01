Return-Path: <linux-kernel+bounces-236531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D532591E3BC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A9DCB29440
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BA016D32B;
	Mon,  1 Jul 2024 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c3TWqj6E"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6A216CD21
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846658; cv=none; b=qZbprdfGI79FD32KAPDpo/aOlzTM+j+jTz1pfPkAPy+qXm9Ot/ngUGdQDkKVXaKBAdJbjPcYbt2TKnL6mDOfl6TXLvDKKjEt5kr9II77OE+uNtZ0HwMB0JU8q9p4sDOZTGGYtArdef2G9hov6rVljSd56S3DVvzo6Wm8FM9W5IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846658; c=relaxed/simple;
	bh=lJT8Lk2aPlRqITXr87EIXyw71vgY9gkIgdZoXFH70G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1dg0VkQKLj05clsvQ88p3XteXc+v/5fbHGcOgSQZ1w8pRL/jLGRsOPhppC5JmXt9MjXNyG6Z2aL2+GX0+Am14PXoR2IWNE2L8NghSUIWpeupL5rKkFdk6iYQdJevqdCntGTE3gLnBLKyOXN8DscHikGrWORn080e54s6TWwQEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c3TWqj6E; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d564919cd6so1997842b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 08:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719846655; x=1720451455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R0BExY/qBhAXsCi0xgA49Ox7G6qkL3RnzSr6IH+J4yk=;
        b=c3TWqj6ELPQct0Cfs7vhjhizdaKFpsBwcXVU1hT2lFCp9eiuCUP14xkMNdU59QJ03j
         8zDX204QidMNIqcKLRL1zveEWID1SuZKmy86n/XLBvS/DyuuidscJHRG/NRSuCsPA6qH
         JNZQS4276guj2T0mqvgzulMLIghQ3ZHJjxGnpoKqXQLGFGZvYIxe2dvXMJ7aPvuEV5wh
         EM4WESIb2zqCOcabE7I9vDXSQ2dxOfs2aZGs2AksXX5jNXLpLtYUjVVxWIVjayyuDFaY
         K5KqdCXuPTl7CSgz1sfcw8mp1zX0kjxNCNFQUkwMmMtNSaWdgmv7IJ7jFZm6jrn6gluT
         P/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719846656; x=1720451456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0BExY/qBhAXsCi0xgA49Ox7G6qkL3RnzSr6IH+J4yk=;
        b=c4N3xC280QZVlXUNzgLU6LxIWaPFVDOH0XaKuDfQAhES7dZ7xgnj/hSpLNZpyo0R72
         i0G9+LAvTMXwV7mImR/9qwlHJqbJhH46ETsDlBKEqYYZKpedkA0iI35OqWqZudx/q24h
         tu86bmIy5kcteznedKwqDM7JBVKMllMoJWVYgrOvR6dN7G2X+KEY+KwTSfwJu7xD1cuK
         zLd7Ft2tEpnWAtVmwqik9fHYMBN2fyqdxvtsnU0+tB5HOsmZKKCnQDvbDrTwtaQNQpf7
         qvZlR9CaBzSU70KU/P0TH++M7VmTVFiWl1tDjOuzXLwIJXYQtLNkqC0B4Y9lzMcNqPvn
         7WMA==
X-Forwarded-Encrypted: i=1; AJvYcCWFm9oQAszYT7TOgZxgIBWVz6bw+6GTwCfYkTLHSDu9KychuUFeFFOuz0+9XyBUl8Egi5O57V8QiLi/yudsKVeJhj8zE+g+Kw4omkFa
X-Gm-Message-State: AOJu0YyvhLcvCe9PVfEqxqyIlcte2+noEucoiIwNht0xFzAD6HcLS2Ay
	vVn1CzKOC0HqszwD9KsiVjDkMLM3Si5mrodrXS+BvLtT9uNSLMto+tCW9QDIq7k=
X-Google-Smtp-Source: AGHT+IF6YwJN4Ni+B2pppaly3KNc0+sFLlPuO2iiu2oQ8LDkTrCGjp/JFalsvNhFMjuistzCA5vRBw==
X-Received: by 2002:a05:6808:3014:b0:3d6:32b7:7364 with SMTP id 5614622812f47-3d6b5686a38mr8478530b6e.57.1719846655648;
        Mon, 01 Jul 2024 08:10:55 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:e8c6:2364:637f:c70e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d62fa00133sm1368692b6e.28.2024.07.01.08.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 08:10:54 -0700 (PDT)
Date: Mon, 1 Jul 2024 17:10:52 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jacky Huang <ychuang570808@gmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH v4] tty: serial: ma35d1: Add a NULL check for of_node
Message-ID: <e3cfc874-e590-4b4b-8822-972d8c7fc98c@suswa.mountain>
References: <20240625064128.127-1-ychuang570808@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625064128.127-1-ychuang570808@gmail.com>

On Tue, Jun 25, 2024 at 06:41:28AM +0000, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> The pdev->dev.of_node can be NULL if the "serial" node is absent.
> Add a NULL check to return an error in such cases.
> 
> Fixes: 930cbf92db01 ("tty: serial: Add Nuvoton ma35d1 serial driver support")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/8df7ce45-fd58-4235-88f7-43fe7cd67e8f@moroto.mountain/
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>   V3 -> V4: Move the version info lines to the correct position.
>   V2 -> V3: Added the "Reported-by:" line.
>   V1 -> V2: Added the "Fixes" line.

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


