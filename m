Return-Path: <linux-kernel+bounces-575820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B65A7078F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17F7C188E895
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC1F262801;
	Tue, 25 Mar 2025 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LW7xLAPW"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BBE2627F9
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742922029; cv=none; b=PiDMLYuCItot3D7J9++ViWIRqHZtawWaaEz3HJ0Ii1BYqupRTBWmblODazdzJbuPe6GOfWIOoQY8GSIrfTvMVFwhhD8Od0JSNUvzmGCd/nTI1qA6deiKTOz0rAqrJYtk1gVPNMQbYUfiND8WE5fcj04i8xam14DojDKYxVqkyDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742922029; c=relaxed/simple;
	bh=JzSyyxHPLR8iFxVsVqAjhsJGNcPWV1+9aX0eGoXDf/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/LDczSllQgcpFO/7E8R1bnjxhOEEZ4LWRiZKgT2xMjlwrXS/fxCMXzO63d5VQuukxzuZorFI2iJ7JC+86smADEqD+vk2vinVt9+ucEYPJXBoS+v9aEecMY6O5cOBB4LBR/nBUS8+QBKkUGwhSl/dFOvUISmkmWgdPJARiRpMN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LW7xLAPW; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22580c9ee0aso121167965ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 10:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742922027; x=1743526827; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Azc65USrzFasHU1jO29UHHSBs9Cx7/6a82Lf9CyANV0=;
        b=LW7xLAPWxQCbQFO8raM5S9i7xiy47n3lFTKo/aJ5OHC3Xm51KGw9unkDnSHKpFDDQ8
         yWz2i0/M7PnymEqg1h8f9ZzPvEB55QGw7+Me7vdv93Xz1bY/7+At+oBFMSy2xKuka4B7
         nNB2Wb9goCJ+Yafnf6/on3LAlA6MwF9UBdHbCvuOl3lJ1WvMRTWVnsI3rl/43+77E9dd
         4zVAeapeCZmOFd+2yhQUVesCVyBOJxasAI9Hi7ZT+00wG9qW1ZqHm8tj74KhFFMcU7/2
         s3yxsMsKA1OqheSHWJFxDLf02jMZhlCo5m/xVJ7hD7WyiW1FpF5eZIFB+NRL+gRDzJTj
         tiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742922027; x=1743526827;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Azc65USrzFasHU1jO29UHHSBs9Cx7/6a82Lf9CyANV0=;
        b=AkhcokhzTfBRJxgL+rWzE7/UYgY8oQUd/ib8FEmTQVKD0pauHs4TG0L1xiakRslt7j
         aTgKZTOeLygpscsL06n6YCZheOwGZiHnaaZNHb/Y6OmTWs9qPt5efnY6rpZCTthgrD9Y
         KPjiB0OFq2SUuu8jRfGp6f+txAaHC8VwhoZTDNninTlGI/fVeGaluL4UtyA/EU+9PoqR
         YINqV2lwey2r2qjNmrSYCLkhXGXGgx62X9R3FlhNXrkD/3wP5A4ZaOiJvGFpaNyFXqFU
         36AjxwGfnPHl6SkMtiidue4mhbuWtTkIUQaOd0qhPWeVBPMbIrwuCI1WkAhuEgBrnEMU
         /RFg==
X-Forwarded-Encrypted: i=1; AJvYcCVS+9Bq82REXCqWYsLbiHvEi9vJEspNWicm2DK+UMR9jpwJfZ35WWlPKQ9DnMfn3eU+1NS+CWxT4kITrUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwThGl4VZILtZ7C84pMjRaWYJ4r0A2/VD/Rxu6PhmvUeIzEEgFg
	s8dzNQ7NMQD/PUv9RiOr4/dGB/teao7Oq3WTk15tgvyI7rUo1lMBu/RePal0ZN0=
X-Gm-Gg: ASbGnctnar7c+S/wbgLpeIqfyuI3t7J1kesgGG8EoH42qSezHzyfBfVRyI1VnowNXU5
	Xpvr0KBQeXo3o20LGSXfiZdiFVgZ8xyDX8LMfbpRMpnK6o8BbRzYAoNd1sefRyjOKlI1ydlbLvS
	PixWtNgErFC+y34TGrlHZpNQQ0e/nszATwpccCMvN/ykR9UJXNEjx5k1Ndn1NODRSRcvTBMq0rD
	OTiOZujDSbO35BDQp+G0fxN3Ke6NabuggcI82GcuHSs4BXDWgPXHpbA1LhwbqjtNObjF/RYl5P/
	USA+qPziKAt7DfvisTbhimDhTKAPeNGCSqhE++mQXdZro/yAvX7MeyeiIhBOk9XRWFtbit0VijJ
	TUBmo32JwdtquYylpvOSlmg==
X-Google-Smtp-Source: AGHT+IEtyy/9fIlH63J5nf464X6zt4pW5HhepzL30KIteieGw8th0/q5z55+RkGRF7k3MuqwqELCXA==
X-Received: by 2002:a05:6a00:2291:b0:736:53c5:33ba with SMTP id d2e1a72fcca58-73905a02b96mr28409737b3a.16.1742922027226;
        Tue, 25 Mar 2025 10:00:27 -0700 (PDT)
Received: from ?IPV6:2409:4080:119f:3ad6:66e:eb88:9ca5:b5e6? ([2409:4080:119f:3ad6:66e:eb88:9ca5:b5e6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a284695dsm9386261a12.44.2025.03.25.10.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 10:00:26 -0700 (PDT)
Message-ID: <31800f57-2fd5-4e9b-a301-36a67ba27210@gmail.com>
Date: Tue, 25 Mar 2025 22:30:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: jfs: Avoid sleeping function call in softirq
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org,
 syzbot+219127d0a3bce650e1b6@syzkaller.appspotmail.com
References: <20250322142134.35325-1-purvayeshi550@gmail.com>
 <20250322143549.GH2023217@ZenIV>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <20250322143549.GH2023217@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/03/25 20:05, Al Viro wrote:
> On Sat, Mar 22, 2025 at 07:51:34PM +0530, Purva Yeshi wrote:
>> Bug detected by Syzbot:
>> BUG: sleeping function called from invalid context in jfs_fsync
>>
>> Fix jfs_fsync() to avoid sleeping in softirq/atomic, preventing crash.
>> Skip execution in softirq/atomic and return -EWOULDBLOCK to prevent issues.
>> Correct generic_file_fsync() call to pass the required arguments properly.
> 
> _ANY_ ->fsync() instance may sleep; adding that bandaid in jfs one does
> not fix anything - the realy bug is whatever leads to having that
> *called* in such conditions (e.g. having an unbalanced spin_lock()
> somewhere, etc.)
> 
> NAK.

Thanks for the review. Based on your feedback, I have analyzed the call 
path leading to fsync() being invoked in an invalid context. The issue 
arises because generic_write_sync() is being called inside 
dio_complete(), which can be triggered from dio_bio_end_aio().

dio_bio_end_aio() executes as a bio completion handler, which may run in 
a SoftIRQ context. If dio_complete() is called directly (without 
deferring), generic_write_sync() gets executed within SoftIRQ, which is 
problematic since fsync() (invoked later) may sleep.

