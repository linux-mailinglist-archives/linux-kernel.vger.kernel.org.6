Return-Path: <linux-kernel+bounces-439681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A573B9EB298
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B056188D87A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E881AF0A2;
	Tue, 10 Dec 2024 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V5nkgO0G"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642BA1A2547
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839352; cv=none; b=KmQmpXsBjPH435Uzvha2ls8uUKcuDAUeSU4UOvGPMckYKt4MRh9xcm1JlRanwh8syO1M954RFkSvwWow5EGsGVxzhPHps9veb84AvJtgBRg5j8uEeu+YdQ9LDVn8RyeBPBUuPkMgo5fgYCV40IzKzERmTXSWPnmDCQJexv1C+Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839352; c=relaxed/simple;
	bh=+NFuZPYZfV1IZRwl655w+8sEEBWW/ztxjjuLMrHJUiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAP6J7A8GyT/OhisW9dge//1QfuQT0jBxCzAnFckRPgAc/S2QzrVlRl14MKMYodhuGZ7X2NvcdHfQiK6sxWOjCfFlJ5tx4ReIoY4z29ejkVUi5CPFks49RgJCpLAmGOyODj5i0a5JTsm2mUtIhsBD78sfP5aWWbnn8UZQnncLYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V5nkgO0G; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e3a1cfeb711so2540040276.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733839350; x=1734444150; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SvPPl8qwVLJcu5oGibdh/vSg/TfeueL6no5HldX5f6k=;
        b=V5nkgO0GthAETk+jpjZWVGIF0wG2rV2zEGQYSYdPaj27p3tqeZYme3hfCEUpRrKmrD
         cldxLGJb7hPrjJxMR51R9N8shyBfntGFLcX6lZxRUYDPB41/rJ4agRflaGf0ODi1jnjA
         wOKBnmWE2ZzfZyUmc1Hubz4qae6QoqQ72ao25ZiDQlwrgBKDkNuvUUVpewiCTeAe5yTP
         s4n6YGphS1Gh5e5fDvBcKScelReybNpg3n20pkyRjRcKQm5K3/NQNpG9rNLbh75vpc3O
         RHKUGPA+qySOzRB5WJh9pZn+6rl84UvHYKebsmppA0m7OG6oM/Sl5XLXavSRRmM+xy+P
         mL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733839350; x=1734444150;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SvPPl8qwVLJcu5oGibdh/vSg/TfeueL6no5HldX5f6k=;
        b=i/nzKfVrzJnfCgwsbO/QKhvqWXzEtprTzMg3X97wXhpIyybgASnmQl5QCDOucJ5E+T
         Zt4CrQ9Iro/G5U9GvRG3pRtvC0GTtQ2f/8yIXenlmLs1Wf4Wf2fyeuz5zpNrNMWear5B
         lGOvLPt/4GdNZkL0khxKX9L6zcfmujR8TQ75vPWVJT+X8GgmoNMZO4DAl++fEXoUTpY5
         /AX0IlDWCTxmNeOa8nZylVg1tq2hF+nOqAepjSP+PaR7U6K3aiXVPvu/pRE8IIww/e1m
         QAtb2Of4PUXMIewn+plRxTroMMYE+VTTAZjol8+s2OHBdclgmKxffFaI5kBAoodg/V6+
         Dxwg==
X-Forwarded-Encrypted: i=1; AJvYcCXgnUmzMhdGAgNq3JhTkU5XGoMv7s+CBEZ+OkeJ0axVA6TUCAPRLaQqytyqxd35CuwygyZCMMMHfT5zAp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlDoRY0dx8dWpecknb9WHBC6n3vxcncsb4dUFlaBTmI0lKeycI
	YM93pRGQJnB3mpTew11ByoR3pSBzz2IicMhTNo5zQ+4WbeLMbalDyKVS7t1Jmqn1uPm7BlL5Z4I
	je619GD3bi0gcGci+PzzYF5BeLrCZ0/nhPIVS5w==
X-Gm-Gg: ASbGnctSRoRor8q2tLRJ9Ji9aYZZ9fnX6emBholsaFCOHSq/6EZ6cHxQvAOsYArkQBJ
	g9kPHMxQ8CUgZ3/AP523cQHd98y6SnukhiV3l
X-Google-Smtp-Source: AGHT+IGmKaNpYBq9hHMjYVpDy/ZFedVuxIxnC/8Szgs06mRME+vwqHaysBmsEf6kl+XmlfJPpFjlh3TT7s7p8aYdx8I=
X-Received: by 2002:a05:6902:20ca:b0:e39:8992:57ba with SMTP id
 3f1490d57ef6-e3a59acdf9dmr3350460276.5.1733839350074; Tue, 10 Dec 2024
 06:02:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130-topic-idle_state_name-v1-0-d0ff67b0c8e9@oss.qualcomm.com>
In-Reply-To: <20241130-topic-idle_state_name-v1-0-d0ff67b0c8e9@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 10 Dec 2024 15:01:54 +0100
Message-ID: <CAPDyKFrQ8EJPg+EDtrTmxy6W0mnKip2GjOH4JeLwVAGE_3Ao9A@mail.gmail.com>
Subject: Re: [PATCH 0/2] Allow naming pmdomain idle states
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Nov 2024 at 17:39, Konrad Dybcio <konradybcio@kernel.org> wrote:
>
> Inspired by [1], add support for naming pmdomain idle states.
> This only affects debugfs output.
>
> [1] https://lore.kernel.org/linux-arm-msm/20241014161631.1527918-2-robh@kernel.org/
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
> Konrad Dybcio (2):
>       dt-bindings: power: domain-idle-state: Allow idle-state-name
>       pmdomain: core: Support naming idle states
>
>  .../devicetree/bindings/power/domain-idle-state.yaml      |  5 +++++
>  drivers/pmdomain/core.c                                   | 15 ++++++++++++---
>  include/linux/pm_domain.h                                 |  1 +
>  3 files changed, 18 insertions(+), 3 deletions(-)
> ---
> base-commit: f486c8aa16b8172f63bddc70116a0c897a7f3f02
> change-id: 20241130-topic-idle_state_name-e119caa0069e
>
> Best regards,
> --
> Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>

The series applied for next, thanks!

Kind regards
Uffe

