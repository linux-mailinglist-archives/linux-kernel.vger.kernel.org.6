Return-Path: <linux-kernel+bounces-439508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AA09EB043
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E673167E8C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C3D1A00ED;
	Tue, 10 Dec 2024 11:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LATMjj9/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7750019CC3E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733831776; cv=none; b=sTVTqsodXkySVTzLqQpQ/RhCMqG9IC+f/3KVj4UvrogPsIxPOiJxoXn1f5s8TBP2WQP8Bz3E883v7uEZpiyakFDnBU1vewRuRGVDOyU5AO4ANN5Ps81Mqm/f0P0vZ1ytgmZJ6rqFcSETIIIoYCWTJLTYbSOpk7AVTjTGvRTnGNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733831776; c=relaxed/simple;
	bh=9D30XLU1YqyFDqV1u6rGU63M73Y+CHh8wTylgtao8T4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nhYGgE5wWxlZ/UZoR3Ml0OI1A2f5Si75j3fKprjNAHXmGFOSzQQy5p1ZNvZUT99h/K5WJtyehmW1AW4iDSQ03aQAw9A0ES7/xs00UTa/IAPWAfdqGQGP7GwpjR+hi0GEhjd2mEnvpj8gclidMyeRtMkMJz/9WEasVYeLIRHxzyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LATMjj9/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733831772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9D30XLU1YqyFDqV1u6rGU63M73Y+CHh8wTylgtao8T4=;
	b=LATMjj9/i2v777yUGdEZ2ie0vGkamrxKQ9CY2/vtiBSsgC4QDC82RzPTxOyt5j4bHZh7Mb
	l3XdkB2B5lFc3cz63LLclskUYQ+MvNJZiE/Ou22AIKCK8qcJAjkkbEwobyh8usqaaN9SVv
	quBFjBNEf6HaZONvT5wczQ8JOIXcLoc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-vzk30Gn2P0-mE6GmOYXyKA-1; Tue, 10 Dec 2024 06:56:11 -0500
X-MC-Unique: vzk30Gn2P0-mE6GmOYXyKA-1
X-Mimecast-MFC-AGG-ID: vzk30Gn2P0-mE6GmOYXyKA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-434f0237cf7so23851615e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 03:56:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733831769; x=1734436569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9D30XLU1YqyFDqV1u6rGU63M73Y+CHh8wTylgtao8T4=;
        b=S4ixxXwa++c5Mvs7EE4E1g3GjgUijWm9CkvuYH4wEBhCcruC3dsQg4+hJEiihMgcql
         2WJn3idFhq1sFG66f1R2YZyxxEj7hBSRLxgb9yQj+o3vqLy4jeBQUvl+iJxdJQIQFfFM
         2p73SK7XTYr8GVtxQCtFmvpNKAItFw9YKnp6Uf7NvC6MdW914E0EkLuj1qKf+t/W26ee
         F+o21GGJjEPFJKDIp/ncSze7mPRqp7V0h+NiJyhdJNW94ek5ibdwKlyd+Duv0Z+OBrvD
         LjNWEpvA4Iy9vcHe+qTsRKAiU/olhCsUT0i6PiLMoNFEDQEe+nU4t3On2hBkiGrik8/q
         uSiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoxB1q4HH7BrjarrdPqNxT9jFOy5QQ7NSHqgcWwG15l53SkoYX8uvnKZp4Nn4iDXxA4sBTp2wstLZJLLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkRGMBchpFtDRRLlgo3NDiNvKb1E1WHyDW5NN3Tuf20rm/Tlh9
	7WRg4mI/nXv+TtPo/2AMyhYKKdbpE9iR25j/xQp9vU7+6jZJlZJfYhOJmNrOEkEdPqD99qOpr7z
	XfBgF/EBH+vjm64iVQeRtcLDwUiXK1HAXoEEj8rEsi/DmTZJAuLt1In7jfBr2ag==
X-Gm-Gg: ASbGnctnmsKAYPtGFoDPpSpT8CfvXegGAQTH89yxDo78hXfup+KYBUDPtzzf0MoLpM6
	Ex4DelSpWgh3g5i0ewIURt58KJQ8YtHUhW+Hq6CKKChRHPgeGLOSYOYz2j7Y2PB+vW8p0MxUpO+
	isLtjUUPtYgau0zo2C30ydiESv1/wJbQnITTByOWcvVQu8n6KU7qMx2kwC9NHe9nRFFp1lc00VJ
	X7al9fzx0aDIhNVfqRuYcXs/mCol90riA8z//H7//baGPXSY/YpS3bo7nceygvbqv/K9LB32Crz
	I2P8A0EkB2aWjpCUjsxEfIV7uQ==
X-Received: by 2002:a05:600c:1da1:b0:431:54f3:11ab with SMTP id 5b1f17b1804b1-434fffc8aafmr36672305e9.33.1733831769657;
        Tue, 10 Dec 2024 03:56:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBbN8A080kEtPt9BMjRTNDgrzEK3dfC71r4vFm7hnAFt6/No3fGb8mFcxtnMlmtMYyN/pmAA==
X-Received: by 2002:a05:600c:1da1:b0:431:54f3:11ab with SMTP id 5b1f17b1804b1-434fffc8aafmr36672045e9.33.1733831769373;
        Tue, 10 Dec 2024 03:56:09 -0800 (PST)
Received: from [192.168.1.14] (host-82-49-164-239.retail.telecomitalia.it. [82.49.164.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da119a96sm191300075e9.40.2024.12.10.03.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 03:56:08 -0800 (PST)
Message-ID: <e6a812ba-b7ea-4f8a-8bdd-1306921c318f@redhat.com>
Date: Tue, 10 Dec 2024 12:56:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/1] net: phy: Move callback comments from
 struct to kernel-doc section
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-doc@vger.kernel.org
References: <20241206113952.406311-1-o.rempel@pengutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241206113952.406311-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/6/24 12:39, Oleksij Rempel wrote:
> +#if 0 /* For kernel-doc purposes only. */
> +
> +/**
> + * soft_reset - Issue a PHY software reset.
> + * @phydev: The PHY device to reset.
> + *
> + * Returns 0 on success or a negative error code on failure.

KDoc is not happy about the lack of ':' after 'Returns':

include/linux/phy.h:1099: warning: No description found for return value
of 'soft_reset'

Thanks!

Paolo


