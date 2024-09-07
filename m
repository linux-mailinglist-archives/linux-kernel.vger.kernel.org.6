Return-Path: <linux-kernel+bounces-319705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EA1970101
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 10:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF5FF284E63
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 08:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87C714B95A;
	Sat,  7 Sep 2024 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fnc7xx1E"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBEB42067
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 08:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725698806; cv=none; b=ddLsXmTmQC7Y+rKUGRXQbyB66kS99LsbMFWlbBFf1fGhvfEmOqZFtCBIsIG939IXnr5hkopmR6ba3l/q5yAjXPyNU1CHA+aiX52kd9Sw4RD9U1eB3GJwbM76RdBnw7ziVdTogeKtsFFVa6SanKcRUE70d7OAfL2Zq7lcl6+xkSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725698806; c=relaxed/simple;
	bh=r3P/alpEUDAFno7LhavVIO6Haae9r6BREv2K8iV+0xI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=KiBVndTQHhE75s/bB815Yrg758/Z+R3K9dYfHkJw02uZ47JKs55RoJp27mMcnSZBulMdicfDoz9mnRZ09wgt5K9tnBq06OddMeUBDg00f5MgqEptHYe6fDb2mB88F11FpT7s0UBXbpQgrFfE4khT1kSb3AR3H9IZZYB+2+KzXos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fnc7xx1E; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-82aa93774ceso22005239f.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 01:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725698804; x=1726303604; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r3P/alpEUDAFno7LhavVIO6Haae9r6BREv2K8iV+0xI=;
        b=Fnc7xx1EMiLIqkrMkdiqtn3/tY8ecTP7nMwnzJ5pPSvy1esnm7Wmi7S36zwsCtC1ZN
         AASjTGFP58UUeL+bKyalIwCFE5cM0ooLozS2X0/SyKUXh+sqtOAEk16Q0DuESbzzBaCk
         EYP4LlJgtiuVZOWUgUOMlZpPfgHvELmuY7PD2Pjm3fl6/qd1WzJeDUUowoS7xLk2VDzI
         uHjxRGxtalGNojA3zjnPgv2jLOEiRSTzwzunXtAE2UGDh62CnxaSBl/4vIZ2F23XWX9A
         GA6rFOroZhNG2WgJR8T2/P9XmiLZFl79iqTD/cd4/TOQ5z1Z/y1VZzTVoIlUPLhkQpTA
         ClsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725698804; x=1726303604;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r3P/alpEUDAFno7LhavVIO6Haae9r6BREv2K8iV+0xI=;
        b=ofAgajERPgL6G+f/kTYUOeENKiQdDNfR++l6mYibjj792tSPOFf5d3JP7ZPp+pNT1b
         XyccHFqNA2Khd9i+0BmuS/9mnylw5FXvFHTN0t2OUPghlZA7QndEl6iqACzTHpl9uN1W
         Bkw2eDeDbSE/lOgL9HbLI4eph/67WaDWL+uk5fD71HMGlyJm74fbVPVXXRpItrf2OTFH
         uk2lmsLpeFaxitEyK45pXNAywCbpOeXSRf7+Z6GMNgIQcJ2358rw9tpwOmnoR8ZBh0Hh
         i7uz06ipDOt3c58kMzG7vFXkyedonqS6YdETvlcu2MT3XoW7nTtjhrvGNTpwHHMDRtpn
         bs/A==
X-Forwarded-Encrypted: i=1; AJvYcCWDj8/7VRRpgpk0uGkUF2QLCDGnEuD+wYZxKE6U6Jx6YFYpjja1zK3/Q5VuqOdBksnUji9bUPiVB5mauo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjG4C2IGNri16V3Skf2KlDr6pYuBwD3tBkRfUXExpJhOn79NZl
	m8TjowuG3c81/6RhAAtzPz/vAg8someNTXBPS4emMO1Ie405c5GM55dILY8LjcbTnXugf+eoIq5
	ZRqOvIV2VJ2Nc4NLTplXJIk5wKLQ=
X-Google-Smtp-Source: AGHT+IG79ei1rgJNObhqWdM9PO7Pez0z1cUi2lL35sijFoungJNzBqqFCLsryWuSSlAYqYj+kRnRNcUMZazaxqcWnHA=
X-Received: by 2002:a05:6e02:1806:b0:39d:2625:b565 with SMTP id
 e9e14a558f8ab-3a0523999aemr43539885ab.19.1725698803965; Sat, 07 Sep 2024
 01:46:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jubilee Young <workingjubilee@gmail.com>
Date: Sat, 7 Sep 2024 01:45:50 -0700
Message-ID: <CAPNHn3rTjMcbNXRpZTBc-zEkmnnMJO2iem9-eUdBkyaquz88rw@mail.gmail.com>
Subject: Re: [PATCH 1/1] ptrace: Get tracer PID without reliance on the proc FS
To: oleg@redhat.com
Cc: akpm@linux-foundation.org, apais@microsoft.com, benhill@microsoft.com, 
	ebiederm@xmission.com, linux-kernel@vger.kernel.org, 
	romank@linux.microsoft.com, ssengar@microsoft.com, sunilmut@microsoft.com, 
	torvalds@linux-foundation.org, vdso@hexbites.dev
Content-Type: text/plain; charset="UTF-8"

> if the process is ptraced, debugger can insert the breakoint into
> please_insert_the_breakpoint_here(). Otherwise breakpoint_if_debugging()
> is a cheap nop.

Generally a programmer wants to put this kind of conditional breakpoint
on an exception path, for which, unless one is working with a language that
abuses exceptions for control flow (which unfortunately describes... many),
the performance isn't of enormous concern. Not that it's free, either, but
opening a file and scanning it is a lot more code than a single call to prctl.

> Perhaps it makes sense to discuss the alternatives? Say, a process can have a
> please_insert_the_breakpoint_here() function implemented in asm which just does
> asm(ret).

There's some merit in having the debuggers recognize this pattern, as that
then would save every language that wants to have this power available
the trouble of reimplementing it. But first debuggers must recognize it,
which would require teaching each of them, which can be... tedious.
Having a function named `fatal` or whatever likewise has this issue.
A toolchain, however, can simply insert a jump to a breakpoint easily,
without having to hold gdb, lldb, cdb, and whatever-other-db's hand.

- Jubilee

