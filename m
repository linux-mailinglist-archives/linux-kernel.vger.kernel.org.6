Return-Path: <linux-kernel+bounces-407107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 724E79C68F5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6060B251BE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 05:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA5B176233;
	Wed, 13 Nov 2024 05:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nY+eVW0b"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A792309AE;
	Wed, 13 Nov 2024 05:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731477480; cv=none; b=gCLQytd4/tAJ0D/sWj8ebpYuKbROzB3Zb0wil8ucELrEo3Xmhnd+cKVENAZDa3KY1b2t5555hoGU9ZXwCMOtqLCIBVX2GfD4jmW37+0DdjC1F3yA6+mG6Tj3BE0nHrVVAw9JSL6RYqPa7TKwjjXTGtNQksruz5VmFLrDyBNp3h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731477480; c=relaxed/simple;
	bh=eh588OqJAZ11hzfiDHHRrxqtZLDGLQpnHKuyQK8kIXg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ITDFXTcR2FkFYIkV36x/JXv0uwGaXYbVgYPD3EBEvRkWGSFs+4jUOEFpQboVy6PfQB8MIkI+PUwyRy2U2C9ioE2PinTMZjUPUiMt64U8z/uxcon6tlx0/QJ2N2EClDAvrpXfV7oBNr2aocxSFUoIepXf1zO5Q0qlGmtnIRy50Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nY+eVW0b; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e29218d34f8so279112276.1;
        Tue, 12 Nov 2024 21:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731477478; x=1732082278; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eh588OqJAZ11hzfiDHHRrxqtZLDGLQpnHKuyQK8kIXg=;
        b=nY+eVW0boHX6cdVDKA9aMX+9eQLUwnWVdc37jhFgUETHNdKpScXh905JI5BeYTKmd1
         Tfqfsk+XxJoEX18bJRSe7COEBzMBfI14g2b9RWr3VqOgX2Vw/0wgcf+2QpjKHCI808L2
         OFWcRPYr2A3L+Ngf26N0qBK9lZsl1Lkn1eMMTdrV21IPPjqMMbFgX4M0ZtAjrrxT96Ie
         Adn3Bj1dRcd0iuwJb84WDdKDdQneGCkgdRDYCIqqHnT3tFYpHl+tc8Zl3blwRwi5qe9C
         VAdqwteEuq8Ysr8t7D1PhPSqpRrYca6yImTtawOQizGC+K2E7J4A+B8GJd+o+o3Id4OT
         w1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731477478; x=1732082278;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eh588OqJAZ11hzfiDHHRrxqtZLDGLQpnHKuyQK8kIXg=;
        b=D4r9i526OQYyZdbQGe/qnrg3EXBKergWz44MIebMi0AQ7C4iKW7SFh1GvSAAVufhLQ
         n4Ntvu/0UybV91n7XA9izuwg5T0Y3PKDtC6kxqXwmKgpI79GCtc2UsILNr0M3D66KOQe
         fcGsYHbEoit2LTD0/TcnfPbODlELEFhhTEf4N2CMUFf6m9cYW1sml9ZFzRuzpZkajWrS
         f5vCDPnQlTmzL9XFLN35bSmQJw2AkVs1IgBQeXWyZHCt38uK3ghNBYGMfjSJq7DSkt4H
         q6a+vgL/dwXMPLSeUiaTovJF5I/QLa89Ui84zxfeEmLSYPpeKEhjWJCZhVqiVWynfwO0
         oF8A==
X-Forwarded-Encrypted: i=1; AJvYcCX0wFrzKwpQnT8Udu3o8xhSHr2zOnusC7CwQMxXQvXGbWEKE00vprFjcuSO5qJOnmDVcmoZ+olAxrESMGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhpeT/4i5wp7aX5dpoLh4quUtNczsRjhls0LOIkHRldezW6FFa
	oLUJEthflOD/zBTvjwMwnnV0VbaIcNalxhX7vViCY9oTAnNwsVUb2Jtm94gxAvaanCGsGpSPlzw
	xuqsWKsqtjjGYTOmKBd4qVrcAcP/Cpg==
X-Google-Smtp-Source: AGHT+IFiJOjP3oCdvBwWms4ccKi/MaLaMU01hwd4cfMw0NBwKOYaGRjGKo7rXblIW6SwLynbGgTcEct/wGY0HTd1roc=
X-Received: by 2002:a25:8481:0:b0:e29:2988:ecf0 with SMTP id
 3f1490d57ef6-e337e102bdfmr16069231276.10.1731477477981; Tue, 12 Nov 2024
 21:57:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jason fab <siliconfab@gmail.com>
Date: Wed, 13 Nov 2024 11:27:47 +0530
Message-ID: <CAHXL5pfQjhpANBxNY1YjURhWwU17WD9gX4rDqi4ezYOKeFs=gQ@mail.gmail.com>
Subject: VTIO support on USB
To: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I would like to know if the linux kernel usb subsystem supports
Virtualization based Trusted IO Management (USB VTIO)?
If yes, could you please point me to any documentation and steps on
how to enable it?

-Thanks in advance

