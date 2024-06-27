Return-Path: <linux-kernel+bounces-231775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 556E4919DD5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 05:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8356E1C2193C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 03:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76A7175A6;
	Thu, 27 Jun 2024 03:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lwC5zb/8"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BBE134BD
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 03:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719458776; cv=none; b=QkdmCerJ02sWxDNl7sIdgQ0GFm7iTIhRfPy17PK83cw0htQl05pEvx07CqAWRGFkRJYz4CFL2hCzkesTNT+YBIdIC7gwoi3K5jg3Gr8T7S1En1IUnJyxlRrVIEZb3dFsBpUC6Hnt+0qi7s2v82h2dQOZZLgtdPfWmAEQyzIVjhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719458776; c=relaxed/simple;
	bh=uvR+0Gq+x6k+bBQoe6kzaG9QWJVAkKlY2L6BoK1ipuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dr2UHcmC9KifPFHYwsyPE0pZkZCCjFGxLKZN/EtW/fYC5IRpFCJboKe2lOb9vMToY5eQtqjfGSsNOkNQ9os8Gl+rgkbtJRWPXVtyUzHM3tQ1nze5DGNAl0p+yARnYm7Jm0ZwXrHWUDXQ9yfcYEZOE25VSExeT8XD+AMRzbpyz4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lwC5zb/8; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-444fdaed647so115251cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719458773; x=1720063573; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uvR+0Gq+x6k+bBQoe6kzaG9QWJVAkKlY2L6BoK1ipuc=;
        b=lwC5zb/8qVBLn+WGpyF5MI0w7C1UhP/wOmL1+tOQPikQ3SzgwRBWRu1olgXwt3UCm+
         Kn6R7/MrsQxJODVNQMl83+BsFjcZ7neXM2T2w/NO13CVvsomrHEPfJiBJvjnX48M9zxU
         PD+84l+HVn4BEtHL3jWJzA//pafK67wODeHbrniXo/MwuK5vYyRCY++R8S5db9vTgE6b
         KZZVFqtmm4Wcsqf5XafrtST3TRtZa4aLnhnMtydN7KJ1rag+QefSzZoCPv4XJ4CMWv2s
         dqZqh5V0W5pJuK8bxt1ngzVev/ODlu7CsDaxM/k0ZY1aFpprWgBddZvSGNteBLa6TUo1
         N3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719458773; x=1720063573;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uvR+0Gq+x6k+bBQoe6kzaG9QWJVAkKlY2L6BoK1ipuc=;
        b=YhGpAod9dTVYQSZtNWcLbHKkpc4kqiF3ipJlegDZ1o/0mPZw+bCEvMgdkMIX8cN7py
         rFBrIV3eyStlaXu75lIoa/fpzG3BQ0bqcafSipw8fnHX5vrUYkdJp1QNPvY4nti5oJi6
         IFRRLnbDX6rbjwF8JAKGNFRKLL/lg02V3s1y9VM8f0jOudxL5N9xImOg5b6qLubP3aw5
         0dp12h2aiBD9Ti/0X/YbE/4HWMEpXmhgm0zEH9ZP0DGUADHlc/kG/lv4AN/vd/sdWtV5
         P3n4IyS5AQB/9H+K6Ct6e99bh7L+vwbyLdKODTzwu9a5g3ROHLf473BnTduIdLbAO/jO
         uELQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYZTrNyA6Ihhv4nCqDTd4QIT0BYO0f/I9V4sXFy8rgJVRwaT6CwysfG8TX3nhhFe76/BGRlLSEZ03gpvpciNzAmbdZcUu3vKW5GbXf
X-Gm-Message-State: AOJu0Yy/IocvSHp6KBlo4Ylu7pOTT/7CnpTNX5ZLMeo2xUi1IIAv9Xu9
	uMOyUG0+MunMkQ2sZm3uNItuTfpSDpVJz8JM0OMGMmV3UIE9rBagdwB5s1mVjUEHGYjXy2EBMjt
	1SVzvMPrXCnBhgmNgQnDSmLTstKIvTAgFAJqc
X-Google-Smtp-Source: AGHT+IEQMWhh3nV9aez5d+6ni2K86V3OV0VRneIw7UhPzOP7WPGwPZT/EkagkQCNPUx6DvrcYQHDIAVWnJp2vdk7Evs=
X-Received: by 2002:ac8:6bd6:0:b0:444:dc11:6980 with SMTP id
 d75a77b69052e-4463fc66b03mr1309801cf.1.1719458773311; Wed, 26 Jun 2024
 20:26:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626052238.1577580-1-aniketmaurya@google.com>
 <20240626052238.1577580-3-aniketmaurya@google.com> <07911285-d01c-4456-861a-825c1e9d65cd@linaro.org>
In-Reply-To: <07911285-d01c-4456-861a-825c1e9d65cd@linaro.org>
From: "Aniket ." <aniketmaurya@google.com>
Date: Thu, 27 Jun 2024 08:56:02 +0530
Message-ID: <CAMmmMt2K9H7WQ53j56kPSiZU+EUfCD0u_yBiyi8vaS4g+iHt8A@mail.gmail.com>
Subject: Re: [PATCH 2/2] i3c: dw: Select ibi ops for base platform driver
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jeremy Kerr <jk@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof.

> > The AST2600 platform driver can always select the IBI ops.
>
> So it is deducible from compatible.

Yes, you are right. It shouldn't be a DT property.
Abandoning this patch. I'll send a different patch to always have IBI ops.

Thanks,
Aniket.

