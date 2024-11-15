Return-Path: <linux-kernel+bounces-411097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4C49CF2E9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20167292EC0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1A51D63D9;
	Fri, 15 Nov 2024 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E4ZHuZSh"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554811D5AC0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731691740; cv=none; b=I5k8awmZ4VHnskYiw4reKh3XpO1C7djmWMyuhuj+5EOkQMaLPq/ACfTBPlz3PitIkRmG7C3pWt3CSd27tL9mAo6ImvOKn1xBAxp75AlP382Ahz7ZUejN+9Gga+u8BbQZJRHjef1aE82tvGazHyWshJt9R5XrR2cqW0U9ch0nUKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731691740; c=relaxed/simple;
	bh=H/v+DCYursXfrqXPf+NbIzOk5ZfMmnE5IY0bw7x58eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0u2Z6emZp2jTBtnYRf8CRnsqM71nYmLXNUZGDZtNrCE4I8/H9jiw7b6cExpfSmrpEXFlucgKrFJ3ZD4flStuHOLp/ltycLuf8IL6IBRhsTngq+7qJdmJwWqI/7PH4VIUoLn2o7cghHYB/Ed89ylafuk3G/zANjUDw2wzOczCX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E4ZHuZSh; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 15 Nov 2024 09:28:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731691736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2B/ejY5qwEus4tiY6IetFhw7H0Ni5kEo/M7BTrC+gJY=;
	b=E4ZHuZShJ9NR11E6U8daE7GZy+Dnp/T6bSrsZ6GkEenzjWZLsM5mVxl8BO3ZgpTEQzA7+t
	dV9/0wP4/FNkUPGUFR2Lqdd8DrelKPPd9lrqdRvVmNcRkkoPVeJh78b7Djtm9gb/x2RGG6
	rSq28yAPacaD9AnaCoxlMNKk+tyHtgI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Russ Weight <russ.weight@linux.dev>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dionna Glaze <dionnaglaze@google.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
	Danilo Krummrich <dakr@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Tianfei zhang <tianfei.zhang@intel.com>, linux-coco@lists.linux.dev,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	John Allen <john.allen@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Michael Roth <michael.roth@amd.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v6 3/8] firmware_loader: Move module refcounts to allow
 unloading
Message-ID: <20241115172843.jqdhggfgotl2vtuz@4VRSMR2-DT.corp.robot.car>
References: <20241112232253.3379178-1-dionnaglaze@google.com>
 <20241112232253.3379178-4-dionnaglaze@google.com>
 <6734119c1c9a7_10bb729471@dwillia2-xfh.jf.intel.com.notmuch>
 <20241114163546.ermxem4bgjzeaxzc@4VRSMR2-DT.corp.robot.car>
 <67363ecf8a693_214c294dd@dwillia2-xfh.jf.intel.com.notmuch>
 <6cffe226-928f-360f-20ae-bcf27a8d2c73@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cffe226-928f-360f-20ae-bcf27a8d2c73@amd.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Nov 14, 2024 at 01:30:16PM -0600, Tom Lendacky wrote:
> On 11/14/24 12:17, Dan Williams wrote:
> > Russ Weight wrote:
> > [..]
> >> Clearly this would be an unexpected/unusual case. Someone with root
> >> access would have to remove the device driver. I'm not sure how much
> >> effort should be expended in preventing it - but this is the reasoning
> >> behind the incrementing/decrementing of the module reference counts.
> > 
> > The module reference needs to be held only if the producer of those
> > symbols can be removed without triggering some coordinated removal with
> > action consumer. A driver that fails to call
> > firmware_upload_unregister() in its module removal path is simply a driver
> > with a memory-leak and use-after-free bug, not something the firmware
> > upload core needs to worry about.
> > 
> > So, the prevention mechanism is "thou shalt use
> > firmware_upload_unregister() correctly", and when that is in place
> > explicit module references are not only redundant, but trying to
> > implement them causes circular dependency loops.

Thanks for the explanation. Makes total sense to me. I agree that the
module reference counts can/should be removed.

- Russ
> 
> I believe that is how other similar services, like debugfs, work, the
> module is responsible for cleaning up.
> 
> Thanks,
> Tom

