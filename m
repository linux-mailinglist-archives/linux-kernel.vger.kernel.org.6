Return-Path: <linux-kernel+bounces-426929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E830E9DFA2E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 06:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5804928183A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 05:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233CD1F8EE8;
	Mon,  2 Dec 2024 05:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="iFCLwv+A"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48FB1F8AC5
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 05:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733117348; cv=none; b=VC6CkHwqhXszA713Z/Uo9FFq6eWPJMVqZ1RSUFbUgRB6TroWsO9azkOXe+qy7IzOaNkLKgSR/OLdo52kLQqron6glQKvVrjdh5W4CSuWS/0W4R6NiGc7Xh/m4fnGnQkKxZwKE5XTUOM2TsIJIxZy7yA7/NjxQ1hsUJp4G8czMSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733117348; c=relaxed/simple;
	bh=ri9C4EnczmANi1+uc2hK89jgj7Gq1j5HuZA0DhuKJi0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAici8ocR2dOq+rBI9VML0MDsgMa488QZCDvNxYN3Vu4pPuUK14BCtfIfldOgd8ttpJjAgiZeUj6KETZYjtkvAxTpQCAhGPDdchJCYhFhjOVJlCmXvfl2/ULy+LNGk4byPBGbLB7ULrv/1KBkNTcsHRuYHqv/3sn0OQFuAGn3dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=iFCLwv+A; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7256a7a3d98so700430b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 21:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1733117346; x=1733722146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9/ewA9rLToSfTcc2kOPnMXbBaHZShyChtB5veaHjOQ=;
        b=iFCLwv+AKnUDNS3J8w+2rEuAWActyezl0nMtIXzi8HQPNny0Xo5gxtiNXAHysrC9Fp
         Bq2ZjS1vSCnMh9nDyo6HLr3dTqChTO535s+LLVNpLwgQNrwH883XrU/aHd/CEdofY7SQ
         /pXk/WidFcV/g/gNCaS0iNu3yynAsnYDGUuHptp50b7LNjhllahLApLufpTm1mL9uMm0
         vXUdhuRz41WmzSNMmlUzKa59cT26P0oR+DfGfFFgxjk1VJh/brXLUm3kQRP+5f78MOW6
         DSmp2nelgRBiQlG/iXLgVKfGBveTtiBUrx4sveUQu8c84ouByKqqQyJ53pbLcvfWCAP3
         TpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733117346; x=1733722146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9/ewA9rLToSfTcc2kOPnMXbBaHZShyChtB5veaHjOQ=;
        b=rUQXhdpoSVCemYGqoMg/qDtTeaxaHBoH8GjxMAUqSaK+F+yQNApmr6A34niC6yQM7r
         dhvBXdmMYkvYgAlnwXSNQ0idv5u8TL+Y8HisUrl1rgnEgZX6WfqP8AcZt0EH2usCTPG8
         rDhf4S6kiRJydTedjqzMCu9GY+24y/ML85oyBcx7W2pbLx+mq/3CONB0k1N+jj8WZxMg
         djeSYfaKb8o+8xZAIZ1wtc5yHuAljZQvX+ItmSGRrUPiyDt0PvbJuOuPZKDOQ0wVpEO9
         CXXhTA1GYf3RJWIaMxwdLkHjKaRDualYdqaHRXnbwIt+hpydEz+2R2+16YsPd5q3HGDf
         9u0A==
X-Forwarded-Encrypted: i=1; AJvYcCVT4hOv9UwPt2POUpvQG7YTrMyRa1gF9j8hCHdbbSRo7s1eZuwz8sIJ01QG0cg965+zuBKfv+dz96T0urQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq6mQACD7vEwhzy4icRjL61rHRwkH+9yeNbs9S0cSIlejTzNnd
	UQvyX1uV7XYBHyiA2WcRe87WjE9dCkGnbHYajJaj9SCqRMjiAo31af7ClIAtpUk=
X-Gm-Gg: ASbGnctXaRlktF3XyUpBF1gvutq8QBTq2AFsRP6/Y7/zHnt53VG0e7no2LZgx1fx1dH
	WWjAZQ9QZH64dIx77buMM/86wQiOgE+eUQ0xFfHSiXanVPO7g8gXrqWrmcBLLvosmvp2Ep66Srs
	ABMsOI2z8+hGHXcFOvUPQskPTs58Ruap9BXQPVpVrCPh0DGOZLng2p8U55d60SjWAthiKt01UrV
	XjVouLfryQ6MQ0Hh+HSdWiKVxUyeYo6oflKiZ/oby+dscYeqEvTyblxHyahtx9sNZUHYSOmkTv9
	ZAQeZJeWwbA296WQBJ+Gqi+LUQ0=
X-Google-Smtp-Source: AGHT+IEC4JaQRdvfLHkC6wbFfEV/IytmFEWvvpiTZ3oJ4bzxdYi7wFe/2m384cAlwdJP3cbs+P3KGQ==
X-Received: by 2002:a05:6a00:3cc5:b0:71e:52ec:638d with SMTP id d2e1a72fcca58-72530010f7fmr27740462b3a.10.1733117345894;
        Sun, 01 Dec 2024 21:29:05 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c388ea6sm6945868a12.57.2024.12.01.21.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 21:29:05 -0800 (PST)
Date: Sun, 1 Dec 2024 21:27:47 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: cheung wall <zzqq0103.hey@gmail.com>
Cc: hadi@cyberus.ca, "David S. Miller" <davem@davemloft.net>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: "Bug in qdisc_create" in Linux kernel version 2.6.26
Message-ID: <20241201212747.13b37633@hermes.local>
In-Reply-To: <CAKHoSAtJSK6tYjZ8djK27LVuPvAVC=r+Hziv2oxA7vAYZw+30w@mail.gmail.com>
References: <CAKHoSAtJSK6tYjZ8djK27LVuPvAVC=r+Hziv2oxA7vAYZw+30w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Dec 2024 12:31:00 +0800
cheung wall <zzqq0103.hey@gmail.com> wrote:

> Hello,
> 
> I am writing to report a potential vulnerability identified in the
> Linux Kernel version 2.6.26.
> This issue was discovered using our custom vulnerability discovery
> tool.
> 
> Affected File:
> 
> File: net/sched/sch_dsmark.c
> Function: qdisc_create
> 
> Detailed call trace:

You are testing a kernel that is no longer supported.
The 2.6.26 kernel was end-of-life in November 2008


The dsmark qdisc was removed a year ago in 6.3 kernel.

