Return-Path: <linux-kernel+bounces-422910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 741149D9FD1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 00:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5C4BB25157
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 23:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6861D95A9;
	Tue, 26 Nov 2024 23:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IUu5Kvny"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADAC1DFE30
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 23:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732664727; cv=none; b=cQh8BZy9VPY76QHMZgdXlyyuxn8HPMxan8htPP8qvh29xlHBJv/nyI1mQXdWomspDt3E2F7MRRTdK0Y0DLpuA4rhZSwjyKf18jqk1nL/oKtzp8VfwkC4Gq15Jbq3+nJQtAP7535spiGfqq8MTjf3rrmVHJ1n2ZL9PlXDplJmASI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732664727; c=relaxed/simple;
	bh=VXT7wVN1rHLhIih/1QX0aBa8H8bgdCdyGTEgIzvjv84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FPwUBvnDSffURENeUucJcEtJCH6w2uuFPxwjtCHHWUqfax7pIOGQ4vvSBIlp8G/MsNXVs5GPPHjE/ZKpdHp93NMqG1mHuYBDnXpYV5VrdRYtl9KcdwixWRr3+Dx6UPEqQpk6cSSopq/jfSaPIhDJ+1p/4SUuzQM8TjZ6VnShphY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IUu5Kvny; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-382610c7116so3388152f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 15:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732664722; x=1733269522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cTIQDR6gO8Gy9gR3S1W7hO6fiHoSmnxEdBfKcw5IXcY=;
        b=IUu5KvnykpEN5he7ICWm0l3EJpE8/4nD46YhWU0Hfh7/i3UoASQzhD9I6WP04eJ3s6
         8GkfuZbXWL4D0fEm2HevL7C98r1pJUtdMn22kwuurNYeTO8qFFyEMrOS4e3Yl3Jm5L0K
         bEuzq6D42xrQ3tf7cR30sCh2SGRzydbQjQenLEgwKOtPU+PivgDDlrnJLAHdanQGx5Tt
         J/AhgvYc/AWUYFSSF3NsB7JtnWkn/nTaaLqpMba7mpxqB6oCCKZFMqS/VYJeaYALVAxu
         p9iQtFiVigKptAVFH/RpHhLXE6EcPlmU0EkS1Ai1wA9NaVfXbd82En+KdMRRCvebE+2+
         wkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732664722; x=1733269522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cTIQDR6gO8Gy9gR3S1W7hO6fiHoSmnxEdBfKcw5IXcY=;
        b=cMBWip09DwddUg4QIo1LmDtQE+H4OZ4iGsc9vpWfhsNYvCdYsqGezNGfFo1ltpK4Zr
         09tn0kyws/xlNcl51T8WC997yI5ZPiDEd4bhrmrzbZ2KamiDs8CVmwM2ZCb6rFpizqvm
         IBuAkt4ryERPWgOlHOYxssP19G6BNAFLIHZ4W4R6a+orkO+/nZAeYPgJpRfzAr/P2WU9
         Kt5tiCaAl3g9Gwrx/OpebzElAbcsCZTC9vpLTVooEYeDVRGLI+3coaLqwLhnpY2Ithpd
         hznPcZIbknSZZPQ6QRURSo3V3L6bo9sXlKgjQpoYi0Y9LpOWoolKvIUSqOIgqjcdu01X
         VThA==
X-Forwarded-Encrypted: i=1; AJvYcCX0t0QzVHjReQvnxk9pamq5CTZDsgicjK3wQzwz85ezm3xvMdsSmHdEp2yvhhbeXzI/8nfxgI/UXUqn1DY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkrWqRkDc3umlVHjuJRI2uAjlscx20Xh2zDbQAeFez5R49SxOy
	Kt74a1uNjukm0udfFWb/kl6lnBZPueiVjyr4IkRMOa6odYsr37ed0utPFLb8BVQ=
X-Gm-Gg: ASbGncs7u6SaQ+BkXLFnj3LE0v1bYDCaj6x+3haAcDR4oLeiowCbA+80cxnQqDY1bm7
	f9k17EQcA8QRV9kBe4N+VPy0m9+V8Z1yeadk75wl6f3DKgusmgXCtAf7VnJs0BHN/pLob25unXq
	cqqHgPcNX30skVzOoJm8aRQ1tfCacI3BQcpI4fyU/VadsGpxviekD3vjNfMGnsD+fwnQQm1Nahu
	c5z+FWrzpFOKsKd2m1ac4am4GlXICU1zVnzwn93ONZK48b0mSNipuBtJhxgnec=
X-Google-Smtp-Source: AGHT+IGgTq9G93zWAnGOsfichoeaSKEevf+t6zRWeozKkzcjQJicK+VxCL2bOFNMReJ5cRUfsxifbA==
X-Received: by 2002:a05:6000:2c6:b0:382:4a69:ae0e with SMTP id ffacd0b85a97d-385c6eb697cmr583035f8f.14.1732664722646;
        Tue, 26 Nov 2024 15:45:22 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fafeceesm14595766f8f.37.2024.11.26.15.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 15:45:22 -0800 (PST)
Message-ID: <faae3508-5dce-4c38-a344-1d35186e0909@linaro.org>
Date: Tue, 26 Nov 2024 23:45:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clk: qcom: gdsc: Add pm_runtime hooks
To: Bjorn Andersson <andersson@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241118-b4-linux-next-24-11-18-clock-multiple-power-domains-v1-0-b7a2bd82ba37@linaro.org>
 <20241118-b4-linux-next-24-11-18-clock-multiple-power-domains-v1-2-b7a2bd82ba37@linaro.org>
 <zhhna2wni4yqhnc2tqfc2ugril3h4kzbyr3ix6vpwrgghwytfa@kjfpff5zdl4z>
 <7a52ca1f-303e-44ae-b750-6aaa521516c3@linaro.org>
 <ava6dkmz5g725skafuqyb4rly3qna5z4bhfmrqgogcmdcubzf3@eu4odajw6e6d>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <ava6dkmz5g725skafuqyb4rly3qna5z4bhfmrqgogcmdcubzf3@eu4odajw6e6d>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/11/2024 17:23, Bjorn Andersson wrote:
>> I'm finding with this patch reverted but, keeping the first patch that it
>> pretty much works as you'd want with the caveat that gdsc_register ->
>> gdsc_en -> gdsc_toggle fails the first time.
>>
> Can you clarify that call graph for me? 

Ah no my apologies, that wasn't the call graph I realised about 2 
seconds after sending the mail and never corrected the record.

Please see the v3 of this series instead.

https://lore.kernel.org/lkml/20241126-b4-linux-next-24-11-18-clock-multiple-power-domains-v3-0-836dad33521a@linaro.org/

---
bod



