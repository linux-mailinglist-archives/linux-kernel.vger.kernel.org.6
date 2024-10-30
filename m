Return-Path: <linux-kernel+bounces-388839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B23A9B651D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905171F214FB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071381EBFFD;
	Wed, 30 Oct 2024 14:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FAkTq0oa"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493B23D551
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730296988; cv=none; b=tWiw8sgaRkXVT6+4eottEiXb9AmYNYHHeKCOVDNzCrPmeTGcs5GnWONTXup8S5MuMTk6/ySoVDmOW5bmLf+Q65aTAEFd/COl3Y/lNQS138kVH9VbJYvO85hu9FlhKA6Uod5k+sDdpymN74cUGoX0VZxlH/oKhxltlqcCH2GXXEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730296988; c=relaxed/simple;
	bh=CikZL7+VJHJ2NMJ0lkb2V1oVcQwFRqrWFUDrGEUN8Z0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZcnO1UVn8O7WZLwPyT0BSNYHO7IlanzjIzC8II/eLIDfWWfpH4Jn3vyBg3ofwgIIBu61YqVpA9mzOaL3pE6Unbw9lNiuAh9X14qmT3aAmxSSBQ5W5CBEO4IzFBAvsZEEv1EsnK7yqSX1WFL4ABBH+vJgxPHcKK6sE/Kdmswlca4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FAkTq0oa; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-431695fa98bso62135875e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 07:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730296984; x=1730901784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CPMzcHtmzvW9kfj5S4miVCTesK0tTrVqiF4YdM0sb3A=;
        b=FAkTq0oasPCMuaIuJotPtQ0toLMYs4SvXU5sdlY6LLwBsxW872kKXXQ4q0qeQgIcXY
         FzOxySPKDh9UVwQ07orjcOhqPQzkLlRcGvkNaUskcRhUxXw3YwNk3rLfEOba3IQqCacy
         BBq2amefoOJET8LjisUTrfzFlHtCGnkwzcHeVTCYZdp9gyyLosTGqArzD547EBT9XZDm
         yBbRKmFeVU87muJln/xp7Mqct4fYQezDg6swFruW0kJGAe0vfawTJ3m5icxOMkl5OdWD
         9Qi5DSKzjcGHFUf8LJnu6UI0gUdY07i7gb6vaMtATYGcF2Fm5q4PjtGl6DKnSH2Kql9B
         +Wtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730296984; x=1730901784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPMzcHtmzvW9kfj5S4miVCTesK0tTrVqiF4YdM0sb3A=;
        b=NJGu8HAmFyR/TICKxP/+I8rfkHT6WLhP8pTLrHpZXji7SXK3+GYEDXtcPM+e2RWnwE
         LtU2uqiyZnQPCsLdE9nOjRnPbrUWYrXEwhW8xVeZ7AIT5aexlk9WNJ+6PD5X/v8ebqFr
         zZThqCWnozOwMaBwVzWOcOOtzY10Bs2AVeBiEUZn5HErZT5DGH+q+rDHMOYEdU5mrddj
         VIggE3Vfwt5opDjWwh7slpga+ec7hPQ/oE5tR0OXGEcSR7vsOfDc5Ju2xGWn71EkqIDt
         1rZDbH0DKpc7oESVLCpoN3IKO5B/bJ37eQWSHwa9pcV/I8D5JUxrmEMmdrQ+vWjjMXuq
         uRaQ==
X-Gm-Message-State: AOJu0YyDVey7zWCM/OvrrOJrYkbHQKVafIAye1RvYYozRWpt/oSsHYL6
	VKiELh1uxoE9RmZMFe3wt8fd0NPFSdBAZ9RWJjuUA1Q6Ss7/ZbwHcGhdggm6tTV2yDtxv0mz47C
	KV44=
X-Google-Smtp-Source: AGHT+IELy7AYZDfZbLyK0uWzYRFQxXzcKdOFnptyThtHAvzukvGaFkUy/b1uc/w+tSHXSGcKKdhrPw==
X-Received: by 2002:a05:600c:3b14:b0:426:8884:2c58 with SMTP id 5b1f17b1804b1-4319ac6fb0amr127917715e9.4.1730296984470;
        Wed, 30 Oct 2024 07:03:04 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd918220sm22707505e9.2.2024.10.30.07.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:03:04 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/1] nvmem: fixes for 6.12
Date: Wed, 30 Oct 2024 14:02:52 +0000
Message-Id: <20241030140253.40445-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=377; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=nauREPHcEuYE0QkpT3411OWUFGxZugFpPYIJ52isw5w=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnIjyHSROFMVWOyEGH0s1juS+wJhjClzOtMuXVd 7gxDNNJIW2JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZyI8hwAKCRB6of1ZxzRV N+NAB/9VvdoM6H/WuxuXNlLHdl4+S+t13VYIiHkUCo0cXEONrZBv8hE0r2FAXjF6oEGYYqjJ8e6 WiVvrIGgFx7h1sC4uxf0pBuZOH49Ktgd4TIrBuAlZZT9G4WMDjxtCUj6DI7WRpNFCwb6Yo3A6FF fSESRWU6QqoJtln5HxA8myin/ey+nyhkEc08AH8z2u/qi2LupuOS7juYrK7SIKSmIpKAB1KmcQL rx5HEqeexR+/qi+tuimDcb2ImsRkOTHnSFU5mHSJR0Jm7JyClr7DC7lRtarhGSP9X5i+oUC4bmv 6M5/mehvQSGxW1eXYHHfABwQLcNCN0ecq+OU1hWUxCNwF2b5
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Hi Greg,

Here is one fix in nvmem for 6.12, Could you queue
these for next possible rc.

fixes include
	- add missing readonly check in bin_attr_nvmem_write
Thanks,
Srini

Marek Vasut (1):
  nvmem: core: Check read_only flag for force_ro in
    bin_attr_nvmem_write()

 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.25.1


