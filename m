Return-Path: <linux-kernel+bounces-515089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFC3A35FB7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810F8188E2DB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15626263F46;
	Fri, 14 Feb 2025 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="MfctabhX"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D195464E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739541710; cv=none; b=JV7k3H0Q7DcVwA1/r8J8N+CfZCwULvR5DzZPuLBq1eYlpixkh7KUr6mb8Zo4zyKmSEhWqmEumwGA0F3OZNcC0L5IqZYJM22Z2InvdDzJPLHkG6S9VSbp+ERqwsQmchlCDy/+bKIS9GcwgOSAYnwepo1XdJWNXclz5p0QdUP1wLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739541710; c=relaxed/simple;
	bh=HGjli0swbCnmOowIJ/Gr0dmqjEGCgwqgbwiDSQUAKTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zph0QDW2h9kwPC2oaMVnoDQ5SxD9KgkKleE/9t09/uVTjpwpkFneAzgbKknqM9BPt/Ao2vwTFoMnTUh458a/UV1mWduyWBEfNe4ukDv3rT7M97S1y7whue7TQGM6QAqTo3INskWTQ5+8TjXIIQKFG1+Wf9ixA7GnVjYup90W7v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=MfctabhX; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43967004304so6332645e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1739541703; x=1740146503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HGjli0swbCnmOowIJ/Gr0dmqjEGCgwqgbwiDSQUAKTo=;
        b=MfctabhXG/Fa+FJJOK3Tl+iq5XBxiYEDRd3uHO+d35UhJ2CLeGJqOnS8rta5M4pm2q
         vJgLqcXtjbYiyh5+HcsRbSOY+rA9J4jEOtHCq8ExEXUD/kZhv2WWG0nCGx2K/sjiOr1i
         pVg/fr+PrI7pVdyHZNil0dwjo5hL60FsWXU98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739541703; x=1740146503;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGjli0swbCnmOowIJ/Gr0dmqjEGCgwqgbwiDSQUAKTo=;
        b=aA8FQj6v788XeP7Ut1Urgd9bMTcE34KXgEhb5QLLJerUokeuJn7sozbiEHIyA+npSj
         k0nJ1oDtLyhbqj/y25izQrWCGgq+kXepTp0U8LRz+vFLqBUZaKmJVDthLX2miEutU1/X
         MOJxOd4ED/6X4LA062vLbdn/vMuwjw5r3lzX8MehBAzuH/qQgbGc6XPV2/tPOU1CVtp7
         /dsX8u0Fdppx2HJMUBQcZl9WmS/M0nUUbi5v4d1fHMG1vAS+qpybnjiOoUCuEyCWXy/y
         I58WcqvM4oofqIag6MCkDOaUROk7xUg/D+CBwN5Uo5oPU+pFO+zuOETWEDjqZTO/Ib5i
         CLDw==
X-Forwarded-Encrypted: i=1; AJvYcCXF4L6TAg6gxW/WKQ97crBWIIGoNb1WPUHTBzmnG64Oeh3OpBcqbJJIkD049wbCrMUuRxsRuJ57H9Ojkqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpfYwwgxyL7hqxBwWpr/gw7Q+SWiDlGMJW/sbd6sQioqhR8JlB
	CdA+MNn1z4UwfUPR/UAlDTlllUQDlRFx2ow7hoS79KidfxYhAE/qbndbtLysi+o=
X-Gm-Gg: ASbGnctZL9JNzfJKIcnj2TvO9JVsYID92ElSUriGJB+807gAl/GdK6ELcx//ARoEdX4
	fp2jHpF0NHT7NOdDm2etL9tAWK8g3eSR1IqXaoMcNfWL+lsda6n1tmSiy3LbvOgOrIrr4Jvmsix
	iDB/lK7ZFFPVlwr21QJtA/SgZ6lhNpHfud3+82COHRMjCyWc0YQ7yWhJGAdJnvbi5e52qrehj+w
	vPCvbrmZNZzM/iu2ATvL4C4sMiiezL61CNfPz3P2etSwmmVGx34y/MRkobV0I4b0O1Y/JsaLowy
	Nn5p/Hn5St6zZETMH9UsE+Pd
X-Google-Smtp-Source: AGHT+IF7b0C2K8tXuQ3ubpa5M1ufNujVdQ0H97x/jjslO46O4jzmw/XslcAWnMthY8HIbApHmdDcTw==
X-Received: by 2002:a05:600c:500e:b0:439:4b7d:72de with SMTP id 5b1f17b1804b1-43960185ca0mr108301275e9.15.1739541701920;
        Fri, 14 Feb 2025 06:01:41 -0800 (PST)
Received: from [10.81.43.157] ([46.149.103.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439617da784sm46791425e9.5.2025.02.14.06.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 06:01:41 -0800 (PST)
Message-ID: <eb5f75e3-0882-4baa-be32-f363a8e411d8@citrix.com>
Date: Fri, 14 Feb 2025 14:01:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] x86/ia32: Leave NULL selector values 0~3 as is
To: Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 brgerst@gmail.com, ebiederm@xmission.com
References: <20241126184529.1607334-1-xin@zytor.com>
 <fa3d0093-818d-4592-8415-3c2e287cc3e6@zytor.com>
 <36970ddb-c0d8-43e4-a94e-0d9ea3d55ced@zytor.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <36970ddb-c0d8-43e4-a94e-0d9ea3d55ced@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/02/2025 6:56 am, Xin Li wrote:
> On 12/12/2024 10:44 AM, Xin Li wrote:
>> On 11/26/2024 10:45 AM, Xin Li (Intel) wrote:
>>> The first GDT descriptor is reserved as 'NULL descriptor'.  As bits 0
>>> and 1 of a segment selector, i.e., the RPL bits, are NOT used to index
>>> GDT, selector values 0~3 all point to the NULL descriptor, thus values
>>> 0, 1, 2 and 3 are all valid NULL selector values.
>>>
>>> When a NULL selector value is to be loaded into a segment register,
>>> reload_segments() sets its RPL bits.  Later IRET zeros ES, FS, GS, and
>>> DS segment registers if any of them is found to have any nonzero NULL
>>> selector value.  The two operations offset each other to actually
>>> effect
>>> a nop.
>>>
>>> Besides, zeroing of RPL in NULL selector values is an information leak
>>> in pre-FRED systems as userspace can spot any interrupt/exception by
>>> loading a nonzero NULL selector, and waiting for it to become zero.
>>> But there is nothing software can do to prevent it before FRED.
>>>
>>> ERETU, the only legit instruction to return to userspace from kernel
>>> under FRED, by design does NOT zero any segment register to avoid this
>>> problem behavior.
>>>
>>> As such, leave NULL selector values 0~3 as is.
>>
>> Hi Andrew,
>>
>> Do you have any more comments?
>
> Hi Andrew,
>
> Are you okay to give a review-by to this patch?

Apologies.

Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>

