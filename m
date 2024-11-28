Return-Path: <linux-kernel+bounces-424589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 362169DB661
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001122817DF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94031482F3;
	Thu, 28 Nov 2024 11:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DuA7I5Nc"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C8915E5CA
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 11:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732792733; cv=none; b=L7G7RbPKMKhiOVkYBe7v3FoozBYjK/BU6JsmCycMAghZ1WsdB/Cz6CovJXMQS1aJ2Lsqda6YNHyAgfvgts/0HKNqiBH+DWru55C81wy6TDORF7gUCYly/+EoYJ1UuV0pfoRMRC7UhI6a2pCK207QrGhIRVdkTSNFtAW9+JuqE2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732792733; c=relaxed/simple;
	bh=1Dr/9wK0GiPUXbwSM3pXd7ht9BNkBZhC+a1phGPu4JA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TbApRXgKLy/jp5K6FT9Yy1VuESp3/jPP6SDznH1H9UDReGaeTO1Ffb882pE+QsPql9MKx16GUbxAUTQtmvHdNFg8ZTfm0rKRne96ZdOgjXGYh+MytTZpCvqPKqYvWUb4tTmRiYp2UrZKwbM/s49mf3soZrHx2JyR3PriORrMOBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DuA7I5Nc; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-724e1742d0dso620335b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 03:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732792731; x=1733397531; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7g0EDzT90oSJRMdudNKevE+2bYFLsEd5Pd/+GTWI7E4=;
        b=DuA7I5Nc/yBWzCzpYtAGYexy6CLXEgr0dTpwIAWbZTU73W4Q63fju9fXqqVRZZj29s
         d3XJ972aZ9SLNRoq/EHZtdvrjZ0MDN41ydzxahJDvZSdrEJryUhagnLaWzx1/O9pWTWR
         unifArbhbMMpQZ2WZH1/ob09VE4jbF3hqGDxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732792731; x=1733397531;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7g0EDzT90oSJRMdudNKevE+2bYFLsEd5Pd/+GTWI7E4=;
        b=lxWWkssWF9LhqSajcZjExWrXwYb2cln9CIFtUTtpGG1HjHbqGyNev9hq7Q4lUZTwM4
         joh8Fry6sd7BQwJHylgGVL6Cn8G7VOoDk34iemcRnjdJf2K7gXZvxyoYXfhWTYzd0oUY
         sbGnEl8NRpEewNA0QmBP5Zie+QFlppPfEFZ40uSNPc4FbHtQcuJumYARRzteGE2VJ12S
         25xd2/WKsM7dTKI2WsVYpoh3TQ4Txj+6siB5yXS4Wt10wQI5luN2pPoOx4Sj3+xa8AeI
         23iwa2eqmgkZcMh0QzNxBigm5LOEE6Z5wOPPUSZUDICdvtQoQQReUfHnbG3DQmaq431P
         ov7g==
X-Forwarded-Encrypted: i=1; AJvYcCXya3ql4ZUMo5A4AAaFJ2m/R9PT/tqeVz6jEunVHqtBXGRpuzxRYYqU2IxJMq4ELI867KfRoyjbtUPPUQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5q3oyTr/8Ts/H/mdxuKtqgZmME172+mf1mfsvFuU6wwsCgSlx
	w1oyStN4yBrAO3sbLLq71E19VC80dWn37qj3tgiA+8WJieP97rJ7b2iUAfnahg==
X-Gm-Gg: ASbGnctXEjpcud1qm+KSelLuV/yr4JHNUCHPDFnrqDOngwpSC7vkSD0rVPj8acJfWE2
	PT1BoAPKAcRBKVYsRZDNHAt0rc+d12Minjzul66hNdqtVKrQs+7xZ0o1Bw+d2G8P1BTSaw+SPR1
	eJ9fc617Q99N/lYGgSpHjPLpTYP9jMcADt3fsZihCglePf/lOlrU1f74Si9GchlZl7m/r/lOHsd
	Fv/twek7EzSw+TI7XPz24jgA/ym23hW9063wOxTVWfkxqpG/4Qmwg==
X-Google-Smtp-Source: AGHT+IEUKIyiy9WVkqcupbZQIOcf/4lQH7Ewcmkw42yxvQRWkwZbjCYyNcNqjlql/El2bpIiD4PCIA==
X-Received: by 2002:a17:90b:4b88:b0:2ea:95ac:54d1 with SMTP id 98e67ed59e1d1-2ee08ec82c8mr8162430a91.19.1732792730979;
        Thu, 28 Nov 2024 03:18:50 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:e87e:5233:193f:13e1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa30fcesm3222262a91.8.2024.11.28.03.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 03:18:50 -0800 (PST)
Date: Thu, 28 Nov 2024 20:18:44 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Zhang Rui <rui.zhang@intel.com>
Cc: hpa@zytor.com, peterz@infradead.org, thorsten.blum@toblux.com,
	yuntao.wang@linux.dev, tony.luck@intel.com, len.brown@intel.com,
	srinivas.pandruvada@intel.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com,
	rafael.j.wysocki@intel.com, x86@kernel.org,
	linux-pm@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: bisected: [PATCH V4] x86/apic: Always explicitly disarm TSC-deadline
 timer
Message-ID: <20241128111844.GE10431@google.com>
Reply-To: 20241015061522.25288-1-rui.zhang@intel.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi folks,
sorry if messed something up, this email has never been in my inbox.

> Disable the TSC Deadline timer in lapic_timer_shutdown() by writing to
> MSR_IA32_TSC_DEADLINE when in TSC-deadline mode. Also avoid writing
> to the initial-count register (APIC_TMICT) which is ignored in
> TSC-deadline mode.

So this commit hit stable and we now see section mismatch errors:

// stripped

WARNING: vmlinux.o(__ex_table+0x447c): Section mismatch in reference from the (unknown reference) (unknown) to the (unknown reference) .irqentry.text:(unknown)
The relocation at __ex_table+0x447c references
section ".irqentry.text" which is not in the list of
authorized sections.

WARNING: vmlinux.o(__ex_table+0x4480): Section mismatch in reference from the (unknown reference) (unknown) to the (unknown reference) .irqentry.text:(unknown)
The relocation at __ex_table+0x4480 references
section ".irqentry.text" which is not in the list of
authorized sections.

FATAL: modpost: Section mismatches detected.


Specifically because of wrmsrl.

I'm aware of the section mismatch errors on linux-5.4 (I know), not
aware of any other stable versions (but I haven't checked).  Is this
something specific to linux-5.4?

