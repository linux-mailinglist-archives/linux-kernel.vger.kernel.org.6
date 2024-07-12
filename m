Return-Path: <linux-kernel+bounces-250157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEC292F4CF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0041C22171
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EB617C69;
	Fri, 12 Jul 2024 05:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pB7faLpe"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EBD175AD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720760424; cv=none; b=nt2iMzxj5KRaPkI7XqfhZtPtIynLDxAPQNIvM+GSxSqzxlgmn4HK7w3VwGBCXMX2B/28l+LTIKdCGoxbHOxyfiKz5/dbVft8wkke3bJoQdFQZSUj3GTON8WX4l8pqRV4lNG21kmtf0V/g/Sag5s/pUpJuT1dcLKpIk5NFMrf75M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720760424; c=relaxed/simple;
	bh=xtREc+nIH3/pIs22PXknrsxKAv9mk8z/DpRw7fu7kso=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ix3Fey0ucEu1H/CGtikyY7Ta3oCAZ9j3cHwTUTyADfe4xOPEsA6zPhuOPs6RAW8ZZePyNzo9SUPePev/jyNnQ98Ka3T9/xMCu9QxlVdfCZBfYqwpIdpbY9jdM+RWEHe6nVKGzKmNnF4d9dwG7uSte285XEAuhvQSV0ajeirPypY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pB7faLpe; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-36796d2e5a9so965781f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720760421; x=1721365221; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xtREc+nIH3/pIs22PXknrsxKAv9mk8z/DpRw7fu7kso=;
        b=pB7faLpeVi+WDWOq3IWH+hnI0QFI+KQGUj9uO4ENgazkYZg/8+gdHfguV9/fhEGip6
         GaLl72DnNJZV4NKmdXk+sjUcAKRDt65rH5HZsrC3uS8YynIpgz6/CQGPFwcvNiA10pvd
         m7zAdOxfsoyCLsPOTVi0UCjW6zwW2fzBrjJE4xjRKsiHCT1qt5KnR1ZvdXSroJBgIn/Z
         qMlY6S1ufdNYC+pzE6LLcWHjT/YAmRG3mHPk/Ta7MTjx53k+rK4a7EVwAKXDCNvCcOjR
         1fxomeSf7pKaWfryWiEU0fCCdBdIyasWkS73BE4TRtXjEQTgu8tuzDku4k5V1QYnMrSX
         mD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720760421; x=1721365221;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xtREc+nIH3/pIs22PXknrsxKAv9mk8z/DpRw7fu7kso=;
        b=aDbSwgdYMnrt3w2th3wslREOzoTV5zz0eneMtbIodsgBzpbOiXOANq5gjYrdn7epk9
         aQaX/I4HNkyAplNp/qv0JMlKhOAKvJ9pODGuhujXH/fmQ0lCdVgiAo1sLo6J6l+l02Nl
         pkZ6usq7cHRPTeiaPKCR9/pjOKuMqTTOisWna5oWUauX/oxAoM1j64xoa9AlvvLlasH3
         I3Hcf37sHn/WQXJIimdCB5WSH7fqWzbOVWQFdWSH7K/4JmVqBBNz6z1azZvRNHWIItnr
         2rnHbeMJQsCzRcXArI0Y7RjhUOEEmqx8MsjZyz2EvA8BkEmX73i2W61bGbc+4qtPRmy8
         Dasw==
X-Forwarded-Encrypted: i=1; AJvYcCXZzW6nTIZ+Uj34yji1BHIWem5SxZ8QbhArdv1NIPcy7se9nnlkuqPOgPyDaULxhgriSw/wczM3J5FPGrDq8/0sgvSbAIFZVX+XGm+y
X-Gm-Message-State: AOJu0YzAnRgIRwCuRUzcc6VVzWXkMDCsHj3/WR610R5yu/jBOc+cQ5w/
	y/AKex1t0Vmau6Kq7eZ9zNKSW02eCAG3GUkX5KKB1wb2eX3QTNSEWG3QXCYbRCI=
X-Google-Smtp-Source: AGHT+IFiYFIGKJfQyPnchd/fwzShUwNh2360VhDrC8CiwYOSi3Z+91egB0zDkeO+M7mP7Zw60Obmkg==
X-Received: by 2002:adf:f584:0:b0:367:993e:874f with SMTP id ffacd0b85a97d-367cea8f98fmr7195391f8f.34.1720760420550;
        Thu, 11 Jul 2024 22:00:20 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde89198sm9143958f8f.60.2024.07.11.22.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 22:00:20 -0700 (PDT)
Message-ID: <74fd5d7cabfda98f578b5a4d4f4df1adba05ca3d.camel@linaro.org>
Subject: Re: [PATCH v3 2/2] clk: samsung: gs101: don't mark non-essential
 (UART) clocks critical
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi
 <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, Michael
 Turquette <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>, Sam
 Protsenko <semen.protsenko@linaro.org>, Tudor Ambarus
 <tudor.ambarus@linaro.org>
Cc: Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
Date: Fri, 12 Jul 2024 06:00:19 +0100
In-Reply-To: <0faacbeb-2ca3-4749-89a8-6dd81621a07d@samsung.com>
References: 
	<20240710-gs101-non-essential-clocks-2-v3-0-5dcb8d040d1c@linaro.org>
	 <CGME20240710132933eucas1p1b4367ec7a3938a39e732b3079eff6f32@eucas1p1.samsung.com>
	 <20240710-gs101-non-essential-clocks-2-v3-2-5dcb8d040d1c@linaro.org>
	 <0faacbeb-2ca3-4749-89a8-6dd81621a07d@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-10 at 16:35 +0200, Marek Szyprowski wrote:
> I think that it would be much better to check if earlycon is specified=
=20
> in kernel's cmdline and if so, simply mark those problematic clocks=20
> critical in this driver. Make this code hidden under=20
> IS_ENABLED(CONFIG_SERIAL_EARLYCON) to avoid polluting release builds.=20
> Any comments?

Good idea, I've found that i.MX appears to suffer from a similar problem,
and I'm testing something similar now:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/clk/imx/clk.c#n157


Cheers,
Andre'


