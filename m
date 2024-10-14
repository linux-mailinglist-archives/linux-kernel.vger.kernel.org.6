Return-Path: <linux-kernel+bounces-363519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE06C99C369
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 247DBB2643E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6FE1537CB;
	Mon, 14 Oct 2024 08:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0gZOtEED"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2747515853E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894718; cv=none; b=Tyj9dCfznuAN2v/OioterBemourZzO+ob1DwA8wTcwxR6u428Gv0KZCP1NpMeKC5n+OkIlwQgvvjzB9ufhk7u0sgnm40NARSw4SvOeblUTudXGuYsuIukRRpbPXKK9CfLZFMUPSfQ7kRJtMYiPpliabWx255IHrd1cBXwXvJa44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894718; c=relaxed/simple;
	bh=ERtyTosM76vUpxtmF4Cy1QAhArlJoqd656AhoSYKEzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ni+rc8DUaKJYXxTToUvhjbKYEP1YOBXtG5wPLhQwy7Mguz9xSBh1J7wYOSVCoSFkocodlwlidCVO3E8Yfy918Fpf9FUAt9CWfH2jZki+RJxViRKIYbGf1lx9cVfxeVDqPMPC3zZ7dfB1aIcPg0EnuECVucM+UsJBNGes5yOMIq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0gZOtEED; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d6ff1cbe1so757778f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728894715; x=1729499515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2r6ByVWzke2vujVQcymK2DMK6uDZmMPvMtc2XOTnxDw=;
        b=0gZOtEED6HsDq8akqOvGp/rDB2gabwUUKjgwsZ1EKIOL+vHF7Ye/m3WPL+bDxuErsM
         Ys5IXgxzcK5RRNKLx9rmvf3eu5cKaNil+1W8kfIRdAGIse/GjezWKu5LwLbpEJpNRs2N
         p0MziFQKG3zk0N8avzm9u4smxiKxTEan2/m1zeBd0HHRnvEQgqxoMOYxMFO1tezWDJSw
         4Ck1xJi9FbMBiGYpLclZCEdbYU9ryGdPdjgXg27sb7dGCx0S8pEWvwsTiNxX3fHFvVPt
         F96Sh888z84i9lU96uC3mBLtB6PQ3ZCO3VR5dIaH3hn8bpnJfQ7rq6ccPg4TGN4Cr0mY
         65mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728894715; x=1729499515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2r6ByVWzke2vujVQcymK2DMK6uDZmMPvMtc2XOTnxDw=;
        b=IWmKGeRYwLVpGPK23RfyE/xMIPjdE40QIYy7hxuFiPqQ+2ikV0tJ2hj6SAM15VQnDe
         o4q+WfBTXc1bPizDaUViSxmDePL1bZ5BdYT1czsNF5y0gMFS8kl1bkXAsSxAfs3jDsNO
         kEngD9cFx5DK6tpxqc/6xDC0KCWviugNlPprYFq58X5niagoTQX4AsxJBo+FwiigS5XL
         cj2skb0aY773NvYBj72+W6q+kMVbotxwBkoVGK7n510o8fHbgiQ8OvnBPw7EZa6dBjJW
         gtxC2WgJGLbQwOFXJrPHsRSFDsKRcYEmDbfkT+0XuSaXDHVXfPVESLgFjyPSo3IoHlpo
         m05w==
X-Forwarded-Encrypted: i=1; AJvYcCX7DUERtI/QmeU/JztmRoY/ZlfYzx9ZUFpyZRPJH5TWWNYs1QlNifKpBR/3A9p3lNc/3WXvasOTrcJL0Gw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3UA9mV61oo3UkURglhS8xRl00F/qvV3vFHbhSpD+/DcGcvZtI
	H4kxCBq0EZit5svy5lPzIKR8xJPWXg8qV+tkv5UxpzG97as3gk1/2R+1CrWTYZ0=
X-Google-Smtp-Source: AGHT+IGIOdFxLJHhDKqHPfpJzhzMoyFRXNhpGgdVWJc0mwOlZYlsCxtQM3/3LF+Q+9Wuxo6GXajhpg==
X-Received: by 2002:adf:f3d2:0:b0:37d:37b8:3778 with SMTP id ffacd0b85a97d-37d5529e7dcmr7002601f8f.45.1728894715399;
        Mon, 14 Oct 2024 01:31:55 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:de54:ebb2:31be:53a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7ed69dsm10737698f8f.92.2024.10.14.01.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 01:31:54 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: ts4900: use generic device properties
Date: Mon, 14 Oct 2024 10:31:35 +0200
Message-ID: <172889468795.57095.2124355920743532392.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007104052.39374-1-brgl@bgdev.pl>
References: <20241007104052.39374-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 07 Oct 2024 12:40:52 +0200, Bartosz Golaszewski wrote:
> There's no reason to use OF-specific variants of property getters.
> Switch to using the preferred, generic device property helpers.
> 
> 

Applied, thanks!

[1/1] gpio: ts4900: use generic device properties
      commit: 16de489e3a3009e027a86858bfd645126d391502

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

