Return-Path: <linux-kernel+bounces-357530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F06C99723D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 862F828367C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10AA19ABAA;
	Wed,  9 Oct 2024 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="nB3mb4pQ"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723291925A0
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492443; cv=none; b=UAKLWKo+O8D71Jv7hGmKu/Pz8ixy/EtEwqI+F6NeyrOitsyZMXoZdgMFmI/lNgnLLHpslhOtones2uaZ1oOZmvtNPwcaQnAFeCscixxt6A35kJsTpvSRwQHFbEmny22cjUtT1lbBntRlDhrJRZLz/9eadbdIskBvIYLUr185XaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492443; c=relaxed/simple;
	bh=7OKpaX0vTt3ZpWsPL9AFkKqd63HxkJPrYW7YJ1vto6g=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=RIUpxLQP7IrR6/ecL3TBd4T6uXlQRj2mz1Z9Vk4C7Qvr3ENjBwsPX9GExdub2YhfFkbPB/EGMPQwABUuhqsH3iV1Ezoi+LQf4WkwbBnbeBGwnvOkUgS12uQNCOKtDHZF3WwSHyegt7xSt1fmUetFWdiFB/wVY2S6PyHr93MEhIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=nB3mb4pQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20b58f2e1f4so48243125ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 09:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1728492441; x=1729097241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QfiegqTqluk30uW9InRvZdJt/6Vj6WI5QVJzRzWcgJs=;
        b=nB3mb4pQT3o5ayk1/VVhfPWd09fMX4SlaakT/zrh+wpp2Cw7R25WML3XzPJt4RCpyz
         Pkv7iBbPqM4G5mMjUv8WDggG1QeywkbLYv3Q45xThlZq/jTVwHCqDfcd7V2rS9G4t2dE
         UQYU0j+/6U318lQAOB5+1aFgv/oIRxQXomo5D8AHSx9M+J6Kee3YJFalG9xQEMrzqv0t
         g3ZzT2TpA06+1N6tZD7HWs5hX2b+UrrhH10oqXTvVLq6OGATqTuAWMZhUemrrSJYEAUA
         R7gODGWhVwOv9hXSk2AGAZJwj5bBu5K2gmLtoRQF9G+jHQVVtfOWevL45AdaW9Bp1CTP
         t82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728492441; x=1729097241;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfiegqTqluk30uW9InRvZdJt/6Vj6WI5QVJzRzWcgJs=;
        b=C/yi2+h5Q29hePe/NlvkODNr6HpJIxgDOtIk62IRxBKMc+BNLXwO4/FDfaT/pcy+pl
         pCMPAQzVP++Js4yYL66O1JR+rsT1ZpQgdZynOSG6BCZgn7JKk8IYRuRO3t7z8+IRG7US
         fS9DzRW36UChz2dSE27EM203dAasIOalOOo3n+oy5imViCLISPuebGYCNIBCfnBjGSrt
         pcHMoRrjKgB6qnIQZbBMmFSrG6MPqFxcUogfYtHYwy8Lb/qog1FfWNZW8YxBspa92EUu
         IXFsfgR1ZOuRUL8/klSxSJrMEhjkm9dZb+uAnEwIXzFAWQZuv/3x1CF0fp2r+pk2mawc
         8x2w==
X-Forwarded-Encrypted: i=1; AJvYcCWs1e4epBMkK9bkCCJvreZB7i8LmF8aRNn9HLIYW3TlSAwajf90Kn+500YF2VAjUftRjdeO284g7MOnfS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJrMqNFkGivNIId/NGvhjYV2LGA/DZTkZ/mQgIaKfwn2poaQXD
	YRiAWlMhkRFXj1vPdCl0Z6seOaBri9FLs4rWVmLXC3/90u/4BqCC3N/8BVPYBUs=
X-Google-Smtp-Source: AGHT+IGro+ekaLb+vYWsCnr5zKEX15a+MHGaD6eX5gY1Apv6RjvWXyRZ3YU9RjBVYsXxt0KV9OJLKA==
X-Received: by 2002:a17:902:e892:b0:20c:62e1:6361 with SMTP id d9443c01a7336-20c6374101cmr43814475ad.25.1728492440634;
        Wed, 09 Oct 2024 09:47:20 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13988d4csm72448945ad.260.2024.10.09.09.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 09:47:20 -0700 (PDT)
Date: Wed, 09 Oct 2024 09:47:20 -0700 (PDT)
X-Google-Original-Date: Wed, 09 Oct 2024 09:47:18 PDT (-0700)
Subject:     Re: [PATCH 3/3] riscv: Allow to enable PREEMPT_RT.
In-Reply-To: <20240917104409.b9nGBsc8@linutronix.de>
CC: namcao@linutronix.de, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, x86@kernel.org, hpa@zytor.com,
  aou@eecs.berkeley.edu, bp@alien8.de, Catalin Marinas <catalin.marinas@arm.com>, williams@redhat.com,
  dave.hansen@linux.intel.com, mingo@redhat.com, john.ogness@linutronix.de,
  Paul Walmsley <paul.walmsley@sifive.com>, pmladek@suse.com, senozhatsky@chromium.org, rostedt@goodmis.org,
  Will Deacon <will@kernel.org>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: bigeasy@linutronix.de
Message-ID: <mhng-5582a629-6b81-4a32-bcbe-02f2e177fe99@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 17 Sep 2024 03:44:09 PDT (-0700), bigeasy@linutronix.de wrote:
> On 2024-09-06 11:48:03 [-0700], Palmer Dabbelt wrote:
>> I don't have a test setup yet, but I figure it's a new feature so I'll just
>> flip it on as a config post-rc1.  Presumably this just works in the QEMU
>> virt board, or is there some wizardry I'll need to copy?
>
> I don't think you want to enable it by default for everyone. The riscv
> defconfig sets CONFIG_PREEMPT_NONE=y by default. For testing you need to
> flip this to CONFIG_PREEMPT_RT=y and since CONFIG_EXPERT=y is already
> set this option is available.
> And yes, it works on the virt board and there is no wizardry needed ;)

Sorry I missed this.  Just in case anyone's curious: I'm not flipping it 
on by default or anything, just adding a CONFIG_PREEMPT_RT=y 
configuration to the list of things I test before pushing to 
for-next or fixes.

>
> Sebastian

