Return-Path: <linux-kernel+bounces-206819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B27900E2D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 00:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D14F1F23F9D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3345615572E;
	Fri,  7 Jun 2024 22:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElzCuoM/"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B5F1CAB5;
	Fri,  7 Jun 2024 22:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717800101; cv=none; b=EKcMaonsQziRjnbRs2f91vzjku9eVCY6FN0de74sCacshaQaPvlrJoMBpM2lQAKDZ34uQO03JSepbbkQXmLGK6uYZCnxTJ+ogJnRPjz4khBMF/crj1+lKEI/hHaoqJX9PXrvDHpchpr28B73QW9Fqc+49aqEXdfNfLlkTrB6mVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717800101; c=relaxed/simple;
	bh=+IuQFkkqLSoWNP9W+SV0SqW5zUBggkLlwkd1gyMuErA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tl4dJf/8ocXDGN4r/71zZ5RPmRmK3o2dhtdyFwy57IfQn5Ww3WcJ3+cZCOyTBoen1WluYv4Oi2uLd89j7UgxdkplZuur3gkzSW28v0IQ+x/P4RYmsAd4HHBUg5JtqZqXYFSahj1pdvki6MNuRoSMYMIi1PPeroUnGJzHQ/FLty8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElzCuoM/; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7041b6b7be0so538707b3a.1;
        Fri, 07 Jun 2024 15:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717800099; x=1718404899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4/KdDowqYo96aSv1CYH3iSuRTeh3ItM7eTh0NzlWdFI=;
        b=ElzCuoM/oySPI9B+cpL5q/+8eoCKim4HgbdtvLVyfsC6becRN7EY/NfPsa1yeI9D3I
         GaOn9t8sBGjUMBRcJsDVEeN6oVZxpTWn/cWHWck2NKa9FDp+BTM+FqWMC5tfWFfI9qW+
         mV6EciV17w8mpCRbFMk4EeUY/lyc5H80rkH6KW672JGr8TC4rYpnhUota7wvvMCaWUG8
         b5b4IDJi2gUw9noBA0sOPncnzLL3/8TtgJZF9tlPTd9D8ho8bo7rOFQduqpKZtguS2PD
         TVhKMBxBN23zaV9sY3tfON4hxXRWLJyLJIcN06OVa0G2OiJvGEFo1Qpuf2HZmhCKIM2n
         4VRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717800099; x=1718404899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/KdDowqYo96aSv1CYH3iSuRTeh3ItM7eTh0NzlWdFI=;
        b=uC0tD/+u1R2goNnp8+aZGAauB1KLGPsF49gHrQkie92sLGJ2RI83rRu6TAeJLpf/8o
         +cW97wTwS6B9gevpAySi8ooQMA+3gcqtO+TWD7LxvWXOwRsyznsDBo96jHCq9yS9u8/3
         KFb0j1ajFrGFWsftlZwiHBJ8dHikSjkhrBX45Qz1+AV9oZ+88JAwtpM6n3S0EYLvCpVH
         mmPqotkfptdqWmzR9hg8twyEyodW+8x4b8ni/bgzBgtZ7XWkredb9f4efTVm+WfRY9K7
         itppQ9ckipWadQsrycwI4W+RCUuR7P7pn5EQPVQfZBnANt1we7hshQl4HrTBTujySktA
         k9mw==
X-Forwarded-Encrypted: i=1; AJvYcCVtLepDsU6Y2h6ETZeqGV0AfhGtvNPnYcIRA1xSLKPmlP9AtS3ZSh9JQXqZolun2ADHf9iNZkXL/6jK5okBuM3497U7tua9JOAYV3F7KwdwiFZ5a8wvqvgCEeJfert3ShVsfC/qVliT2sbVzRGBG4VyzOoaV+sszI2eS82dtHv4H6JC2MMQe0Q+RCc=
X-Gm-Message-State: AOJu0Ywzef4AWCKmKR+1wrqIDwLQErLKNtF4hWYi5eDU1FU3FnEllSNE
	fM6ElilWMAnOHvZfBhxigYg8k9vHN/uODVHJwaSI/SStDk/ZsjQn
X-Google-Smtp-Source: AGHT+IFIzlWtLmb3WDjJxsQtiaaET4AU+WeoM3KRDoIHcKGxmDKnUzr+ow5HgXlo1ZLvS5CIQbgBhQ==
X-Received: by 2002:a05:6a20:6a24:b0:1b2:a8e3:4a3f with SMTP id adf61e73a8af0-1b2e6920b70mr5902899637.4.1717800099246;
        Fri, 07 Jun 2024 15:41:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-704197a644csm1090967b3a.46.2024.06.07.15.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 15:41:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 7 Jun 2024 15:41:37 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Luca Tettamanti <kronos.it@gmail.com>, Jean Delvare <jdelvare@suse.com>,
	Marius Zachmann <mail@mariuszachmann.de>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] hwmon: add missing MODULE_DESCRIPTION() macros
Message-ID: <9eb6ecb9-63d1-43c4-80a6-04323040b9bc@roeck-us.net>
References: <20240607-md-drivers-hwmon-v1-1-1ea6d6fe61e3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607-md-drivers-hwmon-v1-1-1ea6d6fe61e3@quicinc.com>

On Fri, Jun 07, 2024 at 03:27:59PM -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwmon/asus_atk0110.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwmon/corsair-cpro.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwmon/mr75203.o
> 
> Add all missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Applied.

Makes me wonder though why that is deemed to be a warning. Module
descriptions used to be optional, and are (or at least used to be)
documented as such.

Ah .. I see .. a recent addition. Oh well, if it makes people happy.

Guenter

