Return-Path: <linux-kernel+bounces-175094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B56D18C1A3A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E56F91C23190
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D711C2E;
	Fri, 10 May 2024 00:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oMwUfgml"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C187F
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 00:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299588; cv=none; b=awhpBgQa0AuY2yUZITXJ/NNmYPi1LL+mfpbHZAOcY5+J2yCU6VV9SBgdy/2v9sx+ubtlDnrW6bUQjbVh4BA3XFZbjGPUTVVLLpxwe8bBhRpDihrPDX1lJj0nIq2lpl2Fa5JeBwb/IIwobxudOaVUF7dJOw487lNspUL35GrWo4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299588; c=relaxed/simple;
	bh=GLOG80HgKLQomRdNUGeLi4tSJE/YjuubP50efidlOaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ja2Jtj8kPDJOVgzcaeSLJbPts0tm7jyKmGJjeNjjbg332zAAvysLrysXQJAHJcjEFxY1NEaDmZMlJs6inID4d3qNv2/I6z9cxVCtijrI7nAIOFTN+bQ1c7m8+I98T2Em1TKfigy8AqtNm6om3isL8ITCG7DBvefEFGXdGZHWUoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oMwUfgml; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41f9ce16ed8so15143235e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 17:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715299586; x=1715904386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A9bM9WgcUeLqnHcG3u0KhZ5y00qqpThdPur7Fomuotk=;
        b=oMwUfgml4KO6zohBzwROs1yRS9tJhUGd0u0TwdRy+PTo4fF93C3tdnngMsNbwj5/OT
         y9Pqjzt3QTsqLvsFKVZdFvrG8I6QMkDr20Vq64FWVNR3sdd1we8Tl9/+ldmmvUTmhcit
         A6buEBJSJ/Z+z0/iCQA1GuP89oGL090pVy1rmu2lL/p9Y/SMg0PfxBmmjqsGCFBhS73c
         sVcdGFjB+8yxVZ3IbW2YuXkhlCL7TiIl1v7oLycMjB3dE4o07A6/S10Tp3/r+a7IoYfJ
         oq8d5sX3FoIEL7UPT7niXLQbuA/IFOeOjQxC3VQO45GhJpEGJZPtHAElrAARqUPFPOZY
         ACyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299586; x=1715904386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A9bM9WgcUeLqnHcG3u0KhZ5y00qqpThdPur7Fomuotk=;
        b=G6I7zaWcqWzqJgzPdzW+rrues/dT4m57bN3EdDOBXwYpHW7+PIcZ+INZvPOLVdFMNp
         RStgY1u5BlawBj71NP7vjej5J7yWsAOOvcL9Nd4JIqqYkbK8jasUPojIaRy7pTzsjjgc
         WAHeZRjSA5JTTGYyQk35oOi+X/QFMwaIp58UoBXPtDTEmXXWo6QXi3YqNvyXdLJ9Jzpk
         HA2PKl1PSEiuqcNbQGQb1T5wpqVg4BzqqdfYASKg4tX/ic49tj1XBTCiENgPHwGJmRGp
         FWsJz3LC1kcyG7m9y8Z5Jtx8eXB1OSQEktWSEocvqk03olwlK77laCSGVPG8RkBDd7SJ
         LVcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpEqjDve0Uo50xkpGSlGxoeKhSiWUVkMiGe7jFcZktf1HYS/nbYRCDsFSrqgG62bH1pcP2CpWbFd9UXjNQbSATA06zKqa57eX+0vhy
X-Gm-Message-State: AOJu0YyKXBkcJPzWYvGItHr9YSDBAfKVxhDJJJQNr1R6s74oVPXAEOOT
	z+iC9p+CiNsIO+HPPq6pTFz2W9+ZRWJa4rkY1YcENGVzW8JdoVTBtb1RhEMIkhQ=
X-Google-Smtp-Source: AGHT+IGmrKpJP+pGW+74voCnBlphBkplUtmn1tBmjBnekPxUzsEhla98/zmE5Y3eodeDMb+5+jCYMg==
X-Received: by 2002:a05:600c:3b86:b0:41c:2313:da8d with SMTP id 5b1f17b1804b1-41fea539615mr11429115e9.0.1715299585791;
        Thu, 09 May 2024 17:06:25 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee9318sm41856005e9.30.2024.05.09.17.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 17:06:25 -0700 (PDT)
Message-ID: <8ac97153-0e27-47c8-ad86-d1840ac17c3a@linaro.org>
Date: Fri, 10 May 2024 01:06:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/18] media: venus: Refactor
 hfi_session_fill_buffer_pkt
To: Ricardo Ribalda <ribalda@chromium.org>,
 Michael Tretter <m.tretter@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>, Andy Walls <awalls@md.metrocast.net>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>
References: <20240507-cocci-flexarray-v2-0-7aea262cf065@chromium.org>
 <20240507-cocci-flexarray-v2-17-7aea262cf065@chromium.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240507-cocci-flexarray-v2-17-7aea262cf065@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/05/2024 17:27, Ricardo Ribalda wrote:
> -	u32 data[1];
> +	u32 extradata_size;

A correct functional change but again please keep the name to `data` not 
`extradata_size`

Then add

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

---
bod

