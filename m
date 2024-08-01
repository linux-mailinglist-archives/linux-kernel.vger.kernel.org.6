Return-Path: <linux-kernel+bounces-271895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECD1945497
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 00:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A03285542
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 22:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F86614D28F;
	Thu,  1 Aug 2024 22:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lfo7KuAV"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BCF146D73
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 22:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722552245; cv=none; b=ZNhXumrUAAtJq0Xao1HhFiClkKtlII2H+LCPL0FAcx15tdINmPxpxJftGXJOxSPwRSuBvWaFFXeAGe4QD9Bcd7cwTWVSi1V2UVzJJATYyN3n8XblCv5DiBd8dBMo2o03M8pIKFAzODZVy8QsY3dAirmpqMV//F2vbZC63/9nqHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722552245; c=relaxed/simple;
	bh=lq3VBorsI74MMj3Lqck3lrsi3fdGR/6G+iOUm2eJ8wc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gBrwBtLauGbDkIJIuYzt45ENTeKB5E+oOpp9aVnInpA446FfL3s/D3zujEdx8bhW/Xk8uPisu3FUUIEwu/fk73gKRvyRtcpZ7MFuLyWZKj55vNXOa+o1reL3/zqXjkqz84JqsqN5ar5WhcyCD7kFYzbusjcDfdcjDs0e72mTHjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lfo7KuAV; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70e9ea89b42so6743774b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 15:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722552244; x=1723157044; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p85cwU83Btirpz320PiS8rUe0YP6eP6Qw8YmMGvdQno=;
        b=Lfo7KuAVtk8v5trLNAAwaMual7t21JwO/W8EvOKU0ZqhtOygG0AUDcpCSM3HC7eesx
         9oeyN1l6cjjUqIlTsXVIt9RBveR4Va0r6NaEj+VMXqdLisWKGlJsYbgrCgeUqMIWfzt1
         vnt9dXXpVEt3/yjMiVQHjUXLQJerWv2YA2FqYdTY3AAEMSmsXm4Ar0ksVIKgbQ5/+8sh
         BSJyfc+hiIHE+diwGIR3csT0a1WrbefL1hQGJBtgIZO/8fpC/g5bx56NUWetJqOp/GWe
         YG9h+kGK6MkaOL1Zjl58JBgilVbOqydbpvitAQvN1pXIUOpGPIyqSejOUWDRXzmlvL1Z
         g3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722552244; x=1723157044;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p85cwU83Btirpz320PiS8rUe0YP6eP6Qw8YmMGvdQno=;
        b=AOrev0MbyGV1khZxjC0cwt0ZmhYpCGfDGhwrXHVcCF1XWpp5KMYD0T9rRPqZs7iQmW
         hAeMem8FRm7D6cXb03XvirKh8xM5aaaMx/1BjyL5xo4jSz3B9zfA7Dzafqwg5yW/POcc
         TWYOtnoYWh2Icca28q7G0GzeT7gsGqn1L4KxF8Z1BIVphnWCqCLRmDXz/pVCa5JZk+8f
         vhmeyyZR7zgIo/U2tWE2eak/LuOPFY9kK5Pn/hoJD2DcEv0aL1hsb0N5SIEDqFBK76en
         3gpvl/ditFp7DIrT84E9ltxqaFp0T921urf9iiXUkAX0+MX+YGjC+X4hsycWT7etFTd2
         04RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHCgp4l1JFW92GdS3KJhrDTDuPmeCGbzLQxNpk+IWsoTvZGsJ+jDXSDk+6ZiK0j/HflhnZrTFwdtpz8uhveZva5jiRHJREcuxyJGng
X-Gm-Message-State: AOJu0YwOg5YO67viVYs4AED7acWVcufBft+Dlb/ZbN/pr51p6z4e34H0
	TInbp76zPIo1ax6AeCep49WZJzjA9AdO+xpJ2gnv34iYBBkqRnBSAuz9Z+sV8cxtAAnfsa2ZhrT
	xcA==
X-Google-Smtp-Source: AGHT+IEmR7D4g/Tw8EyfOWI7dF5c0FZtLAEI5aDeLZlNzohQhY4pE4dwXTrp2wXUEy2kRsQwoPrBvaSEB/8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:949c:b0:705:ca19:2d08 with SMTP id
 d2e1a72fcca58-7106d0ca7camr10974b3a.6.1722552243470; Thu, 01 Aug 2024
 15:44:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  1 Aug 2024 15:43:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240801224349.25325-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Agenda - 2024.08.07 - KVM userfault
 (guest_memfd/HugeTLB postcopy)
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Xu <peterx@redhat.com>, James Houghton <jthoughton@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Axel Rasmussen <axelrasmussen@google.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Early warning for next week's PUCK since there's actually a topic this time.
James is going to lead a discussion on KVM userfault[*](name subject to change).

I Cc'd folks a few folks that I know are interested, please forward this on
as needed.

Early warning #2, PUCK is canceled for August 14th, as I'll be traveling, though
y'all are welcome to meet without me.

[*] https://lore.kernel.org/all/20240710234222.2333120-1-jthoughton@google.com

Time:     6am PDT
Video:    https://meet.google.com/vdb-aeqo-knk
Phone:    https://tel.meet/vdb-aeqo-knk?pin=3003112178656

Calendar: https://calendar.google.com/calendar/u/0?cid=Y182MWE1YjFmNjQ0NzM5YmY1YmVkN2U1ZWE1ZmMzNjY5Y2UzMmEyNTQ0YzVkYjFjN2M4OTE3MDJjYTUwOTBjN2Q1QGdyb3VwLmNhbGVuZGFyLmdvb2dsZS5jb20
Drive:    https://drive.google.com/drive/folders/1aTqCrvTsQI9T4qLhhLs_l986SngGlhPH?resourcekey=0-FDy0ykM3RerZedI8R-zj4A&usp=drive_link

Future Schedule:
Augst   7th - KVM userfault
August 14th - Canceled (Sean unavailable)
August 21st - Available
August 28th - Available

