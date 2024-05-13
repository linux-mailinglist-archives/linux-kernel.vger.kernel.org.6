Return-Path: <linux-kernel+bounces-177742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAD08C440F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D980DB23A1E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1241DDEE;
	Mon, 13 May 2024 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="PTw3Qwi3"
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26A6539C
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715613579; cv=none; b=r/qCuzZNa8+V9eFM4R/37DFZwLTN6rUQ+18n/iZ1v++6lKYKh9uC8bst+Yq+gP1xY+OP40McP4PQZmKWm505Vc0URhDMzpIhRMk8CxbBJHeWpVfC3ergFOX3pObiCgE79iMb2gWPDqPjqrOTG0xsq97Q/bLsSSAO/iCCmbYAO5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715613579; c=relaxed/simple;
	bh=sPuS7EPTrz0qRzjB2FtezfNzBYa0BrXVt3jdkcELRN8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tZHSGwR/pSwpWJAwAqW4uGVxJanRk29nOCSAzGsokdtJuDcVEfoXrrE8UNpZablV6rWaEIEzLCsN5+prkWqUFLLGY6JuRpOSGrF2R+twL2my6jN0jFbVOq5/MQGVzHRDt2kXdQNuI5tXJiuNaxtM+X6khxEo6vzcMvs45skTq5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=PTw3Qwi3; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=o87U42jqnR9nQVj48Q2/0KYOkznU0Vujp/drf/oUq20=; b=PTw3Qwi3fgASGoRP0cbQORF/Gb
	T+/gXNBNuBH0hYGO3KV8S6vEbz7zRFpegBkeQzhYumffofHtab/+/1I0YkKtTFZx4zQTPvwxgBFWh
	b7lgxy3vyOsin/kU+0oR2/iVx6mG1b+rrDBX23oKz4elacSX26y3vP1Le2PMsjXzm1BaP+X/pxExM
	SkaDaqFWcoKHrGvjpdVSStnmK/xeG52xVYC43WH4TzDMLZ5lO/7Pq0WzukcgdXe1HY+fC90ZaGuqq
	eZx/7g8toEujg8lJjHUZjSY+6VdywtO8QA4g973UxYlVu+LGC+tkBMSBD4qKQp07Y0jczwlnKAcVf
	D53yrMGA==;
Received: from [78.40.148.178] (helo=webmail.codethink.co.uk)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1s6XSI-002nuN-1p; Mon, 13 May 2024 16:19:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 13 May 2024 16:19:10 +0100
From: Paul Sherwood <paul.sherwood@codethink.co.uk>
To: Phil Auld <pauld@redhat.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/deadline: Fix grammar and typos in comments
In-Reply-To: <20240513135812.GA9998@lorien.usersys.redhat.com>
References: <20240511082644.44757-1-paul.sherwood@codethink.co.uk>
 <20240513135812.GA9998@lorien.usersys.redhat.com>
Message-ID: <ef7021835015a5bdd5bf5404ee712853@codethink.co.uk>
X-Sender: paul.sherwood@codethink.co.uk
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: paul.sherwood@codethink.co.uk

On 2024-05-13 14:58, Phil Auld wrote:
> On Sat, May 11, 2024 at 09:26:44AM +0100 Paul Sherwood wrote:
>> - conjugate verb to match subject of sentence
>> - s/a entity/an entity/g
>> - s/this misbehave/this misbehaviour/
>> - a few typos
>> 
>   - not starting all the lines of a commit message with "-", priceless.
> 
> Plus, you're just repeating what's in the actual patch.
> 
> Otherwise, these changes themselves look good to me.

Thanks for the feedback - would you like me to re-submit without the 
bullet-points, or without the text entirely?

br
Paul

