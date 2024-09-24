Return-Path: <linux-kernel+bounces-336870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC139841ED
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C793A1C22799
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2051215574F;
	Tue, 24 Sep 2024 09:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Sxtk18py"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E43153812
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169666; cv=none; b=lPl3OzabYCt+cJGDZobu+xXJVrMnY2XGV5X544HueYfgDHpqYisExwRV4z48zop2WWwXl0bL4J78FDu1WSCNl8qJUXE81rLClIisDoMZjypGzaW7WKvuUPvAP0ljs6LPeUBdZ3Y3tej3SYi1yy+omVNfM/lhTVDEaLDk9s/EvJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169666; c=relaxed/simple;
	bh=xh7XSoYZ2oivlOmfjdqhw2nRgpePSno/axJ6j2KR6+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nffo+TjPlfpRZFI6s3LZeHa8FP4sSCIHSGUUxWazqHpgd5cqBaVXRPUJNpTU1f8hZ0kFcdb7UtOhgS9R/mkQWqcOGcNlCgH2OB8iMz2xMsugXMq1ayx5HltNnkTrOS4wX48eH+wRdLFfzxIA8ZJChXv6uqhbQ1X40q0aDjBPiMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Sxtk18py; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5365b6bd901so6135851e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 02:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727169663; x=1727774463; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H3qBjPt5bsYI9NwIxfpV0RgfHtSupq4ds9YTWbiy/Rk=;
        b=Sxtk18pyr5bIJt30lq8tNvHnJq1bKhcUK5viTiNm5zQCZhIN32/prdcsYrKpOUNXbd
         me/DlRcS9oHR3A/NYiSoygkKpSRoRsT5LzC64FRdZVawYPJmkiLFdAh39Z8NgCpS/hQQ
         UdWnrfXEOnPmKDdh2zJK6ckZjC3izcTBXLiGrO94iB5rv6EKwoLIMV1CpC3IZTBoa9BH
         nxEt8YtGzntTXZXJwIdMk0k6eLhiSvXcspGiJga48iO7W4Mx0viF1BRnQUSbgXBjRGss
         alkWwrcfuGTWuyNng35/Pd2IV+J3NsUwQjl+abmFupCbBbQnq+thY/swnGW0SjWmZtO+
         NJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727169663; x=1727774463;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H3qBjPt5bsYI9NwIxfpV0RgfHtSupq4ds9YTWbiy/Rk=;
        b=KIHXgW3qnHyU3qg75bI3Xhc1nwsBKSCEc2hlqRNr4Aza87OhG5sX/zG64jbtDBFE2i
         xV8yuG9Oxvn8CIoQWupVyGcZKwjvRx7tkUQTCt7DsPNdpU0DRwXxxERLiGHo7bNglxU/
         s4GF8SOKsWz8gt4pPOBVS5IwXtfS1zKh29cErhw/Ionk2nDiU6SqMVSsdUfF65iBQdFY
         W36JxpFSOyjhw+MJBYHtnUYHEOMxo9CbXLXn/aPEpQvQ1jX+tQGhcMc8RmGdkMgJk/Rv
         9HCv3I/lfS2UnvmKw/U2fS3x9qewQ3DstjIwuVR9oAQYwbaNy2nXf2RuN2J9MtvEfb7N
         D5kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWcmQAzPHX5KA848eDR/9Jk6FdlOGz1hAdDoaVRTJsiaohoypi/Ff1IANwTUTbyyqaITtchWc+7sQyH1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUlCTnPaer4Wj75zLfnxxsC3EOAih6ENB1hV1Tri2EalUfDCCy
	fvUt0RX6Q8g/4dCqZArqx96esmUHGS1vO4AhLUTfUW9ZSlAyYwXq5a/Wm2ehMK4=
X-Google-Smtp-Source: AGHT+IErw3GA+vo1i4xCsMhmniR9BecY9KqTjqUd9o6GiDUh+NRMs6WxCikP47BYxeUa3OG4pELYYw==
X-Received: by 2002:a05:6512:3e04:b0:536:5644:6086 with SMTP id 2adb3069b0e04-536ad3d50bdmr6935585e87.52.1727169662675;
        Tue, 24 Sep 2024 02:21:02 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f4fb94sm61097566b.58.2024.09.24.02.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 02:21:01 -0700 (PDT)
Date: Tue, 24 Sep 2024 11:21:00 +0200
From: Petr Mladek <pmladek@suse.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Michael Vetter <mvetter@suse.com>, linux-kselftest@vger.kernel.org,
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] selftests: livepatch: test livepatching a kprobed
 function
Message-ID: <ZvKEfID8AxzeA7NL@pathway.suse.cz>
References: <20240920115631.54142-1-mvetter@suse.com>
 <5e544e68ad83fcdeb3502f1273f18e3d33dc8804.camel@suse.com>
 <9abe1f61-3379-44b5-8b8a-517c3df34daa@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9abe1f61-3379-44b5-8b8a-517c3df34daa@linuxfoundation.org>

On Mon 2024-09-23 10:16:29, Shuah Khan wrote:
> On 9/23/24 08:45, Marcos Paulo de Souza wrote:
> > On Fri, 2024-09-20 at 13:56 +0200, Michael Vetter wrote:
> > > This patchset adds a test for livepatching a kprobed function.
> > > 
> > > Michael Vetter (3):
> > >    selftests: livepatch: rename KLP_SYSFS_DIR to SYSFS_KLP_DIR
> > >    selftests: livepatch: save and restore kprobe state
> > >    selftests: livepatch: test livepatching a kprobed function
> > > 
> > 
> 
> Assuming this is going through livepatch tree:

Yup, I am going to take it via the livepatch tree.
Though I am going to wait for more potential feedback a week or so.

> Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Thanks for the review.

Best Regards,
Petr

