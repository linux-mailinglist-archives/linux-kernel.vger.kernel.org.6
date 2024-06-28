Return-Path: <linux-kernel+bounces-234595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F90E91C864
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B916C1F27246
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1FE7F48A;
	Fri, 28 Jun 2024 21:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IZ1gFDXi"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3338248788
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719611199; cv=none; b=UGmjNTH5q/plVSQnIrC0ovrBGZuh7AYH6iA7W6tuTjHpdq/fd1EccFqbk6wraf5GsyzRf/t2nia9qSwnjUg15Oy3es42rI38N7QmqO8gI7o2KmVK0MVevTgMaLPNlouvKAyjWfyTL10HFPHvjFEm1R6lC6uLhce7dv20XandNm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719611199; c=relaxed/simple;
	bh=3jLwCquKW3GyED/lXgPUxbIyzXjUBfuctfTYO7pqGQg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mYA9MgGsnK4yqZlBprcn/ShQ/TwxI17U41Qyd3xt0BRJ13pDMjGypwH2S+Cayb4ai0KpI0g+UqWT1te4yjDVfJKKacpFN0iUIbb0zOimIM1m99Q0/+DaaVteHukns/Aopg3s+DTNpxu5O8MG0bFxl7cH5sQCNtqo4K4zivog9AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IZ1gFDXi; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f95be3d4c4so565910a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 14:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719611195; x=1720215995; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NPp+ePUGc90IaDta8y4cNAG9IL/0pbWsNrf29+a3X2M=;
        b=IZ1gFDXipk2dWCkM89VBOTyIeZhEIKtgMkzRoTn++f7Dh/TLD3dWJSk5XdUCp5u6Lm
         WvMyCmcW82OGvymRo8AjF6+faHYVaPrQLIabgu+9fJLODDmzTPefJTNIgm7eMkpwc46z
         mjxG1k2/wkiGmuU5zuvoFyymlcEOGTrGx6RAQ5qUIWTb+LIW0zEsPkHPOHEhiLvAPQui
         geKR/jRKEpAb+rVlYSRijihN6lCgoBoYnvStnqYnIGbd1wYtVMKsKt1Xa5XSWkrinHDQ
         mwfPzrLRvAxwCuZmK89RtD692r4/rSwB8TnCAAwCYUN8Qa35b1c1hGOCxcQ+vCtslKO4
         gdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719611195; x=1720215995;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NPp+ePUGc90IaDta8y4cNAG9IL/0pbWsNrf29+a3X2M=;
        b=VY5nDdFdCqgYcWxLP6/sV4RzbtkOWu+kRs7ZFOG4KpJA1Uvqzs/tUAPPZKc/pAirpr
         1zh6cNYC2WXf0gq1jmpVy8duVV2AI088i6t1jfwym+WMEJMCsbEIpnFgIojRgTTUM3WH
         BC1oQeru8bLOkYMXttKd6om24NVQ4sDnOTjmBI15oNVZ2qVZLlPBifcIVSjaTZFcYdZp
         fHVns+NsZr5usHstzJspVxLaiDLruVTS1hTLG8tipDXFUybJ8roQSpEZSzbjaVzHcfB+
         tUsuMusulh1REgzDfPVtfeu8/m7C5KuBwq5aJUTee04EPJQZ5LWwoPav/VMfu1l++XSs
         JxdA==
X-Forwarded-Encrypted: i=1; AJvYcCWtgxs0bUYHVC/f7+K7gy9WB9Osrn0zKxzcLL/p0QtY94DqaX4Sq65Gd5ONeAm9gYF7z/KUTvsh/iBS2nlHPKfM4I/BxfUkRxkXesYZ
X-Gm-Message-State: AOJu0YxaSU7qsKv2MVXG6pJSyukMugcrv0/3kVtVd6LU9rVbSpfVrdjZ
	lBQNe+i104soTGmlQ6X96EdrlvGdx+XoGk9aKbDLorX3O/l1a4lrcuDsN2KiO1TQSu44WUus3+d
	o
X-Google-Smtp-Source: AGHT+IFRuK+Ww/Un/6K1W85JiGOMRpvwKjobJ8PISyNIoNRbGI9W4wLzOAAbtxy/TuxmHO0HRW5uXg==
X-Received: by 2002:a05:6830:1399:b0:6f9:82ca:15b5 with SMTP id 46e09a7af769-700b11e1961mr19903951a34.18.1719611195234;
        Fri, 28 Jun 2024 14:46:35 -0700 (PDT)
Received: from xanadu (modemcable018.15-162-184.mc.videotron.ca. [184.162.15.18])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69309105sm108474085a.125.2024.06.28.14.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 14:46:34 -0700 (PDT)
Date: Fri, 28 Jun 2024 17:46:33 -0400 (EDT)
From: Nicolas Pitre <npitre@baylibre.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mul_u64_u64_div_u64: make it precise always
In-Reply-To: <20240628142025.50ac4c92bfd2034668a0cc22@linux-foundation.org>
Message-ID: <9nr61164-o95o-s47s-33sq-ss86499p6sso@onlyvoer.pbz>
References: <39o9pnn4-p22s-rp4p-067n-83s18o5prnpn@onlyvoer.pbz> <20240628142025.50ac4c92bfd2034668a0cc22@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 28 Jun 2024, Andrew Morton wrote:

> On Fri, 28 Jun 2024 15:06:20 -0400 (EDT) Nicolas Pitre <npitre@baylibre.com> wrote:
> 
> > Library facilities must always return exact results. If the caller may
> > be contented with approximations then it should do the approximation on
> > its own.
> > 
> > In this particular case the comment in the code says "the algorithm
> > ... might lose some precision". Well, if you try it with e.g.:
> > 
> > 	a = 18446462598732840960
> > 	b = 18446462598732840960
> > 	c = 18446462598732840961
> > 
> > then the produced answer is 0 whereas the exact answer should be
> > 18446462598732840959. This is _some_ precision loss indeed!
> > 
> > Let's reimplement this function so it always produces the exact result
> > regardless of its inputs while preserving existing fast paths
> > when possible.
> 
> I assume this was tested with some userspace harness?  It would be
> interesting to see that so that reviewers can see that suitable cases
> have been covered.

I do have a user space test tool but it isn't pretty looking.
How should this be acceptably presented for public consumption?


Nicolas

