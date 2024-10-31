Return-Path: <linux-kernel+bounces-390499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749209B7AA5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7451F22C1A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A37319D06E;
	Thu, 31 Oct 2024 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WU8IeSpN"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163EB19B3DD
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378122; cv=none; b=Ben3Hq3l0KJKWr1hJgy2HfrBXu5AmXEWsSNfKv2DfzjhYn9gFW7Ez1xUEw0Z8lMquEVFDLd2A31RYCfz2ipO6Lk0yJZwUJY8ibzJF3SG6fUboDCuPA12WUh3jmJISHjMkqU0ztuMshGE0yvTtLTg7oleLdzjERtKbIo6AHb9Pzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378122; c=relaxed/simple;
	bh=HNw99ZBoCtL9gebq7HnHLHFtZ02VTCgq3uG6OiI7Lpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2qTbQU1g86vBciFBUMsFdzFGapsgMdI4imCNIn209Wyv2ywEfa2MsoVGWIdZxXoxkgtrBCQShRTzA+wUkVMGjE/iIqEfnqis8g97cSn8phfFobXCVcGxPcAXQuddD3AIE+ybzJtksBPIgxlf5KpgFLdLHHT6NgzYXgvEoqgDJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WU8IeSpN; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7092dd03223so258958a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 05:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730378119; x=1730982919; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HNw99ZBoCtL9gebq7HnHLHFtZ02VTCgq3uG6OiI7Lpw=;
        b=WU8IeSpNiAnaRF36fC/vv7+zG9kGiWFWgWmP8p3Aw6FVgF4xhmjb/fYznNZUOZuH2u
         be1x8nBg6wuJBmFMgfK7UTo0crhdYoraukbHqoqYDTb1CHJGYxwMwOCXjIgbkJTnaCAw
         D/Fi5/noZmiyrt+b3zzLhwe8CoFC2+AXpabfgw2lzxHjksb0US4ZHeirrGU5Dl1dIupi
         60yrAmVUgiz/AqDQcI5DQKjeJ88KlVhGvB8SdUdSVyk+DuYJulV6mEomv3YT5BWR8WZX
         aF0RPimWRgK/z4wdfchtSQMEsjWGgkyUsgLYkz5ldeu37w5au0EYbl0BDZy8MfTN6KcE
         f1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730378119; x=1730982919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HNw99ZBoCtL9gebq7HnHLHFtZ02VTCgq3uG6OiI7Lpw=;
        b=np3daqPXjEGYsvfykEQsIW4cTWz/6F/2e9e4OjZNJlV8nbcwmhuK/dykKf6JZRE1kE
         oA3DpPnbne6IJcmNmWtrN/pjiTPmoVimS5Now9bQUsfq3wUQBwAuaatKxK359HoQoC/7
         cMTkKp7IwnkhtSUKAsMkXz1dwQIGe/r9h2DF4ADefftmKqAucMVPQgL8od8Q+bXt/cnR
         YFuW5zP/1QLnVbZzwwruw/zZiO8nhtKl+9+yQtS0GCOvqW1yQzTo0tLJ7GT3mKUBZF2q
         eeysSc7FWaNMUNfXs9LCB0W6sYaxuiyi9bRVUjvC94WAq6eUrxV1AmBS3GiW5q/o1tfi
         no4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6hIfOSrToNQUWpn2SmI2fZkhZr68Mus5hO8Ns2ZFnQbBgtNUz8ayElRL0hdZExKA0D9zC85xensvxP7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPtebpKoBLJA1PvSxnYbNLLGB9iHv0o9SFXjmxgwoqi3SNtJpL
	oJtcSzS2vgPWOe2aswIie/il/q54vSzf6rklwlU8nAdF7p1ct0ydZLpsm2P5o13Q06YFxXzv3Z/
	VmNc7XjAIeXieNRxUKC4l8t6poziUGv4GmUJoLg==
X-Google-Smtp-Source: AGHT+IEkKbJXyNqLSsuHdItgZxyQY+mBzja5TSh+tq+4mVxz/XjBn5K2/1nC62dW10Qg5qYRGU0KEBvvMHxYsE/WEXU=
X-Received: by 2002:a05:6830:2b07:b0:718:9989:efac with SMTP id
 46e09a7af769-7189989f002mr3434433a34.18.1730378119050; Thu, 31 Oct 2024
 05:35:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025131442.112862-1-peter.griffin@linaro.org>
 <20241025131442.112862-11-peter.griffin@linaro.org> <b5dcd5df-7215-4679-a6be-c45d525e8051@linaro.org>
In-Reply-To: <b5dcd5df-7215-4679-a6be-c45d525e8051@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 31 Oct 2024 12:35:08 +0000
Message-ID: <CADrjBPoRTidJbUmC-gMDaEJRkF8iPUiGHWE89WJ2=+Ja5s1mRA@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] scsi: ufs: exynos: fix hibern8 notify callbacks
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: alim.akhtar@samsung.com, James.Bottomley@hansenpartnership.com, 
	martin.petersen@oracle.com, avri.altman@wdc.com, bvanassche@acm.org, 
	krzk@kernel.org, andre.draszik@linaro.org, kernel-team@android.com, 
	willmcvicker@google.com, linux-scsi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ebiggers@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Tudor,

On Wed, 30 Oct 2024 at 12:00, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
>
>
> On 10/25/24 2:14 PM, Peter Griffin wrote:
> > v1 of the patch which introduced the ufshcd_vops_hibern8_notify() callback
> > used a bool instead of an enum. In v2 this was updated to an enum based on
> > the review feedback in [1].
> >
> > ufs-exynos hibernate calls have always been broken upstream as it follows
> > the v1 bool implementation.
> >
> > [1] https://patchwork.kernel.org/project/linux-scsi/patch/001f01d23994$719997c0$54ccc740$@samsung.com/
>
> you can use the Link tag, Link: blabla [1]

Will fix in v3

>
> A Fixes tag and maybe Cc to stable? Or maybe you chose to not backport
> it intentionally, in which case you have to add:
> Cc: <stable+noautosel@kernel.org> # reason goes here, and must be present

I'll add a cc stable tag, as there is no reason not to backport this fix.

>
> In order to avoid scripts queuing your patch. It contains "fix" in the
> subject, there's a high probability to be queued to stable.
>
> With these addressed:
> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Thanks for the reviews!

Peter.

