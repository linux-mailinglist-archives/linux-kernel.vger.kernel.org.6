Return-Path: <linux-kernel+bounces-198502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6138D795C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 02:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47041F21472
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 00:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAD9A951;
	Mon,  3 Jun 2024 00:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cxshFyB9"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583C6625
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 00:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717374804; cv=none; b=YipKvFPFLiU4102KPE0cfktLyX54oB+RSALQ2E/0ZgLTJS8ORzwR4FqEY5/75k5RHXTORpnGKI3cv9KuegVZlP74mivOMKQYS490yJCSPoQZYLl8mDZmGHOVRjlfqR0tTf9N+AIrqKEKukUCDCc8Cb+7D9rEBNRU+ZSVh0vCp10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717374804; c=relaxed/simple;
	bh=v6FQDpTvBgPP6UY0yZcioa8V0uGC7CDfX5pgDoWI7zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKPYsPmDVDbbnuEQF3l63sOp9E0DiLb8Dg9XYefwVjSv8sXi95bD9URXxIUKv1cphYmalriOMz3V+TwySEe+t/+RWUHyghzJidju+9HIVXGHZhkYtXhHTtyXbBvfSnDuh9ivmkz31RjmxdJnbkK6JW+5xuUPiJ7hQemgmSmPVDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cxshFyB9; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717374798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+9i05LKO2QA/lK7UY488kffvxZI78NDDMmynN4RHjDY=;
	b=cxshFyB9JKCAKNznr6OdQp2IxW5GvjHiPt+QwcO6E7Tff7SKkiTnAbxNBlh6rLc1BPyINF
	oAsbyEBatHM043qRZtq+a8/5fz3Bt4YMJ4266ftivXpjgOu+sVkinKDFD6wTXyCe+0IeR1
	kS1/2wqUZqwufTFCro/A+IvTJdlst2M=
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: axboe@kernel.dk
X-Envelope-To: kent.overstreet@linux.dev
X-Envelope-To: brauner@kernel.org
X-Envelope-To: viro@zeniv.linux.org.uk
X-Envelope-To: bernd.schubert@fastmail.fm
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: josef@toxicpanda.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	linux-mm@kvack.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 2/5] darray: Fix darray_for_each_reverse() when darray is empty
Date: Sun,  2 Jun 2024 20:32:59 -0400
Message-ID: <20240603003306.2030491-3-kent.overstreet@linux.dev>
In-Reply-To: <20240603003306.2030491-1-kent.overstreet@linux.dev>
References: <20240603003306.2030491-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/darray.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/darray.h b/include/linux/darray.h
index ff167eb795f2..603d6762c29a 100644
--- a/include/linux/darray.h
+++ b/include/linux/darray.h
@@ -108,7 +108,7 @@ do {									\
 	for (typeof(&(_d).data[0]) _i = (_d).data; _i < (_d).data + (_d).nr; _i++)
 
 #define darray_for_each_reverse(_d, _i)					\
-	for (typeof(&(_d).data[0]) _i = (_d).data + (_d).nr - 1; _i >= (_d).data; --_i)
+	for (typeof(&(_d).data[0]) _i = (_d).data + (_d).nr - 1; (_d).data && _i >= (_d).data; --_i)
 
 #define darray_init(_d)							\
 do {									\
-- 
2.45.1


