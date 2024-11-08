Return-Path: <linux-kernel+bounces-401147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6489C1678
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 07:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346821F218BC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 06:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60A4194A5A;
	Fri,  8 Nov 2024 06:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pCCrpOco"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713511C3F00
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 06:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731047332; cv=none; b=AFQZj5gNA3EyTp8vdx5H7fAYmliw7ti3y9p9SHdAodg17OTpXxhZQb+tEDGLTg9xrlXz6W8IN4LANtr7KNYYUy48c3vliyauni4/a/vLYOaTLf9H6LXipqcsdwLTOA4Kj0I1lYQ1kDm8mtH167Chud+I2TsguY12Mdon9QpZBOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731047332; c=relaxed/simple;
	bh=nhKZViwIojy1jznqH+DVmUP0BD/k7Oy5tX4x7kzV0XQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXpURl94Df2nBjlDVZeazyQDsjWRlx03hgAS4ZnqUNrBh686/EGrXJMzTe4DSJQVUaz6ymlgjgIEEKfMLrnD4tj5uddRWuwx5mtHmOPSpU5Nzo0rFSIk/LcsKMTHBQVdokOpU6HipNfnLY1FZCEWHpS0KTITI8uUtXSUMWnM6hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pCCrpOco; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso4964604a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 22:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731047329; x=1731652129; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nhKZViwIojy1jznqH+DVmUP0BD/k7Oy5tX4x7kzV0XQ=;
        b=pCCrpOcowvH5Z26iBqh9K9mnw/8ySSn1eU7g7QPabfNVZr2QRg2kREXvJehfRewpCn
         lywD4z2CAPAMwtQ/rxcMX8HFQzHZG1rODdeStMePtEiB/jtdezvlXbgHuNaROgYPBabl
         fJGjPWXbjerNJgH+U+gPsGxt9lfBRE/SSM3RR6b8eqyM4k6gvKXBuq9xArGNGCKIXs2V
         cNDCxseoSsoehhUrJrUQdgcmxgBZa/vM0TPFHw5dVzC+otVLmr9s1i7omzZtBhdntv3A
         gkQ/1gQEJ6+M/1CLNaEQ2SSWLTj9xkmrgkZfsviDYA83FtAE0Lfd8StiUW46MHZhuYpK
         QaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731047329; x=1731652129;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nhKZViwIojy1jznqH+DVmUP0BD/k7Oy5tX4x7kzV0XQ=;
        b=wMkXd04F0EGjImdAg3f+UWWT+EAGk+o+sYfIfgqdrMUlo97PQQ68daWea7ezoix7Tg
         kjWnugxCzSoWexnDzxJBOkoV0hQtoa5wPrRz9bc4r1Z9D0JYYvgd/+26ZWvAL7pHffx8
         bgnoR3y2+Pfnc1HxmJkhjs5esQsfgrn7wMWCP6Tfdm52qN6N00ZTMg2DWSRNsdha8i29
         Z1+JF8FnuOin3PUA2NV1uE3Jpi21ehsXQF7QDbktJS1K553W5TILQ4Ro64PoMjNbrcIV
         CWaHAE6q7tvGbfAQL3EW4L31TngV9FKbmha5mtEntccHjQfx7bbV5xSEUYegJR4MWRsk
         XT3A==
X-Gm-Message-State: AOJu0YyZdNYcLlqZFlkWdwnPwZ018lvBK9FKOdl39HtEa6vTUSHbcc94
	2PxOoERIjSc0AgyzaobLNppUK6iYEW+Cl8B7ibm16NZfkMxRAUpcAlaA4+a+8jfAruIqWnOHhAC
	kdBvjlr6S+VCPi+1PHJ7EDy6+lrMLz17uiWlG0g==
X-Google-Smtp-Source: AGHT+IF4QpvMl47Anct7uB8oNOeB/KNHWgHKnvD8Y/Uan+WAiJAKM17lcJrxkRIlrQw6Wda6VuR3wUPC5X6N3HpZEeQ=
X-Received: by 2002:a17:907:96a2:b0:a9a:7b3d:705 with SMTP id
 a640c23a62f3a-a9eecabd4e7mr172472666b.30.1731047328457; Thu, 07 Nov 2024
 22:28:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913132944.1880703-1-beata.michalska@arm.com>
 <20240913132944.1880703-2-beata.michalska@arm.com> <20241029070429.m7q5dkumitoyqxq2@vireshk-i7>
 <Zyh_ACbOkSsjcPX3@arm.com>
In-Reply-To: <Zyh_ACbOkSsjcPX3@arm.com>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 8 Nov 2024 11:58:37 +0530
Message-ID: <CAKohpokFUpQyHYO017kOn-Jbt0CFZ1GuxoG3N-fenWJ_poW=4Q@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] cpufreq: Introduce an optional cpuinfo_avg_freq
 sysfs entry
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, ionela.voinescu@arm.com, sudeep.holla@arm.com, 
	will@kernel.org, catalin.marinas@arm.com, rafael@kernel.org, 
	sumitg@nvidia.com, yang@os.amperecomputing.com, 
	vanshikonda@os.amperecomputing.com, lihuisong@huawei.com, 
	zhanjie9@hisilicon.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Nov 2024 at 13:30, Beata Michalska <beata.michalska@arm.com> wrote:

> We need a way to discover whether the new sysfs attrib is to be enabled or not.

Ahh, this is too much trouble to make it optional then :)

> I guess I could change the signature for arch_freq_get_on_cpu to return an error
> if that functionality is not supported for given policy ?

That would be more controversial I guess as we may want an unsigned int return
type for frequency.

I think we can do two things here:
- Just enable the sysfs attribute all the time ?
- Make it optional based on some static cpufreq driver flag ?

I would just enable it for everyone I guess.

--
Viresh

