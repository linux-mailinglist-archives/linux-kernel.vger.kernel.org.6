Return-Path: <linux-kernel+bounces-311410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CC29688D3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4B31F233B8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88E620FA83;
	Mon,  2 Sep 2024 13:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vZrFSdk+"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F56F13C9C4
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725283593; cv=none; b=ExgpA60wI67V5NKn9y1pz6YT0WQit9HukH7xeBJ8UwordJl6pyO811V9AQAOCm10Z/7x5W9WUqEaPSMehfn1c9c66NlZjcL7hMATqQkL7s30bbpfyLcCfZ0KluMldA3Ayj/jTkxlLFp4Opuf9GulPbTXesb5oRF7ThETXKbp+T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725283593; c=relaxed/simple;
	bh=G7dWMzL7n4S1+slFQ0ClIOlbPlst8tl7fhHnt32XVU4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aYik8yvYdB/nIooI5kbW2PNuozehVV+EDNsOxYyEXMgNJlxAePIijTEdMUmdCQd9Y3l7bfTqZfB7KWKLV/1e7nRFh/x4sITk8n12GuLeWt/m8YHQKoA27kDTPJdAOmsOJZRiJ5EzhS+nqcRk4QWMfX9JvkrHEjASKi6Uzn6MJBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vZrFSdk+; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f3f163e379so68228231fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 06:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725283589; x=1725888389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtDKzgXODF4JuhczPueitOS5+cM6OVgR5mHBhD2EXY4=;
        b=vZrFSdk+S4dT5TcqHMf+ycqoBqrbYugOBl3G6ZIz7B5sR4PtvkEkjDAmYeWS2k4Y+F
         kJqBfavYko3jSnLP63PsbwcDWEh3yuhlYjxmTrZpY2pm3r4u5SDKLQ807GUrkD3ZD60z
         +EwjRdL3yx5vYxnfIzd0wWZuVsxJH14aaLzkAmSpQydrtneY/FW42Zrvolbb/AoJdoQK
         FqFmWFBTVyJoGRK6d8dUQ3u1fDGl6cifujRKE3v7d0YUrkhVRKUOZx7WLZ8oCam5Lt+V
         MGH0asfwA0dpi7cGONxPaBMfk7PriP1Iirxw7hK4ruFVBTHHmuJgNdWprS+kZPSImxdu
         P5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725283589; x=1725888389;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtDKzgXODF4JuhczPueitOS5+cM6OVgR5mHBhD2EXY4=;
        b=vHXiZ42//Eh/yWMOLJdII1W72VhVLZzdHu8q9H5qZPNZ1qGWld5YLsH5HYDMsbjgZm
         Oe+/of87xuL3Lt6tt8dLoifAmctbN0Yc+2dWmbNDhWjIhhfMUZKE+elzwAnKm5ztLLUo
         mC+QaKL7J/2FLXxpEECbd3W6KhOIpkdhLRNrprPlQmRl7pgoRFkVXSnfBTp1eAH+hwMk
         DaKZLqCeELB9kbFt9A94V/sOMKqX/TzfFIghFh6XbnhRdOixnmnEkiBR3m9OvVCOVN5w
         wXbubbMXcwHrCwFZ7n0b44lWJ6QafaMbkxPfNDKPyocIfq6hBWXSDY0qDkc+iVfIqYiP
         FZgQ==
X-Gm-Message-State: AOJu0YyK+tG8ClH2W+t54eqFROhMXcJWOvr3Mx19itIzVE2x0XgX/gqI
	f+KohoTiCxjJmXO0/znQZiIiAHS9duOh2edODNKRSs53+wBv1rDdHFRrR4oMqrg=
X-Google-Smtp-Source: AGHT+IExx83a8XxfLxCR2FJvOBvSuoXUVVP5qCc6YZKvhOEeQX2FSkzI0JWRse3KRtYW1ypMmGaZwA==
X-Received: by 2002:a2e:a546:0:b0:2ef:17ee:62a2 with SMTP id 38308e7fff4ca-2f6105d8726mr118607131fa.14.1725283589271;
        Mon, 02 Sep 2024 06:26:29 -0700 (PDT)
Received: from [192.168.68.116] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d8345sm566658566b.173.2024.09.02.06.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 06:26:28 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <d2748e1873daf55973de9c99ffeb6de6fa6451af.1724938228.git.geert+renesas@glider.be>
References: <d2748e1873daf55973de9c99ffeb6de6fa6451af.1724938228.git.geert+renesas@glider.be>
Subject: Re: [PATCH] nvmem: Fix return type of devm_nvmem_device_get() in
 kerneldoc
Message-Id: <172528358775.66088.2431572566413912637.b4-ty@linaro.org>
Date: Mon, 02 Sep 2024 14:26:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Thu, 29 Aug 2024 15:32:38 +0200, Geert Uytterhoeven wrote:
> devm_nvmem_device_get() returns an nvmem device, not an nvmem cell.
> 
> 

Applied, thanks!

[1/1] nvmem: Fix return type of devm_nvmem_device_get() in kerneldoc
      commit: e840fdc0eeb7239fc14b36852a6361eef61880c1

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


