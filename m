Return-Path: <linux-kernel+bounces-292462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB750956FB6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097CB1C23C00
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C593189B84;
	Mon, 19 Aug 2024 16:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xjh9o9PP"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F42176252
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083386; cv=none; b=JR5YMGWSJjp5mvBZbQFokb/bII23mDK2tlmaxRKdNeU/L0bkyAaZglIheNvaAmLo8OHy/+3zT/7iaV2HzhggueoLfXM8KtLmRQP1PoqshGV97UTgKgGZ9ylvlRHuSQitajnBrI5f4+XlzwVlEWV9RJrIkfKcuaxcvJ1XoluyVEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083386; c=relaxed/simple;
	bh=QkvRf2gJWrII8R9fwrAbCEH4Jv32FkCvpWWs1LsQX5U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gqbGQX6JAsA8Yy7iuiRg1iwa44bsMyw4TRA/BzAC2xGSnsJriKO33CX5mrMaEnPezQKW80qNmW7317oqzKXoxgZMuMDGaUIt6D2/hiLiHvwxBZnrBOHhq23FhpgKMD/JsH4N8Ujuu1gqOWAj+LkSgmKh2hHu4uSEC4OG+2XRTBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xjh9o9PP; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-371afae614aso1393527f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724083383; x=1724688183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MygLjWxd/cuymlBwTrUlqtMUCrnCHV/7Hdz0OscdB14=;
        b=xjh9o9PPgKOb4BtXVO6lhlgJg+vRpctZaZfd2pk1VqyQ4xgRxVMSoSiGNt1LECLovr
         PSyvRpR11A4DVPY+rCv42mDsa9KFADPN+2HRdZuvue/A9a6x/2nGPmSftKyg0oQ4KLqD
         sQ/tu2uB+Ahuo46dPT0x0XRHDYLvHXgD8R4yRUtYARM33INwbxtiquakOyH4pPeY16s6
         zF+GS6AAq+/+caE9XZJBq6br50RGjFuEN2RFqeYD9kjZLhiLeDTJ6HsFF0ZzMTHe8d2N
         4pqnx6+wZVNzE7IN09MFh71bfoMDwZo/0Nqcg8q9SBKme8RQ3sUdHmzv4Gkvvh4yMXUQ
         yHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724083383; x=1724688183;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MygLjWxd/cuymlBwTrUlqtMUCrnCHV/7Hdz0OscdB14=;
        b=RCJmgtOS/IfjLAkU2uR1l1LG+Vo9CvNa17r3dHHGeg6jP4d0xvYFS6YALGuzZu/Wl4
         f2dB/4OHmvIYhj/FRvAh/JcGmY+zbYMH34NlbXIB4L1SmD7q+D1Y8B02EErYE7R1UOOc
         ymXdMK1qyG0c5cSdJ9Zm7l05ZwORp/xoLLCmGRKshNNYI1cy8AkBgAjB4P8RgYFYWsoD
         v2AU6dIU4T+LMaAcS52XvVlf9R4HVTd7pH0PeoBde8CWfyVmbPWdUdfSvyjZeVEs1c/m
         Jj9imxxjA0KJWZz6Lao0b+JtCd/XFV66RuNy2x8t6susZuh3NsDi2FQwVH/dPL2b2TGK
         wYmg==
X-Forwarded-Encrypted: i=1; AJvYcCV2ia4seDg3Yb9Ji5jep+kZz/zKNgZvTz+olBgYDvbL/WZyeQXLdyNVJ+35XzQVdsZrtYyZV/CZ6o/pxcvmJHfakptStd64ygo2r1B3
X-Gm-Message-State: AOJu0YwjRBzR1soV0/hvMYqXFEnM3NVd2NTJ0FTuTF9Yd1EbGx0LdMFu
	VrpuyGPB4/FJ8bQT92NowIMypWDeL2s9E6e/Mi1sE5ibtM+4tUkPF8xjz3+t2n8=
X-Google-Smtp-Source: AGHT+IGDL1BghlbSzux3yJZeahaJWCA9neTeVGdK794uq57vTBevwaiQ6Y3pvsnu4kDp2NGOiX5ylQ==
X-Received: by 2002:a05:6000:1006:b0:371:890c:3157 with SMTP id ffacd0b85a97d-371946a4611mr8314976f8f.38.1724083382820;
        Mon, 19 Aug 2024 09:03:02 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898aabe9sm10907638f8f.92.2024.08.19.09.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:03:02 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: quic_jesszhan@quicinc.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, dianders@chromium.org, 
 hsinyi@google.com, airlied@gmail.com, daniel@ffwll.ch, jagan@edgeble.ai, 
 dmitry.baryshkov@linaro.org, jani.nikula@linux.intel.com, 
 Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240807100429.13260-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240807100429.13260-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: Re: [PATCH v3 0/2] Modify the method of sending "exit sleep
Message-Id: <172408338165.1748689.14599426466774624687.b4-ty@linaro.org>
Date: Mon, 19 Aug 2024 18:03:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0

Hi,

On Wed, 07 Aug 2024 18:04:27 +0800, Zhaoxiong Lv wrote:
> This "exit sleep mode" and "set display on" command needs to
> be sent in LP mode, so move "exit sleep mode" and "set display
> on" command to the init() function.
> 
> Modify the Melfas panel init code to satisfy the gamma value of 2.2.
> 
> Changes between V3 and V2:
> - PATCH 1/2: Modify the commit message and subject.
> - PATCH 2/2: No changes.
> - Link to v2: https://lore.kernel.org/all/20240806034015.11884-1-lvzhaoxiong@huaqin.corp-partner.google.com/
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] drm/panel: jd9365da: Move "exit sleep mode" and "set display on" cmds
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/97d1f449c359207b2fb5bc62eaefb7e21ad619ae
[2/2] drm/panel: jd9365da: Modify the init code of Melfas
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/64ddf5123eff2edf47202e08744c3c14a9d28f59

-- 
Neil


