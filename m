Return-Path: <linux-kernel+bounces-373463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892559A56F6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 23:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE8B281E66
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4554319883C;
	Sun, 20 Oct 2024 21:25:29 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0110E45025
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 21:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729459528; cv=none; b=MV+I0r0VnbkXSWUCC6a7pe0qL2g39UJ7yMq+VX1zDW0MDXbnXIhPcc4/9qVC7TGYzK8QoKqJnPJmSnNPnqxY6LPXiboWQgAdSCcJxWBx/gEHFdV/iKqQ56/E7MJAUVewkolf3w64YPNscmP2kVXbRcp5S1dzD91ft16moq0S8JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729459528; c=relaxed/simple;
	bh=kFtxmZZNRSShsBtAkbSLJ2rN46/Xm+rm6B8Jq6aaRcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QjnzCQGun2XKti/1d5ESN0RX1hFERjlMqda4lmkfi6RY8WosLeszYAFWwSm0/5g6CfeyY3dmlM0BicD1hgqqhcG+8MZZwaTjoFYiMlbW2yf+cdrYllpdMjmXzVrw1d9Ibftvq1R0DQuYPkH8Lj8R4Tq2xRx94BoZsB7SRDLpcAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4314fa33a35so38467645e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 14:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729459525; x=1730064325;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YBn6K4KZnCY0Yxou4W+FGn+th8k+F+/5VdjO8yXNhFw=;
        b=W7H+UhDe1ofZHo8MvfzPczHA7pFmBdaO5z8eqRpS98b8Z3jvfqyjP0+KGOoIGn+l/J
         He1wrhyw585Dzy5Ly8i/H1noGZgGbRmykQ0mI6v+fxjl/iiLi8jvux29AR6GniKhN2ia
         7G8H0pPG7f+H1IMCwLpdBYQp1hhHKQqX0r0/c3oI10Ti3zfModXBWDmjUa6YzJOdnjMy
         5i26cB3PAUFkLvflA0Rw5A4QbhlttWOjgCQgBWsYEcCTuL2TgyFrDDAhCT7I3c/phjir
         GA1DpfGhCeqcYwyqpeYUi834V5curZsmXzb7e0hBUCvr60UIep8IMJ+sdhfX0R78ByHR
         8pCg==
X-Forwarded-Encrypted: i=1; AJvYcCVxba0rUYlPD4VKjj6/y1uPuXjKCvhMHhBcYmZ26Hb7FRBAKLFxZ2hVUU+j6cuVVIUmldS8yS/cPdnsvss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2u1Mr0qcQ/pqyWegYL/RWZm4o38os3aneIXggNwESa6pYs6Ju
	fofYZT9c71mKlQT1Egbxrix7P3G3/rGq8wcwm22XxSkRs8FlC5mC
X-Google-Smtp-Source: AGHT+IFtrJCzlz0z0djFv72MUW7o9jSkK+ZnXNL/7PGcCRVWu2xSW/e7Nb8Efh4wVBq+302s3jx6JQ==
X-Received: by 2002:a05:600c:1d01:b0:42c:b63e:fe91 with SMTP id 5b1f17b1804b1-4316168f28cmr77354645e9.24.1729459524967;
        Sun, 20 Oct 2024 14:25:24 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f570a97sm34914795e9.9.2024.10.20.14.25.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 14:25:24 -0700 (PDT)
Message-ID: <6905cfbc-2ae2-487f-aebf-e4b944f2dda4@grimberg.me>
Date: Mon, 21 Oct 2024 00:25:21 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-sysfs: display max_hw_sectors_kb without requiring
 namespaces
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Abhishek Bapat <abhishekbapat@google.com>, Jens Axboe <axboe@kernel.dk>,
 Prashant Malani <pmalani@google.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241016213108.549000-1-abhishekbapat@google.com>
 <ZxE-BE4hLVRR2Zcp@kbusch-mbp.dhcp.thefacebook.com>
 <20241018051410.GE19831@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241018051410.GE19831@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 18/10/2024 8:14, Christoph Hellwig wrote:
> On Thu, Oct 17, 2024 at 10:40:36AM -0600, Keith Busch wrote:
>> On Wed, Oct 16, 2024 at 09:31:08PM +0000, Abhishek Bapat wrote:
>>> max_hw_sectors based on DMA optimized limitation") introduced a
>>> limitation on the value of max_hw_sectors_kb, restricting it to 128KiB
>>> (MDTS = 5). This restricion was implemented to mitigate lockups
>>> encountered in high-core count AMD servers.
>> There are other limits that can constrain transfer sizes below the
>> device's MDTS. For example, the driver can only preallocate so much
>> space for DMA and SGL descriptors, so 8MB is the current max transfer
>> sizes the driver can support, and a device's MDTS can be much bigger
>> than that.
> Yes.  Plus the virt boundary for PRPs, and for non-PCIe tranfers
> there's also plenty of other hardware limits due to e.g. the FC HBA
> and the RDMA HCA limit.  There's also been some talk of a new PCIe
> SGL variant with hard limits.
>
> So I agree that exposting limits on I/O would be very useful, but it's
> also kinda non-trivial.

I think the ctrl misc device attributes are fine to expose this and other
types of attributes (like we already do today).

