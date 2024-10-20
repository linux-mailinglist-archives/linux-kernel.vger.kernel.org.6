Return-Path: <linux-kernel+bounces-373288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAEE9A54B1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 17:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723861C20C05
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 15:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544F9192D62;
	Sun, 20 Oct 2024 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCb1/pVT"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE53190486
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729436533; cv=none; b=PUeQACeoNqzMkEMhBGNbxhI5E8Rzm+OR/2eJSoDdknvvS+gVPCo1iLFR/FVfAqAFGP1kyz2GwbdL8BGKQn1PbiDYi35rcqRS0/srLvNXWo2/x47b8YyzxYoIYIm6Du7Be2XxtmIW7ZcJqWaH1tHPQjhige6+B3ZJpsdu0k0dcAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729436533; c=relaxed/simple;
	bh=5qMrkDDpSua0WhcHf1ijpX4hIOEwjhMk9PJUalAAY4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GueWNGzTiDzq+IrNXX1+0Rprw04//oMtJBOfqlnEBPEzSR3fjoIcFUlYUz6uFEFkPE1JK3QDNk1jWOMwPzXrZYCNuG0KTNsxKNVIS4lGHqmc5Sk90KW72KP8snpi6KvqNukaKVO930EcMDUzl8nO9tyN/3ed4AlT5erm2l9MQBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCb1/pVT; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2886e2b878dso1402627fac.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 08:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729436530; x=1730041330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xXFdwlBYQ+ays1xI+Fnzrthukdj8RJZfs/DB6QU1No=;
        b=eCb1/pVTABTRGRJFOFTTnON/x9A4VRRnQjrrnwdnlX6P8gLWc+XJNAxTA1NsGllea1
         VTTB83dyyfZBh0liVcqsuq7Gea8g7huCBHlPnPqFgpYQcFX3CTZBWiJMpuG7dNSapjap
         o9dgHsZnkrCzmG2PozbR1V5EQLifYezrZZm1BLuqUE51KGbi2N3jB2K9zHKhhaANBQFk
         keYq+I+va9zyA4/1xhY7c9EqBhNBxj2jPX8dwBu2UJ9OPMp48TRQQyaNwpibpH6DHa4v
         /M1lDMtRqrklB8jg8mjSwQJxwZXDDA/hzHRWV6AaYOI0hKvh73T3Kxo/wAGzFtW4gP9k
         6AtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729436530; x=1730041330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xXFdwlBYQ+ays1xI+Fnzrthukdj8RJZfs/DB6QU1No=;
        b=O/HzZ4C3PhZ1Ke9eT8Zmwip53heKGawp1D4m0cPLGL9LhxtQIHdtsjVbfnbq+tBxb4
         sn6oebZieiyM7Va88Bd1FX2aaGDR6SZXic0JfGT+o/aEI2XJ+cG0PMJXSx1uq8oJc9jn
         JehwMSb/aR0s49iq2rZCrQwHzgW7gdrD1M7qVriMuZgPD6FzPhqwZi7euO+CNL9XJ2fH
         GFRAHO5sjEQNVkyzSXEw1U/CJ4sW6xt5DtB0kvxHO9qGwb8B83RUHlvnY/+SV+ybNadw
         BiSj9Khi8g2R8KVhbzZGQgglCKUUEer+x6kAjDlOjpLZ91MBhkBt/VVFGyDmb43fa9J1
         bLsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXudpc6ETqbWVFJOLQkXFX5qQL5nCGSPneFW1A0vMzk1mX7lloo6jN5NaEPH9AqQ5yrcs7irLOvz2elu2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY4iogrfdXO/KZFfmzS7k5nJqdd2pjWmEzV8ZWsLSC2l57rJbi
	K7VRx2bV+KoWMYX3kQ0ZcKHx3udsmrpFTxq0ZeWwwwaDcadZ6WmKQuZerruImrW3OUg04GJtaFg
	I6dMjDvNzPMS9UKymUpVVrATBaUI=
X-Google-Smtp-Source: AGHT+IEBfFvGPwnQCMiO5KeleU/EUxZJP5+x0Svrv+FbKVA131GEeAFj+VPEQzEPbIZRsdwYcwIFwElD+ByQF+Ou1jE=
X-Received: by 2002:a05:6871:3a0a:b0:278:22d3:53 with SMTP id
 586e51a60fabf-2892c2b3d50mr6907989fac.12.1729436530302; Sun, 20 Oct 2024
 08:02:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHhAz+iHsEaEkhEFNPyiiR-N-eLYYa3dFArO3rLvGdGKnWbm2w@mail.gmail.com>
 <CAHj3AVmiEY+2nPoJqGNzYdvrTnB8rR2QbR8Ejcohziy9VoAjCA@mail.gmail.com>
In-Reply-To: <CAHj3AVmiEY+2nPoJqGNzYdvrTnB8rR2QbR8Ejcohziy9VoAjCA@mail.gmail.com>
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Sun, 20 Oct 2024 20:31:58 +0530
Message-ID: <CAHhAz+huaww0ufRNaAEU6qJi3+zeL7gZD9040F2OA3C=GxjyDg@mail.gmail.com>
Subject: Re: Assistance Needed for Kernel mode driver Soft Lockup Issue
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: kernelnewbies <kernelnewbies@kernelnewbies.org>, 
	"kernel-hardening-sc.1597159196.oakfigcenbmaokmiekdo-munisekharrms=gmail.com@lists.openwall.com" <kernel-hardening-sc.1597159196.oakfigcenbmaokmiekdo-munisekharrms=gmail.com@lists.openwall.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024 at 6:18=E2=80=AFPM Denis Kirjanov <kirjanov@gmail.com>=
 wrote:
>
>
>
> =D1=81=D1=83=D0=B1=D0=B1=D0=BE=D1=82=D0=B0, 19 =D0=BE=D0=BA=D1=82=D1=8F=
=D0=B1=D1=80=D1=8F 2024=E2=80=AF=D0=B3. =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=
=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C Muni Sekhar <munisekharrms@gmail.co=
m> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:
>>
>> Dear Linux Kernel Developers,
>>
>> I am encountering a soft lockup issue in my system related to the
>> continuous while loop in the empty_rx_fifo() function. Below is the
>> relevant code:
>>
>>
>> #include <linux/io.h> // For readw()
>>
>> #define FIFO_STATUS 0x0014
>> #define FIFO_MAN_READ 0x0015
>> #define RX_FIFO_EMPTY 0x01 // Assuming RX_FIFO_EMPTY is defined as 0x01
>>
>> static inline uint16_t read16_shifted(void __iomem *addr, u32 offset)
>> {
>>     void __iomem *target_addr =3D addr + (offset << 1); // Left shift
>> the offset by 1 and add to the base address
>>     uint16_t value =3D readw(target_addr); // Read the 16-bit value from
>> the calculated address
>>     return value;
>> }
>>
>> void empty_rx_fifo(void __iomem *addr)
>> {
>>     while (!(read16_shifted(addr, FIFO_STATUS) & RX_FIFO_EMPTY)) {
>>         read16_shifted(addr, FIFO_MAN_READ); // Keep reading from the
>> FIFO until it's empty
>>     }
>> }
>>
>> Explanation:
>> Function Name: read16_shifted =E2=80=94 The function reads a 16-bit valu=
e from
>> an offset address with a left shift operation.
>> Operation: It shifts the offset left by 1 (offset << 1), adds it to
>> the base address, and reads the value from the new address.
>> The empty_rx_fifo function is designed to clear out the RX FIFO, but
>> I've encountered soft lockup issues. Specifically, the system logs
>> repeated soft lockup messages in the kernel log, with a time gap of
>> roughly 28 seconds between them (as per the kernel log timestamps).
>> Here's an example log:
>>
>> watchdog: BUG: soft lockup - CPU#0 stuck for 23s!
>>
>> In all cases, the RIP points to:
>> RIP: 0010:read16_shifted+0x11/0x20
>>
>>
>> Analysis:
>> The soft lockup seems to be caused by the continuous while loop in the
>> empty_rx_fifo() function. The RX FIFO takes a considerable amount of
>> time to empty, sometimes up to 1000 seconds. As a result, from the
>> first occurrence of the soft lockup trace, the log repeats
>> approximately every 28 seconds for the entire 1000 seconds duration.
>> After 1000 seconds, the system resumes normal operation.
>>
>> Questions:
>> 1. How should I best handle this kind of issue? Even if the hardware
>> takes time, I would like advice on the best approach to prevent these
>> lockups.
>
>
>  I guess that you can switch on interrupt model or run a thread to check =
the status there (here I mean check RX empty and release cpu)
Thanks for your response.

Switching to an interrupt model should resolve it, but unfortunately,
the hardware I am using does not support interrupts for this
functionality.
Would adding udelay() in the while loop after every few iterations
help avoid CPU hogging, allowing other processes to take control of
the CPU?

>
>> 2. Do soft lockup issues auto-recover like this? Is this something I
>> should consider serious, or can it be ignored?
>
>
> The kernel tells you that your cpu resource is stuck instead of doing som=
ething useful
>
>>
>> I would appreciate any guidance on how to resolve or mitigate this probl=
em.
>>
>>
>> --
>> Thanks,
>> Sekhar
>>
>> _______________________________________________
>> Kernelnewbies mailing list
>> Kernelnewbies@kernelnewbies.org
>> https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
>
>
>
> --
> Regards / Mit besten Gr=C3=BC=C3=9Fen,
> Denis
>


--=20
Thanks,
Sekhar

