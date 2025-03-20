Return-Path: <linux-kernel+bounces-570078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AD5A6ABC9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7F2189B7C7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FA2223311;
	Thu, 20 Mar 2025 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jifhEwLO"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2EF42A80
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742490960; cv=none; b=TBa3hdqGdoqIkEWuQ0bnPeNxitM3+fpknNS42ndzgiaZXstS5OFVRk1r0Lb1PJRqiDtbTrMZ3EMVE3/Qj3AeLAN0WK9IjR+MNSEqy/lhGbnRsuQbo8OU8fScgZk6tdql5aU1zsVKkpKjbr9FTclGQmBs9RwmpXSuv9N0tfSD05M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742490960; c=relaxed/simple;
	bh=5vcA7VYkAbR6dJ4uPGsop0RCD9nTLsdEHjU7/It/kNw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UYxRTp+h/DKfX8gKsDNUm1T/ny5JZ97+ly30o1yqfuRejF0kGioKX5O6ZPRag2HVzC+RPK+WY96NGfPfqdiv4Wun6w8pnXame+O0Bjck6lXv4MbhKR2r9Git5f68gqQOr6k6CwutvnWdmJt92OFbY5oX9uVpTbTpV4/ti9YfecY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jifhEwLO; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2265a09dbfcso26126765ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742490958; x=1743095758; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5vcA7VYkAbR6dJ4uPGsop0RCD9nTLsdEHjU7/It/kNw=;
        b=jifhEwLOsTmmg5SUxzZWE5IxMAgs2cJJVvZbiOjzWcRSVWZJpiS1cfWoE628redgEY
         B5IV5a4SaTq3FhFbEzMyl5SOsQaAUXvA9xOgF/L9UodHJqLuVOSnfvraIdmt2kD7BgiC
         ehZNktjwN/w5rUZAbCMmnmPxIopUz5upyawMHaSp/rxxm47ktCL4FeC7xmaborOPImLY
         JDdPo+wo6fCoMIpRbMKh1TjbJ3pHrOt0R+t1BZlYK7dCikcidmYetkANKEIhne5Q+mGk
         Vs6Fbb+5G2sxpsZrox5rSOR+Y4VhAxN4v0yhexTML2kpb3k/C+RB0E/Q4Hbh72J9P2sx
         /vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742490958; x=1743095758;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5vcA7VYkAbR6dJ4uPGsop0RCD9nTLsdEHjU7/It/kNw=;
        b=HU5nkgx+HsDwnEs/efGW60W9/ry6sb42sHLOtCrcPgHwVg4IjWCdM0Lf27Nk6w7cC/
         o9p6L7NuPz6q4GMNjU6mM8+VXbXgb7N+bfttR8n264zPS2jAirSNdTDhzS7WO4WE3niv
         wwao120OrABgWyB3gHuPD5LSrNU0NCgF+Fi+gS6zGZaGF86efV/Hkp4mDY70FyBmvtlv
         PfbxhhAQK1kXjlU67Z13pEZRaGjny58u9lE5Yt4thwSZq58HIsGTppGE2Y1EaFUFcHNC
         ij9C858EiSH1qzqTmbCMbi9pAfZ9hj3IdAqpBLLxwLaJ3oPaNmqNTw/9KnvwcVh93h+c
         NaCg==
X-Forwarded-Encrypted: i=1; AJvYcCXmcIvNoyeMs3Qqsh6yIMZN2Diz/AQu74Ru2RXONMW7Wyo68NjX/q4eA64QpUpu5CVfKtG1T5sUIPT2aHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIt6hmnqGfqdI0ShbQSuxH6ovR7DGAUFxtnEbauzp8SAdxn+Bl
	kkfCLGnGC/mHczitLZoC0At6NuJ6tZ2l8n8iwGJxl4i8jsqevBQL2P0WDCAVaov+jad7+J6ihp1
	0I1YOop2fzmyB/kZN7Q==
X-Google-Smtp-Source: AGHT+IFSTOZJPhF0A6p4zYu8XqyFCbfj+1u7L3mgdhQb13y/kwPpTEfBMQ3apw/ZGc9/6LxAV+vBXTVj5vs9bXs4
X-Received: from pfbkq8.prod.google.com ([2002:a05:6a00:4b08:b0:732:6425:de9a])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:b55:b0:737:678d:fb66 with SMTP id d2e1a72fcca58-73905955db0mr383661b3a.5.1742490957851;
 Thu, 20 Mar 2025 10:15:57 -0700 (PDT)
Date: Thu, 20 Mar 2025 10:15:45 -0700
In-Reply-To: <16b14662-d69b-478a-9e2f-a05c56f2c4ce@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <16b14662-d69b-478a-9e2f-a05c56f2c4ce@kernel.org>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250320171545.2324955-1-changyuanl@google.com>
Subject: Re: [PATCH v5 02/16] mm/mm_init: rename init_reserved_page to init_deferred_page
From: Changyuan Lyu <changyuanl@google.com>
To: krzk@kernel.org
Cc: akpm@linux-foundation.org, anthony.yznaga@oracle.com, arnd@arndb.de, 
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, changyuanl@google.com, corbet@lwn.net, 
	dave.hansen@linux.intel.com, devicetree@vger.kernel.org, dwmw2@infradead.org, 
	ebiederm@xmission.com, graf@amazon.com, hpa@zytor.com, jgowans@amazon.com, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	pasha.tatashin@soleen.com, pbonzini@redhat.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org, rostedt@goodmis.org, 
	rppt@kernel.org, saravanak@google.com, skinsburskii@linux.microsoft.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Thu, Mar 20, 2025 at 08:10:48 +0100, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 20/03/2025 02:55, Changyuan Lyu wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >
> > When CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, init_reserved_page()
> > function performs initialization of a struct page that would have been
> > deferred normally.
> >
> > Rename it to init_deferred_page() to better reflect what the function does.
> >
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Signed-off-by: Changyuan Lyu <changyuanl@google.com>

>
> Incorrect DCO chain.
>

Thanks for the reminder! I missed "Signed-off-by" in a few patches from
Mike and Alex where I did not make any changes. I will fix them in the
next version.

Best,
Changyuan

