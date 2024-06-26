Return-Path: <linux-kernel+bounces-230285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 695BC917AD4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10F1E1F22ED8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C937616089A;
	Wed, 26 Jun 2024 08:24:06 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CFF13AD33
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719390246; cv=none; b=WmhAG28zLzzTvTLL7DiN0NRqlQFOqU3xVL2Hi03lIU2rwGjy0VeUCiTizKQdWP9h+WUGSK+j5UdOTalMMB/zJ25PJb49JSx5acW0M6oK4qjQ2OeCO4myQ2JQ6gBf8I58xmkxLdLi+JC07p2fTISkAlS+KD/sgSEt9KoGwtZ5blk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719390246; c=relaxed/simple;
	bh=MgU/fsk2o90nv2441UyMkRJGp9lC98Vp+Y0k2mz7HXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ANSR3pLxhLiz7XaNW2Jdnz6Pg+qddDctSQLh/Ex0RUzCfQUjUnLS5NS+6QR7PUg760Z+qM+xYX4aDZpxA3IU5gI1Fy55pj5BYwsoJoTb/+mUi5S6gZ2NBtyjc1DvbCLFG57K5qrXkjUH/CHjDf08+AGVfOZ28xc0b+sZRHQX5wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42111cf2706so8114655e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 01:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719390243; x=1719995043;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MgU/fsk2o90nv2441UyMkRJGp9lC98Vp+Y0k2mz7HXg=;
        b=IjTPzPpWZNjS0vyLcYn1R/9fdjTJ2K8UDM5wjavzaVDry3mUEHR8HtnbIU3FHXschy
         oBneCMa0d32okRncZ27XEtQ3exjpzJ6Rlic2BdxqC/ZULeuzmXwWw/8eWW0nUZeNue/V
         pykL4Lm+4t3E70lakDtRaptCc1lykVTH9/4YaUjKFotpFGsrmvH1SMMGK6eB1SQCABIo
         lLyfq91cDtCYN9lBkGzyAx16/URK1fWdrp9v26alzvF0w189Z6KAfJ2hUq4eG5niIPAv
         JSTbnUPyCvdNiSXVdqFuw4mdoj7BW1GR/QLZluOCeYv59abp+MMAPnjtxEoXCvpPRBBl
         YJBg==
X-Forwarded-Encrypted: i=1; AJvYcCVgq4oAk//Mb2+5QaszW4u6mvHXQ1r1STgcJ8lCqjtJb6bVOkCjoMRZIWKBE5qB+jwn7wSxXH+4NAQKFewh2qFwnmJx5tm1GeOMIZ89
X-Gm-Message-State: AOJu0Yzj3n/JbhTMzRIHxXqMVdnz7ksvsd21uyveNcQQDE2FNzmRAgll
	zVutK2rUrsVlNY8wLx/ISpjDdfG8iWcZ69UMst03CuK3xlF1azuSB+SzWQ==
X-Google-Smtp-Source: AGHT+IHSjUTw3mKKQn9qr6UJDVsF1Ae3yrP/yTdwhV5Mh877uHFja9Cti1FH/pyoM/Toge3XiCDKMw==
X-Received: by 2002:a05:600c:3b8d:b0:421:de31:76 with SMTP id 5b1f17b1804b1-424891aa2a7mr80554065e9.3.1719390242938;
        Wed, 26 Jun 2024 01:24:02 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f6753sm15130117f8f.74.2024.06.26.01.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 01:24:02 -0700 (PDT)
Message-ID: <55079f60-1b3e-4929-b7a9-c5e0d36a03de@grimberg.me>
Date: Wed, 26 Jun 2024 11:24:00 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] nvme-multipath: prepare for "queue-depth" iopolicy
To: John Meneghini <jmeneghi@redhat.com>, kbusch@kernel.org, hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 emilne@redhat.com, jrani@purestorage.com, randyj@purestorage.com,
 chaitanyak@nvidia.com, hare@kernel.org
References: <20240625122605.857462-1-jmeneghi@redhat.com>
 <20240625122605.857462-2-jmeneghi@redhat.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240625122605.857462-2-jmeneghi@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

other than the comment from hch,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

