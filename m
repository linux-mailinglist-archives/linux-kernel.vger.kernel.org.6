Return-Path: <linux-kernel+bounces-401268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34989C17FC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08B231C22DAB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B015A1DFE0C;
	Fri,  8 Nov 2024 08:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sz6QCqO2"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F19F1DE4EE
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 08:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731054700; cv=none; b=vDfjdl3q14oARm6enrzj68KsxD3JPFPCu2O+hj/vpFaIiyE0phoWTBnQDBFTG6lPn+9gle656pplATeP2ce0Bkm+dybtLULE10CHhHOZwTpMg8r4ewiF1ovV/JPmRV3PE2k+aEN2jUbO6h8mBeTejozU8N3ula1EBprMp6z2n64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731054700; c=relaxed/simple;
	bh=QJ1shEfgNhMbzUoWs/iI/qCnvnU4Abj00tvjzrGfSIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rgpYkMw7LH5WmL0TM5nvAnxhmVPi8PhCEo2w/ksgR1wQyWXiYGC2JCsCgwq6hxigVrcFtFb/Iy5vIveyH3oZXm3e5sRW0TJuiQJoXOHaU5bRKRqtsYH0/2GceX9/Y8yls9i9v+n6MFQmF2+MYkPvjISnfxqdHEM7JHAHPgwj/zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sz6QCqO2; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d43a9bc03so1297379f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 00:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731054697; x=1731659497; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kuMMItLYzFCoobqi01tA+K1arxATzzRbaTv/6NYr6os=;
        b=sz6QCqO2RCZ4FF6iuKjtlWGhFqvd5BcCvlP1tx+Txam6h3zcVWRVoTsyp9X0ODCWib
         P8OViASMzWfiQYm/o1JBNLCL9OTr+EAUPMyb9iPa8vNBaB59uIZifNfklZ34co6SCJUR
         3QPWsCrT394EluSN3FM390UOvnHhZP49C5cJiT5fUh4SGf/QeyZr+ZqZVthhGWLUPV4U
         91UFEEhXPNYMCIGbnw9curTRXzFTcWhNg9knIT+XH/iTJkvoAmX5kdfLm6bR2wSJQ7fC
         938PWLF0MWt1dGEbmThkLoJzZ9YfUSk0cQ8xXtuA2qzNglhK55+IL06CiL6Fq8djDO0O
         MBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731054697; x=1731659497;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kuMMItLYzFCoobqi01tA+K1arxATzzRbaTv/6NYr6os=;
        b=OLSzxksBTpK3r5pJfH3hEqflzBY8xj5Azuxq42q0kcT7UGFerkYRHbn4pamKZnXv15
         ZFz0/Afy4gBzv1zz3xzYMz5wWAG6HWMjlmtkz031nUw89iVsKw1qtR4MW1DcDuL3FBDy
         iuAXcpLEVUEAPPheW198fTvXM0h3kEUFhghWXMZDZHtgCjNS+B6FCobA8g70ePMYpvkM
         EK7h1XpsvPV+3KlBJJX1DS+K7eq6Y3U1H84UnSN1MYcCW4N+BapPGKU/ESwkj+tnIldy
         VKK6tMEehfO+ylXKNmLZX1dXocLsr2mQ9FTqhfAOs+2VNzq3HAmH1KCY8ZbZ8zLZBq/0
         QiQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUheCfGLdX3Kuv5rqFs7gS7Mnt/D8f7J3e3CWGAWylibm4XEdJMqXNzpgWSqmFj7tPnR+3Ws+0NrU9IqA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHze2qKM8HMt2J98s/rKizGVWGqp4clfDQsvsO2XxZOgO22ZNT
	q6J1l+cApJI9U5dn3Wuzi8vP1uh3G7mT05SC+Do7HEMvLAGfevlyA2MdSI+v7oI=
X-Google-Smtp-Source: AGHT+IEbn82YtanjJwsBTFkxT0F7uSzZx2KIbtNokrqQeZSRioBBYxItPzf3xppwRdTzkRVo7qD0tQ==
X-Received: by 2002:a05:6000:480d:b0:37d:4894:6878 with SMTP id ffacd0b85a97d-381f1862d7dmr1755298f8f.10.1731054696912;
        Fri, 08 Nov 2024 00:31:36 -0800 (PST)
Received: from aspen.lan ([154.14.63.34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda04ad0sm3876370f8f.100.2024.11.08.00.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 00:31:36 -0800 (PST)
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Fri, 08 Nov 2024 08:30:45 +0000
Subject: [PATCH 2/2] MAINTAINERS: Use Daniel Thompson's korg address for
 kgdb work
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-new-maintainer-address-2-v1-2-47c9d71aac11@linaro.org>
References: <20241108-new-maintainer-address-2-v1-0-47c9d71aac11@linaro.org>
In-Reply-To: <20241108-new-maintainer-address-2-v1-0-47c9d71aac11@linaro.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, 
 kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 Daniel Thompson <daniel.thompson@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=714;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=QJ1shEfgNhMbzUoWs/iI/qCnvnU4Abj00tvjzrGfSIw=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBnLcxWQsD/YJwtzmPwpQMVWHqtNS07maf3x0/vh
 5r9h43cLqqJAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZy3MVgAKCRB84yVdOfeI
 oVW4D/9FVXqDJq4DHUBD4lKDdXOmtcMWGMXhsMBQCl0mRzsT9PVQeWXyNsDOqkgfzXckkgdh6vy
 zFM5AlBzmJsuh5bffLhMQyxUjvTXUD5yTpIOtF4WrLiEO5CQs1uuSD9JKZxFd7MZbBkheZCmiJZ
 6MEqwdsqyKG6ASwhaPh6H6NT5DuWmstx7INWkXJyHfDtLtOh59XjCoUtvZhvPix9z1XoWhh/M0G
 XF3/i2sWRmXwCyx5DkA+7TPnCWF3COzCXqSV0I4blHDIAptgCYnxF1Jk2Is33yaW9K75kiPez0u
 FvtuYFgm5u7YgI+l2ir1rZXnE7QD8UJ/1jGJb/20Cx/9VsEEuKFeRooaXqCq57bd1BpMfU7KcJl
 oAAtiRkrF6RvAaB4xuGwLnPAAsrQRjk1CJG/9Fj2z7wwX9VYqqd9CSzsHGlbdgRkzFRItynjUWe
 gmzmPJL/U1E6YvHm1/LKcWHGbtnPcOeXUXgb5HCzAzw7LlAE8iQudzBMQu0Jn9W8LeGQtXlAVgI
 uN9eToS/EJuooHnnFESqCVLs3kvyJB8V1UHdWzaUdH6iHzuiCWu1kdFZMGztArU5zV7oU03DIle
 nOYocmse3gLulu+QbxvediGRjUfvb02G5AK72LafTVRS4SOdslvAMwFCECE6tUjXC+VwDIwoaMe
 KXmonldOnXGkAjw==
X-Developer-Key: i=daniel.thompson@linaro.org; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

Going forward, I'll be using my kernel.org address for upstream work.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5396fd1b15aee1eb2a234ba8963c57571d532a91..a88528c14e372856f83c60392240a3f1a41f6032 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12659,7 +12659,7 @@ F:	samples/kfifo/
 
 KGDB / KDB /debug_core
 M:	Jason Wessel <jason.wessel@windriver.com>
-M:	Daniel Thompson <daniel.thompson@linaro.org>
+M:	Daniel Thompson <danielt@kernel.org>
 R:	Douglas Anderson <dianders@chromium.org>
 L:	kgdb-bugreport@lists.sourceforge.net
 S:	Maintained

-- 
2.45.2


