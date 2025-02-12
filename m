Return-Path: <linux-kernel+bounces-511090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1865A325B1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C448188BD7A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD10B20B21F;
	Wed, 12 Feb 2025 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="psyZcKpb"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271E520B80A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739362297; cv=none; b=ZYWvxgNfyUGEVAHlfqpmCxaHAKDicqnRZQjGDdkJ5sMFektBsiZf6F1dD40DnFVnQsq3b0rstiKTpwywHZhWZDvHheervEiy76jGZbZBmN9hbafRXY2V/qeXZtmDIEqWyPe7XuriE9d/OCzCTgLvCpBRwES+eeXBONWqXlG4KOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739362297; c=relaxed/simple;
	bh=nJAjT5/s+Bk+T68CHU79IOZD9HbJfSD+dB61v+xr4Gg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=c22ZgWXak6mXU2qPMCVWXMY+ybwEJlKuvk0uHHJkxSPQ3jLhCQQS+QlbisjZnYmcofinrV3Snrq5t90V4fvL+4r8TFWbZl4CswKBAUv2VY0jz4AY/8zZ7MN+4Qu7N2uv1UNApzO5vX80GpeejydlJQv5VEgAC/3w5+YuBMJo9Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=psyZcKpb; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739362283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pD1APsDwrUWqekelr1RRXUMoMxq1F8JT/FnOwqPMeBo=;
	b=psyZcKpbhx3ingRfbaLiu2ViVdK7x+sGbNgzRyVHRzlUBuc1GKZ5n0VzyRZaJajsfCeaWO
	z4LiAo+uf6ZrKu6Tus9m406QhdU/O8Sw2hP2ZtpIAs5yoRLsgrylzgV2JzpV1dXVNCy+p8
	yBUIjFSfuwYJlhZ9zknbMludF2f4j34=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] proc: Use str_yes_no() helper in proc_pid_ksm_stat()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20250212120451.GO1977892@ZenIV>
Date: Wed, 12 Feb 2025 13:11:08 +0100
Cc: Christian Brauner <brauner@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jeff Layton <jlayton@kernel.org>,
 Adrian Ratiu <adrian.ratiu@collabora.com>,
 xu xin <xu.xin16@zte.com.cn>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Felix Moessbauer <felix.moessbauer@siemens.com>,
 linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <220DFA78-0A12-4F46-B778-B331A7F2841A@linux.dev>
References: <20250212115954.111652-2-thorsten.blum@linux.dev>
 <20250212120451.GO1977892@ZenIV>
To: Al Viro <viro@zeniv.linux.org.uk>
X-Migadu-Flow: FLOW_OUT

On 12. Feb 2025, at 13:04, Al Viro wrote:
> On Wed, Feb 12, 2025 at 12:59:52PM +0100, Thorsten Blum wrote:
>> Remove hard-coded strings by using the str_yes_no() helper function.
>=20
>> seq_printf(m, "ksm_merge_any: %s\n",
>> - test_bit(MMF_VM_MERGE_ANY, &mm->flags) ? "yes" : "no");
>> + str_yes_no(test_bit(MMF_VM_MERGE_ANY, &mm->flags)));
>> ret =3D mmap_read_lock_killable(mm);
>> if (ret) {
>> mmput(mm);
>> return ret;
>> }
>> seq_printf(m, "ksm_mergeable: %s\n",
>> - ksm_process_mergeable(mm) ? "yes" : "no");
>> + str_yes_no(ksm_process_mergeable(mm)));
>=20
> Is that any more readable?  If anything, that might be better off with =
something
> like a printf modifier...

The helpers have other benefits (from include/linux/string_choices.h):

/*
 * Here provide a series of helpers in the str_$TRUE_$FALSE format (you =
can
 * also expand some helpers as needed), where $TRUE and $FALSE are their
 * corresponding literal strings. These helpers can be used in the =
printing
 * and also in other places where constant strings are required. Using =
these
 * helpers offers the following benefits:
 *  1) Reducing the hardcoding of strings, which makes the code more =
elegant
 *     through these simple literal-meaning helpers.
 *  2) Unifying the output, which prevents the same string from being =
printed
 *     in various forms, such as enable/disable, enabled/disabled, =
en/dis.
 *  3) Deduping by the linker, which results in a smaller binary file.
 */

Thanks,
Thorsten=

