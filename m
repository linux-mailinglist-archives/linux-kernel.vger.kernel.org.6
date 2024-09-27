Return-Path: <linux-kernel+bounces-341903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1522898880E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 17:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1AC81F225B2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 15:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2F71C172A;
	Fri, 27 Sep 2024 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="k3YpYjCH"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB6E18C335
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727450270; cv=none; b=kLajnFxICPzz7+67n9ayfUcBXJg/XvPO9LrGyN0axhf3l6u3ilpWI89/ja8F9fuoiYF44O8zIsq4ieXdddvVTT0ApASeVH+eT4zDWehhqP1vfxKohBv2ulKI158slY1QhIfCWFvtDCOPbFIdeMcxn9Z6xu0Z2lluO/ESNFqPukc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727450270; c=relaxed/simple;
	bh=0VFOiBJqGcZn5JGPIN5XyCsCk6RR00gRMKGJVv/ZX1o=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=uFW4hgVjRARIIQXBbAr37AknmroVVn6/S1P1cVtm+Rns6HbRiVTshd8upXNTYhC8BE+8KX0Xqghoee5X2YhL2VnCmTzrMy1YmfGPi0cm4M6KabPCbaO/9J26MdoY3+M/ZUQz/0nrpH0zPmPbH90bxykw+4dJtE0ksLkrSOQF/+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=k3YpYjCH; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-831e62bfa98so103831139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727450268; x=1728055068; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJAy1insd6dM3jY9CSa90Q6Fky7PdsrvsA2vVjKbRXU=;
        b=k3YpYjCHYVOOt4IFDq8y3OHHQnDRyEHEyqh3eKqw5i1KROcRJ6NGLtGioLuZYc2JOH
         BO+d3EUs+ugbPVjXR9Qi8q681lSiuocSZ2MjUZPRrdMolKxB3uWV95AHyQw1JrSUAId+
         hgaT1POQZ7MJL41z9i3tk9+tdcxWMjxYu3/H84P/awRHFok8764IYSQuMAhasOkDv6ox
         Y/h3Pskeu/T35extFm5Uqn+6GWfmWlYAUWcfjj/6FoG+JejmbL5uuYp5ij+uNGv07lvj
         orv8ShophlE3zNWZsNZP0s5rk1sft9oALkbO0ND/u+Q7yQicSuePMm3eGUgiOw7YNsUF
         GvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727450268; x=1728055068;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CJAy1insd6dM3jY9CSa90Q6Fky7PdsrvsA2vVjKbRXU=;
        b=NI64s44T9yfcxWaqYi1FiQ+aTRZPYhlj6dCSrBxDWcvx8rAkxqcm6XIVzhdrM5Hwuz
         YTLDUrYEF7YtgAUrXWGzfPXcHJ2fw2VQ2caGWary9o4EFXnXi3yrXuiFr8LoccmqKKMq
         x2bx460QLK95n2hXz/Hlo4x5F+Bokh4Q2W9lz1ft5R/QE90iwXVbPQwIEFNg7rpYGEPW
         GAStu+Zy61Q5WcKoAxSXIuOVqQXuyn0sGisRkG4quFfTdQfFJMOI1MlNFtR4ZmlCDJ6m
         eOr4ORIxy73FU9UCAcSkicukJWGFhP72NY65Oz6jXnmgXKj82wbm3wONxs9LvLo5ktsx
         2lOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEkFu6PxAy9Bh8oq87WfuisoOf6HLM2EfaZDW5g9l7DTBDrmn/Q9aMn5oRQoY9iAniw4Y2VvNjWO5Z1J0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfLgNB1VIIVm6WyBrrABefwapCJztDZqG/b7e8JBNDWhz/83H+
	J1OI8c+TTdmvd0QVB17exZ7EvEd3EQJqt/L7Q34sNAb91cNF6mRhc5M2fk9s+R4=
X-Google-Smtp-Source: AGHT+IGpWtX6DInv1hzBIW7KgqzQVhbP7A+VOVCIXk4NqpeqNQymYxYMNikVNLu3nIAv2mn+06hYYg==
X-Received: by 2002:a05:6602:2b81:b0:832:40d0:902a with SMTP id ca18e2360f4ac-834931de722mr388631239f.6.1727450267841;
        Fri, 27 Sep 2024 08:17:47 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d8888f9d3esm521402173.170.2024.09.27.08.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 08:17:47 -0700 (PDT)
Message-ID: <91194406-3fdf-4e38-9838-d334af538f74@kernel.dk>
Date: Fri, 27 Sep 2024 09:17:46 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: AMD zen microcode updates breaks boot
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Got home from conference travels and updated two test boxes to current
-git (sha 075dbe9f6e3c), both AMD boxes. One of them boots fine, the
other one does not. One is a Dell R7525, cpu:

2 socket AMD EPYC 7763 64-Core Processor

and it boots fine on -git. The other is a Dell R7625, cpu:

2 socket AMD EPYC 9754 128-Core Processor

and that one does not boot. Just get a black screen when the kernel
should load. Because I didn't have much to go on here, I bisected the
issue, and it came up with:

94838d230a6c835ced1bad06b8759e0a5f19c1d3 is the first bad commit
commit 94838d230a6c835ced1bad06b8759e0a5f19c1d3 (HEAD)
Author: Borislav Petkov <bp@alien8.de>
Date:   Thu Jul 25 13:20:37 2024 +0200

    x86/microcode/AMD: Use the family,model,stepping encoded in the patch ID

which seems plausible. And indeed, reverting that commit (and its fixup)
on top of current -git does indeed solve it. Happy to test patches,
unfortunately I don't have much to offer up in terms of oops or whatever
to help diagnose this. In lieu of instant ideas to prevent this issue on
-rc1, perhaps a revert?

-- 
Jens Axboe


