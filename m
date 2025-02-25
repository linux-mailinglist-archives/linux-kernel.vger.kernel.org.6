Return-Path: <linux-kernel+bounces-531256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8D0A43E28
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2C4A18853BF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0335A268C58;
	Tue, 25 Feb 2025 11:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ttmB/aM8"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FEA267F53
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484017; cv=none; b=bBWXyrI8xV5BC65dpaQb3rjCHOM6Le5wgPxKweOKHIeHRnVsKJHJL/piaX1RvDsnRuvxEhg+do0QeBGpGHD9blkeVD2in4S5ki7FaUiUfxLemomeuH1LzeBbo49uhuI2TDnKVw3TNIgbVUu+BGrRHcN/PGQpnQ5qzi7OL/QOa7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484017; c=relaxed/simple;
	bh=LbnNHvJwUCE222tNIF/NxQZ7BADM2FTAY1BWShXpMQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOxubmNE1fks8J6yzdgSSiRGoA435Bo7N/lH9aipNH/R92z4f8fPEWe0Uap9wO1lEnLv4eY/32HjlPlwFl9jMfXIqW5pZPn3+imQwsXJbJt6m2m4mQ9MdL3Kbn7ZAykltPP8CzGKttt/e1Q1demM1cQCt9CnDv0kbUC/E5jZcqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ttmB/aM8; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-545316f80beso4906194e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740484013; x=1741088813; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ts4A/ttxPZ/L49bXy7EOSBKD/ukxratjzN45EB6TnCM=;
        b=ttmB/aM8vGgn8rFZ/vE4rZt/K4F8PoJwh4yCZCXP11y0Nu80Fava0oeOxcG670FkSg
         h5HsfGXjq1w22SXWTsu9xsJx0PQlgRbm2fU6BvdMftpTHaSOMIzpvpeUHot0x8tFNBT3
         Lpl/8eMy15yEPf/mQLO5hM71qxw9t8mA4RubA2EZC/9xBlGb51njvNxIaFH9ryxvEY6Q
         5nf8+2U2rjHVx3PKHFHj9C+DkzHicOMAEVhOWC/Z/fs9yxBc0Yf+iRjeC0HJwmXc3o09
         Syby5P/PB/1EreqN/RmvMktLVi0eSunLfL1C3UDXDnGxF2z9QzV79p6JVevb6mp75QU6
         kGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740484013; x=1741088813;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ts4A/ttxPZ/L49bXy7EOSBKD/ukxratjzN45EB6TnCM=;
        b=gqkVE1sbkdFPvr8A0eA+fbLSJKgH3DpD5yNU2zrnJCmgoHMPojLxSbXLtCpV77i/4c
         +qyyD3OyTbni9ARYM8xyjUzX3aTUjWnCpFTQFpQyO2yFGMGzFPXnXWmo7nuzuGmKErJ9
         dMHEZv1udn3n3xOuFePk+baG+QhVwqcPU1mp+xlAwzmctT1Iq2w06joABPee3Tfk6MUr
         JbE30TZUUpdUQquKRS8z1wG1GieK3yNRpXru9EjQSiW90UBTjOGMWX42glq3qTB1m0rj
         OXD+iVO4ZtOj+oKLP25V6csrkArU3M4SWZFLCE5KVLWguxhHkiMrl1uLJi5oSE12e5ov
         Y5iw==
X-Forwarded-Encrypted: i=1; AJvYcCVEbOl0vyFQG5Hbm10PGH1V1A5jULX9FZZ2OhMV9SVgsgVxzmWjXnGs7+DvLB53GWSm0nAYVbMEihc6SjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhMnZtJJKWvgOSC4VZBDj9Hk3PLIF0sbhyLFHm/EFuXPiJbaL/
	AjoJ3g9QpK9NYnGtpaGJuB6yJ2rRlKDRX2gXy4Y7Qxpq5aeWOLZs+uIiUzgCG0E=
X-Gm-Gg: ASbGncubrVnm79rE1LQODKrbHaypxyCwHQCHBb4+pbJ+TQDq93PKl6j/UHJPjiv9zO0
	OQvx7q/G2gThKHtTrFKPraUOuQSucuqI9ydQTOIVrvcGZYZaiaqk+3GluUjcQ+wOq9NGJQglK8O
	ryv12qVuGUD+S2rSZpk903VVY9ybGIzKQFlmb4Quj6hcFcMOLOojmtjS6BjdCnVzOtXwSAuCnNd
	Xx8zTLmB67RboE9a5/qv2uG6fd0Ze9GI9w+DDldKNNcULWiYSf8TXDYZ41pfVnfAOcGOBIa624h
	31Zf29WUhWkuz13P+4OLefw20YWeeHMQEg++A9hBTiDRSbAraHgELI3xrYDqKEUhUEpQz4T16L+
	bRexc4w==
X-Google-Smtp-Source: AGHT+IHUcQBC16oXfmvyIM7koTL1imeYmCyXP4Cq4nkgukEO51aAQvQvv+5NeosCoPqAnavazJ8nQg==
X-Received: by 2002:a05:6512:15a7:b0:545:16d3:3bd4 with SMTP id 2adb3069b0e04-548510eda44mr800752e87.53.1740484013276;
        Tue, 25 Feb 2025 03:46:53 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514efc90sm158425e87.133.2025.02.25.03.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 03:46:52 -0800 (PST)
Date: Tue, 25 Feb 2025 13:46:50 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	"Wenbin Yao (Consultant)" <quic_wenbyao@quicinc.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, vkoul@kernel.org, 
	kishon@kernel.org, p.zabel@pengutronix.de, abel.vesa@linaro.org, 
	neil.armstrong@linaro.org, quic_devipriy@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] phy: qcom: qmp-pcie: Add PHY register retention
 support
Message-ID: <zppwzqdi5xbggurbqho6ivuorvlubldpjw3pyw2fdgrap4nrhp@5otsko6o5cv3>
References: <20250220102253.755116-1-quic_wenbyao@quicinc.com>
 <20250220102253.755116-3-quic_wenbyao@quicinc.com>
 <20250224073301.aqbw3gxjnupbejfy@thinkpad>
 <7ffb09cd-9c77-4407-9087-3e789cd8bf44@quicinc.com>
 <ea5de507-1252-4ff3-9b18-40981624afea@oss.qualcomm.com>
 <20250224122439.njrcoyrfsisddoer@thinkpad>
 <eea55dfa-3dd3-488b-958c-cd20e18a7d7d@quicinc.com>
 <20250225081744.3aprpztylrdgs2cl@thinkpad>
 <4a672888-a90e-434c-b494-bb58b91c99a2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a672888-a90e-434c-b494-bb58b91c99a2@quicinc.com>

On Tue, Feb 25, 2025 at 06:08:03PM +0800, Qiang Yu wrote:
> 
> On 2/25/2025 4:17 PM, Manivannan Sadhasivam wrote:
> > On Tue, Feb 25, 2025 at 04:06:16PM +0800, Wenbin Yao (Consultant) wrote:
> > > On 2/24/2025 8:24 PM, Manivannan Sadhasivam wrote:
> > > > On Mon, Feb 24, 2025 at 12:46:44PM +0100, Konrad Dybcio wrote:
> > > > > On 24.02.2025 9:46 AM, Wenbin Yao (Consultant) wrote:
> > > > > > On 2/24/2025 3:33 PM, Manivannan Sadhasivam wrote:
> > > > > > > On Thu, Feb 20, 2025 at 06:22:53PM +0800, Wenbin Yao wrote:
> > > > > > > > From: Qiang Yu <quic_qianyu@quicinc.com>
> > > > > > > > 
> > > > > > > > Some QCOM PCIe PHYs support no_csr reset. Unlike BCR reset which resets the
> > > > > > > > whole PHY (hardware and register), no_csr reset only resets PHY hardware
> > > > > > > > but retains register values, which means PHY setting can be skipped during
> > > > > > > > PHY init if PCIe link is enabled in booltloader and only no_csr is toggled
> > > > > > > > after that.
> > > > > > > > 
> > > > > > > > Hence, determine whether the PHY has been enabled in bootloader by
> > > > > > > > verifying QPHY_START_CTRL register. If it's programmed and no_csr reset is
> > > > > > > > available, skip BCR reset and PHY register setting to establish the PCIe
> > > > > > > > link with bootloader - programmed PHY settings.
> > > > > > > > 
> > > > > > > > Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> > > > > > > > Signed-off-by: Wenbin Yao <quic_wenbyao@quicinc.com>
> > > > > > > Some nitpicks below.
> > > > > > > 
> > > > > > > > ---
> > > > > [...]
> > > > > 
> > > > > > > > +     * In this way, no matter whether the PHY settings were initially
> > > > > > > > +     * programmed by bootloader or PHY driver itself, we can reuse them
> > > > > > > It is really possible to have bootloader not programming the init sequence for
> > > > > > > no_csr reset platforms? The comment sounds like it is possible. But I heard the
> > > > > > > opposite.
> > > > > > PCIe3 on X1E80100 QCP is disabled by default in UEFI. We need to enable it
> > > > > > manually in UEFI shell if we want.
> > > > > IIUC this will not be a concern going forward, and this is a special case
> > > > > 
> > > > I'm wondering how many *special* cases we may have to deal with going forward.
> > > > Anyhow, I would propose to atleast throw an error and fail probe() if:
> > > > 
> > > > * the platform has no_csr reset AND
> > > > * bootloader has not initialized the PHY AND
> > > > * there are no init sequences in the kernel
> > > > 
> > > > - Mani
> > > Hmmm, regardless of whether it's a special case, we can't assume that UEFI
> > > will enable the PHY supporting no_csr reset on all platforms. It's a bit
> > > risky. If we make such an assumption, we also won't need to check whether
> > > the PHY is enabled by UEFI during powering on. We just need to check
> > > whether no_csr reset is available.
> > > 
> > I am not supportive of this assumption to be clear. While I am OK with relying
> > on no_csr reset and bootloader programming the PHY, we should also make sure to
> > catch if the PHY doesn't initialize it. Otherwise, the driver would assume that
> > the PHY is working, but the users won't see any PCIe devices.
> > 
> > > But it makes sense to check the exsitence of PHY senquence. How about
> > > adding the check in qmp_pcie_init, if a PHY supports no_csr reset and isn't
> > > initialized in UEFI and there is no cfg->tbls, return error and print some
> > > error log so that the PCIe controller will fail to probe.
> > > 
> > Sounds good to me.
> I'm wondering is it necessary to add this check? In current PHY driver,
> for PHY that doesn't suppot no_csr reset there is also no such check.
> If a PHY supports no_csr reset and isn't init in UEFI and there is no
> cfg->tbls, the worst issue is link training fail and PCIe controller will
> also fail to probe. Adding sucj check seems not change the result.

Failing the training is a random error which can mean a lot, e.g. the
missing voltage rail. An explicit check is beneficial, it helps
developers (and users) to better understand the reason of the failure.

-- 
With best wishes
Dmitry

