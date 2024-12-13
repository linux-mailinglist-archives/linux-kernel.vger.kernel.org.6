Return-Path: <linux-kernel+bounces-445296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DA49F144D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D25D2188D531
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71359632;
	Fri, 13 Dec 2024 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="j4DUC7DP"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FAA17B50E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734112144; cv=none; b=E4kOyB6HJfq1Awm9snqmM/Prg5MtA5vAKuvmHzuzziW3EYfKRgsHWjtkTvrnCkd2dsnqx0FfXgdhIblxuwKPqt+YWmg5udEJCCFFsJ9D7XgFYlVMH36lJiDXjs7oxLFcpmaGckpe0wMV58pn88LMCKCYP+M3YReyMZAFpuYrXEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734112144; c=relaxed/simple;
	bh=Y4LeC5RXGp6H/KRsO20vJmGW1ptiuI4cDc+DzYUyPko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qVXuAMY4j3A6XXRzeq8kWRl7oiV7miJ3YR/F9ZQt11iQU+37H2M4S9j/g46mQSy6WWvRbuL8G+ylt9WQClPVDxMeZD4HrBl5Rq9IwzYuWpZ6nnOhk3X9szzijZ4cq293jwpSUV5e+mH3OVuXQV7oTz9hIBcyI+VdUFXzBgQM+0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=j4DUC7DP; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-844e394395aso52593239f.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734112143; x=1734716943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CcTujtpSjvlWaI5ctqnscgJNM+ozrNrJa3iEX3J3FPU=;
        b=j4DUC7DP3ckWeWBeyt720e83nhooO+osm+Tajbnfe0M5f0Am42vXi7hOC7Fy8vfGy1
         IFOt/W1sePCn1ECRrFtVEQQU59/vhwzbmiV9msvjjqwNqWlF2CC6uvOS2oaxwFgI93Z4
         KnVns3lf407otLpmQitn9kOrG87Acsljql1TD5G/Hnf8frZ84TwuYQErwIVJwUnWLHiD
         llDcDlwgSBwHOvwmArtI2tDa1EZ9aDhIvmIVkgySu6f/jZqhLubuqO955xf+/jIK01J1
         MToSlJ36OAYgV6zRAezQC/ElSueBBf81x/qX9XewrhcfRLe7lC48t7Z96GseX4nlX7jd
         5org==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734112143; x=1734716943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CcTujtpSjvlWaI5ctqnscgJNM+ozrNrJa3iEX3J3FPU=;
        b=Bxuv4pBD018KYw4VuQ6HdSlj/KyMf1lYtbSIqYH9a2lZcNS01mevZzXK+sWU2HJaEv
         3Riz/MQPaIB5ECktfkCZwOQiD361KfYSqNos5hq5IMHVG+8ixZgzuJbPmDnpUMFU76TV
         dpAwFCzsL0Av1609n4J+QybUlZlX306tz2/pYosCOsRv3IxmJihQWyng+Ko9TaFOgy+h
         /g2u1yrzzYMwDD2GCvbY0AtWNnyU5+2KQschOinCXbrzsaECa3lHdxTpNxv15Ii3z8W2
         +Wl6b51TJoySUtqb8kf0nIyaYbPPDKKx+mSA14WH+IKbIqfWr/Dcxdvf3FGC2v0LkTDH
         uc7A==
X-Forwarded-Encrypted: i=1; AJvYcCXcZAy+86ARg9ACC3jpoGxloCKDJhOZ9VtUcnYZ/VdiObU+rQtVpFI6accMRqoFWwimqgfhoUSYHWXWUVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRgbkmxpLLF8EiBLKifV9ThqpuQKbcLa2MJb94PgeOtq1XuFVV
	148LEF6YB8OcnHZnG941B9OVtm9q3t/0lI9iurz72YWOaJxfULWZXLsgMXN34T0=
X-Gm-Gg: ASbGncvmvT0F2fXSyjuQQNEBUMBduY5x/k8iiW31TWuWzXcqaODFv01WH6R8ulfDD76
	l0qWQpB9WN7TAmow65UyJaowJoqmRyuDCtwhM35F4luALZJUYx7TNY9zlvkmQGMrv+pSMaU3C2b
	Cp+hjZU6iFr0UIvCjsY0JCG+xIJn10ggjQS4a0dtJFgUlCfYeK7d0V55174jvb0JLLQJPUQGwxj
	cP2CfQlIc6HGwaaVDtGrJV3FEshwUksHbuhePbMAExFwcumPKAt
X-Google-Smtp-Source: AGHT+IHTNp8YhuwjrOvI0UFfn5eCTMvVJPRKHYRZYXF4sT0Up7xIIztoFPfY1lE5LUD4a32wxrxMfw==
X-Received: by 2002:a6b:6105:0:b0:83d:ff89:218c with SMTP id ca18e2360f4ac-844e8835294mr323326639f.7.1734112142749;
        Fri, 13 Dec 2024 09:49:02 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2bff662b7sm2704740173.103.2024.12.13.09.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 09:49:02 -0800 (PST)
Message-ID: <2310bb0c-8a8d-4520-a1ab-40a0489312e5@kernel.dk>
Date: Fri, 13 Dec 2024 10:49:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING in get_pat_info
To: chase xd <sl1589472800@gmail.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CADZouDQpNvEd7ntUgOAQpU18PErENx2NsMMm05SXXODik6Vmtw@mail.gmail.com>
 <ca3b85d6-ddbf-48b9-bdf5-7962ef3b46ed@kernel.dk>
 <CADZouDTH=t7WTFgrVyL_vYsJaWF4stjAj5W8NF2qAK0bW2HVHA@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADZouDTH=t7WTFgrVyL_vYsJaWF4stjAj5W8NF2qAK0bW2HVHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/24 10:47 AM, chase xd wrote:
> The bug was found in October and the newest update on lts5.15 was on
> 2024-11-17 but still it has not been backported yet umm...

What do you want to backport?

-- 
Jens Axboe


