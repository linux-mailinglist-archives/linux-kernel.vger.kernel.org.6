Return-Path: <linux-kernel+bounces-445306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AE29F1474
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0F8E281169
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F94B1E3DE6;
	Fri, 13 Dec 2024 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JaUVwjLc"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4014718452C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734112649; cv=none; b=AETLI/QrIuKti/5nxgCmT8dxAS2Ix4Fz5bpfv6tT7dPhw5YPkOWfgvW3YSt5340WDPMXehLOwbPHvIKf2uDPKx5to4rEytnl/E4ovrzEZjNWJEF5011aKu77miw/xJZvDns6Tl5XX5ktiQUznW8jyhmiJQW4I888h0/vk8DAkDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734112649; c=relaxed/simple;
	bh=wGx9a+XabHmZFDRAuRV8PgVQitDLKUcZ+lbawg8rKF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L2Hb+uXmsJ/XywHEb9KUBv1do6+2jUYXtDYIHzjjp10OztQq6JHBMFYPGMyuB3gzbgwKtpzclNtuxlaYF0lIgKKnpBdmS+I+ftzaMqgVPDeUO1BtmlKvIKOs0DSxHBvwSJ5Ct++m4CoNOPG66PstqthfVFi0wdx8uIvO01cUTr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JaUVwjLc; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-844cd85f5ebso166269239f.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734112646; x=1734717446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NJ0MdihJSIQEq733ivWrCooxpbpOeLDD6hkL86wZ/mM=;
        b=JaUVwjLcph4eElxsvQg1rKpAfSdICB6lymIa6HnKFmXIhLnm7b09lnoLsNQlh9WZTi
         /Bl3zk8ezlt391BcLSKbD9gUY4Fwm1ix54rS2ApbMkK/aDrt65aBz2eII5wMjxj4c4+k
         swYe/PivVIafliS+U9CfoM7SQmq5jU5eRcwS12sWMHg04rxRuL3rzCjn73YeorpNCNA+
         4c0gZ8ksz5iCWGDdBLbYmNi+wP6RQ0XNcF1o5BXyOyqZ07SqrAq4hwKxD+TQC0viprv9
         uNBMaDInocysHwSyDC995QgrME2hdPevzPFNvOwt33Q/1fvLEX3F9LRUQDD5fdvQkLyA
         6KOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734112646; x=1734717446;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NJ0MdihJSIQEq733ivWrCooxpbpOeLDD6hkL86wZ/mM=;
        b=TEYLXU6N1ZAR220viX6YImNw8qWOF5wWCfggpO7UV/M6AqBnt7pbOmdbZrkLRFdwxd
         TK6Uqz6Y9Zj8ZlDfzn6J9PwjS8x0kbSee0dZzy5NSjqXJw9vl1i7b53Ot+5EOHJqPMp/
         e3PP2w1PaQ6gtocdN0+VXT6JmSQGe4h1HMbpqzdQzd9p00vgwnu2ch0N+c0S9bJc1Jmc
         aKCtrwOQYx3MqaCn3h5ulADGynVZaQb6nZprfI0XqfbegAYe/DTNve8gFra/9eLYnQT4
         6dSrujkHlMKePcLBS7oT5+lnf3RgtG8muOX4X1xEPVe0kLT+r65glM26Kic0DSUVbUNF
         bs8w==
X-Forwarded-Encrypted: i=1; AJvYcCXT2h4OvtCal8n308WGe33p9qs4lrmQUUjZ90Zf1JECbPXLXidgwmPOlCXljXCbBogVuQ/Gh2OEmY7iRg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLReeXkCvOGWFGEA92yxlgJaRJhtfJF7gpquWCmi7LZsH0eOpL
	YVz8oxIDGRWTyK2zINrJsigkLRRd32JALkHj01B6U0dCwtbASnO/FujAgmRT42QCIdmj5YVC2Dw
	G
X-Gm-Gg: ASbGncuEAK2LCubMciC7OvTZTUhdKNTshDBpUBfOkDYfK2IaIjq1wruZ2y1klJyGQuQ
	cf45LIUU+DhWprA9iIrZI+ZT0u2mXyEk3ox8Rxx8ygMcfp8l4BhmoxsZ+q3212Mbz24ag4t0znT
	fZDLPkyf5irlD/tpmiu+P3RsraGx2Fnn+ExRzJXO976rA+qbzOJcyDJvnfJeyrum0X56wG85/oW
	wzDrFqGtxV7DVoBS6cNSlNXNClsFg7zvceiaIwCgRArQWpEdCaB
X-Google-Smtp-Source: AGHT+IHkwAS8Ej9VSR79Cb1OkN5DFMUGnboRhod3n1OF/JTt+wCsm5amZhwtb9LdbY3/dNNzoCVRQA==
X-Received: by 2002:a05:6602:14c3:b0:83a:b500:3513 with SMTP id ca18e2360f4ac-844e8a9d211mr389912339f.8.1734112646477;
        Fri, 13 Dec 2024 09:57:26 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2d34da311sm1835667173.155.2024.12.13.09.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 09:57:25 -0800 (PST)
Message-ID: <26caf39f-041c-419b-beaf-e75c5870d626@kernel.dk>
Date: Fri, 13 Dec 2024 10:57:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING in get_pat_info
To: chase xd <sl1589472800@gmail.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CADZouDQpNvEd7ntUgOAQpU18PErENx2NsMMm05SXXODik6Vmtw@mail.gmail.com>
 <ca3b85d6-ddbf-48b9-bdf5-7962ef3b46ed@kernel.dk>
 <CADZouDTH=t7WTFgrVyL_vYsJaWF4stjAj5W8NF2qAK0bW2HVHA@mail.gmail.com>
 <2310bb0c-8a8d-4520-a1ab-40a0489312e5@kernel.dk>
 <CADZouDS7MWbFdh69DXeSdzUSt4AhEqN-+gy_PTdUV2pAAYyEjA@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADZouDS7MWbFdh69DXeSdzUSt4AhEqN-+gy_PTdUV2pAAYyEjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/24 10:55 AM, chase xd wrote:
> This should be the right fix on their side? I was just wondering why
> the newest lts5.15 not applied this backport.
> https://lore.kernel.org/all/262aa19c-59fe-420a-aeae-0b1866a3e36b@redhat.com/T/#u

Ah I missed that - yeah not sure, I didn't track that side of things. You'd
have to ping the mm/x86 folks involved there, not really my playground.

-- 
Jens Axboe


