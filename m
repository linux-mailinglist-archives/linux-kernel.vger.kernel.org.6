Return-Path: <linux-kernel+bounces-553030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B20A582AD
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4FB16BDA8
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 09:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF8D18CBFE;
	Sun,  9 Mar 2025 09:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GXLGi/GA"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482DFECF
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741512433; cv=none; b=T4oGPxKdF8neR0+s1zxqPmrRG6gxcx20Vnz5JUPxPOtEsFl8th2LypkMOi0HSvDy+EMZTjC7EgvHEvp06DYmrjYiea7OxfgV9jUhlClp9z0+adir6+q42+tytPjxoJNrsKsDzlEdSQw9yO2AlvzNaTFU6pfKhK5UzfP7Bmr5P78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741512433; c=relaxed/simple;
	bh=0Cg0XCOaYyGOBSIOqdmuTO4XIJ0Ct2UiRn7C8HbKR6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRZ1xl5f40b2gNl8a0/51heYrURfqw9O2q8iTKv54cMfFca2PNHFZY51raNOyQx335A/sRaY7hYG3uHh6g9j5QvumFH3+YPUq97izS+ng1uPwCwbE8ZOT7QTnWCFNvEH/qD237eoWM1eT8ocBlWWgNQeVBNAhH/t3IpTDStARqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GXLGi/GA; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e636585c375so1351203276.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 01:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741512431; x=1742117231; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8MzFqTYg/ttLX5uoaIbZhu+X3rO/zERjBLQIlgSQny4=;
        b=GXLGi/GABvw91w8ml6QtAUGgUUEz6efGCQDbRVKzTgJ2nkdT7sqXU0U8ctL3nyOlIV
         Ela3qYxIRG+X4UM+zwBGMlR5Lqoewsrd1iwJHNT5HQvZffONeUFgPlTQhgRgBjqDFobJ
         /YhNabuOkPElFZpiyaQ9ObDpO1FrQ8fYkeYlly8mU/EONXcs3XmtUckdboicv0emesZX
         gwxP/+lXkzH/JVdNng7gISVOCQyMRAySHvrAnwzhadKxSce4sGElxFNtns06kDfwYCkI
         fzJ92a7F1sXJjvQB7I40yA8dReomkOqBEMkchfBzgdOa/SPy5YYiYtUNhMHDhBDDIXDr
         jWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741512431; x=1742117231;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8MzFqTYg/ttLX5uoaIbZhu+X3rO/zERjBLQIlgSQny4=;
        b=orvaCFJD9dFMh11PxwRBLuXQFOWmLi6thz+59dt7D7SwhjVeggR622sTvQHO0xE92D
         6PLYuO4IbjIaxV8Ld86Sde4QXYT8MtShH7R7oPlu0MKSVvo/j2Ziw+gsDHOh8q4ke93T
         qxSNeKMJt8MYqAZsITiVfIEaLazIL4FAQJd77/8QbjIv/nTtsPjnuRP9h9VTZP8vL1NN
         oCT5fTe8QG1gRgg2LXkwbfAXjeLldQq09qL6n/P4xCOzgspVN63A64T145UP0zWbJIbI
         kyRl/gJxae4NT/XNPS90+Y0M0ArOblw4pNp7CPCDmkZ8wlOx8bkfgKjZS9BCoAeoRxY3
         pHBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0WdUmVj/Edqq8vZ9BTHSlYJd8P01IrSGuSo4rW70FHfN6qEsklp/WMCp8vq7Hr6fWrO8qjAsAxb6g5z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyUNhD6QRl/0W2HKEunBrrDfEsLTj8FW1iX/UfgRkENjCMCdju
	4YtNo//nLsZmbmZdnUj4I4rDV7kqN/Lk07ZbEUSzX8vdnaKPfqtUVOpWCsgMAIGznbqNz5c9K8r
	bOqfXhhkf3IIWsddQjxtac2zOJvl8OvN7mTSylw==
X-Gm-Gg: ASbGncvsabQyWAl1yUE482R++EMDgFDIxSqF+g8VjU6wSIVJDFp2slNFi/BtKiR6EzU
	oa1yAxnTnfbavNp2UjP5RGQkVA4ZEexrMNwuI7JqIz9ez+45/z9eb2m8rOSg+WzFh7ih5UJ0tnQ
	M/1AV7G4dO0gGUyVubeILxvfhuxhH4OaDFJRsLDMp9
X-Google-Smtp-Source: AGHT+IFA76leXty/jcWXJzC9DDrnbvcXI51BQa5AVFEVNQnlG4hIa3hv03b3Pkk5R9S7knKinfGf9iLV/UMM6mz9Jyk=
X-Received: by 2002:a05:6902:110b:b0:e63:326a:3acb with SMTP id
 3f1490d57ef6-e635c1e4bdbmr10097346276.40.1741512431172; Sun, 09 Mar 2025
 01:27:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308-phy-sam-hdptx-bpc-v5-0-35087287f9d1@collabora.com> <20250308-phy-sam-hdptx-bpc-v5-9-35087287f9d1@collabora.com>
In-Reply-To: <20250308-phy-sam-hdptx-bpc-v5-9-35087287f9d1@collabora.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 9 Mar 2025 11:27:00 +0200
X-Gm-Features: AQ5f1Jr0o-mNk31NaHNXGWXnai6sEVvAhCvxPdtXNqLeXppZC3-JsMDZY-z7vX4
Message-ID: <CAA8EJpoCMp1Hk7K=OTgR8BW=tncRFTYBKndw9UG-rS3JYyO3gg@mail.gmail.com>
Subject: Re: [PATCH v5 09/12] phy: rockchip: samsung-hdptx: Provide config
 params validation support
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
	Sandor Yu <Sandor.yu@nxp.com>, Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Mar 2025 at 14:21, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
>
> Implement the phy_ops.validate() callback to allow checking the PHY
> configuration parameters without actually applying them.
>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

