Return-Path: <linux-kernel+bounces-208302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF0C90234C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64D71C220B7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97D51482EE;
	Mon, 10 Jun 2024 13:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N1fIm3Xf"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565EF8563F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718027698; cv=none; b=AgdhCIPZBcizwG6Gk0G4TMxYGqYEjZmI2NNN7qsM823tykaUe5r41SBGQGUnDHjucIcDcy4TViAFhWgJ4u2DcwrDjjiXJAxkhzLWMBRlofqpRv2La5Gx5CeB9lnbJuGznkXDrAz9EWUnpjx+w4nRnN4C+popNJTon6X9yqLCg7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718027698; c=relaxed/simple;
	bh=ki43rmTAZ2DSDh0LcmlMo01yj3pL0uFTjHOQnIDSoMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AOichNQ8MkoeJ6eLSE7ckXL00WzxnxILKuc7N3z/YGvob5xjQXTX/EUn45dfEist5/V4fRnyOV+Lli0tu5vmFXyIU7fp5mHRjkz5JyRF+tbB3tOeYQnaTgeDrCZ9fkoPzcol7zP0c4pzg/RocUEzmdk1qt7IZNhb0kbY8nNqvsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N1fIm3Xf; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-421d32fda86so9360345e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 06:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718027695; x=1718632495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B5jcR5L02HgHvX5QCY1ajcgsHfEcPMZGN1IDlOIPxyo=;
        b=N1fIm3XfD0PwKjTrdYvCY4Htvk03K9bzgw06xSMBBRfFTFMf7nLkqrPkJ4gqwz03mE
         31PG4N71mJ586ur0iA7dcFZMa7c/kK4CP2GR4HAFfAc9nP2+C6C0NhjScNWUyGvMe5FA
         wiiSAMF1gHjivT97nwprVkgKSUzkVzLbrgXH3mDADgzupvFJavn+3KPqAFjwMuZnbAHQ
         ickq4pCtr9wOMAmP7gEOTCbRoVzjSVl38644a93IDfIYwaP9jmf5A8DfTnYy4dEh7Wav
         dg3CvVBxgkiE9EXhPAMdcn8zBijtglKMfOMZu3shcYqCNGbQQSXS1cLRL8Q30B1+sfMv
         w1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718027695; x=1718632495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5jcR5L02HgHvX5QCY1ajcgsHfEcPMZGN1IDlOIPxyo=;
        b=RIDD7dpYwfl5D4CIWf4JZMA16U6m18DwtOnBAZ6PuA3exqEs5cxNCiX2L2s9hUPrKV
         fyQ6V5msg05ztc1DWFGLPL7KUQ+4NxT/ruhjFbZZcQt+keqZGXIipy8O304EouXLf4QZ
         QyXYC47OdvKjl/BB2sv1a3F9/ubf6J9U8PslerRAl1gzxikYjO871cIAmcsO5Y3GnGoq
         Lt0qH390zBhzOK7wef+xUr8szbF8T67h47ofF7wUz7iz0CfCEY8itQJz67yTtVtpLcwd
         jDkBKSjlVy4kfEw7axwB0jdPx+gfuG2Lq4O2iMy1ZWfNqnWlEp/9H/LIlG5UcpF3vH4g
         P5hQ==
X-Gm-Message-State: AOJu0YzEqie9OuiQ8pbjbClJa2RfhScGqlsCHB2fPRDcgWr/jzsotuRT
	9z5xnFhsND4kytculYYaDA47hmK1S0yyhfcQelRvg2i8rTIpvqAO4eufWHOgEvs=
X-Google-Smtp-Source: AGHT+IH7jGU+FiZVAF0GNsVMTgnY/OvN2Iz19z/aTtH6QgaSwKjyFpwy6xOKmUeEakpoCZEdqiiL2w==
X-Received: by 2002:a05:600c:4748:b0:421:edf4:1e89 with SMTP id 5b1f17b1804b1-421edf42181mr23334825e9.4.1718027694682;
        Mon, 10 Jun 2024 06:54:54 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:bb3:9a3a:605f:c4c3? ([2a05:6e02:1041:c10:bb3:9a3a:605f:c4c3])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42182ed2b23sm50824965e9.18.2024.06.10.06.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 06:54:54 -0700 (PDT)
Message-ID: <ee2b258c-8155-49e3-b922-ffe8a0fd1d13@linaro.org>
Date: Mon, 10 Jun 2024 15:54:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] thermal: trip: Rename __thermal_zone_set_trips()
 to thermal_zone_set_trips()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <12458899.O9o76ZdvQC@kreacher> <4937015.31r3eYUQgx@kreacher>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4937015.31r3eYUQgx@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/05/2024 18:50, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Drop the pointless double underline prefix from the function name as per
> the subject.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


