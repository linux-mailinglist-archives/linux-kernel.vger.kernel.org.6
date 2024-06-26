Return-Path: <linux-kernel+bounces-231641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD23919B30
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 01:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17B722841D0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 23:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510A2194148;
	Wed, 26 Jun 2024 23:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rt3pnG4M"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C51190073
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 23:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719445012; cv=none; b=BoVnJcFrr+OeaW0e1oMHi4qqZHo4nuDJufCzf1vyMD/ADD4awV2xzrLOGzvM23OYRK0vsdDhfxs2NuNe7RUUm3m6VotwlkX1glRVZ0Z+ZPUfv9brrLkDFeCQ4/8pqP3pwFeJeWAKxcnABvliunIsCrLzYB00Abc8CD7U8rEdRoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719445012; c=relaxed/simple;
	bh=z/wAF2IKsQ5synR7GDt8p9XW7wQtUDuAPAF7D3cS6cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLsVeJfzGlpFAMx+a5J1h71R3rAwxmPoTNkNmzkYPh3dgeuVFOegtfRLvshXemtIiNJVY/sMzCwMPNhsefVdp3lpExzFdGEL/Awj4r+fcyFsw9XyfWy5CRN9HImj5Kq1uuWSz8TQn797e0rnxUKkVMqxDqkQeuOmZfIX7T2Ln7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rt3pnG4M; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f70ec6ff8bso44805ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719445011; x=1720049811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oH/qUWFW4tGC7M67sX1amiT3vWfL3r4iG1qiqBFOKFA=;
        b=rt3pnG4MJ7hLQhRdM8Kke2tbcSbdYgd+gklTSa72kINn5PK0R4a+z2pWzv5tHutOU/
         ukXyCEqqfjJyjDGKw6OCqn0Se6ebzihvRTNSQBIITxrTr6dCDfT53w4M5+UaI7lJ11gB
         htJ4FiEkEIs04OnKIrkKNrUzcNYamSh/se2/qnm6uhh7VVs6EleJx+1PdjnxWlYW/TAM
         +/cdF0BsHd8UIh3qZE2PMUPrORE8WidmUlQaUGTFJ7WPgRun/zTygQ3wnEhGAsoO5Cir
         mVwNcYxOFQUxPdLjbh6XfzRovtW352xivntqyCaUz+EE7voHeOLDRuA6rTg0Rbw29ytf
         uHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719445011; x=1720049811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oH/qUWFW4tGC7M67sX1amiT3vWfL3r4iG1qiqBFOKFA=;
        b=uU61LuVHF8Izpu/WUhtHwhaGJ08/pgyQ443uuvAWn46bjdwKuhEqjL8iwZGD5zjn4B
         8Kc7bT2w30uH/1N/hR7mysULf2oQFdl70Pxus3KNN6P7jcWCOEXNxaqZJtqWM8YHGYz8
         iFIRORoKiIAzJnIxIbTojb+P7WSN9jlmVhZ13YnwU9NaVwJXqn6BgQs2z2EJEaXXHRAz
         tXjx0qy17qm4TIeFxkc46yTSNvHLh/Hcdnb0sfPPzC0+ekkAW22ui+9FMvH4nFSkEXIs
         PsghZQa9X1NNM/uEX4aUzEx+0P7xNyLIP9YaX2ddIvxCfqSmtcj+EaqKmgvDgfJWy1iW
         mxNg==
X-Forwarded-Encrypted: i=1; AJvYcCVssstqjpzOl8JMGxtTVLE3ep1KnPw5BaZDCw3s/Rczlg3WorYSmaXq3Fy3PYV3vPB8LkZAz90Ne5E/q5QbUUOPNDiRYLK+tIaUv9ZK
X-Gm-Message-State: AOJu0YwEYWktdGaBcXhAHp7H4bmULuwLcE/pNvGv1uw2iInLIBCk52XT
	UpnMjsub5xRvDdG/g1kn9VesxFFSucKEpnvKp28w6UyDP0kv72fhtK32TB1uJg==
X-Google-Smtp-Source: AGHT+IGWzunzRKU/pxSD5TKBv4BbD7ipJSDwv30o0P4jS2ap96vNu+qiT1InfYybFnYLD+PBVkyeiQ==
X-Received: by 2002:a17:902:8648:b0:1ea:963e:2e2d with SMTP id d9443c01a7336-1faa999a933mr1481655ad.24.1719445010425;
        Wed, 26 Jun 2024 16:36:50 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac9a75b6sm484945ad.247.2024.06.26.16.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 16:36:49 -0700 (PDT)
Date: Wed, 26 Jun 2024 16:36:46 -0700
From: William McVicker <willmcvicker@google.com>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	alim.akhtar@samsung.com, s.nawrocki@samsung.com,
	cw00.choi@samsung.com, mturquette@baylibre.com, sboyd@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org, andre.draszik@linaro.org,
	kernel-team@android.com, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: exynos: gs101: add syscon-poweroff and
 syscon-reboot nodes
Message-ID: <ZnymDq5Yzd0oyuIr@google.com>
References: <20240626194300.302327-1-peter.griffin@linaro.org>
 <20240626194300.302327-2-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626194300.302327-2-peter.griffin@linaro.org>

On 06/26/2024, Peter Griffin wrote:
> Reboot of gs101 SoC can be handled by setting the
> bit(SWRESET_SYSTEM[1]) of SYSTEM_CONFIGURATION register(PMU + 0x3a00).
> 
> Poweroff of gs101 SoC can be handled by setting bit(DATA[8]) of
> PAD_CTRL_PWR_HOLD register (PMU + 0x3e9c).
> 
> Tested using "reboot" and "poweroff -p" commands.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

Tested-by: Will McVicker <willmcvicker@google.com>

Thanks Peter. I verified the device reboots and powers off with these updates.

--Will

