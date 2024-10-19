Return-Path: <linux-kernel+bounces-372992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C06459A5068
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 21:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30889284E8F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 19:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07142190685;
	Sat, 19 Oct 2024 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROZR3hgU"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6D6320E
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729365001; cv=none; b=m1p9mWgCdd74PHr+9WGdGvRwRffV7henMOjlhxp215qYKfmCZR5p4zPP12U6XHnZRVLw5wWWnRBfOptxhxmOcm0IVv4JPBJMbEZjw/gfTMsJSf/UCKu8sVEhDnkGLQTmEJRFoiIy8Ns/32C2E7/w8POgchYx97Fs+I53LX1/D0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729365001; c=relaxed/simple;
	bh=ejHnmaav8X6sc7lPL9ctHCcvGsPSIGdC7FIsmz7rHoQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=pk5sLWaB/LG1HiRt4epoO0F/fd/QL2kJgbM7l99dTCy1p/h1iEO3ujYlL6Iu7QnzrtkSDD6PX6IfXND7C3GaT5VvjXYSOMa5/HXMV2y9/NaoiGo2HzlejANULV9B9Oax4WM9b/VXWq+P+3frE3HtzghDfvdmvChkkn9RSYnssBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROZR3hgU; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2887abeefbdso1638776fac.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 12:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729364998; x=1729969798; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=caP6QQozkZdh1dmKjhDleElX58hylqMyVpFx0NpRri4=;
        b=ROZR3hgUz4nctJ3AGbydn+VtBNm3JflefQ7pis9E4tWQ+LiKcqJIid1Eux8VMTNbnq
         rnu8URJL5ozD7H5IpjXl4SA18XgZH64aScK3mDWZZpfOX9NC1dmBfvnhMOGcXCGE3WbR
         RKJ5QazQXJeXCekK14j5BGDY8FczvsH2zAjIzwnyGEuaL6g+8rleydRFKJsqwjp0LYz2
         LAmS6IJqU/u0xTJ5rE0vSb9qhKeq9VCJ19TNoCLlvRJNTcDPBCmAb7LXGT0SSWb0aKyj
         WsRr+CU8Bp06cBmAZ/yFFbjIhR4shMo3tL0WYVNi3ONTkegODfMHCoJ0cJ3KHLmBjBGF
         i0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729364998; x=1729969798;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=caP6QQozkZdh1dmKjhDleElX58hylqMyVpFx0NpRri4=;
        b=mTND/B5vFGF6waIs3s8oTUSvjHr91RAU6P/Bntl0xxyhRIVeoKEg0l9qNXHRcrLauE
         7+FzChrxYIQtSSNlpApTQgJdueF9ss8A1Lrlc8WN7XrEQPQSjuenNcD42HRIoMPFx6pq
         KtQ51I7igvfwuV7mVQN86ygNYkvKIy8fp4kT5oGfuLveycLyakexmCliWde9LkT1LL2f
         EyxpVg1WjLiZrOSQLXbiH0yHEJqtsW7bECNOqpEG3vfp/Wit540Tpv86Jx/G4GiS/6sY
         EcgaXRMeSFoBITZk2ilkGdUwT/eyub3SC/HBkfFWD0bNYB8Nq/VhI7+ueQuPfV53f4zr
         tJzg==
X-Forwarded-Encrypted: i=1; AJvYcCV7y1gsIhI+Nhip9wMUwD6m/g7rzAfoPMdQd4inbPeU80EviZUv0nWTlyxGNQpsdTIet+ORdJ+Ll9Tzjgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxL24B8kQbCDg0LbhjCDr5SMK4pQd3R6H2NieW2cOh/zxBZyv0
	lRVG/g0IZ9uGDg5MxqraEY4odBhoWi6QThiMOGenEPf47qReWemMIvDAoODsA28kKR1WoaMVawi
	qFkAiNEe4zhPd8j1TIxj9G2c4eFMSsRpi
X-Google-Smtp-Source: AGHT+IEqHdFFFNKO5rKXhi8r0P8K4vNUNFAExAm2Pq1Q/xTJzFUF3JHD0DS0m0I/IE9RJII9aINQqVcVAIhUS6kMb1g=
X-Received: by 2002:a05:6870:71d2:b0:287:29a0:cfe4 with SMTP id
 586e51a60fabf-2892c4f191dmr5198963fac.32.1729364998487; Sat, 19 Oct 2024
 12:09:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Sun, 20 Oct 2024 00:39:47 +0530
Message-ID: <CAHhAz+iHsEaEkhEFNPyiiR-N-eLYYa3dFArO3rLvGdGKnWbm2w@mail.gmail.com>
Subject: Assistance Needed for Kernel mode driver Soft Lockup Issue
To: kernelnewbies <kernelnewbies@kernelnewbies.org>, 
	kernel-hardening-sc.1597159196.oakfigcenbmaokmiekdo-munisekharrms=gmail.com@lists.openwall.com, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Linux Kernel Developers,

I am encountering a soft lockup issue in my system related to the
continuous while loop in the empty_rx_fifo() function. Below is the
relevant code:


#include <linux/io.h> // For readw()

#define FIFO_STATUS 0x0014
#define FIFO_MAN_READ 0x0015
#define RX_FIFO_EMPTY 0x01 // Assuming RX_FIFO_EMPTY is defined as 0x01

static inline uint16_t read16_shifted(void __iomem *addr, u32 offset)
{
    void __iomem *target_addr =3D addr + (offset << 1); // Left shift
the offset by 1 and add to the base address
    uint16_t value =3D readw(target_addr); // Read the 16-bit value from
the calculated address
    return value;
}

void empty_rx_fifo(void __iomem *addr)
{
    while (!(read16_shifted(addr, FIFO_STATUS) & RX_FIFO_EMPTY)) {
        read16_shifted(addr, FIFO_MAN_READ); // Keep reading from the
FIFO until it's empty
    }
}

Explanation:
Function Name: read16_shifted =E2=80=94 The function reads a 16-bit value f=
rom
an offset address with a left shift operation.
Operation: It shifts the offset left by 1 (offset << 1), adds it to
the base address, and reads the value from the new address.
The empty_rx_fifo function is designed to clear out the RX FIFO, but
I've encountered soft lockup issues. Specifically, the system logs
repeated soft lockup messages in the kernel log, with a time gap of
roughly 28 seconds between them (as per the kernel log timestamps).
Here's an example log:

watchdog: BUG: soft lockup - CPU#0 stuck for 23s!

In all cases, the RIP points to:
RIP: 0010:read16_shifted+0x11/0x20


Analysis:
The soft lockup seems to be caused by the continuous while loop in the
empty_rx_fifo() function. The RX FIFO takes a considerable amount of
time to empty, sometimes up to 1000 seconds. As a result, from the
first occurrence of the soft lockup trace, the log repeats
approximately every 28 seconds for the entire 1000 seconds duration.
After 1000 seconds, the system resumes normal operation.

Questions:
1. How should I best handle this kind of issue? Even if the hardware
takes time, I would like advice on the best approach to prevent these
lockups.
2. Do soft lockup issues auto-recover like this? Is this something I
should consider serious, or can it be ignored?

I would appreciate any guidance on how to resolve or mitigate this problem.


--=20
Thanks,
Sekhar

