Return-Path: <linux-kernel+bounces-230397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C609917C3F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6DD28DDA4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65BA176AAD;
	Wed, 26 Jun 2024 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X80dcg1w"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9904916CD35
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719393286; cv=none; b=e9TnBMjmQ32gYmQRLUl7EHxccr/mHNx1lp8BoVBfXM0AoxfexqZQmqWfDpHL+d4H1esZosb8OdSnQzZU2d++tKkrSzNgRXlJcuYQy/Sn5HK3UTdhXXcmBmwWEt4wiN3Fpvdmu08pIxfZ1jkk/Y+RK/sV0RMysA7QdSyVXZzzohg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719393286; c=relaxed/simple;
	bh=CqAYMziyoNuRluoEnLOJXX4U9aYsyGmmCsxq79X7UAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tk1jt//0MkYl/jv7ZWqaaL8pji9bns4HuOhU2VEmAMQzK2EKfEbjEFq9Aa8xVkjmVO1msUHqxF+HXAr7Z/PTUBYH70/1AXEQaoaTWAOSoez0CGdpEJFnPop1kCELXb75kKOBGj2fp6N4eGrb2LyjwwHNHFvzwNoztQCpLWoUTzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X80dcg1w; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-444fdaed647so192331cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 02:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719393283; x=1719998083; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CqAYMziyoNuRluoEnLOJXX4U9aYsyGmmCsxq79X7UAc=;
        b=X80dcg1whLGJWvL9QdksAgv1mntYrW1ctcO+tSqfUwxdgGGyvUqO7/jUshFE2/6oab
         tAajfm80GJxh3jB/9yawZi9YwRS1x97zoYmObBv4aE0AmHtK59WbfIS4bNs4mINFqVB9
         Jh2GrGv4kOkuT1sHQc5+sYaGrgRDpIfZn3l5xCFy8gYnDf7ESJqovqMzBS+xJJv8xEUI
         b/VQ9Myp7tz8ohFcElAMaiRJ93Qmy5pbyLUy51tBjXG1pOY3kxkkIPq/fHk1jUTxexE4
         6LDH7KhuqrczDT18yVJg1qGG9yLQ39SSkaCxr+nIAuK2f3598xb0ehBxoc84GHRIGrNL
         hQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719393283; x=1719998083;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CqAYMziyoNuRluoEnLOJXX4U9aYsyGmmCsxq79X7UAc=;
        b=P+luPmId40i5YRpOHFF4liWXDlD6lI7Cl209sS5we3pQELK/fMRrra8Ey90SEkSI9o
         g34eCK+op8LqNNyWebp55XvFxExQHehx6PYH9/DY+/FUJxuGNHu7rQjafmmK9JiSPVI6
         vQ4n3cOxSiivj9YLdcwnw7gDe9yv3Dyqkkskds/mjvioKgTo0ZgfP4NmirqLn5Y26oo+
         DSveXgoVt9IxW33uZU1UzWZ9JXPq0WdzqpFHe4+EvJd8+Q3yIfv6haRxloOhVi2nOpDX
         BYVMstWhL8zezvqB+rImQQa+09w1kJvtnNOVsPe+J2O9dN1BDibpUg/nAG/FBsb1VLaT
         O8eA==
X-Forwarded-Encrypted: i=1; AJvYcCUQLuiZ1MgGRCpCZAk2em2FxD4hcr7ZkXqs2rbR38BkUUXjMtO6briceLP+CfKMNryvccSQxYQlHUTairQ8akgn3d385Rz32GGxdc0a
X-Gm-Message-State: AOJu0YzaOK1jcUjIqqK8MKOWSCLxBVUfTYWTle4Qnmf80J42TNlaZywZ
	VkPeog43FJLGcNd+sLJrVKtF4GxinnanOyF9juSVF5CG3hZc4RKJndS8wTz5sWdhO3o8bLNLqLA
	GyGCd7EdjM8ArXP2812umLx4oV/z8mIuTljzA
X-Google-Smtp-Source: AGHT+IHkOrgqoJzL15wN5VWNjha40DP90+u/qO+zEEscGdt+igLxMIgnKhcvFKbglDydrmGy1fqEppkFSUrU9cbE+jE=
X-Received: by 2002:a05:622a:58d:b0:43f:fbb0:b74 with SMTP id
 d75a77b69052e-44542568768mr1806941cf.29.1719393283332; Wed, 26 Jun 2024
 02:14:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626052238.1577580-1-aniketmaurya@google.com>
 <20240626052238.1577580-2-aniketmaurya@google.com> <e28ba03d1df1c0c5aec987411c40e44fc351ce0d.camel@codeconstruct.com.au>
 <c15045b4-2e5f-4fcc-b25c-76a5e4973e93@linaro.org> <b4ba5fa7834fdfb1a1e26ff0e01b9bb235de63b5.camel@codeconstruct.com.au>
 <CAMmmMt25nkZTXXLCVGv1baf3azQR0kwbM8LP4EzCQKOPLUhbVQ@mail.gmail.com> <d256cd72ef2011c3bfd045b04fb6509d1ac827e9.camel@codeconstruct.com.au>
In-Reply-To: <d256cd72ef2011c3bfd045b04fb6509d1ac827e9.camel@codeconstruct.com.au>
From: "Aniket ." <aniketmaurya@google.com>
Date: Wed, 26 Jun 2024 14:44:32 +0530
Message-ID: <CAMmmMt3DZWA734iFGLxz7cj+hYiWgq5MDOrc_UJpYeaij+yywg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: i3c: dw: Add property to select IBI ops
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Joel Stanley <joel@jms.id.au>, 
	Billy Tsai <billy_tsai@aspeedtech.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-i3c@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > So can we remove this selection of ops and always go with ibi ops?
>
> Sounds fine to me, but I don't have direct experience with the non-
> ast2600 uses of the dw core.

I am using dw core directly through Synopsys virtualizer development
kit(VDK) setup.
I think it should be fine to always have the all ops supported in the
SW as they are in HW.
Shall I remove the ibi_capable property from the dw_i3c_master struct?

Thanks,
Aniket.

