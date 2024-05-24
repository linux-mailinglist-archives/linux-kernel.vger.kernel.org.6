Return-Path: <linux-kernel+bounces-188979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 366578CE93B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 19:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 673F11C20336
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C96179B7;
	Fri, 24 May 2024 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="NEe45Ed0"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E025623776
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 17:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716572113; cv=none; b=sgZiE06IIVE6qqGtVbNYHdb2mq+3a+sFf1rUXKycf22HtmvNPzxxGrftBqbEEbVmKv0bEcFZdfnN3dwSxXYFLUKM4/Jf/E2qI6uf0axdLOmhKX0Wpsx5JkmcDyXIEfnrjPLIirxJmgJ/3La2Ut1B+cbNvUMcW1xX/bS3VKIOnQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716572113; c=relaxed/simple;
	bh=X7q4I3Z2W8ceiJRUmxuw0oIfEkVA3C+3uJyWgUVv1N0=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=YKpbHdSIGRMKtqDjtl0jelvgfQnaKVAUN1hZ5jSA6EjzCAprYc0osers0LBtK9gHIz9mpmAuSHAs/xy+SxziGyvoXvYIubGYtLJi9Jsec6CCo2sBYA5ALd6FWwL0wUuaMchDjLGHikSPuUDFd16Fa86iGfYKfRDJHzCqCvg3Ci8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=NEe45Ed0; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f3310a21d8so22416385ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 10:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1716572111; x=1717176911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b/lYKjkuHWJ/tP+SWUmNPxY2vRmvZk0xnVEoyWXDsrM=;
        b=NEe45Ed0QafHxXMB2z7MLiKQtFpj/oTdqxc4LI8XXlTbsS5xEaUoT+4YYjFHsk8PTV
         kxp1JTCcvI9IIbJtDRzdYsOYwJ2KBFBe7ad8BJBynh/d2Q50w0HE4DxdXOxfqOY7e3Kq
         l/NOHHcmg53VIga26fNSO08VAhGSItxiEqkhU2qlRWCKJTJbe7J3iCNUYTkPP1/ipyJj
         fczSo6zUptgl5INTHHBxxBYmnK8xMYZ64+EyY9iQGEVRb6yt+7Ro6GGLMATdj4jQfUCD
         Lt644L8fZSXqLrEBM1LaUP8h/k+47r3M1ECCZHbUvSROY9+NFWseBpJE4w5IDGXenO2v
         1IFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716572111; x=1717176911;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/lYKjkuHWJ/tP+SWUmNPxY2vRmvZk0xnVEoyWXDsrM=;
        b=xQ4WcAIrl9Wbor7KriQyij9iMpY3BYQCl1JZJduzYArNCweHc9yLg39ZVKsgwMrh0v
         4LIkA2AZbVwsMYj/REUBw0LSCm/0xjU+eBz27zmfhuS8qCZWdQfaYF8/XmJu8darZ+bA
         Wl8WR5g+4aZsugp9v/nRVZYMwE+6hSsH77a63KmrTQhTWGNnZVQoypTqqp10GS9w5jT6
         6tibisfG9P6V8msYHAP7DALGAkT7sZzCb++mPjliAzKwP3ancIXf2MUHk1zoF78ILMaU
         7U+Dmq0+ywntI6Cy+6gMpkhsHk5k7tiz4+HHU1OlS95RI5nqwhoebY6gA5EB+40VBKpA
         3+MQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5Fd7jsOPeg5G1gJzwIqP+mXsBdS4uGXtRZmUrqWkR0r3b0uCuTkiB+sN5PvBAs+hSDbrcIo3r2+rLrC9AxUxalkOYgb8c7w99IvCk
X-Gm-Message-State: AOJu0Yxtg3LBpUJKm89CDcylKZwDapCiP9Sm5Z+s5yEMZu5DCLPK7feM
	PlllJCFbGDbnzFLdgLWJYFwzte3JvBiC4WzWqY1Y4i7J34wNchtaG9TVS2uTlRg=
X-Google-Smtp-Source: AGHT+IHIs13/ijYk/c01n1Igl2g2Bp1b8sXlKJdcpDFmF1ecg8B5NT9tVh3ERgJlBBvoqmPuaM3uhw==
X-Received: by 2002:a17:902:efd6:b0:1f2:f107:5a71 with SMTP id d9443c01a7336-1f4494f2cc2mr25001835ad.44.1716572110954;
        Fri, 24 May 2024 10:35:10 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c75782esm16429155ad.31.2024.05.24.10.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 10:35:10 -0700 (PDT)
Date: Fri, 24 May 2024 10:35:10 -0700 (PDT)
X-Google-Original-Date: Fri, 24 May 2024 10:35:08 PDT (-0700)
Subject:     Re: riscv: irq-riscv-imsic-early.c:52:9: error: too many arguments to function 'riscv_ipi_set_virq_range'
In-Reply-To: <875xv3dt71.ffs@tglx>
CC: linux@roeck-us.net, Conor Dooley <conor@kernel.org>, naresh.kamboju@linaro.org,
  linux-kernel@vger.kernel.org, lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
  linux-riscv@lists.infradead.org, apatel@ventanamicro.com, anders.roxell@linaro.org, dan.carpenter@linaro.org,
  Arnd Bergmann <arnd@arndb.de>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: tglx@linutronix.de
Message-ID: <mhng-44d7a1c7-c15a-4077-ac94-23985f686474@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Fri, 24 May 2024 10:18:42 PDT (-0700), tglx@linutronix.de wrote:
> On Fri, May 24 2024 at 08:10, Guenter Roeck wrote:
>> On Wed, May 15, 2024 at 10:05:59AM -0700, Palmer Dabbelt wrote:
>>> as a conflict resolution, which IIUC should happen when Linus merges my next
>>> PR.  So I'll try and remember to call that out.
>>>
>>
>> Unfortunately it looks like the conflict resolution did not happen,
>> and mainline builds are now affected.
>
> Fix is queued and goes to Linus tomorrow.

Sorry I misesd this.  The PR I sent Linus this morning contains my fix 
from earlier this week: 
https://lore.kernel.org/linux-riscv/171647463438.13050.6219786365640043025.git-patchwork-notify@kernel.org/T/#t 
.

