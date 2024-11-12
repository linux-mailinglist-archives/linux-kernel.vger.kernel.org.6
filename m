Return-Path: <linux-kernel+bounces-405556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3CC9C52DA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66A771F22A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7977820E337;
	Tue, 12 Nov 2024 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sf0hPrYB"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E36E2123DC;
	Tue, 12 Nov 2024 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406348; cv=none; b=CO3nAWsMCsr3cNE5djqtsGpRxmJvttaIZdK6sFNn6K41VxaDJULcvP9VVdw9IRDAVfjmW4jckMz9OYq/HZZHWg7WUlqKQhmfxxyTrGL3M37jXkJC+ew0Mc5OdMaPhMsJPzXcpp9Z+j4ypWrgyPystVSvmFGMOhlPB/2xDsBr5rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406348; c=relaxed/simple;
	bh=lrclKszYRsv2TFhiNgHUYKis9sZV2lC17OkxDG08BdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UA/cAy8NFAcWv7+a3cR3J6BdNvSN10NjUg/eCow+oKNJ5COBTUeGVZeo/qZwSiEefwAb+lbf3Kfjm7fhKoXhLB/C/DggjWzD3HOc49c4GFcZz9e2HQJWtwKOinccR65WtpJ8B60JzCd3jDl7HeiaJxah9CRguxmdABqM0eXlXWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sf0hPrYB; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d63a79bb6so3618599f8f.0;
        Tue, 12 Nov 2024 02:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731406346; x=1732011146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pxM4gTQSQABswxwP+nf/NclermLnvfNjsT0wLCiH6gI=;
        b=Sf0hPrYBOJ7JeyVLOIGUxr9CR3uBkmwRLZG59J5fJUfWMWaXLjQ7ZyOuFihkYnRH9l
         o933V5ZksDrwiXnCiICmz9OpL6h370OsDx7A6R5JPKkHv2+v3YPBOLB2bKWC+jkEWZT+
         7X6J8UvCwkyImzbWBjCJSuzMSN9CQSbN/iZOFa9a/NRp6fk6/CK7TupCEou5dUOSvJ3P
         Pv1YnJB5RVjcHX+SWaZC70TjQpjtMcDBf1HH2KOawvqPyHb0pLu4xOdPa+thJ9D6DmjD
         tOQe6IOLXz6En5CdHiN5XnMO/p/QHRmzb69fWYPY5g39UfTFSKQHSCYPoGxjPxwQ3+Lf
         4Z6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731406346; x=1732011146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pxM4gTQSQABswxwP+nf/NclermLnvfNjsT0wLCiH6gI=;
        b=bOg+TFprfDWSi8TJuxodULGM36ElO5g5R3zDXCaN9SytvwfhNU/tGmWqttZDIgpRVV
         1OiRylEsI5uSLCOM02x759aSBE2naDb5tyKBE+ROqCDr5IUolZYGiNyBVEYVceMdSyyY
         hydGITioJZSvMpI/oMn+9nmDq29awu7aYugryeRROl62cADi+cJ0g/dhbmMdvGHDk+Fg
         epGqFY9DCa9cW+X7RfMcwK3Zllch6OHK0fwNrY9zgWhvNcNmkyMZmHlNo8SofxQdC8hH
         I20uwClIQFqCTo7SUAe1b60Cp/X86ETz4UXs86A5bMfZZRzQFuRkfDE/6ZLHBTNRFmhW
         CQWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW47nSC5K60yEBAe9qcDFWtA4xVMHcyLIDIPZQ1PUq0xo2DCVDue5Hnt/1BEJAvav3lg21v0nTI0xhIYlSXcDA=@vger.kernel.org, AJvYcCXVv51cjZrnf6CiCw+1CRik+C4tZ0pfQRBhssq8JNtcCAzBr2IcDlKL/KpGbbd2uYkgBb5hgjXeDv0mVsYz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1z4Tu+onzcLcBh53706djA1HIgGi0sEeH3LmA0pE91kOn+u24
	HrDpZ8Jt3HZs9tj1t+zL0dAJ9nvuiJ67LRsAvKdAiaFYjaWEqqpj
X-Google-Smtp-Source: AGHT+IF2lKwcu2657ck5gxeudUjTWht1t6K5qHLNTn06ITYmACxEnF6yEezmxaFASANVfwEza7fpUw==
X-Received: by 2002:a05:6000:1844:b0:368:3731:1613 with SMTP id ffacd0b85a97d-381f172108dmr11334219f8f.13.1731406345364;
        Tue, 12 Nov 2024 02:12:25 -0800 (PST)
Received: from [192.168.1.248] ([194.120.133.65])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432b0562ccdsm200920345e9.23.2024.11.12.02.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 02:12:25 -0800 (PST)
Message-ID: <13db01a1-1c8b-4d56-ac2d-9f39082c2644@gmail.com>
Date: Tue, 12 Nov 2024 10:12:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] mm: shmem: Fix error checking on utf8_parse_version
 failures
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
 Christian Brauner <brauner@kernel.org>,
 Gabriel Krisman Bertazi <gabriel@krisman.be>,
 Andrew Morton <akpm@linux-foundation.org>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241112095449.461196-1-colin.i.king@gmail.com>
 <3b865b4a-5d82-4d11-a60c-f4bea6cd25c0@igalia.com>
Content-Language: en-US
From: "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <3b865b4a-5d82-4d11-a60c-f4bea6cd25c0@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/11/2024 10:06, André Almeida wrote:
> Hi Colin,
> 
> Em 12/11/2024 06:54, Colin Ian King escreveu:
>> Currently the error check on the call to utf8_parse_version is always
>> false because version is an unsigned int and this can never be less
>> than zero. Because version is required to be an unsigned int, fix the
>> issue by casting it to int just for the error check.
> 
> Why is it required to be an unsigned int?

It's being passed to various functions that expect unsigned int, so I 
presume it was intended to be of that type.

Colin

> 
>>
>> Fixes: 58e55efd6c72 ("tmpfs: Add casefold lookup support")
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> 
> Another fix was already sent: https://lore.kernel.org/lkml/20241111- 
> unsignedcompare1601569-v1-1-c4a9c3c75a52@gmail.com/


