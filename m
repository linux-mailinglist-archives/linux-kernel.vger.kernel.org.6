Return-Path: <linux-kernel+bounces-525148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB9DA3EB83
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 04:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503B417C56C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 03:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D221F9EC1;
	Fri, 21 Feb 2025 03:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MdoQ+p/i"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59121D5160
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 03:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740109744; cv=none; b=iDM+7P9VCclttHkRJo/hqOJ4Ob9Ry3lq9SKeNin1RmrUMvcc5NeFIJDLkMWnJ9JYASOy2ki5uGG5B53PUHCzQFOwcTKzPF+Ywza3YNvCNSiITkVxsQr5PJ6XINxg7q7EFvOf8si2Z1fi5xhJJvYvwyAM6gIQ4PTIX1ktbJheHEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740109744; c=relaxed/simple;
	bh=xhkT06minOaTkf8wZ6rirZdUYd9gm7Mgu2p44K15dwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0UzN8P3R1tXnHh5RmtTDX5K4iv6fwSnXmEYv0FHMPp5WMCLtJSXDgaFj4CxNaENL9kPaWj8EyWWvkNd/wHYIcZlYKw6iXe8p4nsERFeg2XAVejIRKOz7I5aL+eKRtiu3iPFU5m7rbxiIf+B3kh2fd17kQPQC3waBDt28Vu9twA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MdoQ+p/i; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30a2d4b61e4so12361331fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 19:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740109740; x=1740714540; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d1AVackadfhPpCMLLKH7Bg03NDXVVtj9z1+w6CdVYcg=;
        b=MdoQ+p/iQ9vKLQkrdK9sFWKd4/s2MOutj1kVIEmpH1cv2D5+Atd8uSChsczYHcHPXg
         eqRsEHgXyrBurIi/ykiG53e/BkkKmWk6qgiB3/CQpwaemfJkOMvvWBeHzTyuiAhrj7j6
         QDGucE/XgdwBYMuGKHcd9mp7W6MyAnmjwqzYuljutIIVLqogTLEtsU3eryC6Ut7NlUU5
         4Pozun0i7yqCNny32k8wZ+WjnEt1NIR8u6kh0GoD4yF5K5F9HTBgEmiFWq2TDlhtRPLF
         eCNvMJoQkasQlkHyZgZBcimeUutfPOhfprp9Qsq4GqVhmKZs89pMBlVXhJ1MsszaTra2
         nPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740109740; x=1740714540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1AVackadfhPpCMLLKH7Bg03NDXVVtj9z1+w6CdVYcg=;
        b=uHlaW+K+6lTkVMpjJcrYmxX2YzTMGVei006BoJB9OLtnL4w99RBTkRt04TUoIuNkFZ
         QUCgJCrBHyg4KLGmmYgl0+cHpUct6Sz/g0pPXrUx12YaxFh9/xdO/yJyRAEuxmuDxuuu
         ohGItCsn+oedGsUBZCKriNLymnGuIMr4jaU77o0npcsM+ILExzIkCDO5tFC3QkVwyJuV
         /5l4PfWUeyBuoBpmFIVe97A9pcmV7L2vb3QxwrvDWbEokVLJIfIjfpJ6yFwy9L0tasQ6
         UvcrWiKKjFeIb8Nkt+qF9VBGCXw0h0mESQCxyKsIl5n5q3Pa2XXESer/Bi8Pkh4jbcg6
         9Uuw==
X-Forwarded-Encrypted: i=1; AJvYcCVHlLEav12pv8eFZsXvZlcM+ViIbombMW1rwjsApQYQn3Wk6nmq4AJy3q4p9KrDtoyqoPZeODoPUI+e80Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB8Ip3jTJXhWYqQg+BYY1erp5IoE326fn/jGswILacmDCQaud5
	JgpzSrBjxHUqiOp1Fkg06sF08KHs53o8alHw3dg3Taj9vreDbwvZKGpPfwdTEhU=
X-Gm-Gg: ASbGncvwbI1yCCe8wIRiBvAi5nq4fK3EY4m6/GDzdsmIEKe55eP6732Br/Ra+XIabWt
	Og+lUYhV0QmU+WCi0i/i/rCm/ZAfjgdIAOLgCpc7HxdDHfshkl7Ay6+b82/45XjuoHClY+CnViN
	kqkLSqynonDgZ7uIamNhS8G8fKWLIVQRGRAuSrJwUKVDdhFSO9oPMoWxJsok7qtjn8ijKHQexam
	yJokpR/XaZh+FnZvM60LnvhVMuTr9+F+1wPDs8WliiJ59tKjgw/efs6hwN/VPjePSqqr11e6EMZ
	HG7C4IOXjma7gDVbW+9YyEws994aeHZUxFkrkcV++D0niYGQUyjObyfaIVT4KGpRg2qxHJyPNWe
	mY2qKDQ==
X-Google-Smtp-Source: AGHT+IGHQWaI+wsylt7S3+XMOx8A5/5l6dC9pJ61ZYifwIoKtpegMA7wiwgbweb1ZJRIrUmonpuh9w==
X-Received: by 2002:a2e:2c11:0:b0:308:fedf:8c12 with SMTP id 38308e7fff4ca-30a59858cc9mr4238971fa.5.1740109739700;
        Thu, 20 Feb 2025 19:48:59 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a29ab47adsm16752891fa.97.2025.02.20.19.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 19:48:58 -0800 (PST)
Date: Fri, 21 Feb 2025 05:48:55 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Wesley Cheng <quic_wcheng@quicinc.com>
Cc: Melody Olvera <quic_molvera@quicinc.com>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, 
	Trilok Soni <quic_tsoni@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/7] dt-bindings: phy: Add the M31 based eUSB2 PHY
 bindings
Message-ID: <p6ytfgzhcyqzmc3elxkpi5m2sdp3aweladrhzvtwpjpot5jh4w@nbjsg6jumc3s>
References: <20250113-sm8750_usb_master-v1-0-09afe1dc2524@quicinc.com>
 <20250113-sm8750_usb_master-v1-2-09afe1dc2524@quicinc.com>
 <a42wtus7y72mt5adklbwg2hjbuayxkeucs7t4xuzmxyag2mx7b@6wlsomzj4gha>
 <a1dbb65a-d437-46e1-80ac-8dff3c97b81c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1dbb65a-d437-46e1-80ac-8dff3c97b81c@quicinc.com>

On Thu, Feb 20, 2025 at 07:16:44PM -0800, Wesley Cheng wrote:
> Hi Dmitry,
> 
> On 1/14/2025 2:12 AM, Dmitry Baryshkov wrote:
> > On Mon, Jan 13, 2025 at 01:52:08PM -0800, Melody Olvera wrote:
> >> From: Wesley Cheng <quic_wcheng@quicinc.com>
> >>
> >> On SM8750, the M31 eUSB2 PHY is being used to support USB2. Add the
> >> binding definition for the PHY driver.
> >>
> >> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> >> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> >> ---
> >>  .../bindings/phy/qcom,m31-eusb2-phy.yaml           | 84 ++++++++++++++++++++++
> >>  1 file changed, 84 insertions(+)
> >>
> >> +examples:
> >> +  - |
> >> +    #include <dt-bindings/clock/qcom,sm8750-gcc.h>
> >> +    #include <dt-bindings/clock/qcom,rpmh.h>
> >> +    #include <dt-bindings/clock/qcom,sm8750-tcsr.h>
> > 
> > This a typical comment, please actually update your internal
> > documentation: don't use GCC's and other clock controller's bindings in
> > examples for other blocks.
> > 
> 
> I can see that other examples also reference bindings from external
> drivers, otherwise I think it would throw an error for not being able to
> find the parents in properties such as, resets and clocks.  I tried to
> update my dtschema to ensure that this failure was not missed.

Just use ephemeral nodes. Instead of <&tcsrcc TCSR_USB2_CLKREF_EN> you
can write <&tcsrcc_usb2_clkref_en>. It is an example, nothing more.

> 
> I checked and made sure that no errors were not seen, so I started to
> wonder if maybe when this series was submitted the qcom,sm8750-gcc.h wasn't
> yet present on the kernel tree.  To confirm this, I removed the
> aforementioned header file, and got the same error/issue.  Now that the
> sm8750 gcc header has landed upstream, I believe that this error should be
> resolved.
> 
> Thanks
> Wesley Cheng
> 
> >> +
> >> +    usb_1_hsphy: phy@88e3000 {
> >> +        compatible = "qcom,sm8750-m31-eusb2-phy";
> >> +        reg = <0x88e3000 0x29c>;
> >> +
> >> +        clocks = <&tcsrcc TCSR_USB2_CLKREF_EN>;
> >> +        clock-names = "ref";
> >> +
> >> +        resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
> >> +
> >> +        #phy-cells = <0>;
> >> +
> >> +        vdd-supply = <&vreg_l2d_0p88>;
> >> +        vdda12-supply = <&vreg_l3g_1p2>;
> >> +
> >> +    };
> >>
> >> -- 
> >> 2.46.1
> >>
> > 

-- 
With best wishes
Dmitry

