Return-Path: <linux-kernel+bounces-539172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10950A4A1AB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387A6175F93
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C430927AA6F;
	Fri, 28 Feb 2025 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HRP38e3t"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C120C27AA40
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767425; cv=none; b=qwIybST8NnJgPi0g/uYUECvCkou0PP8mRV4SrhugTUTwsneQ0ta36FvlRQ2aINMdKu9TvHrl4PuTUy+t2c0OuZTR7/luyNajXmRbt7nRDH2/1Gh5PzKnNpz/DSaeLx9wmwwoDHECy6jETBb6Scco0Vf4XN8PBIHHaoACizGibeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767425; c=relaxed/simple;
	bh=X39w3F+lZKzDtwc+JkA4F7RVrVKOpwrVxWXrIMQgSAA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nawF5vRMfsrnTjhlkl4qMKBm3ppvt+BbGD34yEd4MX/MldJ/9/2AiGTdQ8LG3iON5JmB7CAeFgzL9yI+P4TrYg8n+PNHzFFgRxRXdRBA5RMksXrUaGwma6nvLsCe9xdTZCgTHF9z+9XMg+I3McjLo7UHBGR7EsaHsUa+0j/ejLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HRP38e3t; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fe916ba298so5050342a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740767423; x=1741372223; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ri+EEQGIMa13uM7TTbruNz5oquaji2Ir3iub6xGqmT0=;
        b=HRP38e3tIVsDTI9JcQIttpwUV46Ia4BeWCea0RkmWRYVsjEOsDAsAdPHMY/Pmos+Pa
         6GWMmmQlw45z1Rf3Sopf1IAQtL4jgydLxDVZPdvNILLB/d9DnVIaB2XncgzpDNC0tFzM
         /TXI4wMay3360rrGUrD9pYwvuPOz7+oaXQA5MqdiJ3vFyeFBcrhFdZxe8HfLhxcD1On6
         UKehC7IyssFif3IN6l7R9xndVYJmXc3E5bcXqP2vszz/eidGSkOAarJneDIUdiWCte9o
         BX9uPuQFBbwRGc9O1zru1RlgwqeXk8JidBvFaf94fn1vo1UHHHoAybNr3GxlAaJAKje5
         SMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740767423; x=1741372223;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ri+EEQGIMa13uM7TTbruNz5oquaji2Ir3iub6xGqmT0=;
        b=cR0NjnB8zuoz4lspcJvbFBDqMka6RC0Z5qIGoc6q03vkFZPQ6F7ETnw154VTjyBHYn
         Ett10NVthEwC/L3CFt4fBufT6tpd3ZWQe7yTP6RC8w5m6vhlCXT/5q+U44DonhPZto6J
         AvDSZj59ZrsLBFzlEIwz54Rzr3ML0Nw632FHG/9Z63bgXof9KHUCQt5VVQUKJGtcEjwp
         BwdWlgjt4cYYDltf9u3MrRvtgao74wnuJKgL6AdyeVuPXgpB1T2R1mMyjHmBkCozTRvH
         iAiar23rNon1NomT+WRz4jwghbiJeGmfULIpfZqS/HM4+DweKiCJLi7uYv14EQfL25+X
         HyQA==
X-Forwarded-Encrypted: i=1; AJvYcCVckfjYXXYXttCBwavkTxTY459ELzn88FA0XgbRb2BntyGy323mVsFP+RZTFAL6X61eLFPHO+hJArF5tYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTs/Joe18/3NB8K5OK5BJVgod7oxjgpPlydcE/gKh72LXQ+ISr
	3L/T7YkOjejIVLUloMH+Zfdx+TPH8ObFxw6qSB2/IfD6f84ndfqPKlWBEVOx0JGI77KIMg==
X-Google-Smtp-Source: AGHT+IHkocdsxLFj1UhQoNs63q4QIAx+wUoAy7Ek0ZQmWo/uXxf9KSLx0hvkfC5/UWsfEohsJBSicvyr
X-Received: from pjbee14.prod.google.com ([2002:a17:90a:fc4e:b0:2ea:5469:76c2])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4fc8:b0:2ee:c9b6:4c42
 with SMTP id 98e67ed59e1d1-2febab78711mr8118779a91.16.1740767423034; Fri, 28
 Feb 2025 10:30:23 -0800 (PST)
Date: Fri, 28 Feb 2025 18:29:22 +0000
In-Reply-To: <20250228182928.2645936-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228182928.2645936-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228182928.2645936-22-fvdl@google.com>
Subject: [PATCH v5 21/27] x86/mm: set ARCH_WANT_HUGETLB_VMEMMAP_PREINIT
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, ziy@nvidia.com, david@redhat.com, 
	Frank van der Linden <fvdl@google.com>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"

Now that hugetlb bootmem pages are allocated earlier,
and available for section preinit (HVO-style), set
ARCH_WANT_HUGETLB_VMEMMAP_PREINIT for x86_64, so
that is can be done.

This enables pre-HVO on x86_64.

Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index be2c311f5118..384e54b23d50 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -146,6 +146,7 @@ config X86
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANT_OPTIMIZE_DAX_VMEMMAP	if X86_64
 	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP	if X86_64
+	select ARCH_WANT_HUGETLB_VMEMMAP_PREINIT if X86_64
 	select ARCH_WANTS_THP_SWAP		if X86_64
 	select ARCH_HAS_PARANOID_L1D_FLUSH
 	select BUILDTIME_TABLE_SORT
-- 
2.48.1.711.g2feabab25a-goog


