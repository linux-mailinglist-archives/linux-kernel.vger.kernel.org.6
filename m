Return-Path: <linux-kernel+bounces-441045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F669EC89E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95001653A1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852CB207A22;
	Wed, 11 Dec 2024 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vymOPRtk"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC501FECB5
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 09:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908500; cv=none; b=ZwtFKBViK38pkmjBYcg1Yu3IWoII3JrdH63LzZl7k8Zfa85+53sEa2NPRYhn8QPyb4isBf/a5AtR8XH2o27g0qvyDxVzneJl5xl4hE8H3r9rQdOrdBPnXP8e1L1fQ4VqlWuubJVZL/FdKkMqnVmCkIpDPawTCJ9K37habfdkcVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908500; c=relaxed/simple;
	bh=JUXrxkRS6ra3CHJ9SyF7bUw/4jbQj+KL0Fb1Fh2MyHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7vxLV0mltNNPxvny4/dKQniRF7oN5nG9yeX/40RLHjlLQbNffaIyKSb0JzlmaSlcwVmCmmsyPt1cl8iRKFI08WVibc2wudjyup0OTFVwPSlr87Hd2cemzz+KzBYi9VpuNwss7wDE31YIx8RqII6MnTi6IVucP3rkGy/Iy/ruiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vymOPRtk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so1645445e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 01:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733908497; x=1734513297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6FDO3wL3i1XscIg74LPG2N/BXo43Ca59PIHDAIDDUjg=;
        b=vymOPRtkPVD6OqtxNN3Zn78DuUPGf0D2EtPIVzre4dUGjBcy72cxW+ZKSHV9Uh8NWy
         L+XdJKYILHL2gZ2nItX9wAJX0DeDjSg1ZjXi777nGzj7YWMBE0jvKlIaUwet6VyZUxtw
         QNxJ0CfcHrvC8MEZ2mGb7sx9ZXQqix2buzRBYdfhLEX76dVWIIzfLU4v0AUXUmFoTTwV
         Dy61krov4I8gSzSXaSKRhFqA9nQLxYbJ1fRWV2TAGqvLm9QDPBXcoOvZE3xC1cgHqhHe
         ub1KvME6gyPg5rEe/pnxTaIFo+JKSEpujW2gEtBYZw7JMYz93jvG+/Hvxdw07gBNpXBi
         Dghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733908497; x=1734513297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FDO3wL3i1XscIg74LPG2N/BXo43Ca59PIHDAIDDUjg=;
        b=gAGNIw97VPmOeqZ2jL/DlXdN3pKCxDE7LPOBLny9EqTnOWzhcQJNbXTccWvKxfxZls
         KzKE/z2ywCdP2KD3xXmLBsg06RtlfPVSe9PXh1tngs5JmswCk3e18/kg4MclNUEaZNtQ
         58/bejH5CdudBTSEs0T1CW6vgQGdEVyut75lFlXtx10CrcVeZCtrVycN78r7hvQfXF+2
         i+w/k1Zp1hBJC3gL87W2L+LINZ1dojiwl4G1g3+vG+SyS6Qwp8HWEFruTASTwm6p2Gbm
         i732gLLAwA4pnLVtJtc8UFyZ5lFLTwvq3zjs10mVqI8HMszDwAdt4UTqq+Q1zBoP3xdT
         hWjQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1l0uA7E2sem/4b1X16LRGX25CwG7/3Elkz8npyYiK5+w2YHdEBqDnemR7x/QYm2a+Wh5vROPqFotVNMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7L3cvbnSAjFjTW8ZiO2vyNzaoSQ4XFNpaA4AmHyG3tgdanear
	ET/HlhQJTNl9b1EXQVPLYmoIOAm/G2T4kSaZe8JNMtU1C7KhCeF4yMqd8QZ5vkU=
X-Gm-Gg: ASbGnctzVxo8peqgdSn6Ui/IU+nBra5TpLnt16d1LGUAoi1MsjtzskFnxzNCBtMBLVx
	ci1TCQN3jEZ33egRIkH0WybZXz2QUNYCIn5e2dmmbCK+bY/UazcNamvhWtg58n8+X1hW/wVAFgw
	/kVkQpXhNUZk1cAXExVW6n+0OGq1Y4KcsjHyeHA8db8OBG6v9J5w05z5/r7335CdUi/WKg6HGzx
	Pe7gJr2W8NfCk8kxSYHqwOcFNR0l3t0bKMtcdf/rpn472uZySS5VpHiWD8=
X-Google-Smtp-Source: AGHT+IHOLK/ljbtyNYazbMd4hvX84Qm4ErHQ/BEuJGZ5dGRRjqOpg37GnjWdhZty1q73L7x1DOcRRA==
X-Received: by 2002:a05:6000:178e:b0:386:3702:d2d8 with SMTP id ffacd0b85a97d-3864ced69c8mr1574947f8f.58.1733908496679;
        Wed, 11 Dec 2024 01:14:56 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782514dd9sm803351f8f.69.2024.12.11.01.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 01:14:56 -0800 (PST)
Date: Wed, 11 Dec 2024 12:14:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v3 7/7] media: ipu-bridge: Remove unneeded conditional
 compilations
Message-ID: <a91a3993-6c81-4abc-8609-8f41804fdf62@stanley.mountain>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-7-00e409c84a6c@chromium.org>
 <20241211091954.42a5c778@foz.lan>
 <Z1lOCGJvgFcqmR3R@kekkonen.localdomain>
 <CANiDSCvPNf2KiEpr6Tboon6bjUxwEkD=+_AQjhiOA7RDTTpnCw@mail.gmail.com>
 <20241211094854.407ddd54@foz.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211094854.407ddd54@foz.lan>

On Wed, Dec 11, 2024 at 09:48:54AM +0100, Mauro Carvalho Chehab wrote:
> Yet, based on the title, enforced by its description:
> 
> 	> One of the quirks that we introduced to build with !ACPI && COMPILE_TEST
> 	> throws the following smatch warning:
> 	> drivers/media/pci/intel/ipu-bridge.c:752 ipu_bridge_ivsc_is_ready() warn: iterator 'i' not incremented
> 
> I don't think it makes sense to c/c stable, as this is just a smatch
> warning, for a configuration that will never be used in production.

Yes.  Plus that check has a lot of false positives if you don't have the cross
function DB enabled.  I thought I had fixed it, but I still need to work on it
more.

regards,
dan carpenter


