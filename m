Return-Path: <linux-kernel+bounces-235142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC61491D0AF
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 10:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F591C20B4E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 08:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F57712CD96;
	Sun, 30 Jun 2024 08:59:01 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A7712C48B
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 08:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719737941; cv=none; b=SfOQ3ySHQgzNYYhpef7/3H6hV7gwbIDcbb2jOc5HyoF4c11qnwJW2WLsoL1NI2uTtWexbbScFKMw6zqI4DPcq+vSGPXtnW0RK93V/4w0wtpDqaHTwsalBF2l7kqMfBp1a2XVZAcep9PNiNZgbxey41y97Enqv5TfyLGgsWoVqKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719737941; c=relaxed/simple;
	bh=Vu0xPU7YvANQvoF5JV0ltf4MRq5rP4MWjiT29tyW7Ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tni1vm5KOGd4YyRmtpJbfn3tyQx5Ie1OQ+QQuX43PGoiHJ8X4lCr+N6LTUr3kwTdfc5wfooWj0UU+/rA1GwztaStwYxjt1m1bgqscPcjj7gH/wUPnkqzjzqToytB0yxIYrK/wuXlnjuonAtpCuqURfEPtRvD6gw0o74Wl+XtTy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42110872bf9so2454565e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 01:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719737938; x=1720342738;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E81u6EdEvG55UDl4LbxoEBMbepuHWzs/Ve/isPi70fs=;
        b=ECHQCuVi8FbTh87cpWkmRLtc0z852gyUkf/+Hsn9KrLonnu5xykq2MYN5BZFS7rRHh
         QjAmZTBQL0gC4yTLNKu9A9h4YvnHDldB45HiycVcSbn4TArLEyY2nXQY72dLemODJ4/k
         56hdSzg52cgo960c3w+eQmb6MHtSZsR+X07mFcffttJvtWnfo3eQ4ukgqWnWiUxIdaqI
         hK+sE8PRDCM8WyMgwoNMrOPsrZEY44B0xz6ukegmEP+jtADLOyAU66zqInRYT4lj2yY8
         pTimpUIiHlVbMn/ud0q7n+b3ny2MUV6LqenoFHZpiU1lhrDhudQe9nBI6r43OKRqF/0j
         iJaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8Dq112uzK0rN+jeWzT9vYDecbSniHLyM7sHOGaz6ZlzI2pf3W/XUaENKgKwOQw0mi1pkAqYF8TD8GzntM4uJI2CgYFMgOLq0yKvij
X-Gm-Message-State: AOJu0YwYVME0wzkatwnR1aXyxINt8/jaluKo1IgB112LfW7DeDmKRO1b
	G/BmTCeCGqrFArQfBG7NQmO28Zh1RKzL8PmDb1cTBRlM4FxCUFpQ
X-Google-Smtp-Source: AGHT+IEGAsRDUvjWOLgC/54rILbb6FRNzUF/Ag71hPxBY+9UOWOGXWoSTFhJ7i9Ps8ADcRPTERUqhw==
X-Received: by 2002:a05:600c:3b05:b0:425:69cb:548b with SMTP id 5b1f17b1804b1-4257a15ac67mr19343605e9.4.1719737937727;
        Sun, 30 Jun 2024 01:58:57 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd56dsm6890447f8f.19.2024.06.30.01.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jun 2024 01:58:56 -0700 (PDT)
Message-ID: <0779b376-38e3-42ef-b32a-a9cfab2749f2@grimberg.me>
Date: Sun, 30 Jun 2024 11:58:55 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nvmet: support polling task for RDMA and TCP
To: Ping Gan <jacky_gam_2001@163.com>, hch@lst.de, kch@nvidia.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com
References: <20240626082823.48326-1-jacky_gam_2001@163.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240626082823.48326-1-jacky_gam_2001@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey Ping Gan,


On 26/06/2024 11:28, Ping Gan wrote:
> When running nvmf on SMP platform, current nvme target's RDMA and
> TCP use kworker to handle IO. But if there is other high workload
> in the system(eg: on kubernetes), the competition between the
> kworker and other workload is very radical. And since the kworker
> is scheduled by OS randomly, it's difficult to control OS resource
> and also tune the performance. If target support to use delicated
> polling task to handle IO, it's useful to control OS resource and
> gain good performance. So it makes sense to add polling task in
> rdma-rdma and rdma-tcp modules.

This is NOT the way to go here.

Both rdma and tcp are driven from workqueue context, which are bound 
workqueues.

So there are two ways to go here:
1. Add generic port cpuset and use that to direct traffic to the 
appropriate set of cores
(i.e. select an appropriate comp_vector for rdma and add an appropriate 
steering rule
for tcp).
2. Add options to rdma/tcp to use UNBOUND workqueues, and allow users to 
control
these UNBOUND workqueues cpumask via sysfs.

(2) will not control interrupts to steer to other workloads cpus, but 
the handlers may
run on a set of dedicated cpus.

(1) is a better solution, but harder to implement.

You also should look into nvmet-fc as well (and nvmet-loop for that matter).

