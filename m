Return-Path: <linux-kernel+bounces-238099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D58924378
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0248E1F237F7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F321BD039;
	Tue,  2 Jul 2024 16:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h7DeL/sh"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4F4148825
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 16:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719937381; cv=none; b=g++HwjktgJDJiZpoByRZcU46qoevVK/JgMWaLlH/sB5ZtzGWYUQa5QoFX3O01IwkfNZ5sbQbEeSWMXrK1sXWTjyaat6w7ZdssokFNoXvUtnCXzoNlLWdiHXErp51ekhthegKZiDgrD1AH2YIuX8ZNByxMlMqhDHHEzmHgQTXz08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719937381; c=relaxed/simple;
	bh=aj7Fh5tckyx4zu/F74GNuIwtbH6bAWyEVqrM39kj9s0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lSKZi1n/5wJgQfV+/DIt4rj6fF6AhvioatkDLGgZNQ/kaItAMEKIp6fpI123fZQEQddgMWffURg8TaDOeVqk/7xqh7H+Wdm7SSxhS0/wTKEADEU5v3wU5gs+F6ou4veY49eK59i3sVUdFZOFI479z6kFEoRDWuw1Sf1OV9jC3jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h7DeL/sh; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-375deacb3e1so2306355ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 09:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719937379; x=1720542179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2rbjjRjoLEssCm6u4+AV7tPUfRxSj6hss64397RvroU=;
        b=h7DeL/sh5Z6d1HLDp08A3MD/4P3jsy/7Nx7QgbFHfcP0kDWZI9U+lECd4d5jnSww65
         rjG/SkAip3XTpY9+TQ/asOTa381B4B4DpjqN8FMqD4licLeFCOCX97cjtc6A7VoQlNiT
         4d6doZpJv5Ef5PZwR8zj72mmInQZ3iSpTLkpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719937379; x=1720542179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2rbjjRjoLEssCm6u4+AV7tPUfRxSj6hss64397RvroU=;
        b=Y5LoCw+zQqVoyMWUtiNzZQLdeCc3NbsmZkd3aOrifOI5qkx78zpmxIsxZq7uz/z0S+
         RSkeFJ9ppOubp3OAyBN/dVPwLZR+If5Iy0OQeEJ+QeuL6W9OCNWuUKV2HV/doNlX8T5P
         8Kqrx//ASFRQKkXlOsmH59z1NhqH9vvVkGXCzSP8xMPMJzcx3B7XiyxJFmZDbgo0X/xX
         UMaK06gnHmPI8eTbZBZyfsJC3xcuwK3GGAsVY8OrIw5rb1d1dmVrpzN1Zrebu5x/3qjK
         bm3nzuF+3ibVSKLc3eK3SbzPlIClxU5jE+I7cq9URlGbUoFdDHtMXO5tKabm9HrUFKuY
         2t6w==
X-Forwarded-Encrypted: i=1; AJvYcCUnlPoDZE82O34Lf6pa9lW3gzfW6u1W2k1gMBFAZ1ToUHH31MZ5AF7N71RmR6AmsCSdM47bDr0P7h0BH3v5ljLqH4uiAkL6ZtM3APMh
X-Gm-Message-State: AOJu0YzRoRjtFG8OiBSY027wxfdgitnKVoSu7N1YdMs9UDY0JD72qFwI
	GBg8ONsaoDBRqtvmEg83d4Gy2ijD0blntpn14y6DYKTXMVo6a+Qt8lAXiTgUirs=
X-Google-Smtp-Source: AGHT+IFaE6xtD3QoZ0GJUmaljKznWWghEaM1pxbA7lx4mZdmW5LUG8WeCqAieecbB73l+pYHLBf7vg==
X-Received: by 2002:a05:6602:2581:b0:7f3:d3ed:1ca3 with SMTP id ca18e2360f4ac-7f62ee5c6a1mr876430339f.1.1719937378696;
        Tue, 02 Jul 2024 09:22:58 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73e05e31sm2811216173.73.2024.07.02.09.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 09:22:58 -0700 (PDT)
Message-ID: <3d7e1a06-28d1-4d78-b04a-ff9cbf85aaa3@linuxfoundation.org>
Date: Tue, 2 Jul 2024 10:22:57 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests/capabilities: Fix possible file leak in
 copy_fromat_to
To: Ma Ke <make24@iscas.ac.cn>, shuah@kernel.org, usama.anjum@collabora.com,
 swarupkotikalapudi@gmail.com, amer.shanawany@gmail.com, kees@kernel.org,
 akpm@linux-foundation.org, luto@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240630130038.3671507-1-make24@iscas.ac.cn>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240630130038.3671507-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/30/24 07:00, Ma Ke wrote:
> The open() function returns -1 on error. openat() and open() initialize
> 'from' and 'to', and only 'from' validated with 'if' statement. If the
> initialization of variable 'to' fails, we should better check the value
> of 'to' and close 'from' to avoid possible file leak. Improve the checking
> of 'from' additionally.
> 
> Fixes: 32ae976ed3b5 ("selftests/capabilities: Add tests for capability evolution")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v3:
> - Thank you for your interest in our vulnerability detection method. We
> extract vulnerability characteristics from a known vulnerability and match
> the same characteristics in the project code. As our work is still in
> progress, we are not able to disclose it at this time. Appreciate your
> understanding, we could better focus on the potential vulnerability itself.
> Reference link: https://lore.kernel.org/all/20240510003424.2016914-1-samasth.norway.ananda@oracle.com/

Sorry it is a NACK - without more details on the tool and warning,
I can't accept this patch.

thanks,
-- Shuah

