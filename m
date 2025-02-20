Return-Path: <linux-kernel+bounces-524885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C82A3E861
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F4213BAC69
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25762673B9;
	Thu, 20 Feb 2025 23:25:18 +0000 (UTC)
Received: from mail115-63.sinamail.sina.com.cn (mail115-63.sinamail.sina.com.cn [218.30.115.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E19266192
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 23:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740093918; cv=none; b=bRK5Z0PXOGNLNioG81eyKvwOzcvCPMo5RdTQWKiOqW9WRylSW1+To6opo3DF35Q/KXaqdMMGduTaABNSM+Xm4mZ7JNzwT/HQPeRZkT02DAdfpgFN6tT9/tLFt07NWdCnXK/J3dzTjt5kziL2Q9MYkRtI9LFS4nK08yHegyuyRPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740093918; c=relaxed/simple;
	bh=GiBI+Ueev+BEL901ge+BPypu7Z9ti8bTpC31MMcUOsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zcc+8MoJ73fyMOv8YU6kN3NLRpsnJS3+/NTMorC3+oCF6MTDfe6lTe4ZQMuaAqFrPGkkpBCeBjFnrfaFCL4B06WZIjV0WRBN+rMC/vxgnJcXnHlXd3cqPuxBFKPtpLUjOtTfZ20eIyH7oWtJgqDMTFRbZ4MOZUZV5SVvkz9cet0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.8.75])
	by sina.com (10.185.250.22) with ESMTP
	id 67B7B9D500004F15; Thu, 21 Feb 2025 07:25:11 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4121737602527
X-SMAIL-UIID: 44415CC9A20146AB8789489C42E1A855-20250221-072511-1
From: Hillf Danton <hdanton@sina.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: Byungchul Park <byungchul@sk.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	conduct@kernel.org
Subject: Re: [RFC PATCH v12 00/26] LUF(Lazy Unmap Flush) reducing tlb numbers over 90%
Date: Fri, 21 Feb 2025 07:25:02 +0800
Message-ID: <20250220232503.2416-1-hdanton@sina.com>
In-Reply-To: <Z7dFuTkdQ7PmP7sY@home.goodmis.org>
References: <20250220052027.58847-1-byungchul@sk.com> <20250220103223.2360-1-hdanton@sina.com> <20250220114920.2383-1-hdanton@sina.com> <Z7c0BTteQoZKcSmJ@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 20 Feb 2025 10:09:45 -0500 Steven Rostedt <rostedt@goodmis.org>
> On Thu, Feb 20, 2025 at 01:54:13PM +0000, Matthew Wilcox wrote:
> > On Thu, Feb 20, 2025 at 07:49:19PM +0800, Hillf Danton wrote:
> > > On Thu, 20 Feb 2025 20:09:35 +0900 Byungchul Park wrote:
> > > > Just in case that I don't understand what you meant and for better
> > > > understanding, can you provide a simple and problematic example from
> > > > the u-a-f?
> > > > 
> > > Tell us if it is illegal to commit rape without pregnancy in your home town?
> > 
> > Hillf, this is unacceptable language.  You need to apologise.
> 
> Agreed. WTF Hillf?  Where did that come from? Is this how you talk to your
> co-workers?
> 
> I'll tell you what would happen in my home town. If someone said
> that to a co-worker, they would likely be terminated.
> 
Interesting, I want to know if the three words, rape, pregnancy and WTK,
could be used before judge in your hometown court by anyone like your lawyer.

