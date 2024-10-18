Return-Path: <linux-kernel+bounces-371586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF4C9A3CED
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482C41F21009
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CECA20101C;
	Fri, 18 Oct 2024 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k/ge/sMc"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF52200CB6
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 11:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729249938; cv=none; b=tS1u9ZVHnMaF3D49QGPSRNDVMlMj7oi/y0ptdqaIlN2eCYdfCbOnWomoD5vAJiI14gNVgf2teOEPBsYfTV75I1zIeQ33ECSI5yWfZLlOHQvZbeGLHxkuwZLTJU/kWLsD5377qJLfYx/TqYya61bS04YxbLmL4jv+5hjRVcQww9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729249938; c=relaxed/simple;
	bh=sboLUVaWZDCOJMR+0tS0W8F9u4PFF4DVPPd99k5TIBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ribb5pZ8zKmkpBl+kisNNOc0Ztor1UtO5wXLWyzTTY/6essvvdGKCK5RSpLzjVGRd8yiP0qv5zg1PCEIVSXzN6pZHC0T59Oe6Vtqf4J4Dg0Yit2A3NBUuLNTNn1DvW/hoBq70QOorBQi7+Mv8dPMlapOS6vt0fH6z7wyp1M5dkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k/ge/sMc; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb498a92f6so24625801fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 04:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729249935; x=1729854735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2s2ZCLF1waKizSxdSo7cWD0QLs8Ba/I3KQJi9DrQE90=;
        b=k/ge/sMc43oPz2J+PEfZo0Lja+MVIr60hQRBaw7/sJqiOXM+X0IVf3BR7F9TYhZ+EO
         NCmWJmLFmyMbxWVQhHPaE6Hn9uC929wAbc9uzWUresYZdabXNVPKnjCyKVCS3BYj3jp5
         XZelZiomRXxNu6hvNw3TDCLVMd86XY8zhj3upOLT/ZuuoKAWJqGo6QTDAKs/fe4DsV1X
         1VTID9Klsv/pJy+5KDc+IUmppgIWXpZ2KTQmxOHLC4wFrnB4sMaZgMkrDpgjZmaySITs
         CxZ7QtJ7fPxeJqNrGuH0FL/t0e8cemNiU74SNV6ASba1P+Oh8Huyh7pt6aCjNPtnaFwc
         hS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729249935; x=1729854735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2s2ZCLF1waKizSxdSo7cWD0QLs8Ba/I3KQJi9DrQE90=;
        b=n7oc8BYzPaLI7tTc4Fr72l73jdd8F4XfCw+WMIs5WYyS25nOd6u4nVFgvSA6dwalfc
         OJrsyc1N/8nBgXJPbBOY+u/aAew/XWQcPqtMpsXWRwAvnRhEdk8L+ZgCukgTsUlP6nkB
         gcRgBqz0JXhV5YNOtUYeybq+c3hFc2ma8phYl7wRs0/rQMB3lSpTGrNSZ8Sevi3u/1bc
         zcmu9IZX5kj8174gPqcIYgD4TJXvmKQZ2t0due0bnpWP7snlVWp+qnhlkBgz9FcW2e52
         /HZm7l0qAFYrFCgcZICqW7A7C9Kap0G/UpCSi5AW0IsIP2yllXBvKTebz+mVgYQjxa+J
         IbMA==
X-Forwarded-Encrypted: i=1; AJvYcCX7KFnVV97jTLk/0qaEEVSdq6xnvv7lXrNLDrsKRbXSRFGwJjtXGgz4fVgMJt1y+RKyO6GxPGkv+2tNEe4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6uME5OAWk2g1yAE3qtPQatl9fepEfwNrUBRnc5s/lG8ry9CeD
	NUd7D8e4G8KPOTRTWl8JGI3tU5gbYGmiE0R9u4bHu4lykdcjHEXBKZ8r4SIm2i8=
X-Google-Smtp-Source: AGHT+IGdgiuS0f6dYbTG6111LuFSuvTL3Dx3rqn1aHYRUJgo6DJbnJR1F0rw0wpH3OGeukLOmxaF7A==
X-Received: by 2002:a2e:a549:0:b0:2fb:3d86:d932 with SMTP id 38308e7fff4ca-2fb82ea21admr11666401fa.12.1729249935090;
        Fri, 18 Oct 2024 04:12:15 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb809a6adbsm1883801fa.4.2024.10.18.04.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 04:12:13 -0700 (PDT)
Date: Fri, 18 Oct 2024 14:12:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Taniya Das <quic_tdas@quicinc.com>
Cc: Stephen Boyd <sboyd@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kalpak Kawadkar <quic_kkawadka@quicinc.com>
Subject: Re: [PATCH 06/14] clk: qcom: clk-branch: Add support for
 BRANCH_HALT_POLL flag
Message-ID: <gmw3fkvtcoorsdqxdqgr4ioew6wuvtuuvy44qv6fpyrs6wgbv3@jqyayktyxfvn>
References: <20241017-sar2130p-clocks-v1-0-f75e740f0a8d@linaro.org>
 <20241017-sar2130p-clocks-v1-6-f75e740f0a8d@linaro.org>
 <d7989a770f0eb35a5ba346beb5e7548c.sboyd@kernel.org>
 <jcjncf5k5syvcvwxoopksisjvvmw4cvxo35nieqf63mquj57io@fumh4jnh2e4p>
 <dfafb945-69f7-4378-9bb0-72eee37de235@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfafb945-69f7-4378-9bb0-72eee37de235@quicinc.com>

On Fri, Oct 18, 2024 at 04:32:47PM +0530, Taniya Das wrote:
> 
> 
> On 10/18/2024 3:35 AM, Dmitry Baryshkov wrote:
> > On Thu, Oct 17, 2024 at 11:03:20AM -0700, Stephen Boyd wrote:
> > > Quoting Dmitry Baryshkov (2024-10-17 09:56:56)
> > > > From: Kalpak Kawadkar <quic_kkawadka@quicinc.com>
> > > > 
> > > > On some platforms branch clock will be enabled before Linux.
> > > > It is expectated from the clock provider is to poll on the clock
> > > 
> > > Unfortunately 'expectated' is not a word. The sentence is also
> > > grammatically incorrect.
> > > 
> > > > to ensure it is indeed enabled and not HW gated, thus add
> > > > the BRANCH_HALT_POLL flag.
> > > [...]
> > > > diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
> > > > index 229480c5b075a0e70dc05b1cb15b88d29fd475ce..c4c7bd565cc9a3926e24bb12ed6355ec6ddd19fb 100644
> > > > --- a/drivers/clk/qcom/clk-branch.c
> > > > +++ b/drivers/clk/qcom/clk-branch.c
> > > > @@ -76,6 +76,7 @@ static int clk_branch_wait(const struct clk_branch *br, bool enabling,
> > > >                  udelay(10);
> > > >          } else if (br->halt_check == BRANCH_HALT_ENABLE ||
> > > >                     br->halt_check == BRANCH_HALT ||
> > > > +                  br->halt_check == BRANCH_HALT_POLL ||
> > > 
> > > The name is confusing. The halt check is already "polling", i.e. this
> > > isn't a different type of halt check. This is really something like
> > > another branch flag that doesn't have to do with the halt checking and
> > > only to do with skipping writing the enable bit. Maybe we should
> > > introduce another clk_ops for these types of clks instead.
> > 
> > SGTM. All clocks with this flag use clk_branch2_aon_ops, so it is easy
> > to switch to a separate clk_ops.
> > 
> 
> The basic requirement here is to just poll in both enable/disable, but HLOS
> cannot update the CLK_ENABLE bit. The clock could be gated by the bandwidth
> vote and thus to ensure the clock is in good state before the consumers
> start using the subsystem.
> 
> We can definitely think for a different ops, I think it is better we have a
> good name to the flag.

Granted that we end up using just clk_branch_wait() in enable and
clk_is_enabled_regmap() in .is_enabled, I think that separate ops might
make sense. Anyway, as this concerns only 4 camera clocks, I can drop
this patch for now.

> 
> > > 
> > > >                     (enabling && voted)) {
> > > >                  int count = 200;
> > > > @@ -97,6 +98,10 @@ static int clk_branch_toggle(struct clk_hw *hw, bool en,
> > > >          struct clk_branch *br = to_clk_branch(hw);
> > > >          int ret;
> > > > +       if (br->halt_check == BRANCH_HALT_POLL) {
> > > 
> > > Remove braces
> > > 
> > > > +               return  clk_branch_wait(br, en, check_halt);
> > > 
> > > Remove extra space      ^
> > > 
> > > > +       }
> > > > +
> > 
> 
> -- 
> Thanks & Regards,
> Taniya Das.

-- 
With best wishes
Dmitry

