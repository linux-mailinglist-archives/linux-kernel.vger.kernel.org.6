Return-Path: <linux-kernel+bounces-351432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 444C599111D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 23:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAF26B23059
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 21:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8391ADFFA;
	Fri,  4 Oct 2024 21:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbLtoeMX"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906FF231CA7;
	Fri,  4 Oct 2024 21:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728075925; cv=none; b=bROWWbdfdnL47flHmRRI7Si4bMJUoPoFvCJRoumFpmooaG3GDJh1hHqtmrMTVsO02+EEpGDBzZS/KWDxYpX8qP+yrhIHuvWWoqANvPlmpLeC7Vf6wUiU3mmd4siUlUMpcp8T5CI7kMGJFW81hQac7zZxknTeE9h9G/AMDQ6rvtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728075925; c=relaxed/simple;
	bh=DT2WHnIBh8UMUWoOng5tAC/Wdv+tohTtauqPm8K2F6c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0I1HulJHT2nsUXAxKH7SJxCsA/RmTnZiSWtVKZ8I8ckglWd3wsQVWfSD9i/qIXzSx6WhDI6glcxixChIdOxTCd3XLMCE+cC9UuG0yO+j9UxeE14LCoeBNxu01tFb2tCMH5xvE1C969EHudUdKwVvHNijf36F1I3uBTWcTJ59VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbLtoeMX; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53991d05416so3223659e87.2;
        Fri, 04 Oct 2024 14:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728075922; x=1728680722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZ6LqA6cGFyG3fHM9OBIDfBQ22yTmW/1uiMLfi3g5aM=;
        b=YbLtoeMX0Z5puqh/aQntXY4Yu/Lk1k8VbSS3344xYB6autz6HUCWaCVywXYVwd1+ZT
         dKydcWsf1zTwTcyHDRmio45poIx5rN6AmhgTmOuRJ0t9F/BDHeltQvluMkdezt/NYDlp
         ZssaN92jQ+z+MIg9BKf3enNkPRGTBBGMsyShLX4rxY/dbuE2KgeplZF0fzWC7n8OM0no
         hLUWrHfX5gLSrtFCcbbmNcjBFLW6vIGi8jOeK2qbbZqxQad+ErCISStb+hJW/Pcj1lmc
         KAgPh/YgO0SJXbnO1kRYvZNarh5yB7x8Mksvj4SNU+yNrBs9UDS1V1IksCIdH0CXqAGD
         HfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728075922; x=1728680722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZ6LqA6cGFyG3fHM9OBIDfBQ22yTmW/1uiMLfi3g5aM=;
        b=wgGdn5mJCvgS9OXJCxmNduav86fb0IcLV4+z0wBIgcZcw/456qtiV9jZqgnwlcSSdt
         4MNc7T0rjMvrCplflrdw5pfCDqgr09l6+dXIMip8VNlL88+VqDp2Vh+7spueicp4w9bg
         gJzwba+Qv/Uz3EVWCNLHQNax/25qi0AWTyZAYz/iZzpbtNp7aPnyV/creU9l3+ZoM+gA
         ZhkaeGeNlxgNKOJWfLNjU3PCDlDWTKgstdjoirK8ZHlhmDbc9I/TsvN357lVQCqQD836
         O0bfDun2K87m9MkMlfo7LYRvXybBY5uq0mFI0SUPLqOnQbb7Al1bbyfQF4qoQ+fJPFsV
         boWg==
X-Forwarded-Encrypted: i=1; AJvYcCV/FGpY1n0CKTx3t2bP7mIviA46zzh+lTJts+MFX2KtX6vEWGIpSw9li7gfO6wTrhd/1EZtCwz7x7xmSH0=@vger.kernel.org, AJvYcCXufWjpc1Gky2PWvFyVBHnG4Mk5vmCshoIqy0fN954m+CEcZ9Ze8BlSsy286SuCkCuaW9KB7H+y9bbP@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4IriSfHn8rYWvzTrDaMa+1ScsPXNuTd4cJQSLuxnZK94WKdZU
	nv7JKbcCXKWGpoigFbJO6GjW5UyBjAqtgeRZLmvJk3jwqiyiMF2x
X-Google-Smtp-Source: AGHT+IGht61pFxnnu7WKnwOuvShXWr1PizGfidCqeTA62Nf8gJGyHgNbkD0Z8DrTv5Um0GJWE8+miA==
X-Received: by 2002:a05:6512:3087:b0:539:8f68:e036 with SMTP id 2adb3069b0e04-539ab87df04mr4162722e87.34.1728075921361;
        Fri, 04 Oct 2024 14:05:21 -0700 (PDT)
Received: from foxbook (bfk18.neoplus.adsl.tpnet.pl. [83.28.48.18])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff234edsm57983e87.229.2024.10.04.14.05.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 04 Oct 2024 14:05:20 -0700 (PDT)
Date: Fri, 4 Oct 2024 23:05:16 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Olivier Dautricourt <olivierdautricourt@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, mathias.nyman@intel.com
Subject: Re: [PATCH] usb: xhci: xhci_setup_port_arrays: early -ENODEV if
 maxports is 0.
Message-ID: <20241004230516.5eb3f7a4@foxbook>
In-Reply-To: <ZwA-n56XlNkkLNXM@freebase>
References: <20240930052336.80589-1-olivierdautricourt@gmail.com>
	<20241004125716.75c857ae@foxbook>
	<ZwA-n56XlNkkLNXM@freebase>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> That is correct, the case is handled without panic, but the 0 value
> gets silently propagated until it eventually fails on line 2220:
> 	if (xhci->usb2_rhub.num_ports == 0 && xhci->usb3_rhub.num_ports == 0) {
>              xhci_warn(xhci, "No ports on the roothubs?\n");
>              return -ENODEV;
> 	}
> The benefits are only:
>   - Reporting a more precise issue
>   - Avoids iterating through the capability structures of the
>     controller
>   - failsafe if future changes

Well, simplifying things is not bad in principle, but in this case it
looks like this patch adds a branch and some 50 bytes of code/data for
the sake of optimizing something with no practical relevance (any such
hardware is useless, rejected by this driver, and violates the spec).

So, maybe just not worth the cost, no matter how small ;)

Regards,
Michal

