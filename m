Return-Path: <linux-kernel+bounces-287548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E98952915
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 07:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE2961C21921
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 05:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F566146A6D;
	Thu, 15 Aug 2024 05:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SKMzwMfT"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB48014373B
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 05:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723701461; cv=none; b=e/leYKcSxMDCYta+i3gVOARPEKFuPOCkkmofJ7gVH8mvmmOpvMgbTRyB0g+k+zwKEgQ7s1X54GRT582m2NI6vYHag1CkDQAWhR0bj0wMNq/EcZ2IK3yA1WcOgZpAFpBDCHFQ9D8t20IQDjt88r+tJchHZ7aK+Wz5vahDOHaJCao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723701461; c=relaxed/simple;
	bh=mXZeQr2Vr+9zCthY+fysuNbATVG4BXJathKzP9Zd7Z8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mSBkHz5m2BO0tRG8AwS8JXYuh14dSXveVbXgdH4qQIjkBGcJ3QZ2njXsXiR3U3zAT02q4w8RvM6xb5OvAWfPqp9gPnrVrlx7XqY6XyqziPFQqwwkPIvW04ye9v14oOSA9b1r0fumXLTlhRP1UBQ2dBgu7LD2SksYuFG/NOqgtbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SKMzwMfT; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-201d9fa899dso4703435ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 22:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1723701459; x=1724306259; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EP1p3+2gvbnxYrGCFl4PMjke3zRORbnj8Xo4kAg7C0E=;
        b=SKMzwMfTSRXvAUUz28wtvt+H3KNiGicyr/QOmZVxfcyLhfLbGuuGlaVHhXKKMlQUON
         VHpouH0uCl2XC7EksKpdTqPCepbFaw9W2jOwIEmpBzESRrD0sEwiTYoGOAMLOIrYgQ1n
         HVlZisW68Xn+8T9bpoWtzYw/GkrqOwBdp0t/Uh+Xi+GhO4g2NxZKBttCGJEaHyQrJ3tO
         t9D7JLDfuHxWmj4O7CU3BxF+zAjljfAzdREt36Qw2DagT025HlcvyRnQ2mmsNTpp8qjg
         t1akNTWGkxsblixsIhECMx5cs1L8WAXHV25p/IR+aqZlxoVBdY7d/x2zt4pYNmuisHdS
         45qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723701459; x=1724306259;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EP1p3+2gvbnxYrGCFl4PMjke3zRORbnj8Xo4kAg7C0E=;
        b=q+pxz9Z5CgymwtcU6D5R7EI27CtrnYZ4vhVV6flXIoIPPFiNx+eHSEhlX7E0xOM9iU
         r3ZTKKzUSrrEZD1aPsBt4BlUdEHoYEquepcuSD8JMqOJxEUyA+0Ayi89oYNImGwDpLpL
         HNZ6ghoU2S1tHROc0H9xs9z0g3snbzrJVbWteBAgUGgEZqefM3yi8E9rn23QFbAaKSNM
         X8CMh7F9p2h1uWfL/0bNT68IHUJdBH3I+j44TXDyzTbBDJUNk8qYvgrBeYKiaoYtqCfm
         MDLqPoL9rxTbEdcJmVg18b8uVc+etDGMV6objvNELTTwyB72sMixbf3x8df47mdoAeXN
         NuMg==
X-Forwarded-Encrypted: i=1; AJvYcCU/YjWcCbPHgiy9davknGMlZh191sebp/r2tKmQLh/nWLQ0BO2iVPvfpzc1ilEgF0Rza2t0Q6aW/WzwS7LLbd2Uq2dBWfXF8fYaAEi6
X-Gm-Message-State: AOJu0YzYTK+h4+YeF+zyDVjBvIk3nMmtHKCy16kKpq+cp2ig/UAoMNpS
	gqoYIBI211/FtsmcXeHws78gz3HPg3//4K3OVzp5nBOFYIl1HMcgY3mSYuGIVn8=
X-Google-Smtp-Source: AGHT+IHy998p3ercTXCMwdNoj95acF7XreRaGMhWKLw6A40uieiN+1tbJNN5OB1UrtU/Ge5cDx60pA==
X-Received: by 2002:a17:903:244e:b0:1fb:4701:be6a with SMTP id d9443c01a7336-201d63b40a2mr61068905ad.20.1723701458884;
        Wed, 14 Aug 2024 22:57:38 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201f031bc36sm4875625ad.100.2024.08.14.22.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 22:57:38 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: macro@orcam.me.uk
Cc: bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	mattc@purestorage.com,
	mika.westerberg@linux.intel.com,
	oohall@gmail.com
Subject: Re: [PATCH v2 2/4] PCI: Revert to the original speed after PCIe failed link retraining
Date: Wed, 14 Aug 2024 23:57:32 -0600
Message-Id: <20240815055732.25252-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <alpine.DEB.2.21.2408091204580.61955@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2408091204580.61955@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Sorry past few days have been struggling to buy some time to look at these. Every
time I go into the store and ask for more time they try to give me phone cards.
Its an improvement to restore the "capable" link speed & in this case I think we're
also enabling a user to have over-ridden it if they were to write the register
by hand. Its nice to give every potentially "new" device a chance at achieving
its full potential.
A little outside of the scope of this patch, but I was wondering if the logline
should be a warn level logline? I don't honestly know what a "normal" level is
for the pci system. Also, instead of saying  "retraining ... at 2.5GT/s\n",
would it be more clear if it said "forcing downstream link to 2.5GT/s". In my mind
its more clear that an action has been taken which produces a potentially less
than unexpected speed.

I can test this patch on a couple of systems, but I need a week or so to
get it done...

Reviewed-by: Matthew Carlis <mattc@purestorage.com>


