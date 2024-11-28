Return-Path: <linux-kernel+bounces-424241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1725E9DB1F7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 04:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1AE4281641
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 03:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4044513A868;
	Thu, 28 Nov 2024 03:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OdSpSESP"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22646136347;
	Thu, 28 Nov 2024 03:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732765080; cv=none; b=NtID+Klu9HOI+P4nr2HxGiEcSr4FEGG+IkstUCIRS3sV56B1YH2wsHGowhPDpP7RWCW/L2alvESRjzjkXeXxWn7gZB9flaDcmndcqItFFtGrrLeAdtU0xKIVDwmEIBRxloMsgvJtAkuNyvI3k27Ne83OYMaLQtGB+hZEpg1szKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732765080; c=relaxed/simple;
	bh=+tACbwppzt9NfZulu2/5Qkz0fbhJc6wEoNrVkgcTxJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KWKQ3HzJXbuRMYefU+HRBkg2GiFgxpAfwjf1p2sdEknw8GlIHnFWusDUViDI+JVGyXIIKhLkzpA39ixZ3zAwPR/L+v1ylPr7dPTFA7sxcLouEw9+GFWiwciVVPiu5a7c01mETYyHwAqNQVzGjUTUc5uPWOIh7JP+Ts+Afka1wa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OdSpSESP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=b2KUGoNLMUqCAxnefaN/mEalsv6wN282lWA1j+r7Vzk=; b=OdSpSESP0zOP6r/AV7kLCda55W
	uGWVvRtEE/Kc3RLokVAWCYtuzbdP13Cw/9tq28M4EVroulJX9XaJCWsq/aj57BUa3aYcIAjkiXHfI
	c8ODVoRn/VYC8HlSbgxm4we8jarG5Le9MEOemms05sQKnJKOFVe2lrr1jDtvZjLyz5pHLgooMVIvC
	W+yHqph5m152jlT6Uzn7pVae8+AAUmQRd0WnUmRUQU3kbhIrzJsWUyv+50sSK355YYo0FVpxicrEE
	HBaGNMkPBlgGQcIg3X4XWEq8oBZecDhpK4KFg6JIF00aI0JW9ru9B9nYckquIBIZUFO/GdkueN+FK
	lsP75LrA==;
Received: from [50.53.2.24] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGVLp-0000000EdIZ-1dvx;
	Thu, 28 Nov 2024 03:37:57 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Michal Nazarewicz <mina86@mina86.com>,
	Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Subject: [PATCH] usb: gadget: functionfs: fix spellos
Date: Wed, 27 Nov 2024 19:37:56 -0800
Message-ID: <20241128033756.373517-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in documentation as reported by codespell.

Fixes: f0175ab51993 ("usb: gadget: f_fs: OS descriptors support")
Fixes: ddf8abd25994 ("USB: f_fs: the FunctionFS driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Michal Nazarewicz <mina86@mina86.com>
Cc: Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
---
 include/uapi/linux/usb/functionfs.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-next-20241125.orig/include/uapi/linux/usb/functionfs.h
+++ linux-next-20241125/include/uapi/linux/usb/functionfs.h
@@ -206,7 +206,7 @@ struct usb_ffs_dmabuf_transfer_req {
  * +-----+-----------------+------+--------------------------+
  * | off | name            | type | description              |
  * +-----+-----------------+------+--------------------------+
- * |   0 | inteface        | U8   | related interface number |
+ * |   0 | interface       | U8   | related interface number |
  * +-----+-----------------+------+--------------------------+
  * |   1 | dwLength        | U32  | length of the descriptor |
  * +-----+-----------------+------+--------------------------+
@@ -224,7 +224,7 @@ struct usb_ffs_dmabuf_transfer_req {
  * +-----+-----------------+------+--------------------------+
  * | off | name            | type | description              |
  * +-----+-----------------+------+--------------------------+
- * |   0 | inteface        | U8   | related interface number |
+ * |   0 | interface       | U8   | related interface number |
  * +-----+-----------------+------+--------------------------+
  * |   1 | dwLength        | U32  | length of the descriptor |
  * +-----+-----------------+------+--------------------------+
@@ -237,7 +237,7 @@ struct usb_ffs_dmabuf_transfer_req {
  * |  11 | ExtProp[]       |      | list of ext. prop. d.    |
  * +-----+-----------------+------+--------------------------+
  *
- * ExtCompat[] is an array of valid Extended Compatiblity descriptors
+ * ExtCompat[] is an array of valid Extended Compatibility descriptors
  * which have the following format:
  *
  * +-----+-----------------------+------+-------------------------------------+
@@ -295,7 +295,7 @@ struct usb_functionfs_strings_head {
  * |  16 | stringtab  | StringTab[lang_count] | table of strings per lang  |
  *
  * For each language there is one stringtab entry (ie. there are lang_count
- * stringtab entires).  Each StringTab has following format:
+ * stringtab entries).  Each StringTab has following format:
  *
  * | off | name    | type              | description                        |
  * |-----+---------+-------------------+------------------------------------|

