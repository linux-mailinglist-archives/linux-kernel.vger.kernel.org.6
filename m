Return-Path: <linux-kernel+bounces-277175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FB5949D78
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541A3284B2D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE6918FC8C;
	Wed,  7 Aug 2024 01:48:59 +0000 (UTC)
Received: from hmailfwd02.mailplug.co.kr (mailfwd.mailplug.co.kr [223.26.214.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C48517B512
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 01:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=223.26.214.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722995338; cv=none; b=GaLwJ4adAdpN17KY4F4yyHg1AUVcLaq9Qx6b/8c3z223EyZwmf98o/3Tgmt2hRTI3y2OyYk2lidxexTqpJSBbYxXn9GvXaGM1EwNqvZ0Od59qfCy7BwDOyvaBxexrjtNjNibgWFetDTrOdwYKqvAhPzwcXYQVKjPgHiLq+P0fAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722995338; c=relaxed/simple;
	bh=TmUw666J5S/m+V/Ac5f/mihn5TuuCsPHRhTtZFFty0w=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=cdEyGaNayUzRV8LkBWJYoURN7iHKjv5WupSMqJnZUdm3HLHYXCL5/ABlSHODH1fI3PV1U3lj1OlAGa0Qskq2BhdYvUfHsQc7P+IOsVK3L/iL9AkBQ1O6oYYESgYVwKQBUDlSPCMgk4Y2j63rjBPXMpDL+To+b3hXWiF14xwi+xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wewakecorp.com; spf=pass smtp.mailfrom=wewakecorp.com; arc=none smtp.client-ip=223.26.214.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wewakecorp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wewakecorp.com
Received: (qmail 2703666 invoked from network); 7 Aug 2024 10:42:13 +0900
X-Spam-Level: 
X-Spam-Virus: No
X-Spam-Pyzor: 
X-Spam-DCC:  : 
X-MSP-Return-Path: <lsahn@wewakecorp.com>
X-MSP-Delivered-To: linux-kernel@vger.kernel.org
Received: from unknown (HELO m41.mailplug.com) (121.156.118.41)
	by hmailfwd02 (qmail 1.03 + mailplug 2.0) with ESMTPS (TLS_AES_256_GCM_SHA384 encrypted);
	7 Aug 2024 10:42:09 +0900
Received: (qmail 2954097 invoked from network); 7 Aug 2024 10:42:09 +0900
Received: from unknown (HELO mailpx07) (lsahn@wewakecorp.com@121.156.118.145)
	by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
	7 Aug 2024 10:42:09 +0900
Reply-To: <lsahn@wewakecorp.com>
From: <lsahn@wewakecorp.com>
To: "'JaeJoon Jung'" <rgbi3307@gmail.com>
Cc: "'Linus Torvalds'" <torvalds@linux-foundation.org>,
	"'Sasha Levin'" <levinsasha928@gmail.com>,
	"'Liam R . Howlett'" <Liam.Howlett@oracle.com>,
	"'Matthew Wilcox'" <willy@infradead.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>,
	<maple-tree@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>
References: <20240805100109.14367-1-rgbi3307@gmail.com> <2024080635-neglector-isotope-ea98@gregkh> <CAHOvCC4-298oO9qmBCyrCdD_NZYK5e+gh+SSLQWuMRFiJxYetA@mail.gmail.com> <2024080615-ointment-undertone-9a8e@gregkh> <CAHOvCC7OLfXSN-dExxSFrPACj3sd09TAgrjT1eC96idKirrVJw@mail.gmail.com>
In-Reply-To: <CAHOvCC7OLfXSN-dExxSFrPACj3sd09TAgrjT1eC96idKirrVJw@mail.gmail.com>
Subject: RE: [PATCH v2 1/2] lib/htree: Add locking interface to new Hash Tree
Date: Wed, 7 Aug 2024 10:42:09 +0900
Message-ID: <000001dae86b$04955090$0dbff1b0$@wewakecorp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQJ06aVWbbSXk45p8AU+nBVbHOMZvAGDsRYJAd3jy0EBYnpY+wGtW8D5sLN25fA=



> -----Original Message-----
> From: owner-linux-mm@kvack.org <owner-linux-mm@kvack.org> On Behalf Of
> JaeJoon Jung
> Sent: Wednesday, August 7, 2024 9:22 AM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>; Sasha Levin
> <levinsasha928@gmail.com>; Liam R . Howlett <Liam.Howlett@oracle.com>;
> Matthew Wilcox <willy@infradead.org>; linux-kernel@vger.kernel.org; linux-
> mm@kvack.org; maple-tree@lists.infradead.org; linux-
> fsdevel@vger.kernel.org
> Subject: Re: [PATCH v2 1/2] lib/htree: Add locking interface to new Hash
> Tree

...
 
> The Hash Tree I implemented manages the Tree with the characteristic
> of a hash that is accessed in O(1).
> Even if the tree gets deeper, the search time does not increase.
> There is no rotation cost because the tree is kept balanced by hash key.

How does it keep balancing?


