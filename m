Return-Path: <linux-kernel+bounces-202006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B9A8FC673
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3021C2300C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233171946AB;
	Wed,  5 Jun 2024 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PYJ4EDth"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B322B1946A3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717576249; cv=none; b=hHD1vWvICO4Q/QF4V/CQ9ZxFIjvVAQgjo9/cd59OcsP9eB1WOs4Yi/PyQ2pgDhRCRFZMMYuW1r8fenSMRjJnxGjMZtQhiOZ3v0SM7uRcOEHsti37o9KUvw48EWTbiwZPxpQDn1L/PRgnNFC8zI1WFRW6QCyfrY514TNUrNJXOqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717576249; c=relaxed/simple;
	bh=DjIt2sv2KBbnpI2+rOFr9SWGiyjz+3LoXn6g22/zqZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HtciFNCoPGYkdAyJ/buugjhRmQbu3VbXvDRuWfz5j7MTxRS8trEC6k3Fs9eCKSmdGbyPxlCh2RqoS4n2cwkILFs/G2sj564jYSJxnQxmkV8sz71NxvIvZnkzMaUfurzx2Ryw/qMM0XTB65mHXdJnL2amHARFhTEYnKScRyQrNUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PYJ4EDth; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=x4ORC
	TIk2E2uJe0udJSKoOkRMe2N4/T+Jt4x6oUiyoY=; b=PYJ4EDthC4ir9DsCjlLUZ
	4wRR5mk2BrCxA60y2uTqWiVNbtIuxd7yPII4+R1xsfMeHl/p5XcKZ8LyN5ZMhkt5
	n/vzilJYhkQo1BV3dtQ5++2eUFWu2jWSWzcunvsqZ/KL1VEK9g+LuTFjl3Q+knBd
	usDRuaPbsvAJmvmwFKfs10=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mta-g1-5 (Coremail) with SMTP id _____wDnT8wRImBmHCpvAQ--.16928S4;
	Wed, 05 Jun 2024 16:30:11 +0800 (CST)
From: ran xiaokai <ranxiaokai627@163.com>
To: david@redhat.com
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@kernel.org,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com,
	v-songbaohua@oppo.com,
	xu.xin16@zte.com.cn,
	yang.yang29@zte.com.cn,
	ziy@nvidia.com
Subject: Re: [PATCH linux-next] mm: huge_memory: fix misused mapping_large_folio_support() for anon folios
Date: Wed,  5 Jun 2024 08:30:08 +0000
Message-Id: <20240605083008.891170-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <05e50d0c-4222-4c1f-b051-c7249f04c661@redhat.com>
References: <05e50d0c-4222-4c1f-b051-c7249f04c661@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnT8wRImBmHCpvAQ--.16928S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw15JF43ArW8Cr4rZFW8Zwb_yoW8ArWrpF
	yqgas8KrZ5XF4Y9ryvqw17trnY9ry8X34UZa4xJwnIkas8Ka12gFW2k3W5uayUZr4xJw4I
	va1UJa43WF1Yy3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUN189UUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbB0hb0TGWXyLDBSwAAs8

> On 05.06.24 04:20, ran xiaokai wrote:
> >> On 04.06.24 07:47, xu.xin16@zte.com.cn wrote:
> >>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> >>>
> >>> When I did a large folios split test, a WARNING
> >>> "[ 5059.122759][  T166] Cannot split file folio to non-0 order"
> >>> was triggered. But my test cases are only for anonmous folios.
> >>> while mapping_large_folio_support() is only reasonable for page
> >>> cache folios.
> >>
> >> Agreed.
> >>
> >> I wonder if mapping_large_folio_support() should either
> >>
> >> a) Complain if used for anon folios, so we can detect the wrong use more
> >> easily. (VM_WARN_ON_ONCE())
> > 
> >> b) Return "true" for anonymous mappings, although that's more debatable.
> >>
> > 
> > Hi, David,
> > Thanks for the review.
> > I think a) is better.
> > But we have to add a new parameter "folio" to mapping_large_folio_support(), right ?
> > something like mapping_large_folio_support(struct address_space *mapping, struct folio *folio) ?
> > But in the __filemap_get_folio() path,
> > 
> > __filemap_get_folio()
> >    no_page:
> >      ....
> >      if (!mapping_large_folio_support(mapping))
> > 
> > the folio is not allocated yet, yes ?
> > Or do you mean there is some other way to do this ?
> 
> If we really pass unmodified folio->mapping, you can do what 
> folio_test_anon() would and make sure PAGE_MAPPING_ANON is not set.

I think I just misunderstood your suggestion.
How about this ?

static inline bool mapping_large_folio_support(struct address_space *mapping)
{
	VM_WARN_ONCE((unsigned long)mapping & PAGE_MAPPING_ANON, 
			"Anonymous mapping always supports large folio");

	return IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
		test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
}


