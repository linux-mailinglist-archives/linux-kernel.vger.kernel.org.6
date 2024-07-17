Return-Path: <linux-kernel+bounces-255650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 222AD934335
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F781C21416
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042B01849D6;
	Wed, 17 Jul 2024 20:28:58 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D241EA71
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721248137; cv=none; b=XDEgRmy91lUVi2fac2RMq8YjDftRsYW1Jb2MMy2kcA3h0in6KtEq9cPoO+veb7nU+e8jD4g1mKKk36oODdm+9zHbucOYH8yaxksbIrIYWrrBGJf5xhr7KZwFvzIXkn5l77x4NCjuhFglcCNpWabBMUbKiIbxRAPh6k4RRVq0aYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721248137; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aiW5nxlK6kg8BLUi8CqShJ5e9yp0aMbIOJYcGFHb71fS1d1AxJxB1nwUOXhWzn7LSRF6l7jfr4pAyrEZ28QY2NLO8Sg1HTqykCd4q9uBPrkHDDTk0g/RnblCPPpXGAehMWIc9qe9C1ZbwuJnRvEsZ/KWIBr/pQvevuN3d4TQy24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-426719e2efeso84115e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 13:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721248134; x=1721852934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Jq/6rKLNf+oZDvaeVdNGtNwNJk0QZF3jfMHNq29tsL273ZYE54STxgG2eDqZuI4M4i
         Jsdr5fzpWbPnRShUO37yejVoRTx+Z8PYbc5Ryhlo5PFlh7VLnEF8ul+kt82VfrfX1M3Y
         w1bg8WfhY2qsdwuJEaxevnl2KPqVAO5ci2Q8U89ep5RBN/VbmS6EVP+/4ytXnR847Ajc
         OC/vk3S9daW0IHeu0Ql3kKiOh+rL6v0WQ9D0+zI+N/6LH1hbMajEu21Q3P93UdU3DAeX
         r4aEEInTjyG2V0VfaaFZtElYsXxG7a+wNpATtL49i/qFhe8X1nqUpoSWuNtFCLe5g1pz
         aEjA==
X-Forwarded-Encrypted: i=1; AJvYcCV3nPXVWXBcAMpvahLcIpVeGL2NhPt23gIQDlbT84o39TCjyu0rhzhECbj5tJ52ZA1Bq7gb9ian5//jwFuWPwu3enZyzT+cmtTmJeGd
X-Gm-Message-State: AOJu0Yx6nxdOSV97P/vVKbtzuTED0YMw8MO6AZ5nXaE4LN/cbhRwbztz
	g+VU1hBcjH4gyCaITVBkR60nbYrmvzqbqsNPL8j0qQ3u0NGTILDQ
X-Google-Smtp-Source: AGHT+IFWDhgmW7Ns8Om9AVWutcqBouODovMIo7AGCd620iDuN7sKdZfHknUMPMGnS9hOBYqJWypgUA==
X-Received: by 2002:a05:600c:46cd:b0:427:9f6f:9bff with SMTP id 5b1f17b1804b1-427c2d33f06mr12930155e9.5.1721248134146;
        Wed, 17 Jul 2024 13:28:54 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c7865f51sm9231345e9.48.2024.07.17.13.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 13:28:53 -0700 (PDT)
Message-ID: <3fe80e4f-6a6d-4347-b35c-ba3ad378f701@grimberg.me>
Date: Wed, 17 Jul 2024 23:28:51 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] nvmet-tcp: add unbound_wq support for nvmet-tcp
To: Ping Gan <jacky_gam_2001@163.com>, hare@suse.de, hch@lst.de,
 kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com
References: <20240717091451.111158-1-jacky_gam_2001@163.com>
 <20240717091451.111158-2-jacky_gam_2001@163.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240717091451.111158-2-jacky_gam_2001@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

