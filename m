Return-Path: <linux-kernel+bounces-362808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F8399B980
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 15:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46562281ABA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 13:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1403313B592;
	Sun, 13 Oct 2024 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eYHZ0sTb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5519C231CA5
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728824825; cv=none; b=f0WBnYwt6yt1uzxiN1AuauDc/scz112kNI9HqTFwRRJ6VLVOpVLMQPcN9+Tx709SAnBOSCCuVVB/Tq7N6pItN9saLbq1LArEDZQe3k3y2Hg3sgR+RrwQm2cUGCyyh/bAElSVrgisfjjgKbqOd8WM1Ab3qrlfM186lcdmwAvsHzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728824825; c=relaxed/simple;
	bh=TYZUS5zaXucY6uOOUmU95bm2gF8iLkrmhpd8kSYjD+4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o86liqHKGVxh0qtHkozXQFHVpl/vdul0ud0U5shrlyJUFtwxu30jSj514kKTG17Ok3rodhicmQJRzVV8hTD223ZfhlSLXt0OlzWK4hKva8PM0pQtHED/fEvh/B0bYSLIyydT95cLCHzsZKKDbSVrzn/rPItD2CPTxFtxB9TdYUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eYHZ0sTb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E236C4CEC5;
	Sun, 13 Oct 2024 13:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728824824;
	bh=TYZUS5zaXucY6uOOUmU95bm2gF8iLkrmhpd8kSYjD+4=;
	h=Date:From:To:Cc:Subject:From;
	b=eYHZ0sTbzHZg6sBE25A1ruLAjwEMXKCGs4RLJ9IxTRJZVfcdvpc5c/JjsQOYzPo0p
	 s7O7GfFRwLYYih8zF07fkclsY2Ypf9SviF+vhTsJ2uXH0cW7nb/v5KdDRSIbReXkzg
	 fxmsvfwyWRPR8IqwR+gtjEGMVtsbu6w/ULYddFQ4=
Date: Sun, 13 Oct 2024 15:07:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core fix for 6.12-rc3
Message-ID: <ZwvF9HasqHKW80ni@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.12-rc3

for you to fetch changes up to bd2b7f62a0d5feda8b21c7371058e8cd2956151a:

  mailmap: update mail for Fiona Behrens (2024-10-07 07:05:12 +0200)

----------------------------------------------------------------
Driver core fix for 6.12-rc3

Here is a single driver core fix, and a .mailmap update, for 6.12-rc3.

The fix is for the rust driver core bindings, turned out that the
from_raw binding wasn't a good idea (don't want to pass a pointer to a
reference counted object without actually incrementing the pointer.)  So
this change fixes it up as the from_raw binding came in in -rc1.

The other change is a .mailmap update.

Both have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Fiona Behrens (1):
      mailmap: update mail for Fiona Behrens

Guilherme Giacomo Simoes (1):
      rust: device: change the from_raw() function

 .mailmap                |  3 +++
 rust/kernel/device.rs   | 15 +++------------
 rust/kernel/firmware.rs |  2 +-
 3 files changed, 7 insertions(+), 13 deletions(-)

