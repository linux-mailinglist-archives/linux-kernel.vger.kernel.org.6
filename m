Return-Path: <linux-kernel+bounces-438327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4D59E9FC9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4479164E07
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE62198A07;
	Mon,  9 Dec 2024 19:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dU3qvQ0p"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C73115853B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 19:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733773264; cv=none; b=ZpYJtvUsVafrYq3P6zONWj8rMip9ioGLQVgJrx86ddWxtWZOCX6wUov2f7pBY011XSH+OsNhFCLvwNnuee63OOJ6zphPwJD5Hp8ulVEpRONSZuxSlLBnNHjIoZJnBzUR7zEwerTZWGemFrWr40WTwwnj/y9MhmQII1lIVusfrZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733773264; c=relaxed/simple;
	bh=wsj/MnKeoarznwWrTt+Dgsg9TMzJpyi2x+4lK27J4u8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a59aUqaNBUsWVFtIOwiN3zE6HweRzDl7RwDMHo8vRVYwMmIEnwTgf2XZMotfSbZ7rcmfWFgPeI9WrtEtNn2s3c6fu+lu37Kcy4PEK/k+fhRT67ouGYSzgaEoy/jlDVg27z5vTcREBgE/gb9E+NfcUdjoIcxWpMGod8bJBVNFhmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dU3qvQ0p; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434e8ed6389so1596885e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 11:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733773261; x=1734378061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TeUV7ATPGzq8ARMGli9TBeGlG7WubOrXx2cbt2C9Y74=;
        b=dU3qvQ0pqd6A8KTKk7zaFT9JHxlFKZHWsmNFBdUgzoq9WR8zK/XWShh/t/ZEuaGEB7
         mRlHI0GiI2NURPUiXClYVl2fHtrNvqf7x5MZwTjxf3b7rwHo4kwq5hmB62xr2UornymM
         LPxP7rjw79BqzsevJp0clsibgzq/H1KAP8aIbjVE2fv7Myc5ZmwlaQfbS3U6qfSttR6q
         /K/7Ow92A691JxYdMmZdVZ32mBkoiZGmYoUb0Ix38uq5SbW1MEDdE/smD1pvf0z/yur8
         5VHO2sCfDyLXkFQrqcUD5AwSa12or1ac1SaOzrSZqERGgCmY8sKp6hA3Ycb6GnUeHhgW
         NoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733773261; x=1734378061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TeUV7ATPGzq8ARMGli9TBeGlG7WubOrXx2cbt2C9Y74=;
        b=sqthg4A/1Cn83Lqc88AzXSIsM37gqKOkux9wMos1pnhhT7EOJUqtS+tXdjTnTdHQmF
         yvAtntGJL86BmnkJRbVVV9WpK1jAkLAEXvO9fF6PgixXB2zwcByiWyDtQzmRvF/ZTmSN
         Iq2j5E1TOTo5dHSlvtpcgok7dIMkTHDcGrN35J3/S585yjegLc0c4x/l8QPrIQIJKd/n
         gFNuFpTQPojTTLRXe7wOTxFQrtz+EjGhIiATkUxnGdgsUHE2wzfi3vy2dqWLhl24l4bt
         LqM0uq2sFv8w9Az3V7G3/FN7PDcJBj1hc5jiU1OKXG4z7TYxz0R2sh+nVhTHTRPgNhan
         plag==
X-Forwarded-Encrypted: i=1; AJvYcCVB3e73UNChmAg9HZ9O5jmgX4m8hmsm9iO3Ogq6L9tCLne9wWfUYBbLVbXn5GNqMFNUIc26AAWW1D4q5b0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3VLzuVjBPlfoj2xFgWPIxQix+gu2kKYRAwD6JCKQ7bPvA7EC+
	k5tW3MEIzDf+HVYMVImI6LHKq+RBI9hoZ/QdBFewWg5MX/FWm8TAH96GPl4YNfQ=
X-Gm-Gg: ASbGnct9uCs6DfJ8mEQ+ue4HASi44CvnG8ub+JTDDgdBQ11JznfIWHzS+1gs45RZirp
	fxkRgz+X6k6Tjn3UvhhQ6+ob/V+YMbAeR86cksWmzgeVpGu3ZdJdF3sR7N+5yhVSffi+4elJWdn
	JVQ07kbaQVly0Jj4/Eef/VT11RbJztlVfn1tCLXHHQtRjBYhpUsrzITCrMIwfnHv/0+hIxZeE3Z
	Mq0uphrzngwke89CBUk2pVfJustSqZJWuMIy/AHsHRdX04AY74ZklSYOzgDG9Ag
X-Google-Smtp-Source: AGHT+IH3wYRFE09ZMScev5P6t8HEEvM5cQ4HvJNjFYxwWecu/5OqRvvW9SX6tcv2+5NXUE7IyZwIiQ==
X-Received: by 2002:a05:6000:1565:b0:382:4e5c:5c96 with SMTP id ffacd0b85a97d-3862b3aa8bemr3627505f8f.8.1733773261434;
        Mon, 09 Dec 2024 11:41:01 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386367f7c71sm8273964f8f.41.2024.12.09.11.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 11:41:00 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Santosh Shilimkar <ssantosh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Christopher Cordahi <christophercordahi@nanometrics.ca>
Subject: Re: (subset) [PATCH v5 0/9] Implement setup_interface() in the DaVinci NAND controller
Date: Mon,  9 Dec 2024 20:40:56 +0100
Message-ID: <173377318397.159219.10800117213949308208.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204094319.1050826-1-bastien.curutchet@bootlin.com>
References: <20241204094319.1050826-1-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 04 Dec 2024 10:43:10 +0100, Bastien Curutchet wrote:
> This patch series aims to implement the setup_interface() operation in
> the DaVinci NAND controller to enable the use of all ONFI modes and
> improve the NAND access speed.
> 
> PATCH 6 depends on PATCH 1-2-3-4-5
> PATCH 9 depends on PATCH 6-8
> 
> [...]

Applied, thanks!

[1/9] memory: ti-aemif: Store timings parameter in number of cycles - 1
      https://git.kernel.org/krzk/linux-mem-ctrl/c/1ec0fa90070c9468d22b3c3ea5f4bd6c27810907
[2/9] memory: ti-aemif: Remove unnecessary local variables
      https://git.kernel.org/krzk/linux-mem-ctrl/c/b3d57e179607106d5b08a635c49b338c409357d4
[3/9] memory: ti-aemif: Wrap CS timings into a struct
      https://git.kernel.org/krzk/linux-mem-ctrl/c/30b4da67655469bf8d4b8ba7c001096a1e10c7bf
[4/9] memory: ti-aemif: Create aemif_check_cs_timings()
      https://git.kernel.org/krzk/linux-mem-ctrl/c/2c7b585d19cc1a7185a3a0b58cb643d28fd19cc1
[5/9] memory: ti-aemif: Create aemif_set_cs_timings()
      https://git.kernel.org/krzk/linux-mem-ctrl/c/a6d60e3376065752137ec23d103f7d039c363e41
[6/9] memory: ti-aemif: Export aemif_*_cs_timings()
      https://git.kernel.org/krzk/linux-mem-ctrl/c/df8e78607d4795806b59564ba7a3e2e125d119fc


I'll wait till it hit next and got build reports and provide these as stable
tag/branch.


Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

