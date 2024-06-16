Return-Path: <linux-kernel+bounces-216095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA8E909B4A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 04:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F1C1F22BA6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 02:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A66716C6B5;
	Sun, 16 Jun 2024 02:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lf7FKzDj"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F1016191A
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 02:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718505578; cv=none; b=nw0XcX9KupZdnHYCeqCaKrwH1cL8UbIDtrrtnsBsZYmInmzNrbNx/Z622Kp199vuJONA+css7+r1D28KQHeva8T3+eJzbDsIlBgyOa9vWlj+bYXD7NkSt7QjGdYD4NZfgEDYc2NhKhBrspNvnctoHHrDD82vltsT4EoVG/XSnOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718505578; c=relaxed/simple;
	bh=YLtvi3cgRMfavP99RYY/804HpNpXhAHiewJbQFScSjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INyuLWHo+YuJvVNU+hThqmhKJUEww/a3nHQblL+RcEfVMPeQ/bhER23HAejucYW46PtwfjDfSe6qFPJNQaH0Lti2BuWsOmPEXMOzHTJ3RJiwqV63SuJtx6Z0a2BaX0LHf8AAP+gb4OscqOZFGnfLAHJsRrIjdS8UyA9mYNp09+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lf7FKzDj; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c4e2cd931aso382305a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 19:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718505574; x=1719110374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yRzT6d/9o8NxOpmdEJ+roA8awtUjpg7JSQcSyhSnRw8=;
        b=lf7FKzDjgrSatnstO7iDR83w7JCminUu7r1HxF9WfEj9rREbVlYcYf/16bOD2cLYsw
         pAcgUBB38ZUGnUIIBXxyiDwnUtt5DG1/7md+ecBXSgem1LjYfGYHULEr/gKV1/0DfeNk
         j5AGhvhzUOUQTk530MxBkb4SOEfk2ggH+L/YBTMBd7w6YXJmz+tvAQGHRgmldQvtTEjh
         CwiT3OwS54xqbnSX7d10NcmKFHxYnfVXXVgk1D1CtUFTU5rSp5ikqnoirnA0R/gtCjUl
         /D4kTQwRHeSArzxNnVkcrbbU9NP8Dtb6D9MC5vyBLNlRHV4bQG9PAy4rgAu1S4K/ZRoi
         4S/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718505574; x=1719110374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRzT6d/9o8NxOpmdEJ+roA8awtUjpg7JSQcSyhSnRw8=;
        b=oGvO4qK/OY/bWW9JxJiwxX4dggDH7uUo2q+KHHI84QwUYV9ESevJsuI3svbWVYJQqu
         +FPdOzdPtvyK+3pF3/ixrW2Gjab09H62YBPvw7UcdGt06naBHyyz5duqisZBPgWY7Xv3
         mXC38NP8D2H/n2Xrgi4pHZx6MwibHbdVNnsJZDBVQ7PPjlwWv9ykinmcJLuXuKOwvkz7
         Wls14INHwzJlt/VG5kMiBiJQYAdyjvE0LBcGL5kpEYbEeGJT1ezDfFJZuvRwGyb0YXY9
         RLgnRK274rBoVio3NKiPaB/yCNO1Mbh/yNAI8dV94SG16b40oWGONAcCmPHa9iJiYjmU
         rO8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpWIV3yP1vs7G0P3EtnTYrBFkKxxBpxS4Vs+B+W7UgcOvCDi+8v7bTnTL5pqIsa7RHJTQlleEcSQ7LGU5Y5EmvGOrNfEfG5Kb4ya77
X-Gm-Message-State: AOJu0Yx8uOQWdAL2rzy9277IpTArcRpv6/SZE2BUIs9C70Ir81wdCoUc
	FSrksHMJHGPUEtWFdoC0U5coIlkp4uE/Ew8T0Vdkmw42R0xn2f1+ZALtUfNIDyJ3z7Bd/rDEgOS
	T
X-Google-Smtp-Source: AGHT+IEvDsJB7TktA53hqRSMvUKa578kd46EEBYJWKXK1pbkfy8WV3h3HK01JNi2yy/ww8NPpJZPMw==
X-Received: by 2002:a17:902:eccc:b0:1f7:1a37:d0b5 with SMTP id d9443c01a7336-1f862c30f6amr75257695ad.4.1718505574638;
        Sat, 15 Jun 2024 19:39:34 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f2fe6dsm56586435ad.257.2024.06.15.19.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jun 2024 19:39:33 -0700 (PDT)
Message-ID: <693af28d-5e25-432b-ab1b-37eb9026c7cd@kernel.dk>
Date: Sat, 15 Jun 2024 20:39:32 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Avoid polling configuration errors
To: Christoph Hellwig <hch@infradead.org>
Cc: hexue <xue01.he@samsung.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CGME20240531091021epcas5p48fdbd6302bec7a91ff66272c600b0dab@epcas5p4.samsung.com>
 <20240531091015.2636025-1-xue01.he@samsung.com>
 <ZlrQCaR6xEaghWdQ@infradead.org>
 <f092f5b5-68c8-4e76-9ea1-f319bcf20444@kernel.dk>
 <Zmqo2iAHlAwANA40@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zmqo2iAHlAwANA40@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/13/24 2:07 AM, Christoph Hellwig wrote:
> On Wed, Jun 12, 2024 at 02:53:27PM -0600, Jens Axboe wrote:
>>> So we need to ensure REQ_POLLED doesn't even get set for any
>>> other I/O.
>>
>> We happily allow polled IO for async polled IO, even if the destination
>> queue isn't polled (or it doesn't exist). This is different than the old
>> sync polled support.
> 
> Yes, and for that to work we can't start returning -EOPNOTSUPP as in
> this patch, as BLK_QC_T_NONE an be cleared for all kinds of reasons.
> 
> So if we want some kind of error handling that people don't even
> bother to poll for devices where it is not supported we need that
> check much earlier (probably in io_uring).

There's just no way we can do that, who knows if you'll run into a
polled queue or not further down the stack.

IMHO there's nothing wrong with the current code. If you do stupid
things (do polled IO without having polled queues), then you get to
collect stupid prizes (potentially excessive CPU usage).

-- 
Jens Axboe


