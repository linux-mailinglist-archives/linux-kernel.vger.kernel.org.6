Return-Path: <linux-kernel+bounces-222077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE20F90FC8E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D58284E0F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 06:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0743439FD8;
	Thu, 20 Jun 2024 06:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bQ6ESW1i"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016AF37E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 06:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718863959; cv=none; b=JpDRkBXyyhCEOVMBAZUlNLV8iD8trh87eGT7SV+9+xcWvFqUCVDS3qw0rcXlku3fTVgQBr+HyJ6xeF+g2Iw6jJ3nHHSJo7vTLaKhez9RTfJc2C09RngUJ9L0/Y9dFYfxjEp3NzlEU6sSjz4NfC0TkxukKgxE0EIvYIwB924grk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718863959; c=relaxed/simple;
	bh=Ujzo3gQITrG9jyah8JaPR0BBgm3LCxgvrnBzDB3jdY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BTSQA+tMM58e2asmgRKdgAgHkCJYT5AhyEE36G6ZDQ6l+N9auXS2zqLq01DxrH++fNAA/OL40XZCNauZ07M+I8HPsteupLI5nbRhisyGHch3rVFh4zik6I6WRMew/uFAORxDh8fzzd8gNUKBh93TMZPSePVACbEzhKPbKBMGWds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bQ6ESW1i; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-443586c2091so678571cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 23:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718863957; x=1719468757; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6MDp6Gu1dB3kA3pFusfmm/YJymGwGFjMgRsVqOFAv7U=;
        b=bQ6ESW1i2MjYncPA5eJ0H71YdcvQ1iw8n5vW7vwoyAGPU6Y1Uq1nHooGo3iQwkAS5Y
         rIYAdEyKrW1I8J5L+WmmwHoz1Ltwvg9566hM4Z0lZj0RF0V+edZaT/UesNaNOA3y3PhZ
         SBBjU017ZE3WouI/yMidOd06kO+npy5cQTuX6Yn42Cw5uBdaYo0b9zeLbfZiMJtiicxw
         sTl7QTjvDFNSV8VfPljsGNqg322Ct27+1D4QSWt3EHfxUd/lGEOp2xklcRRWSMb31Dbs
         aKN3CdlokR4ylNSgT/u8puxdv4MfoK5OshXbfzSastzITyPmw+NORLqHRYOGa4pgIdwa
         54ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718863957; x=1719468757;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6MDp6Gu1dB3kA3pFusfmm/YJymGwGFjMgRsVqOFAv7U=;
        b=rU7l7/mJjiGUgVzeIJ3Q4+CfaUZNX27F9oGw1CZT/oyHgiAmhL8yBYSXcsGIKkZaY+
         Gq7xLlagn1Clx4oLrZu7nLqNDOWG0hMLACcbwgHdY9tvCO42lEW0gIvFxsfk0AfJQukU
         xUCkMxCef2b5uz3DfUEeW4MpH32ImwaNqMYjMa3GKz2+mU+KTC93cvFN8Ci+V2MKHKxW
         hbYe6fu6dIG3E8uWl8q/3zjcnF+uVEIdQN+4cz4vu86cV8+csj0zPF16QMOCqSC+GN7U
         K7zg0FYjfde5sUEV/D39oUFd7J27I1oHo/PEhjesOVI8DtHWiFd5a9Bh0+BDo/pgjPFM
         1caA==
X-Forwarded-Encrypted: i=1; AJvYcCU+zwWc539K4JELXhTO37RlVAMAKQf+NHcVUDZIjVD3ETSNwFPviQ9pAEFPvvNVl36JNCUXzV98F6TRHxSMsYeZf8l+M1DoZE74mHJq
X-Gm-Message-State: AOJu0Yyp8nDbrkpckv6etWHqRBbmvtr/BPzLhlhEulrd+98WMI0cOVsK
	TZ59ZpYV/J5OqxK0p+xSVkLhNKUqhz1X99ODq3XBVbICMV5bPwyxmMKyftpF0Lg7fHF3AQYTCIi
	6drFXyS1j0yCbLSdk3n/NTgqlmQUjoupqH8OF
X-Google-Smtp-Source: AGHT+IHNWwGYLve/6F1QWlvTiTVYGmQ4H8cLjWmI+lXR1LrdOwVRPseIr/mca32BSn0Ip3ODypzRKhOpFo2sA5ibuss=
X-Received: by 2002:ac8:5708:0:b0:442:172e:4dd2 with SMTP id
 d75a77b69052e-444a902844emr4894831cf.18.1718863956650; Wed, 19 Jun 2024
 23:12:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611171600.1105124-1-aniketmaurya@google.com>
 <20240611171600.1105124-3-aniketmaurya@google.com> <202406182005584f0deea8@mail.local>
 <20240618200932858a6e40@mail.local>
In-Reply-To: <20240618200932858a6e40@mail.local>
From: "Aniket ." <aniketmaurya@google.com>
Date: Thu, 20 Jun 2024 11:42:25 +0530
Message-ID: <CAMmmMt21TAH3Vp8axtY9PoM0K6gzQqtMiHTaNGXKPW3J2DJF-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] i3c: dw: Add optional apb clock
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
	Billy Tsai <billy_tsai@aspeedtech.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-i3c@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hey,
> > >     ret = clk_prepare_enable(master->core_clk);
>
> It could be worth having a look at devm_clk_get_optional_enabled
Do we want to use *_enabled clock apis for both core_clk and pclk?

Thanks,
Aniket

