Return-Path: <linux-kernel+bounces-315815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0A196C74B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB09E1F256A6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362081E6DC8;
	Wed,  4 Sep 2024 19:14:35 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D192D1E633A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 19:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725477274; cv=none; b=alNc8nFT+5K90AFdDgjNs2Icrrhnh4g3eeXiwZ+JbG4hxyw88DJt/ChzNS7cddB7FAI0cYSY8QEm58xK0CoruVtjDvSPr6bRrKncLNheoPgjFKmkL07vx0LgMlQMu4943G/RESxR8G8AFvvrkpdMR0MgNJQVpNHLDcVFiYNNFQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725477274; c=relaxed/simple;
	bh=gIz4nWG8vW2Bq5DEc4OdSKXvO7Od/Jr4iRyvbvu+l6E=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=BVJjCgVOuWEV2ovoHtjsAxDH+mh/UBP5gvaBdALAKdXa1hz7AIBwLLqvjY4yODA4VDGKoCIu3x4h5KWRiIAhYx7jpgmGpfZcQifQ/T0JleaPfreDeZO1eteu2nAArEJJeVJV4w5/4knvaxMPSpp0q0vGpBEdFby9d2UQzlxQozw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7375FC4CECB;
	Wed,  4 Sep 2024 19:14:34 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1slvTb-000000059EK-3aev;
	Wed, 04 Sep 2024 15:15:35 -0400
Message-ID: <20240904191535.714583011@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 04 Sep 2024 15:15:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 "John Warthog9 Hawley (Tenstorrent)" <warthog9@eaglescrag.net>
Subject: [for-next][PATCH 2/2] ktest.pl: Avoid false positives with grub2 skip regex
References: <20240904191514.942314784@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Daniel Jordan <daniel.m.jordan@oracle.com>

Some distros have grub2 config files with the lines

    if [ x"${feature_menuentry_id}" = xy ]; then
      menuentry_id_option="--id"
    else
      menuentry_id_option=""
    fi

which match the skip regex defined for grub2 in get_grub_index():

    $skip = '^\s*menuentry';

These false positives cause the grub number to be higher than it
should be, and the wrong kernel can end up booting.

Grub documents the menuentry command with whitespace between it and the
title, so make the skip regex reflect this.

Link: https://lore.kernel.org/20240904175530.84175-1-daniel.m.jordan@oracle.com
Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Acked-by: John 'Warthog9' Hawley (Tenstorrent) <warthog9@eaglescrag.net>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index c82b8d55dddb..dacad94e2be4 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -2056,7 +2056,7 @@ sub get_grub_index {
     } elsif ($reboot_type eq "grub2") {
 	$command = "cat $grub_file";
 	$target = '^\s*menuentry.*' . $grub_menu_qt;
-	$skip = '^\s*menuentry';
+	$skip = '^\s*menuentry\s';
 	$submenu = '^\s*submenu\s';
     } elsif ($reboot_type eq "grub2bls") {
 	$command = $grub_bls_get;
-- 
2.43.0



