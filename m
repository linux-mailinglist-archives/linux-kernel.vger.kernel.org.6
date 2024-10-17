Return-Path: <linux-kernel+bounces-369935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49D09A249E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 266FBB27E39
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214EA1DE4C8;
	Thu, 17 Oct 2024 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bZVI0BD0"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA241DE4CA
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174209; cv=none; b=VnpUjv/5tXaxpXxmf2dV3iQPPyuIRQwhl8ysP7cXYLedIeKj6B/A6RgMUt3HLL3OOuYDrRKOnz335JSIOT3HLGprOK4aUrBPrRAx5ClRr5+idUMjzqyybjiXvV/Eim2rxF7b75MBq8R+JmrNlpro5hV1ltyCg748iENj23oxdSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174209; c=relaxed/simple;
	bh=ImKjS1mAlM/QGNcooKsvSkdmdgnP6JCFSjvMcq5jt2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kk6KkqKi05QOLIIP7Q/qOYRoVXlRMZ4X2Gwim44MSFutW5+J+OzkDa7P7Noqv3NmMwxB02Ki2ZYnLc7jN8YjmUWqbbUdRE3XMf2pRMtD3IxOFGjDiwEIXp1CGiU71yv7R+hi+l/N+TVRcVqBTMCaG5xW5WmDLoN4Qs0JzWgv4hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bZVI0BD0; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f84907caso1273877e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 07:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729174201; x=1729779001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ffWX4sOiGU0Gsj52d9Xu9O70WErhSlef0BU/L7bSCGY=;
        b=bZVI0BD04kEtK/l/7PQ3x1QdrXMwALUErZEw7IrgpfTZQZl9YoM6LTlsEoGz93ynlq
         c9mzxhucKmRLdXectCeptS5Jkwkr9gdfGWVzAyukSkl0WAGIRWwJyYC8ymyFcez4nBqH
         djVKSuEJI2oXLU1GGbXNkVAc4Ud5C4TIY60gBkAggx/Bc1WihSkBGwG9EN4jOL83DfXo
         +NVF3Pd/ZvmzEMrhaP6HALHOQdiTkDk8q87/+7i0dtUhhaMyOsPEgNVKX0fIbnhmOg5G
         eQilvHjSFRUFgyFLE5Y+wSTaKHhiVuwchyHkjHYBmw4Q/lH1n6Z3jpams3T5zl/1yZid
         UEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729174201; x=1729779001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffWX4sOiGU0Gsj52d9Xu9O70WErhSlef0BU/L7bSCGY=;
        b=F511ZsPygSLAKIqqOldcL0JBCoEl2mfzdQ4Y2FW3jryjpa3+Tx08mFQ7Y8uXDTLAmU
         28f0zVlUdTKdOhWFbeArIzdSkuxbdHWMWaojuYw/qA5frDrLxz4PN/uSPgmuGOK0k00N
         ux0Y7zLpw/krLz9D/VMrvgKTTC2pXUE5xK9tqyAD2GpwwaXp6+cdO2RzrCKgZ9pXCn+z
         xiRF9JOOjsZbVtrcVjsW4D7YXDsb3qYWflbydGaLP2tHHJ7y80NWVcOmuj+lBfrQiQ0O
         Hn/RobJLYHM6jizFa/dPZZRFQB/y2rEoyG9LoS3A8fYT4kJbSUgb2QRwTFoboEntyT8I
         GOJw==
X-Forwarded-Encrypted: i=1; AJvYcCW+QWuBZrX1ZdrXlZ8s3OaeXemvNybTZp+q09WX2IdWWMfCyWkH/5t5cqQ0VXER798kJ7MRrMHQNaxqWnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxEPPkf6r7KFYPcYU6ClFlJEt/aaZc2rjKwUBmfPi32KMDkYo7
	bP+zaDmDsGJX8ZsFSO5ewe0iSIpufpFnIXuRKND161B8natHP5IpqQMOtITAq2c=
X-Google-Smtp-Source: AGHT+IHtZ6iuGFS0h/96h+eqk0OJejp1EEqmyNTB75Id/1Au+oEGx2EvNsYPOJigxq2qwKknsnsYqA==
X-Received: by 2002:a05:6512:3b1e:b0:539:eb2f:a026 with SMTP id 2adb3069b0e04-53a03f36264mr5616478e87.33.1729174201351;
        Thu, 17 Oct 2024 07:10:01 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29895da9sm301265766b.214.2024.10.17.07.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 07:10:01 -0700 (PDT)
Message-ID: <cb0eb97c-bb47-4465-af4f-3b5dfcf41681@suse.com>
Date: Thu, 17 Oct 2024 16:09:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/19] gendwarfksyms: Add die_map debugging
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>,
 Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>,
 Miroslav Benes <mbenes@suse.cz>, Asahi Linux <asahi@lists.linux.dev>,
 Sedat Dilek <sedat.dilek@gmail.com>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20241008183823.36676-21-samitolvanen@google.com>
 <20241008183823.36676-32-samitolvanen@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20241008183823.36676-32-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/24 20:38, Sami Tolvanen wrote:
> Debugging the DWARF processing can be somewhat challenging, so add
> more detailed debugging output for die_map operations. Add the
> --dump-die-map flag, which adds color coded tags to the output for
> die_map changes.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Acked-by: Neal Gompa <neal@gompa.dev>

Looks ok to me, feel free to use:

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- Petr

