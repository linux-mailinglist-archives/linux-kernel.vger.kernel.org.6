Return-Path: <linux-kernel+bounces-435455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 160F89E77F5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E18E18838F9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579EB202C50;
	Fri,  6 Dec 2024 18:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="ihp5NaUt"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6E9256E
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 18:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733509028; cv=none; b=nBdLqCWjBoSyJH0gihhJq/shCJFIyRziY7nZ/H7sSkmp806l2nYLH54vYcdL3O+HWz8WuYJGK7UzWXdg1kcAQRw5UUTs0vFQH8DeY5qABtKtt/C6qVULj8w/1IdSp4dW0Y5rYx79hcWKMn5CqB63C4OYA9m5NrUZ8IXvXnipFtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733509028; c=relaxed/simple;
	bh=0kmwuOz7qibXuGzXJBalsi9zlGLF7Gq28kA45wgqC4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iSw78eCfq7O1Zt8jTrqa0I5wVROFkxW7y9vZAL2Drq8A1D8qEsQCb53N2QPaTK1F2tYs/12+FnD+9SinH/TIEWCIO3CpyNAtJgfylmST0z/u2orx6UIO+sQ7z+v+PzpMRHRuYoowKArjmYFb40KkE41TX4wJr8uQSJhRCMMYLNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=ihp5NaUt; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30024c73101so19680361fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 10:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733509025; x=1734113825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T6ecbloalYthckNBNhPOKdoCIqqonfcHxmM2rm8Txtw=;
        b=ihp5NaUtowz+r+K4K4TJxGidG3B0l0vYq75fCy5U0qaDlpayB1vrPqEqGMyD8XKl8E
         zwRmIZ3aG/A4n8lXj55V0S0SMq2gHI5ZfkE72HLvIMxatAPL/Vbl1x3SD415DyUbJVb7
         Mdfcj8C5Rn3+NJWFaHaoSbt8otVWeM9fomtOwVMxVUqidmcfWrEmMp5JajX+7U9iyeh7
         adN8tNA3E+POvtvT1Nh5VfVXgGF9HOFOKbaUOO0d9xtO6poWd8u81wawD1+yB7jZcjxK
         5nQrm3o+0Ps5cu7fqX1tGIGWU9+H7ZzWBljib5h5IVUYcjCv/cCjg4QxTFJp1+DEC5ft
         dWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733509025; x=1734113825;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6ecbloalYthckNBNhPOKdoCIqqonfcHxmM2rm8Txtw=;
        b=RBDBtsrDPA/M4ljl4wTFiQ4WP1FwvXJRJ/wmKwzhtTmrVZ8zPRf91UPPRaApeQpwjC
         vKPEXJMprd1H2hDUS+FGhQQydvCFT7tqyOekc166F088JTczZLvUSzLBuNZd7OvSSY+5
         UuJSaF7ZY5GawxjQgQ0VdqNQxDSChGEdBeolzn4jrMfWVKlqrQANI/d2ozSmk+mvCkKl
         4fZ7fbOosC1PBgnRzj2p8RYm+QfiJQQWC61cSJSwiNA3Jd/2ZuVh8jgNBxapBUSo0NMy
         YCCSl+FwRXeZhmGoGQunwEX6UeUiRj87RXNsGCjuzD4MvHTZL9IB1EjBmaB0heX3t2N8
         3iiA==
X-Forwarded-Encrypted: i=1; AJvYcCVB2Yd1UVZ9vhOZCFcRImPcfWi7ZgFOGicLCnGSVFdOZ6oV6Rt7mCRppb/58GFtYKwZsjQ14iAFKHb+U6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6satKXoHwJPT5TaliSHXnDXC1qsTLPx2VpCnwQ2F+7T8+0mue
	xJ0/g3MMKhnXceDsji+kHDhBOxt0tZnwhwvSSjPQrcN/owY6h3NRYzfTHN43wYg=
X-Gm-Gg: ASbGncv9zFQ2QFEyrWDgEEnFSrqS21xv0imosA4r/+rhXqHWh+/KRMM6Im04PAfzjRf
	V2snZe9dG1f17wqQeZbw8sm35VIMwJdBnq3mwXwqxOPuUVDR/GvyjEID9IypeQ2O00y7jIxqI3Z
	efz09DMkavAmixwtZvkXP3PkPdBLogz0OJ13fK8s00lt9PuMehU1YhphF2T/pmyWyd1nm8s7wbV
	dSw2W17XTZ24Lq33xm3SI2KxIoWgoHSMiT5fJ3P8vB3jCqX6tPsu0RNvxFB6ml1YGLKJQ==
X-Google-Smtp-Source: AGHT+IFSQk4LVXdGCOIZgkcmUG+e+P3Squ0CFAeeVN2glBcgom7D7Xbv7QXnrDJUIxPedfYrmXMMhQ==
X-Received: by 2002:a05:651c:2119:b0:2ff:db26:2664 with SMTP id 38308e7fff4ca-3002de40268mr13998711fa.6.1733509025014;
        Fri, 06 Dec 2024 10:17:05 -0800 (PST)
Received: from [192.168.0.104] ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020d85076sm5301271fa.23.2024.12.06.10.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 10:17:04 -0800 (PST)
Message-ID: <3796604a-0636-41ac-b7e2-13ccd0694d4d@cogentembedded.com>
Date: Fri, 6 Dec 2024 23:17:01 +0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] net: renesas: rswitch: fix leaked pointer on error
 path
To: Jakub Kicinski <kuba@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Dege <michael.dege@renesas.com>,
 Christian Mardmoeller <christian.mardmoeller@renesas.com>,
 Dennis Ostermann <dennis.ostermann@renesas.com>
References: <20241202134904.3882317-1-nikita.yoush@cogentembedded.com>
 <20241202134904.3882317-3-nikita.yoush@cogentembedded.com>
 <20241204194019.43737f84@kernel.org>
Content-Language: en-US, ru-RU
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <20241204194019.43737f84@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Why not move the assignment down, then? After we have successfully
> mapped all entries?

Just realized that moving assignment below the loop will open a race window. DT field is set inside the 
loop, and once it is set, completion interrupt becomes theoretically possible.

Furthermore, realized that existing code already has a race. Interrupt can happen after DT wield was 
updated but before cur is updated. Then, with the completion code won't check the entry (up to a new 
interrupt, that can theoretically not happen).

Will fix in the updated patches.

Nikita

