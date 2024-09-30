Return-Path: <linux-kernel+bounces-344724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E8598AD67
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4473D1F22BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E0619DF50;
	Mon, 30 Sep 2024 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GNlG8G6l"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7861991D3
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 19:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727726019; cv=none; b=dxoerz2aYyDOo2uBYmb7OhLt0RlYoZTPFvDO20Un8Huf/6eMX5RHcKX/PvgOhldL8Qs1VU/AJgSOIEAxyTXzSw6lrJDSK5eFsTPZP6q+l6LZ01Fj0lJboc84by6BOTFvnkuckScd8Hltd5b/t1OjMOyRMgE5OQHrpJpoR6C0RbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727726019; c=relaxed/simple;
	bh=EQ3niX/K3BJ+aOU+MibJwldr/HNSkC3v9ilvWwnJ/gU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U3OSZNdyT4hFuAqbJvWWdMly+CvrHXNCbi567w+5MzYkiAREjP4FoRmC5Lxf3Iw+yJzC2SSCu7qwIQVL3crY1PRqGiPYLhaUMMn0PXkJqXsaiT4r2maCfqMq31XmVWRdizC61MrwuQdffHTfGcy/K/hCluYMwImd0Cq8J1H1AaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GNlG8G6l; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a0cbc08b38so24838395ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 12:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727726017; x=1728330817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y0c1OSnjeq19GYf4nlM2ePALyEZ+IQYTBspuIuHRqiA=;
        b=GNlG8G6lzaF+5ZzhNF1V2xcsFIQhSDyHc8Vyk6O2HZHnL5hhv0UXvuU94U8XWa9rxs
         UAoFGgutfAw2uMxImhPexHwhWUOgX/FQMEpd9Mb5GZ2oIGy/J3HFNf6UFPSbqOud34iK
         RvJmok9ja8rwubTV58T3k8u/7KnY4idSkko8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727726017; x=1728330817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y0c1OSnjeq19GYf4nlM2ePALyEZ+IQYTBspuIuHRqiA=;
        b=N08vR4ViSNBqDbgHwqkKGcdtWfP++cBmtlKz1/GMRRRaI9OkEyuZczmgRtqEAHy5GR
         nqgPh9l8zNg5V7KSW/XaqUNMVRrPhjp45t65R64gQC7pBji1F4L04Gkz/CU08E4mLC7K
         nUI9A52zouq1NviN7tI7JAyrVyRa240La1f1OmelaK7336UdVyeWwpK5Ct7JhoNtK4+L
         PmJyxWwVT/l0NjpOot4caJjM6SDqfiVjMK1eocZ1Cna/4kkDHxqp/ho/zUbVrMx/jgMM
         aJtUYNwTcBfNdyy5yL06NsVY4XNY8VfgE8Wn1qg0TIpnTlMh4G2u07mM6fdyAcmpg8Xw
         FVsw==
X-Forwarded-Encrypted: i=1; AJvYcCVnVU9HhA5uCsc1HBIIBSsSezqhUO6lxpuTE2EcwBU5GVQZ2NExBj6sXk+pFRlQOGc3cPDxGL8tNJkkpMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzct+Qqr3ebZb9TIg5prFHqvwfl6LQv05pDFKexxGV41n2cusgW
	46DKQrl38jx5lY6pGC4Yzl1uDXw2OhwI7NprbuMIOAZyjPhrcZw48Ab/13zt+FY+uyWdpu/ee9J
	Z
X-Google-Smtp-Source: AGHT+IEA40pmYmtY4M1k1g7RDrzT3qGarF+EhIg0WflDAvUWrmq7VmoGREawyq0GRW4ud7ur3WComw==
X-Received: by 2002:a92:ca08:0:b0:3a0:c23f:9647 with SMTP id e9e14a558f8ab-3a34514afc2mr121503965ab.1.1727726017160;
        Mon, 30 Sep 2024 12:53:37 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a344d925d8sm26298575ab.44.2024.09.30.12.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 12:53:36 -0700 (PDT)
Message-ID: <121f3d6f-bc4e-4366-9282-8fda40184e3f@linuxfoundation.org>
Date: Mon, 30 Sep 2024 13:53:35 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: timers: improve timer_create failure message
To: John Stultz <jstultz@google.com>
Cc: Gianfranco Trad <gianf.trad@gmail.com>, tglx@linutronix.de,
 sboyd@kernel.org, anna-maria@linutronix.de, frederic@kernel.org,
 shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <877cbz9x8t.ffs@tglx> <20240829153725.4437-1-gianf.trad@gmail.com>
 <54d1bcb6-b817-4ab5-be0e-aea34cfe0d5f@linuxfoundation.org>
 <CANDhNCrzWz0=5az1a9_-rzCYo42ex0aNbXgdso9sx55BAEp_jg@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CANDhNCrzWz0=5az1a9_-rzCYo42ex0aNbXgdso9sx55BAEp_jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/30/24 13:19, John Stultz wrote:
> On Mon, Sep 30, 2024 at 11:49 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>

>> Jon, Does this look good to you? I can pick this up if you
>> okay with this change.
> 
> No objection from me, sorry this slipped by me.
> 
> Acked-by: John Stultz <jstultz@google.com>

Thank you. Applied to linux-kselftest next for Linux 6.13-rc1

thanks,
-- Shuah

