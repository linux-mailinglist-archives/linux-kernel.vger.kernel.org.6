Return-Path: <linux-kernel+bounces-315714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45DA96C61F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D90A81C250CA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C3C1E1330;
	Wed,  4 Sep 2024 18:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoBAW9YT"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0452C84A22;
	Wed,  4 Sep 2024 18:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725473731; cv=none; b=LhFHSiBY31C+gR7JiU5aKcrsog2u4nC42A3H0VND6YG8N+jpFwEVrReYsH6wjfvMOuy4/7BqsdEntS/ZUmRh8fbMZSZ8yDrMxRLX2FT4ltH7uS4wGZy3T2gOv5k7GWOZ5CHfVzeTymxmr7desUbV11IlCtEm3rr7OTmtThZpthY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725473731; c=relaxed/simple;
	bh=50z5k6U+Yaf2Knd3rhnPaInQsmkIRGPLkC9rAHg30DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDK3elX8oJAqh14Hj+Evc9wza55h1x9EHTf+PdRPXpp1oIBLkRIyz6MxNnQMK+xqt/UcH97DHkYLztnhZmAaVt/vGlOUdRFZO3IoeWUXIGkhlpYIKi/UVrEiIDvpZ1I+UXNeS/hhLAoznwk3V9PRUIdgLoxWnt9N9/oc4xFv1lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoBAW9YT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2053f6b8201so36484425ad.2;
        Wed, 04 Sep 2024 11:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725473729; x=1726078529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WwO+mWB5T8nnBU/vhgg8gwpf1IbVYSC47eToIiPUKl0=;
        b=QoBAW9YT0vKEjbsbYH8KQ4Uzz10VU9oJlPQPIBKoV4SbJxWfSiJA6Q0ELC+iPu0T0b
         LaMgr0xMT/FeNO/uX8Jbr3DVUpKIgaBumJy4zZOT0Ft1KqBmzRSByt0wYRV+5men5t+E
         98EgNkXnNaQkU/jW6U/Qvry+7J8EE+ezx3a3oNpKlMU43pS/JCIf4F3om+P7LTywzO8M
         9TKkqOYIhlUrAsatGmmmoM6oJrgRwjtUrVyo4thJYMUWdvlMZrmScy5/jjTuH0s8QX06
         +fJJgMd8RALqNIalCzdgLozWGGidJJTtX5+L84duGuO3tIkapUtdcHp+LLiF/L8QOsvg
         jffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725473729; x=1726078529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwO+mWB5T8nnBU/vhgg8gwpf1IbVYSC47eToIiPUKl0=;
        b=Vkq7kJfQqbQWbBZDm+VXdGtnd4Sq0z8MXVMoME4SNEExSZ/TWQCyefdm1mT8Ugspk9
         NJne/haDb7L4BOE8CBMxKP6KItVTovCOs50FX9vxXr7/JbgRTSpwZAMYxorFitVQk8Aw
         eghori8lWVgifJgd3e7/mbgik+Y5PVLM9PdPkT7T4Fbynq7esLlXGz+WGImi2ja2wTjt
         61dZklwbgWNfjXshAPG4IQoE01lAdqx3J9ad17QihocGam2ZrZssGFlWqUUWNm3iQM3W
         6g43OVcbGWyeqQ0gRwZVTZASi4m84jHkzb6vi3d0IREQhTi5sz/MFjEklLSu9a6Ag5/s
         q55Q==
X-Forwarded-Encrypted: i=1; AJvYcCWit+U/o642HMs9HStoE9hT81WlUj4LqTUCiB+Lo5hYQZTLvxhnqROLUyeUDl1EN+Jlbv3Ds/7a5v3HM08=@vger.kernel.org, AJvYcCXVUrMX4ie2CM+6n6pWIDOctuLq7Ue4PZMhgp9SpUoTOAQ08kQpcvbiD5LzPyTY52edZsC3g74ENxYl+X7Ii7S07h8/ug==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUNwqC3A+5q0MzObtdRDhoYdkf8RAzItq7OoWE0fTyzskGAgV5
	4A1cQqknHp1S022eic3rXEl3MKs2br8xv4r4zeUUbvnEI/fGWRDV
X-Google-Smtp-Source: AGHT+IFkuclXI18u9/kLkb7YSk0EEYX4GvehBs0jB9UiAkmzv7JpCn8tuVhjyVch0/Jcs3TlPTX48w==
X-Received: by 2002:a17:902:f690:b0:206:a239:de67 with SMTP id d9443c01a7336-206a239fb32mr49199275ad.18.1725473728812;
        Wed, 04 Sep 2024 11:15:28 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:13bd:b4e:4c0f:4c37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae90f076sm16487225ad.7.2024.09.04.11.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 11:15:28 -0700 (PDT)
Date: Wed, 4 Sep 2024 11:15:25 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, Mark Gross <mgross@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-geode@lists.infradead.org,
	platform-driver-x86@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/platform/geode: switch GPIO buttons and LEDs to
 software properties
Message-ID: <ZtijvdOiA-RF_2RO@google.com>
References: <ZsV6MNS_tUPPSffJ@google.com>
 <a2366dcc-908e-41e9-875e-529610682dc1@redhat.com>
 <595fe328-b226-4db5-a424-bf07ad1890b4@redhat.com>
 <20240904132104.GDZthewNjCZ4iLgEoD@fat_crate.local>
 <57bbca66-4d84-46c1-a638-1347ee6a222a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57bbca66-4d84-46c1-a638-1347ee6a222a@redhat.com>

On Wed, Sep 04, 2024 at 06:01:30PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 9/4/24 3:21 PM, Borislav Petkov wrote:
> > On Wed, Sep 04, 2024 at 03:02:17PM +0200, Hans de Goede wrote:
> >> Or I can merge it through platform-drivers-x86.git/for-next
> >> with an ack from one of the x86 maintainers.
> > 
> > Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
> 
> 
> Thank you.
> 
> I've applied this patch to my review-hans branch now:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
> 
> Note it will show up in my review-hans branch once I've pushed my
> local branch there, which might take a while.
> 
> Once I've run some tests on this branch the patches there will be
> added to the platform-drivers-x86/for-next branch and eventually
> will be included in the pdx86 pull-request to Linus for the next
> merge-window.

Hans, could you squash the following bit into the original patch please:


diff --git a/arch/x86/platform/geode/geode-common.c b/arch/x86/platform/geode/geode-common.c
index 8f365388cfbb..d35aaf3e76a0 100644
--- a/arch/x86/platform/geode/geode-common.c
+++ b/arch/x86/platform/geode/geode-common.c
@@ -14,7 +14,7 @@
 
 #include "geode-common.h"
 
-const struct software_node geode_gpiochip_node = {
+static const struct software_node geode_gpiochip_node = {
 	.name = "cs5535-gpio",
 };
 

-- 
Dmitry

