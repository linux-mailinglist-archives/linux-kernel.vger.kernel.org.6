Return-Path: <linux-kernel+bounces-297827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E6195BE2C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 20:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29AA1F25D25
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF0F1D0DD5;
	Thu, 22 Aug 2024 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="BjZgmJnz"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EFA1CF2BC
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 18:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724350879; cv=none; b=HMQBVaw9S6Rd9rqH8gn1RemkbPyLR6cmiG8HGUd9DGqanWyXcmKZ7PKAqfjsPLZulq0yESyjsFHUtZ32xx9fAQAUOmelAKAyVrOvEy7iFCoAhNqFkco2kaPxQSbW09znGLz8GhlBJAv82DB57JSgOviXDcKRjT2ZSp98xKBGTw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724350879; c=relaxed/simple;
	bh=RLs+TgOeDB9U+OeJ5ILJJE/1qQupOxoL4NtsHLcUl2s=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=BxSK+ajlaLLb7gKz6ZtPn8fecZ4HgvICvPYlT6isQ2qf+GPPwPrOLAjnF4khQRoc1amnJfTqR/J5XMG7LblKmMN1ChngSN9dGJiMfGp1bo1HQVQIUV3kz37e7MJT0eIcyAi4xK/nmR3kCjO5lY8eqyQjCD7lofwXVD9V++mk8xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com; spf=pass smtp.mailfrom=digitalocean.com; dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b=BjZgmJnz; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digitalocean.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6b3afc6cd01so18402317b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 11:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1724350876; x=1724955676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLs+TgOeDB9U+OeJ5ILJJE/1qQupOxoL4NtsHLcUl2s=;
        b=BjZgmJnzgKmTy9uPpQxTpyyohGj/7FztpcBZoNI+XvVk1sYuQnCNZ/jtDlz8wGECdB
         9yeSLdZWvtkStppTav2cv1269PQ8dvT42o+OUC/zlQ4TruNwNMxgrSlYrFoN7lPeQYwC
         +s0SmlGzwisHwmaEDV62XgPl4hedgsKL5Xaz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724350876; x=1724955676;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RLs+TgOeDB9U+OeJ5ILJJE/1qQupOxoL4NtsHLcUl2s=;
        b=N8CP4JaTbVa/0Qu+4AjUIiK5Ir9zdHNnulZkWuRtoMovYJMheBQbaWGL6tQtEU0ZZ5
         3u7BJUDhHNK9MemPBi60jkn+9AS5xyrNMjcCq77WS/6fMWpQAL7wM86M9HzA+O09hM3Z
         wUw0Vq/8mIXfa1avEI3UxIYaUdIVWDn0UVjHY2S8m0d1JnIITzCEduf7R6lR/OkN5edL
         a5WyRB8Uj4KprY5Z/fZ8IKWlC4CjFTPc9oz5jnxGpJcGsJWzy0u+xvvladiiYJuoeYhB
         Mcge+SKXUTpnussRG4HFcKrmJxUUzYEFj7MOV/hmPMYhK1hdkneXQ/+NthTlckX+Rm3r
         eEsw==
X-Forwarded-Encrypted: i=1; AJvYcCW89khUjFgw16Dh1DBc7ZmHe8jUkeSHLPjkAQN2xcbUSmX8/kpPkvH4ZQNNbekhfFV3e/HHvzI8apiLHno=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrxYP4o9mz84J0RXnyaTknMt9Twce6aye24aBbLEnfVWc4bEKb
	5lGwNex++G7liXLSx408/KiLH8xXdn0ptBksNVMYnhP8macduYaKosw1Ewj8NHc=
X-Google-Smtp-Source: AGHT+IHtXIMIiSwuBpmYLdcwUNBMd26Nuu8pfXN1VwE1UCqgTVayCXIzfx3aHHiMJ03T6ZoVnLerIw==
X-Received: by 2002:a05:690c:6d8c:b0:665:71a4:21ac with SMTP id 00721157ae682-6c303cf699fmr39887947b3.10.1724350876111;
        Thu, 22 Aug 2024 11:21:16 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:45f:f211:3a7c:9377? ([2603:8080:7400:36da:45f:f211:3a7c:9377])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39a7525bdsm2992047b3.31.2024.08.22.11.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 11:21:15 -0700 (PDT)
Message-ID: <4f4572c8-1d8c-4ec6-96a1-fb74848475af@digitalocean.com>
Date: Thu, 22 Aug 2024 13:21:13 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: virtualization@lists.linux-foundation.org, mst@redhat.com,
 jasowang@redhat.com
From: Carlos Bilbao <cbilbao@digitalocean.com>
Subject: [RFC] vDPA: Trying to make sense of config data
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello folks,

I'm using the code below to retrieve configuration data for my vDPA file
via ioctl. I get as output:

Configuration data (24 bytes):
5a c3 5f 68 48 a9 01 00 08 00 dc 05 00 00 00 00
00 00 00 00 00 00 00 00
ASCII representation:
Z._hH...................

Could a good Samaritan point me in the right direction for the docs I need
to understand these values and convert them to a human-readable format?
hank you in advance!

Regards,
Carlos

---

void check_config(int fd) {

    uint32_t size;
    struct vhost_vdpa_config *config;
    uint8_t *buf;

    if (ioctl(fd, VHOST_VDPA_GET_CONFIG_SIZE, &size) < 0) {
        perror("ioctl failed");
        return;
    }

    config = malloc(sizeof(struct vhost_vdpa_config) + size);
    if (!config) {
        perror("malloc failed");
        return;
    }

    memset(config, 0, sizeof(struct vhost_vdpa_config) + size);
    config->len = size;
    config->off = 0;

    buf = config->buf;

    if (ioctl(fd, VHOST_VDPA_GET_CONFIG, config) < 0) {
        perror("ioctl failed");
    } else {
        printf("Configuration data (%u bytes):\n", size);

        /* Print the data in a human-readable format */
        for (unsigned int i = 0; i < size; i++) {
            if (i % 16 == 0 && i != 0) printf("\n");
            printf("%02x ", buf[i]);
        }
        printf("\n");

        printf("ASCII representation:\n");
        for (unsigned int i = 0; i < size; i++) {
            if (buf[i] >= 32 && buf[i] <= 126) {
                printf("%c", buf[i]);
            } else {
                printf(".");
            }
        }
        printf("\n");
    }

    free(config);
}

