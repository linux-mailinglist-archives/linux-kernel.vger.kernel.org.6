Return-Path: <linux-kernel+bounces-577168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0869A7197A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00D11887572
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D011EEA36;
	Wed, 26 Mar 2025 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="ivsKx9cX"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5561C8638
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000529; cv=none; b=QKxmSyXN+96HUhGo3+bWwBTuiJ5qb8ZLz8TYxY6YNHawCbrb1wrcyeXwU9QKADitUWfoqZaKksLWvgsE5+UDEyvzUC78gh7CeFRp/iSXpBEr38TLDUYsqxOrQxOR1B9rG8pe/hxqa/sgtvrAnrqOHUi0c9CqKuvzGvJQklaMP10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000529; c=relaxed/simple;
	bh=F4yfnC01yAQPXo3tQEauTSdmUQQmT4GSDWCA+pDcd8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2eIollmzm1AxB32b3tqhDpQBsJJjlepBUCmsA7J6q9vRIGEgtg4j9yA3dUA+x1AUPtwohnbtnPLLTEAFBMk2ivtbhPQbuXqxE2Kx+ZSBRHcXuwqvka1P5uIiiE1tRFVx6dZTmTEGNy+aztddeJn3iVSeGwyBXZsY2D78Qz1Yd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=ivsKx9cX; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-477282401b3so52776181cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 07:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1743000525; x=1743605325; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s4L90UXo/Eloa6bFLe63wlh9gsUHXreX60bjxNb5DKY=;
        b=ivsKx9cXwNjWZY+PA27oeQpzwB/c9P805GSJZFqRvi1cCldT4VNki5LX3GeH4SRGeW
         t0D8+SOGkDSB1kVQSSViuqp1h7iv3wZ1phmeubxuKNz+aHPG0LsGneAptI8GX1T4iulV
         4CEO6WdZ9uC49VyZlRWsnJPpQFW59yIbBVvrxvYxPfBwrT5kdfeRaU2JkttSfd/SCzli
         4tnHyZj2q0djXB6zB14js3mRHKVxDxp680T3YKxX1+IyJPWBnfvB70AyfFkkHxI7L49k
         dXgBNU+CNrBY9Icu/Qyam0bp/ItUv6l9rgsiqHyOBlJcHonbsAcp3xWdOBnBhYoPaKD+
         5Row==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743000525; x=1743605325;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s4L90UXo/Eloa6bFLe63wlh9gsUHXreX60bjxNb5DKY=;
        b=Wl95uDMV+T2cACb5CXf1BCyOPdAqShi8svDKQSP8jsDlbyYKu7sTzrA3QaBcSVqSm6
         RrOwY2SREueg6IJFMhHg+9TG3zjVoMyKLVK5llRaftyOG18Rt2K8RSlh6mBNRoc4Cuyj
         3PSvgpbVz31tTnrAeKhChm9vOQ+kxHJofmBeA4CVUNvrHf/bWlTsWunZQvdBA2C0QcbL
         g8xQnFQ0DAAfKJTBkzB1g9RlSlBGELQiTeCzIrQ899QKg/IKycMp7WzYJ273/V1MAXA3
         swZOKLxSq1eMuMnguX2pZWp6+RuAhEAW/Us3UfmyeNcfjD+8ZrJXqm8V9Np3VYEnnLya
         tBQA==
X-Forwarded-Encrypted: i=1; AJvYcCVCHc9dYNYJA5APCQ85x9IELtTJFko6Keqy0LXPk0+xObICxq9YXdWwYGUYtUlkomb5JEHkWuZPMMleEP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Pa7cPr3uukg7mRPZ+rAl67mqF+bagS3nYqT061ftxqR3MH2H
	jtNDgvzsg0J5fHGxN7iXq26+r/GYItHVb3rKPZF22Ur5B3CRfpR8AutpLYVeyPc5d7RIPHVcQlB
	DbK6aH+cAs2rPLYjZ9o1pzmPnoRZBlpej8wgCbA==
X-Gm-Gg: ASbGncv9sMrVJnx9kg+bu8nZ1XkKi0Q4Wh5NiAQL5GGu4bgxqEemdjpzBZJ9tUnfh2A
	LnnyaEpXxbIFPU8ydal9IKbTovFW2+rOVKVOLWA+HR99H3VkDRNUe/Y3HdroSe4jutKlYjOvAy9
	E/v+D0cdfLf1pq125Su+cFATRBqWh36JGernc=
X-Google-Smtp-Source: AGHT+IE/in8kAs9sUqWx2S+TIM+LTl3sNiBhEhAtSNAuElUMT/X5dBkUTEwjbBFN/tuBh1MnZZanWSfFlEopABMrt2Y=
X-Received: by 2002:a05:622a:260f:b0:476:91d8:230e with SMTP id
 d75a77b69052e-4771de62880mr403362231cf.52.1743000525452; Wed, 26 Mar 2025
 07:48:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304150444.3788920-1-ryan.roberts@arm.com> <20250304150444.3788920-4-ryan.roberts@arm.com>
In-Reply-To: <20250304150444.3788920-4-ryan.roberts@arm.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 26 Mar 2025 10:48:08 -0400
X-Gm-Features: AQ5f1JqVDILCP1zyFTP-RFlE3wANS6rYR-F_g2XERE3hhejEgMHeH_4cyMuLPCw
Message-ID: <CA+CK2bA3ctd6+G9DrJZ3RvnehPCrf7hEJ3boFJ5pkMTZyVmDSQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] mm/page_table_check: Batch-check pmds/puds just
 like ptes
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Kevin Brodsky <kevin.brodsky@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> -void __page_table_check_pud_set(struct mm_struct *mm, pud_t *pudp, pud_t pud)
> +void __page_table_check_puds_set(struct mm_struct *mm, pud_t *pudp, pud_t pud,
> +               unsigned int nr)
>  {
> +       unsigned int i;
> +       unsigned long stride = PUD_SIZE >> PAGE_SHIFT;

nit: please order declarations from longest to shortest, it usually
helps with readability. (here and in pmd)

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Pasha

