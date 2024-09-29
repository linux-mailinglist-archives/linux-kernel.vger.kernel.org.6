Return-Path: <linux-kernel+bounces-343045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E56698962C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 17:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E703E282E50
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 15:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E1717A589;
	Sun, 29 Sep 2024 15:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="vdGT7dlC"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430651C683
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727625063; cv=none; b=nlyPmgDZ+teQFUF1Q+3YenmJk2+PoMXEIEi1z6XRDyPALScRqGB62Xpth9oCP/ZK/4eLAXd+fMOBE3K7fq0Z+BicbpQJog+7Jktza0qAnleiwp3FUBbLGQqrisnQOdHbzLBXKxY0ZoD4dbXY5PqfmNt4aURME9yGvKURz4xJwUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727625063; c=relaxed/simple;
	bh=JZxrYxpziZiNH0RWp1bEPKptpq2xXzmCutmdLJ4h9hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5lzyFnbnawUnUYMMU50vuOi9MRZBRJGK9yUYia/Gh9JwXMRiyinK0J9Jx7acxQXLTilXkZAgge/2mWjdp62Rjii9Bb2585fOmaczS8WxH0IHEPN2+1pwTE/qwvyaWQm5AxCv6a+9eXJHpnbwyXruz4zzKu0ts1i1ssU9hz/GDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=vdGT7dlC; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6cb54eef205so9234596d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 08:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1727625059; x=1728229859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Y2D6qTzk1N1f3m0kRzoxA/mFWQeqmxquaa8AlYdeFM=;
        b=vdGT7dlChEUoLJMZsIkAHoUxLlje1p5SAsn3QkpnpPv5Yoco1ZyiTjQ0B16J0H/55W
         Z8ledBqTq5QnEhpRWb9w5FvoAcall/pbgLOdyDoR/s0GHFl217MAdEi78v6Nxyivs/xO
         Wk21CRPkCny5w4pXOpOLR23y2/oumx/qZe3gD+uGEvn7yIYSteV3/7zFaEy3cmkfJ4l6
         OS7oKQJgvQwXXA6Bsnw+fqaJa/gAlILxxJ5NbL3xXzPvtmrGtL57FsK3Y6x6doHNbuZ4
         eOLIwRWqJhlt/hgL4GTnRTS2Hne59hrj1xhnRZaj0pgPgQHMyF5WIZhSc9MNkeAZp6QF
         pH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727625059; x=1728229859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Y2D6qTzk1N1f3m0kRzoxA/mFWQeqmxquaa8AlYdeFM=;
        b=fjCiV/5MNFH+e3zY1InGeUAy4kBnFfGZl8yF7uhyMUG74xeS5CqE4JIgPoMWxml7ic
         w7CPO0Yba7S3ZoFERg2FWOrnWiRu9T5E69zXZxcFvWOrDV0XyJPR/52V3eqPuAXlBYpb
         zz2YHQ21c0rfiizzldzu+RXw7qerWRpHAX757iw+TJ09OWb1aaS0ZDQnIsU3EW7HcI0j
         i0heSuGq4RcQtWVoWOcXxg+s7+HESfo3HGg26FIpxC/Mxd6O2fbRp9kaKeiXPKY4KcZx
         pr1T7sr3ryiDW+3keGk9vV0QLDpzVBcMldzJ/mi9bS+orIePt+bbUQBcIrkLcHR/iHTO
         dn8w==
X-Forwarded-Encrypted: i=1; AJvYcCWiuZtYHDeUUJgsOH3RJbMzgS9UY1Rfbc8UfpcXcWW2qONOGwLASBEZmP/ERmVx5VBjJ1aWzt12U/H9qQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt+kmLHhINXzo7mDxjq+ml2NV3T2lWJ0tW7lnkUH6eHcw4j2/f
	FZPxnpQ2oRbHZmFR+WOHjwtCTfjX96dMOrA6U/sWgRsi1q88F6/wRncbrD1pdQ==
X-Google-Smtp-Source: AGHT+IFZuEPBZGMBb6yILvpuGoLBRTg0zQfGWndE1JjdQ9u9RIGWwrmtLSM5wwVtRT+ilMvEG3tiNQ==
X-Received: by 2002:a05:6214:598f:b0:6cb:2d18:dfe5 with SMTP id 6a1803df08f44-6cb3b65a8femr120236206d6.49.1727625059122;
        Sun, 29 Sep 2024 08:50:59 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::abbf])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b5ffbbesm31867626d6.25.2024.09.29.08.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 08:50:58 -0700 (PDT)
Date: Sun, 29 Sep 2024 11:50:52 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>, John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
	Mateusz Guzik <mjguzik@gmail.com>, Gary Guo <gary@garyguo.net>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@lists.linux.dev,
	Nikita Popov <github@npopov.com>, llvm@lists.linux.dev
Subject: Re: [PATCH v1 0/2] Introduce ptr_eq() to preserve address dependency
Message-ID: <df54d990-537a-418d-b748-7cc140eba236@rowland.harvard.edu>
References: <20240929111608.1016757-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929111608.1016757-1-mathieu.desnoyers@efficios.com>

On Sun, Sep 29, 2024 at 07:16:06AM -0400, Mathieu Desnoyers wrote:
> Introduce ptr_eq() to compare two addresses while preserving the address
> dependencies for later use of the address. It should be used when
> comparing an address returned by rcu_dereference().

Both patches are now much better.  Thank you.

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern

