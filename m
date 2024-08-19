Return-Path: <linux-kernel+bounces-291648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF7295652D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BABDE1C21818
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDF515B111;
	Mon, 19 Aug 2024 08:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="3D0EH2eP"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25FEA41
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724054675; cv=none; b=DJWIH5wzLx97bAwpDMdepFi30OaXrydH2nA47Y63gbJlgKhVOqtcSmb9r4duf4SDxl+LwQXlKvYQOkPwl9zDCPm0Q1FJb7O1xd+Q8esqFKkz0lgFau2gwF9vLINbjawzbOQD7fRwvTrFjyL0yPqxlFeqP+8546zHAZjGfE90xdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724054675; c=relaxed/simple;
	bh=sh6d2T90VBt7PW0O2QnwFfJGTyOiMOwqTUNiAr1Wncs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3M8xFhe/WfbkFwezkfklFhcevTuYdkcAbgzBZ7FPVX9Gw8ZHjcNzeblNauJh2Dl8ee9f95aRiJZLqFdw8T8K3mObEDWppxaTEZgDq5wvcvfTWweYMtXe9o1Wc0i3o12Au/T2RqxAg2E1x11EZ44N5O7HLzIHdLm6ZN8J8BzWxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=3D0EH2eP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42816ca797fso32494445e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 01:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724054672; x=1724659472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIN5rfSZYgO4e9KNw+kDYWbV7vK/3I6nosj6OAZGb0U=;
        b=3D0EH2ePLsZErl2JvwD6Jages0jiADKYrsFu2yJXemglMpFQYnz1zKuk6Ct1UXvfvD
         QrwHsKXgpkHhn3oszrr294Ll/Cf/x/qkUcazhl5ffwkIUBUbquVp1N8vMSaOconjThXv
         5j+zVxy3EWRJUYEjSw3lBgSRUb8W9F3O7dsjVRUU9KLeoJ7Oir7pr7kMuVZdBcYrVIqa
         McA/R9I3n3MRmWMyXffK7wK45aU8jLuaKZ7lZtwobcyEfz8UteYWXYQRRdmYYQ5vgJeD
         5kXGOCw+rSDu5aY6w1DRIM6ec8T+LPROoG0P4I0hSapyDRJXNSvtlz8jWc/FakSaxG02
         a43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724054672; x=1724659472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIN5rfSZYgO4e9KNw+kDYWbV7vK/3I6nosj6OAZGb0U=;
        b=n93GK9oz8Vhx5CS8cP3K0h8Es0z914diZyhArruGrqFa+Kcpn3PM/eYacGtqRI+DId
         tMTJGB6FqB20TD/bPJ3WXDEOwQtY29mQ13ZuIMV8532LIavuYyDknFiFvwmjysDCnSy6
         kYWw/g9pgkdGnSZj/N+ioeR0/eaAfZlbSXWDkPTZYWV2msfwO2foqZhahhukSc4qdxc+
         4qLk0jyw2CUUG/GL4tmtY/P2RC0LuP/ujHNuAbtBGO3cVyTDaXTmOK0GtucMvtKrJuh7
         KT8AuOVvu/CG/fD+q+faTcXSGkyISWGKlbpq/XIA3aKDPnS9sOLPp7UcjtymxMeWmIGA
         Ei8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWk6Za4tXzaEK54znm4uXqyfYFhgpvAop8iv08e/BacfGNUziFte9wvo7L4o2bBT+bbKK67cIVRl1oLZbrVdU595jdMP/IipLQy+NcN
X-Gm-Message-State: AOJu0Yy7Pclc2009OAtpjhPsyBFR8LqZo6uyfijNtI5ZXfzLWM18Oq88
	3BtAEa28GLnNRWRbAY6e65VSOLiPf+PwLEBLKm2FNQk0yy8+o3kDZuDi1qeEuXI=
X-Google-Smtp-Source: AGHT+IH3G85GGe9gDURbCijJL1PblYamaPRjroyy+mFEzzX+T5LHJCe/TbhZd3smYOqpPUe7YpmXEA==
X-Received: by 2002:adf:fd82:0:b0:371:8411:ef7 with SMTP id ffacd0b85a97d-371946ae86dmr8061498f8f.62.1724054671409;
        Mon, 19 Aug 2024 01:04:31 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:7b55:8f70:3ecb:b4ac])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189859d4esm9792432f8f.49.2024.08.19.01.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 01:04:31 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH] power: sequencing: qcom-wcn: add support for the WCN6855 PMU
Date: Mon, 19 Aug 2024 10:04:29 +0200
Message-ID: <172405466482.9106.768629947114407422.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240813190841.155067-1-brgl@bgdev.pl>
References: <20240813190841.155067-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 13 Aug 2024 21:08:41 +0200, Bartosz Golaszewski wrote:
> Enable support for controlling the power-up sequence of the PMU inside
> the WCN6855 model.
> 
> 

Applied, thanks!

[1/1] power: sequencing: qcom-wcn: add support for the WCN6855 PMU
      commit: b8e4b0529d59a3ccd0b25a31d3cfc8b0f3b34068

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

