Return-Path: <linux-kernel+bounces-379881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1369AE56E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D8F7B22922
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610A11D63EC;
	Thu, 24 Oct 2024 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="afIAjaWu"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9A71D319B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729774663; cv=none; b=ABu/p2qOoPkdtA3AuZRFcKh0BIhlotD3pJd+WwDTM37XzKHgVUHhf3pjZ8BjktkUDKoeioR29Q9DUcoUDzF/mwX96ZFHvlYBiwDApUWEGCUxtMp9t8YqgPFtgGVMMO11pXsYQbB75eMHcCY5gB+bcwiBICUiwcfKfKKpqBVMWtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729774663; c=relaxed/simple;
	bh=cQyhfsSc+QXVdTgShDspXvyHPJOSEjQo4rAUnpwMl4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0axCDU7bvF5NtG+7hVOrWp6DizIk/lSX85KgjJ9z8vmUdIS1E36Foh8JLC5UwS1At8tJXyYfTEnHd8xHF4Q2ht86WNwwuBghxlr/Zh9+s1OsZyREp89hIZ5zpmWOXLlXF/E5TE7e8xDzkblEbxbjMszmdA3omv3eeKQFxr+lNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=afIAjaWu; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e3d7e6f832so8259557b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 05:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729774660; x=1730379460; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5vBhWSYNa611sIJg62H3My9cs8KLwfQc2KO3oXMo6UY=;
        b=afIAjaWuJq+WJIbHJrPuLP+k5iY2ifSmFdQ2T9uuiPBQVZizsWbxqcjCi0FsTQvhbz
         lQx1cQI2PmgOqeBimgDo1lwm5yedH48bJgwQDrPs6+w0dX2lx39kpjmNccOEVPRUWCRu
         aRcqKPMTWd6OmnP9aEf0BM/aP8pZHwXCGJ743FtJFCUZxmjlLJStMn5JwfEAEj/LKEsc
         QZVLjDDOqZ9+QlZVSxbXgqAAbl6QTQJLpOvcCvyU8gdDS141VgkGvY7evyjRDNtuWXE+
         J5eUgMvu+eATmvhMjXy+sVEPbKdaueitjOvR24WnWGXWHM9q2MmIvBj+CBU7JyYmv02d
         YSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729774660; x=1730379460;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5vBhWSYNa611sIJg62H3My9cs8KLwfQc2KO3oXMo6UY=;
        b=XsYkwouqCAoOteIIo3BeqRkPwrnMhBUAE62Bb/A5Wmb6pR8IjlDMz/b/6QTCICPwYg
         Hgf/Zg9BEmiu10fiQhmVZBCjk3oJ2fFbrbCLmQJmCmFIDR8vH0fZO4QOw1xqbM1RHWyl
         QRr0wkMt4q1WQcyIymdu9M4Mn/LMKlsuW/XfinHQlvwBg+kfHUptoZE1SwfcAOThDAU4
         9z2MZ+ZOMexZ3fKlLCmH2fAjoy4XEOsVkXPJxHRb+BP/GL8V34+8NmW45Yj6MSyXurdv
         CtOXN0M4uZ/Fz+bp6mFkhMnSxGuRzsCIGViykcIW24yVAT7w09+0uOzSjNGx0vWIWOnd
         7CMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxU2AjHPMscuSiN/AKFpXvyrUAlrVkvOC/TZgdNwA3ftMdbTGnsKKGRzeQzXpRyKelpyOHSwTewokA1JY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwx8qi3yj++CxC83EMhk76S435lt+OhKtulJUuAA7rFmnltchB
	rJJXoGTXahrx8DMSHV9hon2QpBzi9PNEX4Jf7ajc+hMy6uE3sUp6Im+Ync/q5QbHcVB4oRhy0Cr
	hZa5HKvmb0VFZPLVX8Fx9elvI8gSoG22LOFTUnA==
X-Google-Smtp-Source: AGHT+IE7NVTYCzyATqQRLTCNICXhJNdunQUxsnGa+DMBXRcbGXUcfSCZyt6G3MVbWQ4oA3XsK/sRUnX0SDF3ytvz/K4=
X-Received: by 2002:a05:690c:39c:b0:6e2:f32:bd2c with SMTP id
 00721157ae682-6e86630c0bcmr17865107b3.29.1729774660388; Thu, 24 Oct 2024
 05:57:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018105333.4569-1-victorshihgli@gmail.com>
In-Reply-To: <20241018105333.4569-1-victorshihgli@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 24 Oct 2024 14:57:04 +0200
Message-ID: <CAPDyKFrgwmPaAnv3CgH=rL9yV4JfbF9mX6nt+Wy=2OUphadZJQ@mail.gmail.com>
Subject: Re: [PATCH V23 00/16] Add support UHS-II for GL9755 and GL9767
To: Victor Shih <victorshihgli@gmail.com>
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	Lucas.Lai@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, dlunev@chromium.org, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Oct 2024 at 12:53, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Summary
> =======
> These patches[1] support UHS-II and fix GL9755 and GL9767
> UHS-II compatibility.
>
> About UHS-II, roughly deal with the following three parts:
> 1) A UHS-II detection and initialization:
> - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
>   Sequence[2]).
> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence
>   [2]).
> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include
>   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
>   Setting Register Setup Sequence.
>
> 2) Send Legacy SD command through SD-TRAN
> - Encapsulated SD packets are defined in SD-TRAN in order to ensure Legacy
>   SD compatibility and preserve Legacy SD infrastructures (Section 7.1.1
>   Packet Types and Format Overview[3]).
> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-II
>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2]).
>
> 3) UHS-II Interrupt
> - Except for UHS-II error interrupts, most interrupts share the original
>   interrupt registers.
>
> Patch structure
> ===============
> patch#1:     for core
> patch#2-#14: for sdhci
> patch#15:    for GL9755
> patch#16:    for GL9767
>
> Tests
> =====
> Ran 'dd' command to evaluate the performance 3 times:
> (SanDisk UHS-II card on GL9755 controller)
>                              Read    Write
> UHS-II disabled (UHS-I): 81.9MB/s 51.4MB/s
> UHS-II enabled         :  206MB/s 80.5MB/s
>                              Read    Write
> UHS-II disabled (UHS-I): 82.3MB/s 49.7MB/s
> UHS-II enabled         :  208MB/s 80.8MB/s
>                              Read    Write
> UHS-II disabled (UHS-I): 82.9MB/s 50.8MB/s
> UHS-II enabled         :  205MB/s 90.0MB/s
> (SanDisk UHS-II card on GL9767 controller)
>                              Read    Write
> UHS-II disabled (UHS-I): 83.5MB/s 50.5MB/s
> UHS-II enabled         :  200MB/s 75.3MB/s
>                              Read    Write
> UHS-II disabled (UHS-I): 85.2MB/s 56.3MB/s
> UHS-II enabled         :  203MB/s 75.8MB/s
>                              Read    Write
> UHS-II disabled (UHS-I): 82.9MB/s 51.1MB/s
> UHS-II enabled         :  196MB/s 77.8MB/s
>
> Test command
> =====
> Read: dd if=/dev/mmcxxx of=/dev/null bs=4096k count=2000 iflag=direct
> Write:dd if=/dev/zero of=/dev/mmcxxx bs=4096k count=2000 oflag=direct
>
> Changes in v23 (October. 18, 2024)
> * Rebase on latest mmc/next.
> * Version 22 patch#1-patch#6 have already been applied to the mmc/next
>   branch, so the patch order for version 23 has been shifted forward.
> * Patch#1: Remove mmc_uhs2_card_prepare_cmd() function.
>            Remove mmc_sd_can_poweroff_notify() function.
>            Modify ios.timing setting in the sd_uhs2_power_off() function.
>            Restore the position of assign the host->card to original
>            position in the sd_uhs2_init_card() function.
>            Remove unnecessary error handle in the sd_uhs2_init_card()
>            function.
>            Add oldcard judgment to skip some programs in the
>            sd_uhs2_legacy_init() function.
>            Remove unnecessary error handle in the sd_uhs2_legacy_init()
>            function.
>            Remove mmc_card_set_present() function in the
>            sd_uhs2_reinit()function.

I have queued this up for next, with a few amendments and added
Adrian's acks to the SDHCI patches.

When applying, I made a couple of cleanups and fixed
sd_uhs2_power_off() to patch 1. I also took care of the checkpatch
warnings for the SDHCI patches.

That said, there are still some issues that remain to be fixed, but
let's do that on top of the $subject series. See below:

*) The error/re-init path of the card is broken, as also pointed out
by Adrian. I will work on this shortly and send patches to fix this
up, please help to review and test.
*) We should read the card's ext registers, to for example enable the
card's internal cache to be used.
*) We should avoid unnecessary commands during re-init of the card, to
decrease latency.
*) During suspend, we should probably send the go-dormant command with
the hibernate bit, rather than just doing a plain power-off.

[...]

Thanks and kind regards
Uffe

