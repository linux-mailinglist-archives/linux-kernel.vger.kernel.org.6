Return-Path: <linux-kernel+bounces-337887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617299850B1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 03:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 928611C22C3C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17395148304;
	Wed, 25 Sep 2024 01:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghVyEi63"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D81EEAE;
	Wed, 25 Sep 2024 01:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727228563; cv=none; b=DzjjatAhllRpnBc6ipkZZ71tZGl8bK/vW18wU0zRPyIn0kNwe8eIKhBktw869pOhRMGBbkQsjh+3kPlKaw6Z4jYehYAG5WqDJPfs9OntdJFPHFn1J+Iw6gfr+DEL4VHk+aoWDvV+AAgQ2hTsg3D8TMI/LzJRgNyV/eoF4vk4Qxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727228563; c=relaxed/simple;
	bh=fgukxMgAjrlRQrBVZ6J6xzCFT+TQlgaIYzBfc23MB+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHozCnTAI71+kh7t/3DzwhkI2gEwtLckkQZexqnrt504MF0MSeKv6b7Q1ir9n679/LsCNY4/kZhZDi47cXVi7+yzpX/uWStnilSPPyqaoJbryDGccfdE3i26OwM/oBT8kLuGzfKEABIqWj6rrxibgM5jtMy6vlnXnn6tP8ObmOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghVyEi63; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d8741c85bdso1169106a91.1;
        Tue, 24 Sep 2024 18:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727228561; x=1727833361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GcWVN5jq5I86+F+azhdXxblU0W/zeOeflgS1enKCNA8=;
        b=ghVyEi63f4DwO5qcJ+7ys4Ss8h96DXACwtNYHAn0h5OfYlCoInOmYoj8q3Gw4Ev/pT
         xGX03g4O1WUQBsE6i7O26NAKWAWh5IxVqgZIeVcPmyM/vqEUOW2cPr3pf/2Qt25kJNiP
         yEuTEACsWj7tik79TyVBU0YCt3B7NLwzWiY5lFWrrpw86WdphMrDuGgejZ943gfZD6Lt
         NVbFppGS1XxvrTr5BS3vZMF8IRi/2SkWe42PMoSYkDJP5lWRywAekWsGOvOCXpWiS8Mk
         mRao0fEx6gj6u+Fjz8ZPpoFBLcIhBXkfci7hx5teTzjUdEmEUUc3yY1XOdZr1nDHpSF0
         Rtvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727228561; x=1727833361;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GcWVN5jq5I86+F+azhdXxblU0W/zeOeflgS1enKCNA8=;
        b=e3txj2rrA1e9KmbrBcsrJtlsdbPdJbnALs2tDtplyvwuSJwJDz5hkxryyssZ5zuWW1
         B9vsT1ffKXDuYxG44cVwosOJssvpD+3INV2wELSGYwlfEOqjFTK4U+XRwXSdP2qqBxws
         lSPRJ1iFs3eaYLX1Y32Jh2BW1a0vEbO5XG5izTfKD3ikLlAWpnr0oV4Jrxhz3/w7S1wF
         uKK6zSSaYzmXniNZhBEYpOuuEPSNV2ktgwuSbZn+1aRx6IvRB6zu9h49zlgWzZgD1Vfl
         eDW2dDN9nIOJfFeIrWMT26n8WaN97nszLkeahWlYUgguihuc+NAjgzXpwWWbzgPRLNp0
         avqA==
X-Forwarded-Encrypted: i=1; AJvYcCUAtkhjVk5Jp30AvluDM1/O/FqiGWElWv06SpzGkDqMgKfdV6+DMAtc9KYwwCzrHWx5f+GlRWyhNjg2@vger.kernel.org, AJvYcCUiPRtNs8xf35ZwWzGcw3uEHKpwR4WL6PCqzJDFxW5d2n65bDt4LY/un6JDzh6jaLTMHCkN16XmgwtJUv0Q@vger.kernel.org
X-Gm-Message-State: AOJu0YwjB7CXT/ALPQXrM9xQyuZYIJdrK+gZHAbpgbOsfxDh3p4nYh5W
	X+Z4hdVcdJ+91cDpzvo/DkVPYIsR7AVJ+pefouIPFs+4VQZrX7EF
X-Google-Smtp-Source: AGHT+IFqIBT66TkyL0J2QfmtEOX6F9Je5mvlnxVw4zEkidcGIvNVdjtGkMa+udbesxpclhLKmHCHiA==
X-Received: by 2002:a17:903:110c:b0:207:14b3:10f0 with SMTP id d9443c01a7336-20afc6427e0mr6506155ad.14.1727228561153;
        Tue, 24 Sep 2024 18:42:41 -0700 (PDT)
Received: from [192.168.60.56] ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af18572bdsm15396675ad.248.2024.09.24.18.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 18:42:40 -0700 (PDT)
Message-ID: <29d80d30-dcbf-4fe1-b7aa-3f8c46fee714@gmail.com>
Date: Wed, 25 Sep 2024 09:42:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] phy: rockchip: inno-usb2: Add usb2 phys support
 for rk3576
Content-Language: en-US
To: Heiko Stuebner <heiko@sntech.de>, vkoul@kernel.org, kishon@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, william.wu@rock-chips.com,
 tim.chen@rock-chips.com, Frank Wang <frank.wang@rock-chips.com>
References: <20240924085510.20863-1-frawang.cn@gmail.com>
 <20240924085510.20863-2-frawang.cn@gmail.com> <15288441.JCcGWNJJiE@phil>
From: frawang <frawang.cn@gmail.com>
In-Reply-To: <15288441.JCcGWNJJiE@phil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Heiko,

On 2024/9/24 18:01, Heiko Stuebner wrote:
> Am Dienstag, 24. September 2024, 10:55:10 CEST schrieb Frank Wang:
>> From: William Wu <william.wu@rock-chips.com>
>>
>> The RK3576 SoC has two independent USB2.0 PHYs, and
>> each PHY has one port.
> Can you please split the content into "converting to clk_bulk" (see
> additional comment below) and "add rk3576" please?
>
> That would make the patch a lot cleaner.

OK, I shall amend in the next patch.

>
>> @@ -376,6 +378,7 @@ rockchip_usb2phy_clk480m_register(struct rockchip_usb2phy *rphy)
>>   {
>>   	struct device_node *node = rphy->dev->of_node;
>>   	struct clk_init_data init;
>> +	struct clk *refclk = of_clk_get_by_name(node, "phyclk");
> Doesn't this create an imbalance - with the missing put?
> I think ideally just define clk_bulk_data structs for the
> 1-clock and 3-clock variant, attach that to the device-data
> and then use the regular devm_clk_bulk_get ?
>
> That way you can then retrieve the clock from that struct?

How about keep the clk_bulk_data and num_clks member in rockchip_usb2phy 
structs, and retrieve the clock by "clks.id" here?
Just like the following codes.

@@ -378,8 +378,9 @@ rockchip_usb2phy_clk480m_register(struct 
rockchip_usb2phy *rphy)
  {
         struct device_node *node = rphy->dev->of_node;
         struct clk_init_data init;
-       struct clk *refclk = of_clk_get_by_name(node, "phyclk");
+       struct clk *refclk = NULL;
         const char *clk_name;
+       int i;
         int ret = 0;

         init.flags = 0;
@@ -389,6 +390,13 @@ rockchip_usb2phy_clk480m_register(struct 
rockchip_usb2phy *rphy)
         /* optional override of the clockname */
         of_property_read_string(node, "clock-output-names", &init.name);

+       for (i = 0; i < rphy->num_clks; i++) {
+               if (!strncmp(rphy->clks[i].id, "phyclk", 6)) {
+                       refclk = rphy->clks[i].clk;
+                       break;
+               }
+       }
+

BR.
Frank

>
> Thanks
> Heiko
>

