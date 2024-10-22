Return-Path: <linux-kernel+bounces-376019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC2C9A9EB2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FF381C2435F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA491990DE;
	Tue, 22 Oct 2024 09:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DECCXxuD"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F7912D75C
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729589922; cv=none; b=ItOE3ImvS5S/nzFjznEEXBDP1kvi0AGvnekPneZ9N4bEFVTBmSz6YQO7zS/VRx/bVZX9gEyj7aJJZKtohW/c7jG5Hb34PosUxhIGZ/xc9UmuETw5YIbtz1qjW3Sdrj8Cq7xOkwQoEb1kUBSfc+OrjoERNepb7Kkc97TgkEz1V+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729589922; c=relaxed/simple;
	bh=jtL+q1k/uNxoSxNFpXI2oLIDpt4U4O6GXFFLuZ2PuzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QhcU2aoBB3PTtPvt5LlAkGRRYYKJ07khUuApq8gJbXfpiOftplxXc48juBvUV97Ldixa5xhLe14SvOdek2GdaxJIqfQnGy/rSi2o8q6loK3exbEgS5etPpLesYwVYKHNnPGQXhvxzeyTfo9AJfLJKxdtYnK1c0Vpogvb3s3GT1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DECCXxuD; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e3d7e6f832so51957367b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 02:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729589918; x=1730194718; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N/5Dg47fBjY/YhFPEspJexC0cvl06u9WdqmPSroLAzY=;
        b=DECCXxuDCv12XfhmXec7uJZKwdDohA7QlODHM3tW+ShwMFJRkERBxzTn1h1PgGi/JZ
         4VFxq0toK/NQozgUlEM2Az87dvvIomBmoPMGs/EiE/K1787934h+/5kuINBm+1fFRDbV
         iasRCDHL8i9aVEKror6MxSgKyN/j+NTdG2bZjHXaF6EvvD+rdjik0yKCjmBFmZBhcokd
         38TFHqkHdPuUNPflC7KE2j4oAk5Z9so8+JfjTwQDDhH7N06CANOKtulAA6zyd6vU8io5
         6JLYc4ac7Uv29sK22xodCwQTJoZd8TDbOYYSSOjyH2rSe37kczejuDN4on10Ox/0yEfm
         gGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729589918; x=1730194718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/5Dg47fBjY/YhFPEspJexC0cvl06u9WdqmPSroLAzY=;
        b=cm2AV7DNpI+P1aOrX0+OWY4LUuj8WGGq2ySNC1mTAPsO+Le+05aUMOS5UzCJMziMai
         1h1ReX+WFnkriibmmuu3RZ+1KUy1/bd04CmZfVWOvkXJzwYC0X01GpFkQLfNv0JntBnf
         SGE1O7WCdHia3IHcX1jApJm06vcknvl5B3/rz2/fxU1LY6cgVV30vhuacGDEhQhPi0Pe
         VM+MOBusT3vmw+ykNqhwOJnsyLbFwP7tKQKn73419ngpR4VlDVHCbSfZ6mDBM8iVmFqm
         7tG/0OSAbAVHzI6xPHu5786t83CCS/WqbZ9xeTh+rSshPcw8tH6D6SoNpkCsQRQQEc2x
         3e8g==
X-Forwarded-Encrypted: i=1; AJvYcCXveR9HaEX523BbA0V7AZBtWf/TdX8JGJzMp4htcxO6ARxaE84/zAB5pyzzSWuTYE619lsxQW+EYC7oeBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCTntpsiBwcjQAGOwZZOcTc85nz3Y1YPCnMoOXCygmERe7ffdk
	yD/LRGt2heMnDcM1Z43LkXZ6lrrTqaimWmS3cPxz8z+WBJbnJ9c/VEicnoQkEdkwzVnFCcc5kXy
	Mz0gqMDc2nUebApxtTKzp2Hm/Nv7RhQfXs1AVZA==
X-Google-Smtp-Source: AGHT+IFOJm8RAn0EsBkDxk6LqZTnRur9nRUufhWOLHK1CxgpCVThwipByBxtIeBw59Z59ke0ZItxJl9xZjd0Aa6JrTs=
X-Received: by 2002:a05:690c:ecd:b0:6e2:1467:17c0 with SMTP id
 00721157ae682-6e5bf632349mr128695137b3.8.1729589918568; Tue, 22 Oct 2024
 02:38:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014-adds-spmi-pmic-peripherals-for-qcs615-v1-1-8a3c67d894d8@quicinc.com>
 <p7fw7jjfawbnk2vb7zdtr2dp3ni4g2uuiwvt6o4qva53zyrpvd@kokibgaidfzb> <5c23a6bd-e233-4b02-86cf-902d2c57c382@quicinc.com>
In-Reply-To: <5c23a6bd-e233-4b02-86cf-902d2c57c382@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 22 Oct 2024 12:38:27 +0300
Message-ID: <CAA8EJppdQsGe-R5JKRJ9LJs9xGTdhkCGYc5NyzVSLA1bWvvUwQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: qcs615: Adds SPMI bus, PMIC and peripherals
To: Tingguo Cheng <quic_tingguoc@quicinc.com>
Cc: quic_fenglinw@quicinc.com, quic_tingweiz@quicinc.com, kernel@quicinc.com, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Oct 2024 at 11:26, Tingguo Cheng <quic_tingguoc@quicinc.com> wrote:
>
>
>
> On 10/14/2024 6:53 PM, Dmitry Baryshkov wrote:
> > On Mon, Oct 14, 2024 at 06:08:17PM +0800, Tingguo Cheng wrote:
> >> Create a new file qcs615-pmic.dtsi to add on-board PMIC and peripher-
> >> als in the PMIC that controlled by SPMI bus. The peripherals include
> >> GPIO, RTC, PON, power key and resin-key for QCS615 platform. The power
> >> key and volume down key are controlled by PMIC PON hardware on QCS615.
> >
> > Why do you need a separate file? Unless there is a good reason such
> > configuration should be split between the pmic.dtsi and the board file.
> >
> One reason is that I use upstream as
> template(x1ee80100,sc8180x,sa8775p...), they all have
> platform-pmics.dtsi alongside.
>
> On the other hand, qcs615-pmic.dtsi contains only the PMIC's
> peripherals, creating a new file can eliminate duplicate code if there
> are any other new boards with pmm6155au as their PMIC(similar to
> x1e80100-lenovo-xxx/x1e80100-microsoft-xxxx, where "x1e80100-pmics.dtsi"
> has been included).

And this is pretty unique  to those platforms and it exists mostly to
facilitate the case when a platform has several instances of the same
PMIC. In all other cases (mobile, IoT) usually there is just one
instance of the particular PMIC. In such a case pmic definitions go to
"pmABCDEF.dtsi" to be reused by the platform and then board DT can
include that file and wire it up according to the platform needs.

> > BTW, what is the PMIC id for pmm6155au? Is it a real PMIC or a version
> > of some other PMIC?
> >
> pmm6155au is the PMIC id(Silk scree). It's a real PMIC for qcs615.Maybe
> I should use the name qcs615-pmics.dtsi instead of qcs6150-pmic.dtsi to
> align with other platforms.

Is it the same thing as PM6150? Or is it a combo of PM6150 and PM6150L?

> >> Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>

-- 
With best wishes
Dmitry

