Return-Path: <linux-kernel+bounces-567913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F7AA68BF6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FCD2163217
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D0E254AE4;
	Wed, 19 Mar 2025 11:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="uwiZs32p"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945B4253F21
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742384342; cv=none; b=tdT5oBuroevD/AzVOv3LOv5/zh/g+FcgL+9NNuIt7gzTYOboI5X2BoBRn5Ef0rz8aOb0O7gkOZhClBtH5CsEYPeaoKgAeZlQ7tIsz/wkpLBYpMxUTo7zcsdXytlg1E/BluuM99eacoHZnhXC19Lb+JrSMZDjz8cvw/6Dfq/oL/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742384342; c=relaxed/simple;
	bh=Qvbtm6dfyen457gJvLvjX7P5zwfcn2yAepr9V7TxW98=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k0j9QhnbbilRtyzWhfzuoL88tcf4+9zJ0mjqvlUjwDv8ikocYf5ftvwJfFS4cbTmKnldTowpwk0n+K9bO2OiaNZ1zA4BDkt0prImAgeRlO73Lw3rZqbywUj+LLiNqOdRGiiF9f8Y9E44/MS7b2dEeCeb2QQrK7nBf4s1FjbYv1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=uwiZs32p; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22423adf751so118264225ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742384340; x=1742989140; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3b2WbG9Dw9w7LVvz8ibLRK4Lkcz47Aas7wt/j6jq4h4=;
        b=uwiZs32p6QKPjA3U/OMq53AANiClw8YI5ddTJqySjvf5OPNL9EVxZmOjQqlc7U6dGI
         mJJ4BmBRPSK7IbfhS5SrSs9fXvquslrRS9ep7R5aKW5ErzC7S+VfQv7K0BmYbuSR0ill
         vua19EnsZiCv1tGSfVKc+aWdwbzXVeKk05k+vZ4PsVbHCq61BgBMUalQIzFY/g0sA4hz
         0PloCHioVSSiMNU03PNegrRF2p8dCcJlr46LMIfPjckVtQsOpAeG0zPYnIZfY+7d236O
         apLydlnOhh8k0L2kRtIkhp19/zyOcY1OIEFBkiC35k/QGC/R0u6QY/1mx0DzAL0FNUPU
         vuzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742384340; x=1742989140;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3b2WbG9Dw9w7LVvz8ibLRK4Lkcz47Aas7wt/j6jq4h4=;
        b=DxQIu+WGQTIeeW27HTv0pNv5gJBNJEe8nq2RsBGgw31CiazP6QX43Cjo4iRzoRt4q1
         TTPa3tQHHTUkvgH/N9xs2bTbw10HJuSDq7uUV0Z71CjFfuBQAm7pOQuGKX7pc6gcm6qT
         W/Eg6FUOR6fXiIUPRrV2XWtQky/5rczigNl2F1jnEDDrI1pw4eEspLd3qMgclrtY7ZJ7
         fhEUXcb5zAuAX9kfka1ZOCca1phf7k8nTRV0kmiVJAMNxECz4Z13wzcGHrNAY/Be1HdV
         LH1BQs8T7as+xNNXRtwTMjjuL4F69KB+sXjJtsLDHM5m+8wuhJUkLl3ClkeM1Tcit7Yh
         rkxg==
X-Forwarded-Encrypted: i=1; AJvYcCVYSgjTUvKXW5Wg6+E4LwZ5aLsn5E9PsSVU7lJBDi3937xIjzNMuYjuEmPocTXtuvFJTurPnqP8lvXGaQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YydDJIczplB8VMO1pdEdvgrsJENP4AkBhhlhXpgDyO0Ybu6wye4
	IND4EhIGAcO1thBFGwTU+PnzMQBtfXq22nHRiAedT7ISHOhmyQ2Zx9jcevtpDa8=
X-Gm-Gg: ASbGncseMNJocI2JbJtsRABahV/0fesxam7s2uxyHps9exz7Jx+unr+gFLANAT6FiGk
	IkAB8PYMxl/VBnajk7RjeoSnGSr47EBUAsoZbLCbQfs6+kRvvY8WMPEpC+HfFl1bVuVe21QnpYQ
	/Lpc/fxfPRox6ioUmBYxAOVqWUnXLb42IAJQPQK3EqlwFmpix1/TRrfY05NnpClc+uTdLqV9WkO
	J1AN7gWzfwNTYG8t+rluWMrSACkkExk6MCI8oReGksZFTFAitzJYLYsvVfV5KwGtoVkFrhqG78J
	vYJWfwDcdpSwEBEVYXQfum3FozABMIEIPi9eEHiyJZyNv/UJTtWX5VMdD3E=
X-Google-Smtp-Source: AGHT+IHYkRexp+H54sKtCJdj4SxUrr90D/xYbMKs4ypn4d6oGXxC0eDMIKC5k+tCMEC4GAo2sNq6EA==
X-Received: by 2002:a05:6a00:234c:b0:736:6ecd:8e32 with SMTP id d2e1a72fcca58-7376d6ff2b7mr3715385b3a.21.1742384339843;
        Wed, 19 Mar 2025 04:38:59 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-737115295dasm11333924b3a.30.2025.03.19.04.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 04:38:59 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/2] KVM: arm64: A few trace additions
Date: Wed, 19 Mar 2025 20:38:54 +0900
Message-Id: <20250319-trace-v1-0-0fff03204efa@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM6s2mcC/yXMQQ6CMBCF4as0s3ZMW5AAVzEsynTUWQA6rcSEc
 HcbWH4vL/8GiVU4QW82UF4lyTIXuIsBeoX5ySixGLz1N1u5DrMGYmwtjW2susieoXzfyg/5HZ3
 7cFr58y25fI4whsRIyzRJ7s3aXF2NSg0M+/4HaKrISYQAAAA=
X-Change-ID: 20250319-trace-80cb8d39de2e
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

These are tracepoints I added during recent debugging. I hope they are
useful for others too.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Akihiko Odaki (2):
      KVM: arm64: Trace values with kvm_sys_access
      KVM: arm64: Trace SMC in a way similar to HVC

 arch/arm64/kvm/handle_exit.c       |  3 +++
 arch/arm64/kvm/sys_regs.c          | 24 ++++++++++++++----------
 arch/arm64/kvm/trace_handle_exit.h | 26 ++++++++++++++++++++++++--
 3 files changed, 41 insertions(+), 12 deletions(-)
---
base-commit: 8098cf067a7aae92a4f293df03964bf8474faca1
change-id: 20250319-trace-80cb8d39de2e

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


