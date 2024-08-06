Return-Path: <linux-kernel+bounces-276737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B549497B9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB09B1F24710
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8939B7346F;
	Tue,  6 Aug 2024 18:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="A3hY3LRn"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FCC8F77
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 18:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722970035; cv=none; b=jsR/xlHoi1v/KScrpdBoIeGeN9AB9qM2rCNqIQnel0THavng3++cwFALRBLxbnK/lBfG2jgQFs19nTNGB0rOfbNPCtNtXufxvGYDW4emiGGy6JAGkLh+TRVUzLq/mdzNFDa7kEkCta+/2B5AOqgNZCaQTN/O0g01X8c6LRFM9M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722970035; c=relaxed/simple;
	bh=zYZ+0OnIejKYMoOB1WVZaKNvgF0bAI3uhOiw1siPpnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhNQQgwB5z12W2cLy7rIIsAiAOi+GTEVWjrJbiLypBPTt3jMEXK7RVcYeFpncQOkEu5m7jbRO8aYtTleG4aomEb8/H7t2XfBmKEosboDEe3BnhCr0LxNGNIAt1m405FG7TwwDdOdVo5KP7f1xgfCxkCjJXI9/8yIyU9ckq+y5l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=A3hY3LRn; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a3b866ebc9so1231967a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 11:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722970030; x=1723574830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6MAznyqpvb8spFxkoKW0gjqJWNHEy/LCmc62o5EfxKk=;
        b=A3hY3LRnJ9oG1/eX3R/3yF0ME3c+b6fsblsnCSRGUEeXngk5vs00wa9f5eDyY68Pp2
         0cJHIOTZUDRESszOFdClYbdEqgkH4LwIMtZujF96t3JkRyvOFm4yDUco8Gq/t9l/qxzD
         WFX8YJdgRxatG8UCMEG0461oSxgtijlse/dLqKdHz1SseXZe2Pn0bL+bg0lkHVEamp4F
         roVEXXwic/GSzkNFW6ku8Ln4Ip26t/6UzIsQgz5FLIKCro6N7H9PXnGCpzAAUe+fyWI5
         YGc1dLWpr9gzNww1uwTcyrLGQluAM+SwVbr3aowPFNOYORjpotdmPEvnBksrIRRU2sSX
         Df0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722970030; x=1723574830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MAznyqpvb8spFxkoKW0gjqJWNHEy/LCmc62o5EfxKk=;
        b=ZNGHr9+APrgk21mveMaUw6GNP2tDGPMTWy6aoLxA60+OU2GASJNBpdg6SFEcgCFF0r
         WKUFrgPExeGzyJu129H1qHdzV8S/2CisMVZ2lhm1z42rxxsDmNoPjNkj5vL31xTp7VBy
         52eVYfInUFo4BvVPn+XySiWpiu7hDzodBMdUV4rCOK/tx3WVG6CBb1HCSQTr0n8IgVzS
         YGYmf0UbvEWt+BkNAV30HgJKaectt3CQ15tnuY7ti8+EmOEnB3lobrQSwB8NnkTluY2V
         Xgno2IDqPgzx70j9mINcmDnFL1PSTJBnUhzF1juXVYp8fBwLm8cWgGHC1IcIGpCi9fmW
         ck9g==
X-Forwarded-Encrypted: i=1; AJvYcCW9WKmo8Dlfek2KUKJ3ajoq9Rgslligydlq7Ky1H3OeMwlCJIBWkEVfu7OlsABRtQ3f7H9YH9Jh6oQo7vVMVw8McRo0vIpzYYF8Kfp9
X-Gm-Message-State: AOJu0YyVazDGPImzA7gF1g21ri/mqudrYCp9R52mhaCTRXH4UtTj4+sZ
	oJJV3Hhz8Ny+7vQI6KOxAcqKTb+UJ35+arKD5VYI3QPjp1EengOzVBl2KZMvBOc=
X-Google-Smtp-Source: AGHT+IG1qfGVbDM/hX3rH5zzwv3xKuLb799kAVcT/8qvdW2M66Ak8RK7dscO8iCSSxuW5OPapbnoZg==
X-Received: by 2002:a17:906:794d:b0:a7d:2429:dc16 with SMTP id a640c23a62f3a-a7dc5107ce6mr1042915066b.65.1722970030427;
        Tue, 06 Aug 2024 11:47:10 -0700 (PDT)
Received: from blmsp ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e80ea8sm572780666b.183.2024.08.06.11.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 11:47:09 -0700 (PDT)
Date: Tue, 6 Aug 2024 20:47:09 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Vibhore Vardhan <vibhore@ti.com>, 
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, 
	Georgi Vlaev <g-vlaev@ti.com>, Akashdeep Kaur <a-kaur@ti.com>
Subject: Re: [PATCH v8 1/3] firmware: ti_sci: Introduce Power Management Ops
Message-ID: <6zk5auljbsjnimtrftr6se2jrhcibidc2oq2qpdc7yncauvui7@peyzkaszsm2c>
References: <20240801195422.2296347-1-msp@baylibre.com>
 <20240801195422.2296347-2-msp@baylibre.com>
 <20240806153912.sqsirnic5eb7witi@unsealed>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240806153912.sqsirnic5eb7witi@unsealed>

Hi Nishanth,

On Tue, Aug 06, 2024 at 10:39:12AM GMT, Nishanth Menon wrote:
> On 21:54-20240801, Markus Schneider-Pargmann wrote:
> > From: Dave Gerlach <d-gerlach@ti.com>
> [...]
> 
> > +	pmops->lpm_wake_reason = ti_sci_msg_cmd_lpm_wake_reason;
> 
> did you miss populating the rest of the pm ops?
> 	See https://lore.kernel.org/all/202408031302.28NpPykP-lkp@intel.com/

No, I didn't miss populating the pmops.

set_latency_constraint() and set_device_constraint() are only added to
pmops once the firmware capabilities are added in the next patch.
set_io_isolation() and prepare_sleep() are not added to pmops as the
usage outside of ti_sci.c is not planned. These are only used for
suspend/resume in the third patch.

I will rearrange the patches and integrate the functions required for
suspend/resume with the suspend/resume patch to avoid any build
warnings.

Best
Markus

> It might be better to introduce the APIs one at a time?
> 
> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

