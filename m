Return-Path: <linux-kernel+bounces-335191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5099B97E266
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 18:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E44ADB20A54
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 16:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCDD17C64;
	Sun, 22 Sep 2024 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hC89t6Hk"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2422913
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 16:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727021569; cv=none; b=VDlCUNvHFfYsG9QZ6uNEmKxVT6IOD/Y6oPuxtW2sTsH9LL/SmsQLFMpSzDlT6OJoVFBUYOXoL/VfRE+zBMzliZ7ZFieU7uPUyDAZAy0NxsNDH0Jd35y1jQnHl7Kc1/WxmIc6dc4hx3npvYEJvX0Wz+WZGx1EIQFkEiGsoWZXQuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727021569; c=relaxed/simple;
	bh=PxbF7KIDgeswLzBAgkyjDFXslQAxh69mkGfEpa9Lr58=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xjm7k8psIcD9j6N2UIjvmYxw5de9YUi1X2468Ex6ChNHRgGNJJe0ie3VantbbQxuxs6W6kkPNItvToewyQtZl1PB5N+fZD7u/Xw3WPFv1iQP3uMoi8YPZi+biBmHeh4asMqfAVrTQ9VlH1VOo7zXQnrzOiN9y5L4F//EUD3v71I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hC89t6Hk; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5369f1c7cb8so4495557e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 09:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727021565; x=1727626365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QNw0/2euWwO8oJrG8EqU+t5rpgVcNTbYcUPfD5tgmnk=;
        b=hC89t6HkWu8PdML5Q1iVuTMCT7zROFumgF4TS01T13mpgJVwVYnuw39cAxhU+C7wKW
         HIJiTVL33WdZY/rqH8jfIvAm6+OSLEnzcjbP/ELcyXeAw0LKmI3jLJEM32Kd+m9Kjv9+
         Mz9RrJcMgGW1d1KYyYPr2NGrHpfDDPKc1FMhXBy8LsRtdxfqvIc5cIEd3DS08m26TgwB
         7IohrJ+moVOD/mCOGKXwAgbQQlhCh8DECIdnu6pR0khV3gmyEbTXEysZqsNwDFkuOHRD
         S2/U+QZYQlXATYo/DMeuak7qLz7u8rbTC7yY2KN9vjgqahabyk9v3ihngSmBW6Am7M1q
         yjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727021565; x=1727626365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QNw0/2euWwO8oJrG8EqU+t5rpgVcNTbYcUPfD5tgmnk=;
        b=pfcw3IkW1UDjG5K+iczj4Q9PeL/KaraoBDfHD2aP6XDC9chO/cGrsxLBLDBBTINpqB
         OtyFLKhHuZ6oPvAxwybGnx9zZXRGWzOHHReEcymM1rfCgPPNxB6WQ7iSA/L8Gm9CXLwE
         QZ/USBHwXaQE95HND72AumTF5h0cU8TgHetIfvG+w8EIsbo/ZRU/6aB8sn5NHh1pzyuf
         uxCPtZIiln+cFvzfm3M51GWSa7+fScYEQvSz60QxMfPYWHT/DMcC/wFiptf9zYTsVV/V
         Yn1e8bJEHjweyT1JAKZr1dONj0Vk/cRiXO54Og/zolGTCwEJuKA1WaxJcljSOKsQcTJl
         phSg==
X-Forwarded-Encrypted: i=1; AJvYcCXIZol+ZytOLGqwmF8EK8Lb3wLTNRlBfcclv3I8l060mKvM4kCLAQfwq3OQK3vyTx1IilFeNWjyozRGYps=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSV0d8vM1FudzR7jgtcnSRmCPPfC/ETtdIf9DBO2EK7pW1kQoe
	PywvBjNgHnwIIsNLejeCh/fg+rnHxqscUtquxvcudQzuQFmDDLH9ELg0X2Q6ARlSc3MD+NT7Wk6
	2NfM=
X-Google-Smtp-Source: AGHT+IHrHkrXionuyJuSlC4/JFdsVtuuk2CJnoDi1RT/0/wLn7DmA/8XyDMWQDAf7QEs6P814vwmVQ==
X-Received: by 2002:a05:6512:3d1d:b0:52c:daa4:2f5c with SMTP id 2adb3069b0e04-536ac33452emr4622850e87.42.1727021564722;
        Sun, 22 Sep 2024 09:12:44 -0700 (PDT)
Received: from eriador.lan (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5369d5632absm1938905e87.247.2024.09.22.09.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 09:12:43 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	tjakobi@math.uni-bielefeld.de
Subject: Re: [PATCH 0/3] Panel orientation quirks for AYA NEO handhelds
Date: Sun, 22 Sep 2024 19:12:40 +0300
Message-ID: <172702155424.1364397.1004758299220219518.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1726492131.git.tjakobi@math.uni-bielefeld.de>
References: <cover.1726492131.git.tjakobi@math.uni-bielefeld.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 16 Sep 2024 15:18:49 +0200, tjakobi@math.uni-bielefeld.de wrote:
> From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> 
> Hello,
> 
> this is a re-submit of panel orientation quirks for some of the handheld
> devices by vendor AYA NEO.
> 
> [...]

Applied to drm-misc-next, thanks!

[1/3] drm: panel-orientation-quirks: Add quirk for AYA NEO 2 model
      commit: 361ebf5ef843b0aa1704c72eb26b91cf76c3c5b7
[2/3] drm: panel-orientation-quirks: Add quirk for AYA NEO Founder edition
      commit: d7972d735ca80a40a571bf753c138263981a5698
[3/3] drm: panel-orientation-quirks: Add quirk for AYA NEO GEEK
      commit: 428656feb972ca99200fc127b5aecb574efd9d3d

Best regards,
-- 
With best wishes
Dmitry


