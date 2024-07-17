Return-Path: <linux-kernel+bounces-255652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AB0934337
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844A91C2133D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D11C1849C4;
	Wed, 17 Jul 2024 20:29:29 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19D51849CF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721248169; cv=none; b=UoLAb3v0Y/90kfyf2PKWWlj05BaD0iSoENpHz+w84rW0350EJBDApgexAzPgJtuCF+Ngx6DoUo1zZ1k3teYxVI8tmV78nX9UpMfyN4biUwPsmgJDMh+3vGZCh00FHYDR67iXq3j7TOiwHZoXiAgODD8RckKRDzlyW1GDr5d0x9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721248169; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sW3IvXYakH/yuzlqMBWNCvOrMn9zpWj8uwtpasge2yjGBti7iacwJkXO705dnOn8Ts5DKQy4Mh4zCN6r7hXpO5wEZkwb0nYShG0uN967LdkQhnDuZ/rccQ3ToCBmYf4fDH+hoW56UYbUcf8FE9nlT1NR8tgTvWqRYIAkC2PbyEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3684e2d0d8bso1551f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 13:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721248166; x=1721852966;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=PidamFlkDVOXKuHBruCW0vm6j0ffuI0hmyddAZ2AN/994xTnMhD26CHhc0hQeINZX5
         13uODLLAkjuMph93rjXEKxpQeKmBlOEvxnvHUnOt77xGAMyTXaYeBmfmqMyfuttrsRvD
         MjyXyrYprOEfP4ixn7a5/iGOyR0E5rqKpBeeuxL13xuh4EYBmByeutIBANXG1VzheZ6Z
         BeZlQqn4ulLfJDdyKRaWPw0U01fRqOnP620TYEw95TETfFaSNT8gU6mMf9KlZ4o0nERE
         yIzAbSZ+h8yMIT0EhtcqZ/M2aPUbRg/l7BOq7DFDHw5UpTZCm1vJAR9LVvckUUATIwIi
         /VuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVQf0+ck52kspl1g0+vQvq9zBEYZVCbtllZUVCRRPbUEBZu61fSWQayjk8i2P8fagK04RRaNq+gp3gFnnCYxAiV83WyHXVT9dnMc25
X-Gm-Message-State: AOJu0YweJ/7CIzGqyXq2B1OGf35S5pekfgAO5why5r7bvW3A9evsZJ0w
	CaF8Yr4tpMz+G+mSJvHye17Y160ORGVkjMiTlxGXIIKegb0vHh1woFE1kw==
X-Google-Smtp-Source: AGHT+IEO2DpBp1N6Ll+/zU4xSa4F/70cpRJaQU9KNNcMZak9m5oWaQlfCGfSZXEiPPcmESiRxwki6Q==
X-Received: by 2002:a05:6000:2a8:b0:367:811f:814c with SMTP id ffacd0b85a97d-36831652928mr1167016f8f.4.1721248166028;
        Wed, 17 Jul 2024 13:29:26 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafb99fsm12536938f8f.84.2024.07.17.13.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 13:29:25 -0700 (PDT)
Message-ID: <ce3fb9bc-e746-45c4-a25b-9aed15842bc7@grimberg.me>
Date: Wed, 17 Jul 2024 23:29:24 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] nvme_core: scan namespaces asynchronously
To: Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>, Martin Wilck <martin.wilck@suse.com>,
 Ayush Siddarath <ayush.siddarath@dell.com>
References: <20240717185550.22102-1-stuart.w.hayes@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240717185550.22102-1-stuart.w.hayes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

