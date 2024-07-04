Return-Path: <linux-kernel+bounces-241749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABE2927F1D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 01:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40CCC284E35
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 23:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE63C1448EE;
	Thu,  4 Jul 2024 23:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VG41MZlL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FCB1448C9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 23:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720134627; cv=none; b=pY92mGzulPPst/rQY3VuC6qtN1o13amDjqKLJhXgJoTLlLuze/xaUAPkvFrTsM8wv1WwyZqPv/rFeeO1QQbvefJYlYl3glsP7YArzsN/+b2sVuywKI1zvt16/gaHiVnlYjJ/YexiQxvWv7QqpNp+KH4i0cnaQKQ1HmljwV4rtHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720134627; c=relaxed/simple;
	bh=6SgUAiQNBt9sn/RotfDW64n1VgTsFcoup0w0qdcBdGg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Lv38yOmKXTJY4IgWLgGds7XAXPDoxg+FO/Ig7To/CIDnhHv4FChhHRQhmxhEanAGT7UAZlzPeZKEq9g/RvQ9atsX4CwR8FGfQtE7eCyqOkoZVTLP9il9PnrDG2J4vPegn8KJMwwjbJEnHFoLR7FIl5SWJhjXGDifmLJDN3iLg3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VG41MZlL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC1AC3277B;
	Thu,  4 Jul 2024 23:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720134627;
	bh=6SgUAiQNBt9sn/RotfDW64n1VgTsFcoup0w0qdcBdGg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VG41MZlLgge0o3FPDlgvJMpd/z2FB/hr4VFA8sOlDXj9sC/MfadujkOMNwEKMs6cg
	 Hlt4AqC86FsMxGF3Db75hm+JfauJDk1Qv32LrwAb6SJXTPUx4DaeTSEHsIrJ8v7nc4
	 9zBgHilvXaiVwzmnpWvwcEu7WaqhqAM+NPPR8Ylg=
Date: Thu, 4 Jul 2024 16:10:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Barry Song <21cnbao@gmail.com>, chrisl@kernel.org, linux-mm@kvack.org,
 david@redhat.com, hughd@google.com, kaleshsingh@google.com,
 kasong@tencent.com, linux-kernel@vger.kernel.org, v-songbaohua@oppo.com,
 ying.huang@intel.com
Subject: Re: [PATCH v2 0/1] tools/mm: Introduce a tool to assess swap entry
 allocation for thp_swapout
Message-Id: <20240704161026.1e10805b184d7c7f07158622@linux-foundation.org>
In-Reply-To: <fba6439c-9710-4b0a-873c-334058166c03@arm.com>
References: <20240622071231.576056-1-21cnbao@gmail.com>
	<557d7f05-6ba9-482d-b3fb-29eb72cdf09c@arm.com>
	<CAGsJ_4zQ0vjX1UM62o0Wsgh9XYW0SGv2cyG5gUpbP_+Tx3WZLg@mail.gmail.com>
	<76876c5f-f769-43f1-ad53-a4af288af467@arm.com>
	<CAGsJ_4zpn5dMNNNcVcMngT-mJpWV-bzUV+RfQaLLjxMC73xfig@mail.gmail.com>
	<f9fde05b-0340-49fc-92f9-7fa091580444@arm.com>
	<CAGsJ_4xf_s57g5NmxbzFSZqyU05n4CoF5PFTZO73CE4CmB9fEw@mail.gmail.com>
	<fba6439c-9710-4b0a-873c-334058166c03@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

This all seems to have gone way off track.

acks or nacks on the patch, please?

