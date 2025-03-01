Return-Path: <linux-kernel+bounces-540142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDA4A4AE57
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 00:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25AF47A8AE3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 23:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8AA1EA7C9;
	Sat,  1 Mar 2025 23:16:13 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E651D7982;
	Sat,  1 Mar 2025 23:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740870973; cv=none; b=cRCMcRUFMTsLg937f2soi9rBx/nwAj+SFaEvjeJt/9IutKJTQ6D29i5wWma8o2GbkY3sB+hlYuFqyGQSh2oYdGZYae1CmAcRKEA+30gRYOY49gusj3Yba9evadFHyCYx/wr+8YwTR5F2Rv/UYC5K0r5auwuTXrE8xphBeCBRESk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740870973; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e7PThw5pmu/hcz/EamG3w77TXcZL+WR3Owy3gpcq2iYwDD8z8wGHVhNJbI0mN7Ao7BOiPHZgex2T3njMbvtXc2Oh2atgSHmFvV2kgjZCnoYznX6yKGvv6wrTqjkPEXPjNzVDQ/ti1Kot71Y9VYnMZ115y3wTJHQ/ih3mlV0dWME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-390e3b3d3f4so1552464f8f.2;
        Sat, 01 Mar 2025 15:16:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740870968; x=1741475768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=FzUSJ2xu6pUSmUF0zAFFDG74KhvMoJEJR4X/h/5D5GdaCmOOBAJN3TAzlJOQobLMdU
         xV2cRxWYqkC56j9q7/zgEv3fp+dhhRey/IMZ/vfBONVgiYnjJfQJ/owEx64CBXLWrUTM
         N2C++sz/OaYX9tR+PVSUiF7WWSdr2MvLyZQhx4LUnimV3zSMtQLa6Go8XWbYFr3x+fc3
         YsAi9hMxCXtDUrWGvEIpMwUritnrpB5pWO4R+74K/r4TNeNz3/t/EkaOYflvTfUbfg5r
         w4M+Vj+dXIpJvUs2xgq9t/94tkzxA5KFOY3Ggda2G9HQTBbSk1x6wUyBgQB2d5uR5nu9
         rs0g==
X-Forwarded-Encrypted: i=1; AJvYcCWRw2HecGows7BpKk6dZdVyFJvo4tu6RdBJkHYriTIgSLMO1UWp+nAaoa5pJSBpkkaaFu1mThp6h97jQN2taF0=@vger.kernel.org, AJvYcCXPmV0Unxgs33OVqwTWuOsXrJaIFAtpU7w/OG2yP4nO+JrD7/020K8EMziUd42fOiExLw6WuTQ0VlVtjfX3@vger.kernel.org
X-Gm-Message-State: AOJu0YxxyOS+70M9SfuefSlVR9wQYhp+zzHid8ZmlMnP6/iCzadCm/z7
	+k9awMyZq0ATwATYoHZK8AcZiXuHnqjeuCl+MpPJIRgdMFdxNLY9
X-Gm-Gg: ASbGncuyUz9RLjlDW+W2KOhPEeUDYreotN868JWTtpEQcmWoORJ/1bRV+g3DCf2Y9GU
	N/pX+i79qebscmP788RvgzEmbL8SOoVrsN9k37TE9EDQ9nJh+d9rK3oxva/k8zgiuYGd+NZxgTg
	6HEhDmNj8am52m3FCOfv41lPzjSxyNzi5qZuQH1B+D9RrHL9eXQ7Nln5WI8g2nJqYkSMxlYD5cl
	0fKZC9HwI2Sc6SsrHMNtMz5EpR/nleLqtgRJni4uEBt/RIwYb6f0EvCUHQ+dyTdUn6oB9DC/ad7
	D15toy33d6IbSkxxm6vPkxkNS94FFGyYmK3YAJhTwQjyrSonwlBO1nNh4ALs30ACFhij/IVZheN
	XC7G3
X-Google-Smtp-Source: AGHT+IHPLd9+jiab01w985BywzrEuE99VxuwkdCg02g97bwTjyXFL7H2etMm7iPNU0L9KED/95Jb5g==
X-Received: by 2002:a5d:64a6:0:b0:390:e48a:3869 with SMTP id ffacd0b85a97d-390ec7c8e54mr8198941f8f.11.1740870967855;
        Sat, 01 Mar 2025 15:16:07 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47965e8sm9428853f8f.1.2025.03.01.15.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Mar 2025 15:16:07 -0800 (PST)
Message-ID: <ddc3b589-909e-43ea-a02b-7d0b26d730ec@grimberg.me>
Date: Sun, 2 Mar 2025 01:16:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: fix signedness bug in
 nvme_tcp_init_connection()
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <0f3be9ff-81a1-4c33-8960-75de2c239ae0@stanley.mountain>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <0f3be9ff-81a1-4c33-8960-75de2c239ae0@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

