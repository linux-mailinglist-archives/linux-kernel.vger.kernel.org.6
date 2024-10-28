Return-Path: <linux-kernel+bounces-384174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FDA9B253C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 840B82814CF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 06:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555D318E049;
	Mon, 28 Oct 2024 06:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GOx5OKFM"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B7C18DF88
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 06:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730096749; cv=none; b=Fo81pomW/4CPG+/5p2oGy7drnVtdyAJ1f/02rY2KMICASnDWTvXyuZdEMOM89qyNOY+F5AfGSa4u9GhzAm/BcJ5Pjzzh3T12KplKN1FMttfeg1CI/8m2uGcjvfN7Tuuz6B7Ypcdi4i1MsmspaVu1mUPeYdlp9bWZhcLHtMOTw+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730096749; c=relaxed/simple;
	bh=Ej3AeKhS5/abexGCtjpcoEfZrYldhNDzcJtRJE3vgls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WSNY1Gag1jtHrYG/H0ZnC9XWAfpFCtNjxlBdNI5fpPTjDQptJdkNNL8teUiqWaEzV9sNYw4XeTIzjfe3HUdQsDSn7URPlGwLr1cvzu+ZZ0Io7pzbfxPXN0bD2DCg2BiXZeMvtI8QvJfy4oXScXeuE+3Gjdlb+cX4siDuujwQZPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GOx5OKFM; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cdda5cfb6so36321625ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 23:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730096747; x=1730701547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8fAlQccG7+nYMAb+dll6jP8YdzAnpJv1Fs1IZeu8SYo=;
        b=GOx5OKFMZPMVi9D7MFVYXETrbwuuhZ1jzwPLI8XmE8Ia+b3O7j6iDlR4wIA9nTC7dD
         30vLop3pq9fqvoZ+u94SKqm3u1WmQPm3MNkR5e8RpLYQU+GbSGr7pphq/ckxoe0bkznB
         4EbrpD+UqcBTN7s9xDs96WqrHWZO/Y2pHlSD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730096747; x=1730701547;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8fAlQccG7+nYMAb+dll6jP8YdzAnpJv1Fs1IZeu8SYo=;
        b=fJCvvZX5MlYonzc7M49ss4T5fCVVsEMPKm/swNVmomOd0z1CFQ814HUvzrsAOBIpWR
         anOSlBiM1nKnZK9mrAOg4RhorYh7JZqLBXdZEsrMXKh1+VISsDbkW1osM6IiClGcaWGl
         sk2u2XOKuSxIrUWHV3RIGoDK4xUxuTTpwrBxjlAnfrX9Y7GNqDUjj9fG0O09vQPr04WI
         Xa1sA+JXS/IRPLI6GZv2vSQZvpH2s4hF12YwOHOF46su5aqGPWe6I0Hd1aDkYAvjB1LF
         3rOK9y+eijNI7oIPGdWfh6a5aEsiJEZR/q8MZll5Uxa0XxWTJjdKpkXwRnhLyHqwHH1W
         MI0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKDHy2eGb+Khou3f+rUo/MkkApBnVgVLeoyJDr59pxvIlHVGPZr4cDasxrc9ZQoYxxPT0GX3mu57L8atQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyrTnJFHKDCRpcU/RS6qVRSvPah511X2dj0t9v8VEcVQKPam4V
	RF3Uk8yxcxMRnJ5PkmjLxAev/hOu69YlvlPBBHz5DqAx6SpXqidvv84EH54A2V8=
X-Google-Smtp-Source: AGHT+IFBoCs2QY2GYSDMjnCjHu0aK68+gTisee8FtRtpwIHjDkAm+Jokl2+buZlLblNszHpOkHGD/A==
X-Received: by 2002:a17:902:ecc9:b0:20c:5cdd:aa7 with SMTP id d9443c01a7336-210c6cd3ba7mr108520635ad.43.1730096747327;
        Sun, 27 Oct 2024 23:25:47 -0700 (PDT)
Received: from [10.200.3.216] (fs96f9c361.tkyc007.ap.nuro.jp. [150.249.195.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc04b567sm43507695ad.274.2024.10.27.23.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2024 23:25:46 -0700 (PDT)
Message-ID: <19579b1c-0a9b-4c72-be00-44871dd37b9a@linuxfoundation.org>
Date: Mon, 28 Oct 2024 00:25:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next 1/3] selftests/watchdog: add count parameter for
 watchdog-test
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Cc: "shuah@kernel.org" <shuah@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241025013933.6516-1-lizhijian@fujitsu.com>
 <c2cae7a7-1a0d-48ef-9b8f-8d2436532ea7@linuxfoundation.org>
 <0861d73d-4fd9-4118-91c8-5a619c7d7ca0@fujitsu.com>
 <e907e67d-9116-4dd2-9b61-f93191737de6@linuxfoundation.org>
 <b7b3deec-47fd-43e4-a9b5-7099e3c00623@fujitsu.com>
 <54cbf018-eba1-4227-b464-78bfa41fa4ae@linuxfoundation.org>
 <3ee0d14a-7f6b-4ef4-9349-d6b0f14ba9e8@fujitsu.com>
 <f10e8a78-3b50-4212-9b5d-ba99a3421379@linuxfoundation.org>
 <6862e399-b169-4ffb-b9c6-904f99d96e56@fujitsu.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <6862e399-b169-4ffb-b9c6-904f99d96e56@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/24 00:06, Zhijian Li (Fujitsu) wrote:
> linux/tools/testing/selftests/watchdog# make run_tests
> TAP version 13
> 1..1
> # timeout set to 45
> # selftests: watchdog: watchdog-test
> # Watchdog Ticking Away!
> # .............................................#
> not ok 1 selftests: watchdog: watchdog-test # TIMEOUT 45 seconds
> 
> 
> And i got warning in dmesg
> 
>                                                                                                                     
> [ 1953.229511] watchdog: watchdog0: watchdog did not stop!
> 
> 
> 
> 

Run "make run_tests" under strace and send me the output.

thanks,
-- Shuah




