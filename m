Return-Path: <linux-kernel+bounces-251877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3D7930AE6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 19:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4C4CB20F7A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 17:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AFC13BC38;
	Sun, 14 Jul 2024 17:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0qUDM4Y"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A57139CFF
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 17:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720976874; cv=none; b=Elc80tBMa2Nyiib/J/PSnHISTF8DOh/urgPEJP7MyVn2VCZ9GGhpQ9L6J9W/45kMRr8CfyQN1F/npZaAvHvk/cIfyUNZBQQ1n/qaOdhVSHru1LGeGoKkGzOSBECbeyJBK8JiVXsEnNH6y+LD84JzHI/B5m6IUXYbH7+S+lFXyNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720976874; c=relaxed/simple;
	bh=AXwykxJmSeZPwLz8eKff2+kJYYr60n7I+z1kenwyqQA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SHMvCwS6QWF1Vg8/hZZePjXxyzoxvXwsITqB26dtIsP68sYrLNVeHpjUXsnNYmEr1qOb9BmxQ+/9BCgDx/izL/Qx9vEEqlVJvbZ4MwXMqvY/3ghMvf0cxodo9QAly40FtAfBySPwQYFcfX3ugdBtgFdmjQisAWHnr4GNZtUN9H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0qUDM4Y; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-661369ff30aso1622137b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 10:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720976871; x=1721581671; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YjXmWYDlRcyjDKSQWc44GXI3jtKTGsTtfolqb8Dz5VU=;
        b=Q0qUDM4Ym+qaA9ousjgPBGMRbVJ1hMp1557QuAaQHf6J2kHLmlmIAHpQfJ1iU4vRKN
         6mru/3/6VvrPLKHzaNnHmF1FPuGVMylzupJcEs78gAfBrX5UtbXt3Cyn8eWJZj6I10Z5
         TblBxe9MEDL5T9i2bykwPuplYsmKW9ibrEj8XD6mPnZsLw6K2VbTRUhe2G4k5vY7Wtd9
         9prVJoDRp2noE0bZKcqkG3fg+BaSpXy4wl5ZQmHFNA8NfwifPs/PejAUwfPColjAO7UP
         dFLgkNhrE3PKNk8/wusCqkK7VBF3o7nJTIzPIXjX11jqHjC6czjsaYofsSVNyteuotHs
         Jrcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720976871; x=1721581671;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YjXmWYDlRcyjDKSQWc44GXI3jtKTGsTtfolqb8Dz5VU=;
        b=gVayt30/GlG4eY1EJqqYObAJbsV4iKUHSj44qmi27GsIQ5964u/eTlTZ9tZEWlatQF
         gNEhRGofampLvfmHnPyclhDqkYVyW9rtLjaYp1ssLE4yi0Qhgyb/hXQwFp4WjT6rynTy
         u6MLWGLXoMO70eexHb6h7ZxoyzP+hb0/1b7imrSgR0UqR9sZKtywj2P50QEftE0BTEty
         dN8gNnCtzIB0mk3A5RpMm+NkoxfZ2Mzz/9Ex9Tfwf8r3XQ7DlI7rnjosa4fZUFtnPjpI
         9KgVUZqfbBYyDaNQaO4XkPnUa5DTiMiNP519E6Sxc3dDIbZeHGdl45R4FRU0cQxEqpes
         01cA==
X-Gm-Message-State: AOJu0Yzw+NVoQ3W3tO2/FcQttVu4dCpgtEkdafLS4l6f6NKPaXnhb2kq
	0cen7v05QUBt52GHmaWbSBs4qbBhJM4rtMSJwPDUZJsUwevZGd0E4IbsBMiad6hCElulxgiqDZg
	Z/Fg6j3iuHBc8U/8+JfHxAlnxyp5V0IlR
X-Google-Smtp-Source: AGHT+IGv/1h5i2TkcHpfrCBIaN0jFaVpHvejrxHpMXDSMK3tuLIpbwm+eUYLaXdpSiTTu8JHh+4CJLAguMPq21QRj2Q=
X-Received: by 2002:a0d:c006:0:b0:65f:8b0d:f113 with SMTP id
 00721157ae682-65f8b0df308mr48977957b3.47.1720976871380; Sun, 14 Jul 2024
 10:07:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?U2hpLVd1LCBMb++8iEdtYWls77yJ?= <shiwulo@gmail.com>
Date: Mon, 15 Jul 2024 01:07:40 +0800
Message-ID: <CAOpXEOwh6r0Fo_5hgXET6gGHTUxTdE1aDkp_K0ga8BwGSDMX+A@mail.gmail.com>
Subject: A new spinlock for multicore (>16) platform
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux Contributors,
I am a Linux enthusiast from Taiwan, and I hope to contribute to the
Linux kernel. We have developed a new spinlock method that has been
validated on AMD 64-core and AMD 32-core processors. Compared to
previous methods, this new method is optimized in the following areas:

Motivation and Approaches:
1. As the number of cores increases, there is a need for more refined
optimization of the data transmission paths between cores.
2. Data transmission usually involves lock-unlock wrapping.
3. Performance improvement can be achieved using a shortest path
approximation algorithm.
   A detailed introduction to this method can be found in the following paper:
https://www.usenix.org/conference/osdi23/presentation/lo

Our laboratory is currently developing a system that can apply the
same optimization strategy to all multi-core processors. Below is our
plan.

The New Method and Its Compatibility with qspinlock:
1. The default algorithm in the Linux kernel remains qspinlock.
2. A new file is created in /proc/routing_path, where a shortest path
can be input, for example:
sudo echo 1,2,3,4,16,17,18,19,5,6,7,8,11,12,13,14 > /proc/routing_path
3. After inputting the shortest path, the kernel switches to using the
RON algorithm.

Expected Outcomes:
According to our measurements on AMD 32-core and AMD 64-core
processors, Google LevelDB can achieve a 3-4% speed improvement.

Comparison with Previous NUMA-aware algorithms:
Compared to NUMA-aware results, since such systems may contain more
than two processors, the communication cost between processors is much
higher than the communication cost between cores (within the same
processor). Our method focuses on multiple cores within a single
processor, making it multicore-aware. If a NUMA-aware algorithm is
used in a multicore environment, it is not as effective as a
multicore-aware algorithm. (Please refer to the paper,
https://www.usenix.org/conference/osdi23/presentation/lo)

Assistance Needed:
I would like to understand if the Linux kernel community is interested
in this new spinlock method. As a teacher, I cannot complete all the
work by myself. Is anyone willing to collaborate with me on this
project?

Sorry to bother you:
I apologize for taking up so much of your time with this letter.
Although I am quite old, this is the first time I feel that my
research results are good enough to contribute to the Linux community.
I have read the relevant documentation, and it made me realize that my
time and abilities are insufficient to write the high-quality code
required by the Linux community. Therefore, I ask for your guidance.

All the best to you all

shiwu

