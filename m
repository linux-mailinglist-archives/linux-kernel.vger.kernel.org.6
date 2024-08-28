Return-Path: <linux-kernel+bounces-304490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 006EA9620DE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD47B286FCB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E955315957E;
	Wed, 28 Aug 2024 07:21:19 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B559B13D248
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724829679; cv=none; b=LOGdVaNG4zw6rxK0LaUEZf/0lJtU97aHJ0qYMUc+x5enQ2fmpuenXuKHRsarPsLyo6wiMhUFv+mMsVSTlwz0CwOkFvhzuD3iUIfsuqxDgA/yCo9csr0P71vYaAoE/OIHYKduih5yyusHnE1j7+UTQYTCWKk8GOamjLFSNX5Z3tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724829679; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gRUF4Gl4JPznFwvqt62GC6EaTjrmakVj4BF7jDe0dP7xP5gM3WPriQ2eDO/RsRzqH7z2IvRCBOza2KdAuiZEs3YMRVc+yiRJx+ODeyT0VLpwNYlPe3u2xqYG1GEiBsFcE+qC0ghn1aScMPfRHdhL+f0idHrdIwQQPjmdP7sROg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4281c164408so54638975e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 00:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724829676; x=1725434476;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=pG5kp0HL60DFORk+A/BQIRArhIWInTGhXYVWE2h2iStDPF2gShTLDMBMLBScDRFekd
         9knIoajws1CFqQMAcVL5YlOjSRqF+UPQ+mDNjvRmX8xncikbrL/ZP2uUlBfWg001UI1R
         WvU2aT2jw2QJomxEs8vnf2o7BmpRo2l7UaCU3oOeuwzyqgU4rGy5aNgKCSLMVRekjPu5
         prNebyjyc0my5cITWBLvzz5MEtsDeYusbl2PzCMaN1Z7EOybTouPjvS2SiKtCCkknweO
         i0fAMEj2pnFDd9cJoylHml1nBMApNWy8R3Pa5J9jw77RAcfCSUtbeScDOnbLgdMW5Mc0
         potQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzLNMnw9dcorm78gbOrXEnKiSzFlYWYz7y5LU+OHX1xQZWr7dC4SI1856XjlxObdgs/df7mJATyJg5ruU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOBAmkWz0dDqT9FoNhs9HUavDR5f/PmbBdF5MNUWjVpcp9igjq
	xYhHwrbIQevr5r7R4/3ZwhRxBnozhpTt/7Yo2Lvx1jYXBsaIiXdw19KQjg==
X-Google-Smtp-Source: AGHT+IEGJZdA3zvixLCvIXaagTRCXYmH0vz055XZp+0Wc/q1JrJ+WLhLLmXFEmrklDgOFEqcyWFzWQ==
X-Received: by 2002:a05:600c:4687:b0:426:5b29:b5c8 with SMTP id 5b1f17b1804b1-42ba66a957amr7106115e9.28.1724829675219;
        Wed, 28 Aug 2024 00:21:15 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba6397ec1sm11779745e9.4.2024.08.28.00.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 00:21:14 -0700 (PDT)
Message-ID: <9e2c5b2d-a582-488e-9afa-31ae6183816e@grimberg.me>
Date: Wed, 28 Aug 2024 10:21:12 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme: check if the namespace supports metadata in
 nvme_map_user_request()
To: Puranjay Mohan <pjy@amazon.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 puranjay@kernel.org
References: <20240827132327.1704-1-pjy@amazon.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240827132327.1704-1-pjy@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

