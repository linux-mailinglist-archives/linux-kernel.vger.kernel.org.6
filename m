Return-Path: <linux-kernel+bounces-422134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA059D9517
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FBEEB28BAA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CC31C3023;
	Tue, 26 Nov 2024 09:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fbyws1c2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FD8195FEF
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732614989; cv=none; b=rOVJyZ3HZoTg7487c3LZ3R2AOU+iWw4/2QK3T/uNiPWtIP1egEm3GrFtsRBbZFlbfme0X8LgrbN51ogMCPzpuQeTuDRVgxb6IQpHGSvmJRsWpqZp1KKbEmOMYIthYVVsGVLlFY9gfzpIJYXAWEMbVY7pMBNmuuUyEmhVSyoZ69k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732614989; c=relaxed/simple;
	bh=qTXEGV1NqvoB9oYQRL651OM5jxH+Id9oPw0Gr+SEBnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xw/PfXal9ZHlQFChjUt908ZmdosoVGGRkz+G9ARAQV51BiKatsh3F66vDXonY0Ry1UWtN9fKqe+FQr0N+hHGoqxDRmFaFCZ3/oUuCupXw1L2ORLGfBpm243u30RJB7yMm9OVxyicJPykpmYVfUEmmoIPbc8kLgesIBHGMjhu0oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fbyws1c2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732614985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oKQIRQM0DHbMs6DhX26g6JtTMb0P+1aEq6LX6Prz7ww=;
	b=Fbyws1c2A0HDLitlM8hGmf6l2mUmy7N9C9EJA3tdLhffHdLBRrCb+ePp4s3TvYgAE1XgFN
	QN4cYjqXNm0XPP+0YQqODEoDuMEjyJ17WxjHPtQmVZLIPnKxzAD7jL71jFHInRE3IZiodO
	2IGdObkTRbbMWmRVLC0M0OXMEO+bye0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-sSGrKW87Mki00uaOM1Wy9g-1; Tue, 26 Nov 2024 04:56:24 -0500
X-MC-Unique: sSGrKW87Mki00uaOM1Wy9g-1
X-Mimecast-MFC-AGG-ID: sSGrKW87Mki00uaOM1Wy9g
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-382299520fdso3420004f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 01:56:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732614983; x=1733219783;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oKQIRQM0DHbMs6DhX26g6JtTMb0P+1aEq6LX6Prz7ww=;
        b=B5SN3iuj6hZ+HHF2zRKnw43k10QQDZvF0YGf+/WmmyG/s3961epxKNCFYJLfUFW4jV
         DNOBpnXD4VscAy7+oC3dRFeLEbbxHgCRpa11GHnPNg3ZRkWa83m7bNvxmGZj6qqtE/an
         rFnGNJ73P/e/XZvf+bhQy86cUUcSYen0aHHWFHVDRCeqTYUH+w6JNBUXaP16ip9CGSiw
         Am4OV/Oq4OmFv1ID07+o/iRi+Bmh1998vWDEltTxfNG7QVG1zAw5YbhMwbDazMjZs1XA
         wF7yjD7cJ4Xw4Fl0xaBhfublVuwRIMHa8maV8PZOawjceR5oyu1+Dz3PJ1K3zmubF+nE
         1Fgg==
X-Forwarded-Encrypted: i=1; AJvYcCVsB0viD+/VAmfzkdO+whJt42j40PVNlcWOoEm2BLYpoQBTakOBfvwRAIWJCYzltmzNEOVEV41IGsMwM0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHXlg8Au1wxjjNgHyGK1GVyprrceo9DJh0Wjl4olo2gnvnmhmK
	pFWA8b4ScH4Ah/coa8YWN5q+eaIu38S0RDin5MGmLkfY+WQZv7pNPNCn5l3k684p8riGsIqO6XT
	P1+nH8TpZbf8yOSewe5SqwfXdf2ryBIvdt1LG2j75FL1EJ/Sc21DJa9oxm9JgMg==
X-Gm-Gg: ASbGnctNAusqzVehYFhowmgGda4ZWicGuDYNe8+CP1obnh+7o2RO17TkbvzjRngGlcy
	U2PEvrUaNKm8ZG5Gj4tGuuRuNnQxAqJeKsVdSL5hZVDJhFY7USGkKyBOAjAP5FGJ8C3yYyH7Tcr
	Ha/32VoZnhzTC/uQb2z1ZelrT/cKoOmuMu/+e29pZMsEl3Xqmf874QzFVqrdpuzgK0oz6/NfP5Y
	QBE/Sk+CYRj1iGK3XblAA5lmFlU7BY+6cWksUoxf27PGYPxJZjQCQoPvEammTOXCpNoxSqL8U0f
X-Received: by 2002:a5d:5f53:0:b0:382:4b80:abc8 with SMTP id ffacd0b85a97d-38260bccddcmr13487968f8f.46.1732614982806;
        Tue, 26 Nov 2024 01:56:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7er+9nxXHPAG3ENsKoLjcP60A9V+9a0RO/xgQmaA3KSqpNdUGKqVrkbSnBm+ieOOasQsuZQ==
X-Received: by 2002:a5d:5f53:0:b0:382:4b80:abc8 with SMTP id ffacd0b85a97d-38260bccddcmr13487949f8f.46.1732614982505;
        Tue, 26 Nov 2024 01:56:22 -0800 (PST)
Received: from [192.168.88.24] (146-241-94-87.dyn.eolo.it. [146.241.94.87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbe9013sm13078237f8f.88.2024.11.26.01.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 01:56:21 -0800 (PST)
Message-ID: <9a2b27d0-c65c-4954-875c-65ad144bc584@redhat.com>
Date: Tue, 26 Nov 2024 10:56:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/qed: allow old cards not supporting "num_images" to
 work
To: Louis Leseur <louis.leseur@gmail.com>, Manish Chopra
 <manishc@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Florian Forestier <florian@forestier.re>
References: <20241121172821.24003-1-louis.leseur@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241121172821.24003-1-louis.leseur@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/24 18:26, Louis Leseur wrote:
> Commit 43645ce03e0063d7c4a5001215ca815188778881 added support for

Please use the following format to reference an exiting commit:

commit <first 12 chars from commit hash> ("<commit title>")

> populating flash image attributes, notably "num_images". However, some
> cards were not able to return this information. In such cases, the
> driver would return EINVAL, causing the driver to exit.
> 
> We added a check to return EOPNOTSUPP when the card is not able to
> return these information, allowing the driver continue instead of
> returning an error.
> 
> Co-developed-by: Florian Forestier <florian@forestier.re>
> Signed-off-by: Florian Forestier <florian@forestier.re>
> Signed-off-by: Louis Leseur <louis.leseur@gmail.com>

This is a fix, as such it should target the 'net' tree in the subj
prefix and should include a suitable Fixes tag.

See:

https://elixir.bootlin.com/linux/v6.12/source/Documentation/process/maintainer-netdev.rst

for the details.

Since you have to repost, I suggest re-phrasing the last paragraph,
noting that the caller already handle EOPNOTSUPP without failing, and
using imperative mood.

Thanks,

Paolo


