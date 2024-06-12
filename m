Return-Path: <linux-kernel+bounces-210951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F140904AFE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4EC12850D6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CE636124;
	Wed, 12 Jun 2024 05:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWtCrySh"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426F779D8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 05:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718170871; cv=none; b=EMANWPfw/LBTw2PgDLSdkYWZRt1Xh5F4njFTQnjhJpm3ZZFYvooFxNjsxf8J0Z7ZQZ1n6zmkdLxvUXePIP4bYyUiiB/yKNXtQ+2tpMTDAXXQkd4pXHw8QpAE9RY+NJQV0UR6lNvs4mQwHPWz6jCpbwX2isPvtWviqKBxrwswil4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718170871; c=relaxed/simple;
	bh=N2qeEuLIeQ/Sboky+rnEg8RxtodJVVIk8kOoJLibkBg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=u2Ifbs0pOSt3PY4xXObzRnNOQq4+hNXQBX30pEwccSuYO8sNYi34h61Id2YblyzzImPTaXmC7AGFxcuZ+rzvhPU4336otS04O+9jvZ84A9WDhj6ivxbx6toQkQ6TLJU+oG/JMl74lPvc7c5HDPdTa4AuthJ9eN2pYJGaN5BHQ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWtCrySh; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6f408b8037so16242466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 22:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718170868; x=1718775668; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKVvOJDRBmXEZZQWgGpt7X0kHZm5kqDS8w/6wm0mBr4=;
        b=RWtCryShM9qf9COQ1pgWTStsnh5gFYk0xOsPO0Nmma5ziGu4HRnOrWuykZ6bEQyMbc
         4oaM6gHsgAfwRunIVm7NfcoKmQ53vtzgJXqhVMW0PInWdom1kQ4kddNUbjZs5kAS27TV
         1/u351L4oLLQq5JTjlq9gXB4rlamP3SOj7RN9cUzaw3g/YyxLQFT6YHdsrQ2rdw963kO
         i5Cd+hg0PLMVckjozKMqJyFrJGpjEumkRPMhy2RstDjHls8VBEbS/Rsc6aQcf99hOcUB
         OwDq8jUo4okQuL2qOHfTzfIbC28bFMGl2Vvgkp5C1AwO624DalSJbz5iGeY2bxr7sNiw
         jjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718170868; x=1718775668;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sKVvOJDRBmXEZZQWgGpt7X0kHZm5kqDS8w/6wm0mBr4=;
        b=HXCUGlxe6qzYjgQPHW62tVZ2tV9HbrV2ksQlXGZj9Vwpb526sT4k3zUyhDbBhnXLgz
         Gs+4/M2rFS+V2OGuQwaYqGRZ+y+KkaL0vH0bDEXX21WsXf1OyfkIMbB1EyITb4LEDHvG
         p8Gp+3Hp6LlFBqkHITRYs1byob+a1CmmXr3q8jfmJtZM3mHlstk/2hNq0swzh6jNDPdP
         LeMc5ZDp2ferM6UJoeOVaiZrBov/8aicY3w2LN/nxABZDbfLKqNPByv0e9CTSFL8rBzD
         2+L9b0i1alaBkyTskZLv1g8oqbiDPmKictoISuFVyuhphlXTmQdoCvXC9cvsFpvOEqnV
         CncQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBO1wicDle7RZ/joJqSqlqQl6GFqwMF2h2peYh0wlsk/u1zC0UvF8YRjDa/Fr49laDJYC7ZrqVDZisMOcRFQHVdoqs+uviOJXpW7k6
X-Gm-Message-State: AOJu0YwtYULXxnurEatntQF4misQDhjBYWg28grjD9NawMUUtQTBi56o
	wDfKrPYTnB/rt5ZNIcmEWZ55TyCVEW19suhNBcGXlhP0e284kvQC
X-Google-Smtp-Source: AGHT+IEMKTWRaBB1/ku+YH/D2e753+srFdxu59n9NNVoFvu7NyD67xXsC5R0sbrtRdeFTc4/osfwOg==
X-Received: by 2002:a17:906:4ad0:b0:a6f:4a8d:1db with SMTP id a640c23a62f3a-a6f4a8d0254mr17225266b.4.1718170868261;
        Tue, 11 Jun 2024 22:41:08 -0700 (PDT)
Received: from [192.168.0.101] (p57935a9b.dip0.t-ipconnect.de. [87.147.90.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80728be9sm838049066b.199.2024.06.11.22.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 22:41:07 -0700 (PDT)
Message-ID: <fcf77c98-0ee5-45ce-a17f-d68dfba9f7ee@gmail.com>
Date: Wed, 12 Jun 2024 07:41:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Teddy Engel <engel.teddy@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: Re: [PATCH] staging: vt6656: Fix checkpatch unnecessary parentheses
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Remove unnecessary parentheses - according to checkpatch.pl strict

Signed-off-by: Teddy Engel <engel.teddy@gmail.com>


Hi Teddy,

your patch creates a checkpatch warning:
WARNING: A patch subject line should describe the change not the tool 
that found it

The next thing that worries me is that the fix does not increase the
readability of the code for me. I think overview is better with
brackets.

I also think that you are doing two things at a time. You are changing
the TODO file and the brackets.

I would change only the TODO file.

Thanks for your support.

Bye Philipp

