Return-Path: <linux-kernel+bounces-300338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E66B95E28A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 09:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8E1AB213CF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 07:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B1F6F2F8;
	Sun, 25 Aug 2024 07:58:46 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A2E6F2E0
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 07:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724572726; cv=none; b=Vi5/6Ciw5e/xbSrxOSnCPJB6SjJtHr4Ejpot+k/d+LmCfspqDdlaGp4u2AawU4ddUtIvACGhDgNnq8TCThycKCaWO8Kv/1wmxq/4JSUPEojbRdozuyjNrSatqbGEsYgo43RjS0gHESi36KdsUrWkW0odNzFjX1a8Ynwhl1RZIEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724572726; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Pgx+I/eYgRR6pPdcC+jxcioynYD7U2pu8ORAdCFByB++gBbxdLM9AFT3LmIOJnlRRIWMp5UE7lfUGpVqfgWnSUn5unZLjI88D8EGn0sf8z9bxhUGhl7Q/665zLqayO9jnWInf4wGh+jWxHdarO6RUIYLxNyWdfg+7DyjxaGzaB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42812945633so27945925e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 00:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724572723; x=1725177523;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=evWqe4JE9Evy1bXNVr1Y71RU3kUWZDwSVi8pvbIYk2S3ULinA3AU7UND2I1Ym6QiOW
         zsUfFsCKMxt0JUjsvpngvKZfBAteaI1QQrmXnk74/n39km02dk19Q3BctIHX0pqDK51t
         7yv86cuhjqNdaVYx+kIYjGYc9vhg+l2hVKHHvmu4iS02eB2+9U4Y88DUzIcr2OnaUGqL
         vxOhsSFTP8GVjolowBxYh7BbyPEh06QuBoWirUfcFLMCHWsaGYB130quHVRmS2eEqSDY
         M/cr3UbEeVzz6Yd8JWVy2nh31JNlYPEMyaUD6ShmXzjg9owPFvRZWou6ADJSF/HOJUJw
         qLcA==
X-Forwarded-Encrypted: i=1; AJvYcCVgD0UoBGqfZNCvK9G0wtSw3NmHvHt+OQavBZCZ75LCjsaJtD+rtRW0/jGkRS4sr6VgJD5zP9FSCQiQtys=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMHVNs2YGXigQqCPG7S50TLl8RXl5FAkiVb/yM/h29SGqI6aZa
	Mr0xyfG1uI+QJwiTAaBm9HHVM4aPbt9Q7ufvmBh+QC31+SMmvQn8
X-Google-Smtp-Source: AGHT+IGtTeoBfZT6lbAkZDIeXitt56VKRpyvH5aeH5M3apynubxgt3T7VlOA3zjraj5lgF72ZPXBTQ==
X-Received: by 2002:a05:6000:108b:b0:371:8f32:557e with SMTP id ffacd0b85a97d-373118c883fmr3750921f8f.39.1724572722473;
        Sun, 25 Aug 2024 00:58:42 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730813c465sm8118438f8f.32.2024.08.25.00.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 00:58:42 -0700 (PDT)
Message-ID: <facec642-310d-4b74-a6a0-6b7f929e7465@grimberg.me>
Date: Sun, 25 Aug 2024 10:58:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/4] driver core: shut down devices asynchronously
To: Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Martin Belanger <Martin.Belanger@dell.com>,
 Oliver O'Halloran <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 David Jeffery <djeffery@redhat.com>, Jeremy Allison <jallison@ciq.com>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
 <20240822202805.6379-4-stuart.w.hayes@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240822202805.6379-4-stuart.w.hayes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

