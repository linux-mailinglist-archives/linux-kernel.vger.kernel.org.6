Return-Path: <linux-kernel+bounces-186828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F05968CC9BE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 01:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8939282574
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BE814D299;
	Wed, 22 May 2024 23:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EQNtH6Rh"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7EB13DDB5
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 23:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716420989; cv=none; b=JPXF/GtgePzCN6geDi+YPaWQb8gAWdG//pkRZNTeZwdNe0fXELecjTOkMefnJ1t9l7EMgzYQzOMZ++Xq7xbaNyR26e/m/hJopb4qnr4RaUbbXURynxei/8Kum8OcAMC6S7ts9G9ViOgYSZkDGz4E+OKg6ubVqG1jy66QRGLEGXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716420989; c=relaxed/simple;
	bh=eeVd8qPeHXjlun57Uzuk+SFjdiM2OMztLQecXhO4QnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CT9loFYz1NBZexEIYY+7zq40ISSwVENtcPCbqpGcBLbcLHE+OXQTiUr6Mf6BB3QpzV37drO5dPHkmAfLsQvn2h5Mp5+uMXYqNePYR56E7hermAePsTE8ed7OIu3eXqlEOmmAE+GO/WuDakKkn+ATRnVUSrWOYNKaU2pRwkXl4ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EQNtH6Rh; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36dd6cbad62so3931225ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 16:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716420986; x=1717025786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sxGBy+OPXkVQsg70GHc4dBA7DwixWSOZ/j8bxRcEzyM=;
        b=EQNtH6RhnMQVt95nW44fyUQeLAbbyRMzrgtdxNF1oPLCn5OY2JtxCKbfI7X/GG6BlP
         YJ4yP2oVCEzmh0CgSBzZD2mKzLr/W3eQLC7XEKhWxA8zNjGMEMZoKDbGducOwzS+2dpF
         svnTF26JxyaTrvhcwLZp/bWyEDC8VAYSIBCjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716420986; x=1717025786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sxGBy+OPXkVQsg70GHc4dBA7DwixWSOZ/j8bxRcEzyM=;
        b=JY/dD7RIsbP9ZYid0vPsOKm94Z6vEUbx9s6ezDJzkqwG6prHyKc8hZMk+7o4sCMhNs
         pxG9oASawnzXLkf6P//HKORKXXutcOh43bB+j7mITCk1qB/Aryteg8q1joyNXVQlMw2W
         gmzjAVX40JdzNQIc41kGLkNyfUGULocVz4nhWQQy5ff57sBOWa3jkJBOHN/kbvlhYkwe
         Tyxl5ZLTQwxz9qAxkfADH/c0602AdpuxpwWukSrcKJOPHpe0wBXd4O1VZsy3IZsYdtwP
         LCRVRZpNRH4T3sl4otO5laMfSOiBns58l+PRIaaI6v7NjLeOLC1jEGCw1Jt2zJTwIfHt
         Du8w==
X-Forwarded-Encrypted: i=1; AJvYcCVWzLqC6oCAdYO7c+nsDvXI5cMz+rRDsxsuBEN1ROhJqoDrsmJwYWc9U4psCXLP/lGvSPlTh/own7KlcAtbKvs8xOjaZAO6empgqV+0
X-Gm-Message-State: AOJu0Yw/WR2SXLe63bOOZnYNpJ8h61Ea1Sa3yIELYuH+Mug0rssNb9xz
	5MQX0rY6nQysvSFU9Tvcc/XTCvagCXJ6ihppL8GH6i5PLmta/zCCRSdecSQiFXw=
X-Google-Smtp-Source: AGHT+IEtjCdVroZaUVcNGRtUK5AuBGREUnts03x3VGGBxpKu0QVXWygNx3tOfnTDzg2xubxhKgFDyA==
X-Received: by 2002:a05:6e02:20c2:b0:36d:9ec4:54fb with SMTP id e9e14a558f8ab-371f674c2fbmr37234675ab.0.1716420986020;
        Wed, 22 May 2024 16:36:26 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-36dc81b6747sm32595975ab.11.2024.05.22.16.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 16:36:25 -0700 (PDT)
Message-ID: <29c1f444-6c58-48b2-90b7-a17ca22ad309@linuxfoundation.org>
Date: Wed, 22 May 2024 17:36:24 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/68] Define _GNU_SOURCE for sources using
To: patchwork-bot+linux-riscv@kernel.org, Edward Liaw <edliaw@google.com>
Cc: linux-riscv@lists.infradead.org, shuah@kernel.org, mic@digikod.net,
 gnoack@google.com, brauner@kernel.org, richardcochran@gmail.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
 hawk@kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@android.com,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240522005913.3540131-1-edliaw@google.com>
 <171642074340.9409.18366005588959820799.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <171642074340.9409.18366005588959820799.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/24 17:32, patchwork-bot+linux-riscv@kernel.org wrote:
> Hello:
> 
> This series was applied to riscv/linux.git (fixes)
> by Tejun Heo <tj@kernel.org>:
> 
> On Wed, 22 May 2024 00:56:46 +0000 you wrote:
>> Centralizes the definition of _GNU_SOURCE into KHDR_INCLUDES and removes
>> redefinitions of _GNU_SOURCE from source code.
>>
>> 809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
>> asprintf into kselftest_harness.h, which is a GNU extension and needs
>> _GNU_SOURCE to either be defined prior to including headers or with the
>> -D_GNU_SOURCE flag passed to the compiler.

Hi Tejun,

Please don't. We determined this series is no longer necessary.

With the patch that Andrew applied:
https://lore.kernel.org/all/20240519213733.2AE81C32781@smtp.kernel.org/
make its way to Linus? As you say that's a much simpler fix.

thanks,
-- Shuah



