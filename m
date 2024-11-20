Return-Path: <linux-kernel+bounces-415724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FD19D3A5D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAF5A282BB6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BF219E971;
	Wed, 20 Nov 2024 12:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kPSXsvLk"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF381A01AB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732104736; cv=none; b=ns6aT2ylQQ2261uE0V2qhwRjFN3ABJLzulIDU4rSd+/E0kmi/5CmnSHR5h5x+FXwcwpQaklDKk7m1CD7bfPEUhEsoEV6ZsMm3fazIHHLPz+hLBUPtsnoR7SLlxzIsWCs9C31qRYNX7IxrIuzj8d12GtDS+/pKzxFnvY9rpY2Y5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732104736; c=relaxed/simple;
	bh=KdNc17Lw4LgDFyLHvb7jAfVyv6xDBZUsSTSh/I62MZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XagDa7S48oHDeqNuujbysWqLId8EPQY+jldBSPu1vBQtbeyng03Ic101AMangZi1F7HOIoDX89I1PsEStybsYQK4fQA1icmeGbtHgvXQGyavl9mc0Ivxfg2eWdYiAddWQkr52dFTVKo0hFcZui+Q0WM/c3ZVAgOC0ThrLBhySw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kPSXsvLk; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so7442952e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 04:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732104732; x=1732709532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OMWbq/x4Nqudl4yk4SzkkQtLAFxRLITg2CsZtXN2g5I=;
        b=kPSXsvLkjUKntl+eJdYOBxwgsoMsoYSlkAub+nw4ohCgVPuzCdO6x1Z9pzV1kd0KbY
         TR+lTVNAqgyCKv+W7b8iiDubSEK66rM5kjhpTmxRZvXPtd59pjgcckUPLI21WQ3Ui84r
         Y172Zefq6RYn2owhXZx/ohMNfVg6CtvCSSldQrVz/oN8UTgF830q97RBHaGOsG4ccqNR
         c/g+QW3/FLhKm7h1kSpnO28r9BGlZAv20qO2/2m5udVhzWcJX7tlzlpURlYrG6+ZuQYT
         xnV+wRmZK3kbYKMBA4XpDLCZMU3uIXjAj7AQG1cGoRWbdvyAL+fLOOcAXdtv4prbIRPs
         D/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732104732; x=1732709532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMWbq/x4Nqudl4yk4SzkkQtLAFxRLITg2CsZtXN2g5I=;
        b=cs2DEkCO+EIoPOvwkgk3kfeY2//lpnThje+SPpMvifprzG3DPEa1wmRKm96He9RrL7
         SyNE68uIFtkNVhiBY3rJgSiACyLQNbMci9qh6H+aNbdLFyynznCLwMe7VVvSh2rv6R4q
         VYb2exGbQ9WAoBkkKh7bsxIzucN/DQYBcNStxAjbFP8dLz2RI8i+NDPvy3yYiqeNgDa9
         HzILCBD3G1rpi9U2Exapfh1z1KVHghKTvP0iy5Kw7JS57v7oPiL6WUmFmaTsmfLRNO+S
         hBTDYyII3hFflcXNAGx56rWVlBIv/AOWDT6o2nthfLfqbwenrVB67ob+7mXm8H+ZS0QA
         cQHg==
X-Forwarded-Encrypted: i=1; AJvYcCW9P6dv0yuNEkxgs9d7ity47wSLxs+lWLZjxjLY/urGK0pKEAAkg+jl2aHqAYFl3TO8qtMz1BaRWLsyju0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwTacqozlTEekcg4jYHl8Dt3Dq/l1+PwmxBpRpT9VBWluxFkAw
	VH9ngCFekalJ276zAJBW/jz68K+UVhKbr9S57jWu1bE+wMCmwgcPRtIo53oEMpM=
X-Google-Smtp-Source: AGHT+IH9ECfqG+ol7wTxDpRhbAEgdEH8XOGngWTxcGWbNfF9wd7aRWWeuvmmZ0Cg+UuHPZb04xGsTQ==
X-Received: by 2002:a05:6512:3c88:b0:53d:a504:9334 with SMTP id 2adb3069b0e04-53dc13637d8mr1683756e87.44.1732104732148;
        Wed, 20 Nov 2024 04:12:12 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd4672b5sm616545e87.137.2024.11.20.04.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 04:12:10 -0800 (PST)
Date: Wed, 20 Nov 2024 14:12:07 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, quic_riteshk@quicinc.com, 
	quic_vproddut@quicinc.com, quic_abhinavk@quicinc.com
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: sa8775p-ride: Enable Display
 Port
Message-ID: <dq5sikwfoj2uov3qi66ltn3h4wdohqtvr4p6h7gqn7sfk4yccx@btawu7iqg567>
References: <20241120105954.9665-1-quic_mukhopad@quicinc.com>
 <20241120105954.9665-3-quic_mukhopad@quicinc.com>
 <lkovymvjsbd44v2huij7paikvnmo7i7rrmkmvpha2wn5sc4hr3@ppr2dgvhzy6d>
 <a741b71b-af04-44aa-9e08-a3f852b8a801@quicinc.com>
 <qpdponpaztryzacue5vtythr4b4cu6fohmgiwlzredm7ky7caw@eose6vpy4e7y>
 <4da87d98-823f-4781-b138-c6f6caae38fb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4da87d98-823f-4781-b138-c6f6caae38fb@quicinc.com>

On Wed, Nov 20, 2024 at 05:23:24PM +0530, Soutrik Mukhopadhyay wrote:
> 
> On 11/20/2024 5:13 PM, Dmitry Baryshkov wrote:
> > On Wed, Nov 20, 2024 at 05:05:50PM +0530, Soutrik Mukhopadhyay wrote:
> > > > On 11/20/2024 4:42 PM, Dmitry Baryshkov wrote:
> > > > On Wed, Nov 20, 2024 at 04:29:54PM +0530, Soutrik Mukhopadhyay wrote:
> > > > > Enable DPTX0 and DPTX1 along with their corresponding PHYs for
> > > > > sa8775p-ride platform.
> > > > > > Signed-off-by: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>
> > > > > ---
> > > > >  arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi | 80 ++++++++++++++++++++++
> > > > >  1 file changed, 80 insertions(+)
> > > > > > diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> > > > b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> > > > > index adb71aeff339..4847e4942386 100644
> > > > > --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> > > > > +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> > > > > @@ -27,6 +27,30 @@
> > > > >  	chosen {
> > > > >  		stdout-path = "serial0:115200n8";
> > > > >  	};
> > > > > +
> > > > > +	dp0-connector {
> > > > > +		compatible = "dp-connector";
> > > > > +		label = "DP0";
> > > > > > Thundercomm's SA8775p RIDE platform doesn't show such a
> > connector. At
> > > > least not on a device advertised on the web pages.
> > > > > Are you referring to this product in the Thundercomm web page :
> > SA8225P and
> > > SA8775P
> > > Ride SX 4.0 Automotive Development Platform ?
> > 
> > Yes
> > 
> > > For this particular product we
> > > can see
> > > eDP 0/1/2/3 serving as the dp connectors.
> > 
> > Please correct the labels then. And also please mention why eDP2/3 are
> > not included / tested.
> 
> 
> Sure, we will update the labels in the upcoming patchset.
> edp 0/1 corresponds to mdss0_dptx0 and mdss0_dptx1. We have validated only
> these.
> edp 2/3 corresponds to mdss1_dptx0 and mdss1_dptx1, and these are not
> validated,
> as already mentioned during the driver changes for the same.
> Should we mention the same in the commit message for the upcoming patchset ?

Yes, please mention this in the commit message for this patchset.

> > > > > > > > > +		type = "full-size";
> > > > > +
> > > > > +		port {
> > > > > +			dp0_connector_in: endpoint {
> > > > > +				remote-endpoint = <&mdss0_dp0_out>;
> > > > > +			};
> > > > > +		};
> > > > > +	};
> > > > > +
> > > > > +	dp1-connector {
> > > > > +		compatible = "dp-connector";
> > > > > +		label = "DP1";
> > > > > > Same comment here.
> > > > > > > +		type = "full-size";
> > > > > +
> > > > > +		port {
> > > > > +			dp1_connector_in: endpoint {
> > > > > +				remote-endpoint = <&mdss0_dp1_out>;
> > > > > +			};
> > > > > +		};
> > > > > +	};
> > > > >  };
> > > > >  >  &apps_rsc {
> > > >
> > 

-- 
With best wishes
Dmitry

