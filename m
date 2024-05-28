Return-Path: <linux-kernel+bounces-192215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 623208D1A1D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77261F23A6E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8074416D9A7;
	Tue, 28 May 2024 11:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EHv+6h+0"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A25A16C878
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896748; cv=none; b=UYP2MCGI5bp0HpjD1qjoYhb+eDuf9ShfwQzSzOkQ3OJ0MvzhqMZOD52Aub9SNyQGwrbCuiII8r1FtCwS/78Ap7VpbDYcHzzhvklqVvLUEa0RaOlOV701c4Xx7/wwRaVYTeOFtPuXRuV8yYMWHSZ9e7mJiIUiRSB1B3yCDp5rkMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896748; c=relaxed/simple;
	bh=Cyn0ZlNcviHjkEXTH9iWy+1yurJIkOQsTzZX3IFxF8c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M86NeXaMcancUji7HxubYJ1mqzk6NSv+LSfrn3b+yeyKGeMAtWVzQ+zGjgqxbyScsYOzekNrGyVVY7miuP+OS4etgwYIGgNq9JmaK6yR6TToBrlmV7kxx9vx+QlP6LLV+OWNppM9ZFsaZS83qnchcD81aj6ZCv7YYC45ruDCTcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EHv+6h+0; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6269ad9a6fso92006766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 04:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716896744; x=1717501544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gs1QUfWnNTWVVMoflcEKhCp+Y3rJQ2FjHWIov/l5yc8=;
        b=EHv+6h+0YQYO4PMI8m4utqV4k7fZHkFk1akdCzqCpVXvBVzrzMbcIU020BIYP7zzl+
         XNnK7Rmh0+RojhhIfv6oJFcMKuiY/7xOof8I2XTS4xYupfVVMFxbWuwNPQ0npRWOkllF
         PQyz7q5aa1coM7Z0fziGvA7J8xNRwdHVZgGHMLEI/R3Td/1CQo8KLEqGMaKnn8X+TldN
         p/58LPvxf4AP5xlVeRBslmJb/dtds7MXG9XuAWH4oceSjGxWp5qclU094VM5/eBCRaD2
         mZWvFxY4iDztRCUuCN9dJvW/zkkz7whBKsunP2XXQNApyfTvMrXDQwC/Hw1oCBZlsT1F
         9lwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716896744; x=1717501544;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gs1QUfWnNTWVVMoflcEKhCp+Y3rJQ2FjHWIov/l5yc8=;
        b=Hbo7NxXra8UXVWsLfbdWbHQGRCvrIkPtxgjOu7Mi5ZJJkusOgQYEzEgzT/QKGPszGW
         71nKChwPfoL2AEzup5OTZ2dg4szTOvo4TbLj4DUBXvctEzyTQH+SnISdu0ApcofcyidH
         em7V0uMg0sEruGN2ykKjTpSCHmV4h+gKK8WaxC0BzQKnMo69vP/QnAbU/AHj9bQgNuGW
         cOHBYvAO2nUJ8C7miV9IGhX9iuqICXxA77BxRYMC5SnoK5AsCUDoFzkUMX9nRIEN6Ywc
         S9r+ZterRPOCGk7QJnOe2d1KHw42zG2Jsm4pWzF+vyVc4TN9OUICgEHo9dqzZ5eKzreD
         9rUg==
X-Forwarded-Encrypted: i=1; AJvYcCWgKQXCSck5sdQ0skxfDKYd2Sfmt6lJMp1PZPes46Mf2J2S/sDUYIr1uk+4x/+DMWERLFNwCS4YambPMqBdXSBqxyXpedbw/ntvQLuW
X-Gm-Message-State: AOJu0Yxd1FH4ULWzNCc4+7vxzBIarMy6HDqHM4ySIZo9fdslSyMRoAYm
	5Oyps36JvZjkIhbWCa5C93sTxqD1Zuq/VKzK4t4rMC+ZettrEKV26kNCzfzg1KQzMJn5LIpt738
	9
X-Google-Smtp-Source: AGHT+IFxlZlJ4wDQ2J0xN/ryGeuByEIqz96HUM0d+K0FdcFLDBc0ijzJee4UW8RAK2ccNbBjAMBr/Q==
X-Received: by 2002:a17:906:b1c3:b0:a5c:df23:8c88 with SMTP id a640c23a62f3a-a6264f15bdemr680485466b.49.1716896744362;
        Tue, 28 May 2024 04:45:44 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c81773bsm605825066b.30.2024.05.28.04.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 04:45:43 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: arnd@arndb.de, Thorsten Blum <thorsten.blum@toblux.com>
Cc: amahesh@qti.qualcomm.com, gregkh@linuxfoundation.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240507222226.288074-2-thorsten.blum@toblux.com>
References: <29b33c18-f123-4656-8507-406c87a12ec8@app.fastmail.com>
 <20240507222226.288074-2-thorsten.blum@toblux.com>
Subject: Re: [PATCH v2] misc: fastrpc: Use memdup_user()
Message-Id: <171689674351.20426.8981962769310707800.b4-ty@linaro.org>
Date: Tue, 28 May 2024 12:45:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Wed, 08 May 2024 00:22:27 +0200, Thorsten Blum wrote:
> Switching to memdup_user() overwrites the allocated memory only once,
> whereas kzalloc() followed by copy_from_user() initializes the allocated
> memory to zero and then immediately overwrites it.
> 
> Fixes the following Coccinelle/coccicheck warning reported by
> memdup_user.cocci:
> 
> [...]

Applied, thanks!

[1/1] misc: fastrpc: Use memdup_user()
      commit: a16833330e2fa60912af6abebde711bf2c672cf9

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


