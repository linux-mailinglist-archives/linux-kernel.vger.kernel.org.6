Return-Path: <linux-kernel+bounces-294456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B0C958DDA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 20:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15AA6B21AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF881C3797;
	Tue, 20 Aug 2024 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bt4vZ6XA"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B101B86F1
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724177692; cv=none; b=R9CaxaMkmPIbGi86zbBcz1XE9urWYwToWm84JdmPE8YEzi4P/wpOqyYz1jMjPaP2OWJ/IfEwpUWLLux/40eUTe1MI27lwA0LCEX8cpRnr/mmEGXUKoVNXXnbFv8pOIMj08cBAFNwIzLH2Sxktnfn4wPxZDaCL6UacTRbzgPH+D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724177692; c=relaxed/simple;
	bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P5TI6QIt3/Ueos/Y7QTLDq7sJA5gDrUwkK6MS+hTFabsqG/zQGpUL/uM1AZWj3p5fcaCWpcdA5ZCXdSgdhuLO3pRf+4MSZG199tr8OJXFxs5CilznlcnpeT6iZ9HTJHPAGU4iCusMJxPBeZHYETCo8+Vv25wMNfJOVV1RTlzmrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bt4vZ6XA; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-428163f7635so51152135e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 11:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724177689; x=1724782489; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
        b=bt4vZ6XA+jJhcFXCrOrCXm5r52wPMFyclEtqj3BG5+HlCmVixzrK/YJWFlSKGIX9X+
         /8zMFvNEnoCbrQfV7pgUKc1Fa0SfbMLaklOGFfzu+D55LxoP93D9Uc5jPFkiAUd7r3rQ
         dCtoVGiNh3WP1hGdgrp8kFRrJLNgJYEJL2ZYNnli8t2xI1Ww0aYHW7IppFRt/C22TAq8
         XQbIX7meTJm5Yb7kY9QDXq4bmpOL4m2qSLVZ03l/N4Yx+AwV6M9TqWBKu258yQg8Ji1i
         4tuJn5E4/sGgtlgaBnwUy6utL+z5illC67YoFbM7E3k1rJdmRfsxd9Q4GOnjDc7p3Kd0
         +FPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724177689; x=1724782489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
        b=selPMOvOzSduxqElB3rlR2hWIcYf/FtKIM977e7U87aFM6M9cJeaxcG/6u0h1iVzXs
         P1DuBZex7cgyIa9noF9FSVZADcuX0U+c0drghtTEGyTOzwAPGVb6rtYLK8RQGWwPoAo7
         G5DhEiz/Nu3WE83jlNTgKQDBs3Damch2jmZbXeADS4jO+LjUeIAyFNNoIpkpwpxc+2G9
         EHcK3sVgEwwrKYiTfsptY+IHC4AT0OlsHuUgYuYUlvbMh3xbe51RDJ3Vs2QVdX0NpGgO
         pmgPm5NxJ9MCP/6sZpmyo9Uak8kJyMVH2u8nAGrHuxsSpJ4lMe9ipfYnrNT8jpd/yklk
         Qs2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBmROFfF/rg6sDT6LbxelhLilKJh9oTB1nl3fslfh9gh7JwmZ2NyMoX4CwSeH3AF4A7z00ef8sanEkX20rKJx0SOKmDAeD9QucDx8R
X-Gm-Message-State: AOJu0YwoSP7Ohhj6Uz4jllQ87sbpN8wbh0xBHo/BNiLj2A2TgFOB3+jO
	v4wmMLkTwM/wFZmoODGfL0fguYE9gdW5/ydqvuTqeQODzPgn9yvzqAo7CN91HrPLqsOMT3JtADx
	zHcjtSx9Tun2CAy3HpiqEICK/yrBhv29oCpzwlFZEmbval59u3+Wq
X-Google-Smtp-Source: AGHT+IHmbKSFe4B1/1TnoT1W3TvVcJzc2fL1GZV//LexmxlmcbOZiG/FdzVIHlK0+AXA6ItiI5sA+LO8mRK53OYMBOE=
X-Received: by 2002:adf:a2da:0:b0:371:8e8b:39d4 with SMTP id
 ffacd0b85a97d-3719464cd9dmr10782209f8f.28.1724177688981; Tue, 20 Aug 2024
 11:14:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000f7b96e062018c6e3@google.com> <20240820085619.1375963-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240820085619.1375963-1-hsiangkao@linux.alibaba.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Tue, 20 Aug 2024 11:14:37 -0700
Message-ID: <CAB=BE-RDih_Ng0cCCHgmQ8+29yj+kKHZheyoLKEDEnPC=tJjhg@mail.gmail.com>
Subject: Re: [PATCH RESEND] erofs: fix out-of-bound access when
 z_erofs_gbuf_growsize() partially fails
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, 
	syzbot+242ee56aaa9585553766@syzkaller.appspotmail.com, 
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, 
	Chunhai Guo <guochunhai@vivo.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.

