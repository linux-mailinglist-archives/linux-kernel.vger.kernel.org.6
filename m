Return-Path: <linux-kernel+bounces-184790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 084418CAC0E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 12:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39AC1F21775
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8366D1B4;
	Tue, 21 May 2024 10:15:40 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B990A42AB3
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716286540; cv=none; b=NiUnbPnxVIXAAeLrTA2phGutz549EgfsRUb5XJaQqQEHxovOpltMhmBgQd/8LXePIkVgQayeW9yPnuHFAUDV6Qt78k0uOs8i313EK6OcU9uB8DYbi2CB8Cnwgd/Lxf5+9HMKq8LcQKdb/6Sygn9YQbM9V+DdffIR+MAx742Ma3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716286540; c=relaxed/simple;
	bh=441uZjfbDDbYWyVfUP8BlDIxjNcNaPwhAz8pHkqsEdY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IqueFZMgU09EsZg46sF0mo50VuST5B7f/WyPdwNnnfXwKdO+XeXQTjsb16nctPq4jBx4/sVQbqIgDzTWzn/gIc7VUV8GMOak3q0Cw/ONa5o1DvWMAPr7oB6TM6oyo7ra5j+tlN5BzaWqam18cyR7gNxD/qLPAEQBhw8lDSAlyfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-354c28d4e2aso67012f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716286537; x=1716891337;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=02gpweHNfk6o1OCbPBEfCdIF01f37RIcxSIg5M42u9A=;
        b=TXu1+XRINcjiMYEnODQOm2VICBFEieaMjcdmitxn4cQn/lc8FC8KmnTj0F8+dT/lP6
         gs97gSpjJXIVtvKo75WbKlRYY1c4eZ+/a9JJo3QxMm6Zcvpee9WWzLVvIwS9f9EyIfTb
         rSr4ddnI43YiGJ+NbLfd9wRTvbxI3aNSATPJelTz0xfaT4WHPUNDtrSV0+1W2eOTmUrK
         Q34pKc0sBLS/XKaPmJxoD99BgHF5UyutpGyGRH/rOlj0eCuU7TQTTXeMLoLBSn3xPYzF
         5qhJv7i9CdJFsAOILxvkY4w40u9RCukXjyS7DNiy2R/80lulOMctXVuN2TvTCzG+qoJL
         9Q2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+aTzGaGlYHeG1btT5F5YFTPdAnEZ4gIQQZc1zZZtQayDQPAMp0V9WcokJsLHgG9NOOkeCUTJl5VhbOw4/haRl56200p7+LHufkN2l
X-Gm-Message-State: AOJu0YxfzkE6H+qJExHPwzYFTaLb0nbdD9+8vGL2xvbZvdEaXSDCL/CO
	ZyStTS3qoZg5IxPif98jiz+tAS6LFbh970f9urv2jAw1Lb4Miz7Q
X-Google-Smtp-Source: AGHT+IF4BXDJznls9ehBgndP4S1CgsuNMagJiUCcK7yhCwY/0ywrmv1mc2ukP92qRRaDBfRtgnvBig==
X-Received: by 2002:a05:6000:184f:b0:354:c5d5:295b with SMTP id ffacd0b85a97d-354c5d52d27mr4580284f8f.2.1716286536869;
        Tue, 21 May 2024 03:15:36 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-351d2df8449sm15110023f8f.12.2024.05.21.03.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 03:15:35 -0700 (PDT)
Message-ID: <073ae18a-a80e-4a95-a093-36210a3bb230@grimberg.me>
Date: Tue, 21 May 2024 13:15:33 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
From: Sagi Grimberg <sagi@grimberg.me>
To: Nilay Shroff <nilay@linux.ibm.com>, John Meneghini <jmeneghi@redhat.com>,
 kbusch@kernel.org, hch@lst.de, emilne@redhat.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
References: <20240520202045.427110-1-jmeneghi@redhat.com>
 <20240520202045.427110-2-jmeneghi@redhat.com>
 <945416af-3f8b-40b5-9681-49973beb2cb2@linux.ibm.com>
 <3b8d33db-f2c3-469a-bfa0-8fc52594f243@grimberg.me>
 <95fe3168-ec39-4932-b9fc-26484de49191@linux.ibm.com>
 <da35bc8b-6813-42c8-b446-8a07b08db156@grimberg.me>
Content-Language: he-IL, en-US
In-Reply-To: <da35bc8b-6813-42c8-b446-8a07b08db156@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/05/2024 13:11, Sagi Grimberg wrote:
>
>>> Don't think this matters because cancellation only happens when we
>>> teardown the controller anyways...
>>>
>> I think in case if we reset the nvme controller then we don't teardown
>> controller, isn't it? In this case we cancel all pending requests, and
>> later restart the controller.
>
> Exactly, nvme_mpath_init_ctrl resets the counter.

Except you're right, the counter reset needs to move to 
nvme_mpath_init_identify()
or some place that is called on every controller reset.

