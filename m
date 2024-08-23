Return-Path: <linux-kernel+bounces-299124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FD095D069
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01BD2B224A2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122EC1885A1;
	Fri, 23 Aug 2024 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="JresqEmc"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1AC18859A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724424689; cv=none; b=jSADEG7mZA4sOkvUaoKJfNiWbOrVLznWwZ0nxAd7DQIU7NsAcJeTb7B06ZpApo1Qy3rdEzyXpvoskQJWzYvamQNpWEakVyKe7YapxrxpIZnF5tdXwPHN/rbzyKQH0A3X/+MBCrKuk6RbSRAS2yaQf0F2QwhW/WujaMlczNcjTdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724424689; c=relaxed/simple;
	bh=b4C+Oy37DV2Kzj7Jrf0dTC698njLjd23JNwPJG1/FcU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fW4vSJBoZF3LDkREASkopishJAtAl0pxojYiDsNKQcwkdtoZpnS4b6PyLcmh8KkTUO6V71/BByUFvgFX+0dF38V2gM7od2JEG/CGyOmQFMnywqqLfhI1eR6Y5Kfo9iNthHyBR3sYjYY9C1/bRHtHW10vPOgzzu1Rq4iSQbyp0rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com; spf=pass smtp.mailfrom=digitalocean.com; dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b=JresqEmc; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digitalocean.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e116a5c3922so2027656276.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 07:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1724424687; x=1725029487; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b4C+Oy37DV2Kzj7Jrf0dTC698njLjd23JNwPJG1/FcU=;
        b=JresqEmchm4QsXu/uyAZnt1107TGahPZDwlpVIfE/KV+eifVwEf5tOJ+0/Fm90ncEx
         vpbFABNXjFN0A2sRpDkqymTkGccw7Cs7f9ai34NBnaJXtC6n1uHjT9vdoHFIcEkpGVJV
         CnUsjWycyOffaA+2uhL0NAvA8nhO3aUrncIpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724424687; x=1725029487;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4C+Oy37DV2Kzj7Jrf0dTC698njLjd23JNwPJG1/FcU=;
        b=tUN6JwCamS8Xz9kV+kcRbliMyxvrhTaqpvLBKclFQwd8pY95KPPuT5NpEy3OFCVc6M
         hL/CaaVVY8/1tk5rP1nwcYX6cu5b25bavSBFyHNxJimuZxcNrua6jiEm+0L3rJ5WdCc/
         I1Pg5GaxsvayXa5DYBKuFXMjg3XgzSxvRb5z6/JIQ6EU919XBXOvHoASRiQV7WZXFiR6
         NgJIzcnrxNy0OMXQQIjlAU81/eeMmEpZB7H2VN0b9+POEcp+anOGAe9qRBBkcDSbUsOa
         1W1+DjgLXviZqO/BrAxwYRs+ExPN6B+f2oL3ZkE3bExsikp+/QzBCbA1yIUj6fpEPhXz
         uR1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWjuS47HfPywKr7F02kYYnwL0nZC8YhzzqxlxY5wLFd360ozx6O7DSIYyWIPY0ZYiUGk3k9NRFMZQFsWJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwctcioGeXIpkt+1PEqClcDoLu7h2PIyTmN5lXgds8ad4uwrUl/
	wSnh4kokM2UaXnsNlZGWNUPeIGV4KL/Aqq/f+wHbZNHyuFHDJA/QHo3vudRw6mA=
X-Google-Smtp-Source: AGHT+IG6JLoQwXGBZb5kz/05HTW1+oRlGRg0Y8dCBjJ8Cxj2vuoaOWbYxxL+QDFhLPXt07y77oLlWw==
X-Received: by 2002:a05:6902:1109:b0:e16:6b7e:94b5 with SMTP id 3f1490d57ef6-e17a86a517emr3398358276.48.1724424686570;
        Fri, 23 Aug 2024 07:51:26 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:45f:f211:3a7c:9377? ([2603:8080:7400:36da:45f:f211:3a7c:9377])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e178e46361csm707782276.19.2024.08.23.07.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 07:51:26 -0700 (PDT)
Message-ID: <e7ba91a7-2ba6-4532-a59a-03c2023309c6@digitalocean.com>
Date: Fri, 23 Aug 2024 09:51:24 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] vDPA: Trying to make sense of config data
From: Carlos Bilbao <cbilbao@digitalocean.com>
To: virtualization@lists.linux-foundation.org, mst@redhat.com,
 jasowang@redhat.com
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <4f4572c8-1d8c-4ec6-96a1-fb74848475af@digitalocean.com>
Content-Language: en-US
In-Reply-To: <4f4572c8-1d8c-4ec6-96a1-fb74848475af@digitalocean.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello again, 

Answering my own question:

https://elixir.bootlin.com/linux/v6.10.2/source/include/uapi/linux/virtio_net.h#L92

Thanks, Carlos

On 8/22/24 1:21 PM, Carlos Bilbao wrote:
> Hello folks,
>
> I'm using the code below to retrieve configuration data for my vDPA file
> via ioctl. I get as output:
>
> Configuration data (24 bytes):
> 5a c3 5f 68 48 a9 01 00 08 00 dc 05 00 00 00 00
> 00 00 00 00 00 00 00 00
> ASCII representation:
> Z._hH...................
>
> Could a good Samaritan point me in the right direction for the docs I need
> to understand these values and convert them to a human-readable format?
> hank you in advance!
>
> Regards,
> Carlos
>
> ---
>
> void check_config(int fd) {
>
>     uint32_t size;
>     struct vhost_vdpa_config *config;
>     uint8_t *buf;
>
>     if (ioctl(fd, VHOST_VDPA_GET_CONFIG_SIZE, &size) < 0) {
>         perror("ioctl failed");
>         return;
>     }
>
>     config = malloc(sizeof(struct vhost_vdpa_config) + size);
>     if (!config) {
>         perror("malloc failed");
>         return;
>     }
>
>     memset(config, 0, sizeof(struct vhost_vdpa_config) + size);
>     config->len = size;
>     config->off = 0;
>
>     buf = config->buf;
>
>     if (ioctl(fd, VHOST_VDPA_GET_CONFIG, config) < 0) {
>         perror("ioctl failed");
>     } else {
>         printf("Configuration data (%u bytes):\n", size);
>
>         /* Print the data in a human-readable format */
>         for (unsigned int i = 0; i < size; i++) {
>             if (i % 16 == 0 && i != 0) printf("\n");
>             printf("%02x ", buf[i]);
>         }
>         printf("\n");
>
>         printf("ASCII representation:\n");
>         for (unsigned int i = 0; i < size; i++) {
>             if (buf[i] >= 32 && buf[i] <= 126) {
>                 printf("%c", buf[i]);
>             } else {
>                 printf(".");
>             }
>         }
>         printf("\n");
>     }
>
>     free(config);
> }

