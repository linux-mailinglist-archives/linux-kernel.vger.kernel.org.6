Return-Path: <linux-kernel+bounces-547595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFE3A50B69
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3753188EA3F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA12253F1C;
	Wed,  5 Mar 2025 19:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AEliPp/U"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B28A1A23B1
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741202624; cv=none; b=R1PlnElksOe4Dir7l5FTGUQQ//vf/qHvAPlTSmkfetBOGvCQLxhsO9oa5O2htX7nerCMgxrOkHoeLC9pjHTxN65yZr0fMD7+dvxM6QXBm8Gf+CrzV+5RevHTHrngnG37gljj6tkapkIQ6PNqNTSv1xt8kMo1GJlO1Yqq/KFeO/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741202624; c=relaxed/simple;
	bh=vaUgEAer5Xge/kEQRXgXB5szwNYecRgMaTi6GqyJmcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2Wrh/MofW4LeRAETuPX96O2z9/e0H9SZGKVUdwybDGNixz6zkwf+j7R+9wRVgF1VrEi7gfCQ4jWE43PX3vA7RIpN+NMg5YrQdzblmo5c7YHONWCAY4ILXqVtTeYSM4MY+nHur4ClY92Q7Ot+wRNer3e+vDluJYQVDppBEv2rUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AEliPp/U; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e095d47a25so12756506a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 11:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741202621; x=1741807421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tJOdZB6G2ABbbWsbRbOZmmakrOJ/BWtI+ZFyzX6G3Hw=;
        b=AEliPp/Us0WMKfbZ2HposiUZn9AKWxJQHBva/1mCwSMgA9aHtGk8vHjgpzySD3xFuh
         RWcTwIfMDrzGl/mTZJs1L1tHD/pPsmPApnGleq9jgbzeZBuZCf9Qcr3+Muy2Cj0aTL4v
         vvfVr9xalfjQmzfGmYtDXJCtg04oejZSXyqqzPEKYYFABnvjs4UVU6FaF8QyhPxF1BqX
         YjPzeeA4rkdKhey4KiwlHp8myELyI/+k9UFglf/Wvo0avZxsXevsDW/8UEoaKg4LoGXQ
         grAnqSKOYbTZBhMx4G3FZAoc0m3SAqP8Tc40Ny3U0fXotTTAMMQkY43VffLxjCSe7f2B
         oGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741202621; x=1741807421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJOdZB6G2ABbbWsbRbOZmmakrOJ/BWtI+ZFyzX6G3Hw=;
        b=h2bldGQVZQ6KISJxY5C93nNCKt9v68JM0I0wOrXkO7yd1kwIRAQNkcAJFclh8jpYE8
         zRjz80X1lRYKCpc6YNyp/L69rj36njT7LQ2OYnubUUHkXyCVI4urJOJsi4iKjfMhsYy9
         S2dr7BTnJBu633uJD4qdluClxhuA9+I43BdqA6wT0VzxL3dLN7tZo7Bgifafig7sckC+
         atNXWHJdOKIhMYW7fFQvmS4GH1AukytjwSRnxZw5n5LqZ4XInDQtjK4No3o55bpjOmbj
         KLn+fH1JICTYKk/HKrTVP7dxMcxdwgNj0ssqUc+zK3BYTtrpLBP5lfqHgnOvQvqGRWLC
         NBNw==
X-Forwarded-Encrypted: i=1; AJvYcCX7SmPrrIOvY92v2q4G5HbyqYQ9rJheSIkLLRACWgc1PYYBPCab5lYka2wSNniT4myVrhd65oYZjjRlDto=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC8HZo05DNYsdgFvtsuFsJ77MiXSmTvYAggE3VFAbd2NCFdCLP
	nFUPWVmDK8FjqVAd8l3OLApFxrhpbjpFt2SuSn4PoW120ElAvoeQmlck4bS8uxk=
X-Gm-Gg: ASbGncsFUsRz8r7Ld6x/Q+A9FbZ6kGEH69Ai7DqtH8RR5If31iVlpMY525MAdgbbtOn
	95lcLJROFCwPWrv0WntYvejhglu/4Y5dB8Z6qLbkr/qw1z9Vo4mT0Dw9bn4TW6ZActYsOeD6JEv
	kRgCc12ABguuq5V7ha8mZ93YnTB23q+4cDLOy7SrM3DgGss1etf6MUZZVmDVY+cXLuu7pcNz3k2
	G/Ke3dGC9qjsnA6EEo6o2CaYLAzITYW7cYH3IAP7g3LTVS8K8lxpFyYYROqpjBBXC4U1uCZPhRW
	j/WeFlUAK266x5vsE2SrwIR5sSm00UiRW3gV8os70M86F1yISt9zin0=
X-Google-Smtp-Source: AGHT+IF9txh3EuAm6n0J50cqAsEj3nsuUrxvXTKQdKRQO9dNNLQ25d43/uYy7nsh37aYR9UUNXPokQ==
X-Received: by 2002:a05:6402:358e:b0:5dc:1173:bfa3 with SMTP id 4fb4d7f45d1cf-5e59f4fce4amr4148194a12.29.1741202620672;
        Wed, 05 Mar 2025 11:23:40 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef30:85fb:189:4db4:65d6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf1625cbe7sm1131075366b.128.2025.03.05.11.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:23:40 -0800 (PST)
Date: Wed, 5 Mar 2025 20:23:35 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Wesley Cheng <quic_wcheng@quicinc.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, srinivas.kandagatla@linaro.org,
	mathias.nyman@intel.com, perex@perex.cz, conor+dt@kernel.org,
	dmitry.torokhov@gmail.com, corbet@lwn.net, broonie@kernel.org,
	lgirdwood@gmail.com, tiwai@suse.com, krzk+dt@kernel.org,
	pierre-louis.bossart@linux.intel.com, Thinh.Nguyen@synopsys.com,
	robh@kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-input@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v35 00/31] Introduce QC USB SND audio offloading support
Message-ID: <Z8ikt2K0uekU2dVZ@linaro.org>
References: <20250219004754.497985-1-quic_wcheng@quicinc.com>
 <Z7W_Vz_kVDjIcp5N@linaro.org>
 <82ce69a3-d248-494f-6ddb-098f392c78a0@quicinc.com>
 <Z8a4WYq4GqWBVNyX@linaro.org>
 <ee5cb6bc-963a-4e31-8ac4-07120fb9ff70@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee5cb6bc-963a-4e31-8ac4-07120fb9ff70@quicinc.com>

On Tue, Mar 04, 2025 at 02:46:28PM -0800, Wesley Cheng wrote:
> On 3/4/2025 12:22 AM, Stephan Gerhold wrote:
> > On Mon, Mar 03, 2025 at 06:39:52PM -0800, Wesley Cheng wrote:
> >> On 2/19/2025 3:24 AM, Stephan Gerhold wrote:
> >>> On Tue, Feb 18, 2025 at 04:47:23PM -0800, Wesley Cheng wrote:
> >>>> Requesting to see if we can get some Acked-By tags, and merge on usb-next.
> >>>>
> >>>> Several Qualcomm based chipsets can support USB audio offloading to a
> >>>> dedicated audio DSP, which can take over issuing transfers to the USB
> >>>> host controller.  The intention is to reduce the load on the main
> >>>> processors in the SoC, and allow them to be placed into lower power modes.
> >>>> There are several parts to this design:
> >>>>   1. Adding ASoC binding layer
> >>>>   2. Create a USB backend for Q6DSP
> >>>>   3. Introduce XHCI interrupter support
> >>>>   4. Create vendor ops for the USB SND driver
> >>>>
> >>>>       USB                          |            ASoC
> >>>> --------------------------------------------------------------------
> >>>>                                    |  _________________________
> >>>>                                    | |sm8250 platform card     |
> >>>>                                    | |_________________________|
> >>>>                                    |         |           |
> >>>>                                    |      ___V____   ____V____
> >>>>                                    |     |Q6USB   | |Q6AFE    |
> >>>> |     |"codec" | |"cpu"    |
> >>>>                                    |     |________| |_________|
> >>>>                                    |         ^  ^        ^
> >>>>                                    |         |  |________|
> >>>>                                    |      ___V____    |
> >>>>                                    |     |SOC-USB |   |
> >>>>    ________       ________               |        |   |
> >>>>   |USB SND |<--->|QC offld|<------------>|________|   |
> >>>>   |(card.c)|     |        |<----------                |
> >>>>   |________|     |________|___     | |                |
> >>>>       ^               ^       |    | |    ____________V_________
> >>>>       |               |       |    | |   |APR/GLINK             |
> >>>>    __ V_______________V_____  |    | |   |______________________|
> >>>>   |USB SND (endpoint.c)     | |    | |              ^
> >>>>   |_________________________| |    | |              |
> >>>>               ^               |    | |   ___________V___________
> >>>>               |               |    | |->|audio DSP              |
> >>>>    ___________V_____________  |    |    |_______________________|
> >>>>   |XHCI HCD                 |<-    |
> >>>>   |_________________________|      |
> >>>>
> >>>
> >>> As I noted on v34 [1], this version is still missing instructions and
> >>> changes needed for testing this series. The device tree changes don't
> >>> need to be part of the same series, but there should be at least a link
> >>> provided to give other people the chance to provide Tested-by tags.
> >>>
> >>> IMO we shouldn't merge this series without those instructions, otherwise
> >>> we risk that this just ends up being dead code that no one can use.
> >>>
> >>> Can you please share the device tree changes for a board upstream and
> >>> any other changes needed to be able to test this series? E.g. for
> >>> sm8250-mtp.dts, based on the examples in your cover letter.
> >>>
> >>
> >> To clarify I'm testing this on sm8350 in recent times, but utilizing sm8250
> >> definitions for the ASoC platform card, as the platform sound card is more
> >> or less the same between the two SoCs.  Back
> >> when I started this series, sm8350 was missing a bunch of dependent
> >> components, such as aDSP not being loaded, and missing platform sound card
> >> definition, so I had to define and enable those on my own, which required a
> >> slew of new DT nodes, hence why it wasn't as straight forward to include
> >> the DT definitions yet for sm8350.  Not thinking that this series would
> >> take as long as it did, I was planning on separating out the DT changes in
> >> a different series to enable offloading for the devices I have tested with.
> >> (sm8150, sm8250 and sm8350)
> >>
> >> There's still a pretty big chunk of dependencies missing from sm8350, so
> >> those would also be handled in the follow up DT submission.  For now, its a
> >> much bigger hurdle to get the main/functional changes in, and that was
> >> taking a significant amount of time from my end to manage.
> >>
> >> If you want, I can give you the changes I have offline to enable this for
> >> sm8350, since I haven't spent time formatting/prepping the changes for
> >> submission yet.
> >>
> > 
> > Can you push it to a public branch somewhere (e.g. on CodeLinaro)? I was
> > talking to some people from the community about testing this on some of
> > the smartphones we have in upstream, so it wouldn't help if I just have
> > the changes privately.
> 
> Which CLO project/branch did you want me to push it to?  Sorry, I haven't
> worked too much with the CLO open branches.  I have an account though.
> 

Any project/branch is fine for me, I suggested CLO only because I
assumed you already have an account there.

You should be able to create a personal project and push it there. You
could also use the fork button on
https://git.codelinaro.org/linaro/linux/kernel/torvalds/linux to avoid
having to push the full history yourself. It should result in a project
similar to mine: https://git.codelinaro.org/stephan.gerhold/linux

Thanks,
Stephan

