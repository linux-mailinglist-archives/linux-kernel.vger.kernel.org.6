Return-Path: <linux-kernel+bounces-322591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5970972B49
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54124283534
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FD1181317;
	Tue, 10 Sep 2024 07:56:08 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09AE142911
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954968; cv=none; b=XDVag/JuthHfqTizPCQwLLjZ7ZObES0pl+EFQ5PnRMxE78sq9R8oAUrsV/CB+sfmVadrNtYNXkeBY1nNL/7pHftMWH1W1pojhmUTRXYnJt+ezy7+fB6fn4nmT54Ua7fquhKPidPhvFWiv3CQ8p530q8L0KllqwYzQ+VKtSwXlM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954968; c=relaxed/simple;
	bh=la2z/wjfMXM2WYkkigYM27fYHEw+QKZ7VYl07D5xlhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQfde+zb+P1ZBYW4jHLpOZD9VfLedFfo3mDNS86Irj7nH9WDsBF3A+dsWdSquiI20Skwxo5attWQovnLkOJ2gRHW1iVDd/+a2rzKqhegFVTxZTiJnGQ8OhaUucaoNPZs9eZUUCQHrRTTLNBVpLcK11Vt5dtED8jQxtxY/wQs0ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cb806623eso3837125e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 00:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725954965; x=1726559765;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=la2z/wjfMXM2WYkkigYM27fYHEw+QKZ7VYl07D5xlhg=;
        b=r5RO1VQxVFQtFUytAR76zXlakkLvGHSBSvLKZeFXYJrU4SLvBBnMqNgXi1YGbEVME3
         mF2+AjyQim1oHVlYDWYTTaCnyTMaXSFLwchbQ21H0KJYWYaNGbRCYOHL5rNEmtyv/NoN
         3fDlVpXx+hNtzO/HaX3ES4K/HhoQVPFK3DMUg/4BHEu62oxPv2W82wpwQdfPt1CRbMX0
         8P4AAEg/jpZwcD0ynsP3MSNijzEg6OBFOs3KEiTifxNOiyD8+m15l7TJXQSQBMqstDhd
         WvR06FLomhHry6pipVaM/rC+X6fTM0N/HKlilO7UI0A81mgH0tY4zBMOnUvWZePMHf/A
         qzdA==
X-Forwarded-Encrypted: i=1; AJvYcCUlIcipiDIUu2IvTwrc8vloJ2BYdZtaZrLcQQ1NJHY7hlNCiYvFQkub0bvWamSbtrhwuOSZHBCS5cwRTt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvGU0AKMn0hZCKmfLHrfzIB/OXfH16Rt42DHpvTdwRYNeHvsTa
	NoRKPTMtBnrEGPu3uEQb6bfSkMQt+pGYKFe2ypFY9gejwmDprsE8
X-Google-Smtp-Source: AGHT+IHbEmNZzv0aLRT0PXSHoj9J6ezBLXmNy4Jtz1i5tAWzTzynS4g1nhl6g4KPQ96hnqe0DHGL0A==
X-Received: by 2002:a05:600c:1c8f:b0:42c:b309:8d18 with SMTP id 5b1f17b1804b1-42cb3098ee0mr51445405e9.19.1725954964324;
        Tue, 10 Sep 2024 00:56:04 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb32678sm101881705e9.16.2024.09.10.00.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 00:56:03 -0700 (PDT)
Message-ID: <ca3ec565-4967-4e1e-929b-db4219e3e98c@grimberg.me>
Date: Tue, 10 Sep 2024 10:56:01 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: fix link failure for TCP auth
To: Arnd Bergmann <arnd@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240909202118.811697-1-arnd@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240909202118.811697-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Looks good to me,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

