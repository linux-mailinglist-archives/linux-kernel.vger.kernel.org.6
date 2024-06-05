Return-Path: <linux-kernel+bounces-202726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E51F8FD00F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0029C1F2139A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33212192B6D;
	Wed,  5 Jun 2024 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AUH34lJS"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7718018FDBF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 13:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717594717; cv=none; b=cEkwJoxuINdsePk0r4L7Q/iRI7qSYmzpXgOsZkDXg+ya+qJIgSLsSZZ9EK03COuh6CztY7BXXzaRwePz5qROry2tqugLcxbdFZDCuxp+wi0epaXvODTUkM52NlgR6deLQ6k3B4rkw9brsZVQbc5FKO0QeNlet9fu2tZfQbYWYBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717594717; c=relaxed/simple;
	bh=mlhApMpG5WU395YtWwS9QPBflIL0rJC4v8OyN6FnRbc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJsm/qWECToxuJYZo5zxFoCiLjzuPShIkZcCJxsSNikLFhK7143qvuGvg9SAk/mz5b2HErVTU/5fgwYpLhqrDlHnwqfR3B3XKEPtuUfTbKs/VSTuubNy4Jj1HHx5Fmyya/fVywIspkemGwgI5M3Oy7gpg1ESiGeDb6Jgs6NS6Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AUH34lJS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-421396e3918so48144455e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 06:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717594714; x=1718199514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mlhApMpG5WU395YtWwS9QPBflIL0rJC4v8OyN6FnRbc=;
        b=AUH34lJSHF1jmKLrzgVUddSsKCND91OwylcvYopEsudkJI9VrjsLp7Mket5FQ6NCAK
         +bhBPjP5gj+u9a3pX2pHCpy/xTsyECtunF/ogJEwWnfF1XFIhIkvF7kK/m3GJsztd1CG
         tm+Qixqbjhif2OlUGdQCNJAinA6QtoXclkKE9POoJD+yP8bQ0WC2mbAlZRX64QHoaFiU
         MMHJyuAc5FQpS4ucRbhd/qz880dAmHVx68nWaekLhs6YibBZnbjGEF/un28MehTJFwkY
         /6kjzZtrS1Kri/wdZfcFzOM7LIJnQ++bH87xmBa9XQTSG2kWdtS84CNsHgg8gWdocUUG
         E62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717594714; x=1718199514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlhApMpG5WU395YtWwS9QPBflIL0rJC4v8OyN6FnRbc=;
        b=YqNyIzZmx6qSdbP75at3q0K92IaEYf4EtaHJ3bLV8msNlDXsWWKrE23AhPmcFlj7oT
         LAT31GDmyMmnCCD3yN0eotgy4wsL2E/7945HexAt0be5HZsoGsdqD8AH3TuFNPb03Nww
         98JtUd8cOIhbrF19G/RPIbXWq4ZMPUsQJ1BD8a7K7fka5VgbAjbhtVmqnwcQsA5lOmGa
         alSNm77NX6lrKrVw9DKb9c0w5PQmzTPyRDU6fIyNll1YkaLHpfw+VI55YfE2uIDVB/LB
         Su0SHHckwM26DdgS0jQQdc13wMRUEeQkAPT0MhUqgSNsCS8RIciPk/e/tm101UwWb67A
         569Q==
X-Gm-Message-State: AOJu0Yy9IuCtE5JBxeQ4lG4zE4InDGUzdbPWn9P3oxASn9WseDeJAjOZ
	C+WWatbYETg7wHwdNTEx4p15gZmiv5pwc7Sy0cS0zrKRLz6eDqzk77ZXnLPL1dg=
X-Google-Smtp-Source: AGHT+IHjkretuS1fTFtZei6hChIG2kgCEQtxhJThqCOKkNHqb6TBqHMder8dhApLzt0DEjaMW0SbBQ==
X-Received: by 2002:a05:600c:46cd:b0:421:1fb1:fe00 with SMTP id 5b1f17b1804b1-421562d4a37mr26359565e9.17.1717594713675;
        Wed, 05 Jun 2024 06:38:33 -0700 (PDT)
Received: from localhost (p200300f65f283b00ca876ee5dd3d1e3b.dip0.t-ipconnect.de. [2003:f6:5f28:3b00:ca87:6ee5:dd3d:1e3b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215814fc11sm22296825e9.48.2024.06.05.06.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 06:38:33 -0700 (PDT)
From: "Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=" <ukleinek@baylibre.com>
X-Google-Original-From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Date: Wed, 5 Jun 2024 15:38:31 +0200
To: Hironori KIKUCHI <kikuchan98@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Aleksandr Shubin <privatesub2@gmail.com>, Cheo Fusi <fusibrandon13@gmail.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 0/5] Add support for Allwinner H616 PWM
Message-ID: <d5mr73yc7l6w6uvgqb4ymyc5267do4zirnnorkpi5s6qa5vckk@owayit4mexk2>
References: <20240531141152.327592-1-kikuchan98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531141152.327592-1-kikuchan98@gmail.com>

On Fri, May 31, 2024 at 11:11:32PM +0900, Hironori KIKUCHI wrote:
> Add support for the Allwinner H616 PWM, building on top of Aleksandr's
> Allwinner D1 PWM driver v9.

It would be great if you could arrange with Aleksandr to maybe put your
efforts into a single series. I think this would simplify reviewing and
overall handling of your series to me.

Your first patch should for sure be squashed into Aleksandr's patch #2.

Best regards
Uwe

