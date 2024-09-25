Return-Path: <linux-kernel+bounces-338056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9E49852D8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 919B5B21155
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 06:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CACF155C98;
	Wed, 25 Sep 2024 06:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bahQ+can"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2732E155C95
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 06:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727245126; cv=none; b=nAw18Ukh46R7iuxv/nyVc0szKCTggCtIQF/Iq6+NfxsAQ/MmeMxmJaj6HGbjaOjeI/GsDFetUbPCWQ5SmXwW3o3+k2UTjw1Chr0KhvdrZekPvRQoruntZVOmZWNN9G/5KfBXr+AsPA3WjDtE779moJoR4PA4LrbyqhojDFeYx6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727245126; c=relaxed/simple;
	bh=4PFi3GrWcYBdSSW0hgzBkVDs0dXzs21wTMmchnPoW+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQiBtwwXYxE4LNL84M/0FJ3Pg6mdZaDdUy75gzFK8R0za7/aQjlOJQDBuQqmocNSEhpJxL/iYXInKZ2LFgfk2Z50yq2/sMbwC4JQ6uBmefItQZCHa7U0a0Zcn8XDvNIcxwcMUNfnQrIWlb+42DXn597ZhmpsPY1SbF3VzRwnj+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bahQ+can; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2068a7c9286so63599095ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 23:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727245124; x=1727849924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gAfB/c2dUK7Tp4TizuYkDvXRM6wc04Km7rfihTnNlVI=;
        b=bahQ+canDxfoqCvyVVBxpy2yDQTbPoEIGfwsErvWKUcaG0DhTb9u+YhB57wl3rOg7i
         hEkYGbZG8KnbFZFgJ2FrjJdiLkvGdi/OyLhkF0B3W8WmRTMAcnhiX4By6yTAG2oww8Qx
         FxYFcFn8EKdL9+/r1Z46NGQem1hSHkOjcjGZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727245124; x=1727849924;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gAfB/c2dUK7Tp4TizuYkDvXRM6wc04Km7rfihTnNlVI=;
        b=gbeqre9Hw9VBYk5ZTNyHofMtItlmPYncXlxbE26gamhzHzfce62fsyr6BpadpM+oA7
         ltpMgp0QCPsdKRGhK3RmpYHslzx8QC3r9JL9UPSdNRT+UjgZLO1dtTWtpak3vgIbcwGi
         /+sHscUeWh3kP7RfuJmQF0V9XcGk0DYufu2WdqsjP1uu+dFgEsQczvDZ5RG3si1wPVET
         A1JK7vR9/nhXVaihuiIgu/kcIwPmFSwN4FbFC1RyAdci/KJWE7Jp2KvT0bwdID00XwaA
         3vqOKZTp3tiLYPvuWgB5AhL6x26oAu9LNKxl1D7R9Ngp4JRr1agSFy7nqlg1ToOGMs3K
         MHXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZneUfmSRdnDrmAKYMr95pz8pzgHxI/Ua9IUykiOlrcw1PFIuc2i8PcEPSCnE4djUTPDFfbBJp5bQUZIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0/fUrh6USB2OOBHA7EhOvnPruYk9jH3zzqhvFUAZJm4CcnaWv
	2wzNY7f1K2qSbioEa2yOv1NuQOWqR82jyGptpXsnvcFpTj/a2BbzEcijgSJxDA==
X-Google-Smtp-Source: AGHT+IEdnYbq5bAx4Sg9X+VZO3Xo5eBYOK7WziCE8Ch3Kc7BECkSDi4+tCYZhgtuKZ8+gFm9JzzLAw==
X-Received: by 2002:a17:90a:2dc6:b0:2c8:f3b7:ec45 with SMTP id 98e67ed59e1d1-2e06afe8f6fmr1835727a91.36.1727245124474;
        Tue, 24 Sep 2024 23:18:44 -0700 (PDT)
Received: from ?IPV6:2401:fa00:61:204:5d35:3dbe:2256:3e42? ([2401:fa00:61:204:5d35:3dbe:2256:3e42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1ae741sm665351a91.15.2024.09.24.23.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 23:18:44 -0700 (PDT)
Message-ID: <c9f7042b-1e61-4289-9ef9-ea15bd7e9847@chromium.org>
Date: Wed, 25 Sep 2024 11:48:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: display: mediatek: dpi: Add power
 domain for MT8183
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: chunkuang.hu@kernel.org, krzk+dt@kernel.org, ck.hu@mediatek.com,
 robh@kernel.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240919112152.2829765-1-rohiagar@chromium.org>
 <20240919112152.2829765-2-rohiagar@chromium.org>
 <4djlcabqjkq7thbxadjbbi6oumybnyzv7biwawke46ctjccwye@rmqougrj6pl2>
Content-Language: en-US
From: Rohit Agarwal <rohiagar@chromium.org>
In-Reply-To: <4djlcabqjkq7thbxadjbbi6oumybnyzv7biwawke46ctjccwye@rmqougrj6pl2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 24/09/24 2:41 PM, Krzysztof Kozlowski wrote:
> On Thu, Sep 19, 2024 at 11:21:51AM +0000, Rohit Agarwal wrote:
>> Add power domain binding to the mediatek DPI controller
> That's DPI controller, how can you add here power domain binding?
I think, I messed up in the commit message. I wanted to add a missing 
compatible string
in both the patches.
Will update the commit messages in both the patches.

Thanks,
Rohit.
>
>> for MT8183 that already had the property in DT.
> Best regards,
> Krzysztof
>

