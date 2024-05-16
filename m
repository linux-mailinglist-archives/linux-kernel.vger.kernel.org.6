Return-Path: <linux-kernel+bounces-180666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1B58C718A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCC94B22A6A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 06:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9295282ED;
	Thu, 16 May 2024 06:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i81RDg9O"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A4B2576F
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 06:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715839339; cv=none; b=eOyA+Ic8HudD4XakKxmKb6dEu8AVkuU18LARJkxYzZjxqk7r3wfAZgs5bd/yV+RxnUwGIu7nfDUo02pMdMl0wLLKu2W3qGoBLbg05VYGExrEMlLhKNLN0WCAdOHPqsS+L6868aOyzJC51w+qLSLskPhK4tLyR0plEEfgd9Cn3Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715839339; c=relaxed/simple;
	bh=fMxF2StVs/M/aaHNKTnKzRqFLg6CcU30ETa1Rv+cqko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+HvuLHja3wvZWk+IqmzrL4l60EvsOe/gtM8pkEBFd/ZgOr4hKFbOqMARur25AoCaqiCFSJrGBTEbgtkC48e4krcfTQ5CzHB3eGmv40MO/AgtKeRYIBVD66eKBgVc2r8PiNOl1KKWfqHIVNUP/dFviUnK82iKUUA9pbi3avAnog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i81RDg9O; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-df475159042so139787276.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 23:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715839336; x=1716444136; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fMxF2StVs/M/aaHNKTnKzRqFLg6CcU30ETa1Rv+cqko=;
        b=i81RDg9OTTrg7eIrBpaSUCZiDOcu38wt8Zv1o+2K+ZMatMToc6xffHXt18uJxr6qMJ
         p1QXhloacffi41FpwHKM4DVn369p9/+c9F/6UsIClNGFL03EFcsGDYi3EmhVHqJwZVTf
         IXXtH5h/39DQ3JYECUmwYl/iEUokAb7S4B0JwpyqbJTCQsmNyfw9iNQWQEpdntJO04eI
         pzF5O0EADRR7x0byW7tx+I49uzPjepNcNuQSkAv3h+9sFE1tqSEXdPoD3KW1q2srkEsa
         YjxVMX+2C6msc5bTvo6LM/ewIKDc/q9JzMWsZ4mNzY0q7zMvHF7xoFzCLxiATNZuwiF9
         tN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715839336; x=1716444136;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMxF2StVs/M/aaHNKTnKzRqFLg6CcU30ETa1Rv+cqko=;
        b=obtx7VhGlLlLO1qEOHbPS5BPmxSXJA+3j1D0NpScgFp9ZLuH8t3wUIcKaKYPE94j7u
         naX/pSjxESz5GieSCVfXb64GTWtRG5Jiv4V1bfAm508GRFRzkPgup7dMYoI+hO6sZiN9
         cKCvGSMi05zRxrMmiFnzwm0dyheBlidi26ypU29yvWmOKQ5K0doFLXmTPewwv4HeU9jb
         24v8BbpKr6UG18c711lLsYKO/a37Si8Ltm/w6xJLztG0OfqEh3dqVpeegLHuLJiimt9Y
         qtKnY3JKfby4bQZm6yinifzwDoV4g4+H6a/Gc6mbltmX3QPju0sXqTthMw22LJIp06Lk
         vxaw==
X-Forwarded-Encrypted: i=1; AJvYcCVBS3pRWArxbTSuy1jMY0zg1uyCyK9bI3sWxr8pXEPX0lgjg8koz2yRIKH/VP0WRP5v2dVZaJmXPYpzbfUi5Umr4olxsUY5mqPlxvCx
X-Gm-Message-State: AOJu0YyN3sN/9fj5wcPzT+iJJfQri8D5mq9FrIcZVjJ3r6HNhzGP3Djz
	4bc9PJPDikdQLACxSPJ+ZWRm7AC0+jBrvd6TV4rIWFsZgQdbBdn2zR4OJlkU+bAFRlwhMuyhuco
	fhcwLeQvhwu+M5BSAAL7h34sDj2Wt77XvyJ65TQ==
X-Google-Smtp-Source: AGHT+IHQRhJ5WdipOlFEPTE2IXtjwpxOJIa3F6UInY4NKv3hR6EY4LO3bbTRgZIjq/P9G1VVfPyvex/Mx0Vhj/yz1NA=
X-Received: by 2002:a25:f505:0:b0:de6:d0a:ee3d with SMTP id
 3f1490d57ef6-dee4f1b7a13mr16047733276.30.1715839336505; Wed, 15 May 2024
 23:02:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515105446.3944629-1-sumit.garg@linaro.org>
 <20240515105446.3944629-2-sumit.garg@linaro.org> <131345e4-7920-428c-85c8-0fc4f56ca84e@linaro.org>
In-Reply-To: <131345e4-7920-428c-85c8-0fc4f56ca84e@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 16 May 2024 11:32:05 +0530
Message-ID: <CAFA6WYO1r5VydNo3VkdQY4yrC9ppL3-ou15i=GOgaQtVvSw0bQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v5 1/3] dt-bindings: vendor-prefixes: Add Schneider Electric
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, stephan@gerhold.net, 
	caleb.connolly@linaro.org, neil.armstrong@linaro.org, 
	dmitry.baryshkov@linaro.org, laetitia.mariottini@se.com, 
	pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com, 
	benjamin.missey@non.se.com, daniel.thompson@linaro.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Wed, 15 May 2024 at 20:08, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 15/05/2024 12:54, Sumit Garg wrote:
> > Add vendor prefix for Schneider Electric (https://www.se.com/).
> >
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
>
> Please do not resend regular patches during merge window. Nothing can
> happen now, no one will pick it up, so probably you will need another
> resend later. This just creates really unnecessary traffic on the
> mailing lists.

You are right. I suppose the reason for my hurry is not to miss the
next v6.11 release cycle as the v6.10 release cycle has already passed
for this patchset to be picked up. It has nearly been 6 weeks since
the original v5 patch-set [1] was posted and not being picked up even
after it has gone through extensive review. I am really failing to
understand the missing pieces or any unaddressed feedback to get this
accepted.

However, as you have suggested I will resend again after the merge
window closes.

[1] https://lore.kernel.org/lkml/20240403043416.3800259-1-sumit.garg@linaro.org/

-Sumit

