Return-Path: <linux-kernel+bounces-540660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B6AA4B374
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 17:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 246883B3289
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 16:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955E71EB182;
	Sun,  2 Mar 2025 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFX1ESXb"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FD018C937;
	Sun,  2 Mar 2025 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740933217; cv=none; b=UU2YU23cY/jBb/bHXT8q3ZnVVA3fAgZIw2c/HJd4OXOBADCwwZdTaSYl/6di7iV0YNX79mp05+4vdIS9wFvMas0x2Ab9z/wwpXm/deewYJLLyM75KAPoa70y0zz4QKU5X8oa2EHTfPeUXOWqJJ8QCcipvSbq7t5Z+2hRWuEiF4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740933217; c=relaxed/simple;
	bh=QumJo4ai5akiSGOeyNpfxB3bkP78yfCr48VHlASwA1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ih2MVAVx762m/Ku9taq8+gYuFtXK/1O0rTTvwoiqaAO3GDyRmmNlExlvgm2GHImHlUq8psHfh7iK/5npB1Eym7+uBXWvRvDhQRcdSBHj1sTpeEr2Q6ln30UwcC/mLONODD+M2Wii1t0QlXDthgfxGgb7C7nnTYmtgrCMDPC/wYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFX1ESXb; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fea47bcb51so7293000a91.2;
        Sun, 02 Mar 2025 08:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740933215; x=1741538015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KGf93uhJnMz5v62KY5MgEoz35jhGi9QFj1VFR8SSNPw=;
        b=GFX1ESXbgS17JBliNwRLf8YFy25R0YtpUm4feCQZHwZrjUDWVrBhbG+ceSp5KC1kqC
         Jc9nXs7/SMG2RwM1Dza2UdeKVWWsfkX/Hq/9AIVG1/glBML+jcI7uN7lUZY2ko15A3u9
         KwlLtbO+11qxs95bJrNrFVcUc0cpELTYvj8AItoRv0C+uhSHOeivj9as9ejX8I60nIuk
         oAKJ0MmyNPvuTzgXfnVIbOXCCDck1mi+w59uNBi17WwPv8DmB1t3tY6OIZuVvt3m+RXe
         TCNqCV0HXWmHz/8PxrRXKpDLUS40kF2lJywGl7CimwriOD22s/2S7k63K1tE3D84cIHn
         A0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740933215; x=1741538015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGf93uhJnMz5v62KY5MgEoz35jhGi9QFj1VFR8SSNPw=;
        b=RNgB6lmrdAJ6gIV/Wz1is2q3yrEFjCTdeSVAFtuFTWWtkkSv079CRswgT7GySkUDrn
         GaaxWJoQ3DARB0JZURrNV09LgxLCNXf8fFMXsntrppkDp1lU0Sm0r9g9wkYEp9gt8pC5
         f1PP4U0L7fZLFFq19t8FBbWyx9fwrbh5zUkDhtJJcbmaloD9PrgU+WWJt4vfAKmLjF19
         o91IdjYRXN4fWiax7LdUTomE1yGAuRGPKU0IWTRohtjALujiLEYXfNUxzyrqd4wrD9Th
         H619Ilm46In9PzvDk1Ub6AorbJLSg4XJy5AmD5AV7LiQY2c+/XkJX+mPNCzJ/Us5Bt/3
         2pVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/WXJSbd/ijkf+q0FF3kI7jcNfCWYRbBrypgp6Nrmb2xHbNOG0nUR04mq43/XZ4Ji8DtLaxGBUNBLOb2/g@vger.kernel.org, AJvYcCWljJzKv/mx65XHEmdyQJBfVbd5gab9Yd6AKZcvg7ucJWwMok8PvS1HnDW2tJo7TKx+A1rUq6B//55H@vger.kernel.org, AJvYcCXktWX1hnJIHuWqYiILDLdXPGZZ8gQuneMNbBEuw2I+JG6FsDhcsAQSsr1w04fyVrsGh7+8Lf4ow8exhR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxROxsR6yexZjAcEax9il0fFNeSEKaf+SCqIX4jaSBYbkh+oOBJ
	Uxq/V1gDnRYUWhhZDsRmGJ2DjgcnjCBiD4gjDfZkyYUdUE81MOiW
X-Gm-Gg: ASbGncvzS8eZS7f+H8QxYJ1lcSvtUegMo8uc5kxojyqlWJSdy2Qt8omd+7x+L5cxo90
	EjPUZK2bSkEsf9axF4vkti+neAdYmKfgIq3ek50PVsuCgDcZGFF4EQsa4N3xUua4ZoX3HTN0nzV
	rx6X5jh/2CwWx5M85o5FzMPY1pZ2AArx0maYslGNE2F8ZlPsCCd/Yv5OviZwKE5sb9kWR+l1ihb
	5HHjzR7X8Xw3gx91cbBUCQ9tJ/BkpttP4LgkcVH2D29Mh02JcFBtCQoMB2TIvi1jKfs0JRogET4
	59I4iF1fQW5RoI8WI+2KZB2xjAuFTc5qE1Wj6+2fgB35m4/hbsCAbuQE2g==
X-Google-Smtp-Source: AGHT+IFAgz2uFZzN/TBODMqF9kZlNQUJvGc45uMhH4JvHOZNnceuX9oKAYxOHoyDMgy5cyvjQhQwjg==
X-Received: by 2002:a17:90b:4cc6:b0:2ee:c91a:acf7 with SMTP id 98e67ed59e1d1-2febab2ececmr15751860a91.4.1740933214863;
        Sun, 02 Mar 2025 08:33:34 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d2778sm62727795ad.36.2025.03.02.08.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 08:33:34 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 2 Mar 2025 08:33:33 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: maudspierings@gocontroll.com
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Joseph McNally <jmcna06@gmail.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: hwmon: ntc-thermistor: fix typo
 regarding the deprecation of the ntc, compatibles
Message-ID: <332bc087-d17b-42b8-b642-c7fe26af699e@roeck-us.net>
References: <20250227-ntc_thermistor_fixes-v1-0-70fa73200b52@gocontroll.com>
 <20250227-ntc_thermistor_fixes-v1-2-70fa73200b52@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227-ntc_thermistor_fixes-v1-2-70fa73200b52@gocontroll.com>

On Thu, Feb 27, 2025 at 01:57:52PM +0100, Maud Spierings via B4 Relay wrote:
> From: Maud Spierings <maudspierings@gocontroll.com>
> 
> Fix the comment stating that the "ntp," compatible strings are deprecated
> which should be "ntc,"
> 
> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied.

Thanks,
Guenter

