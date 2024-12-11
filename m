Return-Path: <linux-kernel+bounces-441396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FF09ECDC1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC891285B24
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4186222C353;
	Wed, 11 Dec 2024 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mRLikzjc"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04A4233690
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733925386; cv=none; b=ZuPRlblyqPjlXMEYDhLcPircIDCk6Fbi/E0RUkeSNxOkiGQ2Qgbr59VDoPakTm/wRpKs6+/sUePsycxVnzNxTs+IaqrbJ98UNSMCH/0wQPHWgOJhbCyfwPRjw0n18lpneU/+Ozpv/mHy2/L6cRZuuPs7Cy886G3OFCVatOktHyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733925386; c=relaxed/simple;
	bh=jJNvd5CzRMOJ5gUrBQXY1b7u4hCix9pxT1OewNbVyCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhTk9rfVvEc7iexQoL7mNb0l3MKtKbJ5bMSFjyM5yQvvqATTGz6qzRESNtGNDZA9Dq5vHC97tr2gdkr2JUiR/4IXYM+JzlaodrfcJLlG9zoS9G2vcJfn/a86OErjYTSTQHE6LrX5Oug/1gDDDr0re6caXdZ3CrtCjvmSoL00pYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mRLikzjc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4361fe642ddso4505585e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 05:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733925383; x=1734530183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jtSEM+vm+bIJ/KTsXmMQlqO+KHdG4/pkOfrFSV7O0Lo=;
        b=mRLikzjcayj7jg7rQppmNaqnvV6z25LWDzY71mbo84HYprBkKtze/LrPHGqB3YlB8r
         pp/21g1/Cvds0yKrtnLI5qckd/1L5hU622ieRwdBQ5sIiUAUXQTT6vPEIWEBdME+Pxxp
         PutO3Vbvl+lhJuaCMzVyLXvdQRjtJfqWpaZ26pzTPPyXaw324EWdmYeRAxE7IijdHqW0
         MLNkMM6MvFi3t28R9P8Bct5TUDnqeyNrjUwUHg+U4ktWUymb/ryeiYkeZ5APfxVuRfTt
         Ngu9ngl79yRx/9P7xoUHGVeiDCkliYFHJlaakqAd25xerIyTM1CnjNr1FYUMBwIMYYX4
         rsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733925383; x=1734530183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtSEM+vm+bIJ/KTsXmMQlqO+KHdG4/pkOfrFSV7O0Lo=;
        b=vDwxbP+qdcdlVXzXRQdpighsEsijGwUlYEVH81HO2QOLrt5ihn1RtfO1IFbbYPm6RD
         L8BnPlWJicxmPs71JABVAHxId0BqlTH5Njg8osPjdnf1x1YB2r3RCLxqMcypcKZchcGC
         loHGKXHwLIsBMsFTkaTUbwTdz+eXZjs7h4mrmQrC8oBn3qmhpQ+nHB6ZKw46VLK0iz43
         zRcLlmGMSpKhJvHSWJFRSXxNUnlXmhXzeq5yAzgpXygXUdBW4iaPy52xk4xopGYHW8No
         2K/CkV/kUJIeWgIy9Js7cNbbZUHyZqXkM+NXsfSetYI5UE3XqzHpRqPpxchLuGPQPjv9
         SumQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPtbsuUtNZVNhiDxrgFi1CWsKXBV6NvbKxqoMYVjkaYLjvFOHAK1VFq7DMz44irzFY3YfaON8rIlynAlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeqY9IX6CiwjVazt/XrSgrmX7Lef8NJ3P4/aklNJdsaRBAKPfT
	JejUEGHWkFk5g/Y1l7zkC3uzno2d8X4keHYLj+nID3524nplgTktlMrgnOLse/0=
X-Gm-Gg: ASbGncvpjiFEifV9WYQnom2T076cKPqquUnnTzdvUX2GvHN3y8nVJlk8YpJ4JkoqhM7
	naeuKQDlql/l1FmNvFI4hPZ/yU4HpRO+9GvRqGS+ycgQFNki1bI/eLZ+rf5XkONgy69rhH2qfH4
	54EMdfQK6G8NA0S/A6jtNeDNZpgzsOd6f6WV/Uhz6xjYDcssUojpkwwNE0A9zKP4EO26RajaYYr
	DB/80TklTQuDcjDfmZT/MUEDEgLk+1rzPKDVNe12mpnLZgP/Y4/
X-Google-Smtp-Source: AGHT+IF2z7GNLeCXaPcEuFWlypAl7tCU8l7GX3KX4YAoY6IJG61/b+lP2czNLPCrQwDT7QmPykXLwg==
X-Received: by 2002:a05:600c:c89:b0:434:f5c0:3296 with SMTP id 5b1f17b1804b1-4361c3a35f8mr23007175e9.18.1733925383220;
        Wed, 11 Dec 2024 05:56:23 -0800 (PST)
Received: from linaro.org ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4361ec75410sm13569135e9.1.2024.12.11.05.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 05:56:22 -0800 (PST)
Date: Wed, 11 Dec 2024 15:56:21 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	"Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: x1e80100-pmics: Enable all SMB2360
 separately
Message-ID: <Z1maBcM3jG2SjhAo@linaro.org>
References: <20241210-x1e80100-disable-smb2360-v2-1-2449be2eca29@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210-x1e80100-disable-smb2360-v2-1-2449be2eca29@linaro.org>

On 24-12-10 09:36:01, Stephan Gerhold wrote:
> At the moment, x1e80100-pmics.dtsi enables two of the SMB2360 PMICs by
> default and leaves the other two disabled. The third one was originally
> also enabled by default, but then disabled in commit a237b8da413c ("arm64:
> dts: qcom: x1e80100: Disable SMB2360_2 by default"). This is inconsistent
> and confusing. Some laptops will even need SMB2360_1 disabled by default if
> they just have a single USB-C port.
> 
> Make this consistent by keeping all SMB2360 disabled in x1e80100-pmics.dtsi
> and enable them separately for all boards where needed. That way it is
> always clear which ones are available and avoids accidentally trying to
> read/write from missing chips when some of the PMICs are not present.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
> Changes in v2:
> - Clarify commit message, there are actually two SMB2360 disabled by
>   default (3rd and 4th) and not just the third (Aiqun Yu (Maria))
> - Link to v1: https://lore.kernel.org/r/20241203-x1e80100-disable-smb2360-v1-1-80942b7f73da@linaro.org
> ---
>  arch/arm64/boot/dts/qcom/x1e001de-devkit.dts               | 8 ++++++++
>  arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts | 8 ++++++++
>  arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts    | 8 ++++++++
>  arch/arm64/boot/dts/qcom/x1e80100-crd.dts                  | 8 ++++++++
>  arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts      | 8 ++++++++
>  arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts   | 8 ++++++++
>  arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi   | 8 ++++++++
>  arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi               | 4 ++++
>  arch/arm64/boot/dts/qcom/x1e80100-qcp.dts                  | 8 ++++++++
>  9 files changed, 68 insertions(+)
> 

[...]

