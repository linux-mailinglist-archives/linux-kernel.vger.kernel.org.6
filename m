Return-Path: <linux-kernel+bounces-252836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC569318A8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F211F228AD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04874CE05;
	Mon, 15 Jul 2024 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sHqCNBNa"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A997B481CD
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721061636; cv=none; b=PiuemGmRJEPBEfCNHYvnnxHrwJmYFOjEtOwTactUzLDAxWtXpcJiHiPwP07ly/5QbX0Y2rmt4PG052vLRLRpCx0B+srh2O0aO5meR52zBJ2t9mwzEUGtixO37ouqLasa7a2l3+A2ZAqxZB0C/433AUkQSeioYMsaPJ50Ggi5Q28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721061636; c=relaxed/simple;
	bh=9f8Qe6ie90wo/DDF464tuizO4E1SnfvAfFUf1QUmyUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BGoRURyI4pAeIJe1AKKmvS7o8BS3UmHQaWFppwso2VBFq28gfJq5ZI68WgCxutndCwMry8MPszMy9faDGx3QUW7TU4nvmsRsW1OBA3Um0sEV0t5lIYcU1/rqnAiIp/1fhGXIJXRIebzVf8Jd+pPPot6/O5f9g6tl+kr3rKqhKdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sHqCNBNa; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-65f880c56b1so21148557b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721061634; x=1721666434; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=en6+puohAfynQkBKEllMr8eQHTxPNgc5bkI+PFZYQQg=;
        b=sHqCNBNa8O1RqbaNGyAVX4Q28wVhrwLbZRT8aSaCHz7aQuXll2sN5miMFWCC8kCW73
         GIIUBweicQpbB8OX+2h2I8ZRzGHumUs+Bre0aQg7PKil+PjsdowX0vG7zHy6yw/JlRKJ
         BZDm3UPvY6TIKfBP58ksnaHI3S78qSUQMRGGQ3yn5EqkZN2YM50UhzDtMB1NeWBSGf7t
         CwhCKfta5dWORwXgwGR/3UkX86fm+Gbu3kMuN+l6vpzzKW9UZTyLeP2CyJ5i12xxg5Jd
         JVOHHf6DYlvfpw7U8obdQri4H46LGPKPKWQ0rgUwaUAUbdgnh52se+rgykvTZIsxPCpP
         hArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721061634; x=1721666434;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=en6+puohAfynQkBKEllMr8eQHTxPNgc5bkI+PFZYQQg=;
        b=Xyb6RnohCTbI8yrRclGsY1ni2CAe2a8qcI6mYZXGmzSGgzP+yvIfcK21UN4jgeDOvD
         SsQgvqoVUK+AP/Wq5xcS/ucof/8h7uDcud6gzr4IcgfKuaMX6AT3vroAMo5QK/vyDHFw
         2SeYlN8uxR7dHB4Hikjj1ekmBLD/67oU9D4H10McVjv3kVzpilSLkOPTkzl/dZh5jLu5
         WOKcoo0qkXJae+uPHQVYSsrX4cKSN4d86wRBrefBJL+E/DHmNUuF7GScM/YxSqQOhjk9
         Pcs+Vg3Gyctjzxl425S9/IeTTNwEPC35iE76y9uaL79c3RIE5yMlHzvd/pdjAJOTo2Ho
         RqVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlhTCRE60kKjl5nSkq3woOOsAOtLQUzEdWBgVEsieJwiwIbpjz8LrEClBhFIBhySh77UlsGfOgUcLyMgUEKFyKnBBRilkX4R4rQmrH
X-Gm-Message-State: AOJu0Yz/n1Fq8fUNZMJcKKgIyvJW/7LIe1dehzI6iRc3dcTfovH/jcH+
	xLa8wFLK6S9QA66DfjX5nrObhOG5YdvBJ+IuZATxZ1jR76qLkdwzy7Qhhi3SNoGGbDdVqOKgOi0
	sOOaNQYJPqbh/E9p0gXLuu9I9tb1jLBekFyARqQ==
X-Google-Smtp-Source: AGHT+IFv3aNlqZTAbfEk3+SJkAU1VQZMZYGpG/ZTnboW7SE4kuCdio6mZh3pytXItsiGKqcKgm2mh9g14iNQpuvfWas=
X-Received: by 2002:a05:690c:97:b0:63b:f919:2e89 with SMTP id
 00721157ae682-66353dcf097mr646877b3.2.1721061633716; Mon, 15 Jul 2024
 09:40:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715-x1e8-zap-name-v1-1-b66df09d0b65@linaro.org> <ZpU1vxsYUdVg9VGv@hovoldconsulting.com>
In-Reply-To: <ZpU1vxsYUdVg9VGv@hovoldconsulting.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 15 Jul 2024 19:40:22 +0300
Message-ID: <CAA8EJprKTm-FzDjUFwi9jKaHJ121W2m655-GN3DjzB9rSOpJ=Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: disable GPU on x1e80100 by default
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Akhil P Oommen <quic_akhilpo@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jul 2024 at 17:44, Johan Hovold <johan@kernel.org> wrote:
>
> On Mon, Jul 15, 2024 at 05:23:58PM +0300, Dmitry Baryshkov wrote:
> > The GPU on X1E80100 requires ZAP 'shader' file to be useful. Since the
> > file is signed by the OEM keys and might be not available by default,
> > disable the GPU node and drop the firmware name from the x1e80100.dtsi
> > file. Devices not being fused to use OEM keys can specify generic
> > location at `qcom/x1e80100/gen70500_zap.mbn` while enabling the GPU.
>
> Please enable the GPU for the CRD as part of this patch (e.g. move the
> fw name property there).

I can not just move the property, as it is going to have a different
value. I think GPU enablement for CRD should come as a separate patch.

-- 
With best wishes
Dmitry

