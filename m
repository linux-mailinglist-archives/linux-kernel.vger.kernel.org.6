Return-Path: <linux-kernel+bounces-289769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C023A954B87
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 434E5B2238A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7621BCA08;
	Fri, 16 Aug 2024 13:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="s+dtJTWM"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60F31BC9F9;
	Fri, 16 Aug 2024 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723816664; cv=none; b=km/HIc4yyyekptvm2ytwkwy58A0j1XSRbs4FZ/LsMNo0I9bcIkX6WI6MgYNDmthDIZKAz8Oom7IAg0gdo7t7Kfchoxrzf2bGoIWKvFp6+wTXypaAc+1VYkqU4L7mOTkKxUTTvMU38vfI29uM0LDZls0I1WhV74dwVEgwRn2LjTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723816664; c=relaxed/simple;
	bh=StscK8FxfWZdG6WMuxNgzCEvEk1AejAC7UhY7FRMahQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcmtUeGEmlNH7a54nYa1Qn/CnoHtB+llCG8UUotThUfvkyneBcHD7ts+Nm0MDe4ixUEbulDh/t/lmNCBqvpZFZYAJouH1iIfNTFnbl5IBezsP/SBRXTNre8GQlXaCaurA2Wdo4lf6pjeeom+4OvKzh4ySgdnbFcvei+N+8pYtSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=s+dtJTWM; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=c/qeNm0gickEi5kHpgsZtFtwQ/SdYgXdxnuELkHBkC4=; b=s+dtJTWMR1Z+iN5/NcVIN3Z+5x
	ZKJSHyMDp6qT+0g6RR/0naXbad1QJp8au5ngnLaWAq7qmwNiIUwLwd2lT99UVnjBh1RgxRFYcGxIS
	U/3yuezvXEsPs9IvY7xVFANYGD4lM8aqZbGFq7wGqfC9KLqy+xXJYbWbKhFPdYN1vEa1YE0hSvxZa
	OxwsLCSiR66VXrh+22NnNn6UmwgI+/kyirGRXv1sVz7m9Av1Yq1ZmiCNbVmnFEyf9D7aNuB6KnVKf
	P43b535eIAxltDBT1oqKdbzuFIyT82poSk7GUQ5HsZSxddFmUxRkafJ2Sg3uAY6b8ej8u58N/pZe6
	LaMfmsIQ==;
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sexSK-0002hb-TQ; Fri, 16 Aug 2024 15:57:29 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Conor Dooley <conor+dt@kernel.org>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: add wolfvision pf5 visualizer display
Date: Fri, 16 Aug 2024 15:57:26 +0200
Message-ID: <172381656037.84677.11780206459201436040.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240412-feature-wolfvision-pf5-display-v1-1-f032f32dba1a@wolfvision.net>
References: <20240412-feature-wolfvision-pf5-display-v1-1-f032f32dba1a@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 12 Apr 2024 14:54:09 +0200, Michael Riesch wrote:
> Add device tree overlay for the WolfVision PF5 Visualizer display.
> Since there shall be additional variants of the WolfVision PF5 display in
> future, move common definitions to a device tree include file.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: add wolfvision pf5 visualizer display
      commit: 73d6eb7e77099054f7ce4a595767603cb4a096b1

DTC update in linux-next now:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=d2a97be34548fc5643b4e9536ac8789d839f7374
to prevent the compile error regarding the unknown node-name

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

