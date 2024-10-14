Return-Path: <linux-kernel+bounces-364872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7604499DA6A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32693282512
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA141D9A7F;
	Mon, 14 Oct 2024 23:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GL0I0fTR"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759921D9A5B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 23:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728950256; cv=none; b=upVacY/TJK519CZVNH780qMjUO07Fzf4nWTPG7S17syXT8e/hjXPEt8/1DmTLXOOO2N2AoWzKbiidf/NsLK0gFSCtqkuouNDGvo3Ldng8uZRZd3c2SUwaOAyJkCsb7zkVL5cyyExkYsxikmLnr3LaEB/KzV+4blg7rpbr4wpmVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728950256; c=relaxed/simple;
	bh=kX4pqCrBK2GblSEDcTU5YKeWhCLo2dn6mQFQ8uOZoV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvDhOZDkssv1U7pTLTfldcwQV9gHD0o/QjQtCtGCY9cm+yxvoSV3NjDkswvQFzeRWcZyF4E9EELtSE3NGO7TKfRAhMGoTS9KBkxjQm/10co9FoGlKCzyLESAU/6R2X14r0TWzTA9RtZc4z1eo+odr7WxHzuznWCuHkcYk8j/nmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GL0I0fTR; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-8354c496c90so159771639f.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 16:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728950253; x=1729555053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1PKCpI9LOOmwcDFFAV3Q3WPcNRWD/uWDLb+81DiVqOg=;
        b=GL0I0fTRc1O+Ueul+L+qosfHmt4i9W/7csSBM49WhloeM9rIU3dDMeiN0AGcU5TtQg
         xVBJNSuUdx1sRATj5zvZ0jFSs29xl/kUD+e0y2EpTl9dN6KQ1WoLJawV0YNUX3jumi4m
         /iiM/FKzuUVlXvNts17g8GvdsLOuJvvBJhYw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728950253; x=1729555053;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1PKCpI9LOOmwcDFFAV3Q3WPcNRWD/uWDLb+81DiVqOg=;
        b=XSW2LEobDCkCgNiy6PocvZnH12cKjwcrj/50f9pvUV+5JPlRzzemBf5Zdo+Wgqc6ZV
         t9lwOypgZU9Fz0X8/tiySoD1doXqjIZVsFgo2eMqI+0Q6OXnYlsVNnCQ5KwK4Uf6al5L
         W/Maxp0cajBSIdaMMyA6TnmWahOWKpJDxHaSP9isS26H7Mt87asCz5sINmOhTMx3vWm2
         rG226IWw4+oQZcTU6uWhxInQSrGok8VA/Lf/lSso+mNC9OzyiQRvWd2WKlgtf9CFdDpK
         awS1UxP9/oa1WwMQowYYmtkXd5L+tMTP8OgqEYY1YOlaWHhfYjVJjrH8VgstS6yiQAZy
         HsZA==
X-Forwarded-Encrypted: i=1; AJvYcCU3oxHBJ+/wgTjUtu9QmwZXeOyMwVhBHE8U0Twk5WRFTIxIFTzXySwkSp9HdqyLZQIKt+A9urZvM96avA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZrTEFuuuBMr5mwdwJUm1UivscctmmGc0cNHyy6H5G2+xcfgSv
	cY615XZoTb74G0pDvxxrxUhHj09l3Bfu9KUukNTbmgvMkvRJCOFKFuo+s294qaI=
X-Google-Smtp-Source: AGHT+IH0xfL3ktXtZPj3uGodNBsuzJgI8pNk8IlXd2ozjWhgU67nKyr9i4FfLS9KOvhHLZD6fluEQA==
X-Received: by 2002:a05:6e02:18cd:b0:3a0:a71b:75e5 with SMTP id e9e14a558f8ab-3a3bcdb421amr71034295ab.7.1728950253468;
        Mon, 14 Oct 2024 16:57:33 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbecc6a89asm45032173.173.2024.10.14.16.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 16:57:33 -0700 (PDT)
Message-ID: <d0143933-5619-4824-ba83-85274e222479@linuxfoundation.org>
Date: Mon, 14 Oct 2024 17:57:31 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] selftests: tc-testing: Fixed Typo error
To: Karan Sanghavi <karansanghvi98@gmail.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Karan Sanghavi <karansanghvi98@gamil.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <Zw1LvrSdnl5bS-uS@Emma>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <Zw1LvrSdnl5bS-uS@Emma>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/24 10:50, Karan Sanghavi wrote:
> This commit combines two fixes for typographical errors
> in the "name" fields of the JSON objects with IDs
> "4319" and "4341" in the tc-testing selftests.
> For the files tc-tests/filters/cgroup.json and
> /tc-tests/filters/flow.json.
> 

This is not the correct way to write change logs. There is no
need to mention how two commits are combines.

State the problem and sya what this patch does e.g:
"Fix spelling errors in cgroup.json and flow.json"

> v2:
> - Combine two earlier patches into one
> - Links to v1 of each patch
>    [1] https://lore.kernel.org/all/Zqp9asVA-q_OzDP-@Emma/
>    [2] https://lore.kernel.org/all/Zqp92oXa9joXk4T9@Emma/
> 
> 
> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> ---
>   tools/testing/selftests/tc-testing/tc-tests/filters/cgroup.json | 2 +-
>   tools/testing/selftests/tc-testing/tc-tests/filters/flow.json   | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/cgroup.json b/tools/testing/selftests/tc-testing/tc-tests/filters/cgroup.json
> index 03723cf84..6897ff5ad 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/filters/cgroup.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/filters/cgroup.json
> @@ -1189,7 +1189,7 @@
>       },
>       {
>           "id": "4319",
> -        "name": "Replace cgroup filter with diffferent match",
> +        "name": "Replace cgroup filter with different match",
>           "category": [
>               "filter",
>               "cgroup"
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json b/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json
> index 58189327f..996448afe 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json
> @@ -507,7 +507,7 @@
>       },
>       {
>           "id": "4341",
> -        "name": "Add flow filter with muliple ops",
> +        "name": "Add flow filter with multiple ops",
>           "category": [
>               "filter",
>               "flow"

thanks,
-- Shuah

