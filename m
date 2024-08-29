Return-Path: <linux-kernel+bounces-307683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C33C96515A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4D41F23EAE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B043418B467;
	Thu, 29 Aug 2024 21:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFk+t7yE"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF5641C69;
	Thu, 29 Aug 2024 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724965440; cv=none; b=iQZKYJawp+6jzLZoN0VgE2dVrbq3+91hMwoxMeBns9udWCPHqZh1P1OtW6/bozhIL79mhhJuFzyBfvo50vnDfTOPNKaEfZegBpaLJtdlBwA/HnXTNMRTjsMthR2ia+1vGdx4ORik6e+o6PCqR/Vz9WryucKF6LaLRokBtryZjzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724965440; c=relaxed/simple;
	bh=f/3CcU9kx1DRhP2xmjnK+4VqbvzJS+x+R4np2vRoChc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cjcovi+nGgwY6oDpTEqT9332KBppO2I2Dc3m9ZKeJelnrCB+RzUFgSvoogiHreO73bHx+Jc9VTIa1LqcZn9PLAWsXTs3uF/qz7ZF3RR96d7KKZDlbN6riJTUayIFqJm9Nkz/+2bBDoRhW2cbGa1nIewifSvywUamH/oy94uJC1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFk+t7yE; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d3c5f769d6so745762a91.3;
        Thu, 29 Aug 2024 14:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724965436; x=1725570236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u+eq633davczny4idsI+dtvpXGHNdvyYd6tkYsOl3+o=;
        b=TFk+t7yECr2CCK9l7Dzy+rJUhRPWW2tAUHwxaZSM2sYSRhbCLZ5JEQaj/hFK5F1ioP
         +4LWzc55bBo6Z+NeAoQTyjTMIhcSPHtiTzZJqZdZ3aReEos0tfx5mHgGJuwVSF9bb0im
         rTkEyeSS82jZ+2SxkpgsanrLbzhkpNRDwnppmRjnyX8IO9VA+rziNAN4G6MZTract9Jq
         B8uf+qwvtjL4XhRfd0XVTrJX6Ga1e92F2I9JPCnKDM03wNNROtFLspl5RJXGVQa6shUT
         Xq0mx+scqj4tkG6wpU4VVrdxxGUfiAFV8FzVuimW7WCPL3tEvNKHmy2qEhzzDcqnH9V3
         dt+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724965436; x=1725570236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+eq633davczny4idsI+dtvpXGHNdvyYd6tkYsOl3+o=;
        b=U9bDOST5SKhRFsiKH/ywMpvtFJ5qq8BQUehLe47+1qBzCqWH2xA99+lPW4DGp33u7v
         M967jED8en7gO9+jtrgheZ1XriCKxMyt7OCvysM7dVhXVSPLNAICYAu5dPZrhIOjWwBk
         tHX8TZ3Flpk9blYq1RAgAPTleDcrdVLFoY8MhLZtoXPatVJsgyf/JNJvkDwRikihJKde
         FTvBvII9pCrraESlF8a1aQ5ZVFrd8RC8dY/H6F+5Xyhmb/fFBhKSk4PPPc4q6l0MukdF
         pcXgIyiONU6SyU++spFUPeeLw10Mwq21ybLDEdZ5neu2B5wp2wGuTQYRaLcKW4n71sev
         NTSg==
X-Forwarded-Encrypted: i=1; AJvYcCU6jLg2j4LlAWHX9ty9XGExlpvhan97Bn26Iwbq/3nEBgTKyF8PJTV6u5Xia6RewD9mSbqFTOePae3a8v1x@vger.kernel.org, AJvYcCUmIlVXzkpqJm52XG/lRqvhYGZm8pzrbVV2t/uCReVoZ7fG/Fl72031gwCBhHAPMU+MQquU2lsYE9hj@vger.kernel.org, AJvYcCWvClSNXdFKbQEXIo6u8aqORzpJE0W/vpmD3l2xqKsFhFzAEhTt1GN198D+25/EAi6gAzudleDX8yYjSSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOG6hioWx3CPyyeN3z1bSMVEBz+0wsbYlgpauFJsJSoJjqRSHk
	Y/CO6cUjkub+/OvhNqmZWjDGN5tdsfwN36op0bKQjoXF5nLbNaV454K4fA==
X-Google-Smtp-Source: AGHT+IHtH7SEWGs7imBa/ucRnk9MchQGT6ba/XQus7juUQ0mHiwRjP4hPIgaHURQQuI3486uKczqPA==
X-Received: by 2002:a17:90a:ec06:b0:2d3:c675:41e7 with SMTP id 98e67ed59e1d1-2d85618a52emr4335212a91.7.1724965436485;
        Thu, 29 Aug 2024 14:03:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d85b119b9csm2203357a91.15.2024.08.29.14.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 14:03:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 29 Aug 2024 14:03:54 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: broonie@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, jdelvare@suse.com, krzk+dt@kernel.org,
	lgirdwood@gmail.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH v5 1/1] dt-bindings: hwmon: Convert ltc2978.txt to yaml
Message-ID: <1bde904b-7b17-4406-84aa-97742c8a02a3@roeck-us.net>
References: <20240829150641.1307906-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829150641.1307906-1-Frank.Li@nxp.com>

On Thu, Aug 29, 2024 at 11:06:41AM -0400, Frank Li wrote:
> Convert binding doc ltc2978.txt to yaml format.
> Additional change:
> - add i2c node.
> - basic it is regulator according to example, move it under regulator.
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/i2c@2000000/i2c-mux@77/i2c@2/regulator@5c:
> 	failed to match any schema with compatible: ['lltc,ltc3882']
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Applied, after dropping "move it under regulator".

Thanks,
Guenter

