Return-Path: <linux-kernel+bounces-232545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 627C791AACA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62761F26C64
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D21B198A28;
	Thu, 27 Jun 2024 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PW/HTg9w"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7734198E60
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501154; cv=none; b=u49Y+D7+SNjf/SeQKaiklv6Np8dsw04bxR7o5ys8hegeHliK30p5WRFlS0uFGOTDOkc5kcMkx+MuFLB9ErPszzduz2lakaAkIJ+/0xru4QKMhCxoCdwe64celEEOXHM6enWukmVFEEvRNsCyODR1vpqKFKpdyjnbFLnZscbQYt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501154; c=relaxed/simple;
	bh=AMWL6jWtVLIBtIv6eoQ8PZgGmdE3SlQmweWXtoF89k8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CHaMpwb3Y99tPgPYWtLHAKg9DBvI3Uoj+LS9TcxzITWdGBaRhUEKSvRlvBrziiuZgs+XTXOCLdcqALdXuHyTPg+kYqMi+/L65il22SBx7KTJsVCmAmVFGZKv9fCGsD0++s2q+cECaOGBNL4WQNXljBRtUOJRGK8X7IlasHwBzwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PW/HTg9w; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-648b9d03552so16854577b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 08:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719501152; x=1720105952; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BU2vZmzqi+olvgZ5virQM/8AdFIn12e+5hjEcUIemP4=;
        b=PW/HTg9wf4d5A9Ech9apLy6fhW7WZqMGfyzTXaYJQhUpwuJ1XEKk9todhD0DnVL9C6
         agYfiVDhcYdz7Ho2Nqan6IlVQHInQdFMEuDms1JhjleS5XVWNRyj9YzzR9x2gGpIYUKw
         bfDNKKIz4WqUbQv3VqVueWAkl6FnzqQfMWB/l1tUcHFZ9AwgIhfD0eVH9AyVttYfr8Z3
         izVcty99tYgqSptxhBBTbEYNRomatAMfoyO6ueCJANK0P78sanJHJjGaYBDSUiPhMyvg
         lSVBHNdxAXbS8gpVcz5vRyVjPyFMb4QcmtOB2+Mg7Ysr1yBCoHyIAr2oxsI9wsuTX9Hn
         t1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719501152; x=1720105952;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BU2vZmzqi+olvgZ5virQM/8AdFIn12e+5hjEcUIemP4=;
        b=fQ3FCWNqK9OTW5Y7hGPKlqTbL6qftrGUB6ePcmd/vh4HUWfgUzKyciiiJBhrSbE4cU
         EWKVNLzkMI1sbTq4gH2ikTf4uCFsZ4S50xFBcTm/+PHjLIKRM2mXTgMk5MNWUypdsYng
         zbrcjg0vld9AdKvpVpSUOXCAZg7ZLEaPDmKbAZROTL6Omf7oKU70jf/D0erRXVVVycig
         oTD0xjqb2UAoRQy3v0SoFiPLVqJdo7r1BUJJIINufO3srXLCwg+px4FvlwrYJdzKrcJA
         FjGvkq8hSK3AlTdxl1RJoMLCVARbsjdx4OraDaZYO4Nz6/r+y0HaD+0WagNWbekIH7pX
         4/3w==
X-Forwarded-Encrypted: i=1; AJvYcCWseVA/Q4uKbBY5JCuYB/KIHgRT5mZ8rwpnFRLPhzupLlD2DHrqDdGCtWdTrJkrEsK3TZ3s/Cy8mnHjTfue7P+mzBQXUpx45RVLIxb8
X-Gm-Message-State: AOJu0Yw9nDAf297GqZSvpKqDBeWPdbAQ3QPbjoBY/h8ak4YmTz+cSt40
	qfUzk54CeKE2zxol28ZM01DAfI3S54evSeCvhNLswZGFMSZswWOXn+INm+wxVaJSe0i0zKKviZ1
	rvlHOCRxUq380Qm4akFWJR3t6jST7YLIURLtW+Q==
X-Google-Smtp-Source: AGHT+IGBkCGjvpXyOLI1sZD88556mMVWRjS2lGe1CdsQmgpXL0A8yG+//8kBFLmfop+VM0G5SSumDfGjvj4aPwOBPHs=
X-Received: by 2002:a05:690c:845:b0:61a:d846:9858 with SMTP id
 00721157ae682-643aa1c15ddmr132441767b3.20.1719501151805; Thu, 27 Jun 2024
 08:12:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626-port-map-v1-0-bd8987d2b332@linaro.org>
 <20240626-port-map-v1-4-bd8987d2b332@linaro.org> <tlaykv4bx6uizimz3jnprevwbuvygitvacbbdixzrwq4llaz6e@6qpswvidl4iq>
 <3b897a1a-bd5d-4e6b-8289-a9c6b280f193@linaro.org>
In-Reply-To: <3b897a1a-bd5d-4e6b-8289-a9c6b280f193@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 27 Jun 2024 18:12:20 +0300
Message-ID: <CAA8EJppRkyMHmmLWzQumpB25fFkAq8Mji=LsPUsWeoLOpsja3Q@mail.gmail.com>
Subject: Re: [PATCH 4/6] ASoC: codecs: wsa884x: parse port-mapping information
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Banajit Goswami <bgoswami@quicinc.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, alsa-devel@alsa-project.org, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Jun 2024 at 17:16, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 27/06/2024 15:38, Dmitry Baryshkov wrote:
> > On Thu, Jun 27, 2024 at 12:55:20PM GMT, Srinivas Kandagatla wrote:
> >> Add support to parse static master port map information from device tree.
> >> This is required for correct port mapping between soundwire device and
> >> master ports.
> >>
> >> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >> ---
> >>  sound/soc/codecs/wsa884x.c | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git a/sound/soc/codecs/wsa884x.c b/sound/soc/codecs/wsa884x.c
> >> index a9767ef0e39d..72ff71bfb827 100644
> >> --- a/sound/soc/codecs/wsa884x.c
> >> +++ b/sound/soc/codecs/wsa884x.c
> >> @@ -1887,6 +1887,14 @@ static int wsa884x_probe(struct sdw_slave *pdev,
> >>      wsa884x->sconfig.direction = SDW_DATA_DIR_RX;
> >>      wsa884x->sconfig.type = SDW_STREAM_PDM;
> >>
> >> +    /**
> >> +     * Port map index starts with 0, however the data port for this codec
> >> +     * are from index 1
> >> +     */
> >> +    if (of_property_read_u32_array(dev->of_node, "qcom,port-mapping", &pdev->m_port_map[1],
> >> +                                    WSA884X_MAX_SWR_PORTS))
> >> +            dev_info(dev, "Static Port mapping not specified\n");
> >
> > Same comment. Either dev_warn (if it's something to warn about) or
> > dev_info.
> >
> > Or, as your commit message mentions that it is required, it should be an
> > error if the port mapping is not specified.
>
> That would be an ABI break.

Ok. So make it required just for new platforms. My point is that
dev_info here is pretty pointless.


-- 
With best wishes
Dmitry

