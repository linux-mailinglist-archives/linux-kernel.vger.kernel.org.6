Return-Path: <linux-kernel+bounces-395394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA6D9BBD59
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D9591C20DD5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E064018BC37;
	Mon,  4 Nov 2024 18:35:29 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF171C82E6
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 18:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730745329; cv=none; b=dVSd98fV/SVS/W2gcMim2opTTO+sTD5FGp0mWshddL3MH3cgYX241qVSEvQi63KwPj5nVjW73tjdXcxlKicuJkdtkS6Ndc7py6Y7iswLXBWzLXfX8YWU2L4ejMc+YuKjhdgPEV4y2kYk31MXAU8iJxgkieVudkJcmsNnXXnRn9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730745329; c=relaxed/simple;
	bh=0q8JDwWzDntd/aeV9gPiXXtsjosur55lq2xvMgVntdk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LMvS+6Qc/THRVwqUPZ/4oQb9gHAsIWM0bblMdtKrAGRdz9k1CX6mMMU+MmTZJvVR7CyPSBsvkgs417S8+IZJt6JEoIKKyr9QTVkrjzlSLp8hojLv8PmVl+50uxkUgjWGwUGwpNnR7er+Uvopr66hfXO2tnzknK437sgkl5RYQIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-720b2d8bb8dso3396923b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 10:35:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730745327; x=1731350127;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q5psdNGZt7yO/EGDxsF0O7Dn6TNWS1865Oba3g5L+Z4=;
        b=HPWnZkj04APQA1NfG2Chjzit/R5v3UgEYYRsdnQp11UN6o9pHkm0JbGa08CM4NRu9k
         28mJRgLSAvBXxQGexni+RsOadSlpp6+KH282br8n/tngQ70uMNwf40ayrpgJDVAVY84W
         1BYIB1pG+rS2CHE6tj5tmLpgwCNG0AmHhHLUit87pPOidmgxjet0C0Sj5g8bRv8ZFyBB
         W76lvYLZelZW7p8GoelVaBdQ+VVTYgc5DngwJyyU3Sh+pJHWQ8KcsYWc4TvZ67w0jms9
         soJMNKy2M18WwEcyG0IGgY3KvF8Y5d7Iapbnx9XaGQ3Ynqx/1KhBU+yf4F5oYeu4a6UP
         FuSA==
X-Forwarded-Encrypted: i=1; AJvYcCUUtBqKK3nAEvHbviEgbd4Btk4gWFY39UUW+gGSm4Ro8jRwx/R9qhldfV2pUex40Hc6yOnpxzFykGqn7x4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHpLrG2gKoGXG7Aek+N6ZrY7KESxrz3CE8SyhXuV2ehCTEQpFm
	QZOQ/73+qKxV6O50BlvLZ1XxahBI6AcN5gvZ3L2WK8kTqL07/N5f192THYpQ9P0=
X-Google-Smtp-Source: AGHT+IFdG0hVRz4dPBfiFMJhFlY8swzM18DsMZV8IwIUprVfLFdN6Gv/FIxkJZSrzjoyHAC39n6arw==
X-Received: by 2002:a05:6a20:4389:b0:1d8:a3ab:720b with SMTP id adf61e73a8af0-1d9a83aeab7mr46788718637.9.1730745327258;
        Mon, 04 Nov 2024 10:35:27 -0800 (PST)
Received: from localhost ([97.126.177.194])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee45a0eae9sm7369576a12.84.2024.11.04.10.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 10:35:26 -0800 (PST)
From: Kevin Hilman <khilman@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>, rafael@kernel.org,
 viresh.kumar@linaro.org, zhipeng.wang_1@nxp.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>, stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: fix using cpufreq-dt as module
In-Reply-To: <20241103210251.762050-1-andreas@kemnade.info>
References: <20241103210251.762050-1-andreas@kemnade.info>
Date: Mon, 04 Nov 2024 10:35:26 -0800
Message-ID: <7httcmonip.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andreas Kemnade <andreas@kemnade.info> writes:

> E.g. omap2plus_defconfig compiles cpufreq-dt as module. As there is no
> module alias nor a module_init(), cpufreq-dt-platdev will not be used and
> therefore on several omap platforms there is no cpufreq.
>
> Enforce builtin compile of cpufreq-dt-platdev to make it effective.
>
> Fixes: 3b062a086984 ("cpufreq: dt-platdev: Support building as module")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

I'd much rather see this fixed to work as a module.  You already hinted
at the right way to do that, so please do that instead.

Kevin

