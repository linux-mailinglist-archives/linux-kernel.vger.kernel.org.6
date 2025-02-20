Return-Path: <linux-kernel+bounces-523443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42662A3D6D8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F7316FBA8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145EB1F03DA;
	Thu, 20 Feb 2025 10:34:45 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F051EFFB7
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047684; cv=none; b=tp75ESxVdVePKq+zMLwCHRhwsAluS4R/myyvAIh5cY1fF/zj+Ljz5YpR1OQIzW3FUexg94y/k9LcG+CB3zKbxUnshh6aG2+you3bwKEOr8bpXNS4Y31jw2/8eLNvbS8soT9y44azxxTCWS9rggpEzesFRqVF+CcE2alUUHR2RAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047684; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbLhYOTiR5Qv+olKCBDDZESdjyNXD3lN1kvXDz3HXrrmRzrfbctTaaIcRgOCvcywoil3bKLjX5hDwBTZRI+IIGE74XRf1of/ADukAWwvAmp5RyaSsGTkvOfs3UgGU0tIB7M4uI524WQHrHY9AidhRpZG9xEuVmhpwbprMGSnOgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-439846bc7eeso4410075e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:34:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740047681; x=1740652481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Z6BmRbJK3agjpH+9EYQOdN4mCGCAVOw5FVDplTajRXe69B8r815wBGz+GPS/WJZ1At
         /UP6edpwacKLStOQMPTnmlpVZwY0iAIFnWHikTyeKUADcTR5mU4/UVC26K5pxkiY+pqQ
         BWVO81/BAxPGo/qJFrVepjKhTlbwFxITClqfDvd0TMI6jc2KFjPYFcM+jIXN3+ofzkTp
         4qDnxk8kYT7EBwqtcnW4qOPlNKQMwdanlVFpUMls3xFUwOsv1Qn2viyxwAD8IBbOThRV
         ulW87zFvgyoIwvCRPro9IdHW8YfNHH00PrBrGleEJXYwfTHG7x3jum4qeP3kBC4BCrvJ
         RewA==
X-Forwarded-Encrypted: i=1; AJvYcCXZhMm7EGxmQcLeqZk+tkkT9nkFexkttS73qIafJXhCwNS3RElAk/Xj2EbMdRNnQjZ4f00tOF+Si8j8zJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOuuDMykpvNcy3FbRuvUzjC0snOnyiNyWXqimC4YPQFVeBjjU+
	OSh8astDGHT4IY/UsF2yGcQbbtEze/LohcUbkHaE5LPaohp3gdg8
X-Gm-Gg: ASbGncuA8HruodfhaFJR1ORnXNGfTiEV8f53PRTDMbEDbu28UU/J7qhWZSWUlVn6CoY
	gshjptmvCvOcbzScxN/WNV/BsiUFhiSHkmNcS/aUsvKB1ijhHg26v1CF6BuhLmls5HpWm76M7u/
	P4rjyf1v+H3cdJJJfzOU0Jw62iJSXdaJKP2536d/oFH35cP5rj1oZZF+3KfPqkBOaP7d2Gv9hWT
	E8kCthKMtZ2TFhlyCxDvmwcLrrjy5DWFgz8NqQDSjTLeENSlAH00HeWKglV4gZrSKmU3rACMJ8N
	tyr9f3zSGM5ylmGFy6PHXSK+LfkZRDub0YZRL9SYitr6lHBaM+Y=
X-Google-Smtp-Source: AGHT+IG1XAERjlZeolfku4uzfm5PyTJpsYEZeMXgZnFNEAIQaTE8DD6o7lsFxTSvy9r9GAQad0NT5w==
X-Received: by 2002:a05:600c:474a:b0:439:8a8c:d3ca with SMTP id 5b1f17b1804b1-43999ddb1c0mr71908265e9.29.1740047680846;
        Thu, 20 Feb 2025 02:34:40 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43991c84fa4sm83526555e9.39.2025.02.20.02.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 02:34:40 -0800 (PST)
Message-ID: <d10b5bdc-147f-4d72-a47d-b7a5f5cdda40@grimberg.me>
Date: Thu, 20 Feb 2025 12:34:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: only allow entering LIVE from CONNECTING state
To: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
 <20250214-nvme-fc-fixes-v1-1-7a05d557d5cc@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250214-nvme-fc-fixes-v1-1-7a05d557d5cc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

