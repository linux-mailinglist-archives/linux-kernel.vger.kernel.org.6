Return-Path: <linux-kernel+bounces-220356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC4790E023
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 01:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3622287BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A95185E79;
	Tue, 18 Jun 2024 23:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cmyWyxzp"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9908E15EFAF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 23:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718754273; cv=none; b=MztamZiXWdNpq52q/5BZRivHtx7uUttlYmMyZonDudTVN+HnaEDtu7pIxaSqxpHzTpZqtKhcWkQ0qF6q7uqmntfEN/CBOqRDtE5Kw9Ftw8up42PhUj5OmsUB+CSf1spo7ualY2Ey8ZrANGyLmbgBC/IFWw0jBqTeWfxx3T+pgyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718754273; c=relaxed/simple;
	bh=AUXRFG06DcwGhrTY3LEDdoAlZ/W9aY/Wgg4qr/4pmDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+2cP/QvWytRapD4gcS8vtzskYoOIbsdTbnqdPpR+V4MlMCLTgSMTz1kbfnivPgIpzQW2IYuMNRCeP5qDSIzqMV6YkFO3zOJ5lswtsbCNG+seuOZg5dlBoaOGqHVVsK6rm120Z7i8cun+cxOSVahl/Q+M7EzAWWTrXC+2SVua/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cmyWyxzp; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-375932c9474so3416345ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 16:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718754271; x=1719359071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LF6JwX5v6JwcSQfg0sAK1erZy9H9MjS5VLxFNiK67XM=;
        b=cmyWyxzp26RbD08foyDoo5DjA06D8C4KUSg/GbTqKl9qtAK4UD8o0olKgCIzDpbIPq
         ukcgVXKumi6JeViSAQPzpZoRe+ltkVhRSpg0VHCsE4yQLXO+CevmSdCFWe6peqMmxYx3
         KhJU81tiKdoKoHSqYBW/aVcBenRHEP0gcgLvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718754271; x=1719359071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LF6JwX5v6JwcSQfg0sAK1erZy9H9MjS5VLxFNiK67XM=;
        b=Jt33Mfnk1I8zDiMvHgsYUDQOYuRxyVvW0U8cZtB9nCWU5JAa+T1QXhrlqoH74nKkMq
         AexMEfKrq44w1ih+29dFiNPDjkref+ltG/7Mkvp0/89QCNb38iBxqdD1WUwJrhOqGpd+
         /L/v7A0MASZvDrlFm6ZzR4YwwuFiNW5GEc2qqqGWFDHYXDzbVtYQoUH+JcAHKvV0JJeu
         FooHrjl0Zk25Y1Fl6Cu4jkPHj8D78tgqQOVZU7kggt1ax9Zm9QqZd2Svw9ZJfDgilG9c
         kGRvOOJ9klE7EyCh27joHZyM1kQ2PsxVXk426ezaMAG9AH9Z+G9jhW1unUKWsPX4zOjj
         EBuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZZqTM8gOYobKPIAbpqJbhH54JeAxisms1PgGLjTr/936mOJGG084MDFV0qtxi70S9tsFUOIGEaL2j3J4ldQ0tkyvh5d4wrwGTJyao
X-Gm-Message-State: AOJu0YwQnXhT4n4Mv+5DSZQkFmkaWgxgUkU85O7jv84q7bcdBZuGBmjl
	kk4PgukIJyLhyEptdHYjbm1WhVe0X/MFeGPaEf+rtPqi+abXRoyY0sBWtN4lcHo=
X-Google-Smtp-Source: AGHT+IFNozUHLKsr2mQWALzF2PG097Fw+WlGQWqgjuoxKWN84J11NjRK4wqfc3QwlVwBuweVz+LvYQ==
X-Received: by 2002:a92:d24e:0:b0:374:88c6:385b with SMTP id e9e14a558f8ab-3761d6f3b11mr10963895ab.2.1718754270688;
        Tue, 18 Jun 2024 16:44:30 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37613f7a968sm2603405ab.22.2024.06.18.16.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 16:44:30 -0700 (PDT)
Message-ID: <e19e3512-6b6d-4c89-9924-d9f6899fff1e@linuxfoundation.org>
Date: Tue, 18 Jun 2024 17:44:29 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/16] selftests/resctrl: resctrl_val() related
 cleanups & improvements
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger
 <babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
 <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240610151457.7305-1-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240610151457.7305-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/10/24 09:14, Ilpo Järvinen wrote:
> Hi all,
> 
> This series does a number of cleanups into resctrl_val() and
> generalizes it by removing test name specific handling from the
> function.
> 
> v7:
> - Truly use "bound to", not bounded to.
> - Fix separator to use 3 dashes
> 

Applied the series to linux-kselftest next for Linux 6.11-rc1.

thanks,
-- Shuah


