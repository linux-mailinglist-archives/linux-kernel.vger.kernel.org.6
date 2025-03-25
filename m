Return-Path: <linux-kernel+bounces-575278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF34A6FADA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577A03B1638
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FE92571B8;
	Tue, 25 Mar 2025 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="2YbZ2L5i"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1B31A073F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742904906; cv=none; b=l/bLlZRMgdyBzXaL/gyM3LIgGUSKQIGp5Nh1xAWVxSjKmlq3mpugjrLwt2Jt/F84A2mLHLfThdNzSCfajf/4wkVKBJjQnuFhekvxztuZT9FlZablaMYQxH/sueoVkL506wpDuftfbdtQWnWMK3IbvE/HF74NWFW8WbvE6Vhll6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742904906; c=relaxed/simple;
	bh=UKbfjZ5E4QscHPOYkQaEa00cn5sNfmffGihktUEZ+l4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGj8EmR8uHYwCJGFQsJ5BFUbz3QRdmsoklRnaMIa0IE5NP73v5N+obNeizrEj3W/VF5A3pdH3fwwhqQ0KTTJ3djelJY8Sz3EK87P8ocb8SSnwmwJpi/kOiIvTn3PGXR+HhZ3XG/d7a0zdPafpuc2B9h8yKtBmdMY4Y7/A0+bz2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=2YbZ2L5i; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3feb5d342a6so3345555b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 05:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1742904904; x=1743509704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wC3ijQaBf4K8OWU+SDgw4P+7cyUwlTWZLf3LU7lx7Xw=;
        b=2YbZ2L5iLqqAq9w7CEQA1eBKRRLybpnJPvqMNezLnIZHB+01hRw7xydmdRS8yE40iH
         OSf/IbzWFtETS4TNhVZFahVq3o2G80NgVHqEFC1r2Ok7InCuxW9P9oE/MZSLJVGQ/JaW
         1oTcw50UGUahgKsMDV4MwKDkI+ySX0LrgSYvTO/tA07TU4jf7v1oeg9v8RjmkDbZGFLk
         0JmXOApxULnTaISPRZ6jVZAO4l0wzLc74g9CFt8R/FWM3j1rM5f2kmeY89u65Qc39i4N
         PspaNbsuS9oCXclBDnstBkzwMGUPrfruQHF5lb06+IDtzpcgdYkV8Fn0guWZQGuE/flY
         kvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742904904; x=1743509704;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wC3ijQaBf4K8OWU+SDgw4P+7cyUwlTWZLf3LU7lx7Xw=;
        b=EzGgXOqdbY2Fau4XRlq8iL/pDwgxHXqjacCLtJczAvJ+5QKnMD7c17B8zbArSieeEy
         wKcjgxjPVO1K1qe+vNR9N/p7QLkDcImHz5IM3kTKux7Ws8//FNnm0g6OHoYLBvsohFC7
         FuyLwjcGjZhdIBSRr3uHI1Si94Ffii9Ct7Gn+DwxFwU2CMqtuiUteYkP8RT5jha3tuSP
         bAeABXiLJ3KUMEq4MuGfff2Kb0ZbYJKqYfiemwSP4qYZBkNteCY0jr5cYVOG/ACowP84
         amQrApGH4gdKihwcp9OQ/Xkc/33FbwzcjeyFQFG0ZuTWpqOC5yXUdU15o3ggBXv1NyK1
         q7nw==
X-Forwarded-Encrypted: i=1; AJvYcCU0B0tQgmLuebpcEQg8KGjaX8zwKTHZzPhAfOfyyiweejiIvy5RXMpEizd1dTlpprrczsY+acnStC+a6Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUDy/tORJWaiKla4niKcdj3Kbs4L4OlVB1NcpJyVm6L8WtxGed
	CUT0eB9O7ynBMs5mRiGHHj5+VY2s+kcfFAJ87FmN1z3Nftel0dmPSoimvoD8i1c=
X-Gm-Gg: ASbGnctA/GdbpAXphegPMaFthz14emxsTcKk+QChB0Cb/wg6nEZ+/DojKhwYu6HVkwg
	HBzs7SxBv5j8ND3UHpcJoWxbCVg+dxqZVd4lmFeUjvBYZlkCPA+HTVTZbyamZVE3LbqwkUbEa5u
	qE8ZihvTJiIqNHOiEODSSTUOWNvp48e9Jz12X5hNSuDtQtRmbyP+6yU/KqMNoIcYZHZT3rpK26D
	/E/fm9YxEYF+QaYlmm+zhHpb6UapdE54HXgzRkxEb2IaD1WT2fVwzJ26jPnQA2ZE6gI8isIa1bv
	bmZeBHi9vln3C08mKLcJZbORMOZcX7cHItQc9cMpVplA5zLryBQND9fJJ8p3yRIqpGhOzP0hORY
	EnRD4Wtd4
X-Google-Smtp-Source: AGHT+IHZKE0q+q2yQSr22P7i6hKjZROug3Xpi7UzBNf6sOzdWBDPPxeLMvXTvddN7ZqquWTR4AKONQ==
X-Received: by 2002:a05:6808:384e:b0:3f9:a187:1f2e with SMTP id 5614622812f47-3febf7382a8mr10579611b6e.18.1742904903718;
        Tue, 25 Mar 2025 05:15:03 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3febf7927d5sm1974378b6e.31.2025.03.25.05.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 05:15:03 -0700 (PDT)
Message-ID: <a5477192-ee6f-4273-b7b4-1d9dbd7e7b50@riscstar.com>
Date: Tue, 25 Mar 2025 07:15:01 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: greybus: Alignment warning
To: Erick Karanja <karanja99erick@gmail.com>, outreachy@lists.linux.dev,
 johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org
Cc: greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250322065800.21361-1-karanja99erick@gmail.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250322065800.21361-1-karanja99erick@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/22/25 1:58 AM, Erick Karanja wrote:
> Correct the alignment of the parameters to match the open parenthesis.
> 
> Reported by checkpatch:
> 
>      CHECK: Alignment should match open parenthesis

I think this change is OK.  However you'll notice that checkpatch.pl
has three categories of issues that get reported:  errors, warnings,
and checks.  These are in decreasing order of severity.

Alignment issues like this are just "checks", which means they are
minor nits that are often not considered a "real" problem.  In many
cases, white space variances like this are done intentionally, to
make the code more readable, or sometimes simply because the code
that surrounds it used a different convention for alignment (some
people simply align to an even number of tabs, for example).

In this case, the change doesn't make the "look" of the code any
worse, and doesn't reduce readability.  It furthermore gets rid
of spaces after a tab that do *not* lead to the suggested alignment.
It probably isn't a necessary change, but I think it's reasonable.

I write all this to explain that these sorts of changes are in many
cases rejected.

I'll leave it to Greg to accept this, or offer a second opinion.

Reviewed-by: Alex Elder <elder@riscstar.com>

> 
> Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
> ---
>   drivers/staging/greybus/camera.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
> index 5d80ace41d8e..ec9fddfc0b14 100644
> --- a/drivers/staging/greybus/camera.c
> +++ b/drivers/staging/greybus/camera.c
> @@ -1165,8 +1165,8 @@ static int gb_camera_debugfs_init(struct gb_camera *gcam)
>   		gcam->debugfs.buffers[i].length = 0;
>   
>   		debugfs_create_file_aux(entry->name, entry->mask,
> -				    gcam->debugfs.root, gcam, entry,
> -				    &gb_camera_debugfs_ops);
> +					gcam->debugfs.root, gcam, entry,
> +					&gb_camera_debugfs_ops);
>   	}
>   
>   	return 0;


