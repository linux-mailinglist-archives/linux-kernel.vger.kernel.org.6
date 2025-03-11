Return-Path: <linux-kernel+bounces-556225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4FEA5C2D5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450741894EB4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4031C5D46;
	Tue, 11 Mar 2025 13:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BzbxxUSY"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D31070821
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 13:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741700260; cv=none; b=V7JjuZ9jQYcMe571R8OqVoT8p4kPK8j70kMOdcSSokmbsA5OTEflVPD/xZcHmDtNWP/jWWfVNJyYMIKSQ0sI/doQE9wyHz/epTQ9cjKgPwa3nAr+XiW+ApUggJqglT58gaxv4+T1S0Y6akv1qD3P6szY75wxnb2fy7b4W6ycrYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741700260; c=relaxed/simple;
	bh=Fv9bgoCj8T1HxxYViA2cy8fyVV76Oxipu9JiKde52II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PE07zxl/ERNZcegRPHbtx83Kji9b0bmQTL2PNRnuWwZ1jzwRlO9unJlPbUQNv3SVqNTgriTKzm3Z06XxsUfp9S1l1A4oQrzXAvDzftsD3pPnxLBwHSHhjFRKqFdSzXcCLkLwxbAKpGiBM60+cnHKwaIylI0YrLGIthwbHUx8h/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BzbxxUSY; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39133f709f5so2122534f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 06:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741700257; x=1742305057; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qLMXMTwOhKieWEK80byf0Odi49jjdtVmyVqKoQf3GM=;
        b=BzbxxUSYSUmdIkiO3hE/W4w7/6gj7nY00+KonJs7Y5Z3oRQ95RkoEhuBus/I9B58yn
         SPJaV+jYARBV4MVi6+OtOqa2WTMa66Jas49pXHblsymQDcLDA6ejl8MN/Ml3Q/1ukHAd
         5JGkTFCGl3qUJyr/JpWO8XATbfSnmq9e6bg4KMj8qOvsf1onOUNPEH60bMfHqgBfTQIU
         XbpJLHDru8weALQMN57aJi/t/ZNJ9dLsn00WJATQz3vqMzd+M/jA68CwUI9ZLcZU0HtE
         +JupquyaKhHiSA6i1BO8oqbqW1C8BgCWVD/CwXKPtVE3H9/XlRrsLWHA4QiyXulqJ+Vj
         BDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741700257; x=1742305057;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qLMXMTwOhKieWEK80byf0Odi49jjdtVmyVqKoQf3GM=;
        b=oUn4+RkHVdKa5kKXe9gSTiULGX5QdhySZ7PVBqARA9WDz/pNeUt0XDBVzlgpvPX5rP
         J3NPGYsDqjqCCK1TxQdIuVTERvm3KrqzuzqNkzFDt2Dw78ilKRXCvFPQ3DpF4Bxu8Gii
         2mRCeIduK9TTwxzm/1OQq5c6IGUmr1Q4xJhV5YZ7gvMheioUCpLKR5ChXwW5yEu974cX
         xTvJRq9XSsFuQ28vRx9AW8Nl945oJxwdgEXxSKzZrMQO5M/ts8hbaOKtF6nTg2Ng7Vg0
         lnmpe03wh4f/nNP9VOJ8IP5eP/Ob0IUxsS0zTXA2hlBi7M+w7831tGalDC1Z7vB+FqHA
         VU2A==
X-Gm-Message-State: AOJu0YznZXEE8BjHq1/sdhfO3iCUCnFsM6vBjCgxZVzIt9XzUSn72Na+
	pRbgj/8i6HH7llFwnpr+5n5h0vdJOQu5cQIVNf9c1I39eBSJ8gZAJb1JxhBcdlo=
X-Gm-Gg: ASbGnctU//LxBmIiQUHo4wuC3/XWX7g9VYJbQJkVMhwMWGI0FLKyCgMCcGpVOaXXz0u
	Pva5Qaf30KmBZ5+yVILi2tcN0cX3KjRQm4Qc0eJiXAXFPtje3Spnai8ieN1h6h9cGZuLUYCzmcl
	EwobhgUeuOun4hCYCJdaePHoeO7lpYkZ1mg/lOCbtxQKQUPEDc7TJvYRj8YPgONrUn+Q/AAbIz4
	G29PsG7r6PThu4/TsElH13rOxswqiXCp6fxHT6Sw3A97s2/yqgVf0NaZLH7bNx7/yVWdwpULPdS
	FB/3JOT589b7dGa30iw9CwJBzZBamAjJQTMt
X-Google-Smtp-Source: AGHT+IHnMSDX5ZaXtJ2dFla7HDmAssBc1J7kBf27eQZe4BxrcsGOSqTZlUY9mpGYXqZde/4Zg6VzWA==
X-Received: by 2002:a05:6000:402a:b0:391:2c0c:126b with SMTP id ffacd0b85a97d-39132d531c3mr15248738f8f.23.1741700256551;
        Tue, 11 Mar 2025 06:37:36 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af2810c348esm9560597a12.45.2025.03.11.06.37.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Mar 2025 06:37:36 -0700 (PDT)
Date: Tue, 11 Mar 2025 21:37:31 +0800
From: joeyli <jlee@suse.com>
To: KP Singh <kpsingh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	paul@paul-moore.com, bp@alien8.de, sfr@canb.auug.org.au,
	peterz@infradead.org, nathan@kernel.org,
	Jiri Kosina <JKosina@suse.cz>, Michal Suchanek <msuchanek@suse.com>
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
Message-ID: <20250311133731.GB17395@linux-l9pv.suse>
References: <20240801171747.3155893-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801171747.3155893-1-kpsingh@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)

Hi KP,

On Thu, Aug 01, 2024 at 07:17:47PM +0200, KP Singh wrote:
> With LSMs using static calls, early_lsm_init needs to wait for setup_arch
> for architecture specific functionality which includes jump tables and
> static calls to be initialized.
> 
> This only affects "early LSMs" i.e. only lockdown when
> CONFIG_SECURITY_LOCKDOWN_LSM_EARLY is set.
> 
> Fixes: 2732ad5ecd5b ("lsm: replace indirect LSM hook calls with static calls")
> Signed-off-by: KP Singh <kpsingh@kernel.org>

I have tested acpi table override function by
CONFIG_ACPI_TABLE_OVERRIDE_VIA_BUILTIN_INITRD option. As this patch
description, the early LSM can NOT lockdown acpi table override in early
boot stage now. 

Do you have any plan to fix the early lockdown LSM? Or I missed any fix
patch in kernel mailing list?

Thanks a lot!
Joey Lee

