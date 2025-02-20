Return-Path: <linux-kernel+bounces-524114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD78A3DF5B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EDC2423923
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2673720485B;
	Thu, 20 Feb 2025 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="taqvxzDf"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBB81FF7C3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066645; cv=none; b=H2b5kvKJvfVCqNUt63DbnzXU9XSz/jDnxb/u3EGPqD5hWNNW4iolt6DkHBz15+mm/wdip2Uea+zv2yXc8A4eZzHoCMvuOw8gY7GO0W9gtkxQlN76+u6cHwSbhcyshpRs/PX40xN/9Nm9vt6gRx2sJt2nYxcGzNc2f+DNR3zRzDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066645; c=relaxed/simple;
	bh=ieiaw5OY+W9wjSsfmsFhHkkrsbAtEYxkH/L30OdT2RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlXm/JVw5jNySWL+C0YZifYD0INfefZnoHjoi5vOVsHPhfwRH4N0EkiNMai6L53OirXuz6zWNWVmmuX2Ol/jAWWxUNhQj+QiLSnUkG7NZFTwBFAzuha7AzPX1a2hLVF+a/36LiusxqaqqUJXzJngGLS0NqKJH7hX+mVhMrvGCCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=taqvxzDf; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-307325f2436so10855711fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740066641; x=1740671441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VJw+h4hQVN4nQ/xzWE1GpPEBFqaeNGDtLbmaQLEVPk0=;
        b=taqvxzDflrbPpXDQ75Y89R/TPR58JLQgAeQ0JDj3Jrhzjpo7FI8RMhTaIw8UP7ejCJ
         zC/rQEWW58o4v0GlLqGFIk4+9wUhlBtta/QgZ/sevkpxLg20q/GWZpVKmwaxX2WDGKP1
         luTi7zXtdbNIPQE/hUFKy1SItGQ8NSlzZacHXmoH2XLqT3azeJVx2YzIJXTgRcIHB0ur
         O+7i4pioOsuEycVOVRXeilKhw3T/3M7ejADzj5dYWGpwCsDLuxeyFGoutZXJ9dlnDlee
         3qpEWtQ16LoqJm8x1flGLcHww4n9zqVc2OfRe28/j1DZxZpZvDwmmV0I0jVIrOKb9bX7
         5UvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740066641; x=1740671441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJw+h4hQVN4nQ/xzWE1GpPEBFqaeNGDtLbmaQLEVPk0=;
        b=HYtBvmAKdd4QJNKgYsE+i8iwjhKoid9IVLKYqs2ZGRmh4L04+p+/tJln0ON/pxZGdW
         H3lQkhYP38VtuJWcq8Ty+sFnVAJnNfqGV97k26v/H0qs/C0vSonaz4a/7bm5bbvvf2hu
         UnIop0VnepmURGn0AUcU0BOe/J0Ih4g9KQeg00l+h/GJwUC169jM0dfso6LOxowrIbM+
         eVkVLL2YTvwwpJ5181qfDnKA6Fu/B5CIx24zVMp1UCE9vcltNJuEFE/mpK/4i5VqO3O/
         sjddFRsl2Uc8TGShFSWB0FBUls1C4eG8saqyk6hHHPVFSRR1Y82vaZWQWg4hu6r5/sU6
         B0Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVrc7r1Bzi8GOD7GCzkgVqDfK+dviZ0rVbJIOICn6o73fyaS2Zj9ThHAVoHsVDKQ78tj8dawouoqH8MWoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnDFuGyXzlu/AfALvTnq5A4ZsBsITAlU5qLtJvwYtwytHZ63xN
	WwUNwV99LcuUNau6XVFqwIzTUPCstJN2C/rrKO2ZAxmLIgtX/ti1VjqHEvEf0y8=
X-Gm-Gg: ASbGncvThrxNOK6hOh/JZSvhtOw3AIuPMfQrsGug0UoN27tohkUu0nkE5kYHvTYxZy8
	+C2WB7s66EU5BQiFx72AWQdkoXULFuBcPEE5/hr6FlyLAE1ETIcE/lcIpe1xZGdAF1OGYrN2VaI
	JeXrcGMP7QKyEFxO8w8GXCZVikxjjzIGcGXmFv/24m7qWFI36Ntxithzqx5uhrx0kjxseqWQp9M
	vyuQ+iD15tFfJsZq+braEL8iSm9tgic6CmtOrB2IIJPYCdOXAkmUcNE8Dw0lViC2biY92dDx3Hc
	MOt/S7cGILlRQ5xUDr7QfpIJB6E4+tuMIbHZ+2wuuBADzGO5mXlEHyRj5VaQlSNykhdkwmw=
X-Google-Smtp-Source: AGHT+IG96cDdlQ5ip9buGSbrayjmMs6tRL76tsdQABR/QmoJLFuyfSuDIZStdfBwmD72ax+ik4u3IQ==
X-Received: by 2002:a2e:99d7:0:b0:309:214a:6b16 with SMTP id 38308e7fff4ca-30a44ed34bcmr25621661fa.22.1740066641455;
        Thu, 20 Feb 2025 07:50:41 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a28000328sm15763861fa.66.2025.02.20.07.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:50:41 -0800 (PST)
Date: Thu, 20 Feb 2025 17:50:39 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Akhil P Oommen <quic_akhilpo@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] nvmem: core: verify cell's raw_len
Message-ID: <scmsm6wsgspieamsjqftjfdswfmfh5cemiebb6k66qzetdovy5@oa677gskzst4>
References: <20250109-sar2130p-nvmem-v4-0-633739fe5f11@linaro.org>
 <20250109-sar2130p-nvmem-v4-2-633739fe5f11@linaro.org>
 <Z7Xv9lNc6ckJVtKc@finisterre.sirena.org.uk>
 <CAA8EJpp-mE2w_c3K08+8AR3Mn1r8X58FRXvAUFALQ-u2ppoKgw@mail.gmail.com>
 <Z7c5niuwR3TVTQrj@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7c5niuwR3TVTQrj@finisterre.sirena.org.uk>

On Thu, Feb 20, 2025 at 02:18:06PM +0000, Mark Brown wrote:
> On Wed, Feb 19, 2025 at 05:14:43PM +0200, Dmitry Baryshkov wrote:
> > On Wed, 19 Feb 2025 at 16:51, Mark Brown <broonie@kernel.org> wrote:
> > > On Thu, Jan 09, 2025 at 06:35:46AM +0200, Dmitry Baryshkov wrote:
> 
> > > > Check that the NVMEM cell's raw_len is a aligned to word_size. Otherwise
> > > > Otherwise drivers might face incomplete read while accessing the last
> > > > part of the NVMEM cell.
> 
> > > I'm seeing a bunch of failures on i.MX platforms in -next which bisect
> > > to this patch.  For example on the i.MX6q based UDOOq various things
> > > including the ethernet fail to come up due to the efuse not appearing:
> 
> > > [    1.735264] nvmem imx-ocotp0: cell mac-addr raw len 6 unaligned to nvmem word size 4
> > > [    1.735289] imx_ocotp 21bc000.efuse: probe with driver imx_ocotp failed with error -22
> 
> > This looks like an error on the i.MX platforms. The raw_len must be
> > aligned to word size. I think the easiest fix is to implement the
> > .fixup_dt_cell_info() callback like I did for the qfprom driver.
> 
> That sounds pluasible, but as things stand we've got a regression on
> these platforms - taking out ethernet breaks NFS boot apart from
> anything else.  I'd also be a bit concerned that there might be other
> users with issues, does this need an audit of users before trying to
> enforce this requirement?

A quick grep shows that there are enough drivers using word size greater
than 1. Would you mind checking if the following patch fixes an issue
for you? (Note, compile-tested only.)

From 2bde6ec5c9e74771f29170cfa11623208266880b Mon Sep 17 00:00:00 2001
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 20 Feb 2025 17:43:54 +0200
Subject: [PATCH] nvmem: make the misaligned raw_len non-fatal

The commit 11ccaa312111 ("nvmem: core: verify cell's raw_len") enforced
the raw read len being aligned to the NVMEM's word_size. However this
change broke some of the platforms, because those used misaligned
reads. Make this error non-fatal for the drivers that didn't specify
raw_len directly and just increase the raw_len making it aligned.

Fixes: 11ccaa312111 ("nvmem: core: verify cell's raw_len")
Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/linux-arm-msm/Z7Xv9lNc6ckJVtKc@finisterre.sirena.org.uk/
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/nvmem/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index b6f8544fd966..e206efc29a00 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -612,7 +612,11 @@ static int nvmem_cell_info_to_nvmem_cell_entry_nodup(struct nvmem_device *nvmem,
 			"cell %s raw len %zd unaligned to nvmem word size %d\n",
 			cell->name ?: "<unknown>", cell->raw_len,
 			nvmem->word_size);
-		return -EINVAL;
+
+		if (info->raw_len)
+			return -EINVAL;
+
+		cell->raw_len = ALIGN(cell->raw_len, nvmem->word_size);
 	}
 
 	return 0;
-- 
2.39.5



-- 
With best wishes
Dmitry

