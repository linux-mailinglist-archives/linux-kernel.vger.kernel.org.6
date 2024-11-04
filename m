Return-Path: <linux-kernel+bounces-394581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA799BB168
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2093B223BC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6861B21B4;
	Mon,  4 Nov 2024 10:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E/ae7tAo"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C6F1AC458
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730716928; cv=none; b=ch8t6rMZ9xOoEPDOC3dac/9Uxe9bFPR638RW+bDBP32kCrFHXwIPscdp8GbIUSNMPfNiYST2j/kKP3sVhg4dDAN5zvqJAcddtF4Qo1cn7yi/f/BRFM8tAtrrk4CgLZnC3JaGLTe6Jk9HhEGwKI107fiVAuDm7cmYi++LHoHfmfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730716928; c=relaxed/simple;
	bh=Z647jXU0dS+SnMytYB8lAXfsaI5ENPQcmnOoauyJQUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OwjhZ9NvHhfUfsCmYXTtXYBnRsEMaYdZxaAuhgWmoXoRcSkwiIBdUk6M08Znrk9xtRcGRw3K4VG8cwSK10Y4SCWLugsILr9ZMCLbMtdmDgHZD9upNWyJF3GvgLxdpB2JvjqPplWxdwdzlyf/F6H/RjAg08mC6aVxQvXyboxqg0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E/ae7tAo; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e30cef4ac5dso3584595276.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 02:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730716924; x=1731321724; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ShfIvpaQ9LTHGoEs8YYBNIijVddSU0+GArnr30PCRRs=;
        b=E/ae7tAoLU9J+e4aQEfqzQRD+klZHBDEEV+0QSF0BjqJaU8ZGX7BiNBXPQttNv4yNc
         q2x6uiBIAIQ3AUBjmduGx1RDsQuNOaIr2n+N0JFr4CkLoa1UR/rNfPmJToIJRv/KpTZg
         L+0qOkjKgh1u/amDgZe6dc40wfKPLvvDquU/4olC1Oen182C+OI/q6K8QxwP0HKbS4QY
         IoqTSKPc2jAsTHIqO0cFeeakPtft/UTkkdIkWHBSs7TKNPqvRzuJnD3hw/wZCCDEOg5W
         mii4fihLlfhz+L+l+4EzINd3UP+MPQ5HK586TNsqVR2LgCN1xnJJVxMcV9vM02hKmgFw
         F9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730716924; x=1731321724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ShfIvpaQ9LTHGoEs8YYBNIijVddSU0+GArnr30PCRRs=;
        b=T4LnE6KkrHjdV7fw6vI0/laSGTdWjc+cTmETo6Nd+xs/bnWBbL8lht7pvnc2DGA7Vr
         +xfXpWk6/ODDsPgzgwA09IWmRhtgcq/DuSSXzwGudFZAeOVw0dFYqBCbT5RWdl4gln6F
         8NODWLf4Xfj83MfzwwiFNgojtwxfDVhN/z3wY3SoK+N+X8xu8nOUZc1ZBXTz1vbQBXX2
         IYCBQcJvZzXJTOTJ8hjr6xq0xEi4U5PhTp5XFF733MK79QXqD7kLteKk7Dx5Te/wxcjk
         K/qJQ2Hb8RZPoLHZrfN1xSRrPyXVGe6Zc7QUhH2/JqKnxXRRoXXTZQGbJwPBsL3QgYF7
         VYzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvDGzAd/wYPaQE81jxYSvx7NX4gG5MD+TdHxaHQ3JtTVtOGdKB31S/gkNCZXdNSG74ohZMV0K1uvbSfxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx52pnz1ZEVaF/jGHn6uceBEr2avnydO3qtSM77lEii9Ez4AtLo
	HJFcpbmQCizGZ/cOO2yrJaaHIPKEREmFctafKf57yP7kjj+qLFQAHZTOzJC5FrZsA23SyySc6lk
	YdJHRoHzReTl7KrtLCtPXiBREyu10Ulvy5NTP1CKdjLlihByOlnirZg==
X-Google-Smtp-Source: AGHT+IH+YgpZN11wcgktvcVPO77JYSvdveawjqJ3QCFGns8tPyeyiEiVzTVe/qr9NJZ94QECOQ1arMRrm2nem6SVygY=
X-Received: by 2002:a05:690c:445:b0:6ea:9bca:9fdc with SMTP id
 00721157ae682-6ea9bcaa343mr23295447b3.34.1730716924387; Mon, 04 Nov 2024
 02:42:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017-sar2130p-usb-v1-1-21e01264b70e@linaro.org>
 <gohuncowxxud4rilmr23q3zc6rnkoqpbkl6v4puiexegvzr3fm@2zt4olzo64bu> <2024110458-seclusion-impatient-a4ee@gregkh>
In-Reply-To: <2024110458-seclusion-impatient-a4ee@gregkh>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 4 Nov 2024 10:41:53 +0000
Message-ID: <CAA8EJprVitnOubd3wqzgRf1-BeQqM=pVfOHp8xu-MY-wi7=aPQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: usb: qcom,dwc3: Add SAR2130P compatible
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Nov 2024 at 05:46, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Oct 31, 2024 at 07:37:43PM +0200, Dmitry Baryshkov wrote:
> > On Thu, Oct 17, 2024 at 09:16:38PM +0300, Dmitry Baryshkov wrote:
> > > Document compatible for the Synopsys DWC3 USB Controller on SAR2130P
> > > platform.
> > >
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> >
> > Gracious ping, the patch has been acked by DT maintainers, but is still
> > not present in linux-next and got no other reviews.
>
> I don't see the ack here, where am I missing it?

I'm not sure, here is an email from Krzysztof:

https://lore.kernel.org/linux-arm-msm/shzy24hayj6ee72pwc5lxk7yflzawx5f3uaqql4fwb55idbxci@qgi2fr7pvb5m/


-- 
With best wishes
Dmitry

