Return-Path: <linux-kernel+bounces-527506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA87A40C1A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 00:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCFF53B355F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 23:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4913B20370B;
	Sat, 22 Feb 2025 23:18:28 +0000 (UTC)
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D69D530
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 23:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740266307; cv=none; b=R33RS2jMp8B9loX11rzAY5020MIZicLQL8gFKtkOWlXpdUkCS4FdPW1nLz8nUqAAYKmU+NCWkYTJM+L9tJl92XMJyNvH0Rs3i8z+lfVcYzPVe0Mj2T6v2rNyEuXWyq+ahMuuyv2qir5JCz3E1jhp/attBbFSUL1xC2HpsryXWok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740266307; c=relaxed/simple;
	bh=F0gSSjEDxuRkpYB61WXzPtzQIRDmkJ7jwFzDAbDleR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOxt36n2iHQAJTW4ZoBM8EcmpARna9H32LAwDSGkuk6FxqxElQb6U51G7SjVfpU6XTyLkMNpmP8xpeGvxKPFRxdP4Ur2dqGd5emllAVYxo3q7lgJ5rCEMBlA7OtSncZf7O7DtHN9FUqq+GgTLrZLtvJXdb+3CbdZJV6ciyOTxd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.68.60])
	by sina.com (10.185.250.22) with ESMTP
	id 67BA5B3700005222; Sat, 23 Feb 2025 07:18:20 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1936177602351
X-SMAIL-UIID: 322EFC80D7644D64B8FD251F7C1AD073-20250223-071820-1
From: Hillf Danton <hdanton@sina.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Matthew Wilcox <willy@infradead.org>,
	Byungchul Park <byungchul@sk.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	conduct@kernel.org
Subject: Re: [RFC PATCH v12 00/26] LUF(Lazy Unmap Flush) reducing tlb numbers over 90%
Date: Sun, 23 Feb 2025 07:18:03 +0800
Message-ID: <20250222231805.2557-1-hdanton@sina.com>
In-Reply-To: <2025022221-aviation-rectangle-c497@gregkh>
References: <20250220052027.58847-1-byungchul@sk.com> <20250220103223.2360-1-hdanton@sina.com> <20250220114920.2383-1-hdanton@sina.com> <Z7c0BTteQoZKcSmJ@casper.infradead.org> <20250220232503.2416-1-hdanton@sina.com> <20250221230556.2479-1-hdanton@sina.com> <20250222101100.2531-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 22 Feb 2025 14:57:43 +0100 Greg KH <gregkh@linuxfoundation.org>
> On Sat, Feb 22, 2025 at 06:10:59PM +0800, Hillf Danton wrote:
> > On Sat, 22 Feb 2025 08:16:09 +0100 Greg KH <gregkh@linuxfoundation.org>
> > > On Sat, Feb 22, 2025 at 07:05:26AM +0800, Hillf Danton wrote:
> > > > On Thu, 20 Feb 2025 18:44:12 -0500 Steven Rostedt <rostedt@goodmis.org>
> > > > > On Fri, 21 Feb 2025 07:25:02 +0800 Hillf Danton <hdanton@sina.com> wrote:
> > > > > > > I'll tell you what would happen in my home town. If someone said
> > > > > > > that to a co-worker, they would likely be terminated.
> > > > > > >   
> > > > > > Interesting, I want to know if the three words, rape, pregnancy and WTK,
> > > > > > could be used before judge in your hometown court by anyone like your lawyer.
> > > > > 
> > > > > This isn't a court. And there's no reason to use the word "rape" in a
> > > > > technical conversation on the Linux kernel mailing list. Perhaps a person
> > > > > reading this was a victim of rape. How do you think that would make them
> > > > > feel? Welcomed to our community? Absolutely not. Which is why it's totally
> > > > > unacceptable.
> > > > > 
> > > > There are NAK victims. Did you nak more than twice a week, Steve?
> > > 
> > > This is not the way to work with your fellow developers in the community
> > > to express disagreements.
> > >
> > No comment because you are free to express disagreements.
> 
> Disagreements are fine, but not with words like what you used, sorry,
> that was unacceptable and requires an apology.
> 
Feel free to show us how the three words, rape, pregnancy and WTK, are defined
to be unacceptable, if you are correct.

