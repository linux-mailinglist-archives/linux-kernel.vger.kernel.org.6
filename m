Return-Path: <linux-kernel+bounces-417680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DA99D57DD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 02:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F4C2280EC1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 01:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC143176233;
	Fri, 22 Nov 2024 01:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ntba1n+U"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFCE16BE0D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 01:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732240390; cv=none; b=KndwgVDO1Uoe5Oe8ftVEbuINCEWb3spM+7JUaqIojIgUorYAwUw14cEHQKQhy+glUrL/FTwRlt+DmqzeXRKFmJLGv5lqb4WW/t8ozb9peb4u48bb6iWaksKyw/RvqoVeXAiAb3V0GA+gF7D4NXTkMk/5Xmq0FCojjqvkQmMlJQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732240390; c=relaxed/simple;
	bh=9Gp11wURsPmM1pehQpfczGqb8HtkTf/exkB97GkATNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4wxZqpfsQ3mJE+jTY9u8Q7qRPekL0UlX9k9zDqsErN8PqUodbeOpzcriTp86JHnxiCP26l/wA1XDLAY3i1fKwe+k8jM2awOPHrZmxaPDU1ksKvQTc9GHaDIbpAIS9zUtAxkqN66CD2rRd5Am67KQ9jaTMvAQ2f3uHR3U6P3NXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ntba1n+U; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7fbc65f6c72so779070a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 17:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732240388; x=1732845188; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3x8fo8ZdaZL0NcelbjOrkia6dNLJwkoa+yeWX98rz5Y=;
        b=ntba1n+U1aZ8ueNcS9WCkGjWKfWiZh/31OGOAvghUMxAEpuZIPm6GYz5BSYkvfGCb7
         //VDpAqAGE05CnR8jIUVT7T6xTau/yo+buZGciQB5db5DlYJrHJhIhjHzhwcMdH9xMQp
         59pT0jACE/NATTRfj1Nrf0KIxZuvrdrs5fuDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732240388; x=1732845188;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3x8fo8ZdaZL0NcelbjOrkia6dNLJwkoa+yeWX98rz5Y=;
        b=V5nF9J3eEa+OaISEWrBXJtWVvHWncOH5Q8XGpTlaKk79XkbUfx2kueK4uZNMr7Xrjo
         khNlYZ43XTDTy43H4nFHUD3oO7SA3YIfnrOge9lHagXYX7Ti4QOW7msb1/TCcC4oAU5o
         NXIE10yKUcN7ELBghfsKN/eXVnHqGUF0cIG/IyKHCaf0PGEcPUIQbp4saVGemcVdnOyn
         crkujkitgKWMPL2PwDTR29uKF3FnwdPmTWMFa5qjXhvrJI8vmgL2Py70ZyamU71cKPCW
         yQEeDSQG2/RquWfcyNRWvvv9/UCdAt9ozaV6I1bfhXwO33wA0b8kWir9DWDBqVjYOut7
         KliQ==
X-Forwarded-Encrypted: i=1; AJvYcCXd60Yqw2EZRd04oVHLphkGYQ9ruQKyToFv8L8NQUmCvDKFop4/Eo/g/AiJoIfDo2P5ubEKfSa3f/yEPlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY6wlo82zZ7GijrnO2V2+izEO8w3qM9tZ+/FfMAuFF907EZfQ/
	PuOn5D9ysPMLA40Y/w23N0GvBamCTVkA7s9gLnHsUZQHbWFtnLD/+wf/Micp9A==
X-Gm-Gg: ASbGncs7+WbtfDU/r67t+bthLvhkuloRPZkCJA70VzdduITBtSgY2TZJTftIg4NMYtU
	X5wp9E9iFCrqsrg55pcKbPgKzgh9jweD2Msz2pC98HLq2BnvtteU5eTZgj97wtlBh2lxatZW8l/
	/Hww7nRC81FV9SwENHwDPUC4lwm804a+7VmxknC+wgTwBV1OXmNvt20hL0tjKa4JkqlEj/1dwML
	bjkupTIBAFjii897g3QnYaTylPmubO6v95PHapZo+o=
X-Google-Smtp-Source: AGHT+IF1rzuF3haOxVKx1OXtXDkDX/sEISCXgMO2PAx7+IkM05srtj8d/7FtAHkiZLQS2l8phBPE4g==
X-Received: by 2002:a05:6a21:338a:b0:1db:f0af:2277 with SMTP id adf61e73a8af0-1e09e63211amr1302998637.38.1732240388215;
        Thu, 21 Nov 2024 17:53:08 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:533e:26bf:b63:973a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de47d186sm451941b3a.76.2024.11.21.17.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 17:53:07 -0800 (PST)
Date: Fri, 22 Nov 2024 09:53:04 +0800
From: "Sung-Chi, Li" <lschyi@chromium.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] platform/chrome: cros_ec_charge_state: add new
 driver to control charge
Message-ID: <Zz_kACWsTYt9CPbV@google.com>
References: <20241118-add_charger_state-v1-0-94997079f35a@chromium.org>
 <20241118-add_charger_state-v1-1-94997079f35a@chromium.org>
 <8fcf9154-6c0d-42eb-901b-0cc9e731e757@t-8ch.de>
 <1e8bf721-f930-4365-be48-a8c5964c1457@kernel.org>
 <7fc1bbbc-3cba-45bd-a5b6-0029cb5bb8fd@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7fc1bbbc-3cba-45bd-a5b6-0029cb5bb8fd@t-8ch.de>

On Thu, Nov 21, 2024 at 03:11:30PM +0100, Thomas Weißschuh wrote:
> On 2024-11-21 15:00:13+0100, Krzysztof Kozlowski wrote:
> > On 21/11/2024 14:47, Thomas Weißschuh wrote:
> > > 
> > >> +
> > >> +	return 0;
> > >> +}
> > >> +
> > >> +static const struct platform_device_id cros_ec_charge_state_id[] = {
> > >> +	{ DRV_NAME,  0 },
> > >> +	{}
> > >> +};
> > > 
> > > Reference this in the platform_driver below.
> > 
> > And missing module device table... This wasn't ever tested as module.
> 
> It has one in the general MODULE_*() macro soup at the end of the file.
> But yes, it should be moved where it can be found, right after
> cros_ec_charge_state_id.

Thank you all for spending time reviewing my changes, and I am very sorry that
I made so such careless mistakes. All these input are very valuable, and I
learnt a lot from them, and I will prevent these mistakes in future commits.

As we have seen lots of inputs from the DTS change commit, and I spent lot of
time coming up a better solution for achieving my goal (export certain
mechanisms, such that we can limit the charger chip current as a cooling
device), I think maybe extending functionalities in the 
driver/power/supply/cros_usbpd-charger.c would be a better approach. As a
result, I will stop the development on this series. So anyone is helping on this
series can stop review these changes.

However, because I am kind of new to developing the kernel driver module, any
inputs are welcome, and I have to say I really learnt a lot from mistakes
pointed by all of you, and I shall not make same mistakes in future
contributions.

Best,
Sung-Chi Li

