Return-Path: <linux-kernel+bounces-575375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 484EAA70179
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89F917D054
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90452259483;
	Tue, 25 Mar 2025 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdF+eMkD"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE8E265CC1;
	Tue, 25 Mar 2025 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907311; cv=none; b=A2ZWhoID/1GRSdVwA5AaR1X6u6rrodnpb98DqQi52FiAxh5xR/nJkS2A9G+8GyL01fdWbFTmHaOd3t5i9P3avIhc5+Y5CFZ0coQxlwMii3ApElJ7DfsXcNDrzRCnnE0Fo45qsrsQsnwjp7jwzu0Nq6gzgb4+27slp2wL4A/+pHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907311; c=relaxed/simple;
	bh=sGjwtT0kQqdaclvo0LNNYYTMJppQyf4Ly9g9aW3Wghw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mMxCl7BL25JqRJAk1AkyEvrIzZ7FT1vGGyHeQ9yTX3IvvcWJmBHyn42/D0a4PhEc/ZgNUSz5nUmqgsdVjdOw08Ru3LjcBIH+LqX/M+E4RqpvH22l8mqUlJC78hs17Ecqp3S6/inZlNVrVdMyX2/N5lbusLpUbpDoTLKtLNm8Uf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdF+eMkD; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-301d6cbbd5bso9487452a91.3;
        Tue, 25 Mar 2025 05:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742907309; x=1743512109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=D0M6Zo04/7HwG/RGrGKjHsDfbnEgUUvFdZ8bDedEanc=;
        b=JdF+eMkDk2hYcuLdt3cRxWsCoyaDK9hcVNWjqklKpYaTNBFuULfR2SIMSaLo/SqSqN
         iFnvnqLBglPQWAfpD+CfSTePmUXfCJmy91CqZ5ttSkeSLNR5uMfK9zKxWxfz86eK6Bu8
         JxAWUM9FaTi8YeIKjLIwn6CJ2cyhejVciBbZWivc0xDarN6ejrndYMez7LF8Nv5sAiI2
         fDLMAd4Xo+XRD4kVSuNw5CK1pmJ+gjpAaRz/EDODAKdN6j8P1Do9aBHwFiIGVnKIpatz
         QC/AWvM6x9xxAlVxy/wagVOrGj3TvuamqSNCtPvAai+T264KsBQKDF0TzyCebT8qx22Q
         VOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742907309; x=1743512109;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0M6Zo04/7HwG/RGrGKjHsDfbnEgUUvFdZ8bDedEanc=;
        b=HffLOPS87mF/sLjsVhvKTLvoDgmfwfr5wOYR4Eb5GmeJiq3TuwOfdVnRbzR85p2Jsd
         zfkJwebYYoUXKMDtgnauInvgEBCcNmfmZdJ5l8C+DWCoPZiehZjfUluFf5822mBDCrvd
         5aJFeCbauwDb0EnVBiQpS0AvQxpZqhg259wTLQp18GvAOa3rcKFalDw9IzuisfjArKop
         UqwPyjJULCyTDdAYghXOUxqisHVpYUBpRBQK/Nfw2Dsb8uBRHjGw5RWLaf+tXE5zszHu
         ZVnx7xXtkpEt3pDCu7yWqOLdPHDl4Xpp2/ujJHVJKbSrPhyRRhRWCi+K9oAUhzKr4yda
         qE+g==
X-Forwarded-Encrypted: i=1; AJvYcCW3SKEYD0KlJMR4UW+JF3W7uq+WmOx0m+Y8lZ2j0eeKCCvQLvVNROf1eUcDtq66sB/obwMgn/zERPRjxxrJ@vger.kernel.org, AJvYcCXdWcPkQeeK0vx8zHIFzVPf/BdDYrj+PKYKTbQK3zse3CqyEqL4ik83tNv7tgzARBtZ3/VbGMy5Svc69w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxvg5LSYyU3kZqZBF+nkW/vSmnlqGCPdGoTqFZBYcpxj4q5vES
	x9Y2S4t/MzEpi/DG1R/v87K2vj99BuL/QYSUnFLFEOyjtTLN1yG5bgOzrA==
X-Gm-Gg: ASbGnctpU/QgFDvbcdxH9iyjVIeEy0Ip3iHbNKh40yjiin6dX10QzveRcE+p0PiLaMZ
	Uniwb8F8kVFNUDD3dMs8OhtS5qu4EsoHY31V19bnLTUmhzsmlfBrH3bB20smr38lwqNLdaIYTD5
	iisNkJ+BuTXSKIx1vy4rgp2FsD/fN2DaeNjq+6omOLyt/YmAEUExr+mW+pR674Amkkhuiur7271
	AJ/0XQZjs3ND/+qYd0mSVwbvHvLEa1OMQ5x1nxqbQHpErATSBd99GOLYISB1S3e/V16/YPCCtwI
	0am2lz/UdP+LMiWKjp0DZqmTgAv/QIEotHJPeAWSFUv/WmpJfsvaIAqiQnwQibM+xC3HKNLwBXS
	VY9qV7AkfPRmHKKC+WQ==
X-Google-Smtp-Source: AGHT+IGJ1A8WXkWv8tqL0/mNSt7XlUHjXISMclbtTcReoINaJs73G3ltq9M2MuxPVp6zEKsl6s0+Og==
X-Received: by 2002:a17:90b:1d46:b0:2fa:1851:a023 with SMTP id 98e67ed59e1d1-3030ff11268mr27748126a91.35.1742907309239;
        Tue, 25 Mar 2025 05:55:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf58c813sm14143078a91.18.2025.03.25.05.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 05:55:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <aa034893-405e-4f71-8cb6-0ccb112c36da@roeck-us.net>
Date: Tue, 25 Mar 2025 05:55:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hwmon: (cros_ec) Add set and get target fan RPM
 function
To: Sung-Chi Li <lschyi@chromium.org>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>,
 Jean Delvare <jdelvare@suse.com>, Benson Leung <bleung@chromium.org>,
 Guenter Roeck <groeck@chromium.org>, chrome-platform@lists.linux.dev,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250318-extend_ec_hwmon_fan-v3-1-4c886385861f@chromium.org>
 <e4da28be-66ca-45d3-9ccf-34819460b463@t-8ch.de>
 <f50221fd-1d76-465b-ba53-62c08c6f8536@roeck-us.net>
 <780ce6e8-11fc-42be-b4a7-9cffbf811d78@t-8ch.de>
 <42c49b0b-cef0-49ca-a5b2-5bb05eae8dec@roeck-us.net>
 <45d0681d-3446-409c-8d9b-0309dbb93ff8@t-8ch.de>
 <7b5c4001-1a5b-4ea0-aca9-e0c88ec7a98b@roeck-us.net>
 <Z-JYQyxJErCQKo4i@google.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <Z-JYQyxJErCQKo4i@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/25 00:16, Sung-Chi Li wrote:

> 
> Currently, when sending the fan control setting to EC, EC will switch to manual
> fan control automatically. When system suspends or shuts down, fans are going
> back to automatic control (based on current EC implementation).
> 
> Do you mean the driver should not change the fan control method if there is no
> pwmY_enable implemented, or it is the user that should first explicitly set the
> fan to manualy mode, then the user can specify the desired fan speed?

The user should first set the fan control method to manual mode.

Unless I am missing something, setting manual mode means that pwmY_enable does have
to be implemented.

Note that the suspend/resume behavior is unexpected. The user would assume that the fan
control method is still in the same mode after resume. If resume reverts to automatic mode,
there should be a suspend/resume handler which restores the mode on resume.

Thanks,
Guenter


