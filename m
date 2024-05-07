Return-Path: <linux-kernel+bounces-170809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B77C8BDC53
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCED11F211F0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 07:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FA613B78A;
	Tue,  7 May 2024 07:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hw1YIoNl"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDF9126F10
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 07:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715066465; cv=none; b=A4xicJqSy6cm8r+mDPK6qQtZMeFs/6wgUZC/bP226EmIhqLoPDLn6sAtMCaVe2df0GBP72MLu+DadpkpQG5NKFyWDaoG65WeNLUiloxhIDyVQ/nMI7QnXeYs7buQyFyjgP+yDXTevzG7QRni6epWSRUkzwfyAdJfU908EujQlvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715066465; c=relaxed/simple;
	bh=GipwqvypiOLvwU6EeG+vLAUPgeUBGeq105ZDmCvbcis=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BLAf1wz26A2HpEiUEwUibuyfmZsRdp8sOr8s/HDJEqnZvNFZrMdDa0KeqKKWy7Q/27mKMtRYW5EkoJyvydGxSxpL42oM48pHlr3YePnmruiDiGMzNPgMBUr3AYTskp+OgDIH4njNFeTFg506H/3RZ95Ljbu2Pc8Ou8ScFbQaEnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hw1YIoNl; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4df1cb51866so610887e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 00:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715066463; x=1715671263; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GjboetY7EGGtwn+rjcmmRLaaZ+xjrYO5U+LuNkUiwoE=;
        b=hw1YIoNl5MVlYWSOY4rJf7cd8KR2Sy8RfyUhLbwFrAIhBQRRmlQUf5k+5+Cb+F/IQ/
         DDtoz4fnqVhatcClk6A/uQzA18Wz473Ef6AIuT4XZ6gl0RfLA5HoElrLB6BVM5G+1ZWK
         8orqZRPF3vu8uiv3izu7sfdE3VyTxomuKCKiRIb5ZPIJWzzk+e0DoO6FF1ASJR4HPdP2
         Mu7r7kEj1GbLve6ztS+CluG1OBfJLEnTOw2PF01JHlzwY6nGZjHfw1DEcu3akBh5d08R
         wjjOPzLcra4lIXZOxeODpN/AjgWV6h3PuWtnLxPwaDJU1xmIFuSR4uhv1c3R2TrMf7iw
         1VlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715066463; x=1715671263;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GjboetY7EGGtwn+rjcmmRLaaZ+xjrYO5U+LuNkUiwoE=;
        b=kFttRAtqnYIf9IR2ZanHVLS4dm7VbTxw+tBMwOwo8IBuXS2zyV28xzSIRozHHLjT+v
         etW3glJhu4Q0tpP7u68lnMcXQ5U20XfShwhV04aXHFIvWupe06hCRfsGipdyHLXVeebb
         1hlcjl9eS4BzTG8Pl4cqXV8aBkAQSgNdMXdInjLD/LT7gxSOm3Yca92X7xH0t+2rLDWk
         XXWyHmkFxDotYOmfUJ9/4NzEENYXmhla5Yqmp+vXf7NHfcvCpoYayy70APPodGxSWwVf
         KsBCzODNAEYNkxR6GtDD+b1tWsSNW+U6jVO4iOTo3DHeOXIXzLu8myrG2pYWdHtcWiYB
         6ozw==
X-Gm-Message-State: AOJu0Yx8EO9iehsU3QWkfEO54Z2EsEVahkGUlfsrHPdrtL83N96rBwPC
	nY6t0KeTh45hWmJ7/y6cCVRx3SyPUEBefQsXLkDzUA3+xzXTcOyc/Cx+TaNdZ/Y3Q27y8HOWQBB
	pw1wYJDHO8nWOOhvCBZsCuVb16ddtKqyWe0yzH8ekNpYjs37wCdM=
X-Google-Smtp-Source: AGHT+IETDU5JT1DtqMGEfiFivAePnxXKVoMG/w3zhoz5NnmwO5ZJXRWGQnDhxQreZSmBun2BZZydbuoxybM7jF6wIJ4=
X-Received: by 2002:a05:6122:88a:b0:4db:1b9d:c70a with SMTP id
 10-20020a056122088a00b004db1b9dc70amr12185575vkf.0.1715066462784; Tue, 07 May
 2024 00:21:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 7 May 2024 12:50:51 +0530
Message-ID: <CA+G9fYuZd_ur56H8fwDSvUywopvn_b7ogprGkjEatQ7EPTLwYQ@mail.gmail.com>
Subject: re: clkdev: report over-sized strings when creating clkdev entries
To: open list <linux-kernel@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, lkft-triage@lists.linaro.org
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>
Content-Type: text/plain; charset="UTF-8"

The WinLink E850-96 board boot failed with Linux next-20240506 but there
is no kernel crash log on the serial [1].

Anders bisection results pointing to this commit,
# first bad commit:
  [4d11c62ca8d77cb1f79054844b598e0f4e92dabe]
  clkdev: report over-sized strings when creating clkdev entrie

After reverting the above patch the boot test passed [2].

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Links:
[1] - https://lkft.validation.linaro.org/scheduler/job/7546260
[2] - https://lkft.validation.linaro.org/scheduler/job/7548064

Failed information:
    - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240506/testrun/23814147/suite/boot/test/gcc-13-lkftconfig/details/
    - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240506/testrun/23815165/suite/boot/test/gcc-13-lkftconfig/history/

--
Linaro LKFT
https://lkft.linaro.org

