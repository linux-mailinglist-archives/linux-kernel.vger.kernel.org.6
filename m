Return-Path: <linux-kernel+bounces-184973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5469C8CAEB9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E91428276E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 12:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D1E770FA;
	Tue, 21 May 2024 12:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4HtQvZAR"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6771E48B
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296251; cv=none; b=I8jyiOerj+KGexD8UCKNs+gE2g5lnhN0U9r10LQUDOVN6jAhpBd5JhVCY1wHzg+wXQkM3jVbFngP/EEZmk89c6alm4XmWzoEzRs3T4M2+Ni2UVmH+KLzQdWtwfafx2MhxxegJZ8v/pC0P2xC4WFu+YVGpJiyk3H+bb6HgeyrCLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296251; c=relaxed/simple;
	bh=IAKqG4a3JGgyYgp6qcb5UjB5e/oQrViAJQ12kcFXiXQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=r+fzoLHXFJm0qwCHYnkNB4vzl6cOeUl9Z9+URS+xT+KOjJwf5zR9KruhAyq1xiIXexo6/xW3/dv8oMHkr8TNASBNJ8fVnUhEZ0QjyvBeN5B9XZs/sFrgO1GOE36ydRX6GESdgSGdi/cmIhkqa70SKKTL5THsB7FohtZuu90Epro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4HtQvZAR; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4202c2d397aso25821585e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 05:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716296248; x=1716901048; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0mlGZ+pjE3DBn4405CLRqOUEa255qvEGdzVfXh+mxBI=;
        b=4HtQvZARE9jitVktohUgYtPgNJYcmEdFg79dTLcQYN4bWopYjHZEw0KCRQ3Bk6kf+a
         EpTZGMfxm0B2isEjl1jNDS3671e0okAZyy0BC4chNzLn5XGfaVJOTiByUWf0ajMgTPoy
         Geq90oc6xfUD7CGr/iCdwHit9cD9khZtFE1fQO8CTcy7vTLY2xYjcUo+Eww/JUl/gTZe
         Z19KFvWGRlhAFoRKmyi1MFlGH+Lnb3/QKuDPJfzhnTBjS/A1EFMv0piNbGCJonC+Sbul
         VnoJAbP7hxajU8uhEECSbPCWZo80HqNf+HmCSLGxRx1h6HoECEiQYnV0Q/xFV9vHeb6e
         Rnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716296248; x=1716901048;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0mlGZ+pjE3DBn4405CLRqOUEa255qvEGdzVfXh+mxBI=;
        b=LRZmTn8GWgTRgUHVHEOqEanNrt9qljOpFxrYE1SqErgB5YTajz6vPhzMc0Q0a84IdW
         ubZdptMVCqjiyxAmZczBvjccxEa2TOHSr89wvi85G80ZjYLUcR9C1h4ytMleNZ5+peRE
         dH60oXJeOtGg0W/znpp/aauvmwErIgHdtrm40ckQI6CcubOKjge1P+t2KhR7Rbscl1m0
         Pi3tk/1/tI3xioLul6dlhfO/CM4r+pwr8GpO8SrPdpPgALBekGyGCkP3PBRCKD5AtLBS
         lkd1/Mf8xUEU0OUjp1Lzz0oUst2Mlux6PpiP9hTev0jD9Cm6a2uvANNOJGdlVyFTb8RR
         N0vw==
X-Forwarded-Encrypted: i=1; AJvYcCUexOmVZDyocwoiphO23fQWGMAzMOODHRWLj0TCtkHschc6PQsXuUy3KP81ba9qX/6NXyEwMXPPFeJRMis6zUk6Z372Xr1adIWq8a1e
X-Gm-Message-State: AOJu0YyK8VH8W/tfCl4KUXs3LEIVog7SpxegS1/gysXPUwgOSUKbCOTO
	I6fb0R1z8s5qA+ef8wcs7s2zi6rmhSVjzCE6iv5+8Ftpz5DHqv/spgnHEGWTAwxxFnC6OyyH+Eg
	UuDT0fku4pg==
X-Google-Smtp-Source: AGHT+IEoB6ttY86w8OlDJCcJUCo8TVisUJYdX7DKJR/Jmiih5thWUDcjGWVZ4HSKbID3eaG8wrCuAaiwiIa7Mg==
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a05:600c:a4d:b0:420:29dd:84c7 with SMTP
 id 5b1f17b1804b1-42029dd868emr708955e9.1.1716296247873; Tue, 21 May 2024
 05:57:27 -0700 (PDT)
Date: Tue, 21 May 2024 12:57:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAC2aTGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUyND3dxc3Yz8koKc0nTd4sq8ZF1jQ4PUpKQ0YxMDMyMloK6CotS0zAq widGxtbUAj/pzo2EAAAA=
X-Mailer: b4 0.14-dev
Message-ID: <20240521-mm-hotplug-sync-v1-0-6d53706c1ba8@google.com>
Subject: [PATCH 0/2] Clean up hotplug zone data synchronization
From: Brendan Jackman <jackmanb@google.com>
To: David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

Regarding the first patch: The actual hard work of removing the lock was
done by Oscar, but I have set myself as author for fear of saying
something stupid in the commit message that would then be attributed to
him...  Not sure what the best practice is there, please feel free to
reset the authorhip to him (or I can send a v2) if that's preferred.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Brendan Jackman (2):
      mm,memory_hotplug: Remove un-taken lock
      mm,memory_hotplug: {READ,WRITE}_ONCE unsynchronized zone data

 include/linux/memory_hotplug.h | 35 -----------------------------------
 include/linux/mmzone.h         | 37 +++++++++++++++----------------------
 mm/compaction.c                |  2 +-
 mm/memory_hotplug.c            | 20 ++++++++++++--------
 mm/mm_init.c                   |  3 +--
 mm/page_alloc.c                | 12 ++++--------
 mm/show_mem.c                  |  8 ++++----
 mm/vmstat.c                    |  4 ++--
 8 files changed, 39 insertions(+), 82 deletions(-)
---
base-commit: 8f6a15f095a63a83b096d9b29aaff4f0fbe6f6e6
change-id: 20240521-mm-hotplug-sync-310ebbf34062

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


