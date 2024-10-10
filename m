Return-Path: <linux-kernel+bounces-358616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8795E99819F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7CBB1C2477D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B5D188CCA;
	Thu, 10 Oct 2024 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pkd5mj41"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC0A8F6A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551405; cv=none; b=j4dtJ5IWZv2fcmrHjKxX0AOglemQJu9wezRGJNZK65rQOBxSyuLk5aEU1As79bvfEQIxKREvmr+usC+tDUVYBi/+uusFfB21GjrZU66Tevj3TAEmzG3CLzWVr9LYXzrgzT6pxYtsUgH2apOJpjrzGO6fROx/+EAwoB1l0QZ5KRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551405; c=relaxed/simple;
	bh=17AwFvAkvJTc4jkkwP9uZww1kD3c4XBeoOsTn5Mu1W4=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=qPVFyLcwPPWtpZlEncUYsjmLaoqe0l08sqIAp0JMSPfWNxDPk/Unz+SdvGgBXY0zzwBD0KSLx5ZqLwu0BnOGNd1edoG0VpegPLmObniqCc69k83lQupxmBuMTKc3hu0sYFZJ5KEvmlY6bNpLVU/CO5Q9PBxl5p7rnLLGAdXxZ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pkd5mj41; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a3a7d5a156so2398665ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 02:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728551403; x=1729156203; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17AwFvAkvJTc4jkkwP9uZww1kD3c4XBeoOsTn5Mu1W4=;
        b=Pkd5mj41OIhW7/aHzef4sfcHIEodrgf7cyjUTL4ycz/ZdCb0J4Pw5l/AV9n4haYypr
         lat37sUa01x7CsAN8axc5QZ9LnXDBZdydRca5tixtJ18lVFTXadZo7MJue+8UX6H+zkX
         G8VQ9aUv53eDX+q5xz2RlTKx70sKASRRVgeNCNrAF4C56GvB+72IE9AorFecI4qh4U+V
         voXfLJWLM54iL+9H5Ncv5mYKbV6/r6xeVTUXD4++rOfyeN1+xcSRTcdhm6Tz0NcXbnnF
         tALsXE1fbjjLKIPXGbsejDxc+v7ZFt/1HQVnSsJyvPn6rlKTRGTHaV4JMUenm04F87PZ
         vuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728551403; x=1729156203;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=17AwFvAkvJTc4jkkwP9uZww1kD3c4XBeoOsTn5Mu1W4=;
        b=kDZnSBkLHCxKzFsSFUrTs9HSgfHionfSnxCkxGHCpsKWVryld+QaCIiHSZaLVbjY9E
         3rJOclFtRTVPHGpEwvia2gbqebAJdyx7rc1nj27KJlm3tp+VDtybQhBgCJuGEv6X/k9S
         Ow5zKRmwX0LDGpHkEuGzL6Bw22j62jc+yLrI64K/wLvdlNkAcERshJ1S3KJHVjs1YAdM
         GtnjTxb+qco9Lz7q3omElKsZnz5nEBSWxBrF64FiZZPpPu2kM9Trgi6AYrzWJlG+nAhO
         cXfHFI3p/gttiJxAnd9WcwvWEV2w0W6ywAW7tCFf9FhsXAS7dSF/bbsXN4bvSZ2Njwf5
         I8MQ==
X-Gm-Message-State: AOJu0YynQS7EJaqGyE2FPvjwmcxSF4hgOZOWJQJ+Ov+dO/NTpREnTprF
	Ir+gv/wXmjZd4TomajbXsIksWqDNCk3JUelGVKcdKA5kXp/LSOqxfjXxsw==
X-Google-Smtp-Source: AGHT+IEYvR/SWTY2ycTkVmcfq8Cgxvg0fFVjprNRsOJue3VsXeHZa28+2MdzUhvbXPV33cGsg5GdmQ==
X-Received: by 2002:a05:6e02:158b:b0:399:4535:b66e with SMTP id e9e14a558f8ab-3a397ce5711mr43787815ab.9.1728551402957;
        Thu, 10 Oct 2024 02:10:02 -0700 (PDT)
Received: from [178.236.246.42] ([178.236.246.42])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3afdbcfe6sm1831615ab.50.2024.10.10.02.10.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2024 02:10:02 -0700 (PDT)
From: Barr John Marsha <johnathonholsingerjf783@gmail.com>
X-Google-Original-From: Barr John Marsha <info@lancastermoveable.com>
Message-ID: <5874850bfdd2face81a0adad16446ee7f5464b50b7c0b9558a711c943fcb2d2b@mx.google.com>
Reply-To: johnmarsha@arnoldporrter.com
To: linux-kernel@vger.kernel.org
Subject: Vendor Invitation
Date: Thu, 10 Oct 2024 11:10:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Attn: Sir,
I am Barrister John marshal (ARNOLD AND PORTER LAW FIrm)

British Petroleum (BP) has invited your company to participate in our 2024/2025 Vendor/Contractor Partnership registration projects.

These projects are open for all companies around the world. If you have intention to participate in the process, please confirm your interest by asking for Vendor Questionnaire and EOI.

Your prompt response would be greatly appreciated as it will help us expedite the vendor/contractor selection process.

We look forward to working with you!

Best Regard,


