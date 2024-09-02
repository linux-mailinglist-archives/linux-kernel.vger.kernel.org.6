Return-Path: <linux-kernel+bounces-311787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C877D968DA6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 20:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB721C21EF1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 18:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EF21C62AA;
	Mon,  2 Sep 2024 18:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jip7UI1w"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220C71A3058
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 18:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725302348; cv=none; b=m0SGZE1t6PFKyd6neQXl6IFE58/a0zwJ5lk9RFuyoFngqIQAmMxDRnGHL3qgEdeMf22OwUndTHD5UZhQQTqBRi+NE/rFsxco0OA3+sRCleV8hhL2goaTtOnObmgyH7C/5MBcNf7ILdn+3htLMjYLrdke/P19g2tKzG/7DjBJJ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725302348; c=relaxed/simple;
	bh=f7ioOsOW2UtBJTh4Jn8E/jdh27RM+0q2IQHJKOuj6co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzGzZqaEfJq4v/G0y3ybGoB/e3fKrydwRPm9LVSPgDIr0KLJr8j0yUtECSO7LcZK8hSoFqGI1zhiR99X8hc8WirzCydjguIdjpev+t838mhpoEZlUWIm5mtIVNOpmyjUO9LGkICl365PJS9NXv6B3iwBYTh106RaSBPs9o7qIWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jip7UI1w; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-533461323cdso5621359e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 11:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725302344; x=1725907144; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L7ewTdA6TBog3FUoYxRWQ9HefvGnnlDeA05UsrKzpao=;
        b=Jip7UI1wzQeaGIR3kPV9KD0X/dgi5PTFGmb41CNlnJXsvqkCLlGWATPns7J1xW54nw
         OCo8RY0KLyfD7+zv5vbivdwBYJth282KQXCCn3S8aMsmJFKAEZgwqrwOEQfPjcIEu+qi
         2QFWxojOlYlCASs03IC7dv/LCxhyfVwWLyaFBsM3l8l4tchu05FjiHijDdTe1Igg6ufj
         dZCTzN0HATGtNcSEtYLX6BKcbzDy9vqOQF+p2SqU4x35qdRv4vGH/bQ9GacjA/pZYXRl
         QopTdXAGXt9fnePdyWXv86wr5PgVPwmSn53XthX/FJVNVw6bH/+sZVeLyEbSG8FJ31YC
         5rMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725302344; x=1725907144;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7ewTdA6TBog3FUoYxRWQ9HefvGnnlDeA05UsrKzpao=;
        b=nciy2WL2smpVEaH6rHKW4hUaqTkDSnD1Z90o6vQF26FdtpvHFYmuSCsjRMAEyjr7rq
         sEtuQO6m22LBP5mxu7E1rFfHpCUmTSO7W1zUvGsVWA8AGxMoUCKwExNCkwqgm2ApG+Cr
         k+2QLV4VpHsRfBIBhRqt47QqzrDeXOg3E0jJFGuWSJKz3C3+PYqEYQixHDu2lQlGcEjU
         ueF+Vs8mLatP+jy0qjiR2f5d0oweCX9tQE2tqaDvQX7p0JySA923zCnAifKxyQHD6mQZ
         waCsTy4GwOAwkYR+JBxsBJPWuR9I8c6LS9pzMrryJjLTcvYnaLVajE0so8lsH1uxhdKA
         QjIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEt457h6v/hhbCF6ZJ+2SB18SUPUlg+Xm9q7XzoJySW2ZK3VTxm4HN6oAvwdf2EcV/gQFvtEb3PY3wE3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7A19UWRk9vXJ6ik97CWmA8GNw5/JmHir29N0HW4NA5QyswsRd
	V50loGUq8rLLQUejRj32H0tce6YacLzU8etlD0aRNg6J+/ptPqEVAX8ZQQrlpqQ=
X-Google-Smtp-Source: AGHT+IHYdWkXe+rncah+Q/xuDmfgfYg5nYo/bbQbYrDw8rot5x8UI6W5jir4npXXEJXjP7ha7D6T/Q==
X-Received: by 2002:a05:6512:31d2:b0:533:3268:b971 with SMTP id 2adb3069b0e04-53546b0454fmr7257721e87.18.1725302343576;
        Mon, 02 Sep 2024 11:39:03 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-535407b8727sm1704749e87.119.2024.09.02.11.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 11:39:03 -0700 (PDT)
Date: Mon, 2 Sep 2024 21:39:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jie Luo <quic_luoj@quicinc.com>
Cc: Stephen Boyd <sboyd@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, quic_kkumarcs@quicinc.com, quic_suruchia@quicinc.com, 
	quic_pavir@quicinc.com, quic_linchen@quicinc.com, quic_leiwei@quicinc.com, 
	bartosz.golaszewski@linaro.org, srinivas.kandagatla@linaro.org
Subject: Re: [PATCH v3 2/4] clk: qcom: Add CMN PLL clock controller driver
 for IPQ SoC
Message-ID: <6sk7sx4pz2gnne2tg3d5lsphmnp6vqjj2tjogqcop7fwn3yk3r@ftevsz77w6pt>
References: <20240827-qcom_ipq_cmnpll-v3-0-8e009cece8b2@quicinc.com>
 <20240827-qcom_ipq_cmnpll-v3-2-8e009cece8b2@quicinc.com>
 <d7b374670eb2f6d442f351106ab1221a.sboyd@kernel.org>
 <7f4d41a0-b1b9-4b63-8590-63f4fcf1a359@quicinc.com>
 <7736d0d0-634d-403d-b70f-f33b7402456c@quicinc.com>
 <04944b77ce6327ba5f4ec96348a9cda2.sboyd@kernel.org>
 <ecc34401-68c2-463f-b630-6a81ad95625e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ecc34401-68c2-463f-b630-6a81ad95625e@quicinc.com>

On Mon, Sep 02, 2024 at 11:33:57PM GMT, Jie Luo wrote:
> 
> 
> On 8/31/2024 6:24 AM, Stephen Boyd wrote:
> > Quoting Jie Luo (2024-08-30 09:14:28)
> > > Hi Stephen,
> > > Please find below a minor update to my earlier message on clk_ops usage.
> > 
> > Ok. Next time you can trim the reply to save me time.
> 
> OK.
> 
> > 
> > > On 8/28/2024 1:44 PM, Jie Luo wrote:
> > > > On 8/28/2024 7:50 AM, Stephen Boyd wrote:
> > > > > Quoting Luo Jie (2024-08-27 05:46:00)
> > > > > > +       case 48000000:
> > > > > > +               val |= FIELD_PREP(CMN_PLL_REFCLK_INDEX, 7);
> > > > > > +               break;
> > > > > > +       case 50000000:
> > > > > > +               val |= FIELD_PREP(CMN_PLL_REFCLK_INDEX, 8);
> > > > > > +               break;
> > > > > > +       case 96000000:
> > > > > > +               val |= FIELD_PREP(CMN_PLL_REFCLK_INDEX, 7);
> > > > > > +               val &= ~CMN_PLL_REFCLK_DIV;
> > > > > > +               val |= FIELD_PREP(CMN_PLL_REFCLK_DIV, 2);
> > > > > > +               break;
> > > > > > +       default:
> > > > > > +               return -EINVAL;
> > > > > > +       }
> > > > > 
> > > > > Why isn't this done with struct clk_ops::set_rate() or clk_ops::init()?
> > > > 
> > > > OK, I will move this code into the clk_ops::init().
> > > 
> > > This code is expected to be executed once for initializing the CMN PLL
> > > to enable output clocks, and requires the parent clock rate to be
> > > available. However the parent clock rate is not available in the
> > > clk_ops::init(). Hence clk_ops::set_rate() seems to be the right option
> > > for this. Please let us know if this approach is fine. Thanks.
> > 
> > Sure. It actually sounds like the PLL has a mux to select different
> > reference clks. Is that right? If so, it seems like there should be
> > multiple 'clocks' for the DT property and many parents possible. If
> > that's the case then it should be possible to have something like
> > 
> > 	clocks = <0>, <&refclk>, <0>;
> > 
> > in the DT node and then have clk_set_rate() from the consumer actually
> > set the parent index in hardware. If that's all static then it can be
> > done with assigned-clock-parents or assigned-clock-rates.
> 
> Thanks Stephen. The CMN PLL block always uses a single input reference
> clock pin on any given IPQ SoC, however its rate may be different on
> different IPQ SoC. For example, its rate is 48MHZ on IPQ9574 and 96MHZ
> on IPQ5018.
> 
> Your second suggestion seems more apt for this device. I can define the
> DT property 'assigned-clock-parents' to configure the clock parent of
> CMN PLL. The code for reference clock selection will be added in
> clk_ops::set_parent(). Please let us know if this approach is fine.

What is the source of this clock? Can you call clk_get_rate() on this
input?

-- 
With best wishes
Dmitry

