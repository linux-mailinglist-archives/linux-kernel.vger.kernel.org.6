Return-Path: <linux-kernel+bounces-416695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D049D48E5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFA08B238FD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5AE1BC9FC;
	Thu, 21 Nov 2024 08:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJTfxSDu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618AF13BC3F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732177960; cv=none; b=gV4V9fpM83xkN/tAVRTX2UrVz/sJEvpQH5k7BqB2cPAi43b3+jexdpgPxojssE2OHQDr4sC74LWBTcaUbTDCNCDmD9UHJpY1gdKYU6E3z0H1MSaXyjXa6BCIEji1rNhClmtur7K+10Eu6HXagj8JbaWk5b6ZVS3Qr2CsbW8uwBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732177960; c=relaxed/simple;
	bh=4iiaUOGz93H1S4cgbsdyBLjhynmeCThSmYSKF4EHkCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s+kNn61zodlkCHN9uF446NG7fQM842nj0WBwkBRMJ8/jZ8NT6Cpb/TxbUpalw6PntXgzhF8jqdX/0mk1AT9Y1OxKYHs3vUPSEeCAf7FEjs8aGsObyxdQxhQ8L9C0alJ8gyTOe9spnF0Gfxag/KGnQifGaD7ngjOl1elvp5r8cN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJTfxSDu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732177957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/HS64kzGMgc1claFltF2m+ECVBO0rJ10VKJs9lIo19g=;
	b=GJTfxSDufpV3RUIpATrb4qmJ6iM4cj9WCt7I7PETGSFOFxsmnI2xrsFRKN9cR24Cfs3WoG
	4PfbFLG1g4/5J7HOheK+ZS8QlSOcaWbaWo+1oXRn9x9w6sHSU73Qohm9HRBbubjBery4TU
	0obG/VECTQ5ZFgdGOnSy1zQpuSFqBys=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-qx6RmW92MiWVvpU1iYCLDA-1; Thu, 21 Nov 2024 03:32:35 -0500
X-MC-Unique: qx6RmW92MiWVvpU1iYCLDA-1
X-Mimecast-MFC-AGG-ID: qx6RmW92MiWVvpU1iYCLDA
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-382450d158fso362113f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 00:32:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732177955; x=1732782755;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/HS64kzGMgc1claFltF2m+ECVBO0rJ10VKJs9lIo19g=;
        b=fobYlVgGjv1ANdzbRPJRe7576Hvzd9W+S5GEkj9JA6JIwha+3BmhfMT3Enji8i3XrZ
         63YPB62pEG+kyOSBi4tN8yBVvfSZiDBlZ47tCZabzM1Ck7S5IQrJX253oXRvh1PSYLHe
         bLTm7H6NBbdootKFBQV6Ar1t6x6SyhmgKPP26kkKwd3NC4nV8msWNeU4nMzjMiKzaxKQ
         otJNUcJGDsUsu0WekLxrOhD9k7STzqZazDFZnTTu9lBmoF58oaxUB+iDFyKkV3fJrmXC
         bW0KuoYDzkH2hSthlRQpqnDjIoGEaw6ZFDl2z7CKlgQHAsFy91/z/wiRhYIl50U9pOZn
         PHiw==
X-Forwarded-Encrypted: i=1; AJvYcCUQ3cvJPmxun9SEWpV0JJJjykNT2VFFSoIjeGETjKmsRQXh637Cr/girEEd5AbTPirL2KJmLfVfDbVkwHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb3JaxCbElGRsH4R793e0vSvqerr6joF+ZbwXN3K0a2INB4r9Q
	jf0kdH0lyJnHqgVO2LKP8WfNxJ0Gcdps3+bLGIlq6SwHKplxfxqWDgkjxV+fr4B+VD35LCYRula
	J7jMlkB882r2fjf3HPwijViEYFRNABfOAGPpeKJrwEW0nEujNp7PbQiuNd2bMSA==
X-Received: by 2002:a05:6000:796:b0:382:372a:5722 with SMTP id ffacd0b85a97d-38254b0e452mr4473330f8f.37.1732177954719;
        Thu, 21 Nov 2024 00:32:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyAxoVi5AJMaLr3M68ylpafmrXYb/zD7xYmNLoDBfil0ANpkK0cFGXI6Zn2wRYRaXjZESpdw==
X-Received: by 2002:a05:6000:796:b0:382:372a:5722 with SMTP id ffacd0b85a97d-38254b0e452mr4473317f8f.37.1732177954372;
        Thu, 21 Nov 2024 00:32:34 -0800 (PST)
Received: from [192.168.88.24] (146-241-6-75.dyn.eolo.it. [146.241.6.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382549107b1sm4256414f8f.49.2024.11.21.00.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 00:32:33 -0800 (PST)
Message-ID: <82730046-d2cd-4766-b53b-ba40cb6f1bb2@redhat.com>
Date: Thu, 21 Nov 2024 09:32:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phylink: Separating two unrelated definitions for
 improving code readability
To: Cong Yi <yicong.srfy@foxmail.com>, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Cong Yi <yicong@kylinos.cn>
References: <tencent_9E44A7B2F489B91A12A11C2639C5A4B9F40A@qq.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <tencent_9E44A7B2F489B91A12A11C2639C5A4B9F40A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/24 07:27, Cong Yi wrote:
> From: Cong Yi <yicong@kylinos.cn>
> 
> After the support of PCS state machine, phylink and pcs two
> unrelated state enum definitions are put together, which brings
> some confusion to code reading.
> 
> This patch defines the two separately.
> 
> Signed-off-by: Cong Yi <yicong@kylinos.cn>

## Form letter - net-next-closed

The merge window for v6.13 has begun and net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Dec 2nd.

RFC patches sent for review only are welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle






