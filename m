Return-Path: <linux-kernel+bounces-401266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0E89C17F9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380891C22D0E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C0F1DC759;
	Fri,  8 Nov 2024 08:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="og3ea+eg"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E749F1F5FA
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731054697; cv=none; b=lETxQTL0379fdnpnhYqpl236nWHgm1WM17hICYdGsRR1PQjPDC+3to5AMBq6k4uWNCrOaZOf6vFSWjQGsPFFeOyuJu4AMo5vbxvdKdJVQBVSFyN3EVhj6UdOerBYjktFgxZKtUX9KVgOtBpe5MamcqeRpmVIfGJSA0NX5arz3sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731054697; c=relaxed/simple;
	bh=LfuXZV5ft4NyetZM+Ia2hzJO3hj04SYKybK95hZjwW4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PHu+o9MMOhi2wcPjYrQq0z4m8epjkZxHrFsTfOHKoghQ1+r0iSDet4Hh35EvAR8pXzD9wAyWzmfy2jzbhA8g7fTx+EDJ+a/xTWoUGfKgBDMFuxVGP824QduG1Gv+hrGlYHs1HGxUTFBf0Jw/S+lMAX/z0ZKsGkJLXlomO+YHmTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=og3ea+eg; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53c779ef19cso2103907e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 00:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731054694; x=1731659494; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eomDoovwmPoe3D4ex+kqfalwjw8M76GdHrO0gwpAifY=;
        b=og3ea+egciM/929Tnkvb6BwShNqjZc3tir6ciBCKdhNSJFnCiwzztDnNYPbeaDjguX
         Y7LEMs2IQnFTqp9C8YYkYan/fc+HVJMXM++jT/tjl72c7GiSbM+QHdK3x8kDm4qY66Y9
         bLgDAMh6jUHB9NWqmf7kkqJVKMt/rHb9uEyUJAMJAqCFmUkiPfSKXFjDyL4KvDHegtMB
         zoLgMqvTWtZsWFuAi/vLYrAtGHTPv2rj/QW0Yr9kKee9qGDOdN6AlJ4/xCsOuOXm2fwW
         4+HIJOM5b25pmiX8qZLdOuatp6QFStRFVa4IZKp4q55a1Mu0TXmAkT4S1KjQ98QBIHOF
         6DzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731054694; x=1731659494;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eomDoovwmPoe3D4ex+kqfalwjw8M76GdHrO0gwpAifY=;
        b=LNmA0GEvwwkg5CBuo5No1kE2bVKQNDf9n3fTFcIWE5t0LxRzHUlbgWNYqAgHOhJa2D
         gXh4m6LFYRZ7xqSp4ibhbwA2/DE945ifjHF+gecTGh9eX5Xd6wXufpPMNLzXpbZjyqfV
         GZ3QolAqBv7NM3Vw5h2RP42IqgnSw8kYHKxXwaERXGpWRMVhJomc8qi7pb51vJjIEWDI
         0NgIi94C1qBmsFvITzNHI7jGLWZWl69iugR3ZYLhATcSGz0Xax7P2/yn6tYK6QtEZhW+
         BvBmHaGJt9ZBx9cM7cfzmfL3IOuveGL9ISXxEBc73J1w6oUzyB35dg2oI9p4MsYs0+0P
         ktRA==
X-Forwarded-Encrypted: i=1; AJvYcCUVtM+W7VJLnJXrcQgJLNBVwg5xR3mJx1U5lv69GytYQ2whc2i5zV1VF7h8LjJooPETw9fIgYp80e4rImM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpfzL8TU/np6G2ZTpQnah4OByzvvQF7+IxfPy2ouaqcMEtUbBh
	ycsXQNOgQAxSldYhX80s0pNiDAlnu2ihJwJNv9+lTiymyfe7s7hwxCCNv7zKlWE=
X-Google-Smtp-Source: AGHT+IHHJY+9cAH5llReO38ypapsMnCYY1F1ljLHtnGaUqjvCgc24E6ZfcX/bL0Vg9ze7adUU8pTuw==
X-Received: by 2002:ac2:4c41:0:b0:539:8e77:9129 with SMTP id 2adb3069b0e04-53d862be3b0mr1011744e87.44.1731054693893;
        Fri, 08 Nov 2024 00:31:33 -0800 (PST)
Received: from aspen.lan ([154.14.63.34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda04ad0sm3876370f8f.100.2024.11.08.00.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 00:31:33 -0800 (PST)
From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH 0/2] MAINTAINERS: Update with Daniel Thompson's korg
 address
Date: Fri, 08 Nov 2024 08:30:43 +0000
Message-Id: <20241108-new-maintainer-address-2-v1-0-47c9d71aac11@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADTMLWcC/x2MwQoCMQwFf6XkvIGmiBR/ZdlD2bzVHKySiArL/
 rvFwxzmMLNTwA1Bl7ST421hjz5EpkTrrfUr2HQ4lVxOIrlyx4fvzfprAOem6ojgwgqVlnEW3Sq
 N/OnY7Ptfz8tx/ADHucxGagAAAA==
X-Change-ID: 20241108-new-maintainer-address-2-ded1a0e61df8
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, 
 kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 Daniel Thompson <daniel.thompson@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=566;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=LfuXZV5ft4NyetZM+Ia2hzJO3hj04SYKybK95hZjwW4=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBnLcw8ZO3DFRnzO3TsLta1DOEJHXYLUWPOhwwrV
 flZaWazj9mJAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZy3MPAAKCRB84yVdOfeI
 oeSUD/0RmeeQTzyONBemD5YD0uKvILwDE5tqA+PYWK3h1rz5yk6n9CK8e48AN03FCicxVDRkWcp
 nriAW3c62Pe8h5Maz7TDnMqIofcYtwuYyNUCFGFUCGzb8bo4MiRISe+OicZTA0W5acjPj+BTt4c
 pK4Yr0sfavL8rHovt4r8aSA9bggxB6LmhUo0Slu3V57FCRdDqSGg56YF/nUfdD1+0NpqMiJl0Jk
 KhfYzQJGKFDWtBQnt4zrdLZ5I/+rw7JomJeUx+MVLd++SMau/Rts0Ap7S7W9G4OHaPAQqJsXe2D
 DqEwKLN+rbq8A220mxxQEKBaeWSOJbFkg3GejuIdAIPD5K+TqRNLksCYJ6Ojmez2mieFUhwNZff
 h7EBE7aOlGsRAlPL3z92LmGoqDg1hyZlIBvLf1b4WGGvM15vIQbENsSy8BupQer87LyaC+5OV2b
 Mve795O6wEIyJsk/u4tjh/E4XxxUgZYjwpitfmuZvu3mf5AvEVSaUtdyM7NqQCqvjjTLQAvvsEi
 XbgIehLK9JREU8EcX4ztuQWe7f6tGMJrK1zAMjPnnWq/Yv5EJb4n/kfwFkgW49aSJeMtCfTKxyx
 qRHrtWxji/qLVZ7t8zoXSHluJOTXF53wxNxam0xLAxBBo5Q/xliOYF4ivSSjDI1g46l5zdiEc8W
 DGMFARpJGLMd7Dw==
X-Developer-Key: i=daniel.thompson@linaro.org; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

Going forward, I'll be using my kernel.org address for upstream work.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
Daniel Thompson (2):
      MAINTAINERS: Use Daniel Thompson's korg address for backlight work
      MAINTAINERS: Use Daniel Thompson's korg address for kgdb work

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
change-id: 20241108-new-maintainer-address-2-ded1a0e61df8

Best regards,
-- 
Daniel Thompson <daniel.thompson@linaro.org>


