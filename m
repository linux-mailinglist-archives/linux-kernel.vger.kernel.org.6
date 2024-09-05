Return-Path: <linux-kernel+bounces-316938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B98496D744
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC175B21C9E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE085199E80;
	Thu,  5 Sep 2024 11:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pnoQaL6i"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DABD199231
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 11:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725536127; cv=none; b=Loit+3MJ5zlufl6l6EmVdxrLdBN4nLJA6kPzvR/IwVoPA68V2h0fgLxq79LkP5ePrLFH0Lk2/MlPKj6Wpltl7ITMyeuUrMmkImVr0qGxZ1mhnKPPY+/iE+kEFVsINF420AbVSRFEpHvTD/lEsgPpxJ75nFTZNJzNDkUOmE/Ma5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725536127; c=relaxed/simple;
	bh=D8LOK6g38BHVUQYIn2cRYAM0mfKu91TTBAaFY8Nhf18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TY7y5RYbKd+HIAfWMYMsrUiB4YUQfYpx9YKNmjgym6gP2n3v+TISqSnFo/Z4iZ1hfsa2JYURbpfPEW+Bm/I4LvNlFmINx+WUk13LYeZmdCHE09diJrOC8FpgUImR6saQ4iZtkb1NG+ig2QX/oYwWqRu06MMxtoLex+rWHkcNcOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pnoQaL6i; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53653682246so660908e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 04:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725536124; x=1726140924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8LOK6g38BHVUQYIn2cRYAM0mfKu91TTBAaFY8Nhf18=;
        b=pnoQaL6iBGXCUEutcL0WLBXTnd4fcV4nTFgH2YmHT4Ncu6yMjLiZG/lnk0jOql4rLX
         eDUFADaJ2cpdrndoHfAq44Bg9Gf1bIDiwrnF9382U5baKWoGvxvNzeU8vjV8P65lAdUa
         jIJ7EZvwB6qRSHdj5rWEIpO1a4XUpN21/keO/yytTPtoD7xd2mS0jEa4jYquNmkb5Orm
         mJ6xUcqPsRElA4h7BNnbqYMmRs1+451bs8P47JVt6AHs4w4P6hK+6AzD0dQzD1KZYXuG
         z7qcb8TLVrx5qw5/afXKMVAY/cdF3D0Ri7KzkonOs0wzSZRzzRjpD2SsRzsdKkUj0iWd
         Yl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725536124; x=1726140924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8LOK6g38BHVUQYIn2cRYAM0mfKu91TTBAaFY8Nhf18=;
        b=sECHWe/jWqQD3WTnMpWBJ6tpaEN749zrJl7e44dfYbruOBmTtzeZbtofCL3lpz/bLc
         1swVLBb1nmCAM3cGWO5hEj2mRy+4oCAlYMTowF1kzQqw3BbfwdxKcf52pIcCjPwcPu5L
         wnpb31nMtjZJbisTAvTe+j3QX5BY1FdD+3R3cTutg1E9cr/ZnCtK+eNiFkuHK3hPaQ9O
         FB+93/tbHZeW9LwKPi4Bs6ogzxVvkGYBuhDPFO+CeVFbHeKV4cfrjxv1SrAlAX648AuW
         3UHwiuhe618dmTEAVtyEnk8pYNUOpFXfPaWHvqmPZNiTJfNDATpOOrBkGAtV4krwpa5+
         hnIA==
X-Forwarded-Encrypted: i=1; AJvYcCVHLJ2PJ0JgkQ92jDl1KhnppxYtcIq6Nx4ceUTtLW+8w/kqyvyqWRIyCf4QeUWRVsRu6YREQlj4+FmUwyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7QYdKQODl+YAeajBZlKpSOzVBBIQpJyekegFqags08E9i0L8m
	SxIqCGJ1Z7z5z6uVh+OIrAC2PHfmr/4bhTPZ103MiNpBr1CnUxH/DPWZAVjI0/FmXlt7pfPUiX4
	+iUcAQQXbszQ2ZOGyXBIpofS4UGEXeZFlaZqF2Q==
X-Google-Smtp-Source: AGHT+IH50s5Z5WFlFfNldch2QeQuYIA/dIzAsCjazzpfQvumpfx/biIviPNI+zjkOOyT+8fP2SwCgivOGNYW44aUWD4=
X-Received: by 2002:a05:6512:3188:b0:52e:f58b:65ee with SMTP id
 2adb3069b0e04-53546bab08amr16289049e87.57.1725536123383; Thu, 05 Sep 2024
 04:35:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902133148.2569486-1-andriy.shevchenko@linux.intel.com> <20240902133148.2569486-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240902133148.2569486-4-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 5 Sep 2024 13:35:12 +0200
Message-ID: <CACRpkdYWPdha2Viz4v1whGcHi1J0wqThE2ng-=AuW9f9g4oQWw@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] gpio: stmpe: Utilise temporary variable for struct device
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 3:32=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> We have a temporary variable to keep a pointer to struct device.
> Utilise it where it makes sense.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

