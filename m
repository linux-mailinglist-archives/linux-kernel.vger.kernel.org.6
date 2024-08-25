Return-Path: <linux-kernel+bounces-300337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5945295E289
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 09:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17AB11F21E39
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 07:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED0E61FC4;
	Sun, 25 Aug 2024 07:57:51 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7492BB1C
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 07:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724572671; cv=none; b=Cl8ZeGgWV2vX+fhn2+gnamEWnt64CABipfi9Olr55ykruRuOCJyRd6xIW4CRDhza8kGcvY3WFFEEF/ORHuy/m/qw7gh8cvHZjAYzObRGA5tb4eheIFwUdJBZtkIdvWG9zaPQjWKqKtRyr83DZ84jXMQdLV8cVICxlHLcC1wZaCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724572671; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mLBCCgp44VP5oL+BTnYlkC5jT3oCphteAcD50/oBD8O2zDTS+PNovL27ERERpTc2lxj4lXY+taagqmqK5VKi/IkNi7cei+7yiCzZn2RxhFdijrIVzH7prI//jOoH0ZZgmqJzgAUS2KO1r+c3fsHPvBVqtI/BsDjYvGtpU+Zl8gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-428e1915e18so26634735e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 00:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724572668; x=1725177468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=RsguE1KjKwuFQqFfApZoWL+NS6J75pbqMkC9qxCO/nCFKYUZQUerv79phSVsdOgFei
         d/dh6NMmFYV5WafPAb8UikdzyIhXXfIlqnWR9pBmVqX7NxaiKpCAzKLwLa6SEBMWqPBA
         bBMLyIg0JmNKq9o4YQQCy1zxD0KOYyDFEN3QWAq0LAVGpES1qRLuvBq/prkL/4hiIuzM
         WyJOh0ZSsDHMaA1hqNznoppH1enkaCuingsavgwEeTS2Q8SqITo/XnBqdyg6l0HnYojl
         1YU/DktTj6z205iRqp4NvSn5UWvFPryasvTcMNPxZpu4+a+hSErH94yi2LxEzN9F5E1S
         ZZQA==
X-Forwarded-Encrypted: i=1; AJvYcCXSeFKa4+nQnnwAMsXGaYZ5JNYmeXQrJdzTMC4CY+nV/0FcpmAnbiCdAq8xQCmlO6dWfLHqeqL+e9F0zs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK+WKI4R2GCtSShUdL9tiCh8NGBrRlMEkvKX5RExmwqef29ZYF
	qHxjd01YMhO0SwwFCBMb7uzFI/nspp0+21iiOAA0L2fL0iEBPGK5/KiESg==
X-Google-Smtp-Source: AGHT+IFq17EpmluWjsag+gmDhyIK4eSsoiKpB4AM0F31vTSNp10z7/Y7Z6oeTJ2d60ZWn4+Av/9t1A==
X-Received: by 2002:a05:600c:154e:b0:426:5cdf:2674 with SMTP id 5b1f17b1804b1-42acd540c6cmr47928765e9.4.1724572667141;
        Sun, 25 Aug 2024 00:57:47 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730817a2f4sm8109941f8f.61.2024.08.25.00.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 00:57:46 -0700 (PDT)
Message-ID: <46111a0b-eaba-41dc-836c-8a628a4e2ef9@grimberg.me>
Date: Sun, 25 Aug 2024 10:57:45 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/4] nvme-pci: Make driver prefer asynchronous shutdown
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
 <20240822202805.6379-5-stuart.w.hayes@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240822202805.6379-5-stuart.w.hayes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

