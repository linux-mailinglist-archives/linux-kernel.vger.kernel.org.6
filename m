Return-Path: <linux-kernel+bounces-192506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E65E8D1E44
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F042861C4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C822F16F83D;
	Tue, 28 May 2024 14:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dY8/4wcG"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70DB16E86E
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716905699; cv=none; b=gkQNjl1wKFH9ZRAd2VMrV/Z+O//7opn7Lveceb3/IQRXTL0NlcrRwO3gDGpdkYhlLAmka5WaTkSrL4fUr0vCNKAPnglZdLMPjjNkyfHgKs9TrSSuzktYx0PEfLgb565kViITHup9q6jMxkd5vpE1Il/fYBWSNdB+ad2hegPNegQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716905699; c=relaxed/simple;
	bh=A3B7DkRNnn1sAujL7DnS7K9eFHSqkhpLjb2bEuC8kZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jcKE77YxJZN9FFA3HYb2EeqBNlD3+tgbNCIoznDbqVA4HqxoEP5IPz13vIgyHe/YrZN3htgHl2HWdYVLfefAA50NckJPPc07eDpK+B3HCbzYHjuQYj7oGCkO7Jn5y6EknEav4QHoE6MZoUkK09i1Z05U+wiQNNmevM/atRZI1Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dY8/4wcG; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d1bf479c62so506997b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 07:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716905697; x=1717510497; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zittrK0SuyPjIL+AeowzXGFUqlIKj1R5LpUEGnglOow=;
        b=dY8/4wcGnJVVGatixpN+BfixpO7KcxzhpNc9Fv9i3hjgcwtsrTmWDk1x8hyI2HvWO5
         rv8sZRvv4tV77Ep7PDV8Y0TLKlOAj6kJ6ZvO0tgHUgFQxN9ki/3eJpnM9C1JaDaw5E1O
         80zkGRTz/w/swd3siearXlXq0tFEY2WWk4l3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716905697; x=1717510497;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zittrK0SuyPjIL+AeowzXGFUqlIKj1R5LpUEGnglOow=;
        b=aTNEuHGkPo5BZmpHqOaktoQQoRLuea4fhrPSknaNPJ+8uJTgZAyS8NagdeTIw5xdnU
         +5eX2tvWiGeLvD4kbbpZVdW+aoRrGGtC2A5P5v/oNGvb7wR2hBHsKcSc/xc0NKeXBGQi
         fxRplH8rQc08bdTelSLt0bCF1uIkSOayYlgRvXAlmr2WBPx1xlxg/JLUCqAi9eABneyu
         OsScFtdzXms1CijaP8fU11Zrzq8kPx4BpmUtIi/KYlnrZEQvcqjGdGsVwZ2guTVnxt1B
         KKS0Xb26hRQLKdZTeffXsWoiPsQh34s6t2Swp/4COAts/lvVeeWegDKH3Gs8b0LxW1mp
         mm2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXNPlfwBN10PK/UEBN0gu05XUM7kAKwWiv7xv/KRjOtEIpEJ+f7WOTB89m7IDiHC1azZDGohFT+rcX5X4QDdz/e54lAQpochMwRuKN
X-Gm-Message-State: AOJu0Yz9ZXDS5GygKJc8dF+eZUaRo+fsgo+OvT7TtVFtCqNet1wnTB0K
	Qz/I3ADRHUF46arl6oS3wITomEodRx5Dt/kydQXy9IqTGRaj5HnXkPlmdkflpD7XRSELf1aQNDc
	hbhu5/YKA7GICyA0GPxZKRsaYGmRJjc3xHaEi
X-Google-Smtp-Source: AGHT+IE06UeLLaV5hXYkhGE8SfRF9xex+t5CAfAb4fwmYcPWSOsWMJuV6/47FzJTHqjm3DXehq6zwtMtgDzPwvfoLSY=
X-Received: by 2002:a05:6808:989:b0:3c8:665e:1e57 with SMTP id
 5614622812f47-3d1a5e2d421mr14592426b6e.25.1716905696879; Tue, 28 May 2024
 07:14:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528085221.2989315-1-wenst@chromium.org>
In-Reply-To: <20240528085221.2989315-1-wenst@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 May 2024 08:14:46 -0600
Message-ID: <CAFLszTg+Gg=wZDAWX420hA1N04OYM1TY6Yj_JAq4X98TPwaaTw@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/make_fit: Drop fdt image entry compatible string
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, 28 May 2024 at 02:52, Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> According to the FIT image source file format document found in U-boot [1]
> and the split-out FIT image specification [2], under "'/images' node" ->
> "Conditionally mandatory property", the "compatible" property is described
> as "compatible method for loading image", i.e., not the compatible string
> embedded in the FDT or used for matching.
>
> Drop the compatible string from the fdt image entry node.
>
> While at it also fix up a typo in the document section of output_dtb.
>
> [1] U-boot source "doc/usage/fit/source_file_format.rst", or on the website:
>     https://docs.u-boot.org/en/latest/usage/fit/source_file_format.html
> [2] https://github.com/open-source-firmware/flat-image-tree/blob/main/source/chapter2-source-file-format.rst
>
> Fixes: 7a23b027ec17 ("arm64: boot: Support Flat Image Tree")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v1:
> - Add clear reference to U-boot docs along with excerpt
> - Send separately from "disable compression for DTBs" patch
>
>  scripts/make_fit.py | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

