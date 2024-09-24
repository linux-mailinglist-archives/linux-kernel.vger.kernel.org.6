Return-Path: <linux-kernel+bounces-336693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8230983F64
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820251F227DF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D681B148FF7;
	Tue, 24 Sep 2024 07:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cC3Cd+Oi"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9B9149C52
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163589; cv=none; b=QFwxUibf2nkLZ4rrDQ7eKksp1ZSbu1RyxmINovk2AaGDXb7Cex2gupkeKGP55E2g4WSzdmUAu+EQ+q1YeGGQP84dDc+RUezwIdKVEcxCS3Xh6oVfIWFC9cDzESLYY7YUFTHWUC8lzXhU+db2RZzfz2Ta0ap6dgJ0LBi1kSAiPJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163589; c=relaxed/simple;
	bh=UuVCbxCbZXmsnzqgjQAp/JZgwfBvbJQTniutBSS4Qxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuaeTV4bTCUXCT4yARSpiagvUN89+4qCS3oZc+ulML5x+MDGMB1T/Gbb9blsC5LJy+FiVT33E5pyycsTVTrNrVmyE3j+B1oe5vbOxTqH20QOS/Gy7cBL9lq37r4TUR5QxwTZseekqHgXubw4MEjq6qopdXNBTr9kWGgfD9+UcaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cC3Cd+Oi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 6FF5620C6487; Tue, 24 Sep 2024 00:39:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6FF5620C6487
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1727163587;
	bh=Ya0NzQKAk4R4RnEDqvgAZRjMy1OxLehoLLtQ6KuHeKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cC3Cd+OisQRGMUpy5XFA5DVQ+XuS0TFlQ5Df+hOjwgJc3QnPGkj97C7B70OVf6twq
	 FCJ6S61XkIfpzu9//g4ASOov29/7AXZJfCCs8MwROMg3ItSYRrFdWyzLYIVdLDU9aO
	 3OOtcdPRHEih6X4vYlds7qg5UGtDOkMemsLkL0uc=
Date: Tue, 24 Sep 2024 00:39:47 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"mgorman@techsingularity.net" <mgorman@techsingularity.net>
Subject: Re: [PATCH v2] mm/vmstat: Defer the refresh_zone_stat_thresholds
 after all CPUs bringup
Message-ID: <20240924073947.GA22582@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1723443220-20623-1-git-send-email-ssengar@linux.microsoft.com>
 <TYZP153MB07963DDE4B7E01C575B143E2BE882@TYZP153MB0796.APCP153.PROD.OUTLOOK.COM>
 <TYZP153MB0796B44322EAE4C712883201BE882@TYZP153MB0796.APCP153.PROD.OUTLOOK.COM>
 <SEZP153MB0791CB961FF0D1512DC47164BE632@SEZP153MB0791.APCP153.PROD.OUTLOOK.COM>
 <20240920011618.bb2d2a247ae59810aee6c39c@linux-foundation.org>
 <Zu0/nKB5oRF8Yvdk@csail.mit.edu>
 <529015dc-403c-7cc0-5b66-95739e1c78d2@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <529015dc-403c-7cc0-5b66-95739e1c78d2@gentwo.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Sep 23, 2024 at 01:17:16PM -0700, Christoph Lameter (Ampere) wrote:
> On Fri, 20 Sep 2024, Srivatsa S. Bhat wrote:
> 
> > @Christoph, would you mind giving your Ack if this patch v2 looks good
> > to you, or kindly point out if there are any lingering concerns?
> 
> V2 looks good to me (unitialized pcp values result in slow operation but
> no negative other effects) and the late_initcall() is always executed.
> 
> Acked-by: Christoph Lameter <cl@linux.com>

Thank you, Christoph. I truly appreciate your review and insights on this matter.
Looking forward to collobrate more on similar space.

- Saurabh

