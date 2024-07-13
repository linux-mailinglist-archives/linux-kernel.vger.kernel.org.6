Return-Path: <linux-kernel+bounces-251496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 819DD93058F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 14:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42CD5282628
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 12:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B61130485;
	Sat, 13 Jul 2024 12:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQ806ZOh"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62FF1CAB5;
	Sat, 13 Jul 2024 12:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720873499; cv=none; b=oX1+WkCgtkynRzTsyiI+Cukzk4Qx4e4Lw2xl7iYXS/D2C4YNPHDCM4sfF3ju9DI2p/Z7MtgsrKHlxQGAR6FJsMjAIdK7vc1e0oQBc27EJZTXXPYyDTDEruGtv/Qf1Bsoxvy0YofRtsrBXJx8xXgL3TaRkZpvobe69DJkewazGcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720873499; c=relaxed/simple;
	bh=u4CHr3/LFgQ8JdAZHvNWXD5hI0t8XDMu+lLmGTbtjwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agQYS9NEULrITHPFc9PDT2SKU1TOD3jGCipzrLMAf/I/vDR97KuzFXFMxqq6uZHFa2mLkQMVdp03EMJRsqcQdaGsxJv0ZaJp618us9SrzfvUIuJc9n4C+2oZ0GEVb4tkHbpNDrh01IqASYqZs+U9U2lJtuBvQXqdiCwgbMYRB68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQ806ZOh; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52e9fe05354so4066901e87.1;
        Sat, 13 Jul 2024 05:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720873496; x=1721478296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u4CHr3/LFgQ8JdAZHvNWXD5hI0t8XDMu+lLmGTbtjwI=;
        b=EQ806ZOhzpmVvIXiFuCmz6In4PMhsYtWo8V2PvTSmJWiAT6pQ+u4b+sihKopwzGNvz
         hfObHypySsVMA4IGCy4uRpH/ePRsaJrgTGZPv0rDiz7yRKLSF5byPb/nKCXuIPE48j1O
         uFAEzUo/wzs6DB9Xo3GGl/svFYrZdhBoC2e1jwvJVqUMUVFqk/AqT/ugwe2Kh4pzolA1
         Yjl9Ktb20ozR6fUBls9tdsKdz+9bSEXvglE7rsfoCVx92CEAn2c3ynFkgEuvlHk56oej
         WThmTvV1yD6QidEyw39Jno7tX9XM3gTrd5OXjQWVoLuQ4Y89sG86dFEMONbd3agKvseG
         DJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720873496; x=1721478296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4CHr3/LFgQ8JdAZHvNWXD5hI0t8XDMu+lLmGTbtjwI=;
        b=t4/VCYPPinrFOia2hCbkl1+RoPtWVLTl/tsaaN5OoeakKsaTx/8qRshzQp+iz592qb
         49ZkV3Y5twZRIIPKyDE3/gpEg2RUB7PBJPxyPol53pglr+A/3W1UsU/6GB6cDof0C29y
         9wx2pavUzIY27tjWNjsZgHD7RMUILJ2F1/zQr6TyAPSem+X5eYHsJdJvIA0A21PrrNvs
         qHJT9HPuL2PA29MBcmCCWbfAGYuRBcP6GKk+hr44b5gYi2PL0CftRQm523XV+MThEnBB
         ZgenxTVVmkTKecHe8dmFbSVUQ2sobNlsBz7IOANNNmQrjtoBrU48olhNtV45x2aK2pKQ
         +low==
X-Forwarded-Encrypted: i=1; AJvYcCWeY+QeY7g96VYZsolnpx6H02vLDnbBaZHIo9GxTGmhJBfJt48YGCJTOb/EYryw7Ovm+64snTGHkkPtyUavj/Dv8uT4CSlUHPOZ0y/R
X-Gm-Message-State: AOJu0Yw58JycB8p89tjrj1pfUBwGkGrcRLm4fMTlhFfUAjR6RSf+lAC0
	4jJgfuuXPMMXsN0XknGUue1iyUDoNeESHDpLlT9t3Xd/MP6yOjHV
X-Google-Smtp-Source: AGHT+IFxY8iMrfbPK6GDrgCgZoPUm4AgGl3wl1C+rVntUCJriYt71PMzxNnGE35CXI/XKKM+Rk5eiw==
X-Received: by 2002:a05:6512:21a:b0:52e:747f:46d9 with SMTP id 2adb3069b0e04-52eb9995509mr8374906e87.17.1720873495552;
        Sat, 13 Jul 2024 05:24:55 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680daccc55sm1274042f8f.50.2024.07.13.05.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 05:24:55 -0700 (PDT)
Date: Sat, 13 Jul 2024 14:24:53 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolin Wang <baolin.wang7@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Yanxin Huang <yanxin.huang@unisoc.com>,
	huang yanxin <yanxin.huang07@gmail.com>,
	Wenming Wu <wenming.wu@unisoc.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: nvmem: sprd-efuse: convert to YAML
Message-ID: <ZpJyFZSg8Gw1jZfk@standask-GA-A55M-S2HP>
References: <ZpJvRePtbaiG94Te@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpJvRePtbaiG94Te@standask-GA-A55M-S2HP>

Just noticed this old series which among other things, also converted
these bindings to YAML:
https://lore.kernel.org/lkml/20230819055141.29455-1-yanxin.huang@unisoc.com/

CC people from that series, I assume this will be relevant for them as well.

Regards,
Stanislav

