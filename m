Return-Path: <linux-kernel+bounces-440542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 729A99EC090
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 01:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B09C16A2BF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 00:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C4ECA4E;
	Wed, 11 Dec 2024 00:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYr3d+uX"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB454A0A;
	Wed, 11 Dec 2024 00:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733876135; cv=none; b=s+gxi+WAOEKBDmcDD/5470QX1wBO7aVDgsE5Yp3V2KNZ8gWD+uiYM9ZzfP4q8HdfnWNIjKSr13nFti5RLbzu9AZvZJ4237EdCu9/BIK8Ou/SGPJmmxCWmIFBgPB5bFknTwxsvlAUD5x1TTNJv/978hMHA16UWE1YvY+YUNrNoBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733876135; c=relaxed/simple;
	bh=HpUl9pm49rFmCLRsPb0k/g7alvyh9uLTo0blGRFrySM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=chdK+MzocmVanI89kgoRczfkzXwEA2vskuHo7FE32HLy2Cq9h6OECEYn3SH0MYlbZLwmGpbbf58Z3GGFfbmor+Il1neeWzCf6vAMfHmmumqwV5G76IySKed3WU0uM8eeGFeR41kbsMLinmjPLDtjv8Njfq9z5G1Rkj7Lmdtzx+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYr3d+uX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21628b3fe7dso36003345ad.3;
        Tue, 10 Dec 2024 16:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733876133; x=1734480933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gHQo/ujQnGHg0wAqG8J5ZohuHoKhQsc9yZ+fdJ7iwD4=;
        b=YYr3d+uXCJtddvrGGhaJ7NPypioRiDOCsCxqM/VfTQL4/i7jgRfvsYKyr81Q+ujUfF
         Pr64QEPBLWygBHI2AnOHTfb3PSy/Zu0ab1SX2qvUHfXRfYVqOIRPTUwnxJmbtbHULckC
         0KtOBN7BCBa90MR6m4PH5InGsoT0l/vXZzPSYvftmGE0eFebgEJHhnprloIPORIL4Qel
         ju9yDxqdq/kPqXFGA7ZyYpWJEnNCdSflRWsa16lM2WO2xatlFryf93T6kLUH07JiqLRF
         jbypTlxX7PurQE8XYzp/VwuihVTFwQwq/anJ+JwJveGt+sCVf6g2h1JJp2l6VRXShgSP
         p4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733876133; x=1734480933;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHQo/ujQnGHg0wAqG8J5ZohuHoKhQsc9yZ+fdJ7iwD4=;
        b=YmovgRywJiqxf4mZqIzjiZfZuSE4Qf4GHZ8QsjKQH4OBs4Y57b2FfEWv9TK68ZNUQy
         XWGPJ22DTiKguuY7Vr8PgPJxIj5P5Q3znpmPl5s93wH+ds2O7oGbHSIldRa+WtgAyeMf
         e9/JqIomQ5MU4X8bBIB0IhhWmaiiW+awzNcx+6+0T3t4vc00bFIl9qg/mwASAnv0O9kj
         s7y/KojWYGCQRfI999R1/n5Pteij+z83ZmH1dChApeU95QpMYO/F6eFvQlhX/A2SWpPP
         akYEo59+unDezManN4TNQAUg70KGvV5ZfK5JYKg729lc87Kht6fDOBjzJbTXpOf89CRv
         Mtpg==
X-Forwarded-Encrypted: i=1; AJvYcCWxtMz2nfDjDTCCRW01KWCgbVEfICki+jqmGfjxKwLbLAeT0kTnWlag7oXOow6ddMx2ALhD4L7SX6ZhEE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznu8LOOrao8SHNc0hnvc9mvS1MNljwc48AqsJwfkuOHs8T7UyD
	Mf6J2rCDWimg6YVEUlLcCZ4iCpHHvZ1pVJTV8SOD4HX4y1JOdUQlZ1sWiA==
X-Gm-Gg: ASbGnctz/WhQDgN2lvTA/6RiKqmLmx0sM4ke/lCD1u5I1gIeRblSgfbMWBzJoHsEnhO
	zt+s7Nd0TJXg4kyr1cWoHf+4dYH4QJpllZs4DjmR7BC8XdBxRn4mFsTB4BeP6RuMcojT7SKxXks
	6MSErxrMJGY59IlhJfXtPzzxJhRbEE8lfpddegrnMaODYGEtiYH8qOlUpG7ssX3PYXSbbEkcSkh
	5z5GVb8y3CZSwYtBMBdgyOMqv2KF8CRkHflnzPeCTwcFPcpHGg/Ap1a7nig4C7q82k/+3neBThd
	FP8F+0voCGFsQKwsjIcw
X-Google-Smtp-Source: AGHT+IFksFDnsKU5oHhKkOFIsb9atiH+kvxv2N7HdKDoYulHPomoGXHdQTF259XjOQtUN35A7LUt2Q==
X-Received: by 2002:a17:902:d503:b0:216:6c88:efd9 with SMTP id d9443c01a7336-2177851dec4mr15812535ad.15.1733876131845;
        Tue, 10 Dec 2024 16:15:31 -0800 (PST)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2164619fdd2sm46307875ad.4.2024.12.10.16.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 16:15:31 -0800 (PST)
Message-ID: <b7c99226-7c03-425a-91b6-c7969bdbb1cf@gmail.com>
Date: Wed, 11 Dec 2024 09:15:26 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/kernel-doc: Get -export option working again
To: Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Akira Yokosawa <akiyks@gmail.com>
References: <e5c43f36-45cd-49f4-b7b8-ff342df3c7a4@gmail.com>
 <87pllz2r30.fsf@trenco.lwn.net>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <87pllz2r30.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Jonathan Corbet wrote:
[...]
> Ah ... I should have thought of that ... I'm glad you did.  I've just
> pushed the fix out to linux-next, will send it Linusward in the near
> future.  Thanks for fixing this,

Your docs-fixes is based on v6.13-rc1.
This fix needs to come after v6.13-rc2.

On current docs-next,

    ./script/kernel-doc -rst -export drivers/iommu/iommufd/device.c

returns:

    drivers/iommu/iommufd/device.c:1: warning: no structured comments found

I guess restarting everything from v6.13-rc2 would make our life much easier
for v6.14.

        Thanks, Akira


