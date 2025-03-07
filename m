Return-Path: <linux-kernel+bounces-551431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5DBA56C54
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B3E3ABA84
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1960021D3F0;
	Fri,  7 Mar 2025 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o2S1CDfI"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF082E822
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362155; cv=none; b=aQ8xhYspEXVOqZeLVJc5vYASXAvVTSRIQG1M3DBEnAMKyFBxyoz9XiKKG1JuHMmkwxVSK/kyaUq3ep6lTNZ+QKCnqoU+wICAtRBS3R3FpyyzCquY4WzAi/wzHy2WIXYESTQNrOE+B3weSa5MMJdJkpYn2tQnoqNXSrxY50E9wbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362155; c=relaxed/simple;
	bh=nbOVkYwAlhRRi5uwFVVzzTlIsgn5obXbH+hQcwRewD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YG3lRCfjyjdG03/bIOWAE5jW8yd1Uh2M6YzgqpsWjLhgzRqgRB/jkLQ4NhahjdUJq5Olvnjp84BqcsWrqxNcpVQ5OqgUuhR6qcWHHUZ8+8trydQ9kemtAQN930cLhplytKQYJ/847I50Gb+FFcgQwoAUShLREhfPr9VqI0N42qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o2S1CDfI; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so2085728a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 07:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741362152; x=1741966952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3YuW0oXrBdYtRMAGRMastKIQLtGGLBfW0tz3GbiXdp8=;
        b=o2S1CDfIA0pPIQeN3cqs6Fw/XF1/5/gUY3JaFa2hwrP62b2oLY69FZQGdLATLgBmU8
         1GdZtmsObNOZ9WCAq7tX49Rja/wxlpQxr7s2bpoQ2At2hsncffzR6+eH/v4DtfATk7ym
         ej9tRIRo80LGdhce2GNaqem/jZ86VXIFpHpuhaCMnlYG/m1LE52I/Gp4SD8xlLNKBtvw
         6Ce9JnZ9nsoZxks00h6IQD0U9xBivjPUYKDyiFLeEs635Xsna6EUeh+BShuBbfzJclL6
         YDi+g6Qatxo9yl/IFv6R9Hvex4OmAI18CM1UXErGgLmW1LMcs6xSYbpMSCgjJYrW1P0k
         B2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741362152; x=1741966952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3YuW0oXrBdYtRMAGRMastKIQLtGGLBfW0tz3GbiXdp8=;
        b=FA6Roc4h29fGg4jgX/hratMteU0iX6TSqCAOi/tHFCLVcFwPO9bLZRsfL+5ElBOFjc
         KQTTQ/OA7Zm8kJ0tn+RmKOuOgSFIfQ9yP9AiXDh8CIGZAt0atzmA5SnNVdtSbERY98E4
         /Axl3vWTItRbPgtvJj23yV/LxHnK6OaPB3HI/j6OHpJW/+1ltOCSOaqOfEI7e7gCQz94
         3iCl+5vL49T0Np3Z2bXUm6iYjsJJt1NyypMyTUiL5tpeWKZ7jg3FjDtc8LUCzTUzhfZZ
         TFvnF+S8DCinjWqRlQkivjL9d8WE7V2NqoV5h0za1/8qtUrlB3AqL93yZ8YeyGyZP6oD
         Sg8g==
X-Forwarded-Encrypted: i=1; AJvYcCWHKxitxqFl9U2gGX+LaDWnESK5AjF8xuN14hbgS/vgTL6jM9xAvyJzQ711yRaCtkF1ehLBLm6MLnWFC70=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMV30i+o3PgLThrh/PGZ9a9u/FYXOdvkeQ2DuvSN1uHb72Cbb6
	Uw6uSJenjg23shi+Onxf9+U4vsOFTqcboor5o34+Up0+vX8j78Jz3d0h7VFP9X0=
X-Gm-Gg: ASbGnctUxbsinS/m16nCLyDaDm1qBUmW43bMND2FsWo43ZtjJ5AWW0SfQgb8VNHWvT1
	+OVGm24lq6Q4a+dob4eM0CupMK/G6CdXa4gV0CN0IPBzCGmGE8c5z6rl2lDtowy+rvnB4t2djG+
	e+04jwQMbO9dKiaCnrO/c3ktzUD6QbVOaIsDbzmdwwq1mQKpr17T221KKp7JoiISx6T83Y6AM6K
	8grzumf1NxXMYvgQpI2XYO5mwJpXTREoYaEvRwQqisRuTIEYKtHnxhsi61+dc+Reyd5UEyKULHM
	PbUlHKVJxSR+9PDoid+eE/QNOoFEWHh/wlIoqDQ53QzMPg+f4ZtIZg==
X-Google-Smtp-Source: AGHT+IEyat9oHWfOYyiXKs8aTVrlJzL6X4S8kHWHMWCXsCBduRWhn6F9bDNlsKCZelNqCqQeEmR+QQ==
X-Received: by 2002:a17:907:7e9c:b0:ac2:4d80:232a with SMTP id a640c23a62f3a-ac252b878demr402191066b.32.1741362152017;
        Fri, 07 Mar 2025 07:42:32 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239482f62sm287401066b.40.2025.03.07.07.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 07:42:31 -0800 (PST)
Message-ID: <6a384a1a-ec92-4688-a0d9-4118ebd667e2@linaro.org>
Date: Fri, 7 Mar 2025 15:42:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/21] mtd: spinand: Use more specific naming for the
 get/set feature ops
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Santhosh Kumar K <s-k6@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <michael@walle.cc>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <stlin2@winbond.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250307-winbond-6-14-rc1-octal-v1-0-45c1e074ad74@bootlin.com>
 <20250307-winbond-6-14-rc1-octal-v1-4-45c1e074ad74@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250307-winbond-6-14-rc1-octal-v1-4-45c1e074ad74@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/7/25 3:08 PM, Miquel Raynal wrote:
> SPI operations have been initially described through macros implicitly
> implying the use of a single SPI SDR bus. Macros for supporting dual and
> quad I/O transfers have been added on top, generally inspired by vendor
> naming, followed by DTR operations. Soon we might see octal
> and even octal DTR operations as well (including the opcode byte).
> 
> Let's clarify what the macro really mean by describing the expected bus
> topology in the get/set feature macro names.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

this op is likely to extend, so:
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

