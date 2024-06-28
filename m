Return-Path: <linux-kernel+bounces-233800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8EB91BD91
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 13:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70481F23155
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A13157483;
	Fri, 28 Jun 2024 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jLeYAclk"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A25155A23
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719574633; cv=none; b=nNYXRzbOQNXItizrY2HvTKZFngG7jTKdF45BmU5OAHTOfv69RN5xZHXedWg73EEyUmzhoN5RLL8O0hPOb5sVY8EmU0hyvNz0I5h/mogf5SPebHVyIF9jQkZNggsBUydPDuCu6k79iqwKlMjCbEWEisTE/3pnspmVK8UTpCTM8UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719574633; c=relaxed/simple;
	bh=r7AuDPkfpPz/ykAlbBqYQVp17Yf2fls+uTTscd0C+UE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NdYK6L+DTBkixz4tcUIpPNHnUv75KV9XguU+ayDuZQizfrJ3K3Y61aDQYQu2wdnRaFTf3uFB90CgURxZR98gzpGN+1T5yagt8pXNQX0+eLuHQ1NQi0OJMVJzVa4Nc2X0a0jD6l+teCfk0SX88nYLfim1LzPb2ukkPSIb7PEPv84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jLeYAclk; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-36279cf6414so307039f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 04:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719574628; x=1720179428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tJHN/NIGjNEEEhv0nTeDzxDpCr1KQFL+TM38f+gHFhg=;
        b=jLeYAclkt1zg+Yo9DB6IXU+gvffUVS5xlXL0UE96boG0vedZ2TAVJUw7o4lNf+BKOY
         TXZEwvxFnVB+F8Habun1GWg4iaKwUsbiL91mxYBRMWNzMJj7WU4YgxIvRZ+UPwLP1Teq
         biT7wLCEyovgIGG2bM3m6iIOi60N97KTAP/L+QuNrpknrIHhun/IN89Vsq2lMLOiECo1
         ExyFTJFWaEOGI/E4wa1YTR7NmR2ERVwNULsjin2SxlxKuis9ck4gzNc2UPI9ybsRJuXF
         Tfq55Gf+f+VzEKeGPyGJvHxbppx/fEVkiGCMfMLDtct6V77k4suh8/K1q30uaGbkD8q4
         M3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719574628; x=1720179428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJHN/NIGjNEEEhv0nTeDzxDpCr1KQFL+TM38f+gHFhg=;
        b=LVk66wQgFlPgwwojXXdd7pzl8YPvbM8IYFvqRKyHGlYGijwZ+Brqi85lBdQ2fcwTnH
         +CODxrsFeOJzaWN/OaBw1eeg2IXPTe+91ROKC52rUjyrEt0KrGqyMmsdcSwJvBJyqDbA
         KM7lMGwG3sGPCO5tVfGgGhaSVFgl8PA+1OnrPODaMKKMY5ABvPhRaFxBuLr6INxp7kLz
         GbfnxDPe0zADNy0K8ykDDFnHJrTMNlWx5RbG4c93pVGKak3oFGsWCJD1cbusoUdTzUNy
         PsUfBGhs3ErM53jyrEyTOjJ2OvPbT/ZgUTsxenBvQ47K/KiypSSLjsCIkj5sUk+Y9xL6
         oLfA==
X-Gm-Message-State: AOJu0YxGPO4hJ0iB2nKzJS8QcNxW1F5C6I0WLSyU9zqcruuGcEmaAuiy
	A3kSnUNO0lx43nN1J+vGx8Rk1OZobXjADXRLDaFbFYVS5w/7gvfJMgXkrY/yww8=
X-Google-Smtp-Source: AGHT+IHXlRlq4iREHB8mwjhk6FWQnvBuRIYUww+Ri7ojoDig3Uh7jdk+PxtgOn4gH/ZVUG19r64URA==
X-Received: by 2002:adf:9799:0:b0:367:40cc:ac2 with SMTP id ffacd0b85a97d-36740cc0c8fmr2985936f8f.48.1719574628511;
        Fri, 28 Jun 2024 04:37:08 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fba5asm2048937f8f.71.2024.06.28.04.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 04:37:08 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/4] nvmem: fixes for 6.10
Date: Fri, 28 Jun 2024 12:37:00 +0100
Message-Id: <20240628113704.13742-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=809; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=hdIxxhSBzwn9BTxEVbYr79ZxcEBv6QqVRMDL+0ClEGI=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmfqBPFJu3AVCuiGiY1Od4vmKtnw6RMNc3Qtn4/ H8om2Qxy5iJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZn6gTwAKCRB6of1ZxzRV N/R0CACIJRnuMabqp9lzaFozeH6qWaXqJQV2yKWq5IEiBANMszpr/+NjH6LHVuv9GtvpWNEDFUF 1McErvi20MY3iDLddLFi2p+XvUypOyr1SvKiV9NOGAA0YOz/fOhAAGP2E7h2TRlNQfexGIAXBkf gDFmWIDXUPGBGKamRXcS/orIdZLYUgbSaPsooofpbZzXU5ZhD7K0HK14O+D9ECfSwRCkFVhNndS YJJnLxcfG0sNw7wXfnDWcs2tPK2bE8X5NqfJsvWfDMLWdHJHKmvf1HvQ7QaMlrZXguvWyMQ/570 5aNrem4waWa0VjOhUjhUlWe9eYgU3svLTdupqD4cE6xmfheS
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Hi Greg,

Here are few fixes in nvmem for 6.10, Could you queue
these for next possible rc.

fixes include
	- fixing return values for read;
	- fix incorrectly set permissions on cell sysfs entires.
Thanks,
Srini

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Joy Chakraborty (2):
  nvmem: rmem: Fix return value of rmem_read()
  nvmem: meson-efuse: Fix return value of nvmem callbacks

Thomas Weißschuh (2):
  nvmem: core: only change name to fram for current attribute
  nvmem: core: limit cell sysfs permissions to main attribute ones

 drivers/nvmem/core.c        |  7 +++----
 drivers/nvmem/meson-efuse.c | 14 ++++++++++----
 drivers/nvmem/rmem.c        |  5 ++++-
 3 files changed, 17 insertions(+), 9 deletions(-)

-- 
2.25.1


