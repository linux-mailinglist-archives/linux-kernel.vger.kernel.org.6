Return-Path: <linux-kernel+bounces-565588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 346B7A66B5B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 474CA3AFF67
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544731E5211;
	Tue, 18 Mar 2025 07:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lrFqSaHQ"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C7B1B85D1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742281957; cv=none; b=PtK6wHicH477xJl+QJRpAwwMzw67xqrB+MT1rVwO4HxW1Ka46BGK6yaXE6HnokzyQi608iqpW0TnZixJtatizD5akICzuy3cNx/sXXb51EPa64Es4ab2h9YaR3XsBTrsWKcLOQpBSCKaX8a5gcgZOnmQmJu+LBbIbvXLnUzK3so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742281957; c=relaxed/simple;
	bh=9aPkWt15kdE0cstq+uoRNw2VwO5y2gHFLSM304k0pNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FKGuNo6JA0nLIWqlmQiHBAUcyFI8chZpIx/tUXzhG8J9yrhbzuw7L0PxEvQwMnElhgU4VMmAnQ6f7S2B75FN29aJVY4xrd0GPMRvNJU84JDBNLv77S+izESv0o/hQSYrnGfaT3mx84UIuqgBCix6TQkugdA1ZpCyRLx090SnJ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lrFqSaHQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so29135175e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 00:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742281954; x=1742886754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9aPkWt15kdE0cstq+uoRNw2VwO5y2gHFLSM304k0pNo=;
        b=lrFqSaHQvAw2bWzVZmNtNZvyFrrmj/QWJ0GotFkuN1cllhxAob8jF7UFCCsjRCkp/9
         E5bQJm27Cngoekgxqdbn0Fwn8Xqu1fe0761JwJezJSmP2+M+t9uQR3KKRmE/3F3jLzPc
         A793+Oc3qKdlve/fZgx0zmtyzyiNJI0vnUNwPdRC5K5C47KQ8FXg40KPkzatu5iOR5lZ
         Dx4RW75aoVImxaO1fVMeeFbIfTu6Xj14eR7kuAUklD1fZCxH2b2QCgcJ+L4GdUY33bMG
         tp+oogser7A/ijgjqLsOuW/yNsNFynQ5U4dAmsSTRd659yGjtJkpGHvv59KDFObZGymX
         S+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742281954; x=1742886754;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9aPkWt15kdE0cstq+uoRNw2VwO5y2gHFLSM304k0pNo=;
        b=EzGwLpZk50o/NefPJEe/PhuZ+I8d4axifqkjSYHcUD9jzrQnlaNbpyLH3L6QiS2D7x
         pztXGuvZjdbbS36p3ThavwxNsiOzPX3rHNukixZs2DGCOTS2FJYHiePwKOWGxk21Rx6u
         LSPU5s/RqB7V5dalvXnoT8zVVYPOUR6JIKV6k85NXZXCfc2D6dH7EAzMmAFK8nYHeCg3
         pDMFmMOr5RktaKD0Q0qgDulT6awOExPbqcurNQ8fvjzpNgtWCZUNfZqu3Ztt8Ucpqk87
         GqUDwfFue3fGjthoLF4UtdtCGRDalFW2dVb0EmpBY3UIWUINMoU/hpXE3W1fyp93oiGy
         CmYA==
X-Forwarded-Encrypted: i=1; AJvYcCWrvGLblKMUXkPSacy7OVdZ85Ra3mnQR7ekvNthgPGzaQN1LB/h3oD90iPz0qM/xknc80CBiFnDIp1z+kk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw73+lqoBstqNSC62pXvZ2WQtGZVUPJv5N5HHqONAZZUAiuRK7J
	glFv4DCz1j5Q6mdSOkbfOShHaJjvPO3OxMK9Xpt4BXKITYXcY9ttoakjrievOnc=
X-Gm-Gg: ASbGnctZJFRURmp7gReIYWxic938A9NzNeZcLJQaRWvGnCrwpbXLniOvPR2yT+5qzRj
	0y0kOtCp/srrStnhCBI+2ZGqatBdnh9Jq1ilqWterHpZqWE2sc2Gu7yf2NPb7WMKKeHJAmMB82/
	Oy233Tx+0Tt18d6yjLFY6CLOATffOVI+eJ5IksoP9dqtq3QjH4MSsXzlm6mujvTK4xiv40Q1aO7
	zBE5JSxXplOpb9uNFyZQIYO88jOotyljuSDLixOFLKkSE8BQI2O7UjRRzxn9HIRdd8aSIudsvyC
	G/aXdR+Tzk5p1VUhRVHPItojWo2Z8C2czCZA7RnObrL03b23HGpTDg==
X-Google-Smtp-Source: AGHT+IGRzgw0td7tUQ8o6QejSgw5whaNPyJevgCIAzLbJrIbqfpv0Ac/GK08yGIn1kKOLzsYXV2gpg==
X-Received: by 2002:a05:600c:63d1:b0:43c:ec28:d310 with SMTP id 5b1f17b1804b1-43d3e14fa7dmr4229575e9.10.1742281954415;
        Tue, 18 Mar 2025 00:12:34 -0700 (PDT)
Received: from [192.168.0.62] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fdda30esm128241455e9.5.2025.03.18.00.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 00:12:34 -0700 (PDT)
Message-ID: <47905b67-c0b5-45c9-98e2-0dc4dcf9651e@linaro.org>
Date: Tue, 18 Mar 2025 09:12:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: eon: fix lock and non-SFDP flags
To: Jakub Czapiga <czapiga@google.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250317181856.2059536-1-czapiga@google.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Content-Language: en-US
In-Reply-To: <20250317181856.2059536-1-czapiga@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 17.03.2025 20:18, Jakub Czapiga wrote:
> Set appropriate FLASH lock feature flags for chips that support it.
> Set top-bottom protection bit flag for chips that support it.
> Add no-SFDP flags for chips with missing SFDP or without clear
> SFDP description regarding 4K sectors, dual and quad read support.
> Remove no-SFDP flags for chips which documentation states that this
> information can be extracted from SFDP.

Patches per flash please. Then dedicated patch for each logical change.
With testing.

Thanks,
ta

