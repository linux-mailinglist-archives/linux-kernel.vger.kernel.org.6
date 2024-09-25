Return-Path: <linux-kernel+bounces-339485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1FA9865C4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59F74B20920
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF7F135A53;
	Wed, 25 Sep 2024 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SPqRoFay"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3A582499
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727285958; cv=none; b=pRLkWacIhlAo6LDvni+SGYIZii7WSLQe0dyXfpRfjLW2D4P4Emh59ATabgS9krD6++3dkIaWqcx5Lo4ZcstK2YZWFopLqoZWO9Hk592i6O4Tvi/9ICwHAvgf83au2G919M7+QRUFh6QPDXphU5OPNicEQLOIx4DUwRUSOtU2eO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727285958; c=relaxed/simple;
	bh=f5oF0n0Wz/lUkRAQBBnEg8gLjaISAI4VjaTMonM+/o0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iipYsiawHNZJODcZLXTO+0cf6TyBS730LMdJCfnZ4SgzRNd1WF/fMHTa5CFMUa86b8Gs+VroQj2Ir3H3up4WklKRULPNE/GcF2mirCYAwgAPxWljes+22wCS0akq2RcajwYzy+hOYmjm4ZEUQ3uOpzs1ZV5x4QecyuwG9yF5CR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SPqRoFay; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a1a22a7fa6so584005ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 10:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727285956; x=1727890756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KgGueKRixu9ZnQQScLwMQqezoak3dfmeyQsXQ2YDbSM=;
        b=SPqRoFayTCu1EaYJJZHHWPLjRGcX6zM17x7dapMqrKpp0fb2CmMUhw5FpqGqYpaCrE
         Vii364i2dIcttyHDc9Yzs9tZmjofA5PkvdlOrVxV/HKpFohut0A47qf2c7KXiFLZt+9L
         QnqFhmVVMWL/I7pU5vDp+c0MZpSyXfH+S2PE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727285956; x=1727890756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KgGueKRixu9ZnQQScLwMQqezoak3dfmeyQsXQ2YDbSM=;
        b=s+UJX/yey1xvkf3Biuh2rvH94qhdm7onRsI1wuo5fjG1aw3hkz3gPN4dKMzC+q8ZCA
         kwJ8tBijK4FCB7J/m4iTxkhxe2mACA2UuUfzZc8ThOQmExgmYugwXDaVYKP8dBZf21Oh
         WXfy87Z0MbPBeXHJzEh/czjsfdxYmTU8mA66PSkhqsCINr7BQ7JKXJOgySHlb9N3ymcF
         F1BDbUt5GhhthlvF+XXVxUBZJOtwSL1IVLzaJTk19mptjBQuV2fevYe9sudf7X5DLWJv
         mkXNg9/tcn3q/IBxS145AAlHrCY23gWPhpAyhGsdyDAipdacAqC1xm8CDm0IZ3oquTw8
         0wzg==
X-Forwarded-Encrypted: i=1; AJvYcCUXApXoCnSQCbv8sVbzmmfQ5D5nIfqcG2LeC/5O5Yli3PLKBfmNLOkFVMnYj9tyGb+CxN9hReXV5jtDNTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb3TqaJncPq1R6XF7R5M6H5DWfRFIy/UE+3InG4yypX4O61NX+
	dR2hf7VUH4Dq9JH0TI+D0b7odUVc6EuccIrygqDAXkQ/K7MG32ZhH4lNpcN/P20=
X-Google-Smtp-Source: AGHT+IGnl1pfRruM1HkbfEQSAAN/qBj7jRZF6p29u1V71EYrrXf5i6Ra4bM2ngNTx1led/Ivx9L6pg==
X-Received: by 2002:a05:6e02:1c21:b0:39f:325f:78e6 with SMTP id e9e14a558f8ab-3a2767e058fmr3541685ab.0.1727285956068;
        Wed, 25 Sep 2024 10:39:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a1a5713b0bsm12141285ab.53.2024.09.25.10.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 10:39:15 -0700 (PDT)
Message-ID: <5b44612e-7526-416d-b9f5-d2e7d0896f05@linuxfoundation.org>
Date: Wed, 25 Sep 2024 11:39:14 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clone3: clone3_cap_checkpoint_restore: remove unused
 MAX_PID_NS_LEVEL macro
To: Christian Brauner <brauner@kernel.org>,
 Ba Jing <bajing@cmss.chinamobile.com>
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240903033628.10306-1-bajing@cmss.chinamobile.com>
 <20240925-dackel-chatbot-0a01df1e0d6e@brauner>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240925-dackel-chatbot-0a01df1e0d6e@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/24 02:34, Christian Brauner wrote:
> On Tue, Sep 03, 2024 at 11:36:28AM GMT, Ba Jing wrote:
>> The macro MAX_PID_NS_LEVEL is never referenced in the code, so remove it.
>>
>> Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
>> ---
> 
> Reviewed-by: Christian Brauner <brauner@kernel.org>

Quick note to say that I will apply the patch after the
merge window closes.

thanks,
-- Shuah

