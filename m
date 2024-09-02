Return-Path: <linux-kernel+bounces-311469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1E7968994
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406BC1F23491
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFB319F113;
	Mon,  2 Sep 2024 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OKRCy/1g"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F4019F104
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286457; cv=none; b=bNUODp/k36GWsXiBvdQWN3KAVwO5H6qVLexDJY4R6A0jqA0Gs8O70G7RnZnT5NB6KPk3mhRsKPRf8zfzPSs1H1/J2mkN5xJaY6KWB0VWjSA0pikwpx/bIDllxzFPrZyEsz7tjpmkFcgzolwTxKyW2xkbgOt/zBylYGtdl1ZSXs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286457; c=relaxed/simple;
	bh=v2lefujDoVpBIuJLBEvZNiw3JPuM+sFNygRhBi5Us2c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HsChWaWAW5TvhpSRYzDtsB+wLscvvKIudKrzMINz5Ta1xFfFUt5z4KjSFa23iVOtyWooBUT2K0sWlxAFFVaf3fKDjKrlVK2of5snZ9pimNjY6/bfGYbpZKaEUu8ASuh6/EUsoBfYOwCkrwqH/6V+5eLYTfZzN5lq2FFzqWzbM+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OKRCy/1g; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c210e23651so4466113a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725286454; x=1725891254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nmJcmvOj43+5+SnbSrOwyIS0n6r8YRRr9ji9wwxHcZA=;
        b=OKRCy/1gD3+D6u9sit2+dgX3qMbQiLtGeaP55MzrDjK9etEBaDW0pAxfvPqrTx/XoO
         TYB8GjZBchbXZu+wouhG3a9mlOFFW/EL5euzP1iXwcekPvnP7fySlTnEHkVrfwcjHk2x
         912oG9HKaqJqDXn3MHr4nkBuBbJiOdFiAAhGIbTIuamWCwnycKNCaJ1R/bvxSWLPTBlP
         g4Ewn5xnFicNi9zQDTX8PWrNVGaPsS0pC3FhxECYLDMSnl5O4FmojRKIO73mHt1qGR1U
         00LGR6C/Bplan0LOmHuegBTPUcnsyLXCjZgTjPwJ4k3gTxa61xa/G3KlDHVpZYZqnfER
         Z28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725286454; x=1725891254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nmJcmvOj43+5+SnbSrOwyIS0n6r8YRRr9ji9wwxHcZA=;
        b=VA7Zp2PDG1NGbDV2mARYH/6n8wf3ZdTnJcMmlPYHUDucfGVWKZcYCw89czRKrPzh6t
         L89tB/dXpucJW3/OA2L8EHnw6vLrKvGgK8vq7+hPDROZsCsBqzaLxtXWsHGHrlrcMmV+
         31pQPGIl0zJ91n3L2WCA+Nh2KOPZRplcAciMup3+Dblz+cplyOKhobbm5iAWsnW+1mEh
         NlANNYJVOdns0PKNKNOQ7QWue6uXSb3HtqEs16U32iZuCQslDkhySv3LJRVF/pVIeEZc
         7mRjQp6mVUhjLI0iLYGQ6KYOqXdNexSfW0PoJV1N1vpUa9kI1RA/WBw6El3I2zINP1SO
         xdoA==
X-Gm-Message-State: AOJu0YyVXdfdCaDMk7ipxq/cPz0TFMKKAV3yXFIr8AEbNgJp0Cf3qE9H
	hDsrQVQfWMjSWsIlXqRH56NXtqMdUAp99V5sv/Fm+OeHlRojqpgOPgu8VAzXShI=
X-Google-Smtp-Source: AGHT+IExT3kmeUDqu8ma8c+Y54fUSBUInItgpjo3YCn5ueT4Fd35Mu6gFlRGJkWznZ1M8eAuEWFKSQ==
X-Received: by 2002:a05:6402:3483:b0:5c2:4404:a193 with SMTP id 4fb4d7f45d1cf-5c24404a2b2mr4676035a12.34.1725286454112;
        Mon, 02 Sep 2024 07:14:14 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c24ff04551sm2370824a12.35.2024.09.02.07.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 07:14:13 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/1] misc: fastrpc: fixes for 6.11
Date: Mon,  2 Sep 2024 15:14:08 +0100
Message-Id: <20240902141409.70371-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Hi Greg,

Here are one fix in fastrpc for 6.11, Could you queue
this for 6.11 if its not too late.


Thanks,
Srini

Sukrut Bellary (1):
  misc: fastrpc: Fix double free of 'buf' in error path

 drivers/misc/fastrpc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
2.25.1


