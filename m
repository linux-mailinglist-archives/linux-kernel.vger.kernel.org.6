Return-Path: <linux-kernel+bounces-347379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D041998D1E2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4F11C21849
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE7D201242;
	Wed,  2 Oct 2024 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZclqHa+H"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE81200139
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866808; cv=none; b=UUvA/5QPQl5fdQ6PV1Nj0Vuv4gcdWIjFZj5T4uJkwId5WtpnIydbzayvhp++TgS7AuJTBLz7GBtTHPjJa3dz3nAPa/jTQspT07p7Px27q6FANJAbVyJ8TAuQUV1tOVTC9FHX/lvBhDt5fzdxRzWuCfyTwWX2RlMQp5lGvetBNpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866808; c=relaxed/simple;
	bh=PcrWdbduYxZeMb0YqP69rh1ZAPaHmW5lP2887js9ovI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gbbsn/3euHMeJAUH6dLyyPTdd83ov8f0/J6BKXPxU4ZvVzvrNJ4K8xnaHg+jbvGdAbvIlzGTrwyKX0aL0Eh4kfd5GowBY4PkNMIXV2fRw8Qc+JK0TNnw4uzClppL6SsrMzbpr9iMQS4sDdN+eWZZCMjY/mIXoxiBtpsiuFHwLsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZclqHa+H; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e05f25fb96eso6054896276.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 04:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727866804; x=1728471604; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vqnwKXMtIPuvcjdLi+y6QFMRS5xvKxcyBVOpz9PIUOs=;
        b=ZclqHa+H1zINNbkQKDCsfby5e2TbHpaQTKh81t3q9+VTQOm0GTB/yB87ZS5xVH9Jge
         IJsvPdGfqjbu0AteWJ789ZrMI9ge5hS/7cCyw21imRBgSWoBaVeT9zpz/BFEAXenhUxh
         2vUd2zbXkXNRfQIJHJ8YhCjilXdbcpXLIzz7eyzpVaGRq7zlm702Anku4x7DcYR8yGkG
         CCPppspyzuu0dw8uLyZ2fRioG9rJ4FiTGXNAemn5mdITD7UJJ1QTiRa5pGmA3cjzftQl
         CkiEuFLQJrRqifSrET3kBkfmBQL0A032a3P76o3cq9dqzZl3IY+QkjgHCt3otKn4tn4K
         f/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727866804; x=1728471604;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vqnwKXMtIPuvcjdLi+y6QFMRS5xvKxcyBVOpz9PIUOs=;
        b=jRoDVaSq+7zRMM1X7TOPmJS5rH35blb1R5cpKKp2vaiTR8bSiHF2wlBbYXI3Rk2yp4
         H9HphPBr2BDLxE+cMJeLBPsTaWvCquoGqPPEzDqvorXmgsYFeTFin+Q5+BgK9+6WqiQh
         TGgBh5wGmPnHbylPGRIQVstES/DGt7RdbB3sxqU1YqoaHS1f6QbCRpPxWf+oT5BqE6Jf
         VXtHg0cIjZ3XueAlaVsjygnk9TZGif2UBHIOwB44t9ip1kcQnI35J5OUCNtFGzLz58vh
         Ozki4OPe5hY8GH+uTLV9WW8k9nNfijcTl7qTs3ch16tXsprhN5cku4MSjd3cfeepEBUd
         YvSw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ+PPER9/cFA2yrecWrRAtuPwbIwQVD+qQ+VZume43yHX1AfWX4X/xGeNWPqLZx4bQB3InPqk5RaEgwko=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqPqGPgmr0SSIsK4STQ8L1UmzQX/Bu/RR5iUZs2yx3WpRi77EQ
	wFVs4iPkPXAJaGNvrkCX4UbwdPuaT+LJs7a8tdX+0MxjcR8Z15F/FFjO1LcnPHClPqy66cHaPcr
	Uzf26v0HdXq3zwlJhGkkuHtMgXwHdSvEpjRlwEQ==
X-Google-Smtp-Source: AGHT+IGgpG+SeCoc89v9XXZAV+0OdGnBa1rr8GBqp7ZNHU2T0IKW4tijQJBHMruJay+8D5hiheKAuakS+Pmfcp7B/3o=
X-Received: by 2002:a05:6902:1a49:b0:e24:fea0:f9b4 with SMTP id
 3f1490d57ef6-e263840fdd3mr1985992276.38.1727866802706; Wed, 02 Oct 2024
 04:00:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927-add_qcs615_qcs8300_powerdomains_driver_support-v2-0-18c030ad7b68@quicinc.com>
In-Reply-To: <20240927-add_qcs615_qcs8300_powerdomains_driver_support-v2-0-18c030ad7b68@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 2 Oct 2024 12:59:27 +0200
Message-ID: <CAPDyKFqXNC41VySryugwg-BOObPEqtnbyRZcR8NXj2R5tNPqfA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Add rpmhpd powerdomains support for QCS615/QCS8300
To: Tingguo Cheng <quic_tingguoc@quicinc.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, kernel@quicinc.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	quic_fenglinw@quicinc.com, quic_tingweiz@quicinc.com, 
	Shazad Hussain <quic_shazhuss@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Sept 2024 at 14:00, Tingguo Cheng <quic_tingguoc@quicinc.com> wrote:
>
> Document the qcom,qcs8300-rpmhpd compatible and add power domains in
> rpmhpd driver to support QCS8300.
> Document the qcom,qcs615-rpmhpd compatible and add power domains in
> rpmhpd driver to support QCS615.
>
> Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>

The series applied for next and by adding  Krzysztof's ack on the DT
patches (next time, please carry them forward when posting new
versions), thanks!

Note that the DT patch is also available on the immutable dt branch.

Kind regards
Uffe


> ---
> Changes in v2:
> - Rebased patchsets on next-20240927.
> - Combined 2 patchsets into one to resolve merge conflicts of touching
>   the same part of code.
>   - Current Patchset
>   |
>   |->Patchset 1:https://lore.kernel.org/r/20240920-add_qcs615_powerdomains_driver_support-v1-0-8846efaf9454@quicinc.com
>   |->Patchset 2:https://lore.kernel.org/r/20240920-add_qcs8300_powerdomains_driver_support-v1-0-96a2a08841da@quicinc.com
>
> - Link to v1: https://lore.kernel.org/r/20240920-add_qcs8300_powerdomains_driver_support-v1-0-96a2a08841da@quicinc.com
>
> ---
> Tingguo Cheng (4):
>       dt-bindings: power: qcom,rpmpd: document qcs8300 RPMh power domains
>       pmdomain: qcom: rpmhpd: Add qcs8300 power domains
>       dt-bindings: power: qcom,rpmpd: document qcs615 RPMh power domains
>       pmdomain: qcom: rpmhpd: Add qcs615 power domains
>
>  .../devicetree/bindings/power/qcom,rpmpd.yaml      |  2 ++
>  drivers/pmdomain/qcom/rpmhpd.c                     | 36 ++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
> ---
> base-commit: 40e0c9d414f57d450e3ad03c12765e797fc3fede
> change-id: 20240927-add_qcs615_qcs8300_powerdomains_driver_support-7cd487126340
>
> Best regards,
> --
> Tingguo Cheng <quic_tingguoc@quicinc.com>
>

