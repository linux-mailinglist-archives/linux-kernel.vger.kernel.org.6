Return-Path: <linux-kernel+bounces-252088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF48B930E35
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABFC9281C34
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 06:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2171836D0;
	Mon, 15 Jul 2024 06:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPVHfAxW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1612513BC3D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 06:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721025766; cv=none; b=iUNKck7Rr3TXREYcAUx6+Vu/ZEMfPtuMw4KNCe918uKXLinkKjCAIzzjwIfuPchOS6rlTs70cG1uylSaKx0H+9MXlxh54DwYMrVNRGr8ub9AWAVQ1oJZd2mTUYPleO86Z/wXFbKwkMfQWOwrsclXuP5wCIwbJLLo4n0xBG6FKwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721025766; c=relaxed/simple;
	bh=v8cE6GGeNU+RD+Q2LQy+7INYApFI5BbZGukwj8FEdiw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=D6P7fM01K9VduFO4mdTeXD2XgRUYY5R0ZdpbAfy138zn/pVidl3lWVVW0XQbirh+XaRW/gWzaMf/kqZ4Z91MJDDc5UTIkiek/1Xecn1Emdx8HfrUaRimOQpCLfjGdOhkI/fczypMDZr5rfQwyG7pZIbO3iBXKPKDfvBkGMxiE/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LPVHfAxW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721025763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=v8cE6GGeNU+RD+Q2LQy+7INYApFI5BbZGukwj8FEdiw=;
	b=LPVHfAxW6Q3UZh8PeZM+T6EWOCNRwruI1DK+j5FjLbNRnBckp24HMbcEG2HwTmyazbxifd
	Avjj30qBwaSMWvQekT9T63DUMNY+HajHYMDBv5RMC4OPem1+XdeyKnDuHw90z+9ANuCDTV
	eTBvJ1ZaNmaRHk+uzuqrGOVf3Rrw02o=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-Ug0ZiRp7PLGzhmCG_d4xYw-1; Mon, 15 Jul 2024 02:42:42 -0400
X-MC-Unique: Ug0ZiRp7PLGzhmCG_d4xYw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c968fd53adso3077472a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 23:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721025760; x=1721630560;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v8cE6GGeNU+RD+Q2LQy+7INYApFI5BbZGukwj8FEdiw=;
        b=Emz0UDKAXGt64DxpyVrj0cj95z0XMqL1QQQaotgjPduTv+ikw12TLXZJqCezHlilbT
         g7yJs4DyRe2lHCeXYX3a1JeCE0v5d9CMFWOH0CJmQVU3/ajVPm/JTyaKP76Khs4FVFRX
         hqb/oBFCL0y3IOjfXiZeSWKalLDSMeqBa1e2muwkjrdvtJ/uRwy3obrq3MKQKhlSFzE8
         WV6FiAn7k5T0mjJuaAsR2/uSJNCcFkQo6Bw/WdljtqY0FF8K+jGiWk2KlxQQI9CQ2uTF
         CxVDwdtFEhcs7DfaCe19nonrRxHnbwu6RJ3IQ4hnXUcQxhvkHQtNFn8UnxEm5wXZ2SUn
         gcWA==
X-Forwarded-Encrypted: i=1; AJvYcCV8dFEAUsnx5B4M9MjeTgXJVm3lkgx5Nu5KuKJU0fwC6DrjaFSxvNaxV9rWcGeTOhrSdEehq03X/L8yhYZPMsnMJQDBAgo2BcRl7nKj
X-Gm-Message-State: AOJu0YwxjaPWYc1+jVl2Ntb8ef7TUyYQy87wctCjVwi6gqQS1e2jWr0h
	4luaXBHDOUzw7XZL4jAV7cdfFpfSYwm6PCHdfOXcrxFBCIqMTPgK7ToI9iI2aBNEOHq1GFARDc4
	RP0d3SPHFUanBTBQ01dM/F8cjtgHN8z+bGW+3YcoH9mzP7MJxf/NCZXLhaeo/mAS4Y9fXpo0cAN
	41gokQjR7nD+JIH8z9V9+jCQWA/nw2QQbJgVpPAxZrZAM4F+I=
X-Received: by 2002:a17:90a:2dc6:b0:2c8:81b:e798 with SMTP id 98e67ed59e1d1-2ca35d3c7abmr12065014a91.30.1721025760457;
        Sun, 14 Jul 2024 23:42:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlYTBv4RNj4wkh9vEElzqL2vBUU600T1kPQZg9cxT7wUn/6RR1ZSvMIcKwDjEReH6NpcRRBTOd7ZzJ9SSfMhg=
X-Received: by 2002:a17:90a:2dc6:b0:2c8:81b:e798 with SMTP id
 98e67ed59e1d1-2ca35d3c7abmr12065010a91.30.1721025760155; Sun, 14 Jul 2024
 23:42:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lukas Bulwahn <lbulwahn@redhat.com>
Date: Mon, 15 Jul 2024 08:42:29 +0200
Message-ID: <CAOc5a3PhrEQ_xScfCxf+kirKg9aBKwEV2NnyKGEDgaDPUfYnjQ@mail.gmail.com>
Subject: Selecting non-existing config in commit cd01672d64a3 ("um: Enable
 preemption in UML")
To: Johannes Berg <johannes.berg@intel.com>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>, Richard Weinberger <richard@nod.at>, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Johannes,

Commit cd01672d64a3 ("um: Enable preemption in UML") changes the
select in arch/um/Kconfig from selecting ARCH_NO_PREEMPT to selecting
the non-existing config ARCH_NO_PREEMPT_DYNAMIC.

As I do not fully understand the change, I do not know exactly if the
change in this line was just an accident or if it intends to select
HAVE_PREEMPT_DYNAMIC.

Maybe you could have another look at this? At the moment, this select
command is without effect, as the current config does not exist.


Best regards,

Lukas


