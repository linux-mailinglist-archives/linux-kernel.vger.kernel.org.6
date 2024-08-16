Return-Path: <linux-kernel+bounces-289310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF329544A7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105C81F23315
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07FC13C9A9;
	Fri, 16 Aug 2024 08:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nmbP91de"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB5D137923
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723797739; cv=none; b=X34LN3u49828pkyI+RVuNqNDOjOkOhYS+yzIm9Jl5VBV7OanNQGZhxojXkkczK9OL7jcFQfAXPe7F3KiN0Nm0xJuLs9vreNMG2aNGIBgZ8eI36X/QgaqQVtnwnvEROONPcREjSARds2ewbRvPZDDclOT/RjzREpPbMiQYdv08ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723797739; c=relaxed/simple;
	bh=0oLem+Qw7ToSbyPqLYeM0bwsjJ18/XCGqteG7JrZBqM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=InIzlQ6LQ4q+MTQ2pK+uZbNq1G5v5Gc/K3Wnde7pzXQLNIK3DHsJnM7Lnzzc4wHEQ4p3ecF4cjKvgDpwcCVWhBZ93t17Ecgv2T9eN1OqIt6OtHBuYQpP86bt2wipf1mtE60MYiB7LoSBHAUBK/RTs5Nxyp6ZibEllH4GkG1SDII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nmbP91de; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-429ec9f2155so6485555e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 01:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723797735; x=1724402535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Mf1jwtU1IEC5inSpAw3zK8tivE5WAs13EhnH9rtxkM=;
        b=nmbP91deSlmVc53sNgg2P288kTYh0BaMgP+CjpUxSbQIJB/axrKoeml6ZMMh44QSY2
         B8I8kQ/83DdrvnhP9lKpOOr1oKWQkYGH52FKZJ9A0B/90eu2QsxTZFRGUCBCiZNwqe+t
         DLrjvfZoh/FTfSmFyLexxlHuVNiOSkavWoAp7gqsmX4YdsR6HlzLFUpPVT31VoRUSjBr
         14QMvIJBLnd7HsZ0I1pZFTpUfuxh5dfRv2GFpi8XrWj4+ot7vF4IK24Khq5qn+YAF/gz
         bIbiQxG7Wkx5Yufr+xUS1mzxKxPNthP9lu2oCvB9bAMUBX/lT8c6tAm4qpoh3AviBwvM
         ygrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723797735; x=1724402535;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Mf1jwtU1IEC5inSpAw3zK8tivE5WAs13EhnH9rtxkM=;
        b=wi8NnUoXDibG38O20RvSNpnN25unPfBav/c5HC2qRERlqbuuhokge1PgNsSlsVwywq
         o6rlsEpUBkWcXI+5baGu+4fnDTKxGvsYCCk6jTyebFacpnBZ7nSh6+02onzWP1takIKb
         dkVfcMdcjiB0hBWP/vBRR+CnAjLQLtEBk7oJjvuDkk9ZNqJeDTwZ4MOTgwUPD+XSyQkD
         Uk5F7y7dWy4McOqVFiUdiE15D6PrDcw0HtcDCkCrbZBhHlfCzJ69+EDcxrf9mCfV5fj8
         qZYsETTOQmgFHMqm6CncRn0HjRbqsUiiUjg5IkqbqVy3S9/bpgKnfXax9CEYPoZMDccp
         u9Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVomi3bkqq7rgk0UUHGaE6iwRvoNT7YmEmclOmpFYjApMn4V+IMEmlH7TflVdyoi6YZZzLs0N4UH8h6JWGU/PZFRBIaaJ4e6La8DJBS
X-Gm-Message-State: AOJu0Yz3tTWs7OY4zAG/5eByEtYxGrEaRdChINxjBEvSYUwI8Y0Ktbs1
	IbQJM4Gi6AThluK7a4+lIwnHUUV/rfsEwnrNIpQ35lTFgn6eNMQKr363U1R7qXQ=
X-Google-Smtp-Source: AGHT+IEf7cfbN+gD7oBAopP7fq2DDt7WFnAIqgbBVgGTKPU7rB9hSONbmM2OmELOKV6w4B7AP104YQ==
X-Received: by 2002:a05:600c:4f4f:b0:426:64a2:5375 with SMTP id 5b1f17b1804b1-429ed77da5fmr14056025e9.1.1723797735389;
        Fri, 16 Aug 2024 01:42:15 -0700 (PDT)
Received: from [192.168.68.116] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189849831sm3134341f8f.30.2024.08.16.01.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:42:14 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Amol Maheshwari <amahesh@qti.qualcomm.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Sukrut Bellary <sukrut.bellary@linux.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230602113602.1271695-1-sukrut.bellary@linux.com>
References: <20230602113602.1271695-1-sukrut.bellary@linux.com>
Subject: Re: [PATCH v2] misc: fastrpc: Fix double free of 'buf' in error
 path
Message-Id: <172379773428.48571.12712764336372215330.b4-ty@linaro.org>
Date: Fri, 16 Aug 2024 09:42:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Fri, 02 Jun 2023 04:36:02 -0700, Sukrut Bellary wrote:
> smatch warning:
> drivers/misc/fastrpc.c:1926 fastrpc_req_mmap() error: double free of 'buf'
> 
> In fastrpc_req_mmap() error path, the fastrpc buffer is freed in
> fastrpc_req_munmap_impl() if unmap is successful.
> 
> But in the end, there is an unconditional call to fastrpc_buf_free().
> So the above case triggers the double free of fastrpc buf.
> 
> [...]

Applied, thanks!

[1/1] misc: fastrpc: Fix double free of 'buf' in error path
      commit: b056e4e23acbbbf12fa011caa781f7cecbd5b311

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


