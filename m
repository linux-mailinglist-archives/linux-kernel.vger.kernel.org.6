Return-Path: <linux-kernel+bounces-540051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD90A4ACF2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 17:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C02516AAC5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 16:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472061E3761;
	Sat,  1 Mar 2025 16:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xoo37irw"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D181E32D7
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740848358; cv=none; b=o/wBjmLtXQUo+5SHgMmmN8Mv958TCpaH9f6tF/gYvJsBZoRqcJwviLJZ/mXhQu4i6wz+PpZjvk2kW17bw0G5qVvnIHYHssQhe9qONjaYvRazEtajN3zqz8M6LAikFo5SZ1UOgr7Xaeu8lzLgfdFUmpg/Cuukpp+o2N64hb2F+yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740848358; c=relaxed/simple;
	bh=iA5cPbq/9vj429yRUOv7R3QM0Odgw+vixO4V5xlgpBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXDGeaz60Cq933xHtgMpiU9AuCJg11VWzj9Nw56UiPZjVPIH4L4OJZwjXrJTCDNbLa333ypvq9cSgaXB9+Jqe2amWH0gVs9quSy7QNwhsI6usZ3JGMmKxeScmqEDg0VFmhYYye/Mmm4OYmoOYc+ORr6NqrdcXHIH4JlL1zqoYTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xoo37irw; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-307325f2436so32985591fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 08:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740848355; x=1741453155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8yH9gwYALLNPfPaQHLNB6Pw53oWquI/ljPL4PqtQc4A=;
        b=Xoo37irwySjqTyepe78VUVBUucrV9s1MjFfKbCIJoDhk52TjLM0TNnDcz6mY4mveU/
         u6gmi6rb0Wk4s2Hm7aI8M6OvasGTJM68GKEDV6/X1DhEGddz3YPDmKluSOPzyc1uE4qG
         XsjX3Po5uxqGiku/PqXT6qEFvaf4SfEUJZqOM2oFsOWwGxlv2mkXSxc/jUbwHWphSoB3
         nWpub7pyftHMYUklJk5MgaY8qE3vXWCeRzABRy8sITAoUhzC7zH7Y7p/LfcgUGf1woXe
         xbONEDWHpUuUROoLwhG3M8UbptcVjlti9cP5UHsmIELC2IcYWEQMIh1muRQGab1eUblg
         ziyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740848355; x=1741453155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yH9gwYALLNPfPaQHLNB6Pw53oWquI/ljPL4PqtQc4A=;
        b=cGhbymAQ+7o95LCyyMV1p0jULH6meV9A9yKbMJqkAdQ/DsTOdRt8OCML0/B9V2wk68
         Ed6bJWVltvBs9g870avTzA+FW9GDww4sATSHGIz7ET8s6O/trZN9LnUDdSiwKstpsTLZ
         OiO93MeyT5AIR9bShR8OhYiW4WbtIwtLb9BmCs7l+L/l0JO9HUAiMNhuqzQt+FaUbat0
         AR3CFs+HnkMc/LpvhQ0UjNQ/ZJ0dFbPKYuNY6Edi+kmxtWpXEQtzxpKp+W9S9vyTI3sz
         +HiEX+NqvSPlL316pcyJtiei6Qo7WR/l3kEyX+IrtlpFP7NRNUBiLjwPkooy3CV9gEOR
         TF+w==
X-Forwarded-Encrypted: i=1; AJvYcCXqlXU+1eoPoYKpKd3s48nfBHSJnn30cWFCGVdzI6VUWhn/jxCfGNKr8qZRUD7i1wvGfj9kgkoAOA+cCYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjxO8eiCLdO9jw0eXXXJ8KcYHhgCZ3nJkwLMsiz+l+B13pwoM4
	IYS1MUybvY6fwlhQxCTVsr/mCIEy1kP93xBi1BkQonawbU0upzLR/g1odMg3Bc4=
X-Gm-Gg: ASbGnctyNh9Im6FujPMW/tUUSLxB9ZYoicaadK/33sgQq2dYJ/GGHq5eqCwPceu2WNr
	slm7+6aQYm10qb03XXzYIGdr/dz5DUvWrwkJP7h27QX1RGIMcp7ITw4BQGx2RH5N4fzsRz5ykaZ
	FxpJcVvzBK6dTWvabFeQY7oUlbjZgHIIErk24tQ5Dfm7Jcl9rDXj9jRj0rdyPiWjahH/8LfDlVx
	HHXrgFwVMSHnodBGRnXcGqvt5bxeqSGUbUX4XWHRMbvg4dhxGEZZgvXnB0DgxdY72Jn1FdXr5mx
	GUOdpzFuiTYXWLTHE+cGCIKABSNcC0aJmgmfrv/mh82Y865j7LbfdcRG+yafpmx6rXWfyiXJy/r
	tru4t3Aen79bY8WAPAlfzdDxh
X-Google-Smtp-Source: AGHT+IEVHoucPnHehRJx7iK3J6AShz+KMdwofBAN581qWxfDGPZrVO0T7MEE9K9AUrnUMGyOVN+cYw==
X-Received: by 2002:a2e:864d:0:b0:308:eb58:6580 with SMTP id 38308e7fff4ca-30b9345c812mr22403201fa.33.1740848354988;
        Sat, 01 Mar 2025 08:59:14 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30ba9f3ccecsm1399641fa.7.2025.03.01.08.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 08:59:13 -0800 (PST)
Date: Sat, 1 Mar 2025 18:59:11 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yuvaraj Ranganathan <quic_yrangana@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: qcs8300: add QCrypto node
Message-ID: <vrokhkstd3zbvdxcagjvbxnzdwznakwg2xitd7wpbdxogqvfkd@grleg3nqtoxm>
References: <20250227180817.3386795-1-quic_yrangana@quicinc.com>
 <20250227180817.3386795-2-quic_yrangana@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227180817.3386795-2-quic_yrangana@quicinc.com>

On Thu, Feb 27, 2025 at 11:38:17PM +0530, Yuvaraj Ranganathan wrote:
> The initial QCE node change is reverted by the following patch
> https://lore.kernel.org/all/20250128115333.95021-2-krzysztof.kozlowski@linaro.org/
> because of the build warning,
> 
>   qcs8300-ride.dtb: crypto@1dfa000: compatible: 'oneOf' conditional failed, one must be fixed:
>     ...
>     'qcom,qcs8300-qce' is not one of ['qcom,ipq4019-qce', 'qcom,sm8150-qce']
> 
> 1. ICE crypto node is not sorted and fix to sort it.
> 2. Add the QCE node back that fix the above warning.

Two issues. Two commits. Pretty simple.

> 
> Signed-off-by: Yuvaraj Ranganathan <quic_yrangana@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
-- 
With best wishes
Dmitry

