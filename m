Return-Path: <linux-kernel+bounces-449852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 268C79F56EE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 20:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBB25188E044
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9B61F759C;
	Tue, 17 Dec 2024 19:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FSKIr84E"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE92F15E5D4
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 19:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464223; cv=none; b=DVY0iaxM6bm3850IHyIU3pQ5rmho97P72VHA9um1/hsj7X8M1ECQi6eDcGiJD7tg3Z0qUh0amPq2pSZXaUs+J0uwOapnGoM8TLqPqcBFZvR3oUwSQgzyy5f1Dpo6MFIPwzgFuqJktw+nHAv7C/iXVscwGeb3hqA/YiZv2Q/0gzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464223; c=relaxed/simple;
	bh=4/WYvqjtT4p40N5duXZd1a6TrSvQibqe7pcDkYt/F8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPl8qxQcU76Bppq2RlFXmGDxY+LxR4mIhX6IV7UufLFgtyhgR5P7790V90Vx4E+M73bvpaA+5rWZ3YFrzzwPRfEb57/fVSm3Lim2mbXaf+bPcIZDhKOVayQw63EO3UOx6s3VtS3/aDBMSJLdKnEvJ+WyhVjdvzdsJqTsdJgP6J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FSKIr84E; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-216426b0865so50456185ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 11:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734464221; x=1735069021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lxCICxJpXfei8MCzltd58yMQLgKqjwCA0gMAu7lAjwk=;
        b=FSKIr84ExXYkKAD6VFeWN6UH+uR2NgBqJODqZLZNKcKjR2HukDju7nlzN662qZOhua
         tK9ZGwuz/SBpUeJP1AOle6g9OIBt4bcW9b0tirGdusML0DfpOZJl1NKCu0wzNBf2n/5h
         GV4I+qakQ2nBXmmMK4T5O5/XYpq3ePZMD1dgoPVZnTyvGD1bz/oLGMx2VWwrCNcmEViX
         0uK0TnseeXmWJ7MCta1pPZe/e74Scn+CeFToLbsduf0ajdAAgAoT5WlvaLfmCvLj6pNv
         sO1JkQ0IKU8kPMkSNLL1eqwVhgZxU0YU48jktpzCsGmvqp5rSpb4mEZcAWJScCRQIb2B
         h3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734464221; x=1735069021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxCICxJpXfei8MCzltd58yMQLgKqjwCA0gMAu7lAjwk=;
        b=sCCJZe1tC8tJXJqIhddRkcWIIONHpsTvmR5PlBbCnYB/9kJuK2/LusL9mBNia1KLbb
         zoMsjNJDA4wmnGCpxnRuqseUNsO9nbOus/kXUeFJxN6L2/hwRTcgEYQ3sXWc3upftHHQ
         tMY03livziSRD1oEMunmTYgKAmnRiAGpjQtHqLKXeVwTqEwcOZuq/EZa+BZyhVUx+1iD
         d4Z7UxbJsrk5599Tga+vfiMbuphY2f9g+yS124jgGCTUyndJ5pM8AyU4yCi4mGN/LCdm
         DQ2CbKXYmhuSrofifeB+nfo7BdSDCmdLbhB6dWWjmq/0f5nzvkSIXliAp0fLTr/qvR3n
         3pNA==
X-Forwarded-Encrypted: i=1; AJvYcCW9SvzhT5HAayjmyNUtLGrXzCqlJDz/VYVxzFbCOcog19rMtNnpklKccWtzlusnOW5l9ROZ3/kFLIHp4sI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO3eYs5KZ+AsZtn87mAqz53y2iNPWRbhbHNoOItpCR6+opsO5W
	XG1g3S0JgyXLlb04HOYKuQNQZ+Ik/7srVin1k4aa6z1p9Mu6uyujNM6ISieSFkdh0/1r4H85H7C
	7MA==
X-Gm-Gg: ASbGncvBsG8odaEqirE6mV21nJJYIxYk+GT2+90WDyskfJkNAx9x8+G2z43jVgLw4UK
	pcrtXIGaCa6EfJ6yvRyxFSFbzVtqjJ1FQeIACMhjSYtCVoCp40rBF85sQysU/A8zOsNss2unNOF
	TvfhsBEeJv2Lo9IjDR0ABF5bwZMgvjP1jg37tMWojZUmmm16mWjpSG/YwAI+meFUM7Jn6NxQRKB
	dWl8yji2FNa3YZlPRQoMyv09ghGLKLWOiAJT5yKuhrim4rl31RaV9msYtC9K6HxmvtyRPmiaRYw
	ximYh1lrmLGRp7WKE0o5I59m
X-Google-Smtp-Source: AGHT+IE7HeidwXULiczKHkcCrFXy73r0XNQEw07ggxCtV6f/PJ01FEii3YlDMP9Kg7esnumM/Q6q2A==
X-Received: by 2002:a17:90b:548f:b0:2ee:8e75:4aeb with SMTP id 98e67ed59e1d1-2f2e91f6469mr171028a91.17.1734464220976;
        Tue, 17 Dec 2024 11:37:00 -0800 (PST)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e5cec5sm63162375ad.172.2024.12.17.11.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 11:37:00 -0800 (PST)
Date: Tue, 17 Dec 2024 11:36:57 -0800
From: William McVicker <willmcvicker@google.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Pankaj Dubey <pankaj.dubey@samsung.com>,
	Heiko Stuebner <heiko@sntech.de>, Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	John Madieu <john.madieu.xa@bp.renesas.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] mfd: syscon: Remove the platform driver support
Message-ID: <Z2HS2Y0nGBMgvz8U@google.com>
References: <20241217-syscon-fixes-v2-0-4f56d750541d@kernel.org>
 <20241217-syscon-fixes-v2-2-4f56d750541d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217-syscon-fixes-v2-2-4f56d750541d@kernel.org>

On 12/17/2024, Rob Herring (Arm) wrote:
> The platform driver is dead code. It is not used by DT platforms since
> commit bdb0066df96e ("mfd: syscon: Decouple syscon interface from
> platform devices") which said:
> 
>     For non-DT based platforms, this patch keeps syscon platform driver
>     structure so that syscon can be probed and such non-DT based drivers
>     can use syscon_regmap_lookup_by_pdev API and access regmap handles.
>     Once all users of "syscon_regmap_lookup_by_pdev" migrated to DT based,
>     we can completely remove platform driver of syscon, and keep only helper
>     functions to get regmap handles.
> 
> The last user of syscon_regmap_lookup_by_pdevname() was removed in 2018.
> syscon_regmap_lookup_by_pdevname() was then removed in 2019, but that
> commit failed to remove the rest of the platform driver.
> 
> Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

I verified this works on my Pixel 6. Thanks!

Tested-by: Will McVicker <willmcvicker@google.com>

Thanks,
Will

