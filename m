Return-Path: <linux-kernel+bounces-192216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B47E8D1A1E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18A991F22E12
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD6B13F431;
	Tue, 28 May 2024 11:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e23VPRCg"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A9A16C86F
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896749; cv=none; b=Ea/IlRUcDaK4XBBXOXc8Ztqzx0A+BjfmN9QuxXiouwkpmr+jOekPYd/onQCWG4Vu9jU6p4PUQjeJutZX+IkRO0q0EALdZN9Oyh4zpjvWrkPWnEAtVTxnc7qa+d9cWwZIFyAX8iL7Wq1lagIEIKJJC+CdNw/YAxrMPpZwLgKt9Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896749; c=relaxed/simple;
	bh=R+MfTv0tx2Lzk88XPMMihqfsE0CrH+U9/0L7ZShtH2k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jEr5CgOZOvCondYR8VnyaO53mdQkUGmSP/8uRdomZZj7rGvEojYgpklVPtzRaE+cQQHIUW+kQYU07KzNiAxpOI7Z2FyJJEv9jRLkLS+7PyXL0xRhBZf4XbvzUhLSspApB/ktNA7ZhVV9KvSeU0+1oTbmjQJz6tLQYZHzs15RZHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e23VPRCg; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5785d466c82so870759a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 04:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716896746; x=1717501546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDquBsdLvmzQxmvDh4J1njfPrwr/BCq5+dl34vP0JYE=;
        b=e23VPRCggOqmIu5Mtn1VvGWcNYjBAMx0wAEm6Vs/MLz1swyF2cp7gpCLxX1Q0G2LWg
         NPJNFZbnhNEUAavEf+WkYbp5BRRt4Zk1PWt+oAFW4kHKl1yNdE8GaYWNHcLtwHI1ZwBs
         9RLvHtsxMpyp6nZm1nF+QklFSy0i0lrRC1aUtv3F7gL27gyzDxtmdE9OYH5mXWaieA1S
         YAgAYRdbgBuo+uGh+XvBg3BdVofkqC4GFo9DrM15lUImu52+rDBnOtFW+uyF8C1VGNot
         +6CmEQEQISgAyYoPmGD9WlRbD7caGM3pxqxHO0DZYtdR2RRQ5WegGKCLFi5TQZMPjhTt
         EePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716896746; x=1717501546;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDquBsdLvmzQxmvDh4J1njfPrwr/BCq5+dl34vP0JYE=;
        b=sR7KmM6pLWMugBXH8aChvtSbKrSBmr828UdU07D928flzdN8GITo1UJV2IBThD7dEC
         oA4ni0SZHOwpNqoYv/5tNUo//zY0w0DE0/JUXvGQ1IRzLd5I2HGfLxlUHSWc08bq2bHR
         O2iACbD4XogqzQrRyNYZd2lctL9irXS8dbor9NUyI5OV+OCRudcgCcjspIA2nOLeRf7j
         wek+Ysp+ErM8ZQdXPoSlRUt/9wiy5g9Blqm+AsfXIYOh4ng6h3b2pHtI1mGb5hfdeTGd
         ptAfklpBJ7OLENxSYAvPZwqucVKJ77E3NldVxWlzq+Y8tEHmUrYY0QKBTixYDFHyC+Yj
         FTuw==
X-Forwarded-Encrypted: i=1; AJvYcCWvhrN+yCNsnEUOZRbnk8IPf0DMbYJunad269QFxpB0w7HdhoLl/2/5yzB5bmPuSZmhMtPPP4taeZ9p7dzcTYYjR3atScMWb1CdtVuP
X-Gm-Message-State: AOJu0Yzj3TnOhF+6S5oIBWwkYwxlJZlMb7dPP9uW8cBAa1yzG1/V1MA7
	8Q/z2vNgxddN9BQQkzr4pTmS8FtRdmzNIHsa+LSWApqkUU2nLItYmJTMhNrdL8Q=
X-Google-Smtp-Source: AGHT+IEQxDPgZFN7ZWwuI57tP0m82C0TYJ9eis/3zF5nq93vs+Y2XJ6pur8gwKCnx+Zw8XfhZ1lIcA==
X-Received: by 2002:a17:906:3b0e:b0:a59:b359:3e14 with SMTP id a640c23a62f3a-a6264179bf9mr780122066b.10.1716896746013;
        Tue, 28 May 2024 04:45:46 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c81773bsm605825066b.30.2024.05.28.04.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 04:45:44 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: amahesh@qti.qualcomm.com, arnd@arndb.de, gregkh@linuxfoundation.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240527084428.246396-3-thorsten.blum@toblux.com>
References: <20240507222226.288074-2-thorsten.blum@toblux.com>
 <20240527084428.246396-3-thorsten.blum@toblux.com>
Subject: Re: [RESEND PATCH v2] misc: fastrpc: Use memdup_user()
Message-Id: <171689674447.20426.17026638543644613384.b4-ty@linaro.org>
Date: Tue, 28 May 2024 12:45:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Mon, 27 May 2024 10:44:30 +0200, Thorsten Blum wrote:
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


