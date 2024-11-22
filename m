Return-Path: <linux-kernel+bounces-418775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE709D658C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF430B216EA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E031818BC0D;
	Fri, 22 Nov 2024 22:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKtxD7Uj"
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB56812E4A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313345; cv=none; b=EtXn3AfY789drdyRso2p6f7J3IDFGcoiXvOu7aaW5u+CYJhMfefieIxPCGhGGzgE91mvDPJBaiN//bnli0heZKEQETto3CUfDrED8hVqtYtqIHEnnInKxNOK8UgWA0M4eCiqnNQdLr+Pn3FDC/USI17SDai6mCmXw4NR5KmfxJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313345; c=relaxed/simple;
	bh=jf0oq2r/V+Sxr8mnSqnPa38uOXm85TXfL9nmSBNUrEw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hxC+HWO2ydbrSRlAlmUcR9T5wVbvus+feazi9BLjCgETBYEq1oY+PcWlX5LCUuKWVGdWh6EZgM//SpT42LIg6YQZA/X37brsyu+DBBZvbHL8HzraTjs9sM62kVpgJRprekoZvnqGW9Vh3oyo53p9XtrXbi6aYrlysey7IYf/luk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKtxD7Uj; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2128383b86eso25542385ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732313343; x=1732918143; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jf0oq2r/V+Sxr8mnSqnPa38uOXm85TXfL9nmSBNUrEw=;
        b=JKtxD7UjF0ys37TKJYpcUilOGMSTNdwXkKAv8e/PinF+XkCl5KH4fZZqvEXFF4ZhKd
         ptGtZc1ovHlflN/WJnIjuryOXkYNgLhYXXxI3hRibIB8EBM4NWoBt1TjT5PZWgXpkfdK
         +nGfkRLkeVGI6HXj2p+Uj1690Ig7e/MxFlHW1xV2jVM+6qVt4fseixljSIBCcqRiSvkZ
         R/lvEhKHWjf6Nfft1NacF8lHHX921X0gkg6UNagqUaGvS0Koq+F2Wg8NtQErNPC24qzg
         5RMHExxdCppjpNxXhnrwAC2y8Am4INp7NVAXDO/oJy9jR0lwsqlenCrw9ep3S0B3bHQA
         VPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732313343; x=1732918143;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jf0oq2r/V+Sxr8mnSqnPa38uOXm85TXfL9nmSBNUrEw=;
        b=u2vZ3BB+SsCa/mogtrqg+ORRzIHQpEwdd5FA+N0a6vW5RPUS2iIdWDpbVuWzCPv2If
         2aSTMjDs8rKLhRB0Gls9agCeXopiYUyIkjbSNwh1dCyFYPrv8GW5Jd7VCve3LQTWvU7v
         6zZOM2usC6qXMQjMPnx4YE2nlGto8fiJbSlFMNJS1WK1g2MbpyebgDWUtfPhcrPsmpkc
         EHAEXnET7FCBdy+He96iL1IOyTsm5Ctzmmtd8jLwJ3vaygmuE1Aw71AI57oVMw9TfRFH
         h3CObJEKrpyyvxbKZlJca7ZWuwYFJ9rmeJRF7QK3dM+p3Xdvt6C+QVe4jJtXBN5JxTRo
         EA6g==
X-Gm-Message-State: AOJu0YzOzRj59gwr6yqPoogbev5mTpBnRN3yVSSm8roK4D9YF1sAkW4m
	y8FcPAjNCpe0JiYwx6UZeK2524uLpeuxA+dQvufXM6uQX4RzSFl2fZbSuVeGwleDE1x6fofYTB+
	VfeoZ9i/LQBsZFUlHI95Xt/uvz7Y=
X-Gm-Gg: ASbGnctQEDJ1b75UWoq6D6YeUijg8ndmy/bHSZI4V5VfmBQMc/75pzdqk77peoSkrtK
	ST7/60zNIFhqT/FZZMKsrw9MoMlbOBC3i
X-Google-Smtp-Source: AGHT+IFS9AMJYYd/EBLyTmIlb0CM51c795mkEhuuvpyb3Ym9+fkH4nPbWwk8O3cYJQ9fvlkJFURxkMnkr4qND3T0Edg=
X-Received: by 2002:a17:903:230e:b0:212:3f13:d4d5 with SMTP id
 d9443c01a7336-2129fd22060mr55563945ad.27.1732313343142; Fri, 22 Nov 2024
 14:09:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zichen Xie <zichenxie0106@gmail.com>
Date: Fri, 22 Nov 2024 16:08:53 -0600
Message-ID: <CANdh5G6cyMoSjujJcGgJ0G4FrHBBc6uvHr13D09P7c-oODTf5w@mail.gmail.com>
Subject: Question about a problem caused by copy_from_sockptr() in get_ext_report()
To: bp@alien8.de, thomas.lendacky@amd.com, nikunj@amd.com, 
	u.kleine-koenig@pengutronix.de, sathyanarayanan.kuppuswamy@linux.intel.com, 
	michael.roth@amd.com
Cc: linux-kernel@vger.kernel.org, Chenyuan Yang <chenyuan0y@gmail.com>, 
	Zijie Zhao <zzjas98@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Dear developers,

I'm curious about whether the function `get_ext_report` might have a
security issue.

The function is
https://elixir.bootlin.com/linux/v6.12/source/drivers/virt/coco/sev-guest/sev-guest.c#L577,
and the relevant code is:
```
if (copy_from_sockptr(report_req, io->req_data, sizeof(*report_req)))
return -EFAULT;
```

Here copy_from_sockptr() is called without checking the length of
io->req_data. If the remaining length of io->req_data is less than
sizeof(*report_req), the copy should be illegal.
So, I think a prehand check could be useful.

Please kindly correct me if I missed any key information. Looking
forward to your response!

Best,
Zichen

