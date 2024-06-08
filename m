Return-Path: <linux-kernel+bounces-206865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7894A900F0B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 03:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1FE1C21E38
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 01:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19A98480;
	Sat,  8 Jun 2024 01:00:16 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 8FF24ED9
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 01:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717808416; cv=none; b=RjXfsX88Epc8ML0/DBucR4upRXWe1LqB0SjtCl4e37YoVzrVBeYzY8YRMmlhcTNUnQwyjgA6c5FpfIBonK/JDNp1rxfCqQ4cCGlozzA5xW0yMKdKKMLWgFMgx9W1LQR+CywuOF6ktiW+pWO01PpMZSDC8rdekTjpWhmI3VOzkQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717808416; c=relaxed/simple;
	bh=mxbpt/IIjp+zQ1LCt1nVLb4V++Hr8L9etihL8pox+tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cW6WBG4P61qwFRqvR0mBHYuFywOepKcuyq0a03lDyJ8BMGaPSwez3LjN7IpUL9aPWiNzvReZHJeoPH5HoJexoJg5wQuU+ltJYT39zMJVBbx1mfDNguU67JV1G3N3amV+CvZy/YlBkryyufgl3GKFimZGzDTQlAtnm0yBCQCvOFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 67017 invoked by uid 1000); 7 Jun 2024 21:00:07 -0400
Date: Fri, 7 Jun 2024 21:00:07 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: paulmck@kernel.org, parri.andrea@gmail.com, will@kernel.org,
  peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
  dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
  akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
  urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 0/4] tools/memory-model: Define more of LKMM in
 tools/memory-model
Message-ID: <f93f140b-13bc-4d00-adee-46cc1c016480@rowland.harvard.edu>
References: <20240604152922.495908-1-jonas.oberhauser@huaweicloud.com>
 <88c1ebc8-4805-4d1d-868a-889043899979@rowland.harvard.edu>
 <bbc3bd10-3bf5-4b1a-a275-dd328c42e307@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbc3bd10-3bf5-4b1a-a275-dd328c42e307@huaweicloud.com>

On Wed, Jun 05, 2024 at 09:58:42PM +0200, Jonas Oberhauser wrote:
> 
> 
> Am 6/4/2024 um 7:56 PM schrieb Alan Stern:
> > Just to clarify: Your first step encompasses patches 1 - 3, and the
> > second step is patch 4.  The first three patches can be applied now, but
> > the last one needs to wait until herd7 has been updated.  Is this all
> > correct?
> 
> Exactly.

With regard to patch 4, how much thought have you and Hernan given to 
backward compatibility?  Once herd7 is changed, old memory model files 
will no longer work correctly.

To avoid being so disruptive, perhaps the changes to herd7 should be 
under control of a new command-line or config-file switch.  If the 
switch is enabled, the new simplified code gets used; otherwise herd7 
would continue to use its old built-in rules for special tags.

Alan

