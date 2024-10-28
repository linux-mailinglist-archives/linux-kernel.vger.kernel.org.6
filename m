Return-Path: <linux-kernel+bounces-385431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9100A9B3716
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25422B21565
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33481DEFE6;
	Mon, 28 Oct 2024 16:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3ZL/9M2/"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D7E1DED60
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730134262; cv=none; b=fb4zg1AH+ioFzcNyrOQP5Ji5pJuMACz/aY5C6TlPgNoAZqqfKl4v/pK/WLJRMPhbP25LylrEbJ3xP0WGMBdHeB2up4FBqjOqHvmWoyDy63716Y9nJDgXzwZovlOUI2/z25IQQ3sYZjipynvgPsWjTYiAn4FZvGO3MgN9hx8ZQSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730134262; c=relaxed/simple;
	bh=YNoQvvMS5/D2v2YySWQ8RNDrxQrJsWqDk2LwVI2iMak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+HTvS7wY3RPVadJ/phxfnQUl5aLqovAMG0wKzdSCMOiLtllW0Iv9c1txiddXO7lflokBuC+04vvkjlPRnhxcOoH6ewfdlaZ5/iDG1kXLtfO73pNy/fO/hzDGlkpeA9HAW+biwvAVbrmsDT4O8ExwBzHERw4TV/1QaGypYpkQAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3ZL/9M2/; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2891055c448so1854350fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730134259; x=1730739059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=So5fw0V5qgR2UBoNFs0rsc5CZx1axz+g9Tri71Oo1jA=;
        b=3ZL/9M2/iAX1adTQgdaQIPyRJoS5Maj0NEQmNcwMVVh0iOXC1seIpP+8vg5+gwmRiZ
         BQpah43QvQxE3ckGfsi/A0FNO6wby7qCRHc2tiNp75HfSjIoKxsyWK8BVeowVnwWURsc
         TA0tmPI4oRRlRqrTitH85TaToMI0byYhWkmpbXX4+37Sa3luZ+YL76jgW3+pHnUI67UN
         JidVKbLHzLd64Y3UKNegWqsi5dM4LyddPW8DuJZVSSaJZPyxVMhU3VWIwOcUNxF33C55
         BC3O2/iwNBffM6D24bI4UTu79mFjLHdiy3PRwSXTZ6kuHJKu6U1hLBItgmdGeBlSjdzR
         pYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730134259; x=1730739059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=So5fw0V5qgR2UBoNFs0rsc5CZx1axz+g9Tri71Oo1jA=;
        b=eqVsKQVXfcZZNoxIi5XKccrRmCiB/99wbubsMU7u2dxaRwvz2J1XtqG23eOgfzfFQZ
         TnmCb0lY4Y33o1Uqzu2xrrL3hk2IvKt37051fA87CrnPpIjNB/6x1KxDCWfTPUnyVJlE
         hjthYzACtnfTiZ15MMP5utEz7K/yzVbZzPu46b6hz1o9fjw7YNGVsaqH9cTu5bN2zNwh
         IZnHLaejDwuNDHgC0+xgT02rj16xujo6nlbfKcW8pMcxq6aTobNw+ig33826eeiKPmPY
         /7A3B6+iCSjarLSybQkDpom3tAprGp1iZH3Hip6kRpbtoGD2dAB4Njq1Vp73+708J/3p
         iYJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ52DRI/5P8adosr9u0tIORXyVAjCS743EL10f16YWxZtFeybxctGSCQzlk04+YpKWT6LB9ruYNurkpHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzciziHSTdqW9tRyHl3wGpJVIKDofkXB8b5MFTX33wEoTE0VY1F
	QHDZ4eVfQIRrZqZDG335/0WQwtGvlxomhHfg9dnYDZ+ifhqlQ8b2NTW3giG6frA=
X-Google-Smtp-Source: AGHT+IHTf5Y8gWwEN+EmjM+XuERl5FU+xwKU+Ixf8xTy32EpCHlOJQdRNcvgTuT7gcWLD86pnLQhTA==
X-Received: by 2002:a05:6871:6a3:b0:264:9161:82e8 with SMTP id 586e51a60fabf-29051dcd079mr6645207fac.41.1730134259037;
        Mon, 28 Oct 2024 09:50:59 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2904394971esm1939131fac.57.2024.10.28.09.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 09:50:58 -0700 (PDT)
Message-ID: <a4efd955-9956-4040-be2c-9bb8e032d862@baylibre.com>
Date: Mon, 28 Oct 2024 11:50:56 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iio: events.h: add event identifier macros for
 differential channel
To: Julien Stephan <jstephan@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241028-iio-add-macro-for-even-identifier-for-differential-channels-v1-0-b452c90f7ea6@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241028-iio-add-macro-for-even-identifier-for-differential-channels-v1-0-b452c90f7ea6@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/24 11:38 AM, Julien Stephan wrote:
> Hello,
> 
> This series adds a a new helper macro, IIO_DIFF_EVENT_CODE, to
> specifically create event identifiers for differential channel.
> 
Reviewed-by: David Lechner <dlechner@baylibre.com>


