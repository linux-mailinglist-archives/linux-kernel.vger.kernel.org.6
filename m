Return-Path: <linux-kernel+bounces-351321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A802990FB3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D822D2815AC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184F71D9688;
	Fri,  4 Oct 2024 19:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JxnUpHg+"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C3C1D9687
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728069690; cv=none; b=UeKICxUmPzj3U0qEpJg7PTgVXkdfDUHjy7R4I7J5MYIrpuOqG8HJjDk6ul8FPZn5lc7ZxcQCQ2DvcXoDGFgf+KEjO4Qfq73HzuQOibarEq4QHbJExDixk8POizUV5pdPgnWVwxYEo3p+AyucOI73TGE8RXvx5qEu7Sru8/kcOH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728069690; c=relaxed/simple;
	bh=fVEBfxSyDVlc0EpJfy5QcSEdCXKTPrX7H/6owJNViQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iox7udfUTgyTzxBPN8AWPM/RG6qh7WtW2Ca58/Z6D/AqacigvT+b/srx7VOZEP9o8SKehYnJQRmT5YfOrzDT/abIWNRnb2y+C4YTEJG9g6YWhZDjhoG/IlZU+vq3KlIxys/9lImUPEtx4VXKM5Pj3qqNakK6jfdRgzg6X1QNcp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JxnUpHg+; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-82ce603d8b5so112489439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 12:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728069688; x=1728674488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c5m87vTHE++8UIJNUrbgN2K2EeqcMpq6wjqepk0fGDo=;
        b=JxnUpHg+xTEqIWQcF5HmEOh6FkvOBfuDT08TFoCUKFQ/x9OSBIQKnaPULfBaY0vlqa
         fdCQKgzizZcdewhdHIM0NJGUj+ybYp+y5WDeALfO762PXlsN7jblXoKYVobMJIYLh72l
         9zgcfYhwUxYwNl8SRWDPMr08pnJSSyibWs8t4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728069688; x=1728674488;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c5m87vTHE++8UIJNUrbgN2K2EeqcMpq6wjqepk0fGDo=;
        b=UTVUULffLzBY8ViMUyPX1X5gmKxdhKHpSfd4d+9kS1HupyuUtSFy0NvR4gBjFsZ1NB
         /TH+MrWhV/+WHSz+UKb2yARZUm6whM0cJTymNJ6BoxIvA3sMIuQLOdIphSIeywT6v2jJ
         07zEqnqnezcFrSqSHS0rJS6OI+k3E3pxO/8SIznLriun9Z+KI8G9mmuHdwCQfy/oA6qO
         Fk41e9CyfXOGNwriBCL8MpDEQSUcIIMl7QY+Wx23KCdHQU2xIIvGO14yWqG5q7a09Jqd
         ez/MwXbI3W1AZDbooVRssRYu6NGL1NKvQoYAOHnwenc3SQncvtTdkCvA446+Yta8GNny
         +t/w==
X-Forwarded-Encrypted: i=1; AJvYcCUTp6rWRdoMiZukdy9MjWFk7zrkcbXXeC2BX/YHJDutBn54vI52e0MKzmL0jOBdFTtpfpH0kqGUxwMefAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKl3neEW9N7O2F0Tz+6W8YQq9Qxw50xpK21XKe6bSJCWBLGiN5
	A4iF0TPRJAoDdw3ZfL6Kxfs3tlY0fqnAH7TT2fbZyhvTmD8u6mrMmGsHVGjWCYs=
X-Google-Smtp-Source: AGHT+IHB9Cfcv2Wdm+1ezrAxG7L3TnJZuWABNHgrPxjVCcI+GkBmPYJoLNEarQtWr0dK+x5QB4T06A==
X-Received: by 2002:a05:6e02:1561:b0:39f:5521:2cd4 with SMTP id e9e14a558f8ab-3a375bf8c2fmr41012735ab.26.1728069688147;
        Fri, 04 Oct 2024 12:21:28 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a37a87510csm942265ab.79.2024.10.04.12.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 12:21:27 -0700 (PDT)
Message-ID: <f5e004d8-3b90-4697-a2db-4f9dc29b70e9@linuxfoundation.org>
Date: Fri, 4 Oct 2024 13:21:26 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: dev-tools: Add documentation for the device focused
 kselftests
To: Jonathan Corbet <corbet@lwn.net>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernelci@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20241001-kselftest-device-docs-v1-1-be28b70dd855@collabora.com>
 <0040a842-de9c-4f9c-9d61-c1bfbd010470@linuxfoundation.org>
 <ef428a44-783c-43c3-81c6-9abf88ae8949@notapiano>
 <e3602786-d656-40ae-9e22-0e8195d33f0f@linuxfoundation.org>
 <87ldz33h3g.fsf@trenco.lwn.net>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <87ldz33h3g.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/4/24 11:36, Jonathan Corbet wrote:
> Shuah Khan <skhan@linuxfoundation.org> writes:
> 
>> Jon, Let me know if you would like me to take this through kselftest
>> tree.
> 
> I'm happy either way - go ahead and grab it if you like, just let me

> know.
> 
> Thanks,
> 
> jon

Applied to linux-kselftest next for Linux 6.13-rc1.

thanks,
-- Shuah

