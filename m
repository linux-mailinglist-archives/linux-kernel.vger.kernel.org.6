Return-Path: <linux-kernel+bounces-339372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 274B098640A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88781F2446C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D5B1BF2B;
	Wed, 25 Sep 2024 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PC9gRgVo"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1A7367
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727279178; cv=none; b=sFsSYeMWUAqZ6YWTJXmUPLBIwB7hI0HYR/2ii+T4x0XGxKH0XnTZSLakQYX9rYBV4Oo2WBR4QwyPG0SpdicRWuxVGAI8w4hC+FWGsfETEKwDCnIT5bSyyHaRJiPAv4tXcG3aEKoRX/yFt0N0o8IVltAg0zS7N/iTuHUJXg2tDZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727279178; c=relaxed/simple;
	bh=x+4F0wBUmKeHDpIxKuL0c2Jd8c4z4haxH1Lz4gdI+B0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l0LZAAxi+40lFwET3ojbKZmHKHLG3K+/n4Ob1tGcJl52VGZK5zTNpEV2mqW9LDd+oJEOyIJx3nthHBFoNZJ+/FH5Uxsjdp4uIBSHWCfmwL54FkTZbCmw9IxZhWqsWoMXOIgHDxqiTypSTQ6OogfgAw0NnsJIAFaIG3jPMywD8Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PC9gRgVo; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-82cd872755dso303744939f.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727279175; x=1727883975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bJM9B0m/lek0u1t6zaan4eSGVrdWrKVx/I5Nl82tDpg=;
        b=PC9gRgVoBdTFbP/CUmjj8qpu4fOA1QUc1MXA98jYJFalliEKXucSUK5a/JmYxtNdrt
         1GorQ5NKg6gXGR4htfCIwdAz5SWa+WevsgaGrs2sNNRTbV2xm6g7FTCU3PxhYfcVSkBe
         N5II6CsvQ1LhBPL2FEMfRsbT2YZMMwIa2Guhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727279175; x=1727883975;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bJM9B0m/lek0u1t6zaan4eSGVrdWrKVx/I5Nl82tDpg=;
        b=YJE1XpLbICMnVOiX4vvc+pTA01OKumuyV+S3AjqbrsIylpMB4KGM6v5L6s9oh6FpBF
         L/swks22TZUJD8JGN5PLr/QX4BTh0KZgJqxLQ5Q94Jp7GQzHFlZnbMVjwErsR01/Gdxi
         84O+vv6MBFPUeltoh4fRDtk2rsvhPqCNot+/EJNOHDdsNp1SYpFoZ/R2lGRggQ+0biOa
         gUfkV894PVU3nT6PmI5MPCz4W6ZDH4JACFvXngFvoDcSe1to2cJS3VUCYbSHnli0ntfA
         rOXtCwwOvV5LTLqMZuxzZJsS0rOZZHcKLD2Hps3VG+zO/wvMSIEIew0IIZMlv/jCRdr2
         921Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwMwbe70JJatVfc3hrH+F2tWPWqimX7NoDVd8gUtUx2v6M6a9QNAiCLDnqHsktMv+LLQc+t0DM8EYgN1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF/wRlGjjOjUQOp14w9Ch703IY6eoIsqt7qRyT/bCdM4h1WCGy
	k3TioDDT8J45mIyooU8CMLzi+X26MuZ5NZKuWsHPePQ/XtYYhzhvJ5Q3F4lIwh0=
X-Google-Smtp-Source: AGHT+IHRidj4X8LYl5IH0Bj18RNFExR+Bckr7+2ammy4QZdJGrRo2Cl1ySSH9rbblKME1zD62cNhWw==
X-Received: by 2002:a05:6602:6424:b0:82d:f4f:f49b with SMTP id ca18e2360f4ac-83247f9003fmr365137839f.16.1727279174659;
        Wed, 25 Sep 2024 08:46:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8323f5dbf4dsm112899639f.11.2024.09.25.08.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 08:46:14 -0700 (PDT)
Message-ID: <e537539f-85a5-42eb-be8a-8a865db53ca2@linuxfoundation.org>
Date: Wed, 25 Sep 2024 09:46:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] selftests: exec: update gitignore for load_address
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Allison Henderson <allison.henderson@oracle.com>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-mm@kvack.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240924-selftests-gitignore-v1-0-9755ac883388@gmail.com>
 <20240924-selftests-gitignore-v1-4-9755ac883388@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240924-selftests-gitignore-v1-4-9755ac883388@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/24 06:49, Javier Carrasco wrote:
> The name of the "load_address" objects has been modified, but the
> corresponding entry in the gitignore file must be updated.
> 
> Update the load_address entry in the gitignore file to account for
> the new names.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>   tools/testing/selftests/exec/.gitignore | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/exec/.gitignore b/tools/testing/selftests/exec/.gitignore
> index 90c238ba6a4b..4d9fb7b20ea7 100644
> --- a/tools/testing/selftests/exec/.gitignore
> +++ b/tools/testing/selftests/exec/.gitignore
> @@ -9,7 +9,7 @@ execveat.ephemeral
>   execveat.denatured
>   non-regular
>   null-argv
> -/load_address_*
> +/load_address.*

Hmm. This will include the load_address.c which shouldn't
be included in the .gitignore?

>   /recursion-depth
>   xxxxxxxx*
>   pipe
> 

thanks,
-- Shuah

