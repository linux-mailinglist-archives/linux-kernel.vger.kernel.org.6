Return-Path: <linux-kernel+bounces-217721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A83090B360
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07532282372
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE24714BFAB;
	Mon, 17 Jun 2024 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzVY30BC"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9072414431B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718634034; cv=none; b=LPFbRZIIRt1ngjqTgzWlGLO7SxIZaSY3QfsBcJfP85IiQgHboLespHT1TN+yxEOXB/MozLvuqju5EVRsMVrBA4RrmizfcMLvWq3w9+IiMrFTBwLL6CFnIj9SbjqqnkAbIwfIQegE40S3RJPlQOWoSPIR146P9J3HUiIxZk+8nHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718634034; c=relaxed/simple;
	bh=BLWjhTz9auRnPED7pzPK5Gv0CHN5R9TR+CBFMEwRnuU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QPHZ7nez5Yc6btaOV0CKpEHOBVIbrNP5oYu0dW3dBum+OSi8QR/SKkMkmM+MOOm4om+5J8DxO0A4KwEzdFtsahO4w6BjKldDLx63w5cW3NvUqF8AjgnpReZz3RTcDzLZZMOeQMwVCTLcb7zaS40al8pS1StzFdo5S7Jc1Hal5ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzVY30BC; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f6fabe9da3so36350005ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 07:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718634032; x=1719238832; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CGju/za9vCVu6h8SrNjMi4i6Ke8EtAFHTVEqRy1dMv0=;
        b=fzVY30BCEKX2F047Hsd1r4bezgsdMY4820iDc5XhWuiZQNjqtMY2In5QRj9zd1XHDJ
         YRSPaueJTd2ZG0eW4/UBCfMZkARm80Bs3Xkl1dcePHXz0qg5Uo4Y7DdEIlRrEvLXHZMj
         an0HdipA2eQc5454NmbYIbd188Xrrpz57TkQwUKktgIhz30Q9QNTDgBNlU6zfmC+0eQh
         3mG+VDzBvwyuMh7YWMUwgvoDod8zTr+WOf1/zeFP6NX02CIMVwmLfj1AxsT4aW8ShhtI
         iUJL10MfytHL4kr7BjE08U+N18faam7HfRnoKWQ42uL3iYMYL2LPbSR6WjpwzQzUFCPG
         1B/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718634032; x=1719238832;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CGju/za9vCVu6h8SrNjMi4i6Ke8EtAFHTVEqRy1dMv0=;
        b=LHeOOSDhoVHIo6ZDn2O8ZB33EdvEK/qNXloDcowq7IwpQnAmZkePq6B6mtUcRtWKXd
         Pdtpi3S66lCvleSWAxFuFsSdDRGJI0BHF6X9HEHv4ZwBffliGTwLM+TqJFa81SAN3F6/
         BQQTZD8IZ9d4SFBHpkb7yAKsVGd3Mu/bCx8r4c6ZE6+JN6QcwzdHuNpRPj+C3H5Qtbwr
         0qZHATRjV9ntX1nuvqxJfcFdFeihac0TGXcLFUrYHjRFAH4cvfxJbcnbcSmsw2UqanxB
         C1gUP069+/WoK2LEth56yFKxXzI6OEbC4ts2wRBKmN1vXN8fkFIhGFQrSQMG38MbbWYg
         ReaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7BbeVf/qli/+RDeoJixXbGyAlwFC8RNWxZ8dz7pbeO4bZUG7TZWj7qoupTLkP64DktHskkCfQFlAlW0cObmjuQYGqUi+JxZpkjce0
X-Gm-Message-State: AOJu0Yza2mJaR9A6S4djXcQJ3Cj7o3KwrN4kCTk4QNud9alii44M4wwW
	uGuTdAF1+lFLEVpfhLUEiKJVrf9xqslRXUVsn14tvntnrmEsSpdUymQMhw==
X-Google-Smtp-Source: AGHT+IEZPD3wbPIwoYVAT8iE4bVHUU2EnVCA1ySihq/0rH04S0ll9cpbG1U0dTH38FHukUrQT6wLtA==
X-Received: by 2002:a17:902:6b81:b0:1f7:1d78:db3f with SMTP id d9443c01a7336-1f8627cc4bcmr97314385ad.33.1718634031589;
        Mon, 17 Jun 2024 07:20:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855d1cbc3sm80009225ad.0.2024.06.17.07.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 07:20:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 17 Jun 2024 07:20:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>
Subject: Page select register restrictions in regmap core
Message-ID: <e3e11724-794d-423e-9326-ffe8eed5119c@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I have been trying to use the regmap page select mechanism to implement
page access in the upcoming spd5118 driver [1]. Unfortunately, that fails
with the following error.

spd5118 0-0050: Range 0: selector for 1 in window
spd5118 0-0050: error -EINVAL: regmap init failed

The page select register in spd5118 devices is outside the paged area
in an area which is otherwise (i.e., for other registers in that area)
only accessible from page 0. The regmap range configuration looks as
follows.

static const struct regmap_range_cfg regmap_range_cfg[] = {
	/*
	 * volatile registers, only accessible from page 0 except for
	 * the page select register
	 */
        {
        .selector_reg     = SPD5118_REG_I2C_LEGACY_MODE,	// 0x0b
        .selector_mask    = SPD5118_LEGACY_PAGE_MASK,		// 0x07
        .selector_shift   = 0,
        .window_start     = 0,
        .window_len       = SPD5118_PAGE_SIZE,			// 128
        .range_min        = 0,
        .range_max        = SPD5118_PAGE_SIZE - 1,		// 127
        },
	/* non-volatile data, pages 0..7 */
        {
        .selector_reg     = SPD5118_REG_I2C_LEGACY_MODE,	// 0x0b
        .selector_mask    = SPD5118_LEGACY_PAGE_MASK,		// 0x07
        .selector_shift   = 0,
        .window_start     = SPD5118_PAGE_SIZE,			// 128
        .window_len       = SPD5118_PAGE_SIZE,			// 128
        .range_min        = SPD5118_PAGE_SIZE,			// 128
        .range_max        = 9 * SPD5118_PAGE_SIZE - 1,		// 0x47f
        },
};

This works just fine if I comment out the select register validation in
the regmap core (the one which generates the error). Is there a reason
for having this restriction, or would it be possible to drop it ?
If dropping it is not possible, could we possibly add some flag to the
configuration data, indicating that this "violation" is on purpose ?
Alternatively, do you see some other means to describe the ranges which
would not violate the restrictions ?

Thanks,
Guenter

---
[1] https://patchwork.kernel.org/project/linux-hwmon/patch/20240610144103.1970359-3-linux@roeck-us.net/

