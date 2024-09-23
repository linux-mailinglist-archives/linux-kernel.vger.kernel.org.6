Return-Path: <linux-kernel+bounces-335994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC1497EDCF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B69280CE0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58D219D084;
	Mon, 23 Sep 2024 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FLXL/g1E"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A414019D093
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727104189; cv=none; b=RzFoJU/dHOtWVtGcxVCan/aqZdzpLysStiTI/ccbASfFaEfxHJPNOFrq5UYhTqIW7rCFEZ8qw1PiGEehk7tIuLQllKg3nQZ5tugME6/N5SaXaJtzwr4DD+PMZ9OS4BhJk1rBV3gjZpMFnqj42JYKCFQI1CQOuBMYWs3OgnyOxu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727104189; c=relaxed/simple;
	bh=MlhF8ehNpI88dBp1nv0Vi4Pyk5dAvOsVXpOwtTVYI/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pIKllq7wH8MJTZKRvyCh58lv5KrM60Cr2UXNlOXE00+Cg8sV45E6G9cIlPHZBC5VnfOp1ahsKt0u64r8DK8FkAReQhmrnJ5Rwmhu9N5zZ+LyPc4QUeqj0hbXSDTIU41DijAl2J1Hjye/r1fnFP+deJzKmcTYcX/3sTSCeuapczA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FLXL/g1E; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a08dc09ac6so27203685ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 08:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727104187; x=1727708987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ti7v3Fv6sTAv0PRGJJlgJgiyxrO+5APnMuVBlCHcds4=;
        b=FLXL/g1EEnDO0QBP7q0To7XwSaBGCHIZYA1LlalIawZhQCV4TtpSgfubR+eOA2SO59
         iCdNSa2saj54Jm7HEsNDs443J1Zsqqo7E4luvKJPJH9/3FkQYNwJ7T+IFd/y4B2fM8a4
         fQRI9FVFCk5IkqduEcY/1208kpvH4eE4lnP+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727104187; x=1727708987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ti7v3Fv6sTAv0PRGJJlgJgiyxrO+5APnMuVBlCHcds4=;
        b=gFge/ARkaeUH2H62SQ3da025Pj+0C8c4xvmqcU4Ym2f6l4YgqTBtYaF7traWDfTXqH
         T6iBbvy3I3CuQPtksZV+dHaFTbyMVSTxnc3ZzhyT+baBBBj6b2HHtPgMhCWyoNglf6R7
         6yiq2Es+qM01NFaB/1jamUv0mBLWF2bnzOYg23zI5JT9f8m2VCAu4idoJlC9MJLEO/Ss
         SHQhGgxIw/xiqd40NlG3OoWSDgeb0u0ate4ULs5Yj5XQ9v9j6hW4uyW0ZyMxGnTrRPz+
         sBBZ9EHuKC7NNfCo9ntdjelgShltSyfxSza9qzk/ggzudOL6BrdB7YuCvjQ0sC+Nlb/J
         qS/A==
X-Forwarded-Encrypted: i=1; AJvYcCWkvnMD8jpiIHxUajSyav3CaOcBWG2T1HzI799Xi/sLpEG878tVmts+5xnNI6hYRLl6Ng0vaqOlX43nASc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI5PpApkh3qfMGMgSOWiukDBbBOPsEzW0qXFDoqqt4+KRtcvTR
	BHuUZO7+N04l0IFv52/JOlMLesAYKLvoY5K+8yfEFvUGcCkRK1iu9zEO0I9FLxg=
X-Google-Smtp-Source: AGHT+IGVEsquzlM9GoMVthtYSTofa1uUH3CuC0IK5mwuQqFAaLQIwX4GCYrj62qn7WM+7uXx7NF/6w==
X-Received: by 2002:a05:6e02:20ea:b0:3a0:9179:7651 with SMTP id e9e14a558f8ab-3a0c8b982demr97956755ab.0.1727104186559;
        Mon, 23 Sep 2024 08:09:46 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a0b6e604f7sm39552135ab.61.2024.09.23.08.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 08:09:46 -0700 (PDT)
Message-ID: <ab02dafc-e181-44db-bdaf-ae5ff9e01f38@linuxfoundation.org>
Date: Mon, 23 Sep 2024 09:09:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pm: cpupower: Clean up bindings gitignore
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
 "John B. Wyatt IV" <sageofredondo@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240919195626.26833-1-jwyatt@redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240919195626.26833-1-jwyatt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/24 13:56, John B. Wyatt IV wrote:
> Add SPDX identifier to the gitignore. Remove the comment and .i file
> since the file it references was removed in another patch. This patch
> depends on Min-Hua Chen's 'pm: cpupower: rename raw_pylibcpupower.i'.
> 
> Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
> Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
> ---
> 
> Changes in v2:
> 	- Rewrote commit description to use the paragraph format.
> 

Thank you. Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/?h=cpupower

I will send this one and the other fix to Rafael late on today. It will
go into rc1 or rc2 depending on the timing.

thanks,
-- Shuah

