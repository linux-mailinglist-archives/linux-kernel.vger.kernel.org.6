Return-Path: <linux-kernel+bounces-311091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 254A09684C0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40881F233A0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D907013C9D3;
	Mon,  2 Sep 2024 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="iZ0ySCTP"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E981613B2A8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273249; cv=none; b=saC6U3BgmyTkCJJFWyjZ7FeMS186v0593yalP4pe5Ux6e1Gqd/QpA4DJ/+H1W9or+IYVUCrD2NHfw8WxYv8rLB42XqE2njCW9aqqgYVjOTjFeMQ1T7TifmE1Hb9dWMcOtkvXi5NsJuKen/RH5uPfGfiITCRULoVOi30++gauEDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273249; c=relaxed/simple;
	bh=thNj+m9tysdWqjtQSV+YNo4/kN/AS2FzgErK1XihFw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZRwK2LVmqlNT1HHa4qMrWeCwVeDPcIe9QHaqYk3ebmcFneAgB8Se5Ino0GvwTJ4uJhAg6x95W7V1Ui+gLAySmFt6l37uqEIQz01t8SKwZHUdC6PE7w/VACIwL3LdMVSvZPGSMachM86vxJZLr/6XaXqGtv8FFl5bkt2goe3jrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=iZ0ySCTP; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42ba9b47f4eso23371625e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725273246; x=1725878046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfnknnSI88SMEAmIK9ZIqu4FUp3tloSoVvgrsROObkc=;
        b=iZ0ySCTPKMVrA5sRakqEgSqSdfMzqrTKrVrKBgJCse14fx1PKv7RdonTwxIVlu2bCp
         IjhFWvLC84U+0fFGIm9Rr5Nq9uem7ML6ujpc1IcptYnT5HNolruguDoBsDgnPgDaJXuw
         aod518deaAioQfKAWt2gGUF1fsxbBBsojUNbnf8hCTmXxwcChLKWkPJx1ci0vY/KMQQV
         RD/PWoaRHmO2XhK0kHBDBRpgohnCM/g7gaQ2s+nBnnVoJ0rH5p5X7nbkuONj2VtMyYfR
         u9UCeDA9w6JB60wjWOuRVYnct6lldhk/ZLTAy1y3iqb95Wyqm0Z9evyZr3amLC5cWfBX
         PAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725273246; x=1725878046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfnknnSI88SMEAmIK9ZIqu4FUp3tloSoVvgrsROObkc=;
        b=w/vc23kaqQn0r5oPnTROthLi6O+FHnHBE3NOFVur27qedJz/IlC1SHzxhqew4mKFzi
         uZMkCcjq73qHlElB85eV1GvDRw4g3bpSBxzvmfCb8gFRTUQGhkL6dbFr3Lj+r95IaByX
         Bc1DA5sBuv+5hcSdVs4M07LxIn7lDfYiB4o3rLuEt+PsVXYm4wigya8zaEuuSb6jbXOK
         DFAVBcXTmUkVuI9tfeq4R4+MOmrph/oDCA+RqNTPBj5vycRNaC8RLBEbEShJN1WxFZX1
         cmzpBKENQJFtJE5Ha2jAlcyvCgfrudn262JOG+bVmpFJGxTzFj67IietUZ4wCiy9EHJW
         4tww==
X-Forwarded-Encrypted: i=1; AJvYcCU3yI4Lc0ETPphGay1z3nyukKowBRz30shIRQ+kcsdAjsixS4ZuQ6wzOzwnsqXMxV8gGxmt8+qZRZlTzEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU8tWnxITNYSk8ugHkx0QOnlQSYOZFCaoB6ZNzCxnaQcqijFsq
	AcVyfAVwyASYr7QaDz5F87mkum6rnL1neBg/etjGh4ZWeZD+ND/LMScjgMFLSHA=
X-Google-Smtp-Source: AGHT+IFdFPgO+oZwmws/3Yz5eXsbV5a/tr2eiQTpD1UeVF7Ht5uaERbyauIo9GDIAHqXqR8KYzVoRQ==
X-Received: by 2002:a05:600c:4584:b0:42a:b32b:cc65 with SMTP id 5b1f17b1804b1-42bb4c4058fmr83572515e9.2.1725273245644;
        Mon, 02 Sep 2024 03:34:05 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b496:9e67:73c9:9f5a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c32793b4sm5085844f8f.7.2024.09.02.03.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:34:05 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dhruva Gole <d-gole@ti.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio-syscon: fix excess struct member build warning
Date: Mon,  2 Sep 2024 12:34:03 +0200
Message-ID: <172527323991.25859.15792653428426761773.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240902-b4-gpio-fix-v1-1-49a997994fa5@ti.com>
References: <20240902-b4-gpio-fix-v1-1-49a997994fa5@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 02 Sep 2024 16:00:02 +0530, Dhruva Gole wrote:
> Fix the build warning with W=1 flag,
> "Excess struct member 'compatible' description in 'syscon_gpio_data' "
> by removing the documentation for the non existent member.
> 
> 

Applied, thanks!

[1/1] gpio-syscon: fix excess struct member build warning
      commit: 3cbf09bfb6162a90bda5e1228d0c46ad3e4c0d6c

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

