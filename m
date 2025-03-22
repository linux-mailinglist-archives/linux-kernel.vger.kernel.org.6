Return-Path: <linux-kernel+bounces-572111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C508BA6C696
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 01:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 460EA4823A7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 00:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC1B2905;
	Sat, 22 Mar 2025 00:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRmUmtNR"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CD3173;
	Sat, 22 Mar 2025 00:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742602040; cv=none; b=eWo72xGuxx3NejFVasiSqL4tnJCSFkquTrRkZxgjOPh1z5WZ0pDIkkQeDohHTFxjVDWPQA42AhgnlAXulGQcZKxLg62u9UcW9vUY1l1jvemS37q9t+fvVmt1tS+f0CHX9+F5yrXPrNqlp7li5iMz20yxYF69+2T6No26t497bxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742602040; c=relaxed/simple;
	bh=IyTr/qxq70y0NomvKD2q60Aknv/nHZB22ed0liyrWgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfKFilDxgbrGp3vucAN4RcJbQ0eTQPfvFI08L8uyURJrVYcqVMmbhAZw6fD3uUHuZB6PtsTcOn6XmovWdc6cDiOWx5ggGhd6UkRbEPXka2X7K1jBctqG0xw/OaGDse+ZVkYN3GvL5qpZmplhXsbzv7f2eBkcs8msAUeDWlki6pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRmUmtNR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22403cbb47fso50794615ad.0;
        Fri, 21 Mar 2025 17:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742602038; x=1743206838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEnr4izKJdjnJbBtyeXqqfyvYG+/M2XCUVon+4GL2NU=;
        b=ZRmUmtNRU+3X7MwFWJfanbze2jfjtztPmAw4JdjSRBm5h7F8mqaIoby56O8c/6wsLx
         Xu4ITavMx3n3EwUsNBreGTXp+vYA1ovwzlt9ANqHsdXjOB0zfM+Pl7ZIpCek8z3CYj8d
         dRhTAYwP5deRzlDPySH3QGvfcvy74cx6z//D6J3MRPcaI+r9whGO1kXxdWY/qQ06zwVX
         H5AOsaEUetlcKK7cplVkj+zFP6vIFtLhmKoMv0QuCTKQeqL7VRY93W6YLtJvvtK9Uxxo
         Z1OaJ4dWzXPatzz5LMEKM9I6Lw7GYxtbrFiaOVGSFpuy9+NPzSZBZIw+srIuOQnVcrcJ
         /Seg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742602038; x=1743206838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEnr4izKJdjnJbBtyeXqqfyvYG+/M2XCUVon+4GL2NU=;
        b=Nub3sPZIpWPs8fPMYeO+Vuoq73mFZWdYDSARs8k57s4o6Xlc9qdOc/QywbN8VYWoKW
         iy/6mPGExnvUtvRRtlKlOO26c8LMuwh8ydundnMhzUXDnyH2LXKI3iniliDRb6nphpux
         7McOHT3n7zzoyO0EDBiRem80J/cLW3pXLvGIrVHWu0cUDDEl1SwZ646pW2sLAk8QmMnD
         G04m1Ab/svuAxyCXFMCRAtCtFwzxMqF9EGWp7fcNLRdeAJaSw87bTWUS+3GkYgcuQEC7
         fqWeBQ1Mo4Ndo2Kl58wZnTiPM3JQem0Kvv+wdzE5Eyf/M9mm5N4dEmKIi/s+xvWlRExX
         DIig==
X-Forwarded-Encrypted: i=1; AJvYcCUB/qPktEE65ndA56QgJ4pZsTVNMwbpoulvnSa3TL99T5tJxOqRSNT1J7UIVllCJ+LAhiWiav4DI2J+@vger.kernel.org, AJvYcCVFwh6Gqe322EvndEruE6YrGJKUUJjNeXUr7Q4VWFNcy37/7oWQFdJfQphzLZC172H57essfa6CZ64LjFU=@vger.kernel.org, AJvYcCXmc+mrC1H75Q6R8LaGHGjrcH8MBvqobCe6lc7+LnUGs87NNbmGwYBa2x3PsrFbTPAjWg8bh+9QZBgCtduh@vger.kernel.org
X-Gm-Message-State: AOJu0YxLhLwdnTlTZ1GiGN74TdWzXQljWG1ZBvDG+KT85Xwb/1glOqlk
	CPksOvDu/BLj2xbQ05d2ioREkIoh5DLGFDsXQzua47z/qNVJS0l6
X-Gm-Gg: ASbGnctmdwn3aCcpUsQyqiu6xzO6LAqY2abXJsHFd53AbvgQhsPTfdi6w8ck50GLYn3
	u38H1iPV6umdSkeM1mrj5Azln0iVENPR9HTDtZhfRmitewzfSpnGtHckrWT0W82TGnIKKIeDGd8
	4QZyZqIjHNR600dAvq294OZPNeW055AReTYmK8f0mo5fQPqmC2EQ4N0qL268r/+kTXpVHYHMIPU
	qgcQyY0y5tKrlmaYshLx28YtOTkt7Bm9Dvh83b3yDkz7oqntvHCG68gMsc+0DX1liZ0tQhzC2E2
	2gME+qjGfhvzrCalrKoGcvm0BIxQi8xfqtzeMz8Fj0nE/wp9X3eTNlEtvUYaNl4zCd9u
X-Google-Smtp-Source: AGHT+IFDUMil8h2USTF/6GZ8khOOE0OmSkPrtNpa2p2cNYAZZHsrUMdhozVcZR9tPdXtRiTCt389Hw==
X-Received: by 2002:a17:903:40cb:b0:215:b75f:a1cb with SMTP id d9443c01a7336-22780c5570dmr79779235ad.9.1742602037520;
        Fri, 21 Mar 2025 17:07:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811daa38sm23847405ad.195.2025.03.21.17.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 17:07:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 21 Mar 2025 17:07:16 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: florin.leotescu@oss.nxp.com
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Shych <michaelsh@nvidia.com>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	viorel.suman@nxp.com, carlos.song@nxp.com,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	festevam@gmail.com, Florin Leotescu <florin.leotescu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v6 2/3] hwmon: emc2305: Add OF support
Message-ID: <b1dcabc3-0bc8-402d-9b28-8bb561d489d2@roeck-us.net>
References: <20250321143308.4008623-1-florin.leotescu@oss.nxp.com>
 <20250321143308.4008623-3-florin.leotescu@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321143308.4008623-3-florin.leotescu@oss.nxp.com>

On Fri, Mar 21, 2025 at 04:33:07PM +0200, florin.leotescu@oss.nxp.com wrote:
> From: Florin Leotescu <florin.leotescu@nxp.com>
> 
> Introduce OF support for Microchip emc2305 pwm fan controller.
> 
> Signed-off-by: Florin Leotescu <florin.leotescu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Applied.

Thanks,
Guenter

