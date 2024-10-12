Return-Path: <linux-kernel+bounces-362114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 347EE99B141
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 08:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92F6283F67
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 06:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E412F13B2B4;
	Sat, 12 Oct 2024 06:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ijQlXKcL"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C6A13A26B
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 06:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728713879; cv=none; b=K23qTatclsQVC0EXpQIXEFb5dolk1POCWdf6aqAazgwQa7Bex4eEbbNP4biW2yPetvI1jVs/ELYBNFT2hZS66hsTtjzlxBC0+EEhAwg32vhAHCwbjjBZFdafsuPqTcd4kobsh1GyJeihRJTHsT3y/tSsGqaJ9rpZHejt9cdiv6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728713879; c=relaxed/simple;
	bh=35uxd4xytmpWtfl0pjeAVBocR5PQ845hs9VhCdoA424=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rt92faoJYJJaJEWPpwC9+H/gCV0EChYGitw/tkkdtOhBhHvSJOW/w1miFYrHVG+lQWR2qwKPug1CmUktPw/YecI+qZn6gMSfyba5fAyz+yct33CKZvUzrTW0BzzBFfaw68ppKjSHkStjug/RWfplJF5VG0J2ckeXW7x5IBoIulc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ijQlXKcL; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fadc95ccfcso28598971fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 23:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728713876; x=1729318676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Q7VycGiDmbT8NDIEv3VX1atPVNk5kqPI5PABIHipxI=;
        b=ijQlXKcLu//gjp3TlT6408r88GZ0nEd84k16poYjrTfUuAvA5dP7UPinXDsBY7dzpx
         ffHQR8NVvW++Xi4Vf+K/R5YobAZhVPSkiRmXzes4LfTGzrNzRQ4hd7cZLaVpXlUpkZqr
         NVsFb7xm2Cz5ostAr1Ipj5Ilpj/UuzTkW1slopps+cK4zUtVvI9wwvFehNorkC1rsXOc
         ENb1W77E78fAEmnzgBm7vaIVpKOPRKkKLn4xEF0Udfx1AwUwv7feUJnNrx44ijJyUEQk
         eeiB8cu1k8m6nruxsfvindoQOuJk0+qCqndd0K9aMjFUUDTP2Bm9OzRkD4xIkNSD53YD
         GFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728713876; x=1729318676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Q7VycGiDmbT8NDIEv3VX1atPVNk5kqPI5PABIHipxI=;
        b=TQc/vs1nPkfCAelaXz59tH0/7E0I2P0czS7KXADQy4beWJRwx6GbFUVdqIG4dOLVhG
         ct4x8Mcdjt3onG6eVPKiSNPW7VcpmFEpDoeVfbDvh1P+hY855MNqPaCL7zVpozTn1ot8
         hh5+A4tJ3agWDTqPW1N6H1mDNZx7uxwOH7/IkXN8/FTUFjr+9al3hPI+eKycCaX1LcdQ
         1NHo0YYObiMCu1XMvzNEK0ZxlG4OHpz9UkjMLTGFUm1xuCdxtWoomRYqp1WSF3eyexe6
         UDdIQStsex76octtslFKFGwHaRPtoLUTDzwDaXbjUvqdXYGtJSfqIEIL1yssNJSST0Gw
         yZAg==
X-Forwarded-Encrypted: i=1; AJvYcCWR1JcsceXByZf9T21Cs146jx2HnUTImv+VWqr8ed5UwATg+VWJaILKDK/SIuEHWym09XXFpkT3A3Zd6sA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9QsO5fJ/iZp+IeZTxQYSPds85iI6VcCF+9LZMpCWOVuao/xz9
	7nrcLGjJ8oNlQH0efTncBwoa50SGwMvzyR4FUqXFnpMrhGMlDDdTCaQ4N+nJvPw=
X-Google-Smtp-Source: AGHT+IE+lAgJkNquMREXe1TmPbV+3JD5TMKDHxMdgEkU0ZUlRFxtWBhCUVpjtMxSfHO5beBR9qTnQw==
X-Received: by 2002:a2e:a549:0:b0:2fa:e4ae:3388 with SMTP id 38308e7fff4ca-2fb32728039mr22489201fa.15.1728713875647;
        Fri, 11 Oct 2024 23:17:55 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb2474c5b4sm7187341fa.117.2024.10.11.23.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 23:17:54 -0700 (PDT)
Date: Sat, 12 Oct 2024 09:17:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jonathan Marek <jonathan@marek.ca>
Cc: linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: x1e80100: enable OTG on USB-C
 controllers
Message-ID: <f3xyjvxnuonzk6adxbbbrhg77bjnvl6xnvddfm2b3dselynwbj@zjtldmkwha3s>
References: <20241011231624.30628-1-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011231624.30628-1-jonathan@marek.ca>

On Fri, Oct 11, 2024 at 07:16:21PM -0400, Jonathan Marek wrote:
> These 3 controllers support OTG and the driver requires the usb-role-switch
> property to enable OTG. Add the property to enable OTG by default.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

