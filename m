Return-Path: <linux-kernel+bounces-325047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDFD975435
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407691C21B45
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BC619343B;
	Wed, 11 Sep 2024 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PZTGVg+f"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4C318EFC6
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061660; cv=none; b=qsuIjb6wF7AOvajhZsiZtClxXGZB904g7Cl+vtkB9ATfY4GdlKhnbycOKjJg4k5TZzqPzvNXTwn3GTxuhAY2LU0470ujApnid/6UWU5K3sVsbA/mKcTFPeZUk3pkceUsey++08PamTWcBm5mBYDMLrXC40VB7oLEHlYKz53PhoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061660; c=relaxed/simple;
	bh=RBB9U3nSPLz3LfWNIbVMmkPpgVDaDbv/tVjesy9aoLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iI8cpvnP8ROLeGfOujez4ql1/Hw2k9Ysnq8C3LWXIqVmgOL0JxiPjK0d/6B3ARyC6Yx1MrtFcZnlit2ouI5hcfIdvERb0y7IBKQXHXqRaTrtd6gjTdXNtk68CvpU71znsoCj7b5IWEMkq+ARXZEsNYfcRb0I6TsIYPHmIjAQGHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PZTGVg+f; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb7a2e4d6so30296525e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 06:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726061657; x=1726666457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MB0Q4T2mdFiQdLaBYLJ1gGJlfUGPo6tiAGibjtaIGi0=;
        b=PZTGVg+fELo5TFc9qka+BLEVeanCypHnsXqlaokB3090e5p+Bk8OB415RiFHKifsrQ
         koR/kaRtDyWa/Ey95WyqjpBG7m32E/YdMnFXkfKHQLTYPUzb7l2aBd7aZCyKojS/KBAF
         SN5WjUe5wgQeiLhEsXn92yEgqNjPWEBAuCVoZNZVefG6AufUdSQyWpMl2HeQMRRoxq3Z
         9ixdkOWG04yJl4X+ecuKHuqyIjAy/5Yid1Uxidaes0C3bQgJJPGUi6oJI9PIegsI9wPq
         /8NIAA2e64JECkN5xO6EhlVvSnfCA16hKUs31xWksaODRCbXH4MA7XxL2dF1wlCSGQZk
         zWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726061657; x=1726666457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MB0Q4T2mdFiQdLaBYLJ1gGJlfUGPo6tiAGibjtaIGi0=;
        b=TiaN4z4jiF1QRVeKiT/YRY8+g94eruCnNuLscbEh54RWTUGD+cKKnxpV06I1ATCmgT
         kk2tl1RmmwujrVBzSfBjcXLNAMgMuiW896KmV+v1FHlsN2iAia6scYTjDBYPJirYnHhm
         6uNOz4dgpz/9RlBrJFtQ2NOwdV7XW5ipyvPYVkhPP/0RrqIcWC4D/RUzQ19/vhHJmH7B
         E5KdLIhO/dFxR/gQ79Iuld6OctEgL5MBBfHYsKP/Mwrl6PWQHkC4AuuCppUATRoRCOp/
         QU26O0bukp2DtRCB1Ob9g1eb8a/7cSGeMJ1g6IaP0OCSfAWJVeGIYb8HbWfFpdkhnuZA
         jFzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRqW17nrHOwgw+Baa2h/tIdoS/R1FDHvlJr70DwRfYrpuaK2zBl0AfDcZeTa+tUwwRe6i1MDAWkv1RuMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNLEJ1fhVI+14hEdNKqVG32050TMGXNr5/Z8txYANfAeoBIFB0
	K8YdXcl3E/2UEQTU2xwkf084jvnMrYKcPq/8CZGcBmMYnajReJ8ioIe7VDMDTA4=
X-Google-Smtp-Source: AGHT+IF98wgFgdZoL5ZA1kv4nH8IozI2BgdEwrj0ERU2Y51rnQyfegBRzlKUpQnoFwoGO41WvSg48w==
X-Received: by 2002:a05:600c:511f:b0:42c:ba83:3f01 with SMTP id 5b1f17b1804b1-42cba834352mr63281025e9.8.1726061656786;
        Wed, 11 Sep 2024 06:34:16 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb21a4esm144532995e9.7.2024.09.11.06.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 06:34:16 -0700 (PDT)
Message-ID: <f74e73b6-fa0a-4533-a9de-3c5dbc4399f3@linaro.org>
Date: Wed, 11 Sep 2024 14:34:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test: Silence perf check subcommand when not
 supported
To: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
 hca@linux.ibm.com
References: <20240911122850.926303-1-tmricht@linux.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240911122850.926303-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/09/2024 13:28, Thomas Richter wrote:
> Perf subcommand check might not be supported and prints an
> error message when used:

Only in verbose mode though. Personally I don't like all the piping to 
/dev/null in the tests because I have to go and remove them every time a 
test fails, rather than just doing "-v". But as it's pretty much the 
pattern used I suppose we should continue.

> 
>   # perf check feature -q libtraceevent
>   perf: 'check' is not a perf-command. See 'perf --help'.
> 
>   Did you mean one of these?
>          c2c
>          sched
>   #
> 
> Drop this error message, the return code is sufficient.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>   tools/perf/tests/shell/lib/probe_vfs_getname.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> index 5c33ec7a5a63..697fbe296a62 100644
> --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> @@ -32,7 +32,7 @@ skip_if_no_debuginfo() {
>   # check if perf is compiled with libtraceevent support
>   skip_no_probe_record_support() {
>   	if [ $had_vfs_getname -eq 1 ] ; then
> -		perf check feature -q libtraceevent && return 1
> +		perf check feature -q libtraceevent >/dev/null 2>&1 && return 1

There's another of the same in tools/perf/tests/shell/test_task_analyzer.sh

With that:

Reviewed-by: James Clark <james.clark@linaro.org>

