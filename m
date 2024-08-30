Return-Path: <linux-kernel+bounces-307946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 002D1965558
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CE651F242EE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 02:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C8982D98;
	Fri, 30 Aug 2024 02:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnH8e2lq"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D877380;
	Fri, 30 Aug 2024 02:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724985636; cv=none; b=c27Mns++6aTYWt8dpUllI3v8Eu2HxTpXov0IizlQkzNoNUWbIFaegMYYQC6p0OWuyNGIofbFBh77a8uloWRazddqrN1YcnGagpuKsTodYzOvH2pJjlPg6TIdHfjng6Mfea1MLidPQaSFQ9jedhEKrMtsSCArYVLE64nV0fWsF04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724985636; c=relaxed/simple;
	bh=epwxn7dBqW32cxf+5xRIHwjWlChko6uUxNTcXACtVFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMrp2QlxsliT2ITx07kDZNuFhrO77hpmMua9NYi+AbefCNnRtnHoCjM2jIz8pP94d9SRQ0tK+SNk8uLKkfnJRtMGNnxn1YilVgurJ21SiYkEUmiAeTcEWLeYaUxBdQ+UMGtwNlKp/yOwntMhI23ldLQuJ8HeDV/mqz31Jd2Y0yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnH8e2lq; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5da6865312eso874071eaf.3;
        Thu, 29 Aug 2024 19:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724985632; x=1725590432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J+HVqijkTIXEILMWbpv1Z9naApBVGhXsa5ns2Qf6WFs=;
        b=WnH8e2lqEwRGzzSzPyGOloyBGOV1n0ZkjPfoPKlWGp/shdi1qo63MMuUZlfElm7HQf
         jlXzyiI3OQ3PuWCgEcSsV1l/8fHDeLllxFJG+sP55PmnYQgolVhp2AbOVZADQo6kq1Gy
         dQiRccNdN4js2jCfARtKt1HHtRVESQLkw01x3y/heNJSFSWvVqw35/UOQQGgvyr9WdOL
         99XqnPFdFTO6JVEm+I7aZCXkq9ug1qcyD2O6Nvee3D1MDFTOEh/L0mQnR6QgReXqaqDy
         QLiIpqltfRbYfhbqhhYujSvCmyIllAlTTwJQD85qOrxMzNJmuip6l8b/Pj8ZaG7YXsDu
         yXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724985632; x=1725590432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+HVqijkTIXEILMWbpv1Z9naApBVGhXsa5ns2Qf6WFs=;
        b=kNPhTKL+euIuqvnhVYDTVJI0jJxnlrWsNgNeWTc4fzrPwHkqR2GEsMJvc6ZQIp/tX4
         0mkENpeRbO1xbosmvcZ/qrTbnKn8yhel5OgzcPMQ//ICE7oQrW4NzWFvWPMyVWJFnHLV
         hZWbP22BMc1JstIzlIuTGmhras1ToHK0kp/T07uqA/L8OYsVlGu6CkE6uqO7+I3DQeDu
         JNYS7VkA/xNDCPzZNlXFCwLQfKCNoUL+/7pio1+Bheds1/pMk5/9uQtEhHolXz7PqFjm
         G4TXAPu6zk+FoXmp2pg96oH67VoNxEpVESUt3na9Uw+C4ZUvkbQpkXtEK4qkycYa4wK9
         lL5A==
X-Forwarded-Encrypted: i=1; AJvYcCWdS03qTb8oIEV9A67n5VwmO+BnZvcRpq3BLQtWciHgfNfXLcUt24RjgQJFifwF0lcOgrS+yZFvfQx6EQ==@vger.kernel.org, AJvYcCXwOiQMbfUzjKr0Ycdoby3e5iGobovU6ezAyT7d1TYC39h5WQau9RBpeGKwlZgxOoXEGB/sT8OVHLUt5bZe@vger.kernel.org
X-Gm-Message-State: AOJu0YwGfIB02KTpHIBiwMlJ5gc45QtNu4JimMtPBKqskAdDlDyGlNXU
	g9TuHTLAfmMFDd1NpObatQpsJnMCNpK7BmsrAWSTx7PqldDLBxp66wM2Ow==
X-Google-Smtp-Source: AGHT+IFeJaGN5mhTTn2+192nZeojLKG3FQ+88WTKHQwotYDdZrCrJcC0qo8ocLGWSVNXGmE/FO9HaQ==
X-Received: by 2002:a05:6358:b00f:b0:1ac:1492:8d5a with SMTP id e5c5f4694b2df-1b603c3bc36mr635115755d.14.1724985632329;
        Thu, 29 Aug 2024 19:40:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55b4c9csm1798483b3a.88.2024.08.29.19.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 19:40:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 29 Aug 2024 19:40:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Loic Guegan <loic.guegan@mailbox.org>
Cc: Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: Add support for the INA260 chip to the INA219 and
 compatibles driver
Message-ID: <80ad5b6b-36b5-4d16-8bdb-93b94401a8a8@roeck-us.net>
References: <ZOILXb-1ObJRB1ck@lguegan-thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOILXb-1ObJRB1ck@lguegan-thinkpad>

Hi,

On Sun, Aug 20, 2023 at 02:47:25PM +0200, Loic Guegan wrote:
> This patch allows to retrieve current, bus voltage and power
> measurements from the INA260 using its default configuration.
> 
> As the INA260 provides integrated shunt, the "ishunt" configuration
> parameter is introduced. As such, proper attributes can be attached
> with hwmon and shunt calibration related routnies can be ignored. In
> addition, the actual INA2XX current register address differ from the
> INA260 as it does not provide a shunt register. Thus, a specific
> register address INA2XX_CURRENT_ISHUNT for chips with integrated
> shunts is proposed.
> 
> Signed-off-by: Loic Guegan <loic.guegan@mailbox.org>

This patch will no longer apply after the series at
https://lore.kernel.org/linux-hwmon/20240830010554.1462861-1-linux@roeck-us.net/T/#t
is accepted and applied. It is also less than perfect since it does not 
support current limits. Adjusting the driver to support ina260 should be
much more straightforward after the above patches are applied. I'll send a
follow-up series of patches after I was able to test it with a real chip
(I am currently waiting for an evaluation board to arrive).

In case anyone is curious, the (untested) patches necessary to support
INA260 are available in the hwmon-staging and testing branches of
git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git

Guenter

