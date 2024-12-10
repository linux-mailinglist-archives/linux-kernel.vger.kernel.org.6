Return-Path: <linux-kernel+bounces-440184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FBC9EB9CB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2544F28399C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645B72046B8;
	Tue, 10 Dec 2024 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+yr3J1A"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3304AA94D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733857564; cv=none; b=EiymjcS7R0EOpbnOfD290a7IqPTHWrqI/9eptip8trOzAfqZ9edq4IUJFBZT2iDi/yHdwN/SvATXzfSl/tCbKPbV1Q+42skJmlXQ6R9VwPL11saxa52/8JrImF09iomsvEkWUlHyWZUpSJwRSvgTKudtPL21YttodQHrP1M2ShY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733857564; c=relaxed/simple;
	bh=gVEZKZmOX4PSitvACYULrga6C5HqtAfsmFhiTbXXyOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ksK4L5Jb19nUG2Rhha7XMpEnkgBgcozhu7pWTe50fNbgpjA3l6a17DE66OVSJf8KfuGYl2LmlA27gV7irS/tE2dg+nXWSe0EXkIz1UllDHNsAS4ScD9JK9OoE0nxA+Iibs4IpPHPpVC6VraPL4tt/khpMVaUu7mESHj0vvMsMgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+yr3J1A; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-540254357c8so1284400e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733857561; x=1734462361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVEZKZmOX4PSitvACYULrga6C5HqtAfsmFhiTbXXyOI=;
        b=b+yr3J1ACPv6AAnwcxhz77eV0T3XDYwYUL0Qc2+OteRs9W2JjFElw+aOvQ7SKchbil
         2MYRx1Q5NVcWHb3JcpZEPt/x2YeU3ctG7X2PZZ7dkk3FefPpB97ORuHCqs1RoDj+58Uj
         MdbgpZ5HBeAR1zPPqZXD8t5+Ddk2bGkm87vo10XRCWVylkKlc7WAqfPnoFvVCE5MXhkr
         cvk5acavDrx/U5tZMquBF719tRi/Qtd3dgYP82OcQn0VSQibmndAZy/h4c7A0M9KHfF8
         rA0t/cBjxhgsPsdPDJn2NxnWTZf2/9tsK//ZkNN4Ia5IKTUFRrO/dw+hPGQ9xlD1o2fy
         2Ivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733857561; x=1734462361;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gVEZKZmOX4PSitvACYULrga6C5HqtAfsmFhiTbXXyOI=;
        b=jol3kOap5ZGhyLmfLe0BUUUvsh0SFwbihCR8l+73g3tqfRspeuxBrDKaSdWiCAzi3z
         POGj/Coo56vhSBLYXJXJ0lNM0+V2+Htp+f2AyTc541VlH39Enpx2FHpN5vFSMMnUgfS6
         nvI/9dh6RRVmTf+NXDSBjq9iQ06maJCFwKkcOACXlxg+EqlehZJorM52oTlR7kB91x3Z
         ONYg/2Uxnw3rsoiHsq0YvWeqC0+JOqP1yxZo2IyiCwbCM4QPw9O3iCQcU0eqGmxd6cBY
         fPYuVKKFjXu/Lh042Aqm1EuLhQ0EKtqi+AgfEwj/a8GooHhHV1iwE2aoadSO03YSmXAx
         Hxjw==
X-Forwarded-Encrypted: i=1; AJvYcCVDgHS9dzJC7omhXQBFQynFAInAWuAaG+KGVMw565PFS4dV7uBU5RJMThMQPyivJkKV5nx2AzmgOH3hHSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQoPH8Kjzn7dakWab5sU3quWoQFm/Kh1MMaTYRHRYTuxr8HNgH
	6LbolnfvtMmthncGyXAfWuym1UHNl4/RQA/jeVmfSNy9aO+nBfjv
X-Gm-Gg: ASbGncu4LJoVGhTSulE6ZjimUQiQmHZlE3FWyUTjXbC90JWECfx3lCF0Q2y/+vM/rMY
	+/G9avV8I2sYuG/twp4mkdVyGUs2VNE2IFPsk1/goHZ5qPDqz0I35sYlXGtT/Rx48AQtzbznIHN
	DD2iIz9zLpH9b5G5HUwCSx2WJiinh7pNPN8+QGz2oyLv7SIfCJgENqWyPlD98VHoR24VdFJihvd
	jNblcQ18ToRMVTyMEwf84oCybHCO8zfFCtYfDNTG9KrxCVt/w==
X-Google-Smtp-Source: AGHT+IFmDplqYVX7hzey2StjYoswaZrpXFkC2Mi7OLUi0G9AC6ZsugxoBMdXQGrLoIHGHpOPtEP87Q==
X-Received: by 2002:a05:6512:238f:b0:540:1fcd:1d9b with SMTP id 2adb3069b0e04-54024115fb9mr2331595e87.54.1733857560422;
        Tue, 10 Dec 2024 11:06:00 -0800 (PST)
Received: from 127.0.0.1 ([94.41.86.134])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53fa8bbd864sm1077599e87.215.2024.12.10.11.05.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 11:05:58 -0800 (PST)
Message-ID: <fdf8b753-f4ff-47ea-aec7-508ad72ce5b9@gmail.com>
Date: Tue, 10 Dec 2024 19:05:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 05/11] x86: add CONFIG_X86_64_NATIVE option
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andy Shevchenko <andy@kernel.org>, Matthew Wilcox <willy@infradead.org>
References: <20241210144945.2325330-1-arnd@kernel.org>
 <20241210144945.2325330-6-arnd@kernel.org>
From: irecca.kun@gmail.com
In-Reply-To: <20241210144945.2325330-6-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

On 12/10/24 14:49, Arnd Bergmann wrote:
> As a replacement for the obsole MK8/MPSC/MCORE2 configuration options,
> allow building a specialized kernel for the local CPU, which is useful
> for users building their own kernels, and does not require maintaining
> a list of possible CPU options.

That potentially introduces problems. Namely compilers could apply auto-vectorization, which currently breaks the kernel.
We probably need an additional patch like this: https://github.com/zen-kernel/zen-kernel/commit/95b7981ba2e5c86529de0e895c2d9e428aa3f7dc


