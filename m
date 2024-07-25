Return-Path: <linux-kernel+bounces-262561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1776593C8A0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 21:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 488BB1C20E12
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CD25381E;
	Thu, 25 Jul 2024 19:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="03oi1sol"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AAD23741
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 19:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721934704; cv=none; b=t8ypKQvitr0qkVvgYHJPNpEPYn6yzXoH488oyC4j4EvsEHQAbyYWSpQGq6T8mLC1d3K9dliLk8lGgwf+70vWyoDklbum1Amq2W9NfSwAalLX8ny1trLC0PBOeDSCC2ATIT4M9xxJja0TD7MlN2ZQR+JPoTaAxD6/x2GFiMEqGCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721934704; c=relaxed/simple;
	bh=yVBTPVX3Lp7l8RaImy225IQQYMhdecaQ2QYzAbRxVh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jC326+KiC8V7anyUAZJfaQNGnfhidqnyGZP2OS/t1JWq4ZtYh2kyGfGPSrWF8zx38EddiY4K8F79EObbyFtjfUGc4RQyQ0bxNeRBgtlyjVd1omri11/2AhOsS7CV/D15172MhrXbiQAHZHdxEx9gqHuV8hHd1UnEzu2TySdLY+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=03oi1sol; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so3804a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 12:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721934701; x=1722539501; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yVBTPVX3Lp7l8RaImy225IQQYMhdecaQ2QYzAbRxVh0=;
        b=03oi1solLSm7M4Vvi2WhTlIBJRybKehA+HnMR8oGJpPeyhz7Sd9redANvbrR9prHm1
         9z/9rp7RJGPl+1AQQZ8FnnRwuQc6Mqy6oYhpVktc0JM2uBSMDDDuRFuXIDi5PRkPB0dc
         FsqwiusBKMMDx0/EYIzVjYgrkhwh9IwrYEtJhMHCUhaquuFYuFQdXiGmQHUAM7pOmUvM
         FrIKz6WEfP4I99LkI1GtF5uwcPjkSrhdM5UIH4y/Ioxqh1OYOxotRk6BPUpeQe4C2ab+
         dn8DpXuvo6+UDJNdfjv/AMsNVQLJWEGWykNo9aWAKTdLVZd19aW70dkQFJ2Pe7va/AWk
         OKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721934701; x=1722539501;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yVBTPVX3Lp7l8RaImy225IQQYMhdecaQ2QYzAbRxVh0=;
        b=XcZeXTAu8l7xI4Yi4Y7WcfFzw+CpvhgJKYP6XTIqXSvFtj0g0zLc1BSLoDXuReZwH9
         /OEOII+q53utvvFVoNMxECs7XrSWa4YdwvQvmDtKwCxSHzzZ/KdWFlqMwTmBHzEst3Wy
         +oaRzcTWLuYJ9SdCZxdX5+buL+wmlmVOKNsHXAp031n7DdqUwi5q67hPhkMDqy0em1Qm
         RiricsRKNIdyyPMGDGg3TPEy3t0qAYiUlsOu6RxQZO0a0v48rDYB5OtsiXzhXeSAoVme
         8zaROinHvh/KUQRcelqhNqoU1g1m1fYTW/FhVY60w6avfFkDNK6+xXP9Psw/jaHyI+OJ
         A41A==
X-Forwarded-Encrypted: i=1; AJvYcCUNRd8ArwuzVC/O2b/ob9dMPxshl2rcHKMCoIXAGBMuBZFT2IrVtlzXctw5vn+q99CHiVfuvpxFu8iIOUqVjwFRXpfYAYMw3qBbonBk
X-Gm-Message-State: AOJu0Yxo7rfUUyV4gaJ0M0cZbwdFdAr3pZF3xnggzwOuzlxp/DWCuGP6
	HQEIvF7o7yXZQdWGjmRiPgl2nUDY4RVOs5ajFqpD9+nhWAefRV9Mv9hzqeE6+AeCKn3AQjrhKHX
	wvkRLgeorfvat/6iEWFJ3V+pbra9OrbxYV4u9
X-Google-Smtp-Source: AGHT+IEkP1TAs73/GVZXcs9RX2QfLgqSt1NLQOoJkJYk2T/i8tERi/9BrKyDw68Dq5/fUQZA7zrbrAqrGL+oKomEZww=
X-Received: by 2002:a05:6402:2112:b0:57d:436b:68d6 with SMTP id
 4fb4d7f45d1cf-5aedd10d485mr25013a12.7.1721934700834; Thu, 25 Jul 2024
 12:11:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724201116.2094059-1-jthies@google.com> <20240724201116.2094059-4-jthies@google.com>
 <5eloulbppelko7hwyppq4apkuqowe3yv5bd7rlipispetg6aqj@u3mzwubs6xxf>
In-Reply-To: <5eloulbppelko7hwyppq4apkuqowe3yv5bd7rlipispetg6aqj@u3mzwubs6xxf>
From: Jameson Thies <jthies@google.com>
Date: Thu, 25 Jul 2024 12:11:28 -0700
Message-ID: <CAMFSARc8D2q2YO6-Mz7jDQv15Yc9f5U7eCXaFTPjLJu_UMXwcQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] usb: typec: ucsi: Set sink path based on UCSI
 charge control
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, heikki.krogerus@linux.intel.com, 
	linux-usb@vger.kernel.org, bleung@google.com, abhishekpandit@chromium.org, 
	andersson@kernel.org, fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org, 
	hdegoede@redhat.com, neil.armstrong@linaro.org, rajaram.regupathy@intel.com, 
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dmitry,
thank you for your feedback on this patch. The intention here is to
allow power source selection through the UCSI driver. The existing
typec operation wouldn't work here because setting the power roles
alone won't set the charge source. That's also why there is no
pr_set(TYPEC_SOURCE) call for a negative value. It should disable
charging from that port, but it doesn't need to change the power role.
But I take your point that writing positive/negative values to
charge_control_limit_max is not an intuitive way to enable this
functionality.

Thanks for catching this issues with UCSI version and inconsistencies
between sysfs and system state. I need to revisit the design here.
I'll remove this patch from the V3 series and take another look at how
we could implement power source selection.

Thanks,
Jameson

