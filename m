Return-Path: <linux-kernel+bounces-537408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAF3A48B74
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5175188FA1E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6791323E35F;
	Thu, 27 Feb 2025 22:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GSr5EiiN"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0568823E345
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 22:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740695009; cv=none; b=GQHxQzc42JUR0Hbh4am6QgxbR6ILxRbbfjlPIJGbKCtF1WHXwHXj9Skk+o9uti8LHIi2kFrpxUczx3QCUGep9yzqDw4xwl79S5RobRlO/qAjO0gs/pinrs70tG8VueHHe9UHzILeCpiao5wES+MeCAxIoPaPVL60u6yJkk8TLnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740695009; c=relaxed/simple;
	bh=0YNPSWTQpWa/D7GXeK/2uRq3i3eL4O93TsB5Vt1ZrbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H1iDWbNawIYLDeXBO5ngpOeCjuHa+4uQZ/WYas4wI6u4bYIhTbN47yx/YE75JOIqy966xBCoSPPJHs1RqOXC+6afl1cSAWuYDeBrJQbVPXfgLdt9PBCJgD68Su7UAvNgNmVJjoZNkBZhM0AlFgN69v82KT0eLBvQS8yfHqd0rpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GSr5EiiN; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d2a869d016so4507115ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740695007; x=1741299807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WZGLdBAP4UrHwr4pwKCt5KapJuR+y6gbHDi1DCQWdcY=;
        b=GSr5EiiNc3IGIsq3xZaFvkHePID4hJpiDago/iR6MeyJvY+CnPwDhksatyKDzQiaVj
         +KtedjqXogUOS0ascY4nL/RBd/1yscrGPVrlbxZ36OEt/kHMannHfGFFexjVfHGBUw4e
         uPLYDqgNKNyppEzSuc1bKjCH7e0VKeyA2gupc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740695007; x=1741299807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WZGLdBAP4UrHwr4pwKCt5KapJuR+y6gbHDi1DCQWdcY=;
        b=piQ183lEbp/pSwzMkCjM6SzaMKJc4lUhzde9KJFuH9JncsE/FJrIUtFXnSyXGJx7hE
         ds9iR8caC3zNwRWxMcBu+BDEEMJvra5dAGqFB9uZsqplY21LIMulzeLHggqGp8gNgRKC
         PiAuRQBgcN9qdrneNF90wr0HYbjI9fmETxJ/Sm+BudL2FsidvKIWB9L14+Bd04GDU99T
         ohzAo1MYNoGtolMmdBj9ZKkwyrxwWgELX4nvE85Ik1lQFvjqQbhczP6Ae9GpevvZYBip
         ei1jXZsB4z+xnoj5gXrJxKW8NJfAQSAwzxfLValTpRfeU7OHdhJK+KhEczMjStHJjP2b
         V6fA==
X-Forwarded-Encrypted: i=1; AJvYcCXk5qRVNFBBm/Rvoxum95HlXshbf3AFeaINDdoeW3cf9i5PFfIT6iuEHG4AXgeXCoUhWcY1W7hYvsarh1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylvmoguml1R9XAqXsw84E8LZxaA9pFPxgju8wXQ1PEKrv1Vqpi
	e4/8O5Ka0wiyhBt43CaN1cIRoahk/VYQzOUMblOuHkUAiIdse55Yk4YO4woZu4s=
X-Gm-Gg: ASbGncsKGWDjZMKamQMkOIHMcOTYQetOcuY4eFDttTkD9xjGE1SFqIQObByxqYq3wEL
	tkilGl+FSfxcq7YXq7KUlvMB0YnVjNTkp3VN1ES1YSxxD7tuDdBQ9XnXdR+4dDpA/Arp7WZhPrs
	uCDl38OYRxM3PiyXVGpoHhiJv1cDTAm4iQgRFx4ePg4U+TH2t98TbPHZMViBnzVfopXbO6OVglA
	5wimvr5G8E/C/BijrwdDj/x5cVpLelVspT1XimHOUKvfArX+eUpzi9xrM/wvrCcWHbgMcleitMn
	gYJ04ZPy8k8TZNF8dAUftZMoVPbhBAFgjrQj
X-Google-Smtp-Source: AGHT+IEKZr3NGXPy1Tv5y66C8yGg4ClACZyJG7v4CYzLbHYBMX19ZoriO50XGMis7tUv/ZwDiVzyTQ==
X-Received: by 2002:a05:6e02:184a:b0:3d3:dd32:73d5 with SMTP id e9e14a558f8ab-3d3e6e23403mr11186115ab.4.1740695006941;
        Thu, 27 Feb 2025 14:23:26 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d3deee5d4fsm5165025ab.62.2025.02.27.14.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 14:23:26 -0800 (PST)
Message-ID: <247c7e15-bbff-427f-8315-ca463f8b933b@linuxfoundation.org>
Date: Thu, 27 Feb 2025 15:23:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usbip: Fix the error limitation on max_hw_sectors for
 usbip device
To: Zongmin Zhou <min_halo@163.com>
Cc: valentina.manea.m@gmail.com, shuah@kernel.org, i@zenithal.me,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zongmin Zhou <zhouzongmin@kylinos.cn>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250219092555.112631-1-min_halo@163.com>
 <88b2fb4b-96a4-4d29-bf92-4064d3572fa4@linuxfoundation.org>
 <5a41d6c3.8c78.195371996e0.Coremail.min_halo@163.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <5a41d6c3.8c78.195371996e0.Coremail.min_halo@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/24/25 01:36, Zongmin Zhou wrote:
> Dear Shuah,
> 
> 
> Yes，the usbip server get the real USB controller message send to usbip client vhci-hcd，
> 
> must have to changethe API between the kernel and user-space.
> 
> The easiest way is to simply set vhci-hcd dma mask to 64 by default,
> 
> but not all USB controllers support 64bit，That doesn't look good？

This is an expetnsive change to fix the problem. In addition this change
is unnecessary for non-storage devices where USB over IP is used.
You mentioned this happens only in swiotlb cases? Can you explain the
configuration on host and client side.

I would like to explore fixes that are simpler than what is proposed
in this patch.

thanks,
-- Shuah

