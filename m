Return-Path: <linux-kernel+bounces-225018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A284C912A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A41EDB27C1C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D48C15D5A3;
	Fri, 21 Jun 2024 15:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nReiFojZ"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E1C15B971
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718984902; cv=none; b=AaTPRGtfxvCZMPss54jVDFv3y+q5YWkCketlbARP9/mQl4/kGS8Y/JCRotOujavMMYgrxsBgwmfBQFYNWTmyj9KSz0bABQHg9A2St3MyEz3Vg680JsNMZuTgNE/l5IdnJ3mXznIEn1fVWlvTQPju2KDtKbcaobbwM18ampCfHCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718984902; c=relaxed/simple;
	bh=/+0P7DbN0EFfEa5LSpYKn8QHKHZXK56vAl4Pv84o57o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L5vC30D+J6YmF5m8g+XKB4B0yexigCqvBQG2R2noA/ISgggjc9qQbOdsr2c2Q1MyDUyyiDk9Q3pF0DAjoCzdTzWZDiQYgUqrh1N1SIfKliN6Y+vXZ+KZSFP7Rk6VgCM9Bqhf9mvjy8jleidPPQAsY6sJvTk6sIM0WYfJ9SiN/jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nReiFojZ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3632a6437d7so1310855f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718984899; x=1719589699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7F4blc1FhU8dDIuyj3gflH2Q2a5MTAEysTa84PWYMM=;
        b=nReiFojZHZigznmcTb4X/VwhYaGm25TREq4Dl5G3/ypPV0ZCdS0K5isAPN76GSi4Nk
         TQgQ8tBd5w1sJbgyrWVbnd4dyW5DHVhtL2nOsuva7/08Vt5K0HZnsRfgjtOehhiYh7uH
         X6uqhhHrpDm34P3ZdsGTwP5PF0bOtUItRzbkt1eTmKe/BSAaV9hcnIxeTNnqeIp1OUX/
         jRAHYWUm+lGFekNHVpwryPFlN40rVp2JxGJbm2z2ZV16rV9+4xboNlY6xaFxCX8Jkysr
         /G9KaUkBeHf4y4ZlUItpmn+Z37XscttAyjf/lysnt3IgCMYvQBpFsohf8vNjUBmnycwO
         h0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718984899; x=1719589699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7F4blc1FhU8dDIuyj3gflH2Q2a5MTAEysTa84PWYMM=;
        b=ck4QldDKSUctwDtmix6iAd7htui9hEt6hztPJYJKIHhTcYk5YHAYrMWyoO8U76C7tz
         q0gDdfpMwYVYxtHIPMHDQ9hCygOXzP4ns6LynCCZN4++rUk1xrHA0hsg+hzDE/rHo6dV
         lhRARJ1C7s44+xkHocxruUT6GUnzR4SPf35fxExRRFzLxO/xhmIf8QUIalwerVHsRHKI
         FxSZ/3xTQsPohX7DPjOnuqYb6pu52lKR0aXvTrEQnkfkZEzD4DoT3Pqn/wyH4WqFCzsc
         3RuWsAdVRHRcCv/DXV6xJVUnWKE7UxFeLHdD7Sbx1J/qR2rpnUAoYUcILdra5WgafEWz
         tw5A==
X-Forwarded-Encrypted: i=1; AJvYcCVkRy8khXKIiflHkkYg2nxPSmjWXIOsBMJNJqu/BCPOH3P1I57NY+l5405ajXEwdeeYVl6n3mDbFGHB9P1tYLk5AE/A3FhBtfsgOx0x
X-Gm-Message-State: AOJu0YzWCtHw2vy7SgK/F0JatPHtO6x1qFfOirTlcS7ZI8b5O2US5Opj
	f6i8Jc8BEDPQSCN9MQWfXT+Z7+xxcumSTbF4p5o4gzcmVoRF44N9PrGQxuxl6o8=
X-Google-Smtp-Source: AGHT+IGB8sAjigGmQp+XmeJz9+tnNgM+gOHHEgHPbkVOWfg/3iCmkMwZZc40y0wkMmuZC9rNkIxLvg==
X-Received: by 2002:a05:6000:114a:b0:366:8d90:84c3 with SMTP id ffacd0b85a97d-366de857ba8mr165926f8f.14.1718984898793;
        Fri, 21 Jun 2024 08:48:18 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0be9fasm71314525e9.16.2024.06.21.08.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 08:48:18 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
To: jason.wessel@windriver.com,
	dianders@chromium.org,
	Zheng Zengkai <zhengzengkai@huawei.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	pmladek@suse.com,
	christophe.jaillet@wanadoo.fr,
	thorsten.blum@toblux.com,
	yuran.pereira@hotmail.com,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] kdb: Get rid of redundant kdb_curr_task()
Date: Fri, 21 Jun 2024 16:47:52 +0100
Message-ID: <171898481991.314245.674243020349240942.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620142132.157518-1-zhengzengkai@huawei.com>
References: <20240620142132.157518-1-zhengzengkai@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 20 Jun 2024 22:21:32 +0800, Zheng Zengkai wrote:
> Commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")
> removed the only definition of macro _TIF_MCA_INIT, so kdb_curr_task()
> is actually the same as curr_task() now and becomes redundant.
> 
> Let's remove the definition of kdb_curr_task() and replace remaining
> calls with curr_task().
> 
> [...]

Applied, thanks!

[1/1] kdb: Get rid of redundant kdb_curr_task()
      commit: 9bccbe7b20876a34c70b13430ea1b308fc8d5a7e

Best regards,
-- 
Daniel Thompson <daniel.thompson@linaro.org>

