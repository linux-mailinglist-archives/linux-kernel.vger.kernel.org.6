Return-Path: <linux-kernel+bounces-336288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C1697F19D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 22:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BF761F226DA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 20:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8244D8A7;
	Mon, 23 Sep 2024 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="G2itaHZC"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C7415E88
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 20:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727122644; cv=none; b=KHeRGNSaH+n8HwmdKU047N3qG85HXEb8pnHY3hceOgvaVvMKLfnncR2p2U4OrUZXDO62b98XdviACE2nXZJY2PF1q0ZMvAsdnehtZrpWu1IvbQl3ZNcePdnJYXruwGVowWsxfG59YviADORYOB3RHBhopMizSiM5GxTJXakKkDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727122644; c=relaxed/simple;
	bh=7LkRaa+MyVh2hulErC7C42yXncUklW5xs/ymRrebSZg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QjRI4xeY4cAaUJdL6sitxqy+GZJwiVK/hB2B4l26AuUDnU5HRoqSRCdnKU9P32H0g2U2C/xITahQlhRxadP95hnvS/FML+YlPPLm/oUDaEH+YZselWvVLIhkleSfNrq9Gf3l+zqnBenQJ/TE4XQS0+Ppu0FuLdAu5KTktw7RjAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=G2itaHZC; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1727122636;
	bh=7LkRaa+MyVh2hulErC7C42yXncUklW5xs/ymRrebSZg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=G2itaHZCQi8z8YUKVRqf7sBXhFpTGklOZ8+GAImeja/y4h4JQ3w5gKI1XKVhFE6Yy
	 VMfwCUMC0lTOqwdPngR5DlCqzo60Xmsr1VHpVG6Ni0meEKuSfFv3mN96fP0BxpFg4V
	 9x04VCvB3X5Z3hz2g8JwqMFBrPDAxsAc+Pu62y1E=
Received: by gentwo.org (Postfix, from userid 1003)
	id 15E684026D; Mon, 23 Sep 2024 13:17:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 142D840264;
	Mon, 23 Sep 2024 13:17:16 -0700 (PDT)
Date: Mon, 23 Sep 2024 13:17:16 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Saurabh Singh Sengar <ssengar@microsoft.com>, 
    Saurabh Sengar <ssengar@linux.microsoft.com>, 
    "linux-mm@kvack.org" <linux-mm@kvack.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "wei.liu@kernel.org" <wei.liu@kernel.org>, 
    "mgorman@techsingularity.net" <mgorman@techsingularity.net>
Subject: Re: [PATCH v2] mm/vmstat: Defer the refresh_zone_stat_thresholds
 after all CPUs bringup
In-Reply-To: <Zu0/nKB5oRF8Yvdk@csail.mit.edu>
Message-ID: <529015dc-403c-7cc0-5b66-95739e1c78d2@gentwo.org>
References: <1723443220-20623-1-git-send-email-ssengar@linux.microsoft.com> <TYZP153MB07963DDE4B7E01C575B143E2BE882@TYZP153MB0796.APCP153.PROD.OUTLOOK.COM> <TYZP153MB0796B44322EAE4C712883201BE882@TYZP153MB0796.APCP153.PROD.OUTLOOK.COM>
 <SEZP153MB0791CB961FF0D1512DC47164BE632@SEZP153MB0791.APCP153.PROD.OUTLOOK.COM> <20240920011618.bb2d2a247ae59810aee6c39c@linux-foundation.org> <Zu0/nKB5oRF8Yvdk@csail.mit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 20 Sep 2024, Srivatsa S. Bhat wrote:

> @Christoph, would you mind giving your Ack if this patch v2 looks good
> to you, or kindly point out if there are any lingering concerns?

V2 looks good to me (unitialized pcp values result in slow operation but
no negative other effects) and the late_initcall() is always executed.

Acked-by: Christoph Lameter <cl@linux.com>

