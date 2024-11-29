Return-Path: <linux-kernel+bounces-415703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AD59D3A20
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 706E0B23D5D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF05C4EB45;
	Wed, 20 Nov 2024 11:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bFi4ievt"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDE319F116
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 11:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103703; cv=none; b=l+InxUJsudC+xaXpET2Ad+nOpGmSgNAZm2CcGDRqj4A0OAxMx8vax+n5mgpS4pvFn6MVLIgHulNlRE/QGGYw5ouQt1mOgOJr5YnQ5TLgnSxcHAcTUxOn027TwGX6qpiZQfJd+3+32pbxdF4bYt+KeeSYcr/pZFbJHkmnxYAe7lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103703; c=relaxed/simple;
	bh=KyL3kYPj+ynCqBkkIgRzK6ppMn8Q42vYTthv6ynTbZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dK4iN0jNLVHob947MpyHccVm4BVwRIR/QHlzrD7Hq8VfDYeC/WklxAGdx063xLRQxjv8nyASM9DI2SChfFHX9osHhRnuLsVumvF7emDkOrkiQYbmpBk6D78H5NYgh0kFp+JBJDSQhQ7Uiopfr1y9lb7GuczcVaW3vtJ4rlh6v4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bFi4ievt; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f6e1f756so2246314e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 03:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732103699; x=1732708499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cYPtpbT0rYtV4i05WMfOS2O/bZheBplF9irAJrqd1/4=;
        b=bFi4ievtEScwmDM7Bx35Jb0KUYHv1qAtn0XgyOLgEcgXDSXWC7niq7/DDAo/IG8Zaz
         ULFzEsIwP+WpE4keSDZ5Dm5OphVKgkTeKk9JD8kMFYu+RDpmo4KcFKt51zymazfTTHt6
         zvJfgrnJxaAC4AhqKzqRSC38oVc1Xq2NX3H7gEzjcOqh3QqLTNgczPUnxOo5Efm925Yo
         Xmg0jwbARwdx0LQgAXeTGqZ1x+0dYa5G8G1XSXMVfUkotPsqHiHKntB1x6RpyUxhxUXy
         AEncxeZtAwxGlnbre2njF29IoEpiUSAAuYjXchH224bGIfV88ijV/Pvyy7iDz//2m81g
         eURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732103699; x=1732708499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYPtpbT0rYtV4i05WMfOS2O/bZheBplF9irAJrqd1/4=;
        b=RDQo/6fePHZfdFRO652Ka+cox1Sh8owH/H53yTFwvS+a/pz6vvmceDwOFlzZBAjqP5
         jNDQSewndi8CeRJ8GK5DrmHU38uQuWUjVs2E2k4Zut3qUcbmBDNTym8E+4m7rvnvYYXD
         aVOaOl1INp9lFFdIZfytEPSIWHqpD5W3hQC6ha+/AXRc3UGC6SpWHEt7Rg1/GeL2jWV6
         9KDpogyoTdJeRNXFGRXaJiV/AgJK8DSgXLljF0F4rHSbBRaglrRHdD/Sl7U/VPNzIh3i
         xZs7L//soR8wnVQ7H2dKwZL6Dkf5YQbylF9K2Im0S0oqMNVxAewTD+jMdf5qQoIW7CDc
         nejQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+F1jKQUXPu6wqqIZY6isOFAuyvyELfyXERJZVvmHd4dWVddGOOe8doQh2Ud6jNhCHUXc0s7hKitbJGVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbLF9H5Tlh+F28uncq1ramhk6lMtSnJ84TVsV+ZO3a4vj6kGDM
	+IqdsTtEB8NjUvEbMPypBrOIYH8OWzYQbrShE72LzSPvdKz2s0CuaH9e4T4K1ZIV+7urjpxg478
	y
X-Google-Smtp-Source: AGHT+IFMequDT4bdY6LP9O3I5AvvXInQUMDuGlgE0eHlxcbATY6rHghGabLIkWJMyNfHChGofJMPQQ==
X-Received: by 2002:a05:6512:1303:b0:53d:a883:5a3e with SMTP id 2adb3069b0e04-53dc1369cb4mr1005535e87.39.1732103699572;
        Wed, 20 Nov 2024 03:54:59 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd3edd2bsm608508e87.43.2024.11.20.03.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:54:58 -0800 (PST)
Date: Wed, 20 Nov 2024 13:54:55 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Kuldeep Singh <quic_kuldsing@quicinc.com>
Cc: Pratyush Brahma <quic_pbrahma@quicinc.com>, 
	Bjorn Andersson <bjorn.andersson@example.com>, Konrad Dybcio <konrad.dybcio@example.com>, 
	Rob Herring <rob.herring@example.com>, Krzysztof Kozlowski <krzysztof.kozlowski@example.com>, 
	Conor Dooley <conor.dooley@example.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_tengfan@quicinc.com, quic_shashim@quicinc.com
Subject: Re: [PATCH] arm64: dts: qcom: qcs9100: Update memory map for QCS9100
 Ride and QCS9100 Ride Rev3
Message-ID: <rnrxb5e7xcgnjp4y4id5m5dyswii6xipry3bvtpit2f4c3iqfy@qghr42jz6oze>
References: <20241119092501.31111-1-quic_pbrahma@quicinc.com>
 <30fda0e2-f314-49b8-8c1c-bf4fac87050d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30fda0e2-f314-49b8-8c1c-bf4fac87050d@quicinc.com>

On Wed, Nov 20, 2024 at 01:41:03AM +0530, Kuldeep Singh wrote:
> 
> 
> On 11/19/2024 2:55 PM, Pratyush Brahma wrote:
> > This patch series is based on Tengfei Fan's patches [1] which adds support
> > for QCS9100 Ride and QCS9100 Ride Rev3 boards.
> > 
> > Some new carveouts (viz. gunyah_md and a few pil dtb carveouts) have been
> > introduced and the size and base addresses have been updated for
> > a few of existing carveouts compared to SA8775P. Also, tz_ffi_mem carveout
> > and its corresponding scm reference has been removed as it is not required
> > for these boards. Incorporate these changes in the updated memory map
> > for QCS9100 Ride and QCS9100 Rev3 boards.
> > 
> > [1] https://lore.kernel.org/all/20240911-add_qcs9100_support-v2-4-e43a71ceb017@quicinc.com/
> > 
> > Signed-off-by: Pratyush Brahma <quic_pbrahma@quicinc.com>
> 
> The memory map for qcs9100-ride-r3 and qcs9100-ride is exactly same.
> A good churn you are first deleting(based on sa8775p) and then re-adding
> for qcs9100-ride*.
> 
> I think it's better to move common qcs9100-ride* to a common file ex:
> qcs9100-ride.dtsi and keep specifics further to .dts files?
> 
> This will ensure common entities are present at same place with no
> duplicates.

I'd second this proposal.

-- 
With best wishes
Dmitry

