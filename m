Return-Path: <linux-kernel+bounces-362632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 643A899B739
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 23:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D705F1F21F5B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 21:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE53189B8F;
	Sat, 12 Oct 2024 21:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nreaCkLH"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE9B1474A2
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 21:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728770321; cv=none; b=C519IyBM+oYHIQmApsUMs/f2C/5nt4//5Pw+T4VDIBVIXW6ZL0SFwB0ENJpNXqWHUUXimSq0VTyMMT60E1Pcd/SbU7Og5NUgwi3kRjUVotLmlsiZ3ABii5N5900u6HKSWELcrb4CWBIeWNwbBgWwXSt9yrZVJJH4xylsDkbUCk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728770321; c=relaxed/simple;
	bh=4p9zMCHyTvIHqWb+RiLLmYJIcUZSBcLyXxn110UCViQ=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=X1h4vapaVqU7oscuYo0Tqp2ns4HwPFgv4wXmkHG4Cj6URyL7fR2XRkwtrdx8y9abOCA/poz6lf/8YQSWmpzMcrAb9Wkh7w9DV0vQQRmbhxSucUYbTmelUU/UtYNUjD1Qz5eYE/VrMnXyUTODnJUwAcK+QIJmCLuHX9JSFSOjKPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nreaCkLH; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-208cf673b8dso33308405ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 14:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728770319; x=1729375119; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4p9zMCHyTvIHqWb+RiLLmYJIcUZSBcLyXxn110UCViQ=;
        b=nreaCkLHKf2ek4Wi40mCwiUYTfoikI1K5VMUTnno8ISv5npzMNS5IsJFmqM4QdOKfF
         XVsq5MExgoREJb5VqJlL/4cGx+gkUWgFh8EnaKDOUQn3uQW/xd0v5qmdkUgM+asM41M/
         XhRZuSRF5WSTxc7Ys1uL6G/ywcrarsdgsT6VLNpIh9Sh5gwhyhyUB+SGxn2SbZdyaXDu
         I1n7Rq93oYj6o3YSg2+h6CMUybz902TWsmrfLSdBz+RbqnWoj35uU07xLsekchAL9zLY
         IUKj3emKImzkiWOGMW4R3jLirCFwvI7L3/tOIUrUz35yfYXgzY7R8PZd8VHdoFn4neYP
         rSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728770319; x=1729375119;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4p9zMCHyTvIHqWb+RiLLmYJIcUZSBcLyXxn110UCViQ=;
        b=ve00J+ZWFgM4a0z5XR7e/J48tCBVOfam3M6hq2bT97VOLY0iHNxs2DLXL91HIb4HaV
         Bv8+HyxgTWHRn6Uq+U2DK7zkSgjhFL4I44/7u6DSTIv+jmNSVxgMn8pCN9cywlsrTmeE
         kn4uqDBSOeiVyeVL1krjgbz+FXpGdGMX9HLYDjyoAe6Sd8YEPtaTsHhZLv38Hblz/3qT
         xU5f401jausRr/QWYVX7VDAtSHhJ36h/IucdhqVL9sE232OgiHhOy6/rLAts9KYjoqKw
         Urck/vE+dRx/C/bxjqyDtTW4//iPCEH468SPDAqOw/BP21YyRViCVjfBD5wQZjgayH3y
         1ngQ==
X-Gm-Message-State: AOJu0Yy3XC3d0gy7et6QQGbrhTTKch72WZP1PtVtGUh24RIfkMKmA+XA
	/fZhu1UwkVDuOwfRCVu7vjOzEwrdoBt4BVj/HIQCujUEPVLQQLRr+nmlpdkq
X-Google-Smtp-Source: AGHT+IFuw3vmlesafU0mXI1A3LYbRJHe//2QC/WViD9FUENMPe6cRQSEGtuijA8FPkWUecZK6dLWog==
X-Received: by 2002:a17:902:e541:b0:20c:d072:c899 with SMTP id d9443c01a7336-20cd072ca01mr24690575ad.24.1728770319133;
        Sat, 12 Oct 2024 14:58:39 -0700 (PDT)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc1a59asm41252865ad.113.2024.10.12.14.58.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Oct 2024 14:58:38 -0700 (PDT)
From: Josey Swihart <nvfdsabdsat432@gmail.com>
X-Google-Original-From: Josey Swihart <joswihart@outlook.com>
Message-ID: <d5d6de0cf4a29308349b434bb837687a4881b978cc86e633dbfd25f9ce8d0de1@mx.google.com>
Reply-To: joswihart@outlook.com
To: linux-kernel@vger.kernel.org
Subject: Yamaha Piano 10/12
Date: Sat, 12 Oct 2024 17:58:36 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,

I?m offering my late husband?s Yamaha piano to anyone who would truly appreciate it. If you or someone you know would be interested in receiving this instrument for free, please don?t hesitate to contact me.

Warm regards,
Josey

