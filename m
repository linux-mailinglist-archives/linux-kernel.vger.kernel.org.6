Return-Path: <linux-kernel+bounces-535963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B44B7A479D1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7490E1891A89
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A31B228CB0;
	Thu, 27 Feb 2025 10:10:59 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6673227E9F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740651059; cv=none; b=WUbTtbBrbhxiqon2S4qM1CeOc5w2sLEt+T8Ah4ZDewoJDFuZyCL7al2SDW9ox4y7MKp72Sf1Zzmxze2GXAM/QJAHVwNoiFLDb+7LbekeuBsBBzcguB9YYuS3ajjzK8A0mecOY7pFXdvK+dGAZPrk5s1tfWdIOdvpQz7HalMC6zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740651059; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G7X6/BnqxVGTGQtAeZekuDT7U4FHkP7s0EBJ0FlF3XZ0+Uwu7Eefa4eK38ep2FNE1b19V3Ukl8vjt/cyHwmEqrBHb4KhY5e+VKoCx5FSLUEkpWICP3phr+wDrId0z/wMXc97ScDNSa6kobWq4uS7sEn2VYBM+XCe+8A2fvBiyP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4399ee18a57so4835035e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 02:10:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740651056; x=1741255856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=OrqDzRwYMZDxfJL6Uo6w8mIR5lUpNBy5MsCvAnaeXd7Y4Iz07FQk430JogbGzLaz7g
         3Ep9hDjbPg/sF0U6OK6hzHuHIF8vMF1tWs7QJFl53lWHLyZI/3VPpNqm5lKKi4tGBblo
         8n8R3SzWsKNVOvAgP/LMn8Fel85B975hrJaGpvs+g2TGbgu52Afkorm5asgoujj3sbYE
         XuTmpMETZTcjX0iYLuzT4kBtBjFA7fW5G8zkpZo5XZbXztrRnB0MUIUJ8wnLZW0oNp5c
         dRp8IFOHa2Qs2ft6C0NYAMnyu8V8SXvPHh7V63f1a9RdLeX4cTGkXvhJxKgok9Pw7XX8
         I7OA==
X-Gm-Message-State: AOJu0YzkmXS+LEg5JtfBZCGxoJr6M/fY0/xDVqX3gOxTIvjVsVATodab
	ev8WMPjJhwq5HHKAK+BAoxzSgDraBdz0GFL/FHFMWrEAV+uUt43T
X-Gm-Gg: ASbGncvxCnl7UE4Y9I9G998Z9v5Cx1zueKr10ITwrLzGtUf0Bsg/T74afmx+pkjpity
	yVpBy3Pe3Y8wviSSew+veXFcHMJtlQdp9HqyItMqn7xpcn2uxhyfgFoVO3HStQvncn+BG73u8Y7
	hR9yp1bbng+boRVar4GG3JzI8X4DjkYBLofPkTt7cJ0HeKSaThFxSokw5YRf+srvDwDR7+WSxnV
	YfqX6eSNXJXpCMFVvJ8ms9r3JBgdE26RabrJM5jukfe3RP2monGnHlUvAo7Pb/guwCB9JMXc+el
	dlVOOiz9mpuyze2Yd8wQLx0RwW9ZiHVvsVCOHqElsjtos82WFDThB9m3eG7jvH/+1h/+
X-Google-Smtp-Source: AGHT+IETf1ydKJC64LpbkEUtHd/+rj/dNLC+JvQG2PFcKRXO1/PPRN1fU2EB+mSFMbb+gxeNxS4Zqw==
X-Received: by 2002:a05:600c:348f:b0:43b:a41b:ee7a with SMTP id 5b1f17b1804b1-43ba41bf043mr5335215e9.1.1740651055643;
        Thu, 27 Feb 2025 02:10:55 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710b7sm49253495e9.25.2025.02.27.02.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 02:10:55 -0800 (PST)
Message-ID: <98535ea8-2355-41a2-bd2e-2fb4b494fece@grimberg.me>
Date: Thu, 27 Feb 2025 12:10:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: switch to using the crc32c library
To: Eric Biggers <ebiggers@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
References: <20250226062841.60688-1-ebiggers@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250226062841.60688-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

