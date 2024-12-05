Return-Path: <linux-kernel+bounces-433770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CE39E5CD0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1E41884C31
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915CE224B14;
	Thu,  5 Dec 2024 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gXfu4U+i"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACDB7E105
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 17:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418926; cv=none; b=pI69oXWLu+XGVhw1f+ByFCb+qmpkgVGVtcTyLq9hhKtpirBiHqW1eCOq1k8oLwDYziDWgoJ408QHwteGgHvSs6cN7U2qfs0x757eEHTqtVldJKuJvKEgoEZshREWVLaknXCb7FylqLL+ygyn2WHgrm6+h72mDtsZVu47Qw+SLNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418926; c=relaxed/simple;
	bh=uJrtJT7gxlW++Ty/O1yTg6+kz0Nk5NMas9el983z21o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qv6L5QWf8pz+4PO6knQkTCUE1rYIk6o33flIeTEzyIkCLWc6LhdvbuwJm4Qzk7DzOnySug0WgTIMMeGzj31aCEY9o2zTjAZvKO7w4HxpsBsr+x2yeKpUhOVennvZ5tzsRmksyqZJqSE4gRibcHRQ64bs7ftp/qbeu2HKNkblRR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gXfu4U+i; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53dde4f0f23so1103815e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 09:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733418922; x=1734023722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VC7qjn2Ue13WwDYjqbV/OAtsUDuWOgrtwnr0NjndRq8=;
        b=gXfu4U+iqsWHO5Zpnv6R1OphO+fciwmTcW4XfSqA7joXBypPLi4J4TZU/EkX5zAf3o
         PRajMAJXDAUrX2IARVZO5kPizwRmGrVhHDJWv5m7Djl7zc/zTZ8aXB93DizeZxoqBvxL
         W/89Evcx/M8e2lbgiO8FXPBk1RGv3aAn28OByYvCKDO8bUJT+Ju0vDiJBnAdlyVJ87Vl
         k/ce4tYDYRE8PuMDim6LMU+cFsGRM+Z1ohlfgIdSpGtEWyyNq+MSshIjcshfTUQPTm/C
         jvdJ2tqxcXVWko0oU5IvCQSbJecavaSf0c35z1mEOcMsOt79xvxr6Y8AkQj+8kipBxbO
         Viog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733418922; x=1734023722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VC7qjn2Ue13WwDYjqbV/OAtsUDuWOgrtwnr0NjndRq8=;
        b=U5gTSib9qm0wWU4qr32yBrkkRbf27jScyngH219Mu24/XEp8vSoSvozFhq/Z6nITgb
         14LV0nom4SNjR0tuRTbL7zSyrJZNhYchlZQnm5m8Fja1NV2Q88JGmKLFsL/jqIkUJO0C
         kNL4MkmRxpEe48AAW8KKzEs8p+35vMjawPOwjcnXXWhL7fvkEHnv2OqWdZuCqC715TOg
         RiMiHhet/5CjSbWN0lB5gF2p5nU74ZRSJYM+S45rIvCiUYJc/ncXdWX8laANh5r8/jXw
         UUZwhMWc1OcNrRcYMFheEMcOZAmMm/9QfbvgRskUfRupQkwZI5Zi05Jq6no/sT1dlENe
         rE1w==
X-Forwarded-Encrypted: i=1; AJvYcCX0l9v2jQIcu851MzL53QakrC8rC/GPYS53sW2hnBOkpvMGM3QdThlV8CuRiUdkJ10bQyNxBfldQAS2eSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaVpf/twOfIYhilUJZv8s6bhznUixk+HcvUOwzpDfm07T9zbOg
	EdZZHGUGCrdbW/tixDpnv+l/K66BJfzDfEhAAFXUYAroGl6SzGd+5qtPiZuku8s=
X-Gm-Gg: ASbGncuS04iB3PndEW8Fj8vlsYrFhNBcn7U/A7PXzOiZFByVx17/SxWitKrlVE0eY2J
	f2O4YhzNGeB6PY/ONp4/Gkgk9plZar7CAiXZNzaBLZmpd96qGbGs+v8rR0TlZNJ+AQodBKGZhQI
	Cead/RSwe9pWWh7VaTv+XGhn4Oh7sHm6Cime++H6bnWEEw+tbnYVO0j/6TeEo3k0jO13Gx9b6II
	q+KnmO5NgomvDhOWxMdSktPQHjplao9ARTHAQeiiwzAiNHAXhQOSiLyuLc7Wq1vcMz9POL6K0JH
	aTy8vVxehOfwLdn7c+i351jv+GJL2A==
X-Google-Smtp-Source: AGHT+IGH88KxLDDpR3F7Zua2FFnZVp+X450MYJpG7X6Zbx4IrQuk9wIFPeZ+LGfXcyrUOUfPRq9xtw==
X-Received: by 2002:a05:6512:224d:b0:53d:a99e:b768 with SMTP id 2adb3069b0e04-53e129fff72mr4872910e87.25.1733418922320;
        Thu, 05 Dec 2024 09:15:22 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229ba710sm290454e87.140.2024.12.05.09.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 09:15:21 -0800 (PST)
Date: Thu, 5 Dec 2024 19:15:18 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, Trilok Soni <quic_tsoni@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Jishnu Prakash <quic_jprakash@quicinc.com>
Subject: Re: [PATCH v3 3/7] arm64: dts: qcom: Add PMIH0108 PMIC
Message-ID: <4i4y5sajd7dmqjm7snjxmj2v64hadj52reo6utztvk4lsulwax@p5yq7swn3z2q>
References: <20241204-sm8750_master_dt-v3-0-4d5a8269950b@quicinc.com>
 <20241204-sm8750_master_dt-v3-3-4d5a8269950b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204-sm8750_master_dt-v3-3-4d5a8269950b@quicinc.com>

On Wed, Dec 04, 2024 at 03:18:03PM -0800, Melody Olvera wrote:
> Add descriptions of PMIH0108 PMIC used on SM8750 platforms.
> 
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/pmih0108.dtsi | 68 ++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

