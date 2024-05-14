Return-Path: <linux-kernel+bounces-178517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4198C4EEB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1057E1F2124D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D399812F5AD;
	Tue, 14 May 2024 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ih/TTPwN"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C17412F59D
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 09:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715679504; cv=none; b=WRnfsz4Cr4hLHTCrX/tclnYpQvKdO9gZMuKK73lRV+Vddm9is/p8MdkhS2nFoU9x5Fs773LuqY+t7iR4s6qMKubEKsj7WLwhfABfhauOyXTQflkC1twQ/DzwqLbdeix+qlM1/lYooO/IGPTldqaNl58vqhiXhG+us0nJyxg8If8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715679504; c=relaxed/simple;
	bh=ugmqHD8gx3nFC7pqTV+mFjN74vQpROvL/Tcrh6tNX84=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=IM+MHclQ0bHexq9QFwcyxrsGHRK5Krybk9Nv3rN7RprOK/F1yhni9Vs8o1mP+Orwc1irISWGXLBca0Trsc4ahQiw+DdYRup83Hxsd7ABtVVER3feAK0if/ZuMsbsZLK+5kngscqvc4s+QK4uXr0laDHvZrRkVIZCegpTCqpeeOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ih/TTPwN; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a5a7d28555bso226340266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 02:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715679501; x=1716284301; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGsUCRPnRZg4apsajqD36k6G3B5MN1PDLfHztCfclRQ=;
        b=Ih/TTPwNxLOzHTPIFILd1++PXBoUyYy021zof956D50Gjp4N+eYyql5Ri5d8+D0Ji4
         P51ST6qWpwf4wiIr2k6U5SERa5NV/EAZA1ciRG/+JWrP3yAGSAp5YKEfopUXGkDyPnnt
         BlgFjIEarexE8C5Lm/QpGUMhW7TNzY57fC6dxoMxTxSW6yVZkyIPKmPW0mCjHMJHamp/
         6RdklVujJs8YVDTg2iTad3rGIwCTGVU9HZ0ZXn2dh1d+JRSYfbxX+hZglybdzRrXZpZG
         bMIKV6g5esKRzqd7/sy2xzOAhUit6c2VYxz0ghFLclJ9Lb/eWDGjggQMW7epgJkkg6y+
         9hdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715679501; x=1716284301;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RGsUCRPnRZg4apsajqD36k6G3B5MN1PDLfHztCfclRQ=;
        b=oKKNR4g8GwCPy8vCQcw4yNIIdMVd3m9lNuBq60SL6p2+lSzeBPwo2LFmA/bRl5nqji
         c/UsJGeezXA6mtVeBHHg7jjLIl1LiH+/BEEX8g6TNVdkIaY6Pm+YSJjn2RPSJEvp99lk
         X6dcRHf2uV+u9u16e9tk3C31Z3rBfqBodGT28jyHf6bXKn5Q32xWZIF3gYwKqJOribpg
         jUo4luRo0uoEAe+7NAozDlB8XKhdwjks7pH7CflAgBxac4iKQQaQ3QibeaBnxf5RN971
         yi1+0iSWNqixpKsy9W6DUeP89dkE8qR5fAquHYfe08RlQzFIzBCiKfaR+1WKFd3lH0ni
         XslA==
X-Gm-Message-State: AOJu0YxaVOzQLKS8K3ZBQfCQx7Q7bIKsRALTYtgiTTKEdSCY3Yl5cb6o
	e0s5nzTjL7V5lXvpI8HX7RTP0nP6onGXNa/K/UV7oM8IfcBJEOo3JKY36acr5qQ=
X-Google-Smtp-Source: AGHT+IGhaDRC8ZE1M0n1tsEORkQpuue4i3sx3d6VABGlcTAzlgZ4kqX8eW2RddB6QDt2ma7+Ob1Rmw==
X-Received: by 2002:a17:906:4808:b0:a59:c31a:91be with SMTP id a640c23a62f3a-a5a2d54c571mr780243366b.16.1715679500665;
        Tue, 14 May 2024 02:38:20 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a5a179c7f27sm701510266b.127.2024.05.14.02.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 02:38:20 -0700 (PDT)
Message-ID: <1a27254d-110b-4c01-89a0-e5e7b7c986ca@linaro.org>
Date: Tue, 14 May 2024 11:38:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux PM mailing list <linux-pm@vger.kernel.org>,
 Julien Panis <jpanis@baylibre.com>, Lukasz Luba <Lukasz.Luba@arm.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal drivers fixes for v6.10-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Rafael,

The following changes since commit 734b5def91b594d3aa1147d60c45eded139ce2eb:

   thermal/drivers/loongson2: Add Loongson-2K2000 support (2024-04-23 
12:40:30 +0200)

are available in the Git repository at:

 
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v6.10-rc1-2

for you to fetch changes up to b66c079aabdff3954e93fdd7f52bd8f9ad6482c7:

   thermal/drivers/mediatek/lvts_thermal: Fix wrong lvts_ctrl index 
(2024-05-06 10:33:26 +0200)

----------------------------------------------------------------
- Check for a NULL pointer before using it in the probe routine of the
   Mediatek LVTS driver (Julien Panis)

- Remove the num_lvts_sensor and cal_offset fields of the
   lvts_ctrl_data as they are not used. These are not functional fixes
   but slight memory usage fix of the Mediatek LVTS driver (Julien
   Panis)

- Fix wrong lvts_ctrl index leading to a NULL pointer dereference in
   the Mediatek LVTS driver (Julien Panis)

----------------------------------------------------------------
Julien Panis (3):
       thermal/drivers/mediatek/lvts_thermal: Check NULL ptr on lvts_data
       thermal/drivers/mediatek/lvts_thermal: Remove unused members from 
struct lvts_ctrl_data
       thermal/drivers/mediatek/lvts_thermal: Fix wrong lvts_ctrl index

  drivers/thermal/mediatek/lvts_thermal.c | 15 +++++++++------
  1 file changed, 9 insertions(+), 6 deletions(-)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

