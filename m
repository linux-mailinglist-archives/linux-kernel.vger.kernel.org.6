Return-Path: <linux-kernel+bounces-562376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC24A624EE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 03:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56DD08815FA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 02:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8761517B502;
	Sat, 15 Mar 2025 02:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OWiDZzGI"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7C22E3381
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 02:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742007099; cv=none; b=RvcEIKWYKs0r7VSb/e00FuEn4CdSCk2C1IHMi4dxDf7tSdTcjY5O7wUOe8rZXVECwWo38ntAKbwnO/AYIrXWvbp63oNXE/Q1esgRRIPrVPkwb/0k8/8DrqwEnPC8oQNqm1/2dhmRjmq/+xVbHAQfefzkKZI/Rn28Fx43xZpQ/yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742007099; c=relaxed/simple;
	bh=0YZU/DvP8fB3z8mZiiIDMaWfk8+HgW+71aQP8SeLwgY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JCmm+SJSGvXZNhPZfQx8AQk6ylDN0IBT6BysH/nfoHjWiTSgA5KW1I6b02Hoje2/0I9XR21E0yEMuK0xBGkffdiZvxY269rLoT3So1HLJvLi2H3q2loL265Lt+DjnkTh1U4LPy9GkkmAuX9i4+dsbP6uddFRT2NlSMcUnilzTZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OWiDZzGI; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff581215f7so309753a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 19:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742007098; x=1742611898; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMbGiitCpuvjOFuODMMxjAc19DExq9bX91Vfl+5044M=;
        b=OWiDZzGIlDUXeA52YQOSAHE5Vk0vTA9s1q3/g81Zjibiv99A3SPbQW4kI319AlCBA7
         q8RTnNqxrsWBz7CLKi1ushPM4H6Ryk0BGMzkuyGaOGyWI9TUcL8sRJWijvxECESghjM8
         IidRctbTDCWD/q+L/jTd9aYFn+anG3NbsPWKNgn4+TqSP3dg0MckyFsxu1+gLSeY6ICq
         PTa6PV7mol9qs+YAJgdAyG8CXMJjsNYpU8vSPuITpZAKWohH7dEHx4abq5dLxwdswlvj
         znrpvbMh+DyNHHY0MiLa2zdodXhHCx8HYXEGqR43vyHOhB9kml5wXUGuza6UvToiWUmb
         VZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742007098; x=1742611898;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DMbGiitCpuvjOFuODMMxjAc19DExq9bX91Vfl+5044M=;
        b=sgsaT2xkI72kQBVBRUGmvJED8ZGToMDpVr2JvR/2iUd8Muk/zF17ZNgrJkCFJT6Igs
         crV6mVcBiYEkro3O4EiMYaYTCkqeE8Ao4Pj4Z2SqV+SLNYm7l1IeskVLSFJ4ojUxo+7j
         QD+YDLHs2P7yq/iLFWlkW7zaanSyqUPgoP4eWq9dFNA+0ZC+4cu/xS5mkc6+pe26TIQW
         qvFs4c98ya3+3qXzUuapggRHaLXtjx6oEzF+3SxhA2YbKIQNcKfmY61SIqE3TZt0vj4a
         k3Mqx2eQiUYn3bNaIocyQ8StdH6QWIuzTUgwX4avURvB7+2/Pn0h1e6RDw6pxQHDri60
         CiZg==
X-Forwarded-Encrypted: i=1; AJvYcCUTCxiy2lp+plALy+BT+Nw4kNSeAAswuPQIjZ6dcDM05ndSqTJceku4SqbBZnspJLZ2pW+NTJ89tpl4xKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsihjqP0JeO9R3F+/KMzT3XSBvTKPJii23A6putb8Ukz2z05Rd
	F/zbdja643J2TU4xD0xwSF+kecpsGYEKcBgCqqNFMnmJeu2SfjzNgSNjE6sCgaKHeUKfB/IVS8t
	edw==
X-Google-Smtp-Source: AGHT+IEp3KLKUystWtxj9uI1C1L9MSg3ce6eOk6EzEg5jdro4UAaSDmC2iPIXDV2Ck000kG9t+mMtpyxKqA=
X-Received: from pjbos14.prod.google.com ([2002:a17:90b:1cce:b0:2ef:d283:5089])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f0b:b0:2fe:80cb:ac05
 with SMTP id 98e67ed59e1d1-30151c9a26bmr6572265a91.9.1742007097783; Fri, 14
 Mar 2025 19:51:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Mar 2025 19:51:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250315025135.2365846-1-seanjc@google.com>
Subject: [PATCH 0/2] iommu/vt-d: Fix posted vCPU vs. posted MSI bugs
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix bugs where using posted MSIs will clobber IRTEs that are configured to
post IRQs to a vCPU, and where undoing vCPU posting fails to put the IRTE
backing into posted MSI mode.

Sean Christopherson (2):
  iommu/vt-d: Put IRTE back into posted MSI mode if vCPU posting is
    disabled
  iommu/vt-d: Don't clobber posted vCPU IRTE when host IRQ affinity
    changes

 drivers/iommu/intel/irq_remapping.c | 42 ++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 15 deletions(-)


base-commit: ea9bd29a9c0d757b3384ae3e633e6bbaddf00725
-- 
2.49.0.rc1.451.g8f38331e32-goog


