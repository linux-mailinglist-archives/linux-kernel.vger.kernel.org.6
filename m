Return-Path: <linux-kernel+bounces-386248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE87C9B40F8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 04:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85AA62837B7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 03:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1551F4265;
	Tue, 29 Oct 2024 03:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FXJjDsay"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856F3FC0B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730172138; cv=none; b=W5be3oCI2Btg5iEeT67GBFIT6oHwcnnFg5X9v9qclJrZQ2DIcwYXhvx2zjFfnT1ARrvsHUORteesxvy2viQSkR77MNLR5jwoeeBE67XL+x/0KAx86IQ0V90lx+krgUhx1+kbE432ich4f0gi0ZhcdD5Y5Qn594q73UkS3oNlTo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730172138; c=relaxed/simple;
	bh=vDaqNIx014rOd3WGYP3FU8767BW0UayQOiIqJPsF8Ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sa3FKr43w7j1aNmozhpw20pYe2SJ46mb16ZnuP68kDsNGpbHdvtd9sLk0w0KAzs9JySbWgn+BiGahGk8hGxBAWrK+B9WFkcT/StCBhgEFaH8AFpdeKBogfrVjJRXDxyANQil8iKVlH6DZ2+420ifuIgNwqR5FNYueFAa2KmhGqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FXJjDsay; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea8de14848so2662215a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 20:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730172136; x=1730776936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ago6CCUz4KeIAm6BunmfmSUFaWYM1LlpUdAhiuiu0fM=;
        b=FXJjDsayDrgr+nIObNHoJgctKgpCtliDjQ52IyGreV1BtW0nw2KlfEO8hIiYdwXsDg
         1cAzcSXfd0Ex39sSI7Xaer1am4R9NSroFUWNgU+rVq/7wsirJqX1QbRv/Nj4J0HAf/70
         2HOAf1JkeJ2N6a4a6/yYXyqgUZ1gSecikwcSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730172136; x=1730776936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ago6CCUz4KeIAm6BunmfmSUFaWYM1LlpUdAhiuiu0fM=;
        b=J/5QmLRhx+KAZtqvnkdU/NDa5WFrmf1IG3fl7HXluUMu2ecy9OBGZI7DsOhBdbj7PL
         qr+qvVbxRL8NL07k5yFzWCkkPrgKftSvf71BLtbWOt5eqdknk38uc7vWUlcaufDm4x2+
         WYV3AMIbstLnGzFUAaH6SgAC+yR/8jjmIJjexeyVUIm5euZDv0bpbyHXGcEla1dyXooi
         DrnrycNRDcjNiVyXqYFGoenK8p3Cx4UacJAlEwCEjVgNnDCKVw2tj0sO1YLMq7MIBJCV
         4oZP3zIa3imZRVVcXslJfFN25hK+bdjPBA5KxxEIvRy/MXnvU0QaCcVQ3p7fd+Ch4Bt1
         J0pw==
X-Forwarded-Encrypted: i=1; AJvYcCWjmule4yWeqLaZ9yz/WKd7+nhX4Saww0nMZuE2yqNntOyYVjNPLMRCUW/1mwsWvVSeHcXWL+FTxFzzz5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBEbCOEfvf4I+LFo86OHuBFkcnRrkjjduogRFPdSLqV0PoGjZm
	SEmfGhqji5usRpVcNQhJIrPZlDBPTc9y2InVKjz5NXbC5AotfdHHAsTFm2J1edU=
X-Google-Smtp-Source: AGHT+IEhOXh4vbQjaBSmOMb2IfMnms9z1xgawCts+x85ZseWyhXJSBcPSK69ypBBm9QEhhqMfKNwog==
X-Received: by 2002:a05:6a21:6b86:b0:1cf:2d52:415e with SMTP id adf61e73a8af0-1d9a84da03cmr13844312637.36.1730172135973;
        Mon, 28 Oct 2024 20:22:15 -0700 (PDT)
Received: from [10.200.3.216] (p99249-ipoefx.ipoe.ocn.ne.jp. [153.246.134.248])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc89f2a2fsm6562114a12.73.2024.10.28.20.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 20:22:15 -0700 (PDT)
Message-ID: <2bd7b521-0351-46e1-9480-2223d79e6dbb@linuxfoundation.org>
Date: Mon, 28 Oct 2024 21:22:10 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] selftests/intel_pstate: fix arithmetic expression and
 cpupower
To: Alessandro Zanni <alessandro.zanni87@gmail.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 anupnewsmail@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1730141362.git.alessandro.zanni87@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <cover.1730141362.git.alessandro.zanni87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/24 13:08, Alessandro Zanni wrote:
> Address issues related to arithmetic expression compatibility and
> cpupower operand expected.
> 
> Command to test:
> 	make kselftest TARGETS=intel_pstate
> 
> Alessandro Zanni (2):
>    selftests/intel_pstate: fix operand expected
>    selftests/intel_pstate: cpupower command not found
> 
>   tools/testing/selftests/intel_pstate/run.sh | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 

Thank you. Applied fixing the short logs for next rc.

thanks,
-- Shuah


