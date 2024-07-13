Return-Path: <linux-kernel+bounces-251334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C669303A7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 06:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BAFF283D6E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 04:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C67C18C08;
	Sat, 13 Jul 2024 04:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="uwbDWDz2"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1C2175BF
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 04:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720845325; cv=none; b=J91rJEmeYtYteX1p/qjvtpK38SdqywwDLnFUu80RqpqyABzXD9gE4SgKZOHbhHDHsV91Iw0MyasXcAU070/dZkihBXP7cHrvsWKLKc1aojBtyuS5d6NhlRv9Rxpsu7y3KEopPZetCeTUJlKeVIsnEsHkUSzRAY4PJE0nyrvFO8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720845325; c=relaxed/simple;
	bh=lKgzL+30qZf1S4Wd7pdx8pYaBsMqWB2klohiFKOshAI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PVVhIzUu6uKUK2bbZ8vOXH91jB3otuVNNMtlvZRrhFomwE2mUUKDVGpJ7H9EB42JNjVlG4IsS5bX6XMDeL0HgbBp9akRTd8f36/xbjpcDQ7AnzUSv9MNAY63ACzGpRl0pWkK3atzpS/muNHUJfpoHyKD5q+4GX7vQgpqaVO1Y6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=uwbDWDz2; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70b0e7f6f8bso2373757b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 21:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1720845323; x=1721450123; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lKgzL+30qZf1S4Wd7pdx8pYaBsMqWB2klohiFKOshAI=;
        b=uwbDWDz2lw7zGGqpDP6tBVJJxUZx01XB4j1l28c4AmpUMs3X3FGEMrAbZi840wIUF4
         f/bqWZIp9KsbAGlv46kjWgPFY6dFdVHZM6jXxi3E6hnuqlXwTDtedhCjFnWDBvpB1fJu
         f781/yy1JPUkzmumyAb9zH+d8aFo941Dq8mzyGQa3S3298JDbitNw6gsmsIrGMzRUA/f
         GyCe0IrGoYbKDQOaBCBPXDkmUWGQZHknAQIOwNFY7CQRjd2MKXaMZH+sZE9pFYmMYV+f
         KD2HOOq6Dqx+eyzOhLAqR38pw+I/Ukgn1YWWCietzgUlUetQv1CikNfMm6/a3pXyEkPi
         Zidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720845323; x=1721450123;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lKgzL+30qZf1S4Wd7pdx8pYaBsMqWB2klohiFKOshAI=;
        b=p4//Q7f8ml7EG0jcGwusi726JPzRKiaxPpbmwjfFcfcl14GWFreDdIhzofQo3NAGHA
         owyN8b0uE0ljfxXoG9fybP6rfB7FPF07mmS7r8S62+/swvkuUi+Mu+ryLFgj8zc2huqI
         zTqgijZ4sJTNX/HOkMehKfbOwEguNLlhRTONKJbvLlmpba1CDt8H07h/vHolBgKrXTwk
         WgfPscDEI+UL1mwySZxV20a/j5PtPMczguF67QfMM5A3iXUB0qLgTyeGZZIvTSDBwHwA
         P8w+XElocQ/Alv+IBwN5x2bP/IDMI6rXHfDmqLl5GS4tEieDO+OT6GiE6BiqabtsvYTn
         F/zg==
X-Forwarded-Encrypted: i=1; AJvYcCXMwnRnwdBgJTYoupx1msBoqhTxxnm8QdtpH5ITRia8pcL3MR83fzsl4amLiqEvSzKUhkqOFSg/0Xt/rpXsMiXcNKPNl9pTGbENotEP
X-Gm-Message-State: AOJu0Yw0yloeRvjJKgcchiR0mbKoXiGO+dm6fZ1eadssaJDrjIx6w9mo
	TmbuZCVP3lpmfInIp3qYrj/vUVjPnMQE3fcqFdFnyKQdXHDW+C7YPp23A3qAue8=
X-Google-Smtp-Source: AGHT+IHlsTG9y4Nwef7rgZ1gxDUSR35+wfEMcc0fUV/pYgNzESx6ymbYMYbGIKdWBI+T9U1MrE7wJw==
X-Received: by 2002:aa7:8889:0:b0:706:31d9:9c99 with SMTP id d2e1a72fcca58-70b43362a47mr17227141b3a.0.1720845323274;
        Fri, 12 Jul 2024 21:35:23 -0700 (PDT)
Received: from x1 ([2601:1c2:1802:170:d7fc:57d0:ada6:13b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-78e34d2c533sm230717a12.45.2024.07.12.21.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 21:35:22 -0700 (PDT)
Date: Fri, 12 Jul 2024 21:35:20 -0700
From: Drew Fustini <drew@pdp7.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Add thead to linux-next
Message-ID: <ZpIECMEzy1srRfe1@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Stephen,

I've taken over the maintainer role for for T-Head SoCs [1] and I've
set up a tree that I will being using to send pull requests to Arnd.

Please add these branches to linux-next:

thead-dt-fixes git https://github.com/pdp7/linux.git#thead-dt-fixes
thead-dt-for-next git https://github.com/pdp7/linux.git#thead-dt-for-next

Thanks,
Drew

[1] https://lore.kernel.org/linux-riscv/20240620162522.386-1-jszhang@kernel.org/

