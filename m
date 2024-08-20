Return-Path: <linux-kernel+bounces-293984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B25958735
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 055BB1C21B4D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165F518EFF1;
	Tue, 20 Aug 2024 12:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HStJNNPz"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04221370
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724157666; cv=none; b=L9mYAojXsNeZ3NKP/d3jP92Plh3gZbMbRG3IPxCVO4o+IWzhQHtdcKI2rK3lUhKPOMe5Qc4BVpe1rqrriWbmwpE1JSEsDaWmGoTXqnMC6TPOl6PHC5omN9IZndB5KN2r5Bdg1SEBpxmqbE9QsuKMXBdPVchvjRtYWITkYLhIszA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724157666; c=relaxed/simple;
	bh=PGSEQAyIi9jI9oBqITOqFC8xkaLtciX6Fdb8rojnYRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nD2Gx1unrdTlfO7g2gCZAL7ziDO3fRpX3kN0+HHo8EKTkLBEH40lQpOMkF1/BeMb82+helqVOJcfpjHXZIeDqYjbE/rRNbme8+KQ/xugPbYIauPieIzoKmuYrgaxrzMYuELw1NPw886Pzff3V1FM02ufb0cNJm78QXVywDtVZZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HStJNNPz; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53346132365so131094e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 05:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724157662; x=1724762462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=th9bq7VQDRijrIGlbRpXI4kxULxr9Qo0oEmRThChA6U=;
        b=HStJNNPzuu0/AI3Ca29alwvbcRKL1K+FehVrwMhE4P5VDiEv4I3gmdd3B1x9QRaYiZ
         ZpmigPqQv9iwo1AcorgXhtId9GsqBHxqxtnthrxC1FQIytt82URK/hffaA70Cw2XkWJU
         0Pkd1ZHPXMXZJ/ichO20V17OrZcnNWOjPc/4OKffE7LJSfqW5NV3NnGYCy6DRfTeYmSu
         CanOdhaL58fM6x3+De2Ssbo0MBj74woov03m8hf2Yycb0imA/0idsWhA/jPDGxbgzF2L
         xCxAUEPzaB72gaa3MnlrwnFamN6yLiZEavHYL6YG+tlMA+95r+fjiN+rsLv1eDL984aZ
         59vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724157662; x=1724762462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=th9bq7VQDRijrIGlbRpXI4kxULxr9Qo0oEmRThChA6U=;
        b=b5G3c2PanSLrRKkJPlbVz8c4B0YTfiCy7KJPbRyJL3Sk8h+INmqORzOdz0TifdhV+Z
         3ibLQJVzMNNwYe2uKk+E3wyc6VCUZrwzPOqng0nbb/3IB4BJIA2PNty9PtqSEStIt/Hf
         GAMkE9L6nsxOER30DHNqSToA8VCdpeJw6yyjGmc5hDnDx/0iUbBJiKq3veYQe5g928nk
         UbLv44saxTPdYNPTZJZj4pmc2o0CM/0HZxts7WQWPzBh0ZkwpQfUKoyypOZ3SP1rHnQd
         9n+mBrC4voeAgRwJvNo9wBC7sPAXRj4HYBZcxu0/SIKGChTJVY9NIFvOjrG+WaU6H0iG
         aOhA==
X-Forwarded-Encrypted: i=1; AJvYcCWM7M8ah/ceohFzJ37xLVwV0RNOExztWreqPZTdTLUOtpYIqxcq9bvEmc7+0RauYkTTA8v8nSR0bA2No+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBr5qlq4zN9afn3SqV1bkUR/VsAQlHeaWuedKOmuyLLB8s8nRj
	IsSIgRe9swcJS44AzfwSc5ndbI3KNzBSCTGukb6RvkS0s6aqM+hYMjyeQaOyulU=
X-Google-Smtp-Source: AGHT+IFNYgoQNngidsNHNA8R7CTMeA6kfVvv/tq+qTTtkoOL0vjEXyJyslyeRT0dXztU8fTH3SUt5g==
X-Received: by 2002:a05:6512:6303:b0:533:44e7:1b2a with SMTP id 2adb3069b0e04-53344e71c63mr623283e87.40.1724157661251;
        Tue, 20 Aug 2024 05:41:01 -0700 (PDT)
Received: from ?IPV6:2a02:3033:209:8a31:69e4:f574:e675:7754? ([2a02:3033:209:8a31:69e4:f574:e675:7754])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838393598fsm758618966b.133.2024.08.20.05.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 05:41:00 -0700 (PDT)
Message-ID: <f0155b49-f940-471b-834c-62254afc52d3@suse.com>
Date: Tue, 20 Aug 2024 14:40:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cdc-acm: Add DISABLE_ECHO quirk for GE HealthCare UI
 Controller
To: Ian Ray <ian.ray@gehealthcare.com>, Oliver Neukum <oneukum@suse.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240814072905.2501-1-ian.ray@gehealthcare.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20240814072905.2501-1-ian.ray@gehealthcare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14.08.24 09:29, Ian Ray wrote:
> USB_DEVICE(0x1901, 0x0006) may send data before cdc_acm is ready, which
> may be misinterpreted in the default N_TTY line discipline.
> 
> Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
Acked-by: Oliver Neuku <oneukum@suse.com>

