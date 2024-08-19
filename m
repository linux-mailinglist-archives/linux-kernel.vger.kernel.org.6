Return-Path: <linux-kernel+bounces-292938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 194899576B1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 23:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9362CB218A6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B621DC485;
	Mon, 19 Aug 2024 21:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O42P+Im4"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E56E1D6191;
	Mon, 19 Aug 2024 21:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724103425; cv=none; b=Q2Gj+x72pzkE5QpkKdalox/+RIMzzlvKuHrlyp7WH+qDj/TrwACU/gz+J2/vJ1TqpiRWsC4Hkj79ufVc19+jlvP6xOdOsypSn9OAzcRihe7V9hqOU+83Dw/3Tis+GmtcR0tww5TdS1N6CZF5IWqNRsUg+SZDMw+Qg+zoMEbZYTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724103425; c=relaxed/simple;
	bh=ZhlxgUWZA7Mzdd4SO9mRlaORtWiZzjROZug9lz/RMtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBoJek4ynpOt8ebLcDbHvxZA7hgq3XpXc57v/WUd3DYvhQNVUCWtleG5hwUfV5idTHsuY6l9dIy63YozqVHSgdO+jSLAoKBHm56o9Hpgp0+DpGC+GD5fjTXl9c/Ph5kpIx7Ea7pszTMDyE9v64Xb96b74gdHj38hOb5S0xPpFXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O42P+Im4; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fec34f94abso41726965ad.2;
        Mon, 19 Aug 2024 14:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724103423; x=1724708223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KbFmVdZVt1jZ2w7ablB15iTS/AnL4wG1tnrAxNIbA+0=;
        b=O42P+Im4jNkc4dzzWhH9PPkerrwWipgmJa+jNgl3ZJr9gP/Q5FUa/m11lEO9I9BuUF
         tN6L6EiaXoCk6xNZV0LlNoks1Am3OIJAJaPHPe/eZmSuBU8pdFRfTHD+kxhrZGIIehFI
         hnTDsXCG3VbgADcoDxFFHBgXL3ZhpzuU8wBk108xYfgNTtFVqAAvQK2U9u0xOKKQGUzP
         LekEACRIYGDARk3vv8ILdogIdeK/dS3Dhi8bjmxP0Be2hBJQ70/V1WPZQgKTrlgGmGa2
         HrJL57Sae1SYWgaU71oNMY59chdjGuT2dpV4LrXpxlSil2mf+PL+4vpMlvLdBVBPWYBb
         PeOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724103423; x=1724708223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KbFmVdZVt1jZ2w7ablB15iTS/AnL4wG1tnrAxNIbA+0=;
        b=Z5HOsGtoGiOCV4ge//pZxWafgs8JFv1y1QffhvUsdGxl9lUWBHQ4gRQ9tS+/KgZzP8
         HBRULtqr7zpMiaTQ1HcNSj53ACIkFbdovWdFBJda6GcAdL+Pzd50zscS5KGgik+7Pcjo
         fLyXdAy8YwRCnd1SGA1ngsgl4WzdnDbTaT+DyDgZssHK8TXDKKHBtL5eYuUIANrd6ynm
         JqbShuYoVsXjk01IGpm3MveGgpltbo2b6cpgT1ijuMUpwNhe3s+V7d3WHMQSZPNht9RZ
         LwXOgetwgb38UpG+SvuqUQXRAeeLxHKPf8bH95WeknN2P29j6gUb3jlaDJgLn+bOsD2e
         ZZRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkG2YOhau3XNIGovQ2n8hAj2QerTllRpG0q0hM5Tt/Hc1kn5cLQfVg9KsUvTThlswMiY0fnHBbPfqJlB/pO/Kz0/xe9IdzaKV7eGk8ZGRWDyxgy9VMSdSGkvuvuhdspLrOcfnP7T4HPhMiiw4euzZqUzSFFia1YBoI1nkC2iiihNBsZUfy
X-Gm-Message-State: AOJu0Yzf0RdJ7+dYGRa5xNecAoOmRRLrTBkn7FSNx08039JQjjDaFKqy
	H8+/kK2PCCF5HUhkMvSMedQFcTbIp/QQbFmgPzwMhGWrpHLqbpAZ
X-Google-Smtp-Source: AGHT+IHItFcJqz4vPegw9f19DaR5lvqG3jsvTuiwi2TkotQDaaEWjcFXJm6BiUuo7uswJ0PWg5G0RA==
X-Received: by 2002:a17:902:d10b:b0:1fb:6d12:2c1c with SMTP id d9443c01a7336-20203e9b06emr88206325ad.19.1724103423231;
        Mon, 19 Aug 2024 14:37:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f031eb50sm66377835ad.119.2024.08.19.14.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 14:37:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 19 Aug 2024 14:37:00 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Frank Li <Frank.li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Jean Delvare <jdelvare@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	"open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: hwmon/regulator: Convert ltc2978.txt
 to yaml
Message-ID: <e63f6e5b-09a8-400f-8425-8dac4284fc9d@roeck-us.net>
References: <20240819190652.373222-1-Frank.Li@nxp.com>
 <bea0d3be-6b2a-41a7-8644-44b17d3a26dc@sirena.org.uk>
 <ZsOfeimD94+mh5gt@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsOfeimD94+mh5gt@lizhi-Precision-Tower-5810>

On Mon, Aug 19, 2024 at 03:39:38PM -0400, Frank Li wrote:
> On Mon, Aug 19, 2024 at 08:11:46PM +0100, Mark Brown wrote:
> > On Mon, Aug 19, 2024 at 03:06:51PM -0400, Frank Li wrote:
> >
> > > change from v1 to v2
> > > - maintainer change to Mark Brown <broonie@kernel.org> (regulator maintainer)
> >
> > I also shouldn't be the maintainer for this specific binding, it should
> > be someone with knowledge of the devices.  This is a requirement imposed
> > by the DT people, I'd be happy to just not list a specific maintainer.
> 
> I remember 'maintainer' is required property for yaml.
> Look like Guenter Roeck contribute many code for this driver.
> 

Yes, but I do not maintain code or documentation outside the hardware
monitoring or watchdog subsystems. You want this file attached to the
regulator subsystem, so you'll have to find a maintainer from that
subsystem or sign up to maintain it yourself.

Guenter

