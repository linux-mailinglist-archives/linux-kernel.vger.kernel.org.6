Return-Path: <linux-kernel+bounces-207716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CD4901AC2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1941F2405D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 06:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC9E28377;
	Mon, 10 Jun 2024 05:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="K5yNUOcG"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF19208D0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717999038; cv=none; b=uLfBYYv1cHdfz+7m/wRDjuzfPHVspAis49HGHiiZELsiqZI63dNx2t53qezX1NxbhpDOkDE87jnc3GBozBcwh1zn+hHc/aEj2suoRhxrzM5qzUC53V4B69qMsQ+0gw0r82bYfh4iiIbkDWaJwyF4ayUJshdRpe7DnnHh1GNhCh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717999038; c=relaxed/simple;
	bh=1/vAMTbq3ZBiRUGV1BfzxoHRsbHKecxbVfTvTcOo+68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecbavNQcJjK+NeELHQ40lrwvj5XbztbiNFHuF0YE0WwO5SAQQRMWS1+g+BzeaqJmM4v56oaM44d8mrwCpNYQp5LsDU7O6ng9382e8Ac7amIzqSJ/zQbT26oMR4OMVfOkUNO4nC1i7uE/eIYTz1krlNEb8EEVEbFj7H6k8wv9yQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=K5yNUOcG; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-35ef3a037a0so2394980f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 22:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717999035; x=1718603835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c5zOFAazIMlIFvhZhDihadnq9wfYmdHFcKUSAGOnXFo=;
        b=K5yNUOcGY28ABWhgUSEKLA0BhUlePsziiDRJ1CaQpJpyhIsaabUV/WR6DTXP6Puy0i
         myPxC4jmpizmodhoydAxd5GZ3Gq1Ge3GRcmq5/q4i6N06kRvFtB+u2WbCoLwQRra7qje
         Rd4Sd1/Ck6jUOX71fdG3UvOnMOju7ufoXYN53DivL7GaAe5Ymh/6RDYiJ3cgb7/gzFVR
         GUpBDNRqVFTzcQC2B4iEqG4mzt2xwSR2Ps55HQ275kUT893hW+ofgp1pwKbg72MBXAAh
         Tsue8rOHZboxfCzcmcw6X1IEan1pk0ZZx7VLz6nMhjVg8oyHHJNCiBeZXpi9Tmk+1Oj0
         XBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717999035; x=1718603835;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c5zOFAazIMlIFvhZhDihadnq9wfYmdHFcKUSAGOnXFo=;
        b=Qeya1Bk7OSuNbMsA0z3zF4XA3YUd2YK2+uLlKFG7CuKzDKH8bhmCrxK78WJmBPuth/
         zmbkRjKUnDh9oE9RL2FGoGxeTtC7hIORTgtCIIqhBE92oVkToepeAIWbjK5qYtH9fmBw
         /IuxB1BuEPbOu0myj3UgZGq+brwOzCW6nJ/2sRBEIXsyN5xzmxBrMDpr1P3qQHsgOyeH
         ecbZ2fXMnrwJeweazuUalfMo6wrQAcINsyhzgNikeExt9izEXBZy3WbWnM0O7SI5B0Pu
         NuQphHdAMRjr8g3KncnC+XwxQ+QiQJvcJLENDll5CRodqr4RN4Odb2TcQ6xgKvQ7BpyM
         SAKA==
X-Forwarded-Encrypted: i=1; AJvYcCVwJ7puLEH0YuB6gqNvq+SY3jTNGDBNwXCipc4u8cfRW+LYkZu12iSCoMIY+fG/jAmy6xxQgQDcXFAxeRI7/vrfgpOpeycaHgwYW3OY
X-Gm-Message-State: AOJu0YwLagJO1yloPGHjkPeMQdhTTnW4tb81Ad1nAJaM7EKaC8wWACGl
	aVzO1QWlf5+r6D7tIZDcvWkAGmvCf+K3kzQGcwOUxuGf9gElmN+xaAUvDrVgqyE=
X-Google-Smtp-Source: AGHT+IGVumZGSFnDHVppYevQMMMEsdzJ2eDAeIRuctFbzJKUmRaBmB6mVqMLLZKUGMeoRn86QX0pbQ==
X-Received: by 2002:adf:e844:0:b0:35f:1da1:c077 with SMTP id ffacd0b85a97d-35f1da1c1b6mr2999123f8f.5.1717999035187;
        Sun, 09 Jun 2024 22:57:15 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d29e57sm10097602f8f.2.2024.06.09.22.57.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jun 2024 22:57:14 -0700 (PDT)
Message-ID: <a8fa2f27-8c7e-452c-82c7-fb0a0d93b9fe@tuxon.dev>
Date: Mon, 10 Jun 2024 08:57:13 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/15] pinctrl: renesas: pinctrl-rzg2l: Acquire lock in
 rzg2l_pinctrl_pm_setup_pfc()
Content-Language: en-US
To: Prabhakar <prabhakar.csengg@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240530173857.164073-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240530173857.164073-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240530173857.164073-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 30.05.2024 20:38, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> To keep consistency with rzg2l_pinctrl_set_pfc_mode(), acquire the lock
> in rzg2l_pinctrl_pm_setup_pfc() during PFC setup.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S

> ---
> v2->v3
> - New patch
> ---
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> index 1cbf97d416bf..2be088bbbd9f 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -2541,7 +2541,9 @@ static void rzg2l_pinctrl_pm_setup_dedicated_regs(struct rzg2l_pinctrl *pctrl, b
>  static void rzg2l_pinctrl_pm_setup_pfc(struct rzg2l_pinctrl *pctrl)
>  {
>  	u32 nports = pctrl->data->n_port_pins / RZG2L_PINS_PER_PORT;
> +	unsigned long flags;
>  
> +	spin_lock_irqsave(&pctrl->lock, flags);
>  	pctrl->data->pwpr_pfc_lock_unlock(pctrl, false);
>  
>  	/* Restore port registers. */
> @@ -2586,6 +2588,7 @@ static void rzg2l_pinctrl_pm_setup_pfc(struct rzg2l_pinctrl *pctrl)
>  	}
>  
>  	pctrl->data->pwpr_pfc_lock_unlock(pctrl, true);
> +	spin_unlock_irqrestore(&pctrl->lock, flags);
>  }
>  
>  static int rzg2l_pinctrl_suspend_noirq(struct device *dev)

