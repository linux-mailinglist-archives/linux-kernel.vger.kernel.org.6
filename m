Return-Path: <linux-kernel+bounces-392137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B1F9B902A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C63328282E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D46199238;
	Fri,  1 Nov 2024 11:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D0+H3b1C"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6BC19923A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730460118; cv=none; b=GTzjvcrZUyIg8old6sTuqZEc28Xdm0A4rA7KPVathgceuaETV3ZfIXLJ02TXknjjwZHLrZpNGSWKZXw98TnQulyUwsN/+TRhyGQDzseJpzN89iD1foFUTrC0NrrPoQV1KOljAvu/+KG/p5NkwcUd/dROZtUyq8a5L5Me2DDuheM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730460118; c=relaxed/simple;
	bh=KoTvzO8VKEqtuA3KrJa8XxyQcDEmRjc9CaAtz8YICLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cv5nq1eARAZApq8F4yIk3KVkZq/9UPCh9NEzkML6tXycFKgTFSbs4Ykkt429lMyCHcuLP+2rCemM3JLeEkkW4VNsGwDp77HrGH5Z20XesyL8kWDW3SwmFPPmHDdTsobKzLVNhPbRJ/9Q+xBKXXgBuq8bG0wkqw59wldCCVvxE10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D0+H3b1C; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so1502347f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 04:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730460114; x=1731064914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eXKsOWR/wJ8s/vomPLhl+IstAtu8+B4WWYmjYIcAfF8=;
        b=D0+H3b1CJsHsW37MQ9JBJ/6HJLHuK1ZM8h2nikhAD8L8bG8AqhMBJ/rvNlKvvOG+bL
         6b0PSWwpp1Zx2qFi+p301nVQAd9H5/9W8Crdi5yBiWEfMz7ppIIRzDI3iCgCxiBHqTgc
         20D0trc1YBuF/zNdp7TGWFPqbffhk7rDm+PUdEIAny07XC5HvoawO/0Tk242VBQQ7I4y
         lSpQ1rTUtbeEjQ/SpSnwwURJuPaEhg1c1DnExTPnpXQm0s39OWBSWA6b3TZrqKtmxDhX
         gWqYa3+6ByhQKu9mtWJWJu85StsKS2kq6MG6oeiQcnlh+jD0bCGvILDQSyDaiD1VwcA9
         nzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730460114; x=1731064914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXKsOWR/wJ8s/vomPLhl+IstAtu8+B4WWYmjYIcAfF8=;
        b=vtDPiwj4wwviZOsxx7LmJo0IXVvgWNTtDADGNZ5lpltK2ThcvVq4WM1Cdd8kYxII6G
         1L2a8wHQkKB8tVDyn5NuIQHE1DlrLh4FG1RRKozlIRZ5LQeBUwX9p+hELlWv/rYfiX5j
         myDTE0/IKsNOH1rfoInOST15TlfM7E0HINKA2Bz+zAcaqta2oOiydV6n5sj11YQGwPhZ
         7MVeEy4HkWiYzMy+4d4RuoBI912et4Xja8UZRUt9zkOnMD0XorZjeJc3khv5SlM3d1b1
         G1n6P+plVkJPLboSpgPqdueBTKHURGIhOKLkziJl6o3OcTpsYs7ek5JU2TMnjVaGNagJ
         cufQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxomThgdUN9ys4Y9OAAbahIxOdD1Ib08/V6vKksm+ajO3euu5nysLdeeZy8mEF8NUS6B33nJxy+U6hd7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyebeeIOkOVU8IPvZ+DEjl+QOBzIaeQFiBLQsdDHh35xCVFOd18
	jhZpoZaEcVzZkoV32CaDWJvWqZ1PCxE2bPtMvt1FYKyfUhgrfZyWWXdr9VM8kx4=
X-Google-Smtp-Source: AGHT+IF1Hi3RvwWs7DSq+spdpzYUhwOwwmzTbkypHgqr1nBe6xd71RG+VXm6t9yCvd53dDUoi1AkKw==
X-Received: by 2002:a5d:5a13:0:b0:37c:fbf8:fc4 with SMTP id ffacd0b85a97d-381c7af3be3mr3201528f8f.59.1730460114103;
        Fri, 01 Nov 2024 04:21:54 -0700 (PDT)
Received: from linaro.org ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e89csm4808765f8f.74.2024.11.01.04.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 04:21:53 -0700 (PDT)
Date: Fri, 1 Nov 2024 13:21:52 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: x1e80100: Describe TLMM pins
 for SDC2
Message-ID: <ZyS50DFLhHVlnRtd@linaro.org>
References: <20241022-x1e80100-qcp-sdhc-v3-0-46c401e32cbf@linaro.org>
 <20241022-x1e80100-qcp-sdhc-v3-2-46c401e32cbf@linaro.org>
 <a282021f-5e61-480c-84c4-272049e28244@oss.qualcomm.com>
 <Zx9P+HQMOkJsJGcj@linaro.org>
 <327507d8-2dc7-4645-ac3d-d68ff31a84dd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <327507d8-2dc7-4645-ac3d-d68ff31a84dd@oss.qualcomm.com>

On 24-10-28 14:10:54, Konrad Dybcio wrote:
> On 28.10.2024 9:48 AM, Abel Vesa wrote:
> > On 24-10-25 20:34:19, Konrad Dybcio wrote:
> >> On 22.10.2024 12:46 PM, Abel Vesa wrote:
> >>> Describe the SDC2 default and sleep state pins configuration
> >>> in TLMM. Do this in SoC dtsi file since they will be shared
> >>> across multiple boards.
> >>>
> >>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> >>> ---
> >>
> >> Not very useful on its own but okay..
> > 
> > Fair enough. For some reason, I'm not able to get sdc4 pinconf
> > to work.
> 
> Any chance you tried to define 'sdc4_cmd' etc.? This one seems to have
> sdc4 pins on gpio127..=132

Yes.

But since the sdc4 pins can have other functions and since there is no
device that uses them (yet). Shouldn't we just skip describing the sdc4
pinconf entirely as that should be done on a per-board basis?

> 
> Konrad

