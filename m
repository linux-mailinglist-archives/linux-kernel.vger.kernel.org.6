Return-Path: <linux-kernel+bounces-553072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A060A5831D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 11:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571263AC734
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B1E1A3158;
	Sun,  9 Mar 2025 10:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HatSATAu"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEB51BF24
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741516419; cv=none; b=RMInAtKTMbwKFDVFrOtTeh0jzZr4pi4qLQynEcxt7ZMv2zjELMtTVPLxK+Q32zBb9uyM9Kda9IX3THRx6vKIsuIynMUp4rwE5+VKbJzopQXZNvLq0p1ago+HoF1TdCPKNu0EF8nNQpcaE6CyPLoOLX8y95DG6W0pYgIHQxXRqqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741516419; c=relaxed/simple;
	bh=Ozpnb0Ug2oL6cxnV7Sv8Z/csCAhXPSRJOyhuF3CB7f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s6df0hrhuYyrQWKYM6EA3ZGMLd8uNULfUn5eJgm0eT0zkmr9Ge+Tb5GM7Rd1h60wFoDhOYYIas/M/3LbPwsWm0EDkw81oxVkD7XMVJNLdVH6XP2rRJ/7Dp08+jvoDAxA+ixlCtgyNQoccYTQva9aDOJRR5wvk/8WjQlTrwwIuiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HatSATAu; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e4419a47887so2530024276.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 03:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741516417; x=1742121217; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wNpRGIZi3b7vxWPUvyY23xmfkUDKlM0nIxV07CpFzTA=;
        b=HatSATAuTh59Q38gG7QKTarPCySPGraTs0TY/VWzNtwfJs0zo8Kl5qTBCrH3Iy9XgI
         ev1nzKmn25Z1LjMQnWv24i2gqBJDUccnAeFbTUaxyiBn/QVp9KI/xfU2Mu08BpQoiKai
         dujkot7JbnfEZKF5ECZjg+MHmzcK+jl32e6OSfUrX+ofTxYsmHn0R1TcqZ8SrdUjn9AF
         WpRddIWQF9L+UNK4YTi4GVprTOFabAjbeSXwDRGCTlREH2P5cccafDMe6+s4B2zVQNLk
         nwQTZnFkWF7FZILjBm9Nh8iJSYqOpcpqnXxw5IBNUmJISSDhPsYUNTPubjM3pzR/wzxs
         BbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741516417; x=1742121217;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wNpRGIZi3b7vxWPUvyY23xmfkUDKlM0nIxV07CpFzTA=;
        b=Bmim+0y9EAyMu5Ykz5IUepDmEGhL2Qhcv5e+wz6zTmpg6V5FrVgM99L5K3+/q8SfTK
         jUZLI4dUDkMrjvruUFzNPe4xMCk5FnZJAsDvJNJUEKY/g5GwToPGjw49yELHUJb3iHU5
         iPZX8SyXRr4S3sfKlfdeaC3jQB5cKqmbfqGTNyzbvK5Yyheci3bpli1lHAm3wlujbVEx
         qDkwoibzOeCILYpMtYWjORsAEd5an3rTf0NWK6MGxkvX6Koc2TyCVPJHReDkJpNVhv05
         uJLjBxxdBi6DjI6IUmmm5AlMei+AcmoGMA0hgkoZGq1dyItPSoo5yNbqhw4a5ptm0x90
         /2mg==
X-Forwarded-Encrypted: i=1; AJvYcCWtO/bxf6aenihXL7y+G//u3A4Rhk9f2pRoaC3pdqE3yhJlveMfXKItqZTX+qj3q3/sonBZu9LAbktf9Z4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6MP7ZlnJUFvFM4zAsuir+iYMSuCZBc5psDN0EJy5YsNDw6kWn
	jM/vWkL6GYQy/DaD6fBSfGRmRSt/3cn+bPg33WtNl8V0m6HLk1rfx0gsAVxfCKLuV8bpumNP2pz
	dQectvkUHMPOJezrILZ86BoyriyVovkgr/HnkXA==
X-Gm-Gg: ASbGncvK0i5fs3sDVPwtxco2/7ug/cL3LV7EgBrE46JxhqjT5otc3BTeLSsOi1QL/zo
	lm/evaka8kyszvh1ZPPH2c020xnt3s2GTb0AvwbQQcjY4/Gi47yFborAFJ/oqu8Du3T3F4GjB+2
	RCmc0Fd802jpf6ZIiUYAlGGB+M5a6Il+4meGI+M8BjnoC6i1RyWYc=
X-Google-Smtp-Source: AGHT+IGVt6euUeWJaHel2JO0R3PdrFmPyg42bYFogZr5LdUenoAcHAoi+gtckgcA2kBzPh3bWUnzK1DaGMhNqPsRL9w=
X-Received: by 2002:a05:6902:154d:b0:e5d:dd0a:7fdb with SMTP id
 3f1490d57ef6-e635c19566dmr13607641276.28.1741516417063; Sun, 09 Mar 2025
 03:33:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308-phy-sam-hdptx-bpc-v5-0-35087287f9d1@collabora.com>
 <20250308-phy-sam-hdptx-bpc-v5-11-35087287f9d1@collabora.com>
 <CAA8EJpqzZaRoQ5mDeKUHpNhYsegC=V6c2SQpKaQn4FYhozQn1A@mail.gmail.com> <884acd6e-4936-4b00-88ed-cbccc10efc9c@collabora.com>
In-Reply-To: <884acd6e-4936-4b00-88ed-cbccc10efc9c@collabora.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 9 Mar 2025 12:33:26 +0200
X-Gm-Features: AQ5f1JpGOU7l-kSySgvwGTxj7XdS5KAe8kqPUkQFgXHpSlPZef1sDW4xG8Fp1l8
Message-ID: <CAA8EJpqDiK37uLid2ap0E=Sa+DU9vOmSf6WBUe4ZeVKj9mVODg@mail.gmail.com>
Subject: Re: [PATCH v5 11/12] phy: rockchip: samsung-hdptx: Optimize internal
 rate handling
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
	Sandor Yu <Sandor.yu@nxp.com>, Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Mar 2025 at 12:32, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
>
> On 3/9/25 12:17 PM, Dmitry Baryshkov wrote:
> > On Sat, 8 Mar 2025 at 14:21, Cristian Ciocaltea
> > <cristian.ciocaltea@collabora.com> wrote:
> >>
> >> Drop the rate parameter from a bunch of internal helpers and, instead,
> >> make better use of the newly introduced ->hdmi_cfg.tmds_char_rate driver
> >> data.
> >>
> >> Additionally, rename the rather ambiguous ->rate member of struct
> >> rk_hdptx_phy to ->hw_rate and ensure rk_hdptx_ropll_tmds_cmn_config()
> >
> > Would it be better to name it tmds_char_rate?
>
> This is only used in rk_hdptx_phy_clk_recalc_rate() to provide the
> actual rate programmed in hardware, hence the "hw_rate" naming.

Ack

> Renaming it to tmds_char_rate might add some confusion with the similar
> one in ->hdmi_cfg, but I don't really have any strong preference here.
>
> >> updates it only after all the other operations have been successful.
> >
> > Please don't mix refactoring / renames and the actual code changes.
>
> Right, I should have moved that to a dedicated patch.  Will handle in
> the next revision.
>
> Thanks,
> Cristian



-- 
With best wishes
Dmitry

