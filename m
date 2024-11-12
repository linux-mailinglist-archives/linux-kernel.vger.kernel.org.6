Return-Path: <linux-kernel+bounces-405968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAF09C596A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24C771F23290
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2065A1F7068;
	Tue, 12 Nov 2024 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lxcwkGQs"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1CE1632C4
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419107; cv=none; b=eO86J/+nDMpgVs9yAfF50gLDvhK5urtcOjx1zFUqaqKNKSTVH4hsaJJ+5duGL654i0GI61oi5cX/QPo2G9ljNs3UxKQ/nAbIrzMBglsZgs8arc8Dp5/1mMBxXiJau71xdzIlRzA9ayRvfnu9GYbO6UR6LQBrxpb5j9a59eJcGqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419107; c=relaxed/simple;
	bh=nF71dfXw9piCIlT2j/742VJmP1SWGegOHqfZKKdLKlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uH0Meuc2RNWIjp9lSmjmqipDapakNeiUvKLsPdbYwNp+v1YLmbpw2arcXrlLzqlLuQkrUWB71GpjY0HF6Bxp0ghJ4a8gT6f47ztZNkzyu40IpGvgXeSbWX1wha+AKhylB3uDGE7bJZTjbW7mYQsEk0d3LDygklwleWcgEHSZ5Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lxcwkGQs; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539fe02c386so6366675e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 05:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731419104; x=1732023904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p8XhL/KO7ax4DYfSEQl2Gemn7CXDKPvYLisy0AOZrYc=;
        b=lxcwkGQs4+0XP9ra9K+anbA8sJV894bMriN4IrhuN7H0cKQD0qvVTsRNrLO/ULABnj
         n9EewOya4VEjIdaSyPis++Izc+IZVQ7w7jLKSJw1yqXABZee3Aqb8BXv8nXnpBiv60SM
         NeUDvfyn6wimaBOZS3cTjMUB5u7xExR7YnMf890XLDzSwizSDYLzUNkdf2XVL4O5BEA6
         1Oxf1hHmGtQ00pcdx85c3XWdCYf4tS6SrqCHpDrkEo5Lz888g/w9dY8AcGDh0qZtt2X7
         LTNGkVgfdtCVJ29WA25Cg8EU8xfzuqlNDyvFVq/f5Grj2PCNy4ii09zRdXj6IOri6jk3
         9mxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731419104; x=1732023904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8XhL/KO7ax4DYfSEQl2Gemn7CXDKPvYLisy0AOZrYc=;
        b=G7wa/AzOSIdE/gLcRav7wLtSalYOkqcatyj0zv326tzLkVXgxAO4LO/DWgwbFP3VqB
         IZy8Z5z8kX7008TMcliexpKwecY/6P4wBr4ulnaYNyTWGM3Yk7KHSLOznqtAjIM3ebPQ
         jj4a8MJqEV2h7fM6p8JB468V/bkX9/OWGSfBhqiYK5qvi+VBfKEJhjqTwkS3F++1Qo9n
         25yaDjGBvF/AVFsN1mXS0AFG91JpUOlh8WWlS+EuqqXIdnWnaXvuv3JpqIPDIyh4oo1w
         agwvwTkLT40jxdCgiCPikh6QEJF8+OtOqm4t+ldyyacSqk+3DArG/vjx8dGUrBCrzGmV
         ENeQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1tcwy51tkzPUAj+loBQ+kVgyutIKvp/6UMj+ZOOfj5XCp1eLX9A0ws3O6B0gy/MaaNxUJ8V6IGXRieXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB55wO8EW0EBc/WBaWrBJhjoYn6CFFTQeTU3aXwOcimkNk9xNH
	+cgb+8vJu1Q+/pa02u5Fvx+wceXDOoA7MhYL9aowxabK9xtfWBiTQ9SFMp5/Og8=
X-Google-Smtp-Source: AGHT+IFAwO32Ncdw+qEGZ4aWRj0mcaaHcO3uY0rwX+jAaJsbwSik56EmV6ZmRwhhKG4oqdNuqcKamA==
X-Received: by 2002:a05:6512:124f:b0:539:ea33:c01b with SMTP id 2adb3069b0e04-53d866c91d7mr5071381e87.9.1731419103995;
        Tue, 12 Nov 2024 05:45:03 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826a9c42sm1890161e87.215.2024.11.12.05.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 05:45:02 -0800 (PST)
Date: Tue, 12 Nov 2024 15:45:00 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, gregkh@linuxfoundation.org, 
	andersson@kernel.org, konradybcio@kernel.org, mantas@8devices.com, 
	quic_rohiagar@quicinc.com, johan+linaro@kernel.org, quic_kriskura@quicinc.com, 
	abel.vesa@linaro.org, quic_kbajaj@quicinc.com, quic_wcheng@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 4/6] phy: qcom: qmp: Enable IPQ5424 support
Message-ID: <i6z3rplnp2awqwqlkpwwzgaweoxi5yi6jz6klveop7namcovns@q5aecu5mcb3l>
References: <20241112091355.2028018-1-quic_varada@quicinc.com>
 <20241112091355.2028018-5-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112091355.2028018-5-quic_varada@quicinc.com>

On Tue, Nov 12, 2024 at 02:43:53PM +0530, Varadarajan Narayanan wrote:
> Enable QMP USB3 phy support for IPQ5424 SoC.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

