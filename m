Return-Path: <linux-kernel+bounces-553021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B2BA5829E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0344E7A3344
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 09:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E4717ADE8;
	Sun,  9 Mar 2025 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qX7CYTo6"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B60519259F
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741511928; cv=none; b=l9H8/j3M8aJrROpnrwJrvda/I9dL0m+I4LG7ikJ5dap6Tt9zkAIxdSh5S2jKIFpCWj2z2WtXPJKA10J+fx8O6U5ymAPKMjplBY0vmfqUuCmiNd/fVL8Ypr/LlEI9bjnD0fIZi+ynMtI+ksbWQ+CSXmh2YemVZh2IilxMvd2uXh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741511928; c=relaxed/simple;
	bh=8y2vcvxDMA8P/abDzthSg1+UrVcvRmnMiLhBJ4dj3ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1AOt0mE1iY0vN9hdUcT3VVKdXSZ3VtH43tAt2/oruOgtYjqrSOVkVwkA951gDyfBeIdDsTWpKL6Gl/uqoe3voE70zAhJ2VlMeU43f9qp0FAb97J6DfMghcNIg7eR77x6+3Vc2Uc/8rnIcGNm+68E4GX5Zf5W55vR84SOVjIlSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qX7CYTo6; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e461015fbd4so2357775276.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 01:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741511926; x=1742116726; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NjoirmZ/5qUE6QTY9P4KcVvh5GMm6iUYiIH5ki0k/yU=;
        b=qX7CYTo6s2qhU1o7T0Qcol10RWq/fTxz5N7f1IVAbZ+t5qA7rLHbZncimCu0+KXtwt
         +S3QXoBCnZcv29vm9qVQzRf81gYtmT1c7dfxB0pNRml1jK0QZRa3V3P8zw07bREndSHZ
         nqJoeyPzYDIqYNNHx/XKOMTWFOsCUHkScbO/6Nf2Uf7RE5cwqlODb9epjytMPDBz2C8+
         ZQnVIBt6qNxgG454nrK+3d6M7YV05uzgtDlYkzFOknhC5y+IMiTpByjeoZo7RgINRKFu
         iZ5ZcgSOLLAmb2vVMCi4/BlahzTySrkT29Qiw+xmkE50EQY2yq0FjzwU8i3gQRrgdGgW
         hpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741511926; x=1742116726;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NjoirmZ/5qUE6QTY9P4KcVvh5GMm6iUYiIH5ki0k/yU=;
        b=KxelZbWrXHevMFxy9sA7iNTTq5hGAL0P7zVtPq/ctwb1aUgi/mCzHXQgOy+c5Y2G4F
         3uHgVykxTpK+PQovlAX+QTAHz4jLbxgEXscjtocTlAE6/BaYxss2njxx0J+fv/iG8CXt
         vJSX/QdholiJajMiITu7JZhNaCeZF5SWrgc+oXYiOaqd8Oy5yYXJXUwCqNzBoy+y8toN
         KptL70wXQF/lgXWd9mf3TQeQmHHmxCQjAwB7RGUsYXnvUHAkmbbS9oiaq8nvVU5xVcDM
         rhMrf1apxNqArJi8ZFq47i0x2fsGg1EbEoQfXN0UkyDYl9WATQJI95bui9hX5Psx178w
         FFPg==
X-Forwarded-Encrypted: i=1; AJvYcCWwnJ8R6VPe1tYx0ZbTMP2RAfIa9wdnrzbtJqNOAfdNpjTv8m+8BVODnfhT7ClvIaL8BHX76ykCXR1/x3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7q4Dt4i5PCSBew05Wag+UJ5DNnmrgNMJ0mcJlGPC/NyGSjkjc
	JL7jKjtIFKesDCMwuU0hF1Y9RfrKLPjSbCnhHIL/I1/P4kJ5iAa5QlyJna5HrWDqkH34fFru2jp
	B5zcQsl/61KrJ3+YUlVUSvQc4jaxcenzmlF93sA==
X-Gm-Gg: ASbGncu/BdvqjRc1PuG088A+Sr41ZN5EMSvOUiHRLyyBlK9KiaFX9LNO9m2wC2tCP/s
	E2zF5mCNPaqGYGgK3feyVQMumfJ6gLZTSfFTmJrcl4r4+Q8OYKzf1Vex+ot1ctBN0uTMAHV3xKp
	Xzpod47LEbrroH+8PQkdPj18kJ2nuvMwbhrRmpP29R
X-Google-Smtp-Source: AGHT+IH4XPDX1sv9v/O4fHv7FdLtDOK1nSH/pYUTyPU6X3cGpWa7GU9Du4h4efF7cwLgeAUNmZ/eF/AUnWn6NuP38pQ=
X-Received: by 2002:a05:6902:1ac4:b0:e60:99e3:f8c with SMTP id
 3f1490d57ef6-e635c2fea74mr12941522276.46.1741511926194; Sun, 09 Mar 2025
 01:18:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308-phy-sam-hdptx-bpc-v5-0-35087287f9d1@collabora.com> <20250308-phy-sam-hdptx-bpc-v5-5-35087287f9d1@collabora.com>
In-Reply-To: <20250308-phy-sam-hdptx-bpc-v5-5-35087287f9d1@collabora.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 9 Mar 2025 11:18:34 +0200
X-Gm-Features: AQ5f1JoYXHeMEkeI_3Qn-eZRDS7BsRAZP2eXaZlYLUfhSvlvlxiajsqE4pYYYnE
Message-ID: <CAA8EJpoqRbTgkvQz8E2PpgC9QAsQBHvedY8=xH4haMVMjNbSuA@mail.gmail.com>
Subject: Re: [PATCH v5 05/12] phy: rockchip: samsung-hdptx: Drop unused
 phy_cfg driver data
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
> There is no usage of phy_cfg in the upstream driver data, nor in the
> downstream one, hence remove it.
>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 1 -
>  1 file changed, 1 deletion(-)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

