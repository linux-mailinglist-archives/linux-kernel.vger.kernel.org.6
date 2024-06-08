Return-Path: <linux-kernel+bounces-207213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520C59013E5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 00:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 353FC1C20CF8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 22:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D533A28B;
	Sat,  8 Jun 2024 22:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTTlUfzs"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1B822F17
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 22:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717885689; cv=none; b=MeL4CynjopU86aN5lq+2eYQ1mNAz3Vz0QVh1Iu/ey0+by3tdVwrzmhEUL5SGn2SkKynd3ySaWhuCrz6FzV4M4/VMCqsmdxBLTv5taC5gsPy3y8FL7fjtMTMS6+PmwAE+ifI37NfSMmOqlmbtvrcbdqJRkMapDSCI/lM1cdM7kB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717885689; c=relaxed/simple;
	bh=8nVo7pcYFVIws0R85Xx9ro7lcHjBDrxiOclhZ9piyYo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ADO6byfdUV1MvDNcXwf1FP3co5uvnrUhctDaDNL/x2nXV21nebdg8XQgvjihqqNU0P1xDnElsg9V/EsBGyG7U+5laO9hTHLgxNyxPLyVZemqZFVEIu91hytNDkRreRHYcPB+F/k7+PfJw6uhSAXDC3mZAI0itdFM+qYPPh4IY5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTTlUfzs; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-795413e26deso124120885a.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 15:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717885686; x=1718490486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9dxU23zAUv/XmEP+8t8kKPzDjau4x8q++94k2vNSlM=;
        b=hTTlUfzsUXzET2+qqf5oVMr/n3sTf/bRcTX3K6gVfGSV++s4g+e844ul9U31Ixta24
         qeqihdfLeSyRRAr5cqcJIuD0KarbMEaZniScm4SADEDJyTEmWRedZF6HvlJlsP7oRjk1
         mM6531CRiwiO+/2iIxSLJ6GUBg4ODR4irwIqHIcwKxpZIhzFxmO17n0iKOToZt6FpigK
         8uegrsjgu2u5WysYbPTWH9RbZfMcSRPnB1GBzZHY8uP84dQdoe162gZDZt8VsFyy2cLR
         BwUc/RejV3wF/dwZTJRCquOJVk1FT+xzF5p30ux/IU5YbKp59sa5M+UMAr83EIM7Bk9P
         sFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717885686; x=1718490486;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O9dxU23zAUv/XmEP+8t8kKPzDjau4x8q++94k2vNSlM=;
        b=cwuGehl5kXHDvyVXNXeIMCR10/Rogej3TEGP/epQH5bhvmQORtjqJt3H9SKOps6eOC
         gycci/4+wec/eyyzBVur81yznzM+AlNuW5KDAXy/ZZs50Lh702B/zZWbkCHR+sJvqgs0
         Zfe+y3tefuCRVLl8RDpPFqBL4Fg67lKoyUBSckAlp9wL5htXtF0X6hpmbqwG9+INe5Hg
         ndMqsMWochjzd5XcwSmP0WtVuBQA51KI7ivzmVndipiahwwMCmOpKHpS57VCrmYtH/p3
         u16AF0aAhgegNLljLRb+JJsLbxlunXV3W2UFuDaKPiTDYeffrsGjXfTJLttbD2pU++cA
         7Qdg==
X-Gm-Message-State: AOJu0YwezSZlBIpw8ArdQZUSvd7IHigDh6tS5fomDazNGdu5yQEdMYor
	BH76ZLiP87LlyqDEuhJ7czmDisXtduZosgBAT6DzNO5/xbM3//+r1gmy
X-Google-Smtp-Source: AGHT+IH5buws2EO0WTkdJu2Qp9VkKdYJ0rdwuf4PibfQLLamiJTzDUPyKRXcEbC3KEXeyRqjTYvxqw==
X-Received: by 2002:a05:6214:3a08:b0:6b0:778b:dabe with SMTP id 6a1803df08f44-6b0778bdbe3mr649306d6.11.1717885685995;
        Sat, 08 Jun 2024 15:28:05 -0700 (PDT)
Received: from [120.7.1.23] (198-84-205-203.cpe.teksavvy.com. [198.84.205.203])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b06ae2266bsm10279516d6.3.2024.06.08.15.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jun 2024 15:28:05 -0700 (PDT)
Subject: Re: Linux 6.10-rc2 - massive performance regression
To: Linus Torvalds <torvalds@linux-foundation.org>,
 David Laight <David.Laight@aculab.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wisJ8bS3qe6iBPwL9x=PqJA5oE7tum-E9oZfyPgd2mmrw@mail.gmail.com>
 <46cb50d65e414bfd9bef5549d68ae4ea@AcuMS.aculab.com>
 <CAHk-=wh170Lme6HHSGa5eM6YNcd01vdkOoPenZ0m7P+Yv6_zxg@mail.gmail.com>
 <adbbd899aabf4e6898bbbb04f90b3ede@AcuMS.aculab.com>
 <CAHk-=wjwFGQZcDinK=BkEaA8FSyVg5NaUe0BobxowxeZ5PvetA@mail.gmail.com>
From: Woody Suwalski <terraluna977@gmail.com>
Message-ID: <b6083a4c-44be-c90d-bb41-c48e130503b9@gmail.com>
Date: Sat, 8 Jun 2024 18:28:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 SeaMonkey/2.53.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjwFGQZcDinK=BkEaA8FSyVg5NaUe0BobxowxeZ5PvetA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> On Sat, 8 Jun 2024 at 14:36, David Laight <David.Laight@aculab.com> wrote:
>> I'll try to remember how to bisect through the merge :-)
> git bisect should just do all the work for you. All you need to do is
> give a know good and bad point, and keep testing what git bisect asks
> you to do.
>
>> I've done some tests.
>> I'm seeing a three-fold slow down on:
>> $ i=0; while [ $i -lt 1000000 ]; do i=$((i + 1)); done
>> which goes from 1 second to 3.
>>
>> I can run that with ftrace monitoring scheduler events (and a few
>> other things) and can't spot anywhere the process isn't running
>> for a significant time.
> Sounds like cpu frequency. Almost certainly hw-specific. I went
> through that on my Threadripper in the 6.9 timeframe, but I'm not
> seeing any issues in this current release.
>
> If you bisect it, we have somebody to blame and point fingers at...
>
>                  Linus
>
I have run a quick test on my laptop doing

time (i=0; while [ $i -lt 1000000 ]; do i=$((i+1)); done)

and 6.8.12, 6.9.3 and 6.10-rc2 have identical results...

Woody


