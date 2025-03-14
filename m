Return-Path: <linux-kernel+bounces-561173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD7AA60E4A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3430189FD5B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E650A1F3BBB;
	Fri, 14 Mar 2025 10:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lFJTDqmC"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8935D1F3BBC
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947011; cv=none; b=CpcHjJpfGX1aCnDzaGj0RnPNf+JKrIxfo9YssSmh7Y/Iu3KEpD2/fZCvpTWy6Co4L5DuC7MrwKsCaSboJOWwnLJ2F+dppiCxNJOtv/BQBMgFnREkI3G7eXR7wFqXSgmiM2kLnPa8bVPR5TY9xiEIc7xGss98TUXRgtgbrlGLQB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947011; c=relaxed/simple;
	bh=wgSkUJ1HIbbvgEalgmD7njvprBMNHLFJxss43b8eAV4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JIdTsm4YhpoibiFdvA5U+Z7AN9lH+uLCqu3/QLn4IEQYsJ6+AMAZKXnL6eVrffhjZRusvAXX1TAdH9ednw2/K5k1Td/aYPJHCPaUHxfKdvhtFVV47rTmtMAbPEWLYk1FjneYyuI/4RZn9w7evEgHBWA7pXiAgjULIIE3q6XLQ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lFJTDqmC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf848528aso18064555e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741947008; x=1742551808; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ajo3lszNKhNp84zfU1OoU5TqXF6za+pgykwrTQT7DR4=;
        b=lFJTDqmCfqvLlb4nRVhU+x1GzwDLofMklUuVRInzVm+QQkIm2WgvLyEJxAgNk8dItF
         w/33Z8gF/SBufSuf3bU1gsxmQTKad9TQj+EdJ7dnAlbzf/bSV1RM4wsD1f5KVU28yJsU
         I4OprPIav6LiiVozH+E9LrM7cT0ArgUAYWBotP+j/78TahKeta628GG9VMk78g2g3tpq
         QSJExr1y6jZgRfWTQPocPsg+Pjx3AV8v8t7iWtbbwC254iXhbx3U+p3dotrdy1TpVxgB
         jtUv/5mFOIXJx2ikSDwZ2fIGGCKgzIXuT/f0lqRPEdDsWbhOvCplnKOXu+OnK2Z6U8GC
         gOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741947008; x=1742551808;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ajo3lszNKhNp84zfU1OoU5TqXF6za+pgykwrTQT7DR4=;
        b=iCc+k007/spgaYbM6J5Bgb9A69GNpIvdG+iWJcigXeG0nvmwqVl25r7OviWqcInbt1
         QISsUy0uWnZxtPG24mh4x9E54RDvUCCOjsQIlmxWh5GvO7NskMnT/BqsenBSLLdbBniP
         HRYVz89bhbrGzcEpgibivewjHTAfSazu4WfCKFu2QDqgsWfqNeUbvl+VhfFdeROCYQoJ
         aCSzj7CM3x9gURq5/1Xv6dHhIfdN93OBiCyOrmEc/RsePLK1/BSnyqVF98z22V8lJMGI
         ZaEo5j4pIEL+1HSLXnG6DhX9V5NY3DG6GRKZslQuvyNsZJ1I03+KOePZkzILbsa6eyyF
         /HiA==
X-Gm-Message-State: AOJu0YxqTqg1eUimLd+YQLza00EaCtg1BnthURZA4ZZ+VGuGA/oq0YvR
	w+5dSFHj3+aluEVKfkU38TMOG6UIlikA+icxZTUQWlzGgUk5Wb0ud0/MOAXQZ9B222RKTL+i4K+
	A
X-Gm-Gg: ASbGncsE7FWOBvyUcMZdmPd1ZOwMxF4+AuV+E8bHrT6XlfKfRVeC/XNvGDmrzuJyHuQ
	dj0CfrRHTWjW9BYctwCPgvLAnRdiw+4/SjE/3BnFy4W+BF/+ozIweDfOdxRn9RanCEtnHeCa+RH
	XzVvRNkanvqjFZGGYWQNZLE2AdcX3Q0UZIewAVyCbym6Fs7b2RaExT7P9ezz0kYG9jMFQF0IcOV
	40Gy3PeGcSrpfP5ZliQqaM51L5VRHM3Ga+uIHlUmGovw5YqBNJ2sEj+vLy4g4fG/UK8ksIsHWIh
	29wRt1g/uaz4dTeWblY+VZvHcPv7Z9DqcIXvi/VLhQ/obrWSLQ==
X-Google-Smtp-Source: AGHT+IHbOkr5XakbV0xgM2f5fP4p0hwGNF7uGzjMIrr+H0pRM0Yj5sQU8IrthP6K42vBJedD8UbWtg==
X-Received: by 2002:a05:600c:4583:b0:439:86fb:7326 with SMTP id 5b1f17b1804b1-43d1ecd0ff4mr20249955e9.22.1741947007770;
        Fri, 14 Mar 2025 03:10:07 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d1fe05ff4sm12439265e9.10.2025.03.14.03.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:10:07 -0700 (PDT)
Date: Fri, 14 Mar 2025 13:10:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Longbin Li <looong.bin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] spi: sg2044-nor: fix a couple static checker bugs
Message-ID: <79c71b81-73a9-407d-be6f-481da27180bc@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here are two fixes for Smatch warnings.

Dan Carpenter (2):
  spi: sg2044-nor: fix signedness bug in sg2044_spifmc_write()
  spi: sg2044-nor: Fix uninitialized variable in probe

 drivers/spi/spi-sg2044-nor.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
2.47.2


