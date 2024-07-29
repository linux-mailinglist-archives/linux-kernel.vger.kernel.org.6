Return-Path: <linux-kernel+bounces-265728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495F193F539
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50F4D282804
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585BD148318;
	Mon, 29 Jul 2024 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TeKRYsRe"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CD2147C74
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722255821; cv=none; b=kEXj0ahw3yhsxeReEHOtVDD3Aqxp7cgrumcIBby6sx6mxwKWI4o2H5wTux0tTMrq9KG2vCQPqiUpgBdsP18mx7/8H3BZKnjuHcKf+NTlH/KF90cljspjBs9+UDBkBJmiaLco2EwpT6RfTWDiaoVYT593sgj9exnOYG63tA+ILCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722255821; c=relaxed/simple;
	bh=l4wtlpGxiDuUNNO7seUVBPrhKKPr15GuT0Xz+RjLV1E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=B8Doz8LZ69dhXMXYB5AUQsz5WW8m/84wMXlQBXFB5IE1MbmvfPg5kJBfy6fu4YkNeQAoMAe68+3UQzBIPKRabOAc4a1+Su1rpcPBT6hwnmBfHIS6hJfMUmstC76zUL8Hor+8+rTI4AmCxjD+Iqss9eDxg14tDhK9/Jf2IDX6hJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TeKRYsRe; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-368584f9e36so1270261f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 05:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722255818; x=1722860618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcxhcCNMxc3/Qo4UN6vxYU71BcAnj0w0jQQev6c+Yms=;
        b=TeKRYsRePsMMw+mR+RllBATSM2LG0wR9s+O6cr/rq26cLiIKdci0W7XlgOS4/z+gnP
         m3skjXwwGRmMfid0Om+i3cKeLtZk2bfZM2MmFpG0M9RsnABw8blfhFRYBy+G2ybITm5p
         75CKKvleuBBgVM1QtPYs0ZXxbBEhi5S7UA4Dnk8hC7aUYz+SFSV/BnjiLsieL49o4wv5
         sSzBDNIIGW+OiP8nVhe45wOpZeLbfcgcsDFiV6uMeHpRX8t7nDa9tkpvAGjBMa0MVKs9
         I+v2WM160Ln8J1T64qaGHbKUUzozKth1KoZhKPmULe1jRTityWfbB3dR28W+kjai4jbI
         mSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722255818; x=1722860618;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcxhcCNMxc3/Qo4UN6vxYU71BcAnj0w0jQQev6c+Yms=;
        b=alNE/SC0AHpVMmdvrtUoyGlqaQBGEQP6WvaN4cpEtARo4XyqqxXyvI4Pc7kCIW3DhS
         nJ4nqOUFAABizjWAfkLOdbbPgyI+9MT0yFIXEexpJH4kTf5ttc3wffqQcTPlzH3SU8BR
         c185jkeiTen5ux+Ky3YJ7NjXUmL9iH0Mr2WDPes2HJd0OvBcTD2l5a29RNMAn1fk8vtn
         vDM3zVBRRh06oRzzkkFN9r1rIi78tlYqJjFVfhFSzUtnMdvgvgIUBoezlFCBhOGXol8+
         BEvmj71KbLo6+Bu0Uv0b1L2yzDuy5p5NxubXEQ8sDQjcpGgzhL9ujr+AA3LLekTBmjQm
         69Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWC3G2Kq9FyJGaWfR/t+mFbE7BZEvsYFwbzxk0+xHawMrPfUZoSBYthfq/mYggyYjnnm9eNL6IE7HGkDiCS3w1EIpANLIlvygq6hMiu
X-Gm-Message-State: AOJu0Yy88CDOBbRrD2CCQQv7xFEVw5cLFdUGize3IxwJHYWZMkq9srQ/
	4oQ89MVRARCz2YigZVkM/k+An4k2sUaNNEoG8DjqHmeuHOMG2gqyL9YVww3QVD4=
X-Google-Smtp-Source: AGHT+IFRuYT0Y4jSgNDYWdZfJ2AbEF9HGHfkGAHlCRK8AhOMQmpX/n9oFEPATe+nLyTOpCWZ+00PeQ==
X-Received: by 2002:a5d:64c5:0:b0:368:7f4f:9ead with SMTP id ffacd0b85a97d-36b5cecf32amr6013462f8f.7.1722255818250;
        Mon, 29 Jul 2024 05:23:38 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36858197sm12393243f8f.68.2024.07.29.05.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 05:23:37 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20240725160909.326143-2-u.kleine-koenig@baylibre.com>
References: <20240725160909.326143-2-u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH] w1: ds2482: Drop explicit initialization of struct
 i2c_device_id::driver_data to 0
Message-Id: <172225581721.279382.13628225936081847049.b4-ty@linaro.org>
Date: Mon, 29 Jul 2024 14:23:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.1


On Thu, 25 Jul 2024 18:09:07 +0200, Uwe Kleine-König wrote:
> This driver doesn't use the driver_data member of struct i2c_device_id,
> so don't explicitly initialize this member.
> 
> This prepares putting driver_data in an anonymous union which requires
> either no initialization or named designators. But it's also a nice
> cleanup on its own.
> 
> [...]

Applied, thanks!

[1/1] w1: ds2482: Drop explicit initialization of struct i2c_device_id::driver_data to 0
      https://git.kernel.org/krzk/linux-w1/c/e940ff286ec47067cf5043fde41bea45d7ec4a5f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


