Return-Path: <linux-kernel+bounces-347449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B39D98D2DF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96B9284C67
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C6B1CF7A8;
	Wed,  2 Oct 2024 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azmg9Dj3"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39731CF7DD;
	Wed,  2 Oct 2024 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727871304; cv=none; b=aX8+v4KCYVyXHKV3yNn1XE+yjtr7MxWg2/I4ts7PbEfuItJTcqnFiTQViErqmVnpMyoC84NVFID6GCxOD/gtOGI6VpNKa6NoiNyC5sTDFHOl9r8La3ZCNdk+lyKhfYqj8vXVum0Jz/Fk1LtvZI3SSpNPd6LwqZbQt4rQ/xKtmPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727871304; c=relaxed/simple;
	bh=BjwaCv7uDDzIkm1TMEXbaGK/xUX4PnAT4wFjUSuexzg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZWpAcw9vBYwyBDxGXihxQLyRMVF/0vtCDOKsaG1f3Av15EMmqcGL71faNyJ4wxP6YkIezsshx3s5WZEBLCXnJPOcnAreebTg2a8l2Nj0nHr7XWIBAhvu6E6Udbapy7oVhXXqbKAFiC0bMyHI03sMB//R+TudpbmhFtx71Rmhdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azmg9Dj3; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53993c115cfso4189224e87.2;
        Wed, 02 Oct 2024 05:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727871301; x=1728476101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjwaCv7uDDzIkm1TMEXbaGK/xUX4PnAT4wFjUSuexzg=;
        b=azmg9Dj350c69nls7eOcKF/B/Lt1//GvSyh0Txpl57u4XnMyYFzNOCO7AeAkuezDt2
         /gQthv+cRSnYVjPmQWNxfWNF8BRiTfODbUX6hTwW00MwgORYskZV1CPHBVxQlJCM0hC9
         a+NcEzyPs0N9icgfwfOmjvdEM/da1loA3gsIEcbYZ0De1Opjvt7rvousVk028h/2+hW+
         pkBqxk97IRt6+3+6WtvE8cCNC2Jzr+Ob6BxIU7e3i6IFFZD9m15bHAlhY0EfVE2CGg2K
         pOgofPat4tjzK1H+a4IdNEC50xkweBBjWWpMkJ7ANjaGEybVNwTMt2UQx76OUWIFQW7i
         1Y2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727871301; x=1728476101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjwaCv7uDDzIkm1TMEXbaGK/xUX4PnAT4wFjUSuexzg=;
        b=EPEne8YZpUv2Wl3ler/IsAvqPHRJWX4LmtQhunTUoKouT1mP9e2O5OPplPX7XBvw8g
         eTK6jpK0e0diQXRCiXbOJPm7XSZnfrLJJIu9ScDaPBMNJUNXt5ascarECEbu16CgZJiz
         hHu0M88nMByGEOXaNeFR/pxX0q2ZM9Z+OsNbm/sPi+B1siISc6uXkapeVKhxQ0yAoq2w
         wmIRwRnZkmXL/coAiZgAJFyjhVAFJfCKs2ZYmO2Qzzl6Xx7kB07gR7RT/u4kS7DBlgn+
         hji8FFbcwYiKIGIpFBzcQ242pG/LxiUxTuMXMjySUquRTzH4Znc/ZNK7VVuq6uySEbt8
         4L/A==
X-Forwarded-Encrypted: i=1; AJvYcCWGDsI/RmrgZIjdVjkps8G55VIIX5wg7kbWJ0qXfXzZwXkkTkzLHXkIwG35zbq4+V4VhV6EmXy/Jo8mQ5E=@vger.kernel.org, AJvYcCXN1L8fmPkHMPh4cI00vI+TviSzHCRGMizxWRPrVPHdXTekYUv4y3a5gLJX5UxMa2p6R/s+UIsf3FU+@vger.kernel.org
X-Gm-Message-State: AOJu0YzzRV2BXTP/hV1WkpzgXP9oY5FIKgnob1Ntct+sODdEV5Qj316a
	EUAp1S1qS7zJ5MT0lwliFw/fe2KMvp2/77HH/vH2PWU9QTUlBLq7
X-Google-Smtp-Source: AGHT+IHL/UELjj8FLpSEoIAjqkOC4UWMNXeDSval1SKifmHeDk8Vb6OZoHsklJziffGBbsCsSsnOsg==
X-Received: by 2002:a05:6512:1052:b0:530:e1ee:d95 with SMTP id 2adb3069b0e04-539a065c60bmr1590688e87.1.1727871300537;
        Wed, 02 Oct 2024 05:15:00 -0700 (PDT)
Received: from foxbook (bfk18.neoplus.adsl.tpnet.pl. [83.28.48.18])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a04398e2sm1922448e87.212.2024.10.02.05.14.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 02 Oct 2024 05:15:00 -0700 (PDT)
Date: Wed, 2 Oct 2024 14:14:54 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: islituo@gmail.com
Cc: baijiaju1990@gmail.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 mathias.nyman@intel.com
Subject: Re: [PATCH] usb: xhci: fix a possible null-pointer dereference in
 xhci_setup_device()
Message-ID: <20241002141454.6efded4e@foxbook>
In-Reply-To: <20241002120439.077afc90@foxbook>
References: <20241001194526.25757-1-islituo@gmail.com>
	<20241002120439.077afc90@foxbook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> By the way, is your analyzer not finding the issue that any call to
> xhci_mem_cleanup() wakes up everybody waiting on the command queue and
> then sets a bunch of things (including xhci->dcbaa) to NULL shortly
> thereafter? This race looks like it shouldn't be harder to detect than
> the things you are doing already.

Actually, I think neither the above nor the issue you reported is a
problem at all, because xhci_setup_device() checks if command->status
is COMP_COMMAND_ABORTED and returns early in this case. At a quick
glance, other command handlers do the same.

This status code is always assigned by xhci_cleanup_command_queue().

Regards,
Michal

