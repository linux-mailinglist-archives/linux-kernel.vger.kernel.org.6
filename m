Return-Path: <linux-kernel+bounces-426204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B34CE9DF03F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 12:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7565D162D67
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 11:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDF414A630;
	Sat, 30 Nov 2024 11:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lIb8eqCT"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD2D14A4FB
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732967157; cv=none; b=gLfTvTVTTC9pu5pFOVBxA+QLDP0KSmhgSSxhiKmFKgaJCC2rHnfvH/Pd+SvVcza/Upz5b2LacQa1bYWavuvZysRdjw6ovALMqf0SCULHrmGRYXwqLH6V+PqPOGCmHm0oJAwBvXB4BO8ezcbuAsFlTE2vhRNpZX8uH125QWOGL6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732967157; c=relaxed/simple;
	bh=r1e0yUCyDDwKPlm63GtdgkD7CHFhpuCqZeRfGb0SRpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeRvND98MU1hml5v0KWy+yfU6zOKMTNwCGGwbSV3f6hxFPZfAHGRElcCS9ENEzsAyWG7XYt9F9w8YIybplP6cuxLWH03mEomz80MRVPT57l1d6qpyhz3yMnTo9ebDajgrBufqz0lR3vkfTwp50C54Sv2hg5qJO/X+zZoRbbVItA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lIb8eqCT; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e56750bb0dso1940961a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 03:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732967155; x=1733571955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SZLt8uumTsVK4PRtt2vPFNMECzkd5X7pvdUrrrYwcuk=;
        b=lIb8eqCTB/teUES3ilAePby0+wZ5lipqBQsr5ydfF4sU2VLfZfLSYnpldF61qz1duX
         IiNpI+799ApHZPB0Fp4vFOMuHioeT/hTDiaDgeN7gWbCgKmRws2PMmxTnSaI0a7kK6ug
         AmX1pv1gH8QgTA+OErVhuJeok8V8X4V6cs1fI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732967155; x=1733571955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZLt8uumTsVK4PRtt2vPFNMECzkd5X7pvdUrrrYwcuk=;
        b=cuj3nAXw90aNB5cSXpcOI7tC4iAT0yEPxJQlWqFdQSz4cJKQ8fD7F4uYMOVbnT8NLa
         dxEGmWrXeiwNqq/ymmjt3UlyZjNsSAvJJTNV8ZxP+z+GaeqAzVWbXAJ1P773Ffa3mhni
         c+toDhbsFYIYc/f3Kb4r2vRjVWw+W9g9jwXFl+jypX7HbMdZv+OoGmV1vZ82m/QglLnz
         aSk+IHbuNjBnFHG2dqWFEiA1cMEuyP070d99Ib+L1I0Be2uaq9HZsdgGm8dR3+f3Xtc2
         9muKWC2/WKgyeq6s/mrBGguWokdMV/PDSdfpk0sEB2VkE7UxCEo5/YYHl/bTA3YXhrNw
         yx1g==
X-Forwarded-Encrypted: i=1; AJvYcCXFlXqB2hiR95/LSW8ON/4KYtzeBkDHz/zv0EliQJR0qGMtFEPV/wZJjrd7BLMfVGNPWKaYBZxVMJt5fe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeAgFpcu92DCPY5+ly2iymEK3XLMjJRKzumlv/B8R0KgvizMUG
	175EXO/Ll6KN2lKMJmfQaBln24cnldHRWEtW0RXUFJFrHcS2leZkD6kM0Nm42A==
X-Gm-Gg: ASbGnctn07HBqaNlSJDx6v6I1hyfI0+qXHUOHD4MSvYgByKSLms3WaSt/HZYftpVwkn
	EHtZOxKoHSyeOF94BWoDOXT+UZZ6xgIis4SUp8nX9V7gdNRqvVONGZOHKq9mOqIN7VzouSHTyPK
	Ur5hcb9kzImEcDyJTeqJ1grsX4nOwOqAVrObBW2eW8Krtuv1PVrF1Es/gnPpDNXCYeXfIW6fJqR
	mR4tei7xS1Clk8t8aym6v6Kez8wfAnLSit695t/Q4Of9Rvxm7g5Hw==
X-Google-Smtp-Source: AGHT+IHgAsdwCtIGni0kUusDMWjJYG3oPVjW5T6ZOyx1CHulNmaI/ielGsyBmh1jVqjnM8DFAz+dAg==
X-Received: by 2002:a17:90b:3b87:b0:2ea:83a0:4792 with SMTP id 98e67ed59e1d1-2ee097bdd2emr16602262a91.28.1732967155689;
        Sat, 30 Nov 2024 03:45:55 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:18ff:40bf:9e68:65f3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fad03bcsm6794650a91.33.2024.11.30.03.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 03:45:55 -0800 (PST)
Date: Sat, 30 Nov 2024 20:45:49 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: 20241015061522.25288-1-rui.zhang@intel.com,
	Zhang Rui <rui.zhang@intel.com>, hpa@zytor.com,
	peterz@infradead.org, thorsten.blum@toblux.com,
	yuntao.wang@linux.dev, tony.luck@intel.com, len.brown@intel.com,
	srinivas.pandruvada@intel.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rafael.j.wysocki@intel.com,
	x86@kernel.org, linux-pm@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: bisected: [PATCH V4] x86/apic: Always explicitly disarm
 TSC-deadline timer
Message-ID: <20241130114549.GI10431@google.com>
References: <20241128111844.GE10431@google.com>
 <87o71xvuf3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o71xvuf3.ffs@tglx>

On (24/11/30 12:21), Thomas Gleixner wrote:
> > WARNING: vmlinux.o(__ex_table+0x447c): Section mismatch in reference from the (unknown reference) (unknown) to the (unknown reference) .irqentry.text:(unknown)
> > The relocation at __ex_table+0x447c references
> > section ".irqentry.text" which is not in the list of
> > authorized sections.
> >
> > WARNING: vmlinux.o(__ex_table+0x4480): Section mismatch in reference from the (unknown reference) (unknown) to the (unknown reference) .irqentry.text:(unknown)
> > The relocation at __ex_table+0x4480 references
> > section ".irqentry.text" which is not in the list of
> > authorized sections.
> >
> > FATAL: modpost: Section mismatches detected.
> >
> > Specifically because of wrmsrl.
> >
> > I'm aware of the section mismatch errors on linux-5.4 (I know), not
> > aware of any other stable versions (but I haven't checked).  Is this
> > something specific to linux-5.4?
> 
> So it seems the compiler inlines the inner guts of
> sysvec_apic_timer_interrupt() and local_apic_timer_interrupt().
> 
> Can you try the patch below?

That works, as far as I can tell, thank you!

