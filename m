Return-Path: <linux-kernel+bounces-344807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6003898AE6D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92DB41C20AB4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FC817B50A;
	Mon, 30 Sep 2024 20:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dg9blAMH"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BCB21373
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 20:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727728325; cv=none; b=LZK7mC0dg8dHLiQNiKF9DIxDtezvXjmzFQF3ZlqWPxwf5ODgubi0l1GtmnrUcyDVRfBukpRm3Tqrox51l5rFZc9gWTfp2SVkzeHlOMEBCF3fbOneMepnoq/8uh5DW9fvtTHxxyImdEMTO8ZQRBxS2705Vc1eIr5M8Ec3B2k/wfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727728325; c=relaxed/simple;
	bh=iuTBkTsVyUwHG/0VX7MtzJpflCWh6jClaP5eVt/7IPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C+zNcFtWiwo+sfoCCkplAdU3ujcblVvBvS7AyoPMphbQU4Oof7d6B/m+vzlXcflJngEqQbJKLyCsfvTrmdQ+HoopI9wkXW94xr6/9RY6+LOsyb0TPaIfvGpoqM0BASVNIj3kmcIVMJ8npJmM/zmDxBwDPTk6QnrI3o88Vr/vxXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dg9blAMH; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-82fa0ccb0cdso187008639f.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 13:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727728323; x=1728333123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fh9PH2Jop7KznotYQEt9VOPK+AuZOwXiP4v5Ug8+hPc=;
        b=dg9blAMHXjsDSvMjGp6PaflU7q+fvbVJFchBu+h2kJ5zzhwFA6VKzGRgwW5BNgTaC4
         mEea/B8VqPC5bhm4pSQ4YmCRY+GNPDsr47Y9v/SClmP8JmA4d7rJNqgGNfohN+ejLqVd
         PXTdKOxrDZdBDRZPqR0HJlafjB7RbAEuFI+og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727728323; x=1728333123;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fh9PH2Jop7KznotYQEt9VOPK+AuZOwXiP4v5Ug8+hPc=;
        b=CueGDd9pzPyuS6+RCgiXj2p7dcaOBDZJlGV8liIexq7mED9jgwUliY8DVBc9sxt6kx
         MX4xMqxUlXV8M+0GDrGwySiLbpGWBXKNZSkmL/Ek9CBxbkE/96Mw0QbEAaYEQCNawUOV
         0YtEIc9xTVYgTIFF4Bmxu4Si2dOT+wRyoCxupHuQdS1rwrutj2Dsr1fqslycVUAm1BUz
         kWrCeGSdwUOzMV6aOSynR+q0+nq16o9sO/epTqwo2Fk9z3ws4bumQbhUfFqk7am4rc9J
         aWb+PQYNwEKS+sqdzRUime2b7j6/KzJcGLqO06ZRmreZIfG2xqKw+27l1neR4A7se9M1
         NiGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvYYnR+1OhJXxc3bjdG/cnW1rW+Db9MPW1R6JLbqOoYe4UBHIsikdIGliRJoFLgQVKriSOTpwsV3QO0Dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZn3LJNegBJvA9t10h2+6w0c3iNcJIoTuUy0zrtF0x9d46iPpe
	CFR9+asvCxWUb1PdrVq+WmQ6d0YhFlV0zbWbTCRJLg+5luWgVD1NtTFsos90M74=
X-Google-Smtp-Source: AGHT+IHiJKMaCXtddQeMdqbzlj9+mgu41HkyhLDB0xfNP3HkFbQViAqxH4ZR5Vmwe1Tup1wyJLXA6g==
X-Received: by 2002:a05:6602:1653:b0:82c:e8d2:f86b with SMTP id ca18e2360f4ac-834932796c6mr1072841339f.14.1727728323394;
        Mon, 30 Sep 2024 13:32:03 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d88884a431sm2269417173.64.2024.09.30.13.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 13:32:03 -0700 (PDT)
Message-ID: <ef99a697-5d3b-40e5-a917-6f983b53e5cd@linuxfoundation.org>
Date: Mon, 30 Sep 2024 14:32:02 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: update core.c
To: =?UTF-8?B?T2thbiBUw7xtw7xrbMO8?= <okantumukluu@gmail.com>,
 shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, Kees Cook <keescook@chromium.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <CAJb+kEmFoTXCKh=xSfCas7B=oQP1p8vnn5eoa=zn54FRXOOntg@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAJb+kEmFoTXCKh=xSfCas7B=oQP1p8vnn5eoa=zn54FRXOOntg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/29/24 16:40, Okan Tümüklü wrote:
> 1:The control flow was simplified by using else if statements instead of goto structure.
> 
> 2:Error conditions are handled more clearly.
> 
> 3:The device_unlock call at the end of the function is guaranteed in all cases.
> 
> Github request : https://github.com/torvalds/linux/pull/967 <https://github.com/torvalds/linux/pull/967>

Please send patches for these changes.

Refer to submitting patches document in the kernel repo.

thanks,
-- Shuah

