Return-Path: <linux-kernel+bounces-262040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4178493BFDD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1F8E283471
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF29198A19;
	Thu, 25 Jul 2024 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nhiw/56j"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2F0197A76
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721903073; cv=none; b=fVhnPqvbX3WuMCy2u32bdKPaCrqSq9+B8FjGdPPovafz+e719ehDGsW+48VQXe+3+AiJQ5iJa8BDqaogB22UjYVuNkQHxg94Ky6Pe3v/0O4dCJwo2haANRK9VLKbvm4uDTyQKvZ6fTjYahYum5+RhiZeUpfDD94VIdX9YHshvVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721903073; c=relaxed/simple;
	bh=CwvaLmHe/vs0rLGhaPMxOTOImY4e3eJPnOPidzlP8+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYLlBTHtOF7n7z5K2DhKov6F3Lde3RKdqs5L8FG5PBk+rlZaB9mexTk12cfkHEAJoF0ZHIAV7idzB4LEl+gC/CBIQVHZWL+/yc7gfC4tgKn7YSJWK4ZvMnx4vwr+UN693EVISXjjfKEuda2oz6iEdJIfKnxf0MjAZj3DQ7AK2LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nhiw/56j; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52f04150796so958895e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 03:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721903070; x=1722507870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WoxYQNUTCa1T0SH6iTcHddQ7maMyu3El9N4s8NEmbaI=;
        b=nhiw/56jnuizFAnCeyPLNVQnh6Iu7PRZFMwcCFJ117cfMWIAgg8HRySx8enbX/UqdQ
         00//43FeX3eFqYWDpBc0IUr5fNRjzMcA2ugOHk/cGs/333CjT9xu1Cyc4y+yck5r8AQ+
         wsO9qOnOI4Gi6TES6BFSfghTt9VDa+AZI6JQb/XsKNxH/DWaU+e+Ok2FydwlH8hdJx+i
         ytN0g2jzN0dcMM2ZK/8aRx20eikd3OmmvX7SJRj+LMNezxZhAQXBpiA4QnYj6BbE2sHg
         CfgWQoJqQdhw4yOInCM1cg+zmoI3OUxbFvx3lrzVyU2Yz45ftCqhroxZ4dp3UnGo+0Po
         bJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721903070; x=1722507870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WoxYQNUTCa1T0SH6iTcHddQ7maMyu3El9N4s8NEmbaI=;
        b=q1ebM9kwg6r3fY1GJVL6da9kC8vMUFVfsSlUeuuXV4NUpwk2uXhnkirHfTSTWWJAS3
         ElFiv8sbsB5arNy9wvQ9P81Q9698Yf9WC7fiarZMUI1iwSfkQRwYBn5BRtjJgI8JmNOa
         mC6c8wnsdJ6ZtFwuom2jYtbShe7C5SRukKRUyEQdvOLxgnTUFh0DOriPcUPjf3ePVb07
         M8Exi5nefPyiRsKBf2dAPGWk0IVAhs5Mu6R9sVmKWGujHSTtkaBHl1e0CcYErxGFpvLY
         XLnW3sJgezeXRp3KtnJw3PDuK8m4EL7vCmoVuOtEVq85VCXTiNLTNrBSyjLloHafyKAK
         551Q==
X-Forwarded-Encrypted: i=1; AJvYcCWpPrBqeQefjIbfdS3uC4pJuO5q+LaDIAQxNAE2JjHhU3nWX/B8j8BuYJowOLMuJRgMswCBK3eT49Ev3HE4uNhZkTdGhw0yC7dPuGW9
X-Gm-Message-State: AOJu0Yy6HZhWr3d87v4LnbuDVfC46erTLxixOT3XuQ58ADtjKvm8qGci
	dZDbgzfzZQR5cDhC6sqykVtLd/KiVYtKrihT+9Vdkb7/yuYlXh2+zvZ78rATNG4=
X-Google-Smtp-Source: AGHT+IGON4hLG0hEzvd0Z/9nSbx4Zc3GQMs6yIMVvA/tKBhu9hBIRLjsY50KwApJu8PHZ19IjLHfQA==
X-Received: by 2002:a05:6512:3e15:b0:52e:7125:c70a with SMTP id 2adb3069b0e04-52fd3f7e820mr1730350e87.47.1721903069556;
        Thu, 25 Jul 2024 03:24:29 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c196e7sm175346e87.190.2024.07.25.03.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 03:24:28 -0700 (PDT)
Date: Thu, 25 Jul 2024 13:24:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom: Allow 'vddpe-3v3-supply' again
Message-ID: <pbkzwy63j7dh365amgdze2ns4krykckqyx2ncqjw2u4dufuoky@fg6rdpnqh5vb>
References: <20240723151328.684-1-johan+linaro@kernel.org>
 <nanfhmds3yha3g52kcou2flgn3sltjkzhr4aop75iudhvg2rui@fsp3ecz4vgkb>
 <ZqHuE2MqfGuLDGDr@hovoldconsulting.com>
 <CAA8EJppZ5V8dFC5z1ZG0u0ed9HwGgJRzGTYL-7k2oGO9FB+Weg@mail.gmail.com>
 <ZqIJE5MSFFQ4iv-R@hovoldconsulting.com>
 <y6ctin3zp55gzbvzamj2dxm4rdk2h5odmyprlnt4m4j44pnkvu@bfhmhu6djvz2>
 <ZqIVQzQA5kHpwFgN@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqIVQzQA5kHpwFgN@hovoldconsulting.com>

On Thu, Jul 25, 2024 at 11:05:07AM GMT, Johan Hovold wrote:
> On Thu, Jul 25, 2024 at 11:57:39AM +0300, Dmitry Baryshkov wrote:
> > On Thu, Jul 25, 2024 at 10:13:07AM GMT, Johan Hovold wrote:
> 
> > > It is already part of the bindings for all platforms.
> > 
> > It is not, it is enabled only for sc7280 and sc8280xp. 
> 
> No, that's both incorrect and irrelevant. It is used by msm8996 and
> older platforms by in-kernel DTs as well. But the point is that is has
> been part of the bindings an cannot simply be removed as there can be
> out-of-tree DTs that are correctly using this property for any of these
> platforms.

It can not be removed from the driver, but it definitely can be remove
from bindings.

-- 
With best wishes
Dmitry

