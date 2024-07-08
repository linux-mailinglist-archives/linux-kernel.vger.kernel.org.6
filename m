Return-Path: <linux-kernel+bounces-244895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAE092AB12
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 23:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5042F1C21A29
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1E714EC7E;
	Mon,  8 Jul 2024 21:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XDys5MyZ"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50C814D2A3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 21:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720473557; cv=none; b=Jrf/HrbgNQ0zlkuXxeTNj89NT1CDsgaOAFrCIYFJf1aUsqANFQqLAXjT9jrlCVse+QI3O3sH3+CM/81Sp39l2Ak8fOI002M/Wcwl2H7ccokHDJZxpmi4Ti8uO+sPSGQz9GP3Mkd91pmAxbPtVFC2P4LIZ4lksMzHlgQQPe+2YQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720473557; c=relaxed/simple;
	bh=hsAhfj8aFEJs71FYpyqPwZGOXF4mUvOaxuVfwyymbI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZiM+wJUGDgs1bT6CNZeYFujG0z47HU2wq9dJMVpaOteiyqxkSBpPtZxsOL/Sy2h8w09d+XwT0jmBBsDMveu4YSacYv0OEzfYqTxTURvs2as11FJIr0c4Thb3Er/kjCp2xusXbHAuafUIpJ0xMnKBcra/k7ldCRLrAbd5ddJips=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XDys5MyZ; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7035d5eec5aso1703353a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 14:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720473554; x=1721078354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mXYMPnBhTdbUT+bRyOjqdFg2raSWl8DIGx1soVkduSw=;
        b=XDys5MyZhHNieTee5sQHCa2FS0EOHE3PvP1ei/qgPgKD9iv8l+qlmgnU6vcLn7VWP9
         5aKOIlnaULeszFiPd6zu3vNHSwin08oVh8Cc4za5q0QrFjYbp821bQaBFA2oTY2TK9fM
         bEj6QrVjanTvCLNPuFzcA5MmMFnhRc0eHr77QJUXBIY3gRekMukemWoP7BDpXQb3cnzY
         /eGxFzQd3FWpYmcZQGF6okDd9lbo+GPBGkABT95cj4994zIbrjS1yd2x6dJ4fRRK+VtN
         1kQlt+EDoUZtJKtPAfa74eKMJzFLhWWlDhk7qluZamSs87TdqW3WXxqGTZF562r2m8fU
         cOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720473554; x=1721078354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXYMPnBhTdbUT+bRyOjqdFg2raSWl8DIGx1soVkduSw=;
        b=MTPsY57sZnq+b1SlsAJh/R63BzmgzSmUTyB/6GktReuU8mMfhkDiuEaNBQ2UIOn6HN
         1ZPRXA6JzrLWSni1dpXeSmDfszjApjSMeqWQmcR/XNygqoadejsmYRjdyU/T8eF+WSkF
         bmYjNLwIFbhNFFN9YZ2DTp3tvS/aA0jx0rhHN4Em9cLqM+JN/N51Qmmd/k137WuGdYOI
         Ixcl6ajczIRCgSW9bqbyTG3EUszll2YbQFHasTllbujJVXXOMxc6y74Vnth3ipn23WvA
         +lmqF+Hfg7NN3pxyfxCibLdHXwtqOBIPPlgLJbKEMc0VFj4LtRgn6ZM1XHN2mpgUt0M3
         /HcA==
X-Forwarded-Encrypted: i=1; AJvYcCV0skV8HyOELvEEbV4NHz8sDq9aTSU/ei8dVyvv64eNTODlmYY2fDaDuUlXLTU5cRrhtz3opal3qTXPU6kt1fqbBr2TADwKhweH5zka
X-Gm-Message-State: AOJu0Yy0yTEXYN2DBJ778QGq7KewDcho7JTxK4theDfk3KZ4PAqlFMTr
	tuBEeew4dw9or+R35HwFRV91G31lNq0yowPi8SllYGsbCB0EyGtBzVGzm0gdSXY=
X-Google-Smtp-Source: AGHT+IGIs8S5SwxO5AG/xIB7go50K9dRKNy/yvMs5ivx/sMjNBmQ+wjU9JHs8h70Kd5YvwnO3+hheg==
X-Received: by 2002:a05:6830:3443:b0:703:67f8:9b3b with SMTP id 46e09a7af769-70375b4045fmr634344a34.30.1720473553835;
        Mon, 08 Jul 2024 14:19:13 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70374f791fbsm165072a34.27.2024.07.08.14.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 14:19:13 -0700 (PDT)
Message-ID: <f543a6c6-ef79-4dc2-a5e0-872d491d9606@baylibre.com>
Date: Mon, 8 Jul 2024 16:19:12 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/7] spi: bitbang: Implement support for MOSI idle
 state configuration
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nuno.sa@analog.com, corbet@lwn.net, marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1719686465.git.marcelo.schmitt@analog.com>
 <b08e21823638c241228f4bc27a7bf5d4ed88d54a.1719686465.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <b08e21823638c241228f4bc27a7bf5d4ed88d54a.1719686465.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/24 2:05 PM, Marcelo Schmitt wrote:
> Some SPI peripherals may require strict MOSI line state when the controller
> is not clocking out data.
> Implement support for MOSI idle state configuration (low or high) by
> setting the data output line level on controller setup and after transfers.
> Bitbang operations now call controller specific set_mosi_idle() call back
> to set MOSI to its idle state.
> The MOSI line is kept at its idle state if no tx buffer is provided.
> 
> Acked-by: Nuno Sa <nuno.sa@analog.com>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

FYI, this doesn't apply cleanly to spi-next and needs to be rebased.

(conflicts with https://lore.kernel.org/all/20240517194104.747328-3-andriy.shevchenko@linux.intel.com/)


