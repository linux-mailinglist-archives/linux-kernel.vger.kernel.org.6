Return-Path: <linux-kernel+bounces-195502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FF58D4DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F571C2370E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F1717C9ED;
	Thu, 30 May 2024 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="pP25FJ/m"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B361417C207
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 14:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717078567; cv=none; b=NQk7G1iuYx9cUOEB/Qn7axCf5DELItKkkuxPNIlV2/lVQMQrkW5Ue3cJmM7b3vvxNnwb3gCxdxfmXPY44YfEg6MyTFh4Ki49ZDCEXcjLsWolR0Ad3Y39BaH+m/D/JuminhHVw6FwYu6MDcXaHkJW9N227R7wbj9y9RIoFbbDgRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717078567; c=relaxed/simple;
	bh=bvIAGvRXMNpdUhPoETcyOi3cHSAfWQnCfagkxpAFajQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Y4NXHeTaVu7rR2f/cYmsXFVkxtM/qU4PANXSPtJw47M2p6gqHLfP4fo6bil/f8/UXRoj95ZbIOSUdwA3ZxGshsVDFu9s4Mx+5lrz6QooYA+O19IA5J6mNxt0EqIqAhpQsUmJC+cgRSkLWZuANFyR74fGU5KmSLUT9NsnroXiHxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=pP25FJ/m; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a62ef52e837so98234366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 07:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1717078564; x=1717683364; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SrOn7yUVC9kN8SKaYqmUwEiVGnDGl9gohY+ONwqgl0=;
        b=pP25FJ/m3PjicCvNhBooY1AcR2dt+/Zffxz3S1fffXNO/L9FVfTLTOrqYMpXmAxAVf
         XXHyRs4pYWBHOfZWTSdPu3hUZ2poHjh8xZqX3A9iC+pUxtMD4XG433fC8OljZWgP+Wd3
         xR4rFbPqjcUL1/Q9gqZCUylShgqkvXQhuTQ//hD9AnoDHvHKV/4GVpGO9XMq/lPVHTki
         YjdyKYmv0GPXDoUhe1wMw1PKDN5vd0zI2kLx6FjwGtzLZAt+yk7DYhRYKajhl1vscXFt
         j+KSonwV+lxCrThrZrkVGG4tGAKQPfsirGROct+jlVibaAu6zuvxPncodZixwdbtiJIy
         2r2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717078564; x=1717683364;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SrOn7yUVC9kN8SKaYqmUwEiVGnDGl9gohY+ONwqgl0=;
        b=XXsdm+AH8cOwA73Pf3N53dZJ34hyKIHAcvDIqAFuBELyB05uHE2jjFqnsnUzsP0jpN
         JcO9zYvxlTJgXq1Oik8C/nCnSug/pRgPzkZ+JDOiegYLlXT4n7VKTtItQ+Ratc5Pmxfi
         B96WrbnHHHFk4edvPeiXdu1NF1qBLzN8PyalTX1wdGv6xgwhrWn8Wl9diybVPDjOEsgC
         HPOhD9nQg3dQOyU13NnxCdEWjZztLv+KmX791lqbHiPN902Hg7wZByk3bPSMXMk9oHwH
         4+etbYAvnY8ntgPfW/zee4MW20jcTkss7aYBqjeXCl9miXYn6dl9Z+8FrDkTdONzcSrr
         1IBw==
X-Forwarded-Encrypted: i=1; AJvYcCVaLUus38V9n/Ba7DvNJXPiwBPFni1ys78Vg4aivgzC0R+C2PR7BNM/9XEFZR4kVWjlZ4x/CFscY+lVoFMznqYHRDgU9mzc8b/iSYA+
X-Gm-Message-State: AOJu0Ywm5wTiU/bjGyfL/RKh21U/W44TpnpWl2Twd2YYpXMrp0rgSRVH
	R9BtTzPL4I4ULBzu6uDkDh/0rIfaXyMDz46I5sz/lE9+HJT+J4VkfC1PAeg+z6o=
X-Google-Smtp-Source: AGHT+IE1Gxt4e7p05tnSjb/uvvdgi7YH2rrBA2tf2xKHkqxV2osqZET9Lhq+RcPBHLK9qZGK1rnznQ==
X-Received: by 2002:a17:906:6d0f:b0:a59:b359:3e14 with SMTP id a640c23a62f3a-a65e8d12314mr168664366b.10.1717078563585;
        Thu, 30 May 2024 07:16:03 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:1083:f101:c1e2:c2f3:b010:383c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a660947c20fsm56515766b.175.2024.05.30.07.16.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2024 07:16:03 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v2] platform/x86/amd/pmf: Use memdup_user()
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <4c2c8a76-17c7-4dbb-96ff-8488c8e953ff@moroto.mountain>
Date: Thu, 30 May 2024 16:15:51 +0200
Cc: markus.elfring@web.de,
 Shyam-sundar.S-k@amd.com,
 hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com,
 kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <1D5BDE66-ABB3-41D9-ACB0-FBAC207D55DC@toblux.com>
References: <50d10f0b-d108-4057-be9c-a90e2398e810@web.de>
 <20240527083628.210491-2-thorsten.blum@toblux.com>
 <4c2c8a76-17c7-4dbb-96ff-8488c8e953ff@moroto.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: Apple Mail (2.3774.600.62)

Hi Dan,

On 27. May 2024, at 12:38, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> Also this check isn't great:
> 
> if (dev->policy_sz < header->length + 512)
> 
> header->length is a u32 that comes from the user, so the addition can
> overflow.  I can't immediately see how to exploit this though since we
> don't seem to use header->length after this (by itself).

How about

	if (header->length > U32_MAX - 512 || dev->policy_sz < header->length + 512)
		return -EINVAL;

to prevent a possible overflow?

header->length is used in the next line

	dev->policy_sz = header->length + 512;

and if the addition overflows, we end up setting dev->policy_sz to an 
invalid value.

Thanks,
Thorsten

