Return-Path: <linux-kernel+bounces-403947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB0B9C3D08
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79FA4B237BA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B27189B8C;
	Mon, 11 Nov 2024 11:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZAy6roTZ"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4FD156F44
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731324078; cv=none; b=t97biE68CNTQYjfN7LXSvupJ7/P5jofwM+8TDqEbGOXxOKuE6irV0NZc1+qMi7nJ4K/BYOoo8viRxIKOUjPYJ9T30cTraDmquGwGj2ZSIWcoMHc9EdRoQ5MmU7ZlGyJ/ML7nx6TVh04B6XI4m8m4xG02RhqHT+y6qxp1lDzJY+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731324078; c=relaxed/simple;
	bh=gVRNVXU+XsTveFPESwuAaoUa9rADH15YraU1uwLLr5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3MyR3g44dvOErd2hVsp0vcUZIVYlqwAC7hafcM52z/JezPumLe1wOCrn/R3KnLWWWtY+nbfCXyWvo07S0eM6YA2ziQWg6SPPp8SHhFcezfPlbItuTJQkq9TdpPKUPQxVTcNdGt4w3zlFU7OqJChX7sY1CdN1F5SSdRZSN5l4qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZAy6roTZ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso746816766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 03:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731324075; x=1731928875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xadGs5mwD1qsGTtzkxs+MHJf7d9pXe1KKCe8zYpsmpo=;
        b=ZAy6roTZLgZ0TMqrx8YOQClPQSIgmyfb6r8xA7R61SjGZ4V6WRMlfmR4Y1Ie5ycRvs
         742eP+YL20dvjAHHGffZQL/YviHuJea0izeXBbFDYO5s2Fi0+6Nd4o5SniNkoCEUXAcs
         FXQHWTaeB0lK+JkEq4LhWtlwkCFbr2ilU8UxyP9+S2e7LPHheF9Z9ckSDLJmd+FBSFS9
         YvPsUkFRHj5HwxJCPaE6Wh2zk95+jXVNaPUUkCZAJIP2kWuFrzebb2RSP4wUkq8Y2KR0
         bRqn8JNVOV3UU6DhUwOaOLj/swy0ow8kqrpN3pk1q/KgUuX7ACIGulFho9zg7hbXlNNm
         PMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731324075; x=1731928875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xadGs5mwD1qsGTtzkxs+MHJf7d9pXe1KKCe8zYpsmpo=;
        b=p16yYXs2Y15keDRLdyFUzq6Ecyy2UiVNk6be1UqcyrZ98rpUTw3zYPZZ1/GaxzFSDI
         xK0ILIhXbCrbVaUfGPvkctw9pinKoK6M5aOTQTA34Y4XMnuxBYj/9G2pK3PqGbspiv/e
         0AOW0+yoTPpCALSxsUFYISOsKpU/6njrA2ySRYeNbrkXs8G0UhA70cZNJ0I9QHCf4/zd
         PRA1+em4bNL1Dp8yqgyJW+Fvn/SnIxoUEmtJjbW6Pcg7DixHNx9aXpypRJN7L9BkUe9l
         giC0LGQIzc94CScRWtySJTq5FKH4asTqGgnIh38nEzp6EHmap5K2uBqhosrarD59d6iw
         NIuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrMpIG+2DJBi+TJTwpOYJmQ/6PPhsfJSYRGtitQhe8oT/oRjV6EwNcra0G5p2JTmFR1E0/49BGw+BTkGY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5keBVuhBKUgnwRQzI7qmAbotNTNUr7nOUMqObCUyMMZ7VF0s6
	uAgl8YL55HWS+fgqZAiVhB3c0HptfbOb3yBtA9fXtbZROLrdWPAIy5PCSI4CQROoIpqlThMmifV
	3
X-Google-Smtp-Source: AGHT+IEwy2N2c63rj8E+OlMUwXaIcbDUR7Sk7oDxP0sPZ3aSNMocv7LL9KE0Izc+N6rNT+6VMc/psA==
X-Received: by 2002:a17:907:7e8e:b0:a99:37f5:de59 with SMTP id a640c23a62f3a-a9ef001919bmr1200287766b.53.1731324074792;
        Mon, 11 Nov 2024 03:21:14 -0800 (PST)
Received: from 1.. ([79.115.63.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a48585sm580264166b.45.2024.11.11.03.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 03:21:14 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: pratyush@kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: mwalle@kernel.org,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: winbond: add "w/ and w/o SFDP" comment
Date: Mon, 11 Nov 2024 13:21:11 +0200
Message-Id: <173132406532.9203.16605766715028942192.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029080049.96679-1-tudor.ambarus@linaro.org>
References: <20241029080049.96679-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=730; i=tudor.ambarus@linaro.org; h=from:subject:message-id; bh=gVRNVXU+XsTveFPESwuAaoUa9rADH15YraU1uwLLr5I=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBnMeil94i1AddMV1iOqINU7/gzjAdNXiYIo44l5 x07nJhNGjaJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZzHopQAKCRBLVU9HpY0U 6VGgB/4k5MVyWCGYYf01ruTnRsPkUVYYgauJWhy0qDI4NPnSs64C4HMLTFjMmWZjHXUONCIVOLK juKPOhBh91AO67d0FxAKeFPBfhIiEQK2rFKPdqhJ5QGgLp8JQutlGfn5vuy5TVX7retT+51y+Cg k6FlLEmQAUbKQI8KcDdvTIVEsaKWUmySe2h/yTcJ2yYdKZUxOPXgbDBy1xJsriHXRpSeTLF1PQT 6PWEwdsLaQTmsub0/tpBo9KWZQJvj+Cqo/Afpwp9g40QoqM/+xeBthgvw5mFopw3UthIHHfb2hi az78nFCgPRmeZkGQu9xj8q0S86bE1B63lY01WQu39kM9FVKn
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit

On Tue, 29 Oct 2024 08:00:49 +0000, Tudor Ambarus wrote:
> Commit d35df77707bf ("mtd: spi-nor: winbond: fix w25q128 regression")
> upstream fixed a regression for flavors of 0xef4018 flash that don't
> define SFDP tables. Add a comment on the flash definition highlighting
> that there are flavors of flashes with and without SFDP support.
> It spares developers searching the entire git log for when we'll better
> handle these cases.
> 
> [...]

Applied to git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git,
spi-nor/next branch. Thanks!

[1/1] mtd: spi-nor: winbond: add "w/ and w/o SFDP" comment
      https://git.kernel.org/mtd/c/f8f6224948d8

Cheers,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>

