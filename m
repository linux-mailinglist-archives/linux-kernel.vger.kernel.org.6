Return-Path: <linux-kernel+bounces-402453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6159C27B9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12B10284564
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 22:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033681F756F;
	Fri,  8 Nov 2024 22:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hUaSoy5y"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A66233D8B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 22:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731105920; cv=none; b=Q0wcR437BMKwx2nIg3VntuJ6GgwwbIKZkdmsZ60AQ6qpZMCyk8L4I3i3tKDKO2FJ4pM6fBK25ERqNaJR6uI0hsUC5WIjxTATutLC6DUh4NtA+Ebj2bBdqTf/cTdD/hadQzAE68cLS2nUJsTqFUSS1Jt5f0e5rLI/mBiNTP0X/XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731105920; c=relaxed/simple;
	bh=BavrQDFzzrlWgiT5B+/qX43by6uGDYlkSI/1UzJVLrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uoviEcxa5b8lBudsiHwzSIzW0B6G2pQ3NAIUhRhQAz56jE3ZyC86KpvcCy7KCssH75OjHw+9XiylD3xFLhJc/+3z7nEWIZV9V/DUlaboNLS6NePYuD6xF3M9/cgg4WvxkaXlyCIi6HA012+h1Kxq2XIB+YOhClYPCGutBOCBYc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hUaSoy5y; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e2974743675so2545242276.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 14:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731105916; x=1731710716; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ufwDKW4XcMz+Ec+d5o/acjOdG+Dxgj/1/6CBL/TRtWA=;
        b=hUaSoy5yKV85TISUxaGNo5VrQXqn7i+KjH41VVIRlmgW1urUWNDWE5M+rYlMRHMEgK
         kJdzB7n3f0AA4wn4vrig0Yo5Nb/gFSyg0dmuwAAsf8lDzsOhUlElQba4iIJFQ+JwuR3J
         W/betgFDoJ9RbjZNm3UY1ct4Er5zx07FeuUM+y9ul00xdY5WQhD0XeoVnTD1CUVu8jch
         dUwuerfL90G85IuKDcmKc4xDuAIsSWk6AdmJU8BM1w2F4xTpOocHnfBvv5w3oFm0mnqG
         48q81Oj5m1PPUI91TuSa20jdmtsZERSO9QX7O7s0teA+aY6kBRY9MaAtiKcx+7vtF0Cn
         NMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731105916; x=1731710716;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ufwDKW4XcMz+Ec+d5o/acjOdG+Dxgj/1/6CBL/TRtWA=;
        b=CrdNFuuleSDAEA/VpsHI/v4rlaWC15vQDcVcrjQAMX0s9ZBFqwea8XJ1G6lhxwsnZL
         5RYqAMl4cw5sCpvoA9Ev5gF3ZFWwwx34C068B/lSGorBnLKHwypKLQPI1qVRY9T5bk9H
         fYVABjbK9+IKj+9JnJh9QF9wM+XgekT3Ee6VcQuHytZRU/27MgYnG9edWNGFZMVRf7RI
         2DgfK1BBCwQWCXQKW6Xq2aviwAYzSW2P/Dhv3teIvR3HlxiDr1XW6JRD8GxKsmpPyI94
         2u9py50IwPfQqhgFGETbyEZ5dolfiEm57yGzmQCa/zcH7WFld+qRpyop6z2vPqwFB1Rd
         H18g==
X-Forwarded-Encrypted: i=1; AJvYcCVpSkkcT0A3UKxxvsBLcc8HwfwI7LuIgM1s83RcWoWPjx9TTu6jwTOYBcT8a3wnI0370JOH4RdR+e5dYV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrMu3kkbS93faLLrqYg1CUxr4v+GZvloq0DDIuPNerrHk8iPTt
	cNPh14Sn50JJ/uRM0ykF0l3Cuex5KpwuWfzBrmATwX4hLfztgC+ShpusFBt6jGlt9mQ+kFGbLdZ
	gJ875JyZM3yBVCjPFg2G/BD4iQ50bGXOOr7vGXQ==
X-Google-Smtp-Source: AGHT+IGVMMFgpkuR2thRDPZH1iZPEmk+lLe5r7P6Ak8vvtQs8OAmlyimK84GVoy6TsHBmPtnknQukf+VH133Ykjo9oM=
X-Received: by 2002:a05:6902:18ca:b0:e30:dbda:de2e with SMTP id
 3f1490d57ef6-e337f843d3amr4784672276.2.1731105916544; Fri, 08 Nov 2024
 14:45:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017-sar2130p-pdc-v1-1-cf9ccd9c37da@linaro.org>
 <t2trcojqskryzbuh6cbuqev35eioduarneskwtcm5aeeqlvbkv@3kj4x36ebkqk> <20241108211322.GA2849214-robh@kernel.org>
In-Reply-To: <20241108211322.GA2849214-robh@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 9 Nov 2024 00:45:05 +0200
Message-ID: <CAA8EJpp9Q7ZH3fdMsVgznp-xwUVN7EyrVPoPVRJ0Pd9Po7Anew@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: qcom,pdc: Add SAR2130P compatible
To: Rob Herring <robh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Nov 2024 at 23:13, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Oct 31, 2024 at 07:34:41PM +0200, Dmitry Baryshkov wrote:
> > On Thu, Oct 17, 2024 at 09:13:01PM +0300, Dmitry Baryshkov wrote:
> > > Document compatible for PDC interrupt controller on SAR2130P platform.
> > >
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> >
> > Gracious ping, the patch has been acked by DT maintainers, but is still
> > not present in linux-next and got no other reviews.
>
> Applied.
>
> > Krzysztof mentioned that the patch should be picked up by Bjorn, but all
> > previous patches for PDC schema were picked up by Rob Herring or by Marc
> > Zyngier (and one stray patch was picked up by Linus Walleij).
>
> My preference is for it to be applied with the driver or dts changes.
> For standalone patches, I only pick them up if the $subsystem maintainer
> does not.

Understood, thank you!


-- 
With best wishes
Dmitry

