Return-Path: <linux-kernel+bounces-282433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7E494E3DD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 01:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5C528187F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 23:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB2C165F01;
	Sun, 11 Aug 2024 23:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VbR1ij9V"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8011547D6
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 23:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723419355; cv=none; b=VrN9LJCAvRVH7IcFoBvoN+IXUXTOde9oHCHRjViFTCHNR4CFkhlA6tqeb0SWVeFzbpNip49W8EmhrHYoVtEewIV3utkvUXTcUj3gNg9M6RO8vbLESBML+JeVfMLLzhTnxrf3zdQg4PEyZHmZi+VTHQtWSqXC6qG0vnDX2d9by00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723419355; c=relaxed/simple;
	bh=yb0ny0zY4VuXPLTCQZNYbnK3oc52429hwYQFgNULx1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yij8zZQ3wHZiufpTWwDKJUrZr5DfvdTBJSXwlBJl4x2Op/SmzXCpf5t/oy5UfM+hDLCva06RmqyvKG9QAdZjsyUPsqF4IRRxSusWOxJ2CyR5bmNvhWbs70kn42rcND5J6mFdUxBrVMjS8Tc6eg4pbjYr6ufvNRVqMSNG9K0FbEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VbR1ij9V; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d2a6e31f1so173234b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 16:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723419352; x=1724024152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hO37jwTmuSgE1Z4eVGpKU3tnYdMedGjB31Oft97scek=;
        b=VbR1ij9VvJ5R1Xp+0Tf+tjuWY9r6cJUsaJ3mU+3cOGpyd/gO5p4JaUOZ2NkDEcINUX
         7XlXByUu6nyNtPM29yVEAIf3B3sXR0IakfKZxiwrmvaeg/9dcEo8QXjNGNtvWCJMS+We
         izk2mXgvfdJjgdt7neJkrQLvIllwO7guC3FH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723419352; x=1724024152;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hO37jwTmuSgE1Z4eVGpKU3tnYdMedGjB31Oft97scek=;
        b=s4/g+Lx9bKlM/jse7pvdHEopN28q/wjJIClMU61KTMDQfNCFUVWK1B31WKPbXEJkZ5
         tJ5yV0XnlZO2bWNAb6yMqMvIFaJKidJXCdavMzCYB4/F1qCNJy1BLhh/EgYtBJzGj+op
         jh0839qawmXb3Roaw2slBNjpyNwOTLngEy517A5m2t17xLrXH0FEpirDJxMBoIvAfUSy
         CbsuGQHYd9et1A5rRaPAY4KUrnVkONE20Cc3gCwYxsvuHZv4brKOVXjkIJAmWWFl07o9
         w8CYJSPYj/ytkM55OFg6OdClOLYPXPr5v11IGEZpcVKqz15FtgazBQgh/V35/akILQlz
         Svgw==
X-Forwarded-Encrypted: i=1; AJvYcCXc3RylV9pPCjvahbgKmKbD9Li9RlEeibQz9L4HWF7ikyVS0ugJM7PrZOe9c85Zj3Q2zGGD2HfKcAfNd+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj+DTpSG73FtMToaeOd2L2wQH5TIaUMKV9SrGhpisBmvkkftex
	4VgZx2LQ2IJGVpHqhgjAybsicIE5CejMatQMSmWCE1yRZOmvQUKEQs54wy+gx0+bxyn0jQD1Tt7
	KEy8=
X-Google-Smtp-Source: AGHT+IED5VVnpv8Jj/o2aNdwI2tSUckratzTwSCTsE+zxtRcpvo79CBOM3dI2QieB5Cx1UViO5mYtg==
X-Received: by 2002:a05:6a00:9149:b0:706:aadc:b0a7 with SMTP id d2e1a72fcca58-710dc687057mr5239855b3a.1.1723419352538;
        Sun, 11 Aug 2024 16:35:52 -0700 (PDT)
Received: from [172.31.140.29] (softbank126051159161.bbtec.net. [126.51.159.161])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a43948sm2840815b3a.122.2024.08.11.16.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 16:35:51 -0700 (PDT)
Message-ID: <de8abe69-3735-4ffc-9cc2-21a167aab44f@linuxfoundation.org>
Date: Sun, 11 Aug 2024 17:35:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests: rust: config: disable GCC_PLUGINS
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Anders Roxell <anders.roxell@linaro.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
 shuah@kernel.org, rust-for-linux@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240802124536.2905797-1-anders.roxell@linaro.org>
 <20240802124536.2905797-2-anders.roxell@linaro.org>
 <CANiq72kb9mDd0xndGFnMQXP4Hg-GE91eQ07yYiQW1HwWv75Qtw@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CANiq72kb9mDd0xndGFnMQXP4Hg-GE91eQ07yYiQW1HwWv75Qtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/10/24 04:34, Miguel Ojeda wrote:
> On Fri, Aug 2, 2024 at 2:45 PM Anders Roxell <anders.roxell@linaro.org> wrote:
>>
>> CONFIG_RUST depends on !CONFIG_GCC_PLUGINS. Disable CONFIG_GCC_PLUGINS
>> in rust/config file to make sure it doesn't get enabled.
>>
>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> 
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> 
> When https://lore.kernel.org/rust-for-linux/20240731125615.3368813-1-neal@gompa.dev/
> goes in, this could also be relaxed.
> 
> Thanks!
> 
> Cheers,
> Miguel

Applied to linux-kselftest next for Linux 6.12-rc1.

thanks,
-- Shuah

