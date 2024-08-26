Return-Path: <linux-kernel+bounces-300623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B46E95E631
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 03:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 751001C2081F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 01:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3100F2CA7;
	Mon, 26 Aug 2024 01:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gb+QVjH9"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA17765C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 01:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724634915; cv=none; b=YWQnfMLe77aLTbb7pXMlBvW7VFctkjqVDNZuXHdw4abowwfJ+IQVK+wN317aHjp6GbGtkGF5IkJHgAoOBIdCAaThqCSijsn/pUoqcFgYiWCpuhcT/fyLwffAVnw6sZBr8gDZqg0ok44mXEhL5ASeYJHy39G+Fr0aQKziz5jBKkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724634915; c=relaxed/simple;
	bh=yey/safOiJjvcVc74bPJRECTUO+McyoN9PWKBMuDuwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fOo6wyRrCyYPzduQuHPUK0cRRPK3xOwIHLITeKSfSygtQs1iYwz6g8ROWMXF6AQF1JKjF/VZj9U/KqsXSXHiSBnwKwcac9DrXPs9wSyHJQQrl/GKkdDH+f/20Oh3VeOJ2wStjchYqeF36GpVk5nJaMpdYLDPOG/pTH0CbA77lzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gb+QVjH9; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a869f6ce2b9so354612766b.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 18:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724634912; x=1725239712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XH41IRwsrbE+mNci4UYQWCo3CzLco+pMM+xg39EvIWc=;
        b=Gb+QVjH91zrb5SSjnDanMVjgOpNvfuIBiOCYDm2/3JCtSVH2OFDrfg/WDmgkylKogj
         trcKAqmUuuHR0+oVDwfIS4yBmWUEkYwXyBUKZFUf2vRiRRtUbOzNki712JDGUbVWbqLE
         Rk4QTcpv8wHkAGuUkmKdraH08KNlsK2g5HuphowGw3zuR29O9VQ9qDVWxa5uD34tl5Tj
         /elMlBavSAWJHjimNNpY8YcsXWUJXo40OssLDmH1OTg4HDIj8EijG3JU4bQJ397t5Swa
         2LczMxdC30xng2N5dyMsxPigWKlSV7N5WFcjQmlxS/W8CDnmfYvUtIsLq5ek+oJnkE+4
         967Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724634912; x=1725239712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XH41IRwsrbE+mNci4UYQWCo3CzLco+pMM+xg39EvIWc=;
        b=XOJUXllSfFjvoGxA26AvvOF9StIhe26oS9u/gxi9CV0NZjrKpyJXYnZlMNB4YnrC0b
         +fOBwaj2m0vqso0YkJWMy1oG9ub2s8Qbs31zOAgoCgcJapDq++OSQqSrIxvxyEbD0Mx5
         ywFQGxMc+VcWtNIR8CaBSIrpN/Z/YqpRuslGO8iQa77VJ13piCMrzS4Wq+Q6W7u9KQIW
         s+iczpgA+0Kt9av6Q70A3KeKvSBM41I4UT2jenRlK8TZp/3xOnOHHUUejfNfjEfc09sn
         m7+5cef+65l03Ih3xvhoLpPaPBw2/kRtzmbXYEwDXbyCakJjkrvw9xjB+CMG0FXuS+7Y
         U1qg==
X-Forwarded-Encrypted: i=1; AJvYcCVa7rjxZHv6SDbZMH2rDk17D1Xv9IWpF3XvgYahUmSCu8OBegqoKDEv2jQe3WtJpIuEyd9Sg/1NUR506ow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznq1w2vtO9iLpPcn9sJmlNwSEUuCAFL1rcupFhDPMRy4zECbTd
	1MIUpZ+ct2+TFK84dpRqxktOVfflHobhMtuM+3Vn15ZUqnes1571
X-Google-Smtp-Source: AGHT+IEuW9jo2qd0tjZSuQYtLVjW51vjim5vwz/DEilzUnEApZl9dc2seVq8uxArc9IVu2mf6Z3IqA==
X-Received: by 2002:a17:907:9814:b0:a86:a909:4f67 with SMTP id a640c23a62f3a-a86a909505cmr600104966b.52.1724634912067;
        Sun, 25 Aug 2024 18:15:12 -0700 (PDT)
Received: from [192.168.0.104] (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f220d76sm607307366b.15.2024.08.25.18.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 18:15:11 -0700 (PDT)
Message-ID: <94f3e86b-3bd2-40e8-a02c-9aaaa483a7bd@gmail.com>
Date: Mon, 26 Aug 2024 03:15:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Staging: rtl8192e: Rename vaiable cleanup
To: Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
 anjan@momi.ca
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240826001724.274811-1-tdavies@darkphysics.net>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240826001724.274811-1-tdavies@darkphysics.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/24 02:17, Tree Davies wrote:
> This series cleanup up camelCase variable names
> 
> Tree Davies (6):
>    Staging: rtl8192e: Rename variable CurPsLevel
>    Staging: rtl8192e: Rename variable bLastIniPkt
>    Staging: rtl8192e: Rename variable CmdID_RF_WriteReg
>    Staging: rtl8192e: Rename variable CmdID
>    Staging: rtl8192e: Rename variable msDelay
>    Staging: rtl8192e: Rename variable bCmdOrInit
> 
>   .../staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c  | 10 +++++-----
>   drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c |  4 ++--
>   drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 18 +++++++++---------
>   drivers/staging/rtl8192e/rtllib.h              | 16 ++++++++--------
>   4 files changed, 24 insertions(+), 24 deletions(-)
> 
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

