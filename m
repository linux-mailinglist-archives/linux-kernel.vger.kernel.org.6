Return-Path: <linux-kernel+bounces-537602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EB7A48E05
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 02:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3CFE16A451
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 01:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E416235977;
	Fri, 28 Feb 2025 01:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laAXA1OT"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A9D53363;
	Fri, 28 Feb 2025 01:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740706396; cv=none; b=C7xB1mb8TTb1ujWHu6UJs1uJaj2UaLvBAAWu1iyLnhcxesqzD9QyA/XVmZDAOJvAWldMHFsKEfCHREeO5oYCH6WsOBpCAs/uR0TA5bitnEiEoPBkOCnwIM1iEHj1+yIdQA8/2OtzabqUtqZZ+kGhqmsbO7FKwgm4OTBZkLJwu38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740706396; c=relaxed/simple;
	bh=ZUKnlJ+YjtpuQ2qv6xdVXPEP9vVZjQYDpbFSbR7UGsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2fhsZalOePGlvOb+uPrq4O58CmGH2SQojVk7e2t/XGXBrNA+oqLoUzPTuoLiMZkYOIt80h4aPDnuSDeSyk6bGBuhRSXL41S1zwKLmoxJDdmylELOhG4y26NNX5h55IaR4PAEv0LcEUqAb7WRd5nxaFV45WM6eMCHtg5CEDZKks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laAXA1OT; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6dd43aa1558so13195826d6.0;
        Thu, 27 Feb 2025 17:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740706393; x=1741311193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzKnzLSFF/gRYTjZd2rXqbgU7CsAt+EMo3/BYaDmuh4=;
        b=laAXA1OTjShan/ppAg7dmgjFNFWix2gdN4igRh1tKhVZ3foVNoXUKtmsX0U0lV3kgt
         3K7oHqKD3NO2Im86bDGq8H9w99ThS2ZRnD7QHi3GtDRZoxvNMzpLhzvsOhcosxD7wTX1
         KueGTbFnPCaMJFcOQiX02xKtVma50YLcGusOOZRgbQD0JMFG8p4xukhcY4UaEYUBDTB8
         MTRaCIdnM6rddLtq/brZstKn5X7Nnq/WnN8MTFI6xBmTeH40se3OSN2Of3sSDAa2RuEM
         PcDoZO7Y8yb1isAD+dnBGPzW5p0axr6GEkVYKzJfFrUbap49BpB9HRXSW3nxjhHi7Ccq
         WNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740706393; x=1741311193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzKnzLSFF/gRYTjZd2rXqbgU7CsAt+EMo3/BYaDmuh4=;
        b=vgq6EwV+TYHu1ka/JTpqiPhLhoIihkxZIYOh0Wug9QpxwZ9MidB1+EKZr/n3+0dKwz
         9PDbf5SbWtgmIiq5GNM6AKw61HeK5StsoWUIGbrwf7VsRPzY/TJkrDzxm9Gj/bEjTiY5
         2Vh0RZmDGmVHPWGzI/7nlXoFmz77a+Xs4hWZBjTQSSimRBwFlJY1yF1gpVgkmsGtpfLa
         K/DDuKkXcjwbNVf905Y4Xw7CYwpMMBaYVWQmymCJipltiDhut/gnExHj6kL2CoubW6A2
         ENeJ9bigAQZlYZu9XiEuYHVoLjWKLahk9+QjY+Q8vvG6eHc6PTY7b2rK0n4NsrUQXpXZ
         aISA==
X-Forwarded-Encrypted: i=1; AJvYcCUYYFUZjD5CpaK9k10fvuOkQOxm7JSEHadEW/dmpnSJz4Hmsfwgp645BzsuGbKIyF0vdGSlWCEdcW68sh8=@vger.kernel.org, AJvYcCXtOS1GhJthNcUaLvd/ikS1vJECX4zgdapTyuAka1Kgg2jJaxGW38VIuOZNemYwN6mPpgr+tb+hJUBfCApPCeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+rsGWYlrzw5MAb0MuKjpAaDY/sdM2/EEXEYnLjX5aJXLFHTtc
	QPl+jr3vRREy4cjIk5grJd4ZnAfe9R8iqWdci29ScFqNFlHEqnPQ
X-Gm-Gg: ASbGncsWwQhpVTnSLJqXVZJRov37NLShdDzZUKFgF2eSWNkKLM0JAHnVPZFajRt1/Sj
	EVFyNdFfhSMdref9Y3fJ108GrKoCac/oltnZdo4J02tS23uYcxq5YI/BJu2QWLY6lkINrBp93Ak
	pvIq9GXqJ3+4TuhX7/3VdyhQ+5BRkY4BJd5Rsl6ustihKkG83HHq3Edt/6CohwHTx4O1fMB+9OP
	ihZb8uTENQKp8kpNB7NCWDwVSwgKNf4mMmzzty7dFbp6ef25qIHdp3NH1HZGnjZ165oNqPELbUN
	1TMftScbOajmsH0P6Efem8DI2KihvOPO8tITXowunpFSlh6v1g8+22y2uIDUGjR2hkNp33xZSxS
	3zK3QeVWHabyNyQ9R
X-Google-Smtp-Source: AGHT+IGPCe3N/rnHyjBycXbXfmJBT6C/xAXMQb0UXZOZOAzocU5QXjsqC8ETDH7QHK2XReJAOyCeAQ==
X-Received: by 2002:ad4:5f87:0:b0:6d8:ada3:26c9 with SMTP id 6a1803df08f44-6e8a0cb955emr30855096d6.10.1740706393625;
        Thu, 27 Feb 2025 17:33:13 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e897634926sm16436046d6.9.2025.02.27.17.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 17:33:13 -0800 (PST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5A9A01200066;
	Thu, 27 Feb 2025 20:33:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 27 Feb 2025 20:33:12 -0500
X-ME-Sender: <xms:WBLBZ1vhJVc6yIWHr3IdXJE44ClJnM5mi1XQG2C33XFuxu4-4VKmLA>
    <xme:WBLBZ-fRchVF3qi8uujHczTLfGCVJUAlORQc-WQOPnS-Ra9WDjYwPGabMqEFKdONq
    MEKEUEi-CIJO78PuA>
X-ME-Received: <xmr:WBLBZ4xBzRSalAvrqMA7wO_w4dKjKrdxBhQta2x-2J_wueURYgA3dOM4rA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekledtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedugedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdroh
    hrghdprhgtphhtthhopehlhihuuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehr
    uhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehmihhnghhosehr
    vgguhhgrthdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdroh
    hrghdprhgtphhtthhopehjuhhrihdrlhgvlhhlihesrhgvughhrghtrdgtohhmpdhrtghp
    thhtohepvhhinhgtvghnthdrghhuihhtthhotheslhhinhgrrhhordhorhhgpdhrtghpth
    htohepughivghtmhgrrhdrvghgghgvmhgrnhhnsegrrhhmrdgtohhm
X-ME-Proxy: <xmx:WBLBZ8McPF6agxWcS4tAcxH34jRigKSLqbEUKu1uCGZJnTSrFh9PKA>
    <xmx:WBLBZ181d_sWxMmQO9goD9L4Dg0KxJ75TJ1ie-7m4LfwfDK94UW__Q>
    <xmx:WBLBZ8WvL0INsSaxYlkWXRoqW1lPNzHLELx3V9KXrn-EWTHSrB1DoA>
    <xmx:WBLBZ2dmclioFBoBv0JXmBblW1SwdUOqqtcrZYK3rK1ogaALPx2ZNg>
    <xmx:WBLBZ7fwWjJhVkkVMjS4t615-AOn3Lv6l7nS2IMZkG0MlcLjG6tUkubv>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 20:33:11 -0500 (EST)
Date: Thu, 27 Feb 2025 17:33:10 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 1/9] preempt: Introduce HARDIRQ_DISABLE_BITS
Message-ID: <Z8ESVjynMytXObEp@Mac.home>
References: <20250227221924.265259-1-lyude@redhat.com>
 <20250227221924.265259-2-lyude@redhat.com>
 <20250227180916.1ab6d957@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227180916.1ab6d957@gandalf.local.home>

On Thu, Feb 27, 2025 at 06:09:16PM -0500, Steven Rostedt wrote:
> On Thu, 27 Feb 2025 17:10:12 -0500
> Lyude Paul <lyude@redhat.com> wrote:
> 
> > From: Boqun Feng <boqun.feng@gmail.com>
> 
> -ENOCHANGLOG
> 

Yeah, sorry, I forget to add them or ask Lyude to add when handing over
patches.

Lyude, could you add below in the future version?


In order to support preempt_disable()-like interrupt disabling, that is,
using part of preempt_count() to track interrupt disabling nested level,  
change the preempt_count() layout to contain 8-bit HARDIRQ_DISABLE
count.

Note that HARDIRQ_BITS and NMI_BITS are reduced by 1 because of this,
and it changes the maximum of their (hardirq and nmi) nesting level.


(I will add patch #2's commit log shortly)

Regards,
Boqun

> Why is this patch needed?
> 
> -- Steve
> 
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Lyude Paul <lyude@redhat.com>

