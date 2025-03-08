Return-Path: <linux-kernel+bounces-552580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60829A57B97
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 16:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC1016D7FE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 15:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47ED81E1E18;
	Sat,  8 Mar 2025 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BWUplUDZ"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035E31C84C1
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 15:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741447752; cv=none; b=m1QzW9uknydbodZwMnpnHEZL33h8Ri5FdGGRJLif9SpZgWDPB31dANzUd74SscABseMrwxQPlEtIGj1dJKcJO3vPMoR6sBdhfIqh5mrX3GyJfzZus3Zr9UeuBq+IU8Cckj4njCqGMK415+77+mt+9+txcFLKemdO5DDbUcRW0ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741447752; c=relaxed/simple;
	bh=DngW6UKwtoP4vTNhZNLO04627yOjUXfCZEoZdkARLkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bl1yFLvaNfXkeARO1H0FmidvpJ/RUBk7nlE9CGCcP2Pz+yi+UsEoetRDI4hitETv+24QnGYgIVjJ3MBrjDXXJ9bXuPF3B/dSFZ54gKud76k4AQVVIoRTrUYfKisJeyA63uiz/lhrn8kdp7r0kl2iEbmYeEtMNE6dlaUv1j5ogpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BWUplUDZ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30bf8632052so15352031fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 07:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741447749; x=1742052549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j1erwRbEpf42IpSPu2HfeF24p9T9l4keifT6FQUxIMM=;
        b=BWUplUDZeU96vc/TLQ7w/otbqzRgDvT04TbNFonvcJaruyHrXUlYrduHQmt78qat6q
         GmonXuEAXKDRBa90glxwaCN77+Wde2D5FsSFPkXNcQ2vy2MVdRbAu/YuPHQcD3M6EsSR
         dlCD9uJGmSBQYvIpmokxA1U+N/WFnKyJJGNiHwgOTlQGijR17Dz1nBGt/teRWg85WzgL
         MdtsLpgZ7rLGnZzIlDxhE9zg4ijroIIpoCzw/+dfvkBmCa4/V2BOa7Mjm/JL1V+T715o
         oKXC1OtQIA47M2C5tQmXRuaRhiTz5K3fYWqSaWM76Ss3/vq6KjMxEwb+6RarroS5CjCZ
         fW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741447749; x=1742052549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1erwRbEpf42IpSPu2HfeF24p9T9l4keifT6FQUxIMM=;
        b=XivHXrB268uzKlt+97oG/r7Tgpt4pLHtnDmzStcwHzXU2YxJJi/Ap8q6VdpQOSeAaj
         qno2EdKUZ25vuenmSYUVFLPQIa8D6WyGVnQLqzWRDYEYiOMw82O+ifu/+zhnOYlLlE7P
         7gS7nraO5iQv4t1E5RFhoNfMQmIh73HTTklBXIhKf6fSJfUOgx+Hh8rJ58x9IsfwNQcw
         Q3GDgpiHBZG/1FdRAEuUYXfXBU5W2VM/eY7U0f8zmFERj+bmjkfSL0Y6BiIGsVaq5Qhq
         G1V4XsXcN3cehJIbm9ybYCl8oGta0j3nc5KEk1HPOjNDA5Nt69oxXv/YVn79JXf4B1uQ
         tpVw==
X-Forwarded-Encrypted: i=1; AJvYcCXdk+kwy41ktfhcMlY8yMmCF2/otGAJWTwCwBR4TNvqimb16vhMJ1GkMC9tTXFOFecMwibeZ2q5LpuZX9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEisSsc7qY8p3U4X2eWSBSF2H0TMD4zaKb8QWNBBKulx0bR4in
	sorM4k7NwmaAJY1Hk4t2BSNsGf8rt/msCnvs8L8rTmulhGjDDJuPWJ6Alt5UV44=
X-Gm-Gg: ASbGncs5GxYfoMFVXjPLVlCUM7CSTsIUO3FeWfwrrhhGbKz/G8Jkpz5nSEtBSYPa/KH
	Hxi+OKTCRRe8g+tRgCiIJNuk95oSboFQ8MSu2zJGW3YWXBZCQGTRIathm6myoJT15DicYkFw5pN
	N8CuijezRG487l16StjXIllgmBF0mryhtcTYGumNB5VlsnFEb7GS/7Wpz96AWsxy5pVwYghN9Qh
	TrIlZ4g8qBCowd+ASIupVgsjM2XHM9+TBQG03iXV36kBWU2cn8Y4FFAGJ/CTWPB+ZXFlY8wALjH
	brawRjm7SzqAr/0zwLavSrjh9cJTuiMexxMZmD/vTMBMwlFXI5AVKyaL5PvCfzJu2Bx5o71nHUB
	m/uVJl0qLQkScCtvATaNxAZxg
X-Google-Smtp-Source: AGHT+IHWJzyRENoKYCsCD6ryWleW1FfCxkcxA9oKFolKIPqPM2Gc1cW/mG3/aDezKXNBCG2jOe6Msg==
X-Received: by 2002:a05:651c:2106:b0:30b:b204:6b80 with SMTP id 38308e7fff4ca-30bf44eda0cmr24484481fa.8.1741447749006;
        Sat, 08 Mar 2025 07:29:09 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30bfcc80809sm3965871fa.86.2025.03.08.07.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 07:29:07 -0800 (PST)
Date: Sat, 8 Mar 2025 17:29:05 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: George Moussalem <george.moussalem@outlook.com>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-phy@lists.infradead.org, andersson@kernel.org, bhelgaas@google.com, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, kishon@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org, 
	kw@linux.com, lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org, 
	p.zabel@pengutronix.de, quic_nsekar@quicinc.com, robh@kernel.org, robimarko@gmail.com, 
	vkoul@kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH v3 2/6] phy: qualcomm: qcom-uniphy-pcie 28LP add support
 for IPQ5018
Message-ID: <fwpdzm4gdulyhfnmcvoqsbnu3fwbqyc6gne3ayz7sr6eu2yyqy@hhii6x4pk7a7>
References: <20250305134239.2236590-1-george.moussalem@outlook.com>
 <DS7PR19MB8883A6C7E8FA6810089453149DCB2@DS7PR19MB8883.namprd19.prod.outlook.com>
 <oeu6wkfhx2masvendoweoufzit6dcwwer5bakzvg75dz3uc4bj@bwuj4slnb24e>
 <e2d84147-c061-4f12-a44b-f60919625f77@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2d84147-c061-4f12-a44b-f60919625f77@oss.qualcomm.com>

On Sat, Mar 08, 2025 at 03:25:05PM +0100, Konrad Dybcio wrote:
> On 5.03.2025 9:39 PM, Dmitry Baryshkov wrote:
> > On Wed, Mar 05, 2025 at 05:41:27PM +0400, George Moussalem wrote:
> >> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> >>
> >> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> > 
> > Something is wrong here. There can't be two authors for the patch.
> 
> It may be that Nitheesh was the original author, whose patch was then
> picked up by Sricharan for sending (no additional notices of
> co-development), but George later did the same, forgetting to remove
> Sricharan from the chain.

That would go to the SoB trailers. The issue is slightly different. I
can't even come up with a normal way to end up with the patch having
two From: headers:

The only way how one can get the From: header is by doing git
format-patch. But then git am would get rid of it by filling the commit
metadata.

-- 
With best wishes
Dmitry

