Return-Path: <linux-kernel+bounces-300557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B9B95E50C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 22:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0004EB20F59
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 20:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70726A8D2;
	Sun, 25 Aug 2024 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="Vw5M0PGH";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="OVoCRC3k"
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8020801
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 20:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724616982; cv=none; b=JIZmLhfHy2DC80txk67fU4YOB5lFpAQRtMO2I49HW7nOvf6pg//zVvSCA2KyH9I6TOZFfdIg1p5bgQpzirEQjcNZtz6TZbcCEVjxtWQOINiPNK05DWdlqCj4u90RoQFIy6AuiyxbRhdlW/Ox4Hbl8rAXuWPF4Te2n2EG77zSayU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724616982; c=relaxed/simple;
	bh=IftuA32XlEbaZofHucC96uY7DnLWjOMFJXrYAbowuxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AL7JyH9PjidA9NhT68e1CagdBJ3vuoAr/Ukq09QBwZ39Bg1uhea1vm1nzJIitFfSjA/8AVPImus3wb8eI2odx1lpmgP9rcDRjFadc0LCeKScaoULUXUVn5oOFVHAgIqH8C+CMjdG1eEUvp2u0A5lH0y0pgSTqTyBTd5fbkLpWjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=Vw5M0PGH; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=OVoCRC3k; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1724616979; bh=IftuA32XlEbaZofHucC96uY7DnLWjOMFJXrYAbowuxE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vw5M0PGHSNqyRDXXTCPxp04Ukp8NusTDFoBlaUrO4IpxPVCSVz0aCiFT7RhvYHFYi
	 BLPBRrnIvlD4n1FzWgZC+JcMNH8Wu8IvlGXZXArhUsGsrfrv0D41jcYYB0Isp1+1y2
	 FC08j6ikn9su+V+x0pL+ZYGuvABVIkiUbl55glvUY+FqZVd3rgpiBpEz1/O3E48iDn
	 KqUChoLWVuXurEyBlNAjpSt8se06GjGiKlULuBbNs+hVCP8wrPS4qo/eBMV9F7oKOB
	 q4sJwHctlKc4Yq39bcVNjCi+S330WhLm693p+k21iu7C/aeTm9dqMRzU3OKJNgnsoT
	 ivPXBQUh3YYZQ==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 00E9116C9;
	Sun, 25 Aug 2024 20:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1724616978; bh=IftuA32XlEbaZofHucC96uY7DnLWjOMFJXrYAbowuxE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OVoCRC3kQ36E/aSOrcsfVbQpeix8i3FTvxZvC66afdP1KYM0WT5RjA6BYUXu/PC+A
	 o1k7LuuWROvMbLL1yNtBY94AEfFzkE1MMsoAC9R+BCXd8hQwmi4VjbpU425YrHd3SJ
	 DZFfKJr/6IPkDgt5Fp7ETlE8OSE8gjIKTEmgr6kz1WSdaNFZoKRt34Q+GnvuyPGv6F
	 H1bF/mCeE2mheqjcm9id8GWxpgGVCXFp1yeIlvJTMrmXmjv0wH9UsDS0QKDpUftoCN
	 YANumklnkoTAr0HoIPuGYUds1fjlYiFK8TjJEZF3TBMd4J1hVkJuqXXD0tYPp8vFwb
	 akdh8p4zN60Ig==
Message-ID: <31fc82ae-76e4-4045-952d-210f8c47d7d7@mleia.com>
Date: Sun, 25 Aug 2024 23:16:18 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] reset: lpc18xx: simplify with devm_clk_get_enabled()
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Antoine Tenart <atenart@kernel.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>,
 Palmer Dabbelt <palmerdabbelt@google.com>
Cc: linux-kernel@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20240825-reset-cleanup-scoped-v1-0-03f6d834f8c0@linaro.org>
 <20240825-reset-cleanup-scoped-v1-5-03f6d834f8c0@linaro.org>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20240825-reset-cleanup-scoped-v1-5-03f6d834f8c0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20240825_201619_037168_D36C7569 
X-CRM114-Status: UNSURE (   5.24  )
X-CRM114-Notice: Please train this message. 

On 8/25/24 17:14, Krzysztof Kozlowski wrote:
> Use devm_clk_get_enabled() to drop clock prepare/unprepare parts and
> make code simpler.  Change to dev_err_probe() in handling
> reset_controller_register() error to make it even simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Vladimir Zapolskiy <vz@mleia.com>
Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir

