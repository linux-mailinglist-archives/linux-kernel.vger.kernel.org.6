Return-Path: <linux-kernel+bounces-369376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B251A9A1C8D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C7DCB27329
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEED1D2F58;
	Thu, 17 Oct 2024 08:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFCptwy+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2091D2F50
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152261; cv=none; b=ISSLoBSoS3f2ghsPHnk/Roobau54pyxo8WYz9nJC1OJjspU6tEMs7VTv/4myKjfE7zQaF7J0t8dJxlilbKg50LVKVMnJwOniAOqEdtCw41H0cp4K/42QNI6X9l+r3UzEjNK3m4PqTdPePCTYZII0BuRi++LuygTLJ8eVGRlDkxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152261; c=relaxed/simple;
	bh=gtaBUmgxl2HdEconv9lj1dXNVhYyJlwHFuoeJGtu7m4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pu1sigh1sYJ5mO2bt9ZB1xp/6uAtE5x7PmheIHv+n4j3sewu18lXEhoNQ80Tabl/NXIDwBibL309GojqOJwN+GzES9K0vpEuv2KrmFn+yqRVwX64+5TPZqPtXwoUFao7XwiKKuKLjlqlmblQp/Pe9/aOUdghm3Z2GIBQeKLMSqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OFCptwy+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729152258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZO8UCuKbSZt+/BzvbR8aK7OxMm4lkhtuT9Fr8MXR7Uk=;
	b=OFCptwy+Cn9dsa4HoKXxl1h1ebIqzhgvqCR0N+q4G149gB2uR3Y7gCe/U/8BjafOdymuZU
	D18X7bF9aF91bPdkFVWSD47YL0oK/qAQucQoKQ+7wrW5TC6GiHmdijqWHjHC6h/6xt2pN6
	c1menjOiDSdxoRGrcRhC90ui71Fb2NU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-n8vZB7w2PdmjTze2UkBxNQ-1; Thu, 17 Oct 2024 04:04:17 -0400
X-MC-Unique: n8vZB7w2PdmjTze2UkBxNQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-539e294566dso411676e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 01:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729152256; x=1729757056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZO8UCuKbSZt+/BzvbR8aK7OxMm4lkhtuT9Fr8MXR7Uk=;
        b=I/771osXUvE61CaN+XaEUV+t1k8ra8xPOaEaUXQZR6QJqZR69SdUfc5XAJvG7RuKhF
         /v8K0N28L5z2Dnqo3VLOqX2JcA4MTy+QtX0UNT0qGxeANhOQJ/lzwAf955F18OV21JzG
         Bg4ZfjYTjyNYfWOI8xcMYd9tABGQQZVljyQIXKvagKwfjUpe6eJhO5RF5Rfw+mrtaVD8
         0Ut0fCI26RmKr/r5cGBkrb8rDIyx1+JBe98RFt+OFgfoc0Xyso7LKm52aC2pMLikhFjk
         8/Uf7xNh8Ek6yR8qyKYDrhv0fkprmMnj0ecC0r4BV8CMYUqTISkCkrKfkWmxJ/wrSTQi
         W11g==
X-Forwarded-Encrypted: i=1; AJvYcCUwNteLOQPrvZdamXrom/7ZDahrnT0RrsuabZ7mSFnEoHXAOG35UYeiKbti979Fg/OmUo2vgDsT909mxhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMtTldDl+f9LTaiubFzs0qHlKb0+Q+G3eJ/WVyH8C+pDiOC3Ec
	EzB+Ye8RUZQImNrxM7Ite7TUN9QVl/QTndUK9Xki8pIP6qh3kKaJdklFVOGUaU9JKZhFuimgbNr
	RoseBjtgmZ0bHOi03SSdJZQVuv1QhrWc02y/FhhedWe+ias1iE9eK8SfebWa3FA==
X-Received: by 2002:a05:6512:33c8:b0:53a:bb7:ed77 with SMTP id 2adb3069b0e04-53a0bb7ee58mr1677322e87.14.1729152255771;
        Thu, 17 Oct 2024 01:04:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBPfQRYMHFp3GTkkzKGNINwnC6QE2O6rfOaHgOQa9hVwPABw61gd5NSheFE2souMGZG1P13w==
X-Received: by 2002:a05:6512:33c8:b0:53a:bb7:ed77 with SMTP id 2adb3069b0e04-53a0bb7ee58mr1677302e87.14.1729152255318;
        Thu, 17 Oct 2024 01:04:15 -0700 (PDT)
Received: from [192.168.88.248] (146-241-22-245.dyn.eolo.it. [146.241.22.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c4dc29sm17967385e9.36.2024.10.17.01.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 01:04:14 -0700 (PDT)
Message-ID: <53cd75e3-79c3-42ed-9fb5-4d7258d9bffb@redhat.com>
Date: Thu, 17 Oct 2024 10:04:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 RESEND] net: sfp: change quirks for Alcatel Lucent
 G-010S-P
To: Shengyu Qu <wiagn233@outlook.com>, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <TYCPR01MB84373677E45A7BFA5A28232C98792@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <TYCPR01MB84373677E45A7BFA5A28232C98792@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/11/24 19:39, Shengyu Qu wrote:
> Seems Alcatel Lucent G-010S-P also have the same problem that it uses
> TX_FAULT pin for SOC uart. So apply sfp_fixup_ignore_tx_fault to it.
> 
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
It would be great if a 3rd party could actually test this.

Leaving the patch pending a little more for such goal.

Thanks,

Paolo


