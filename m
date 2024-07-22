Return-Path: <linux-kernel+bounces-259456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960FE93967E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 00:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FBD2280C2E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 22:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2494776A;
	Mon, 22 Jul 2024 22:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="s0JtGKL6"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF06D1849
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 22:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721686950; cv=none; b=rW2P+RhVZobN8weBfu8ah+BtbyTn+FUrJMMoYpk5x+7iPyZT9VJxJnD6iFnSJWvja8P3cU8I7O9WXjsQAnFrSKtEdKplsjHXmVlS5PGKLLDUaCOsbvl15Ma42FGHh7shRHL/FHBwtQisQq+/kfEAhOPtmYuQ5hdU0TQpTu2JRDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721686950; c=relaxed/simple;
	bh=NBa7JVKjwoFi4L04QvHkRHOK1hCkVZoIydEAQJ8zEFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rEcs/SYQTCaiZ2PYpOdKiZsPmLUgk3wbiinu4tUC5p7i5gcvXJSXwdQvCm6m54GA0fE1+nBUfbr2/4BiuQQAhSeMAHjrFru19uvPRz44YpNPSI7tLsptjru28p4e0Dqxkv3ZCkQG91NWOgnYirpYyIj2PIwdhIs1X44vZ9qo+hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=s0JtGKL6; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-812796ac793so20136339f.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 15:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721686948; x=1722291748; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MnRlInGC8vN1+rV19INQEkwGpgPNaUbausotg6BATNY=;
        b=s0JtGKL6IA1nZBi0d+vZIFFOtEBw68ylf5xA2XaGhvBce/WB0Gd7lEpMvHBBjQXVyh
         YUNzdv+wjdD4eUXbN1JH/ZeDUJMfIotZbQmIPLtAX801dPPJW9Nyc1u+h7QpttvH40oh
         wjH5us74GSsXlFzp4rGAgGTNjOljXoausBIwlGYwebVjBrVFza/GRQvNiBk+ZFl4Wpne
         U3Gmh+zqTJ89eMML6VlImvrsjA4E2V3OKfoY2gZKW5rx4GmHXbPfE+GQJFmUk3cx85TI
         97EHefIFxJ74EX41/aXfXe1Uja+GWsulpKOfZo68VEEZWuy4wxcmzDy1QhAyWfSux38o
         bd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721686948; x=1722291748;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MnRlInGC8vN1+rV19INQEkwGpgPNaUbausotg6BATNY=;
        b=t/ynwZ3drRZ5TNiFlbKRZDDMZ9612cddyKs5gwtQqp3AHkdsa+ueV+hQNkPJXWd6CJ
         NlB4px5wtSYTcHEFw3Ub+ARuhGzDMNjmZVC5mX7QlXmBGnZiYTDJnAi8nbqSRBgx9az6
         fOP536ODdj/GgR4UjDMQyBxmOkLq8Sd392JTVv5RGAYCvhkuJJY/SbOSpcKzHSOA/HEZ
         6Ir2YCRHBF9tZyBsMb+mGBZWHBtoYpVBI8dIuCv6H1eLAPSGPbQDyg977mvBDww7OHGz
         c1LroAW4ux2AuRGfBJUuWs73qMPGizqAv8aO/5XYoMGUBTUIO/jIaCxIBdnsp5/a4hfx
         pEVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVliRYgAiS4gpOyIx25TEialo0zISjdZaL0xMPLl9ajzY6dVZaiPm4111V6E4cTdZTePVzJtoWUmAgIOq1tLnsxzLskKqTL1Rezq+gs
X-Gm-Message-State: AOJu0YxM3F9j/TDawdCo9UItkegpaqgXV3Bq36KqiqeO7LPFLLk5G6No
	FJ0eYxPJgHq1Ner5ey8ZCsEUj4G6yP5r/CGcGfArgGrPxpR+91p+iUFJ1eBvg+A=
X-Google-Smtp-Source: AGHT+IGErpgwGnbRUj/d1zgp5yaU/AfHzH/lzmXBBD0hSLIdu6yCr2Kv+i26Aj/Fex49lV/gUXpopQ==
X-Received: by 2002:a05:6e02:1d9b:b0:38e:cde9:cc86 with SMTP id e9e14a558f8ab-398e725c529mr48241285ab.4.1721686947826;
        Mon, 22 Jul 2024 15:22:27 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d35de3274sm981370b3a.83.2024.07.22.15.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 15:22:27 -0700 (PDT)
Message-ID: <c1b47037-4754-459f-9e8f-ae4debd3fcf2@kernel.dk>
Date: Mon, 22 Jul 2024 16:22:25 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] scsi discard fix
To: Li Feng <fengli@smartx.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Damien Le Moal <dlemoal@kernel.org>
References: <20240718080751.313102-1-fengli@smartx.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240718080751.313102-1-fengli@smartx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/18/24 2:07 AM, Li Feng wrote:
> Hi Jens,
> 
> These two patches have been reviewed but have not been merged into
> linux-next. Can they be merged into 6.11?

They can, but is there some dependency that means they should go
through the block tree? Would seem more logical that Martin picked
them up.

-- 
Jens Axboe



