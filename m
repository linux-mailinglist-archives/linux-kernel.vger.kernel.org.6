Return-Path: <linux-kernel+bounces-318613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDFC96F0BC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386171C233BA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4992C1C8FC7;
	Fri,  6 Sep 2024 09:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="iZqKhBpJ"
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7080E5C603;
	Fri,  6 Sep 2024 09:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616785; cv=none; b=Cs/5YAz/H8BV8EzHtVQmKZovYWG7LRBy03Ksjay7FHdcRBWkr5IpfNKo4P25sL0h5CtJe71BIo/2PLmEmkxoLJHiaTXYnS7WMhXFc+eOCCkRC2vvjoSXcfIr+76KJpUJI8WXCdS4fAiczwIF9LSvkxwa1B7/gbtdkQfg3NzYruc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616785; c=relaxed/simple;
	bh=OBYK/cwmrrD191HhapUVtf6Eff+iVUgfCnF3WCkWNXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=otslukITdEuNt2Tq+idkbIeIrnlaOCnONqBBPBfGApk37MLW6k6eJ6sDWhYss7+UfDITsQOKj/5W6DltBknleOcgd/qjWgwJOhwZQuHSq1Fm3qtdwIjH2/bIP64Wzx5ly/HsVWD/XEo+6Bj02LPUQmU4/xbgRykHsaOHaXGopag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=iZqKhBpJ; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1725616474;
	bh=fDzdhuq3BTn/PhJmovzZDBOySf443Z+eO59QGoBKOow=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iZqKhBpJOUuqnLa5PVE51S4iY4/QgijDkWSe4nnTQq379/IZytpCLC9Ezl6RmKUf/
	 +F+PHLe8nhF93tRTCA1PvU7wnli081e9PSdHtROstQVG1shrxhiRxXVTPvkAsrS933
	 iYt3ee/AVSFjS/DmP5BJJWtPrhYYwHN1hZd7tSmQ=
Received: from [192.168.2.109] ([117.62.156.135])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id CEC07E63; Fri, 06 Sep 2024 17:51:44 +0800
X-QQ-mid: xmsmtpt1725616304tb959mdc4
Message-ID: <tencent_443CD854D495576C1821D5843AAC5FCC5808@qq.com>
X-QQ-XMAILINFO: NhLjqwvA90qWIIAUxAYexinvYgvrzd/w+O+eDpoGCWiNfgdXBpv07xXAGH7PJK
	 JIIvyvDBR3CyyW3A+5RpTFDZNygGOqzxpf22C97Pe3//YGUau5lWro+GagPYmJSvNCc62MH1LaVj
	 SRDzVmNLzE8VVS0h4IMtWDh0AgFOGrcnfrYQbPW2xi25TuMCG2RvhuQRayu+W2oFOaCvdZAFcz3e
	 j8pgiiHIh5jaYarUCsxqWWaiCs1/kOEjiKl4e9ZCd4KRWf5DXEFyvofg/1HXO2rMuwsnq1iDkEzR
	 JHIHn913ktMNycrk24zRc/btVcQ6me3kG4XZJdoWgvZZvu0000le0OWETlb/m7PaNNqx3TuXQhXP
	 TY+gbWs9wgdm4tELRcHpA4vJBERS/wKa62hoqUevPMgYpZ7Ao2WIv6WpwuHf0YgQnlwn8FLkmQDp
	 B+FVuGIwkU+6JNUzqm4R5KC3hhhfjkar/jB0HjSkei9U8W7gCA+qTMNlgjqW6HQROKZazNttB055
	 H2x81GNVGk2CoTBU4nH2WGhugBEnY/prQ/YtaMxgJdzE3N80WEN542WEJB2ggshncbIvVJ1d/6S5
	 XHWOXGLcXbMDwTqzQhSFcef3Hg96Z/hJBp2EBtCV5rGbT0+3JyK9U9OJ5HJfF9kCr5IqHp/QI1hT
	 7c1QKPooZHEkt5XG5zoHUKQbvMYCcDkq5f5Bzwzk7usKI0nF6FjMxsYOou0F/F9b1F2pEZ4bdr2b
	 OEOiVFzSlQvdHSO/5RhmTgQyDaNFXmGfxV2NxqHPTNmpiNcFGkOuUUBLT1uZJwgbH/pM1bsXZMZm
	 JQexuG11pZdcTu4A5dp+BYlI60uk1H17ll9kMGXFGTKPg+9FNzI7taXQPt7CMA0jf4/NpCfba0c+
	 kUb+uV4CHWAT3bmlUAChsv23Dkl0M2pbAZWXgAoZJtHd2Ola2V1KLCkmIzFwe/dsVsFOYAONqkFJ
	 6V8lgW+Gt9jznoHzy8ELyf3rFL7wINCVThjPyKVdzqrf3emjovdpCi9SzW+JWGoiN6nAtRnDM=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-OQ-MSGID: <18db40ef-3922-4752-9f11-d6d9c8e591af@foxmail.com>
Date: Fri, 6 Sep 2024 17:51:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: clock: spacemit: Add clock controlers of
 Spacemit K1 SoC
To: Haylen Chu <heylenay@outlook.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <SEYPR01MB4221B3178F5233EAB5149E41D7902@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <SEYPR01MB4221019943A7F5361957811FD7902@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
From: Chen Wang <unicornxdotw@foxmail.com>
In-Reply-To: <SEYPR01MB4221019943A7F5361957811FD7902@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024/8/31 23:47, Haylen Chu wrote:
> Add definition for the clock controllers of Spacemit K1 SoC. The clock
> tree is managed by several SoC parts, thus different compatible strings
> are added for each.
>
> Signed-off-by: Haylen Chu <heylenay@outlook.com>
> ---
>   .../bindings/clock/spacemit,ccu.yaml          | 116 +++++++++++
>   include/dt-bindings/clock/spacemit,ccu.h      | 197 ++++++++++++++++++
>   2 files changed, 313 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/clock/spacemit,ccu.yaml
>   create mode 100644 include/dt-bindings/clock/spacemit,ccu.h

Suggest to use format: <vendor name>,<soc name>-<clk name>, look at the 
files under Documentation/devicetree/bindings/clock

For example:

starfive,jh7110-pll

For your case:

spacemit,k1-xxx

BTW, What's "CCU"?

> diff --git a/Documentation/devicetree/bindings/clock/spacemit,ccu.yaml b/Documentation/devicetree/bindings/clock/spacemit,ccu.yaml
> new file mode 100644
> index 000000000000..90ddfc5e2a2f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/spacemit,ccu.yaml
> @@ -0,0 +1,116 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/spacemit,ccu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Spacemit SoC Clock Controller
> +
> +maintainers:
> +  - Haylen Chu <heylenay@outlook.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - spacemit,ccu-apbs
> +      - spacemit,ccu-mpmu
> +      - spacemit,ccu-apbc
> +      - spacemit,ccu-apmu

Same as filename, compatible string should contain soc codename to 
differ from other soc of spacemit.

[......]



