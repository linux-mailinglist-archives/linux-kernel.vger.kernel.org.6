Return-Path: <linux-kernel+bounces-256203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8893C934AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 493E02826EE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFF080633;
	Thu, 18 Jul 2024 09:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b7LiQIbo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCFE2E419
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 09:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721293614; cv=none; b=nv4QJLUnXtJbcnx8dNl0m2Aab0lmpQ24tVQBOXXbej54QyF6FmiEHsU/7Xob2eqc8LtSRQzIfPy9l3fj3vKPFFqd7oJoX9DcNq5R5QpPIXDa7eWMKHAN45ycCmmTqQT+PMZPXzFNPCag6GndOitE+pytBbSojeNNFbPFvQYwiCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721293614; c=relaxed/simple;
	bh=fyyWx8U8VVx1dX3aVlq0lEv6E7jxlmpHFgOb/0d128E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VnC05obncoN9eykRs224KJB0Fue9pkr/YNAqITwy5UjIxS6fRzVRazYNb/1/mcztsPsuHrATdqPQbaWMnsIYb4NWPJ/e0qX+NeyJh5o6JHm/KpFn8qP//h9KjVoFErqHp8iabKKx5wI21lRGDB5ho8UiycJeQrtzp2L9RwKZ99U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b7LiQIbo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721293611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8RCvekDuVMGClEb5Zcx5cpKXF2G/MkF3FsUT2L2fQJc=;
	b=b7LiQIbo5pL7KqfSwrnqwb7O3LZ5wVGrUPt/M+j7vjb4MhRhwczGAloplji1Dp3bBlJOOA
	1jNMsDl0er9KFli7fQS0TI7GI16dD2+osxXTTe4gWue8BwirsBc5Qu6t2Sfl+TrG4SPigU
	KhIs9gSuEwZLyQItoZUPdfCX42es3dQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-Zpgvpz_fOEKKTXDyg0cLYg-1; Thu, 18 Jul 2024 05:06:47 -0400
X-MC-Unique: Zpgvpz_fOEKKTXDyg0cLYg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4265e546ca9so123945e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 02:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721293606; x=1721898406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8RCvekDuVMGClEb5Zcx5cpKXF2G/MkF3FsUT2L2fQJc=;
        b=hpxAXvG0Ed+ckwhP4sGzIYYLiZVbCkTSsRF/P9eOx1EANEjMqwClc7viwz2n9U4YY9
         PfS83ZGGuVicht6jArUwnaArMA94Bm3W6Ssf8KDg0jVgImpDc6JRgDFyWG6G4fZMK6XI
         5O5ByLBHS6h/i5WM+K+yd8tq+CIf3mq+KYhMxX1zUtcmISWJAMw7oxAeajLPAG/Luub9
         BvyO0vylVWXc4eEHv7IJ7PfHydtG3tfWdr9sFoglhQy6ft6a/FzqDn5g+vPuWkl+/IpQ
         mlMiV+Boj5eiEzCanR6lLWLtutrofBvH0Atc7/siFdaa2OgGd5iTQN4Xzp7w9ZALfPvm
         ZVMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW818gMdDNZdk7YyWjLC566YRg8szhE3Ca1U7Z9v1WT3z4LDIl5VDGRFLQ5igjFEUs+Z0ITV8TY3tS/Uc5npG9+n7sIk86BQfB/wd/D
X-Gm-Message-State: AOJu0YwQH6BfYUbgUFGxtfubJ61CR3HkbX2GA/Rw+uIVs3tcIwT5ckBT
	gDnyTwwLCJ5Mze79fg1i65QEJqgzJdsHARG4Jv06gWQOuhM2z1H0Uro+H+INdh1UlkQS3CfbjiJ
	lm43lLD21Sy0KuEC5OL0541f8dUBbxMo3wnzHg3dL6mXFf5pj9WwbZ0SWGrWsHQ==
X-Received: by 2002:a05:600c:4743:b0:427:9f6f:4914 with SMTP id 5b1f17b1804b1-427d2aac236mr1057685e9.6.1721293606351;
        Thu, 18 Jul 2024 02:06:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsT3v4FMriXfs1n3xUxl+Nav2GTdTv3Ty+wMHYrugLpRBpptpKSiqdz3BT6uF6IHT2hyVbHA==
X-Received: by 2002:a05:600c:4743:b0:427:9f6f:4914 with SMTP id 5b1f17b1804b1-427d2aac236mr1057585e9.6.1721293605964;
        Thu, 18 Jul 2024 02:06:45 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b08b:7710:c7b:f018:3ba3:eb24? ([2a0d:3341:b08b:7710:c7b:f018:3ba3:eb24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a3b7aasm3663905e9.6.2024.07.18.02.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 02:06:45 -0700 (PDT)
Message-ID: <eff0af6e-ad83-4935-bf69-8acb42e37380@redhat.com>
Date: Thu, 18 Jul 2024 11:06:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: axienet: Fix coding style issues
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, michal.simek@amd.com, andrew@lunn.ch
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, git@amd.com,
 Appana Durga Kedareswara Rao <appana.durga.rao@xilinx.com>
References: <1721242483-3121341-1-git-send-email-radhey.shyam.pandey@amd.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1721242483-3121341-1-git-send-email-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/17/24 20:54, Radhey Shyam Pandey wrote:
> From: Appana Durga Kedareswara Rao <appana.durga.rao@xilinx.com>
> 
> Replace all occurences of (1<<x) by BIT(x) to get rid of checkpatch.pl
> "CHECK" output "Prefer using the BIT macro".
> 
> It also removes unnecessary ftrace-like logging, add missing blank line
> after declaration and remove unnecessary parentheses around 'ndev->mtu
> <= XAE_JUMBO_MTU' and 'ndev->mtu > XAE_MTU'.
> 
> Signed-off-by: Appana Durga Kedareswara Rao <appana.durga.rao@xilinx.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

## Form letter - net-next-closed

The merge window for v6.11 and therefore net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after July 29th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


