Return-Path: <linux-kernel+bounces-349980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B6298FE2C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED521F22D1F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 07:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4BE13AD0F;
	Fri,  4 Oct 2024 07:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dq5ArJ/y"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF7E2209F
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 07:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728028529; cv=none; b=fOLoGV5bynWFSEoT6UXQtb5BjQD91Pg2VaX4VK8LgWAYYp6nfWkFjoBqTzRaprfgrxrA7ludxfrYYL71yW23Pu/AgbRcsN+rBbVjG3GcqSkRd05aS5E3Ki7J+INokU81eWPRiYjJQ1SpBroqpL+8uahNkIIUtfj2q8RrxOcGt14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728028529; c=relaxed/simple;
	bh=Sla59omVs1a66Fa00iyOK7RF8EoxQRRdQcgewA171Wc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qdvAhPHBAIVYFV/ff7BaMNLRyFJdDJrlOTH/NN2Qmz6zT9pHZCpwZY4xs3YKtnsx1ajjEu/EIiRO6Nf1rxx2snVBWEGIL7UAgZXMcoRdmhwSFgk3xrJqhTMeIB2lq9D4HU2vMNBZcvdCUo/Sl4x+T6hHOMO5Tj65kdCTmGufwA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dq5ArJ/y; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37cd1ccaf71so1631879f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 00:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728028525; x=1728633325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FhNRrSnyZylgcaxxovBMlLXGqaYS04e7rZyoS3PuP0=;
        b=dq5ArJ/y1/0JpDPhMbXQA/v7GQ+6nsYXABsLZ9S8PmcJXuUhlIf1czd17XrOmOUw8I
         VBa9oggEVn9kpZWhV15fFJozRrrhnhSNrJrnEXkb1ZAqTVkkzv9KKOeJ1Sv9ZrJbTuIv
         +IdGrni10fwSF1eJWdEinEz+rTBthuFOKAHSjmdy8MG78ZlM4XFNG0JWPlyRvVU3SE9+
         OD3UMLcgthpZAufUFhJnP7ACom5wEv0WklcOtIG7hppfEAygXmyPbbAeWW7RYulTKLoq
         DVi60zmto2ic8pbB9K4XV0+rlYTw0QVCEW9nKoqgMBrD+bnNq3Wx+ebH9ovr3ljNNabB
         Q+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728028525; x=1728633325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FhNRrSnyZylgcaxxovBMlLXGqaYS04e7rZyoS3PuP0=;
        b=QqEdE3H8GZ8jAIfVwoDsss2BObRT1+rFHw+JLm5yzGL3BNTsiYo+edrTuMZWXooNuo
         jCwejbnFxErr5wczdz+3Q1wBml7xdx7weJuwvtK1lcGbtZE65bgSVF3d1JgutZsPcK7F
         QwyE7ocnBrjrDB4Znomukj+sHyZx1e1S1FyF3SYIqqsVQADFzX5PY2DN/LyV0ASp+0MF
         LNwCNtnyRqSQU5OO38/BX1AYUQH2QcNTOBPr6+5OSao7sgJSHxjePw5sm9a2cfYLvbQt
         1165cg3VwY84uPPz0aZX7642608oTRcpNOGpIJW2Hl+8qJYW4WXj8D7lj8Tv2PyrjDui
         vFdg==
X-Forwarded-Encrypted: i=1; AJvYcCXxoDeoXmpXLqfMFwzUf4wMnl5qIf9ozNBsKBm57uIlzbLY6nEyXvBBLR+c/uD8748EXWMQTfBcYcxPaxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys9pzo5FZAM6fgyRqf/qIWuLA/uCge2RGJW1wqeZC8kdLYcXlt
	TE43wK2lExLTd2CVsOEvKyMfobDlMZE15vw06Jubi+bCQuw6lPdYu4nylP7Pmes=
X-Google-Smtp-Source: AGHT+IG1JoUsqKBdDF7cCqFuGrOBJMWIqdelI3A/3zB9ug7YMTLNfUWq7WbX04o8yxlgPk/pm0MNqQ==
X-Received: by 2002:adf:a45b:0:b0:374:c613:7c58 with SMTP id ffacd0b85a97d-37d04a7b2e6mr3435594f8f.29.1728028525557;
        Fri, 04 Oct 2024 00:55:25 -0700 (PDT)
Received: from 1.. ([82.76.204.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b3951fsm9058045e9.41.2024.10.04.00.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 00:55:25 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: linux-mtd@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	broonie@kernel.org,
	AlvinZhou <alvinzhou.tw@gmail.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	chengminglin@mxic.com.tw,
	leoyu@mxic.com.tw,
	AlvinZhou <alvinzhou@mxic.com.tw>
Subject: Re: [PATCH v10 0/6] Add octal DTR support for Macronix flash
Date: Fri,  4 Oct 2024 10:55:19 +0300
Message-Id: <172802837479.20734.613907045651385407.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240926141956.2386374-1-alvinzhou.tw@gmail.com>
References: <20240926141956.2386374-1-alvinzhou.tw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1278; i=tudor.ambarus@linaro.org; h=from:subject:message-id; bh=Sla59omVs1a66Fa00iyOK7RF8EoxQRRdQcgewA171Wc=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBm/59kHY8UWiDNnVTb3qmjpzEIQup8tWBSV4mq1 JQgVpJ+1NaJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZv+fZAAKCRBLVU9HpY0U 6dClB/9zpqjtj8auegJbo5/kDhhYg+kjoeTCDMsqktnl46imgtkM/ZfxHOUZo+EkonTBr8ahZ13 dwjxMT/EIg/Rplylb+HCXEiNAnPaeI8bvJmYjYH4GzK0K4qM2kOiRsRKUOE7dEEuaE3kA/ZfEbu BwQMQqbU40OifVNSPdeMjC5Qiq2Nl7nCClJeti3saULUKt49Cl+h+9r+D7MMt2mJMSE4bBFGY3V D9w92BNoy9NdvO4kF3POcTmCyZahASzwNsACLBREaJbz/5SksBFuVdLghM9pO4NM4dQpCn+CBGW GVazCPDVO81zDjcxdPgYefTat7UAMYMkjf1ctpHoZlXzB9pj
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit

On Thu, 26 Sep 2024 22:19:50 +0800, AlvinZhou wrote:
> Add method for Macronix Octal DTR Enable/Disable.
> Merge Tudor's patch "Allow specifying the byte order in DTR mode"
> 
> v10:
> * Further explanation on adding Macronix manufacturer ID in ID table.
> * Correct some typos.
> 
> [...]

Made the changes that I specified in replies. SFDP
"Command Sequences to Change to Octal DDR (8D-8D-8D) Mode" can be parsed
later on.

Applied to git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git,
spi-nor/next branch. Thanks!

[1/6] mtd: spi-nor: add Octal DTR support for Macronix flash
      https://git.kernel.org/mtd/c/ccac858d2bdb
[2/6] spi: spi-mem: Allow specifying the byte order in Octal DTR mode
      https://git.kernel.org/mtd/c/030ace430afc
[3/6] mtd: spi-nor: core: Allow specifying the byte order in Octal DTR mode
      https://git.kernel.org/mtd/c/6a42bc97ccda
[4/6] mtd: spi-nor: sfdp: Get the 8D-8D-8D byte order from BFPT
      https://git.kernel.org/mtd/c/46b6256a68b4
[5/6] spi: mxic: Add support for swapping byte
      https://git.kernel.org/mtd/c/50cb86f21ec2
[6/6] mtd: spi-nor: add support for Macronix Octal flash
      https://git.kernel.org/mtd/c/afe1ea1344bb

Cheers,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>

