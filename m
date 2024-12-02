Return-Path: <linux-kernel+bounces-426902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EDF9DF9F0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 05:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F302819D6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 04:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18AC1F9426;
	Mon,  2 Dec 2024 04:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Krnr484r"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F021F9410
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 04:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733113902; cv=none; b=tKjSUUNiWUQTCd8at8F3EOjTqKW2K5upIL229AxyllbSthoiMkOdPLHroLpx8+hdKdX4995HS8dU9f/yyNcnB+pjTyTun1kODYVEn5IhAQOKmy31A7oYoG4oJB+fVYWhSAynKj6V14Vh0bsaf71fPsUGl6CuTxkjx8Pb3tNqQxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733113902; c=relaxed/simple;
	bh=56Z7vtClXZDAVTMPZo+ONi+IO+6Hj8anC/vgwElyZfA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Ou4wep5Veu43Eq8+K9+/DTlZEp/z0Of/+jt6n+crNTb0bTBzCg9MRHptRpGe3tl/VT+oc5prSNuD8ciFbVSeJbPpCakgdOTBl1o6eJBhWIz4ucWM1cvxSrDjg0MhDE6i9/da0VXpenJBaEz5hgYhCGai6la8DPDlGj7kQS5XDGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Krnr484r; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa520699becso639010966b.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 20:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733113898; x=1733718698; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=56Z7vtClXZDAVTMPZo+ONi+IO+6Hj8anC/vgwElyZfA=;
        b=Krnr484rDhLZGuUjMOzL5zw4AWz0EMgwRva5Y9Dr2NEoYMkH4zofbOJaAXKxhkCVDV
         giL93joj/64Bzkew++RB+WIQdzfOPtrUivDyW0RJakCMwsUIojDMDyNpKuKM/iYGFwP/
         aFf5FWdmYGRAwzJQ4UXL0t/1At3ay151LYAS19D/Tg0mwFNbMURUYJlglGuWORRfNSBq
         6uMWEKPIXaHFnkZPQJp6TEKW8zjVChYtCkBxaLk8V3mrQzPmQxXEGz1rWuxhAg27YyI0
         R99P/hdkjdt6nuWkMQ+PKs674ySOHB6fIXy0EdjTXKnRHTtQOhuwUF2yIZGyvGlxTMi3
         M7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733113898; x=1733718698;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=56Z7vtClXZDAVTMPZo+ONi+IO+6Hj8anC/vgwElyZfA=;
        b=NKqY5Ubjb1I2Sk1ph30YqTN4UZNF9KQq3TocU4acsjhjZ8g8SjJWeL8d01fuFIIPkA
         rNEEKpjxxC4Kya7cMf4WgInPxDV1rtuH7L89sgU8g6fdkUBzDOTKCq4FCOgmJNHdBaVD
         ZxF62Zyd/3nhgFw5UKLERFcdcmYe/obv7NZPqn0KJFQcEeYcGmT1sMrU3E4K/WK95KOu
         whTgbuLuO+3LnSrB/ywL3iuJjrwKm/d+sA7B532+xc8h47xtpIlpzrPSiypnqemad8/g
         2JjQolbQf/pbIQQ0gVksFPyjqO0/on33HPRjTJiZP8UutBoSRU7yDtsPNFp08v7KrxdJ
         EiRA==
X-Gm-Message-State: AOJu0YwkFQ3xmnVWq4jf3ZdTPF1C9r+UADPwSRLpTdL+Sq2xqVuafgTG
	MyQmoeRboeAERSUldwS2U35y3x2kKUeVlzWR0dpPhPipS3cLiiqrqAE6vviUoAV4XKPzd9dxiU7
	Ii7XWmfqtObOpDRlG8ZdaWKA7m2ZnYN7m
X-Gm-Gg: ASbGnct1FBNJkdfuuUsMgwM1pC2mnap2CCFi4ZaMeZqBNlRbg6kD/YIP8e/TiB9tQj1
	PO9WtC1cB1aO3GfuAtV9pXa5kyAqSTiJG
X-Google-Smtp-Source: AGHT+IHQZwzyzfTMVm94uYHjMUn1pLJiEpCjg+qw4iBMedOO5aROvVEi5ipSZGl9VfBmQgt6fjG4sgMZWg9X0PInSLQ=
X-Received: by 2002:a17:907:7703:b0:aa5:39d0:845a with SMTP id
 a640c23a62f3a-aa580f01be6mr2075209466b.15.1733113897965; Sun, 01 Dec 2024
 20:31:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Mon, 2 Dec 2024 12:31:26 +0800
Message-ID: <CAKHoSAsjBpfS5REyfRWJz3GA8PSLnXEE3wi2Dq9oJb-jYLjkUg@mail.gmail.com>
Subject: "BUG: unable to handle kernel paging request in DataTLBError" in
 Linux Kernel Version 2.6.32
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am writing to report a potential vulnerability identified in the
Linux Kernel version 2.6.32, specifically on the PowerPC architecture.
This issue was discovered using our custom vulnerability discovery
tool.

Detailed Report:

fsetxattr$security_ima(r10, &(0x7f0000006f00),
&(0x7f0000006f40)=@ng={0x3, 0x1, "508395"}, 0x5, 0x2)
close(r1)
ioctl$FIONCLEX(0xffffffffffffffff, 0x20006602)
#executor: Prog has number of calls = 30
#invalid syscall number call_num=18446744073709551614
Unable to handle kernel paging request for data at address 0xd64c6b9b
MSR: 00001000 <ME> CR: 82000822 XER: 20000000
TASK = c0591330[-1065942759] '
GPR00: fffedb15 c05cbe10 c0591330 c05935f0 c0591330 00000000 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
NIP [c0000ed8] DataTLBError+0x58/0xa0
Call Trace:
3d60c058 616bd000 7d919aa6 558c0402 7d919ba6 4800000c 7d7342a6 816b0010
Kernel panic - not syncing: Fatal exception in interrupt


Root Cause:

The root cause of this issue lies in an invalid memory access
triggered during the handling of a kernel page fault in the
DataTLBError function, which is responsible for addressing data TLB
misses. The paging request failure occurs at an invalid address
(0xd64c6b9b), likely due to an invalid or corrupted pointer passed to
a system call such as fsetxattr or ioctl. The lack of proper
validation for inputs or kernel state during these operations results
in a fatal exception, causing the kernel to panic while attempting to
handle the interrupt. This indicates a vulnerability in the kernel's
error handling and input sanitization mechanisms for system calls
interacting with low-level memory or TLB management.

Thank you for your time and attention.

Best regards

Wall

