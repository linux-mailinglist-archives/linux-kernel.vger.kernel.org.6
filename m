Return-Path: <linux-kernel+bounces-282434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E9994E3E0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 01:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1851C211B8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 23:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB03F165F07;
	Sun, 11 Aug 2024 23:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Me3s1RBb"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973DD1757E
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 23:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723419417; cv=none; b=WtSnac7H1zNRUFPxAKnk6VOofE5dNoZzXF1ofl4JfFsJ/JcIEdbX/cGGGqBKZSdViKhCcTSCjwfnccbHL8nBoxZ7K02f0LUyyZS4vr2UsRKiC2AaW8sMIIjjeL9ibUEg0R/ezh2h1RQXvL2pmbSdFwdjAzlzK1SKutclSrZOGKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723419417; c=relaxed/simple;
	bh=jJik5mBjweL3zeBsn9GrnT0qvWZxBXOstNtni+DjEVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQO+HwxKREHJcYxrCTtmepHrjgyLTksOJC+A9+/DWq2WdFABjKZK6SIPHs03DI8ZOTgaRwfEfhjU7YoyDEMaljra35mBTP6QlUu94wRYn7qy/XSbb6R4vXS7Ms0oW61UbjAxuNV05Xxi/AGfG+WlZH9GRfVkPJRKjGzuYTbX0ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Me3s1RBb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc57d0f15aso2265375ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 16:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723419414; x=1724024214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/o6QQklAMDDZPvFb9yHs8DL9r8gNwt2hVWkEfNGtW8M=;
        b=Me3s1RBbq/W3b+mT8KMprLwXlFHJjfAhTwyWmw6LGfz0Nb6upydLrSaQqz4dgxcjiX
         dxr8b7aAS48nB6dQbrxCjQ7N6H5GT+9FobvEdh/0hMLilPXmOCoA7i2deuEn0j4NRNoK
         90QFT52veFvtG9H2awhoflwNjF34gURaz65+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723419414; x=1724024214;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/o6QQklAMDDZPvFb9yHs8DL9r8gNwt2hVWkEfNGtW8M=;
        b=t+UJXxdQmVwiAefBDYDKQPT1k3VVRlHL5xZ7lwPoZ7hCTRIgTz80tQsFCfPyTxcXeU
         NC8TsehEVzYRwC+j1Zl6w59iHy5kBDIPuF7XA5k9bkCyQoNir3QrPXt/fOi70H1wpoX6
         9w1agXQdTA90L3owfzELtNyF06PvyIZoway86tv5wB30rT/CfxZeoosEMOGts+yc9l5F
         opdNF+bvX7wmjWKOjEyYDRbiB/9aYOKv+WKd6qItnimbDTU8LApWKqHSyF7YBm53eVAg
         k64tmK6DVzFh3qG5yk4IZYqeDDf0of2jNOvfZajF7XuOosB5bxmiakVbh5g770RbQqeT
         DSRw==
X-Forwarded-Encrypted: i=1; AJvYcCW6SIxnsuOFBxPlnjvUA8yCSud5wEH/QNPmgkUZLwSXtaJdg0xGGzSZQW7CAfj4ddHGzT2xRogwvTfsf651y6BvMDwoWM3LtL7osgBQ
X-Gm-Message-State: AOJu0YxuzVN3IeWxQ4+YRWUQ+ZVrIn8Rv2KcV1WCsdzSew4lTj8ebhzT
	DQ48Qocl252VA8iROq6/mJiQ9Wna0b/rUnepcUsyZU8KkWT8JO0Xxq9an6MQIkc=
X-Google-Smtp-Source: AGHT+IE8vpXF6yYoRRIs3j0MzPmM2wt2DL1913U6epAdVdcSZnLFNeXmzAhsKHWMRz/AyXkdKABfpA==
X-Received: by 2002:a17:903:2445:b0:1fc:52f4:9486 with SMTP id d9443c01a7336-200ae5daa64mr60718415ad.10.1723419413833;
        Sun, 11 Aug 2024 16:36:53 -0700 (PDT)
Received: from [172.31.140.29] (softbank126051159161.bbtec.net. [126.51.159.161])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb903b09sm26740135ad.95.2024.08.11.16.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 16:36:53 -0700 (PDT)
Message-ID: <4542b8cb-414c-49e3-8509-6975976ce3a6@linuxfoundation.org>
Date: Sun, 11 Aug 2024 17:36:50 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests: rust: config: add trailing newline
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Anders Roxell <anders.roxell@linaro.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
 shuah@kernel.org, rust-for-linux@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240802124536.2905797-1-anders.roxell@linaro.org>
 <CANiq72kM1RsZCrK-3gFZufgeZQRvOBAbO=DwRHpukX5W=T=UAg@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CANiq72kM1RsZCrK-3gFZufgeZQRvOBAbO=DwRHpukX5W=T=UAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/10/24 04:33, Miguel Ojeda wrote:
> On Fri, Aug 2, 2024 at 2:45 PM Anders Roxell <anders.roxell@linaro.org> wrote:
>>
>> If adding multiple config files to the merge_config.sh script and
>> rust/config is the fist one, then the last config fragment in this file
>> and the first config fragment in the second file wont be set, since
>> there isn't a newline in this file, so those two fragements end up at
>> the same row like:
>> CONFIG_SAMPLE_RUST_PRINT=mCONFIG_FRAGMENT=y
>>
>> And non of those will be enabled when running 'olddefconfig' after.
>>
>> Fixing the issue by adding a newline to the file.
> 
> Could `merge_config.sh` be improved too?
> 
> Shuah, if you plan to pick this:
> 
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> 
> Thanks!
> 
> Cheers,
> Miguel

Applied to linux-kselftest next for Linux 6.12-rc1.

thanks,
-- Shuah

