Return-Path: <linux-kernel+bounces-201113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1798C8FB9BC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422FB1C24AD8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C33149C79;
	Tue,  4 Jun 2024 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6oDQq1P"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8E4145B15;
	Tue,  4 Jun 2024 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520427; cv=none; b=tD45sZH1IEvgtDnsrzOj6H8rOaRwgwHN5ODKYNrzBludgpa0+p2aat7YhUWLs68G9zMJySLauavRv25+B1YwGGqbMRZFkHygPIPgCq/4jNs3ETJkhgpLd1AIoVnRW5dIZymqS1P0WubnBQ6OT5NW/oC7aT10EAKywDiOlyDyq6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520427; c=relaxed/simple;
	bh=17dXFGae872whgZklDQQzkiEAYOWAobA+XzsoWEhIMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkN+YVIK6QohhZ67wJGfoKwedKv0UzXG7R8SFjGZ2wuN+X27O/W1vPyiM6z+PZjg/Hq7r7o/B+UHPV8Z7bpx3vq+YbCA+fj/Y1slHHzVul76XfKDBXuXeGsPhp7O3lS4kO7Gf0UTf6GxRtMHnpi59+PZ1QViOA6MfmPce86ibew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6oDQq1P; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-702548b056aso2875039b3a.1;
        Tue, 04 Jun 2024 10:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717520425; x=1718125225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZR9T3dKRqYP06jWojlNU1wVp16lfFgNyl8ujlT0RpX0=;
        b=Y6oDQq1PvGyvz3ARiAB5k0B/jq520juWD7tcpKrFHxGlR09Nc2rW6jATPF7phne23t
         07j4SbPrSRfduGhuFNw2qZG+k6LAmHSDmpijVX9+TW63MFYPxCKPW3UUqTfDhAr4Nepp
         eVnN98FkFiq3xWEZYMmtRegqeyOcaDibxmLi3bb3wnmiaJ441JaZ+V16/S1roOucCOuE
         Hdvg+/EaZafLAvHLnqqhzjsUkJhKpzxdm2ZjlLj4JSAKOjhGymeRWX8hPNc21VMCH+RL
         NvyRGpnH2EVLEvcb0RFi9/EETZGAJA1daqV+puXAA/HFdo3kYO9q2El7gfFjjWxyGmyg
         CW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717520425; x=1718125225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZR9T3dKRqYP06jWojlNU1wVp16lfFgNyl8ujlT0RpX0=;
        b=Af2IJstzRrTeqNSrRZSQe7p2snvBDEpcn9pk0pQrs0qxFV2sJilOjApufuTQI65iLG
         QEqCopxgQ7rxlSj36hGEyjgcE7XOuM85nD9XWDKBTtDi5vIAT8Pp623iViaVyZuDP/tm
         fPcEzOBpzRfXevZpsBLGe9J1tp/JJtwtbfb1tSJRgBV1URxQQxuXXbBZ4zRocvRv0giS
         A+NqGdi3E//sB+9zc7KhCEFfLJi6ih76K2T4gom5CyNy5JJSCSDWjNN32qmIdQpt5R1s
         LTfn+lQSZ1fN1DqUnBbx9KNXQAqBiraUgBkH45JngX8X/8aT+3BeaaHilu+SeW9FYuV7
         TQ2A==
X-Forwarded-Encrypted: i=1; AJvYcCXOcA2D98isQmrrYX11Pg3JUp5NtAPYyzpU4Q9Gw23XeLQvIDRX6vZ1J8rNCJHNISqyyoDNOS08hzz2QWskMSqcx/XlvNvdYrUoNKkN5pbLUIemef2IlROvjDMJWNCfVtLEM2OjGCnLvJL3T0wC0YwnCr76khVjuq/DoZIJj/nyK26kSi6w
X-Gm-Message-State: AOJu0Yx5INjdscMp4mVUIL9XC0LhYxUpBG7+76UV7Go+XVSVgfe3AT/I
	184jaiyyrYLwJK8Cdp3GzlfalhvWFYMCyZsagTVaqB3Y6uaRcYw5ilVoGg==
X-Google-Smtp-Source: AGHT+IECGnrJz+lHNeazQFroOOf78DG4jbV7qhbn+pyynIKPXjh92hcGDJj8fIT9I24ffjZTEDy6mQ==
X-Received: by 2002:a05:6a00:23c6:b0:6e7:117:c5d5 with SMTP id d2e1a72fcca58-703e5a24a28mr32213b3a.23.1717520425178;
        Tue, 04 Jun 2024 10:00:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242ae89b0sm7274059b3a.101.2024.06.04.10.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 10:00:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 4 Jun 2024 10:00:23 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] hwmon: g672: add support for g761
Message-ID: <fd3d9a6d-03fd-4f95-83ce-c79cac7cedc8@roeck-us.net>
References: <20240604164348.542-1-ansuelsmth@gmail.com>
 <20240604164348.542-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604164348.542-3-ansuelsmth@gmail.com>

On Tue, Jun 04, 2024 at 06:43:43PM +0200, Christian Marangi wrote:
> Add support for g761 PWM Fan Controller.
> 
> The g761 is a copy of the g763 with the only difference of supporting
> and internal clock. The internal clock is used if no clocks property is
> defined in device node and in such case the required bit is enabled and
> clock handling is skipped.
> 
> The internal clock oscillator runs at 31KHz.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Applied.

Could you possibly send me a register dump ?
I would like to add the chip to my module tests.

Thanks,
Guenter

