Return-Path: <linux-kernel+bounces-311482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2D49689B7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2CBE283301
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DB419E977;
	Mon,  2 Sep 2024 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LWgAEOko"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D75B19F13C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286714; cv=none; b=Pwh57ibx3v8s+qVBSxVDuwY+gGXaKjrj3zMLmiNlV4LeTvtqP9omaDkI2m5LAco8QRtoxEFR27Qq3sTgrPmkEr1T7PVAN4dFGG1YltyJLpAJcRAiiNO9BkWCYZGy3gSGvTcGyW/2fcie+ssYHFk0Ab9XA9qYEGggIw1r6LmVXBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286714; c=relaxed/simple;
	bh=RJf66FZieBdEBRXddOhm//gZP8RPSjXtWI9uP192WqE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mi/sG5FARVePb5BEJnOHJW7lbJfuHBJCEUEyJ9TMWgTDJTkIjq3/dnc5R4Ec7QpWive8t9e0wBQq/GyrEeYK3uZsIiXFTkEAtZLuWVkxMR0PMwRHNoyV+iaK89LDYO8cS6ePSRGSjH0ia/VsndR7QCkAMKpc2bZyM1qP4c4kw5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LWgAEOko; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c241feb80dso4024953a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725286710; x=1725891510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cmCplvNv/o0XBKdQpaaHdksNPJ+iFNTEfsZ73Y6mNsE=;
        b=LWgAEOkowpOP8vDyc0dQsFSwXblrMA2Cb8tqPAHeWi5Cnx+GsWJOOl9TzrPpKrrpL9
         tU0yjdbx2xnBKikGwzauovgAg1LLHkTCXv2UVbzqHS/Ao+XffymfRDNEE59nTwit7mD6
         PblL/JsrkjusrOh6pdlEf6oqs5ZENnJEQbD9/dhu/usN9ccIhnZ2h4X+xkN62ohVYFzP
         +btlSK0RQbZ0CSp56mBCee3WG+N4ZM+0nfwoacE57rY1orul3VsfexoBBSxPRm3bF2G0
         oR5KZ9cJ4J/oOhMPb6TXT1uFEsQfSxFcSZEZkQyG70HDA5iMUox0c1EEDBCupI2/9xhX
         5IIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725286710; x=1725891510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cmCplvNv/o0XBKdQpaaHdksNPJ+iFNTEfsZ73Y6mNsE=;
        b=lVzTuFN4RBHdG3HkreLxWH1hf3EpyU9isCdRF/aFaxAWmFkUhYTNoNh3brsPSthYb3
         Kv+I/6tu+1vyi/iL9uXNzi8++VldoF1JeHi5Xq+fCMf17taKt//1eh4qPDfJ7lSb9M/C
         s54xbFNCweTt8iYPdHLXd0a56zewZazNaIet60pLgsicTl9GV0c+be2S1xHzMuzWBr/s
         21RrsS1RycYeqCnYD1cidnIojDDG8IBvae6w0WD+aaNDry+pguL4hbbJsD7pvhjFVMQY
         DWhBEXAGXf6N21yhgXZIU+Q0OIRVhhWpMQln9L6bm4hUkBsYPBZvOs0oqj9l6Z6PRwHS
         f8bg==
X-Gm-Message-State: AOJu0YzQnaAaJKB7yTRDCkijHGCA0pSo4k5nbfBPA8lxZ15EKVwxYA24
	wbi/zfr7pTpmU3DEbQX29T30HM0otPX5m0KaSDJcqM0gFEiYcC5lfAuT/HkHLWA=
X-Google-Smtp-Source: AGHT+IFKDyELtK0thTSo2ST8R6mm0dLzPHd2+GF2QHZoDnMM9jYmVPfJF4mEJggOa9E/SKkHSY5P9g==
X-Received: by 2002:a17:907:9726:b0:a7a:ac5f:bbef with SMTP id a640c23a62f3a-a8982833612mr1358627466b.31.1725286709504;
        Mon, 02 Sep 2024 07:18:29 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891966f2sm566000666b.101.2024.09.02.07.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 07:18:29 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/3]  misc: fastrpc: patches for v6.12
Date: Mon,  2 Sep 2024 15:18:18 +0100
Message-Id: <20240902141821.70656-1-srinivas.kandagatla@linaro.org>
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

Here are few changes in fastrpc driver for 6.12 that includes
 - support two Compute DSP instances
 - update dt-bindings to allow multiple iommus and new domain ids

Can you please queue them up for 6.12.

Thanks,
Srini

Bartosz Golaszewski (2):
  dt-bindings: misc: qcom,fastrpc: increase the max number of iommus
  dt-bindings: misc: qcom,fastrpc: document new domain ID

Ling Xu (1):
  misc: fastrpc: Add support for cdsp1 remoteproc

 .../devicetree/bindings/misc/qcom,fastrpc.yaml         |  3 ++-
 drivers/misc/fastrpc.c                                 | 10 ++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.25.1


